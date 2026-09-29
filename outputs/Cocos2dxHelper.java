package org.cocos2dx.lib;

import android.app.Activity;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.content.res.AssetFileDescriptor;
import android.content.res.AssetManager;
import android.media.AudioManager;
import android.net.Uri;
import android.os.Build;
import android.os.Environment;
import android.os.IBinder;
import android.os.ParcelFileDescriptor;
import android.os.Process;
import android.os.Vibrator;
import android.preference.PreferenceManager;
import android.text.TextUtils;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.Display;
import android.view.View;
import android.view.WindowInsets;
import android.view.WindowManager;
import com.android.vending.expansion.zipfile.APKExpansionSupport;
import com.android.vending.expansion.zipfile.ZipResourceFile;
import com.enhance.gameservice.IGameTuningService;
import java.io.BufferedReader;
import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.LinkedHashSet;
import java.util.Locale;
import java.util.Set;

/* JADX INFO: loaded from: classes.dex */
public class Cocos2dxHelper {
    private static final int BOOST_TIME = 7;
    private static final String KEY_VERSION_EMUI = "ro.build.version.emui";
    private static final String KEY_VERSION_MIUI = "ro.miui.ui.version.name";
    private static final String KEY_VERSION_OPPO = "ro.build.version.opporom";
    private static final String KEY_VERSION_SMARTISAN = "ro.smartisan.version";
    private static final String KEY_VERSION_VIVO = "ro.vivo.os.version";
    private static final String PREFS_NAME = "Cocos2dxPrefsFile";
    public static final String ROM_EMUI = "EMUI";
    public static final String ROM_FLYME = "FLYME";
    public static final String ROM_MIUI = "MIUI";
    public static final String ROM_OPPO = "OPPO";
    public static final String ROM_QIKU = "QIKU";
    public static final String ROM_SMARTISAN = "SMARTISAN";
    public static final String ROM_VIVO = "VIVO";
    private static final int RUNNABLES_PER_FRAME = 5;
    public static final int VIVO_FILLET = 8;
    public static final int VIVO_NOTCH = 32;
    private static boolean sAccelerometerEnabled;
    private static boolean sActivityVisible;
    private static AssetManager sAssetManager;
    private static Cocos2dxMusic sCocos2dMusic;
    private static Cocos2dxHelperListener sCocos2dxHelperListener;
    private static boolean sCompassEnabled;
    private static boolean sDeviceMotionEnabled;
    private static String sName;
    private static String sPackageName;
    private static String sVersion;
    private static final String TAG = Cocos2dxHelper.class.getSimpleName();
    private static Cocos2dxSound sCocos2dSound = null;
    private static Cocos2dxAccelerometer sCocos2dxAccelerometer = null;
    private static Activity sActivity = null;
    private static Set<PreferenceManager.OnActivityResultListener> onActivityResultListeners = new LinkedHashSet();
    private static Vibrator sVibrateService = null;
    private static IGameTuningService mGameServiceBinder = null;
    private static String sAssetsPath = "";
    private static ZipResourceFile sOBBFile = null;
    private static boolean sInited = false;
    private static ServiceConnection connection = new ServiceConnection() { // from class: org.cocos2dx.lib.Cocos2dxHelper.2
        @Override // android.content.ServiceConnection
        public void onServiceConnected(ComponentName componentName, IBinder iBinder) {
            IGameTuningService unused = Cocos2dxHelper.mGameServiceBinder = IGameTuningService.Stub.asInterface(iBinder);
            Cocos2dxHelper.fastLoading(7);
        }

        @Override // android.content.ServiceConnection
        public void onServiceDisconnected(ComponentName componentName) {
            Cocos2dxHelper.sActivity.getApplicationContext().unbindService(Cocos2dxHelper.connection);
        }
    };

    public interface Cocos2dxHelperListener {
        void runOnGLThread(Runnable runnable);

        void showDialog(String str, String str2);
    }

    private static native void nativeSetAudioDeviceInfo(boolean z, int i, int i2);

    private static native void nativeSetContext(Context context, AssetManager assetManager);

    /* JADX INFO: Access modifiers changed from: private */
    public static native void nativeSetEditTextDialogResult(byte[] bArr);

    public static void runOnGLThread(Runnable runnable) {
        ((Cocos2dxActivity) sActivity).runOnGLThread(runnable);
    }

