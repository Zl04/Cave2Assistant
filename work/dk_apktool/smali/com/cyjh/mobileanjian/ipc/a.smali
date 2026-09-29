.class public Lcom/cyjh/mobileanjian/ipc/a;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static f:Landroid/media/MediaPlayer;


# instance fields
.field private a:Landroid/content/Context;

.field private b:Landroid/os/PowerManager$WakeLock;

.field private c:Landroid/os/PowerManager$WakeLock;

.field private d:Landroid/app/KeyguardManager$KeyguardLock;

.field private e:Lcom/cyjh/mobileanjian/input/a;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 36
    new-instance v0, Landroid/media/MediaPlayer;

    invoke-direct {v0}, Landroid/media/MediaPlayer;-><init>()V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/a;->f:Landroid/media/MediaPlayer;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 3

    .prologue
    .line 39
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 31
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->a:Landroid/content/Context;

    .line 40
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/a;->a:Landroid/content/Context;

    .line 41
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/a;->k()V

    .line 42
    invoke-static {}, Lcom/cyjh/mobileanjian/input/a;->a()Lcom/cyjh/mobileanjian/input/a;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->e:Lcom/cyjh/mobileanjian/input/a;

    .line 43
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->a:Landroid/content/Context;

    const-string v1, "keyguard"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/KeyguardManager;

    .line 44
    const-string v1, "unlock"

    invoke-virtual {v0, v1}, Landroid/app/KeyguardManager;->newKeyguardLock(Ljava/lang/String;)Landroid/app/KeyguardManager$KeyguardLock;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->d:Landroid/app/KeyguardManager$KeyguardLock;

    .line 46
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->a:Landroid/content/Context;

    const-string v1, "power"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/PowerManager;

    .line 47
    const v1, 0x10000006

    const-string v2, "lock_unlock_screen"

    invoke-virtual {v0, v1, v2}, Landroid/os/PowerManager;->newWakeLock(ILjava/lang/String;)Landroid/os/PowerManager$WakeLock;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->c:Landroid/os/PowerManager$WakeLock;

    .line 48
    return-void
.end method

.method private e(Ljava/lang/String;)V
    .locals 3

    .prologue
    .line 211
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/j;->b()Lcom/cyjh/mobileanjian/ipc/j;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "ime set \""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/j;->b(Ljava/lang/String;)Z

    .line 214
    const-wide/16 v0, 0x5dc

    :try_start_0
    invoke-static {v0, v1}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    .line 219
    :goto_0
    return-void

    .line 215
    :catch_0
    move-exception v0

    .line 217
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto :goto_0
.end method

.method private k()V
    .locals 3

    .prologue
    .line 53
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->a:Landroid/content/Context;

    const-string v1, "power"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/PowerManager;

    .line 54
    const/4 v1, 0x6

    const-string v2, "fzcyjh"

    invoke-virtual {v0, v1, v2}, Landroid/os/PowerManager;->newWakeLock(ILjava/lang/String;)Landroid/os/PowerManager$WakeLock;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->b:Landroid/os/PowerManager$WakeLock;

    .line 55
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->b:Landroid/os/PowerManager$WakeLock;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/os/PowerManager$WakeLock;->setReferenceCounted(Z)V

    .line 56
    return-void
.end method