    /* JADX WARN: Multi-variable type inference failed */
    public static void init(Activity activity) {
        sActivity = activity;
        sCocos2dxHelperListener = (Cocos2dxHelperListener) activity;
        if (sInited) {
            return;
        }
        boolean zHasSystemFeature = activity.getPackageManager().hasSystemFeature("android.hardware.audio.low_latency");
        Log.d(TAG, "isSupportLowLatency:" + zHasSystemFeature);
        int i = 44100;
        int i2 = 192;
        if (Build.VERSION.SDK_INT >= 17) {
            AudioManager audioManager = (AudioManager) activity.getSystemService("audio");
            try {
                String property = audioManager.getProperty("android.media.property.OUTPUT_SAMPLE_RATE");
                String property2 = audioManager.getProperty("android.media.property.OUTPUT_FRAMES_PER_BUFFER");
                i = Integer.parseInt(property);
                i2 = Integer.parseInt(property2);
            } catch (NumberFormatException e) {
                Log.e(TAG, "parseInt failed", e);
            }
            Log.d(TAG, "sampleRate: " + i + ", framesPerBuffer: " + i2);
        } else {
            Log.d(TAG, "android version is lower than 17");
        }
        nativeSetAudioDeviceInfo(zHasSystemFeature, i, i2);
        sPackageName = activity.getApplicationInfo().packageName;
        sCocos2dMusic = new Cocos2dxMusic(activity);
        AssetManager assets = activity.getAssets();
        sAssetManager = assets;
        nativeSetContext(activity, assets);
        Cocos2dxBitmap.setContext(activity);
        sVibrateService = (Vibrator) activity.getSystemService("vibrator");
        sInited = true;
        Intent intent = new Intent(IGameTuningService.class.getName());
        intent.setPackage("com.enhance.gameservice");
        activity.getApplicationContext().bindService(intent, connection, 1);
    }

    public static String getAssetsPath() {
        String str = "";
        if (sAssetsPath.equals("")) {
            String str2 = Environment.getExternalStorageDirectory().getAbsolutePath() + "/Android/obb/" + sPackageName;
            String[] list = new File(str2).list(new FilenameFilter() { // from class: org.cocos2dx.lib.Cocos2dxHelper.1
                @Override // java.io.FilenameFilter
                public boolean accept(File file, String str3) {
                    return str3.startsWith("main.") && str3.endsWith(".obb");
                }
            });
            if (list != null && list.length > 0) {
                str = str2 + "/" + list[0];
            }
            if (new File(str).exists()) {
                sAssetsPath = str;
            } else {
                sAssetsPath = sActivity.getApplicationInfo().sourceDir;
            }
        }
        return sAssetsPath;
    }

    public static ZipResourceFile getObbFile() {
        if (sOBBFile == null) {
            int i = 1;
            try {
                i = Cocos2dxActivity.getContext().getPackageManager().getPackageInfo(getCocos2dxPackageName(), 0).versionCode;
            } catch (PackageManager.NameNotFoundException e) {
                e.printStackTrace();
            }
            try {
                sOBBFile = APKExpansionSupport.getAPKExpansionZipFile(Cocos2dxActivity.getContext(), i, 0);
            } catch (IOException e2) {
                e2.printStackTrace();
            }
        }
        return sOBBFile;
    }

    public static Activity getActivity() {
        return sActivity;
    }

    public static void addOnActivityResultListener(PreferenceManager.OnActivityResultListener onActivityResultListener) {
        onActivityResultListeners.add(onActivityResultListener);
    }

    public static Set<PreferenceManager.OnActivityResultListener> getOnActivityResultListeners() {
        return onActivityResultListeners;
    }

    public static boolean isActivityVisible() {
        return sActivityVisible;
    }

    public static String getCocos2dxPackageName() {
        return sPackageName;
    }

    public static String getCocos2dxWritablePath() {
        return sActivity.getFilesDir().getAbsolutePath();
    }

    public static String decryptKey(String str) {
        return new StringBuffer(str).reverse().toString();
    }

    public static String getCurrentLanguage() {
        String language = Locale.getDefault().getLanguage();
        String country = Locale.getDefault().getCountry();
        if (language == "zh") {
            return (country != "CN" && (country == "TW" || country == "HK")) ? "zh-Hant" : "zh-Hans";
        }
        return language;
    }

    public static String getDeviceModel() {
        return Build.MODEL;
    }

    public static AssetManager getAssetManager() {
        return sAssetManager;
    }

    public static void enableAccelerometer() {
        sAccelerometerEnabled = true;
        getAccelerometer().enableAccel();
    }

    public static void enableCompass() {
        sCompassEnabled = true;
        getAccelerometer().enableCompass();
    }

    public static void setAccelerometerInterval(float f) {
        getAccelerometer().setInterval(f);
    }

    public static void disableAccelerometer() {
        sAccelerometerEnabled = false;
        getAccelerometer().disable();
    }

    public static void enableDeviceMotion() {
        sAccelerometerEnabled = true;
        sDeviceMotionEnabled = true;
        getAccelerometer().enableDeviceMotion();
    }

    public static void setKeepScreenOn(boolean z) {
        ((Cocos2dxActivity) sActivity).setKeepScreenOn(z);
    }

    public static void vibrate(float f) {
        sVibrateService.vibrate((long) (f * 1000.0f));
    }

    public static String getVersion() {
        try {
            return Cocos2dxActivity.getContext().getPackageManager().getPackageInfo(Cocos2dxActivity.getContext().getPackageName(), 0).versionName;
        } catch (Exception unused) {
            return "";
        }
    }

    public static boolean openURL(String str) {
        try {
            Intent intent = new Intent("android.intent.action.VIEW");
            intent.setData(Uri.parse(str));
            sActivity.startActivity(intent);
            return true;
        } catch (Exception unused) {
            return false;
        }
    }

    public static long[] getObbAssetFileDescriptor(String str) {
        AssetFileDescriptor assetFileDescriptor;
        long[] jArr = new long[3];
        if (getObbFile() != null && (assetFileDescriptor = getObbFile().getAssetFileDescriptor(str)) != null) {
            try {
                ParcelFileDescriptor parcelFileDescriptor = assetFileDescriptor.getParcelFileDescriptor();
                jArr[0] = ((Integer) parcelFileDescriptor.getClass().getMethod("getFd", new Class[0]).invoke(parcelFileDescriptor, new Object[0])).intValue();
                jArr[1] = assetFileDescriptor.getStartOffset();
                jArr[2] = assetFileDescriptor.getLength();
            } catch (IllegalAccessException e) {
                Log.e(TAG, e.toString());
            } catch (NoSuchMethodException unused) {
                Log.e(TAG, "Accessing file descriptor directly from the OBB is only supported from Android 3.1 (API level 12) and above.");
            } catch (InvocationTargetException e2) {
                Log.e(TAG, e2.toString());
            }
        }
        return jArr;
    }

    public static void preloadBackgroundMusic(String str) {
        sCocos2dMusic.preloadBackgroundMusic(str);
    }

    public static void playBackgroundMusic(String str, boolean z) {
        sCocos2dMusic.playBackgroundMusic(str, z);
    }

    public static void resumeBackgroundMusic() {
        sCocos2dMusic.resumeBackgroundMusic();
    }

    public static void pauseBackgroundMusic() {
        sCocos2dMusic.pauseBackgroundMusic();
    }

    public static void stopBackgroundMusic() {
        sCocos2dMusic.stopBackgroundMusic();
    }

    public static void rewindBackgroundMusic() {
        sCocos2dMusic.rewindBackgroundMusic();
    }

    public static boolean willPlayBackgroundMusic() {
        return sCocos2dMusic.willPlayBackgroundMusic();
    }

    public static boolean isBackgroundMusicPlaying() {
        return sCocos2dMusic.isBackgroundMusicPlaying();
    }

    public static float getBackgroundMusicVolume() {
        return sCocos2dMusic.getBackgroundVolume();
    }

    public static void setBackgroundMusicVolume(float f) {
        sCocos2dMusic.setBackgroundVolume(f);
    }

    public static void preloadEffect(String str) {
        getSound().preloadEffect(str);
    }

    public static int playEffect(String str, boolean z, float f, float f2, float f3) {
        return getSound().playEffect(str, z, f, f2, f3);
    }

    public static void resumeEffect(int i) {
        getSound().resumeEffect(i);
    }

    public static void pauseEffect(int i) {
        getSound().pauseEffect(i);
    }

    public static void stopEffect(int i) {
        getSound().stopEffect(i);
    }

    public static float getEffectsVolume() {
        return getSound().getEffectsVolume();
    }