.method private l()Z
    .locals 2

    .prologue
    .line 60
    .line 61
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->a:Landroid/content/Context;

    const-string v1, "vibrator"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/Vibrator;

    .line 64
    :try_start_0
    invoke-virtual {v0}, Landroid/os/Vibrator;->hasVibrator()Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 70
    :goto_0
    return v0

    .line 66
    :catch_0
    move-exception v0

    .line 68
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private m()Ljava/util/List;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 162
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 163
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->a:Landroid/content/Context;

    const-string v2, "input_method"

    invoke-virtual {v0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/inputmethod/InputMethodManager;

    .line 164
    invoke-virtual {v0}, Landroid/view/inputmethod/InputMethodManager;->getInputMethodList()Ljava/util/List;

    move-result-object v0

    .line 165
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/inputmethod/InputMethodInfo;

    .line 167
    invoke-virtual {v0}, Landroid/view/inputmethod/InputMethodInfo;->getId()Ljava/lang/String;

    move-result-object v0

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 169
    :cond_0
    return-object v1
.end method


# virtual methods
.method public a()V
    .locals 2

    .prologue
    .line 91
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->a:Landroid/content/Context;

    const-string v1, "vibrator"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/Vibrator;

    .line 92
    invoke-virtual {v0}, Landroid/os/Vibrator;->cancel()V

    .line 93
    return-void
.end method

.method public a(I)V
    .locals 4

    .prologue
    .line 78
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/a;->l()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 80
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/a;->a()V

    .line 81
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->a:Landroid/content/Context;

    const-string v1, "vibrator"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/Vibrator;

    .line 82
    int-to-long v2, p1

    invoke-virtual {v0, v2, v3}, Landroid/os/Vibrator;->vibrate(J)V

    .line 84
    :cond_0
    return-void
.end method

.method public a(Ljava/lang/String;)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 102
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 104
    :cond_0
    const-string v1, "Error --> Empty package name"

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->e(Ljava/lang/String;)V

    .line 115
    :cond_1
    :goto_0
    return v0

    .line 107
    :cond_2
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/a;->a:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    invoke-virtual {v1, p1}, Landroid/content/pm/PackageManager;->getLaunchIntentForPackage(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v1

    .line 108
    if-eqz v1, :cond_1

    .line 112
    const/high16 v0, 0x10200000

    invoke-virtual {v1, v0}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    .line 113
    const/4 v0, 0x0

    invoke-virtual {v1, v0}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    .line 114
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->a:Landroid/content/Context;

    invoke-virtual {v0, v1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    .line 115
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public b()Ljava/lang/String;
    .locals 4

    .prologue
    .line 178
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->a:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "default_input_method"

    invoke-static {v0, v1}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 179
    const-string v0, "com.cyjh"

    invoke-virtual {v1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 181
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/a;->m()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 183
    const-string v3, "com.cyjh"

    invoke-virtual {v0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_0

    .line 190
    :goto_0
    return-object v0

    :cond_1
    move-object v0, v1

    goto :goto_0
.end method

.method public b(I)V
    .locals 3

    .prologue
    .line 124
    if-lez p1, :cond_0

    .line 126
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/j;->b()Lcom/cyjh/mobileanjian/ipc/j;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "kill "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/j;->b(Ljava/lang/String;)Z

    .line 132
    :goto_0
    return-void

    .line 130
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Illigal process id: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->e(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public b(Ljava/lang/String;)Z
    .locals 4

    .prologue
    .line 140
    const/4 v1, 0x0

    .line 141
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    const-string v2, ""

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 143
    :cond_0
    const-string v0, "Error --> Empty package name"

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->e(Ljava/lang/String;)V

    .line 157
    :cond_1
    return v1

    .line 146
    :cond_2
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->a:Landroid/content/Context;

    const-string v2, "activity"

    invoke-virtual {v0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager;

    .line 148
    invoke-virtual {v0}, Landroid/app/ActivityManager;->getRunningAppProcesses()Ljava/util/List;

    move-result-object v0

    .line 149
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager$RunningAppProcessInfo;

    .line 151
    iget-object v3, v0, Landroid/app/ActivityManager$RunningAppProcessInfo;->processName:Ljava/lang/String;

    invoke-virtual {v3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 153
    iget v0, v0, Landroid/app/ActivityManager$RunningAppProcessInfo;->pid:I

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/a;->b(I)V

    .line 154
    const/4 v0, 0x1

    :goto_1
    move v1, v0

    .line 156
    goto :goto_0

    :cond_3
    move v0, v1

    goto :goto_1
.end method

.method public c()Ljava/lang/String;
    .locals 2

    .prologue
    .line 199
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->a:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "default_input_method"

    invoke-static {v0, v1}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public c(I)V
    .locals 1

    .prologue
    .line 258
    if-lez p1, :cond_1

    .line 260
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->b:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v0}, Landroid/os/PowerManager$WakeLock;->acquire()V

    .line 269
    :cond_0
    :goto_0
    return-void

    .line 264
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->b:Landroid/os/PowerManager$WakeLock;

    if-eqz v0, :cond_0

    .line 266
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->b:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v0}, Landroid/os/PowerManager$WakeLock;->release()V

    goto :goto_0
.end method

.method public c(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 226
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/a;->c()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/stuff/b;->f()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 229
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/stuff/b;->f()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/cyjh/mobileanjian/ipc/a;->e(Ljava/lang/String;)V

    .line 231
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->e:Lcom/cyjh/mobileanjian/input/a;

    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/input/a;->a(Ljava/lang/String;)V

    .line 232
    return-void
.end method

.method public d()V
    .locals 2

    .prologue
    .line 204
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/stuff/b;->e()Ljava/lang/String;

    move-result-object v0

    const-string v1, "com.cyjh"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 205
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/a;->b()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/stuff/b;->c(Ljava/lang/String;)V

    .line 206
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->e:Lcom/cyjh/mobileanjian/input/a;

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/stuff/b;->e()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/input/a;->b(Ljava/lang/String;)V

    .line 207
    return-void
.end method

.method public d(I)V
    .locals 3

    .prologue
    .line 364
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->a:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "screen_off_timeout"

    mul-int/lit16 v2, p1, 0x3e8

    invoke-static {v0, v1, v2}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .line 365
    return-void
.end method

.method public d(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 313
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/a;->f:Landroid/media/MediaPlayer;

    if-nez v0, :cond_0

    .line 314
    new-instance v0, Landroid/media/MediaPlayer;

    invoke-direct {v0}, Landroid/media/MediaPlayer;-><init>()V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/a;->f:Landroid/media/MediaPlayer;

    .line 315
    :cond_0
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/a;->h()V

    .line 318
    :try_start_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/a;->f:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->reset()V

    .line 319
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/a;->f:Landroid/media/MediaPlayer;

    invoke-virtual {v0, p1}, Landroid/media/MediaPlayer;->setDataSource(Ljava/lang/String;)V

    .line 320
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/a;->f:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->prepare()V

    .line 321
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/a;->f:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->start()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 328
    :goto_0
    return-void

    .line 322
    :catch_0
    move-exception v0

    .line 324
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    .line 325
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/a;->f:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->release()V

    .line 326
    const/4 v0, 0x0

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/a;->f:Landroid/media/MediaPlayer;

    goto :goto_0
.end method

.method public e()Ljava/lang/String;
    .locals 2

    .prologue
    .line 240
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->a:Landroid/content/Context;

    const-string v1, "wifi"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/wifi/WifiManager;

    .line 241
    invoke-virtual {v0}, Landroid/net/wifi/WifiManager;->getConnectionInfo()Landroid/net/wifi/WifiInfo;

    move-result-object v0

    .line 242
    invoke-virtual {v0}, Landroid/net/wifi/WifiInfo;->getMacAddress()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public e(I)V
    .locals 6

    .prologue
    .line 373
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->a:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "screen_brightness"

    mul-int/lit16 v2, p1, 0xff

    int-to-double v2, v2

    const-wide/high16 v4, 0x4059000000000000L    # 100.0

    div-double/2addr v2, v4

    double-to-int v2, v2

    invoke-static {v0, v1, v2}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .line 374
    return-void
.end method

.method public f()Ljava/lang/String;
    .locals 2

    .prologue
    .line 251
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->a:Landroid/content/Context;

    const-string v1, "phone"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/TelephonyManager;

    .line 252
    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getDeviceId()Ljava/lang/String;

    move-result-object v0

    .line 253
    if-eqz v0, :cond_0

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    :cond_0
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/a;->e()Ljava/lang/String;

    move-result-object v0

    :cond_1
    return-object v0
.end method

.method public f(I)V
    .locals 10

    .prologue
    const/4 v9, 0x2

    const/4 v8, 0x1

    const/4 v5, 0x0

    const-wide/high16 v6, 0x4059000000000000L    # 100.0

    const/16 v4, 0x8

    .line 378
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->a:Landroid/content/Context;

    const-string v1, "audio"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/media/AudioManager;

    .line 379
    const/4 v1, 0x4

    const/4 v2, 0x4

    invoke-virtual {v0, v2}, Landroid/media/AudioManager;->getStreamMaxVolume(I)I

    move-result v2

    mul-int/2addr v2, p1

    int-to-double v2, v2

    div-double/2addr v2, v6

    double-to-int v2, v2

    invoke-virtual {v0, v1, v2, v4}, Landroid/media/AudioManager;->setStreamVolume(III)V

    .line 380
    const/4 v1, 0x3

    const/4 v2, 0x3

    invoke-virtual {v0, v2}, Landroid/media/AudioManager;->getStreamMaxVolume(I)I

    move-result v2

    mul-int/2addr v2, p1

    int-to-double v2, v2

    div-double/2addr v2, v6

    double-to-int v2, v2

    invoke-virtual {v0, v1, v2, v4}, Landroid/media/AudioManager;->setStreamVolume(III)V

    .line 381
    const/4 v1, 0x5

    const/4 v2, 0x5

    invoke-virtual {v0, v2}, Landroid/media/AudioManager;->getStreamMaxVolume(I)I

    move-result v2

    mul-int/2addr v2, p1

    int-to-double v2, v2

    div-double/2addr v2, v6

    double-to-int v2, v2

    invoke-virtual {v0, v1, v2, v4}, Landroid/media/AudioManager;->setStreamVolume(III)V

    .line 382
    invoke-virtual {v0, v9}, Landroid/media/AudioManager;->getStreamMaxVolume(I)I

    move-result v1

    mul-int/2addr v1, p1

    int-to-double v2, v1

    div-double/2addr v2, v6

    double-to-int v1, v2

    invoke-virtual {v0, v9, v1, v4}, Landroid/media/AudioManager;->setStreamVolume(III)V

    .line 383
    invoke-virtual {v0, v8}, Landroid/media/AudioManager;->getStreamMaxVolume(I)I

    move-result v1

    mul-int/2addr v1, p1

    int-to-double v2, v1

    div-double/2addr v2, v6

    double-to-int v1, v2

    invoke-virtual {v0, v8, v1, v4}, Landroid/media/AudioManager;->setStreamVolume(III)V

    .line 384
    invoke-virtual {v0, v5}, Landroid/media/AudioManager;->getStreamMaxVolume(I)I

    move-result v1

    mul-int/2addr v1, p1

    int-to-double v2, v1

    div-double/2addr v2, v6

    double-to-int v1, v2

    invoke-virtual {v0, v5, v1, v4}, Landroid/media/AudioManager;->setStreamVolume(III)V

    .line 385
    invoke-virtual {v0, v4}, Landroid/media/AudioManager;->getStreamMaxVolume(I)I

    move-result v1

    mul-int/2addr v1, p1

    int-to-double v2, v1

    div-double/2addr v2, v6

    double-to-int v1, v2

    invoke-virtual {v0, v4, v1, v4}, Landroid/media/AudioManager;->setStreamVolume(III)V

    .line 386
    return-void
.end method

.method public g()V
    .locals 8

    .prologue
    const/4 v3, 0x0

    .line 273
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/log/b;->a()Lcom/cyjh/mobileanjian/ipc/log/b;

    move-result-object v0

    iget-object v4, v0, Lcom/cyjh/mobileanjian/ipc/log/b;->g:Ljava/lang/String;

    .line 274
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->a:Landroid/content/Context;

    const-string v1, "activity"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager;

    .line 275
    invoke-virtual {v0}, Landroid/app/ActivityManager;->getRunningAppProcesses()Ljava/util/List;

    move-result-object v5

    .line 276
    const/16 v1, 0x64

    invoke-virtual {v0, v1}, Landroid/app/ActivityManager;->getRunningServices(I)Ljava/util/List;

    .line 278
    if-eqz v5, :cond_2

    move v2, v3

    .line 280
    :goto_0
    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v1

    if-ge v2, v1, :cond_2

    .line 282
    invoke-interface {v5, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/ActivityManager$RunningAppProcessInfo;

    .line 283
    iget-object v6, v1, Landroid/app/ActivityManager$RunningAppProcessInfo;->processName:Ljava/lang/String;

    invoke-virtual {v6, v4}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v6

    if-eqz v6, :cond_1

    .line 280
    :cond_0
    add-int/lit8 v1, v2, 0x1

    move v2, v1

    goto :goto_0

    .line 289
    :cond_1
    iget v6, v1, Landroid/app/ActivityManager$RunningAppProcessInfo;->importance:I

    const/16 v7, 0xc8

    if-le v6, v7, :cond_0

    .line 291
    iget-object v6, v1, Landroid/app/ActivityManager$RunningAppProcessInfo;->pkgList:[Ljava/lang/String;

    move v1, v3

    .line 292
    :goto_1
    array-length v7, v6

    if-ge v1, v7, :cond_0

    .line 294
    aget-object v7, v6, v1

    invoke-virtual {v0, v7}, Landroid/app/ActivityManager;->killBackgroundProcesses(Ljava/lang/String;)V

    .line 292
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 300
    :cond_2
    return-void
.end method

.method public h()V
    .locals 1

    .prologue
    .line 332
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/a;->f:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/cyjh/mobileanjian/ipc/a;->f:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->isPlaying()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 333
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/a;->f:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->stop()V

    .line 334
    :cond_0
    return-void
.end method

.method public i()V
    .locals 2

    .prologue
    .line 343
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->a:Landroid/content/Context;

    const-string v1, "device_policy"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/admin/DevicePolicyManager;

    .line 344
    invoke-virtual {v0}, Landroid/app/admin/DevicePolicyManager;->lockNow()V

    .line 345
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->d:Landroid/app/KeyguardManager$KeyguardLock;

    invoke-virtual {v0}, Landroid/app/KeyguardManager$KeyguardLock;->reenableKeyguard()V

    .line 346
    return-void
.end method

.method public j()V
    .locals 1

    .prologue
    .line 353
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->d:Landroid/app/KeyguardManager$KeyguardLock;

    invoke-virtual {v0}, Landroid/app/KeyguardManager$KeyguardLock;->disableKeyguard()V

    .line 354
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->c:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v0}, Landroid/os/PowerManager$WakeLock;->acquire()V

    .line 355
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a;->c:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v0}, Landroid/os/PowerManager$WakeLock;->release()V

    .line 356
    return-void
.end method