    public static void setEffectsVolume(float f) {
        getSound().setEffectsVolume(f);
    }

    public static void unloadEffect(String str) {
        getSound().unloadEffect(str);
    }

    public static void pauseAllEffects() {
        getSound().pauseAllEffects();
    }

    public static void resumeAllEffects() {
        getSound().resumeAllEffects();
    }

    public static void stopAllEffects() {
        getSound().stopAllEffects();
    }

    static void setAudioFocus(boolean z) {
        sCocos2dMusic.setAudioFocus(z);
        getSound().setAudioFocus(z);
    }

    public static void end() {
        sCocos2dMusic.end();
        getSound().end();
    }

    public static void onResume() {
        sActivityVisible = true;
        if (sDeviceMotionEnabled) {
            getAccelerometer().enableDeviceMotion();
            return;
        }
        if (sAccelerometerEnabled) {
            getAccelerometer().enableAccel();
        }
        if (sCompassEnabled) {
            getAccelerometer().enableCompass();
        }
    }

    public static void onPause() {
        sActivityVisible = false;
        if (sAccelerometerEnabled) {
            getAccelerometer().disable();
        }
    }

    public static void onEnterBackground() {
        getSound().onEnterBackground();
        sCocos2dMusic.onEnterBackground();
    }

    public static void onEnterForeground() {
        getSound().onEnterForeground();
        sCocos2dMusic.onEnterForeground();
    }

    public static void terminateProcess() {
        Process.killProcess(Process.myPid());
    }

    private static void showDialog(String str, String str2) {
        sCocos2dxHelperListener.showDialog(str, str2);
    }

    public static void setEditTextDialogResult(String str) {
        try {
            final byte[] bytes = str.getBytes("UTF8");
            sCocos2dxHelperListener.runOnGLThread(new Runnable() { // from class: org.cocos2dx.lib.Cocos2dxHelper.3
                @Override // java.lang.Runnable
                public void run() {
                    Cocos2dxHelper.nativeSetEditTextDialogResult(bytes);
                }
            });
        } catch (UnsupportedEncodingException unused) {
        }
    }

    public static int getDPI() {
        Display defaultDisplay;
        if (sActivity == null) {
            return -1;
        }
        DisplayMetrics displayMetrics = new DisplayMetrics();
        WindowManager windowManager = sActivity.getWindowManager();
        if (windowManager == null || (defaultDisplay = windowManager.getDefaultDisplay()) == null) {
            return -1;
        }
        defaultDisplay.getMetrics(displayMetrics);
        return (int) (displayMetrics.density * 160.0f);
    }

    public static boolean getBoolForKey(String str, boolean z) {
        SharedPreferences sharedPreferences = sActivity.getSharedPreferences(PREFS_NAME, 0);
        try {
            return sharedPreferences.getBoolean(str, z);
        } catch (Exception e) {
            e.printStackTrace();
            Object obj = sharedPreferences.getAll().get(str);
            if (obj instanceof String) {
                return Boolean.parseBoolean(obj.toString());
            }
            if (obj instanceof Integer) {
                return ((Integer) obj).intValue() != 0;
            }
            if (obj instanceof Float) {
                return ((Float) obj).floatValue() != 0.0f;
            }
            return z;
        }
    }

    public static int getIntegerForKey(String str, int i) {
        SharedPreferences sharedPreferences = sActivity.getSharedPreferences(PREFS_NAME, 0);
        try {
            return sharedPreferences.getInt(str, i);
        } catch (Exception e) {
            e.printStackTrace();
            Object obj = sharedPreferences.getAll().get(str);
            if (obj instanceof String) {
                return Integer.parseInt(obj.toString());
            }
            if (obj instanceof Float) {
                return ((Float) obj).intValue();
            }
            if ((obj instanceof Boolean) && ((Boolean) obj).booleanValue()) {
                return 1;
            }
            return i;
        }
    }

    public static float getFloatForKey(String str, float f) {
        SharedPreferences sharedPreferences = sActivity.getSharedPreferences(PREFS_NAME, 0);
        try {
            return sharedPreferences.getFloat(str, f);
        } catch (Exception e) {
            e.printStackTrace();
            Object obj = sharedPreferences.getAll().get(str);
            if (obj instanceof String) {
                return Float.parseFloat(obj.toString());
            }
            if (obj instanceof Integer) {
                return ((Integer) obj).floatValue();
            }
            if ((obj instanceof Boolean) && ((Boolean) obj).booleanValue()) {
                return 1.0f;
            }
            return f;
        }
    }

    public static double getDoubleForKey(String str, double d) {
        return getFloatForKey(str, (float) d);
    }

    public static String getStringForKey(String str, String str2) {
        SharedPreferences sharedPreferences = sActivity.getSharedPreferences(PREFS_NAME, 0);
        try {
            return sharedPreferences.getString(str, str2);
        } catch (Exception e) {
            e.printStackTrace();
            return sharedPreferences.getAll().get(str).toString();
        }
    }

    public static void setBoolForKey(String str, boolean z) {
        SharedPreferences.Editor editorEdit = sActivity.getSharedPreferences(PREFS_NAME, 0).edit();
        editorEdit.putBoolean(str, z);
        editorEdit.apply();
    }

    public static void setIntegerForKey(String str, int i) {
        SharedPreferences.Editor editorEdit = sActivity.getSharedPreferences(PREFS_NAME, 0).edit();
        editorEdit.putInt(str, i);
        editorEdit.apply();
    }

    public static void setFloatForKey(String str, float f) {
        SharedPreferences.Editor editorEdit = sActivity.getSharedPreferences(PREFS_NAME, 0).edit();
        editorEdit.putFloat(str, f);
        editorEdit.apply();
    }

    public static void setDoubleForKey(String str, double d) {
        SharedPreferences.Editor editorEdit = sActivity.getSharedPreferences(PREFS_NAME, 0).edit();
        editorEdit.putFloat(str, (float) d);
        editorEdit.apply();
    }

    public static void setStringForKey(String str, String str2) {
        SharedPreferences.Editor editorEdit = sActivity.getSharedPreferences(PREFS_NAME, 0).edit();
        editorEdit.putString(str, str2);
        editorEdit.apply();
    }

    public static void deleteValueForKey(String str) {
        SharedPreferences.Editor editorEdit = sActivity.getSharedPreferences(PREFS_NAME, 0).edit();
        editorEdit.remove(str);
        editorEdit.apply();
    }

    public static byte[] conversionEncoding(byte[] bArr, String str, String str2) {
        try {
            return new String(bArr, str).getBytes(str2);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static int setResolutionPercent(int i) {
        try {
            if (mGameServiceBinder != null) {
                return mGameServiceBinder.setPreferredResolution(i);
            }
            return -1;
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }

    public static int setFPS(int i) {
        try {
            if (mGameServiceBinder != null) {
                return mGameServiceBinder.setFramePerSecond(i);
            }
            return -1;
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }

    public static int fastLoading(int i) {
        try {
            if (mGameServiceBinder != null) {
                return mGameServiceBinder.boostUp(i);
            }
            return -1;
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }

    public static int getTemperature() {
        try {
            if (mGameServiceBinder != null) {
                return mGameServiceBinder.getAbstractTemperature();
            }
            return -1;
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }

    public static int setLowPowerMode(boolean z) {
        try {
            if (mGameServiceBinder != null) {
                return mGameServiceBinder.setGamePowerSaving(z);
            }
            return -1;
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }

    public static float[] getAccelValue() {
        return getAccelerometer().accelerometerValues;
    }

    public static float[] getCompassValue() {
        return getAccelerometer().compassFieldValues;
    }

    public static int getSDKVersion() {
        return Build.VERSION.SDK_INT;
    }

    private static Cocos2dxAccelerometer getAccelerometer() {
        if (sCocos2dxAccelerometer == null) {
            sCocos2dxAccelerometer = new Cocos2dxAccelerometer(sActivity);
        }
        return sCocos2dxAccelerometer;
    }

    private static Cocos2dxSound getSound() {
        if (sCocos2dSound == null) {
            sCocos2dSound = new Cocos2dxSound(sActivity);
        }
        return sCocos2dSound;
    }

    public static float getSafeInsetLeft() {
        WindowInsets rootWindowInsets;
        try {
            View decorView = sActivity.getWindow().getDecorView();
            if (decorView == null || (rootWindowInsets = decorView.getRootWindowInsets()) == null || !isAndroidP()) {
                return 0.0f;
            }
            return rootWindowInsets.getDisplayCutout().getSafeInsetLeft();
        } catch (Exception unused) {
            return 0.0f;
        }
    }

    public static float getSafeInsetBottom() {
        WindowInsets rootWindowInsets;
        try {
            View decorView = sActivity.getWindow().getDecorView();
            if (decorView == null || (rootWindowInsets = decorView.getRootWindowInsets()) == null || !isAndroidP()) {
                return 0.0f;
            }
            return rootWindowInsets.getDisplayCutout().getSafeInsetBottom();
        } catch (Exception unused) {
            return 0.0f;
        }
    }

    public static float getSafeInsetRight() {
        WindowInsets rootWindowInsets;
        try {
            View decorView = sActivity.getWindow().getDecorView();
            if (decorView == null || (rootWindowInsets = decorView.getRootWindowInsets()) == null || !isAndroidP()) {
                return 0.0f;
            }
            return rootWindowInsets.getDisplayCutout().getSafeInsetRight();
        } catch (Exception unused) {
            return 0.0f;
        }
    }

    public static float getSafeInsetTop() {
        WindowInsets rootWindowInsets;
        try {
            View decorView = sActivity.getWindow().getDecorView();
            if (decorView == null || (rootWindowInsets = decorView.getRootWindowInsets()) == null || !isAndroidP()) {
                return 0.0f;
            }
            return rootWindowInsets.getDisplayCutout().getSafeInsetTop();
        } catch (Exception unused) {
            return 0.0f;
        }
    }

    public static boolean isAndroidP() {
        return Build.VERSION.SDK_INT >= 28;
    }

    public static boolean hasNotchAtVivo() {
        Method method;
        try {
            if (isVivo()) {
                try {
                    Class<?> clsLoadClass = sActivity.getClassLoader().loadClass("android.util.FtFeature");
                    if (clsLoadClass == null || (method = clsLoadClass.getMethod("isFeatureSupport", Integer.TYPE)) == null) {
                        return false;
                    }
                    return ((Boolean) method.invoke(clsLoadClass, 32)).booleanValue();
                } catch (ClassNotFoundException unused) {
                    Log.e("Notch", "hasNotchAtVivo ClassNotFoundException");
                } catch (NoSuchMethodException unused2) {
                    Log.e("Notch", "hasNotchAtVivo NoSuchMethodException");
                    return false;
                } catch (Exception unused3) {
                    Log.e("Notch", "hasNotchAtVivo Exception");
                    return false;
                }
            }
        } catch (Throwable unused4) {
        }
        return false;
    }

    public static boolean hasNotchAtOPPO() {
        if (isOppo()) {
            return sActivity.getPackageManager().hasSystemFeature("com.oppo.feature.screen.heteromorphism");
        }
        return false;
    }

    public static int getMIUIStatusBarHeight() {
        if (!isMiui()) {
            return 0;
        }
        Activity activity = sActivity;
        int identifier = activity.getResources().getIdentifier("notch_height", "dimen", "android");
        if (identifier <= 0) {
            return 0;
        }
        int dimensionPixelSize = activity.getResources().getDimensionPixelSize(identifier);
        Log.d("miuiLiuhai", "statusBarHeight === " + dimensionPixelSize);
        return dimensionPixelSize;
    }

    public static boolean hasNotchAtHuawei() {
        try {
            try {
                try {
                    Class<?> clsLoadClass = sActivity.getClassLoader().loadClass("com.huawei.android.util.HwNotchSizeUtil");
                    return ((Boolean) clsLoadClass.getMethod("hasNotchInScreen", new Class[0]).invoke(clsLoadClass, new Object[0])).booleanValue();
                } catch (Exception unused) {
                    Log.e("Notch", "hasNotchAtHuawei Exception");
                    return false;
                }
            } catch (ClassNotFoundException unused2) {
                Log.e("Notch", "hasNotchAtHuawei ClassNotFoundException");
                return false;
            } catch (NoSuchMethodException unused3) {
                Log.e("Notch", "hasNotchAtHuawei NoSuchMethodException");
                return false;
            }
        } catch (Throwable unused4) {
            return false;
        }
    }

    public static int getEMUIStatusBarHeight() {
        if (isEmui() && hasNotchAtHuawei()) {
            try {
                try {
                    try {
                        try {
                            Class<?> clsLoadClass = sActivity.getClassLoader().loadClass("com.huawei.android.util.HwNotchSizeUtil");
                            return ((int[]) clsLoadClass.getMethod("getNotchSize", new Class[0]).invoke(clsLoadClass, new Object[0]))[1];
                        } catch (Exception unused) {
                            Log.e("Notch", "getNotchSizeAtHuawei Exception");
                            return 0;
                        }
                    } catch (NoSuchMethodException unused2) {
                        Log.e("Notch", "getNotchSizeAtHuawei NoSuchMethodException");
                        return 0;
                    }
                } catch (ClassNotFoundException unused3) {
                    Log.e("Notch", "getNotchSizeAtHuawei ClassNotFoundException");
                }
            } catch (Throwable unused4) {
            }
        }
        return 0;
    }

    public static boolean isEmui() {
        return check(ROM_EMUI);
    }

    public static boolean isMiui() {
        return check(ROM_MIUI);
    }

    public static boolean isVivo() {
        return check(ROM_VIVO);
    }

    public static boolean isOppo() {
        return check(ROM_OPPO);
    }

    public static boolean isFlyme() {
        return check(ROM_FLYME);
    }

    public static boolean is360() {
        return check(ROM_QIKU) || check("360");
    }

    public static boolean isSmartisan() {
        return check(ROM_SMARTISAN);
    }

    public static String getName() throws Throwable {
        if (sName == null) {
            check("");
        }
        return sName;
    }

    public static boolean check(String str) throws Throwable {
        String str2 = sName;
        if (str2 != null) {
            return str2.equals(str);
        }
        String prop = getProp(KEY_VERSION_MIUI);
        sVersion = prop;
        if (!TextUtils.isEmpty(prop)) {
            sName = ROM_MIUI;
        } else {
            String prop2 = getProp(KEY_VERSION_EMUI);
            sVersion = prop2;
            if (!TextUtils.isEmpty(prop2)) {
                sName = ROM_EMUI;
            } else {
                String prop3 = getProp(KEY_VERSION_OPPO);
                sVersion = prop3;
                if (!TextUtils.isEmpty(prop3)) {
                    sName = ROM_OPPO;
                } else {
                    String prop4 = getProp(KEY_VERSION_VIVO);
                    sVersion = prop4;
                    if (!TextUtils.isEmpty(prop4)) {
                        sName = ROM_VIVO;
                    } else {
                        String prop5 = getProp(KEY_VERSION_SMARTISAN);
                        sVersion = prop5;
                        if (!TextUtils.isEmpty(prop5)) {
                            sName = ROM_SMARTISAN;
                        } else {
                            String str3 = Build.DISPLAY;
                            sVersion = str3;
                            if (str3.toUpperCase().contains(ROM_FLYME)) {
                                sName = ROM_FLYME;
                            } else {
                                sVersion = "unknown";
                                sName = Build.MANUFACTURER.toUpperCase();
                            }
                        }
                    }
                }
            }
        }
        return sName.equals(str);
    }

    /* JADX WARN: Code duplicated, block: B:31:0x0065 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Not initialized variable reg: 2, insn: 0x0062: MOVE (r0 I:??[OBJECT, ARRAY]) = (r2 I:??[OBJECT, ARRAY]), block:B:24:0x0062 */
    public static String getProp(String str) throws Throwable {
        BufferedReader bufferedReader;
        BufferedReader bufferedReader2;
        BufferedReader bufferedReader3 = null;
        try {
            try {
                bufferedReader = new BufferedReader(new InputStreamReader(Runtime.getRuntime().exec("getprop " + str).getInputStream()), 1024);
                try {
                    String line = bufferedReader.readLine();
                    bufferedReader.close();
                    try {
                        bufferedReader.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                    return line;
                } catch (IOException e2) {
                    e = e2;
                    Log.e("Rom", "Unable to read prop " + str, e);
                    if (bufferedReader != null) {
                        try {
                            bufferedReader.close();
                        } catch (IOException e3) {
                            e3.printStackTrace();
                        }
                    }
                    return null;
                }
            } catch (Throwable th) {
                th = th;
                bufferedReader3 = bufferedReader2;
                if (bufferedReader3 != null) {
                    try {
                        bufferedReader3.close();
                    } catch (IOException e4) {
                        e4.printStackTrace();
                    }
                }
                throw th;
            }
        } catch (IOException e5) {
            e = e5;
            bufferedReader = null;
        } catch (Throwable th2) {
            th = th2;
            if (bufferedReader3 != null) {
                bufferedReader3.close();
            }
            throw th;
        }
    }
}
