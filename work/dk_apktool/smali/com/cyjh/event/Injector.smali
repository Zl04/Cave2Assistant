.class public final Lcom/cyjh/event/Injector;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/event/Injector$a;
    }
.end annotation


# static fields
.field private static final a:Ljava/lang/Class;

.field private static b:Landroid/app/Instrumentation; = null

.field private static c:Z = false

.field private static e:Z = false

.field private static f:Z = false

.field private static g:I = 0x0

.field private static h:Ljava/lang/String; = null

.field private static final i:I = 0x1

.field private static final j:I = 0x2

.field private static final k:Ljava/lang/String; = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.64 Safari/537.11"

.field private static final l:I = 0x5

.field private static final m:I = 0x1

.field private static final n:I = 0x2

.field private static final o:I = 0x3

.field private static p:[Lcom/cyjh/event/Injector$a;

.field private static q:[Landroid/view/MotionEvent$PointerProperties;

.field private static r:[Landroid/view/MotionEvent$PointerCoords;


# instance fields
.field private d:I


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 37
    const-class v0, Lcom/cyjh/event/Injector;

    sput-object v0, Lcom/cyjh/event/Injector;->a:Ljava/lang/Class;

    .line 39
    const/4 v0, 0x1

    sput-boolean v0, Lcom/cyjh/event/Injector;->c:Z

    .line 162
    const/4 v0, 0x0

    sput-boolean v0, Lcom/cyjh/event/Injector;->e:Z

    .line 823
    sput-object v1, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    .line 824
    sput-object v1, Lcom/cyjh/event/Injector;->q:[Landroid/view/MotionEvent$PointerProperties;

    .line 825
    sput-object v1, Lcom/cyjh/event/Injector;->r:[Landroid/view/MotionEvent$PointerCoords;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .prologue
    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 41
    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v0

    iput v0, p0, Lcom/cyjh/event/Injector;->d:I

    return-void
.end method

.method public static AddContact(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 427
    invoke-static {}, Lcom/cyjh/event/Injector;->c()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 437
    :goto_0
    return-void

    .line 430
    :cond_0
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    const/16 v1, 0x34

    .line 431
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 432
    invoke-virtual {v0, p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg2(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 433
    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg2(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 434
    invoke-virtual {v0, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg2(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 435
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    .line 436
    invoke-static {}, Lcom/cyjh/event/Injector;->b()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    goto :goto_0
.end method

.method public static ClearCaches(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 528
    invoke-static {p0}, Lcom/cyjh/mobileanjian/ipc/engine/utils/j;->a(Ljava/lang/String;)V

    .line 529
    return-void
.end method

.method public static ClearContacts()V
    .locals 2

    .prologue
    .line 453
    invoke-static {}, Lcom/cyjh/event/Injector;->b()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v0

    const/16 v1, 0x36

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/c;->a(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 454
    return-void
.end method

.method public static DeleteContact(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 441
    invoke-static {}, Lcom/cyjh/event/Injector;->c()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 449
    :goto_0
    return-void

    .line 444
    :cond_0
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    const/16 v1, 0x35

    .line 445
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 446
    invoke-virtual {v0, p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg2(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 447
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    .line 448
    invoke-static {}, Lcom/cyjh/event/Injector;->b()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    goto :goto_0
.end method

.method public static FreeupMemory()V
    .locals 2

    .prologue
    .line 533
    invoke-static {}, Lcom/cyjh/event/Injector;->c()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 536
    :goto_0
    return-void

    .line 535
    :cond_0
    invoke-static {}, Lcom/cyjh/event/Injector;->b()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v0

    const/16 v1, 0x29

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/c;->a(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    goto :goto_0
.end method

.method public static GetAndroidVersion()Ljava/lang/String;
    .locals 1

    .prologue
    .line 1050
    sget-object v0, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    return-object v0
.end method

.method public static GetDeviceID()Ljava/lang/String;
    .locals 1

    .prologue
    .line 374
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->d()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static GetDeviceName()Ljava/lang/String;
    .locals 2

    .prologue
    .line 604
    :try_start_0
    invoke-static {}, Landroid/bluetooth/BluetoothAdapter;->getDefaultAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v0

    .line 605
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 606
    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->getName()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 612
    :goto_0
    return-object v0

    .line 608
    :catch_0
    move-exception v0

    .line 610
    const-string v0, "NullPointerException"

    sget-object v1, Lcom/cyjh/event/Injector;->a:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->w(Ljava/lang/String;Ljava/lang/Class;)V

    .line 612
    :cond_0
    sget-object v0, Landroid/os/Build;->MODEL:Ljava/lang/String;

    goto :goto_0
.end method

.method public static GetDisplayDpi()I
    .locals 1

    .prologue
    .line 540
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->j()I

    move-result v0

    return v0
.end method

.method public static GetForegroundPackage()Ljava/lang/String;
    .locals 3

    .prologue
    .line 548
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x14

    if-le v0, v1, :cond_0

    .line 550
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/engine/utils/j;->a()Ljava/lang/String;

    move-result-object v0

    .line 553
    :goto_0
    return-object v0

    :cond_0
    const-string v0, "com.cyjh.mobileanjian.ipc.rpc"

    const-string v1, "AndroidHelper"

    const-string v2, "getForegroundPackage"

    invoke-static {v0, v1, v2}, Lcom/cyjh/mobileanjian/rpc/Rpc;->SimpleCallReturnString(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public static GetSdcardDir()Ljava/lang/String;
    .locals 1

    .prologue
    .line 379
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->o()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static GetUiEvent()[B
    .locals 1

    .prologue
    .line 736
    invoke-static {}, Lcom/cyjh/event/Injector;->c()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 737
    const/4 v0, 0x0

    .line 738
    :goto_0
    return-object v0

    :cond_0
    invoke-static {}, Lcom/cyjh/event/b;->a()[B

    move-result-object v0

    goto :goto_0
.end method

.method public static GetVersion()I
    .locals 1

    .prologue
    .line 1045
    const/4 v0, 0x3

    return v0
.end method

.method public static KeepScreen(Z)V
    .locals 3

    .prologue
    .line 417
    invoke-static {}, Lcom/cyjh/event/Injector;->c()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 423
    :goto_0
    return-void

    .line 420
    :cond_0
    if-eqz p0, :cond_1

    const/16 v0, 0xa

    .line 421
    :goto_1
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v1

    const/16 v2, 0x25

    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg1(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    .line 422
    invoke-static {}, Lcom/cyjh/event/Injector;->b()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    goto :goto_0

    .line 420
    :cond_1
    const/4 v0, 0x0

    goto :goto_1
.end method

.method public static KeyDown(I)V
    .locals 3

    .prologue
    .line 142
    invoke-static {}, Lcom/cyjh/event/Injector;->a()Landroid/app/Instrumentation;

    move-result-object v0

    new-instance v1, Landroid/view/KeyEvent;

    const/4 v2, 0x0

    invoke-direct {v1, v2, p0}, Landroid/view/KeyEvent;-><init>(II)V

    invoke-virtual {v0, v1}, Landroid/app/Instrumentation;->sendKeySync(Landroid/view/KeyEvent;)V

    .line 143
    return-void
.end method

.method public static KeyPress(I)V
    .locals 1

    .prologue
    .line 97
    invoke-static {}, Lcom/cyjh/event/Injector;->a()Landroid/app/Instrumentation;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/app/Instrumentation;->sendKeyDownUpSync(I)V

    .line 99
    return-void
.end method

.method public static KeyUp(I)V
    .locals 3

    .prologue
    .line 150
    invoke-static {}, Lcom/cyjh/event/Injector;->a()Landroid/app/Instrumentation;

    move-result-object v0

    new-instance v1, Landroid/view/KeyEvent;

    const/4 v2, 0x1

    invoke-direct {v1, v2, p0}, Landroid/view/KeyEvent;-><init>(II)V

    invoke-virtual {v0, v1}, Landroid/app/Instrumentation;->sendKeySync(Landroid/view/KeyEvent;)V

    .line 151
    return-void
.end method

.method public static KillApp(Ljava/lang/String;)V
    .locals 3

    .prologue
    .line 481
    invoke-static {}, Lcom/cyjh/event/Injector;->c()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 487
    :goto_0
    return-void

    .line 484
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "am force-stop "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->s()Z

    move-result v1

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Lcom/cyjh/mobileanjian/ipc/engine/utils/f;->a(Ljava/lang/String;ZI)Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;

    goto :goto_0
.end method

.method public static LockScreen()V
    .locals 4

    .prologue
    .line 571
    invoke-static {}, Lcom/cyjh/event/Injector;->c()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 582
    :cond_0
    :goto_0
    return-void

    .line 577
    :cond_1
    const-string v0, "true"

    const-string v1, "com.cyjh.mobileanjian.ipc.rpc"

    const-string v2, "AndroidHelper"

    const-string v3, "isScreenOn"

    invoke-static {v1, v2, v3}, Lcom/cyjh/mobileanjian/rpc/Rpc;->SimpleCallReturnString(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 579
    const-string v0, "press power button"

    sget-object v1, Lcom/cyjh/event/Injector;->a:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 580
    const/16 v0, 0x1a

    invoke-static {v0}, Lcom/cyjh/event/Injector;->KeyPress(I)V

    goto :goto_0
.end method

.method public static OnPause()V
    .locals 2

    .prologue
    .line 557
    const-string v0, "ROOT OnPause()..."

    sget-object v1, Lcom/cyjh/event/Injector;->a:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 558
    invoke-static {}, Lcom/cyjh/event/Injector;->b()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v0

    const/16 v1, 0x2a

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/c;->a(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 560
    return-void
.end method

.method public static OnResume()V
    .locals 2

    .prologue
    .line 563
    const-string v0, "ROOT OnResume()..."

    sget-object v1, Lcom/cyjh/event/Injector;->a:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 564
    invoke-static {}, Lcom/cyjh/event/Injector;->b()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v0

    const/16 v1, 0x2b

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/c;->a(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 565
    return-void
.end method

.method public static PlaySound(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 507
    invoke-static {}, Lcom/cyjh/event/Injector;->c()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 512
    :goto_0
    return-void

    .line 510
    :cond_0
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    const/16 v1, 0x23

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg2(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    .line 511
    invoke-static {}, Lcom/cyjh/event/Injector;->b()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    goto :goto_0
.end method

.method public static RunApp(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3

    .prologue
    .line 461
    invoke-static {}, Lcom/cyjh/event/Injector;->c()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 474
    :goto_0
    return-void

    .line 464
    :cond_0
    const-string v0, ""

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 466
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "am start -n "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->s()Z

    move-result v1

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Lcom/cyjh/mobileanjian/ipc/engine/utils/f;->a(Ljava/lang/String;ZI)Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;

    .line 473
    :goto_1
    const-string v0, "runapp--->finish"

    sget-object v1, Lcom/cyjh/event/Injector;->a:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->e(Ljava/lang/String;Ljava/lang/Class;)V

    goto :goto_0

    .line 470
    :cond_1
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    const/16 v1, 0x24

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg2(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    .line 471
    invoke-static {}, Lcom/cyjh/event/Injector;->b()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    goto :goto_1
.end method

.method public static SendSimpleEmail(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z
    .locals 7

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 698
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    invoke-static {p5}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_1

    :cond_0
    move v0, v1

    .line 722
    :goto_0
    return v0

    .line 701
    :cond_1
    new-instance v3, Lorg/apache/commons/mail/SimpleEmail;

    invoke-direct {v3}, Lorg/apache/commons/mail/SimpleEmail;-><init>()V

    .line 702
    invoke-virtual {v3, p0}, Lorg/apache/commons/mail/Email;->setHostName(Ljava/lang/String;)V

    .line 703
    const/16 v2, 0x1d1

    invoke-virtual {v3, v2}, Lorg/apache/commons/mail/Email;->setSmtpPort(I)V

    .line 704
    invoke-virtual {v3, p1, p2}, Lorg/apache/commons/mail/Email;->setAuthentication(Ljava/lang/String;Ljava/lang/String;)V

    .line 705
    invoke-virtual {v3, v0}, Lorg/apache/commons/mail/Email;->setSSLOnConnect(Z)Lorg/apache/commons/mail/Email;

    .line 708
    :try_start_0
    invoke-virtual {v3, p1}, Lorg/apache/commons/mail/Email;->setFrom(Ljava/lang/String;)Lorg/apache/commons/mail/Email;

    .line 709
    invoke-virtual {v3, p3}, Lorg/apache/commons/mail/Email;->setSubject(Ljava/lang/String;)Lorg/apache/commons/mail/Email;

    .line 710
    invoke-virtual {v3, p4}, Lorg/apache/commons/mail/Email;->setMsg(Ljava/lang/String;)Lorg/apache/commons/mail/Email;

    .line 712
    const-string v2, ";"

    invoke-virtual {p5, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v4

    .line 713
    array-length v5, v4

    move v2, v1

    :goto_1
    if-ge v2, v5, :cond_2

    aget-object v6, v4, v2

    .line 714
    invoke-virtual {v6}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3, v6}, Lorg/apache/commons/mail/Email;->addTo(Ljava/lang/String;)Lorg/apache/commons/mail/Email;

    .line 713
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 716
    :cond_2
    invoke-virtual {v3}, Lorg/apache/commons/mail/Email;->send()Ljava/lang/String;
    :try_end_0
    .catch Lorg/apache/commons/mail/EmailException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 717
    :catch_0
    move-exception v0

    .line 719
    invoke-virtual {v0}, Lorg/apache/commons/mail/EmailException;->printStackTrace()V

    move v0, v1

    .line 720
    goto :goto_0
.end method

.method public static SendUiRequest([B)[B
    .locals 1

    .prologue
    .line 728
    invoke-static {}, Lcom/cyjh/event/Injector;->c()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 729
    const/4 v0, 0x0

    .line 730
    :goto_0
    return-object v0

    :cond_0
    invoke-static {p0}, Lcom/cyjh/event/b;->a([B)[B

    move-result-object v0

    goto :goto_0
.end method

.method public static SetAutoLockTime(I)V
    .locals 2

    .prologue
    .line 593
    invoke-static {}, Lcom/cyjh/event/Injector;->c()Z

    move-result v0

    if-nez v0, :cond_0

    if-gez p0, :cond_1

    .line 598
    :cond_0
    :goto_0
    return-void

    .line 595
    :cond_1
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    const/16 v1, 0x39

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 596
    invoke-virtual {v0, p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg1(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    .line 597
    invoke-static {}, Lcom/cyjh/event/Injector;->b()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    goto :goto_0
.end method

.method public static SetBacklightLevel(I)V
    .locals 2

    .prologue
    const/16 v0, 0x64

    .line 617
    invoke-static {}, Lcom/cyjh/event/Injector;->c()Z

    move-result v1

    if-nez v1, :cond_0

    if-gez p0, :cond_1

    .line 624
    :cond_0
    :goto_0
    return-void

    .line 620
    :cond_1
    if-le p0, v0, :cond_2

    move p0, v0

    .line 621
    :cond_2
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    const/16 v1, 0x3a

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 622
    invoke-virtual {v0, p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg1(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    .line 623
    invoke-static {}, Lcom/cyjh/event/Injector;->b()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    goto :goto_0
.end method

.method public static SetControlBarPos(FI)V
    .locals 2

    .prologue
    .line 355
    invoke-static {}, Lcom/cyjh/event/Injector;->c()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 367
    :goto_0
    return-void

    .line 359
    :cond_0
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    const/16 v1, 0x28

    .line 360
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 361
    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg1(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 362
    invoke-virtual {v0, p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg3(F)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 363
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    .line 364
    invoke-static {}, Lcom/cyjh/event/Injector;->b()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    goto :goto_0
.end method

.method public static SetVolumeLevel(I)V
    .locals 2

    .prologue
    const/16 v0, 0x64

    .line 628
    invoke-static {}, Lcom/cyjh/event/Injector;->c()Z

    move-result v1

    if-nez v1, :cond_0

    if-gez p0, :cond_1

    .line 635
    :cond_0
    :goto_0
    return-void

    .line 631
    :cond_1
    if-le p0, v0, :cond_2

    move p0, v0

    .line 632
    :cond_2
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    const/16 v1, 0x3b

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 633
    invoke-virtual {v0, p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg1(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    .line 634
    invoke-static {}, Lcom/cyjh/event/Injector;->b()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    goto :goto_0
.end method

.method public static ShowInputDialog(Ljava/lang/String;II)Ljava/lang/String;
    .locals 4

    .prologue
    .line 674
    const/4 v0, 0x0

    sput-boolean v0, Lcom/cyjh/event/Injector;->f:Z

    .line 675
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    const/16 v1, 0x43

    .line 676
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 677
    invoke-virtual {v0, p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg2(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 678
    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg1(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 679
    invoke-virtual {v0, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg1(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 680
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    .line 681
    invoke-static {}, Lcom/cyjh/event/Injector;->b()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 682
    :goto_0
    sget-boolean v0, Lcom/cyjh/event/Injector;->f:Z

    if-nez v0, :cond_0

    .line 686
    :try_start_0
    sget-object v0, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v2, 0x64

    invoke-virtual {v0, v2, v3}, Ljava/util/concurrent/TimeUnit;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 687
    :catch_0
    move-exception v0

    .line 689
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto :goto_0

    .line 692
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "InputDialog typed text: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Lcom/cyjh/event/Injector;->h:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/cyjh/event/Injector;->a:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 693
    sget-object v0, Lcom/cyjh/event/Injector;->h:Ljava/lang/String;

    return-object v0
.end method

.method public static ShowMessage(Ljava/lang/String;III)V
    .locals 2

    .prologue
    .line 387
    invoke-static {}, Lcom/cyjh/event/Injector;->c()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 399
    :goto_0
    return-void

    .line 390
    :cond_0
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    const/16 v1, 0x21

    .line 391
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 392
    invoke-virtual {v0, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg1(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 393
    invoke-virtual {v0, p3}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg1(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 394
    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg1(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 395
    invoke-virtual {v0, p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg2(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 396
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    .line 397
    invoke-static {}, Lcom/cyjh/event/Injector;->b()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    goto :goto_0
.end method

.method public static ShowMsgBox(Ljava/lang/String;III)I
    .locals 4

    .prologue
    .line 650
    const/4 v0, 0x0

    sput-boolean v0, Lcom/cyjh/event/Injector;->f:Z

    .line 651
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    const/16 v1, 0x42

    .line 652
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 653
    invoke-virtual {v0, p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg2(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 654
    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg1(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 655
    invoke-virtual {v0, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg1(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 656
    invoke-virtual {v0, p3}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg1(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 657
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    .line 658
    invoke-static {}, Lcom/cyjh/event/Injector;->b()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 659
    :goto_0
    sget-boolean v0, Lcom/cyjh/event/Injector;->f:Z

    if-nez v0, :cond_0

    .line 663
    :try_start_0
    sget-object v0, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v2, 0x64

    invoke-virtual {v0, v2, v3}, Ljava/util/concurrent/TimeUnit;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 664
    :catch_0
    move-exception v0

    .line 666
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto :goto_0

    .line 669
    :cond_0
    sget v0, Lcom/cyjh/event/Injector;->g:I

    return v0
.end method

.method public static StopPlay()V
    .locals 2

    .prologue
    .line 519
    invoke-static {}, Lcom/cyjh/event/Injector;->c()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 523
    :goto_0
    return-void

    .line 521
    :cond_0
    const/16 v0, 0x33

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/c;->a(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    .line 522
    invoke-static {}, Lcom/cyjh/event/Injector;->b()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    goto :goto_0
.end method

.method public static Swipe(FFFFI)V
    .locals 10

    .prologue
    .line 106
    .line 109
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    .line 110
    const/4 v4, 0x0

    const/4 v7, 0x0

    move-wide v2, v0

    move v5, p0

    move v6, p1

    invoke-static/range {v0 .. v7}, Landroid/view/MotionEvent;->obtain(JJIFFI)Landroid/view/MotionEvent;

    move-result-object v0

    .line 111
    invoke-static {}, Lcom/cyjh/event/Injector;->a()Landroid/app/Instrumentation;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/app/Instrumentation;->sendPointerSync(Landroid/view/MotionEvent;)V

    .line 112
    div-int/lit8 v9, p4, 0xb

    .line 115
    const/4 v0, 0x1

    move v8, v0

    :goto_0
    const/16 v0, 0xb

    if-gt v8, v0, :cond_1

    .line 117
    :try_start_0
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    .line 118
    int-to-float v2, v8

    const/high16 v3, 0x41300000    # 11.0f

    div-float/2addr v2, v3

    .line 119
    const/4 v4, 0x2

    invoke-static {p0, p2, v2}, Lcom/cyjh/event/Injector;->a(FFF)F

    move-result v5

    invoke-static {p1, p3, v2}, Lcom/cyjh/event/Injector;->a(FFF)F

    move-result v6

    const/4 v7, 0x0

    move-wide v2, v0

    invoke-static/range {v0 .. v7}, Landroid/view/MotionEvent;->obtain(JJIFFI)Landroid/view/MotionEvent;

    move-result-object v0

    .line 121
    invoke-static {}, Lcom/cyjh/event/Injector;->a()Landroid/app/Instrumentation;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/app/Instrumentation;->sendPointerSync(Landroid/view/MotionEvent;)V

    .line 122
    if-eqz v9, :cond_0

    .line 124
    int-to-long v0, v9

    invoke-static {v0, v1}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    .line 115
    :cond_0
    add-int/lit8 v0, v8, 0x1

    move v8, v0

    goto :goto_0

    .line 127
    :catch_0
    move-exception v0

    .line 130
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    .line 132
    :cond_1
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    .line 133
    const/4 v4, 0x1

    const/4 v7, 0x0

    move-wide v2, v0

    move v5, p2

    move v6, p3

    invoke-static/range {v0 .. v7}, Landroid/view/MotionEvent;->obtain(JJIFFI)Landroid/view/MotionEvent;

    move-result-object v0

    .line 134
    invoke-static {}, Lcom/cyjh/event/Injector;->a()Landroid/app/Instrumentation;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/app/Instrumentation;->sendPointerSync(Landroid/view/MotionEvent;)V

    .line 135
    return-void
.end method

.method public static Tap(FFI)V
    .locals 9

    .prologue
    .line 77
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    .line 78
    invoke-static {}, Lcom/cyjh/event/Injector;->a()Landroid/app/Instrumentation;

    move-result-object v8

    const/4 v4, 0x0

    const/4 v7, 0x0

    move-wide v2, v0

    move v5, p0

    move v6, p1

    invoke-static/range {v0 .. v7}, Landroid/view/MotionEvent;->obtain(JJIFFI)Landroid/view/MotionEvent;

    move-result-object v2

    invoke-virtual {v8, v2}, Landroid/app/Instrumentation;->sendPointerSync(Landroid/view/MotionEvent;)V

    .line 79
    if-eqz p2, :cond_0

    .line 83
    int-to-long v2, p2

    :try_start_0
    invoke-static {v2, v3}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 89
    :cond_0
    :goto_0
    invoke-static {}, Lcom/cyjh/event/Injector;->a()Landroid/app/Instrumentation;

    move-result-object v8

    const/4 v4, 0x1

    const/4 v7, 0x0

    move-wide v2, v0

    move v5, p0

    move v6, p1

    invoke-static/range {v0 .. v7}, Landroid/view/MotionEvent;->obtain(JJIFFI)Landroid/view/MotionEvent;

    move-result-object v0

    invoke-virtual {v8, v0}, Landroid/app/Instrumentation;->sendPointerSync(Landroid/view/MotionEvent;)V

    .line 90
    return-void

    .line 84
    :catch_0
    move-exception v2

    goto :goto_0
.end method

.method public static TouchDown(IFF)V
    .locals 18

    .prologue
    .line 228
    invoke-static {}, Lcom/cyjh/event/Injector;->e()V

    .line 230
    invoke-static {}, Lcom/cyjh/event/Injector;->f()I

    move-result v2

    const/4 v3, 0x5

    if-lt v2, v3, :cond_0

    .line 244
    :goto_0
    return-void

    .line 235
    :cond_0
    invoke-static/range {p0 .. p2}, Lcom/cyjh/event/Injector;->a(IFF)V

    .line 237
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v2

    .line 238
    const/4 v4, 0x1

    move/from16 v0, p0

    invoke-static {v0, v4}, Lcom/cyjh/event/Injector;->a(II)I

    move-result v6

    .line 239
    invoke-static {}, Lcom/cyjh/event/Injector;->f()I

    move-result v7

    .line 240
    invoke-static {}, Lcom/cyjh/event/Injector;->g()V

    .line 241
    sget-object v8, Lcom/cyjh/event/Injector;->q:[Landroid/view/MotionEvent$PointerProperties;

    sget-object v9, Lcom/cyjh/event/Injector;->r:[Landroid/view/MotionEvent$PointerCoords;

    const/4 v10, 0x0

    const/4 v11, 0x0

    const/4 v12, 0x0

    const/4 v13, 0x0

    const/4 v14, 0x0

    const/4 v15, 0x0

    const/16 v16, 0x0

    const/16 v17, 0x0

    move-wide v4, v2

    invoke-static/range {v2 .. v17}, Landroid/view/MotionEvent;->obtain(JJII[Landroid/view/MotionEvent$PointerProperties;[Landroid/view/MotionEvent$PointerCoords;IIFFIIII)Landroid/view/MotionEvent;

    move-result-object v2

    .line 243
    invoke-static {}, Lcom/cyjh/event/Injector;->a()Landroid/app/Instrumentation;

    move-result-object v3

    invoke-virtual {v3, v2}, Landroid/app/Instrumentation;->sendPointerSync(Landroid/view/MotionEvent;)V

    goto :goto_0
.end method

.method public static TouchMove(IFFI)V
    .locals 24

    .prologue
    .line 252
    sget-object v2, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    if-nez v2, :cond_1

    .line 320
    :cond_0
    :goto_0
    return-void

    .line 257
    :cond_1
    invoke-static/range {p0 .. p0}, Lcom/cyjh/event/Injector;->b(I)Lcom/cyjh/event/Injector$a;

    move-result-object v2

    .line 258
    if-eqz v2, :cond_0

    .line 262
    iget v0, v2, Lcom/cyjh/event/Injector$a;->c:F

    move/from16 v20, v0

    .line 263
    iget v0, v2, Lcom/cyjh/event/Injector$a;->d:F

    move/from16 v21, v0

    .line 266
    const/16 v2, 0xc8

    move/from16 v0, p3

    if-le v0, v2, :cond_3

    .line 268
    const/16 v2, 0xb

    move/from16 v18, v2

    .line 285
    :goto_1
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v22

    .line 288
    const/4 v2, 0x1

    move/from16 v19, v2

    :goto_2
    move/from16 v0, v19

    move/from16 v1, v18

    if-gt v0, v1, :cond_0

    .line 290
    :try_start_0
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v2

    .line 291
    move/from16 v0, v19

    int-to-float v4, v0

    move/from16 v0, v18

    int-to-float v5, v0

    div-float/2addr v4, v5

    .line 292
    move/from16 v0, v20

    move/from16 v1, p1

    invoke-static {v0, v1, v4}, Lcom/cyjh/event/Injector;->a(FFF)F

    move-result v5

    .line 293
    move/from16 v0, v21

    move/from16 v1, p2

    invoke-static {v0, v1, v4}, Lcom/cyjh/event/Injector;->a(FFF)F

    move-result v4

    .line 295
    move/from16 v0, p0

    invoke-static {v0, v5, v4}, Lcom/cyjh/event/Injector;->a(IFF)V

    .line 296
    const/4 v4, 0x2

    move/from16 v0, p0

    invoke-static {v0, v4}, Lcom/cyjh/event/Injector;->a(II)I

    move-result v6

    .line 297
    invoke-static {}, Lcom/cyjh/event/Injector;->f()I

    move-result v7

    .line 298
    invoke-static {}, Lcom/cyjh/event/Injector;->g()V

    .line 300
    sget-object v8, Lcom/cyjh/event/Injector;->q:[Landroid/view/MotionEvent$PointerProperties;

    sget-object v9, Lcom/cyjh/event/Injector;->r:[Landroid/view/MotionEvent$PointerCoords;

    const/4 v10, 0x0

    const/4 v11, 0x0

    const/4 v12, 0x0

    const/4 v13, 0x0

    const/4 v14, 0x0

    const/4 v15, 0x0

    const/16 v16, 0x0

    const/16 v17, 0x0

    move-wide v4, v2

    invoke-static/range {v2 .. v17}, Landroid/view/MotionEvent;->obtain(JJII[Landroid/view/MotionEvent$PointerProperties;[Landroid/view/MotionEvent$PointerCoords;IIFFIIII)Landroid/view/MotionEvent;

    move-result-object v2

    .line 302
    invoke-static {}, Lcom/cyjh/event/Injector;->a()Landroid/app/Instrumentation;

    move-result-object v3

    invoke-virtual {v3, v2}, Landroid/app/Instrumentation;->sendPointerSync(Landroid/view/MotionEvent;)V

    .line 304
    if-eqz p3, :cond_2

    .line 306
    move/from16 v0, p3

    int-to-long v2, v0

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v4

    sub-long v4, v4, v22

    sub-long/2addr v2, v4

    .line 307
    add-int/lit8 v4, v18, 0x1

    sub-int v4, v4, v19

    int-to-long v4, v4

    div-long/2addr v2, v4

    .line 309
    const-wide/16 v4, 0xa

    cmp-long v4, v2, v4

    if-ltz v4, :cond_2

    .line 311
    invoke-static {v2, v3}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    .line 288
    :cond_2
    add-int/lit8 v2, v19, 0x1

    move/from16 v19, v2

    goto :goto_2

    .line 272
    :cond_3
    sub-float v2, v20, p1

    sub-float v3, v20, p1

    mul-float/2addr v2, v3

    sub-float v3, v21, p2

    sub-float v4, v21, p2

    mul-float/2addr v3, v4

    add-float/2addr v2, v3

    float-to-double v2, v2

    invoke-static {v2, v3}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v4

    .line 274
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->h()I

    move-result v2

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->i()I

    move-result v3

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v3

    .line 275
    const-wide/high16 v6, 0x4000000000000000L    # 2.0

    mul-double/2addr v6, v4

    int-to-double v8, v3

    cmpl-double v2, v6, v8

    if-lez v2, :cond_4

    const/4 v2, 0x1

    .line 277
    :goto_3
    if-eqz v2, :cond_5

    .line 278
    const/16 v2, 0xb

    move/from16 v18, v2

    goto/16 :goto_1

    .line 275
    :cond_4
    const/4 v2, 0x0

    goto :goto_3

    .line 281
    :cond_5
    const-wide/high16 v6, 0x4034000000000000L    # 20.0

    mul-double/2addr v4, v6

    int-to-double v2, v3

    div-double v2, v4, v2

    double-to-int v2, v2

    add-int/lit8 v2, v2, 0x1

    move/from16 v18, v2

    goto/16 :goto_1

    .line 315
    :catch_0
    move-exception v2

    .line 318
    invoke-virtual {v2}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto/16 :goto_0
.end method

.method public static TouchUp(I)V
    .locals 18

    .prologue
    .line 327
    sget-object v2, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    if-nez v2, :cond_1

    .line 347
    :cond_0
    :goto_0
    return-void

    .line 332
    :cond_1
    invoke-static/range {p0 .. p0}, Lcom/cyjh/event/Injector;->b(I)Lcom/cyjh/event/Injector$a;

    move-result-object v2

    .line 333
    if-eqz v2, :cond_0

    .line 337
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v2

    .line 338
    const/4 v4, 0x3

    move/from16 v0, p0

    invoke-static {v0, v4}, Lcom/cyjh/event/Injector;->a(II)I

    move-result v6

    .line 339
    invoke-static {}, Lcom/cyjh/event/Injector;->f()I

    move-result v7

    .line 340
    invoke-static {}, Lcom/cyjh/event/Injector;->g()V

    .line 342
    sget-object v8, Lcom/cyjh/event/Injector;->q:[Landroid/view/MotionEvent$PointerProperties;

    sget-object v9, Lcom/cyjh/event/Injector;->r:[Landroid/view/MotionEvent$PointerCoords;

    const/4 v10, 0x0

    const/4 v11, 0x0

    const/4 v12, 0x0

    const/4 v13, 0x0

    const/4 v14, 0x0

    const/4 v15, 0x0

    const/16 v16, 0x0

    const/16 v17, 0x0

    move-wide v4, v2

    invoke-static/range {v2 .. v17}, Landroid/view/MotionEvent;->obtain(JJII[Landroid/view/MotionEvent$PointerProperties;[Landroid/view/MotionEvent$PointerCoords;IIFFIIII)Landroid/view/MotionEvent;

    move-result-object v2

    .line 344
    invoke-static {}, Lcom/cyjh/event/Injector;->a()Landroid/app/Instrumentation;

    move-result-object v3

    invoke-virtual {v3, v2}, Landroid/app/Instrumentation;->sendPointerSync(Landroid/view/MotionEvent;)V

    .line 346
    invoke-static/range {p0 .. p0}, Lcom/cyjh/event/Injector;->a(I)V

    goto :goto_0
.end method

.method public static TracePrint(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 494
    invoke-static {}, Lcom/cyjh/event/Injector;->c()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 500
    :goto_0
    return-void

    .line 497
    :cond_0
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    const/16 v1, 0x20

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg2(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    .line 498
    invoke-static {}, Lcom/cyjh/event/Injector;->b()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    goto :goto_0
.end method

.method public static UnlockScreen()V
    .locals 2

    .prologue
    .line 586
    invoke-static {}, Lcom/cyjh/event/Injector;->c()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 589
    :goto_0
    return-void

    .line 588
    :cond_0
    invoke-static {}, Lcom/cyjh/event/Injector;->b()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v0

    const/16 v1, 0x38

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/c;->a(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    goto :goto_0
.end method

.method public static UrlRequest(ILjava/lang/String;Ljava/lang/String;I)Ljava/lang/String;
    .locals 3

    .prologue
    .line 750
    if-gtz p3, :cond_0

    const/4 p3, 0x5

    .line 751
    :cond_0
    const/4 v0, 0x1

    if-ne p0, v0, :cond_2

    .line 753
    :try_start_0
    invoke-static {p1}, Lcom/cyjh/event/Injector;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/github/kevinsawicki/http/HttpRequest;->get(Ljava/lang/CharSequence;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    mul-int/lit16 v1, p3, 0x3e8

    .line 754
    invoke-virtual {v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;->connectTimeout(I)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    mul-int/lit16 v1, p3, 0x3e8

    .line 755
    invoke-virtual {v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;->readTimeout(I)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    const/4 v1, 0x0

    .line 756
    invoke-virtual {v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;->useCaches(Z)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    .line 757
    invoke-virtual {v0}, Lcom/github/kevinsawicki/http/HttpRequest;->body()Ljava/lang/String;

    move-result-object v0

    .line 758
    if-nez v0, :cond_1

    const-string v0, ""

    .line 776
    :cond_1
    :goto_0
    return-object v0

    .line 760
    :cond_2
    const/4 v0, 0x2

    if-ne p0, v0, :cond_3

    .line 762
    new-instance v0, Lcom/github/kevinsawicki/http/HttpRequest;

    const-string v1, "POST"

    invoke-direct {v0, p1, v1}, Lcom/github/kevinsawicki/http/HttpRequest;-><init>(Ljava/lang/CharSequence;Ljava/lang/String;)V

    .line 763
    const-string v1, "User-Agent"

    const-string v2, "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.64 Safari/537.11"

    invoke-virtual {v0, v1, v2}, Lcom/github/kevinsawicki/http/HttpRequest;->header(Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    const/4 v1, 0x0

    .line 764
    invoke-virtual {v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;->followRedirects(Z)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    mul-int/lit16 v1, p3, 0x3e8

    .line 765
    invoke-virtual {v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;->connectTimeout(I)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    mul-int/lit16 v1, p3, 0x3e8

    .line 766
    invoke-virtual {v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;->readTimeout(I)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    const/4 v1, 0x0

    .line 767
    invoke-virtual {v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;->useCaches(Z)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    .line 768
    invoke-virtual {v0, p2}, Lcom/github/kevinsawicki/http/HttpRequest;->send(Ljava/lang/CharSequence;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    invoke-virtual {v0}, Lcom/github/kevinsawicki/http/HttpRequest;->body()Ljava/lang/String;

    move-result-object v0

    .line 769
    if-nez v0, :cond_1

    const-string v0, ""
    :try_end_0
    .catch Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 771
    :catch_0
    move-exception v0

    .line 776
    :cond_3
    const-string v0, ""

    goto :goto_0
.end method

.method public static Vibrate(I)V
    .locals 2

    .prologue
    .line 406
    invoke-static {}, Lcom/cyjh/event/Injector;->c()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 410
    :goto_0
    return-void

    .line 408
    :cond_0
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    const/16 v1, 0x22

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg1(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    .line 409
    invoke-static {}, Lcom/cyjh/event/Injector;->b()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    goto :goto_0
.end method

.method private static final a(FFF)F
    .locals 1

    .prologue
    .line 802
    sub-float v0, p1, p0

    mul-float/2addr v0, p2

    add-float/2addr v0, p0

    return v0
.end method

.method private static a(II)I
    .locals 6

    .prologue
    const/4 v0, 0x0

    const/4 v1, 0x1

    .line 992
    .line 994
    invoke-static {}, Lcom/cyjh/event/Injector;->f()I

    move-result v2

    .line 995
    invoke-static {p0}, Lcom/cyjh/event/Injector;->c(I)I

    move-result v3

    .line 996
    invoke-static {v3}, Lcom/cyjh/event/Injector;->d(I)I

    move-result v3

    .line 997
    packed-switch p1, :pswitch_data_0

    .line 1033
    :cond_0
    :goto_0
    const-string v1, "injector"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "injector>>>>>>touchType:"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "action:"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "---pointerNum:"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, "---pointerId:"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 1035
    return v0

    .line 1000
    :pswitch_0
    if-eq v1, v2, :cond_0

    .line 1006
    mul-int/lit16 v0, v3, 0x100

    add-int/lit8 v0, v0, 0x5

    .line 1008
    goto :goto_0

    .line 1010
    :pswitch_1
    if-ne v1, v2, :cond_1

    .line 1012
    const/4 v0, 0x2

    goto :goto_0

    .line 1016
    :cond_1
    mul-int/lit16 v0, v3, 0x100

    add-int/lit8 v0, v0, 0x2

    .line 1018
    goto :goto_0

    .line 1020
    :pswitch_2
    if-ne v1, v2, :cond_2

    move v0, v1

    .line 1022
    goto :goto_0

    .line 1026
    :cond_2
    mul-int/lit16 v0, v3, 0x100

    add-int/lit8 v0, v0, 0x6

    .line 1028
    goto :goto_0

    .line 997
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method

.method private static a()Landroid/app/Instrumentation;
    .locals 1

    .prologue
    .line 48
    sget-object v0, Lcom/cyjh/event/Injector;->b:Landroid/app/Instrumentation;

    if-nez v0, :cond_0

    .line 50
    new-instance v0, Landroid/app/Instrumentation;

    invoke-direct {v0}, Landroid/app/Instrumentation;-><init>()V

    sput-object v0, Lcom/cyjh/event/Injector;->b:Landroid/app/Instrumentation;

    .line 52
    :cond_0
    sget-object v0, Lcom/cyjh/event/Injector;->b:Landroid/app/Instrumentation;

    return-object v0
.end method

.method private static a(Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    .prologue
    .line 783
    :try_start_0
    const-string v0, "[\\u4e00-\\u9fa5]"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    move-object v0, p0

    .line 784
    :goto_0
    :try_start_1
    invoke-virtual {v1}, Ljava/util/regex/Matcher;->find()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 786
    invoke-virtual {v1}, Ljava/util/regex/Matcher;->group()Ljava/lang/String;

    move-result-object v2

    .line 787
    const-string v3, "UTF-8"

    invoke-static {v2, v3}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    :try_end_1
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_1 .. :try_end_1} :catch_1

    move-result-object v0

    goto :goto_0

    .line 789
    :catch_0
    move-exception v0

    move-object v1, v0

    move-object v0, p0

    .line 792
    :goto_1
    invoke-virtual {v1}, Ljava/io/UnsupportedEncodingException;->printStackTrace()V

    .line 795
    :cond_0
    return-object v0

    .line 789
    :catch_1
    move-exception v1

    goto :goto_1
.end method

.method private static a(I)V
    .locals 5

    .prologue
    const/4 v1, 0x0

    const/4 v4, 0x0

    .line 854
    move v0, v1

    :goto_0
    const/4 v2, 0x5

    if-ge v0, v2, :cond_1

    .line 856
    sget-object v2, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    aget-object v2, v2, v0

    iget v2, v2, Lcom/cyjh/event/Injector$a;->b:I

    if-ne p0, v2, :cond_0

    .line 858
    sget-object v2, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    aget-object v2, v2, v0

    const/4 v3, 0x1

    iput-boolean v3, v2, Lcom/cyjh/event/Injector$a;->a:Z

    .line 859
    sget-object v2, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    aget-object v2, v2, v0

    iput v1, v2, Lcom/cyjh/event/Injector$a;->b:I

    .line 860
    sget-object v2, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    aget-object v2, v2, v0

    iput v4, v2, Lcom/cyjh/event/Injector$a;->c:F

    .line 861
    sget-object v2, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    aget-object v2, v2, v0

    iput v4, v2, Lcom/cyjh/event/Injector$a;->d:F

    .line 854
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 864
    :cond_1
    return-void
.end method

.method private static a(IFF)V
    .locals 4

    .prologue
    const/4 v3, 0x5

    const/4 v1, 0x0

    .line 869
    move v0, v1

    :goto_0
    if-ge v0, v3, :cond_2

    .line 871
    sget-object v2, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    aget-object v2, v2, v0

    iget-boolean v2, v2, Lcom/cyjh/event/Injector$a;->a:Z

    if-nez v2, :cond_1

    sget-object v2, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    aget-object v2, v2, v0

    iget v2, v2, Lcom/cyjh/event/Injector$a;->b:I

    if-ne v2, p0, :cond_1

    .line 873
    sget-object v2, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    aget-object v2, v2, v0

    iput p0, v2, Lcom/cyjh/event/Injector$a;->b:I

    .line 874
    sget-object v2, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    aget-object v2, v2, v0

    iput p1, v2, Lcom/cyjh/event/Injector$a;->c:F

    .line 875
    sget-object v2, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    aget-object v2, v2, v0

    iput p2, v2, Lcom/cyjh/event/Injector$a;->d:F

    .line 876
    sget-object v2, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    aget-object v0, v2, v0

    iput-boolean v1, v0, Lcom/cyjh/event/Injector$a;->a:Z

    .line 893
    :cond_0
    :goto_1
    return-void

    .line 869
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_2
    move v0, v1

    .line 882
    :goto_2
    if-ge v0, v3, :cond_0

    .line 884
    sget-object v2, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    aget-object v2, v2, v0

    iget-boolean v2, v2, Lcom/cyjh/event/Injector$a;->a:Z

    if-eqz v2, :cond_3

    .line 886
    sget-object v2, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    aget-object v2, v2, v0

    iput p0, v2, Lcom/cyjh/event/Injector$a;->b:I

    .line 887
    sget-object v2, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    aget-object v2, v2, v0

    iput p1, v2, Lcom/cyjh/event/Injector$a;->c:F

    .line 888
    sget-object v2, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    aget-object v2, v2, v0

    iput p2, v2, Lcom/cyjh/event/Injector$a;->d:F

    .line 889
    sget-object v2, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    aget-object v0, v2, v0

    iput-boolean v1, v0, Lcom/cyjh/event/Injector$a;->a:Z

    goto :goto_1

    .line 882
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_2
.end method

.method private static b(I)Lcom/cyjh/event/Injector$a;
    .locals 3

    .prologue
    .line 897
    const/4 v0, 0x0

    .line 898
    const/4 v1, 0x0

    :goto_0
    const/4 v2, 0x5

    if-ge v1, v2, :cond_0

    .line 900
    sget-object v2, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    aget-object v2, v2, v1

    iget-boolean v2, v2, Lcom/cyjh/event/Injector$a;->a:Z

    if-nez v2, :cond_1

    sget-object v2, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    aget-object v2, v2, v1

    iget v2, v2, Lcom/cyjh/event/Injector$a;->b:I

    if-ne v2, p0, :cond_1

    .line 902
    sget-object v0, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    aget-object v0, v0, v1

    .line 907
    :cond_0
    return-object v0

    .line 898
    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0
.end method

.method private static b()Lcom/cyjh/mobileanjian/ipc/b/b;
    .locals 1

    .prologue
    .line 62
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/ClientService;->a()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v0

    return-object v0
.end method

.method private static c(I)I
    .locals 3

    .prologue
    .line 912
    const/4 v1, -0x1

    .line 913
    const/4 v0, 0x0

    :goto_0
    const/4 v2, 0x5

    if-ge v0, v2, :cond_1

    .line 915
    sget-object v2, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    aget-object v2, v2, v0

    iget-boolean v2, v2, Lcom/cyjh/event/Injector$a;->a:Z

    if-nez v2, :cond_0

    sget-object v2, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    aget-object v2, v2, v0

    iget v2, v2, Lcom/cyjh/event/Injector$a;->b:I

    if-ne v2, p0, :cond_0

    .line 922
    :goto_1
    return v0

    .line 913
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    move v0, v1

    goto :goto_1
.end method

.method private static c()Z
    .locals 2

    .prologue
    .line 69
    invoke-static {}, Landroid/os/Process;->myUid()I

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {}, Landroid/os/Process;->myUid()I

    move-result v0

    const/16 v1, 0x7d0

    if-eq v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static d(I)I
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 928
    move v1, v0

    .line 929
    :goto_0
    if-ge v1, p0, :cond_1

    .line 931
    sget-object v2, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    aget-object v2, v2, v1

    iget-boolean v2, v2, Lcom/cyjh/event/Injector$a;->a:Z

    if-nez v2, :cond_0

    .line 933
    add-int/lit8 v0, v0, 0x1

    .line 929
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 937
    :cond_1
    return v0
.end method

.method private static d()V
    .locals 1

    .prologue
    .line 171
    const/4 v0, 0x1

    sput-boolean v0, Lcom/cyjh/event/Injector;->e:Z

    .line 172
    return-void
.end method

.method private static e()V
    .locals 6

    .prologue
    const/4 v5, 0x5

    const/4 v1, 0x0

    const/4 v4, 0x0

    .line 830
    sget-object v0, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    if-nez v0, :cond_0

    .line 832
    new-array v0, v5, [Lcom/cyjh/event/Injector$a;

    sput-object v0, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    move v0, v1

    .line 833
    :goto_0
    if-ge v0, v5, :cond_0

    .line 835
    new-instance v2, Lcom/cyjh/event/Injector$a;

    const/4 v3, 0x0

    invoke-direct {v2, v3}, Lcom/cyjh/event/Injector$a;-><init>(Lcom/cyjh/event/Injector$1;)V

    .line 836
    const/4 v3, 0x1

    iput-boolean v3, v2, Lcom/cyjh/event/Injector$a;->a:Z

    .line 837
    iput v1, v2, Lcom/cyjh/event/Injector$a;->b:I

    .line 838
    iput v4, v2, Lcom/cyjh/event/Injector$a;->c:F

    .line 839
    iput v4, v2, Lcom/cyjh/event/Injector$a;->d:F

    .line 840
    sget-object v3, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    aput-object v2, v3, v0

    .line 833
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 843
    :cond_0
    return-void
.end method

.method private static f()I
    .locals 3

    .prologue
    const/4 v0, 0x0

    move v1, v0

    .line 944
    :goto_0
    const/4 v2, 0x5

    if-ge v1, v2, :cond_1

    .line 946
    sget-object v2, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    aget-object v2, v2, v1

    iget-boolean v2, v2, Lcom/cyjh/event/Injector$a;->a:Z

    if-nez v2, :cond_0

    .line 948
    add-int/lit8 v0, v0, 0x1

    .line 944
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 951
    :cond_1
    return v0
.end method

.method public static finishInput()V
    .locals 1

    .prologue
    .line 159
    const/4 v0, 0x1

    sput-boolean v0, Lcom/cyjh/event/Injector;->c:Z

    .line 160
    return-void
.end method

.method private static g()V
    .locals 6

    .prologue
    const/4 v0, 0x0

    .line 957
    invoke-static {}, Lcom/cyjh/event/Injector;->f()I

    move-result v2

    .line 958
    if-nez v2, :cond_1

    .line 986
    :cond_0
    return-void

    .line 963
    :cond_1
    new-array v1, v2, [Landroid/view/MotionEvent$PointerProperties;

    sput-object v1, Lcom/cyjh/event/Injector;->q:[Landroid/view/MotionEvent$PointerProperties;

    .line 964
    new-array v1, v2, [Landroid/view/MotionEvent$PointerCoords;

    sput-object v1, Lcom/cyjh/event/Injector;->r:[Landroid/view/MotionEvent$PointerCoords;

    move v1, v0

    .line 966
    :goto_0
    const/4 v3, 0x5

    if-ge v1, v3, :cond_0

    .line 968
    sget-object v3, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    aget-object v3, v3, v1

    iget-boolean v3, v3, Lcom/cyjh/event/Injector$a;->a:Z

    if-nez v3, :cond_3

    .line 970
    if-ge v0, v2, :cond_2

    .line 972
    new-instance v3, Landroid/view/MotionEvent$PointerProperties;

    invoke-direct {v3}, Landroid/view/MotionEvent$PointerProperties;-><init>()V

    .line 973
    new-instance v4, Landroid/view/MotionEvent$PointerCoords;

    invoke-direct {v4}, Landroid/view/MotionEvent$PointerCoords;-><init>()V

    .line 976
    iput v1, v3, Landroid/view/MotionEvent$PointerProperties;->id:I

    .line 977
    sget-object v5, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    aget-object v5, v5, v1

    iget v5, v5, Lcom/cyjh/event/Injector$a;->c:F

    iput v5, v4, Landroid/view/MotionEvent$PointerCoords;->x:F

    .line 978
    sget-object v5, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    aget-object v5, v5, v1

    iget v5, v5, Lcom/cyjh/event/Injector$a;->d:F

    iput v5, v4, Landroid/view/MotionEvent$PointerCoords;->y:F

    .line 980
    sget-object v5, Lcom/cyjh/event/Injector;->q:[Landroid/view/MotionEvent$PointerProperties;

    aput-object v3, v5, v0

    .line 981
    sget-object v3, Lcom/cyjh/event/Injector;->r:[Landroid/view/MotionEvent$PointerCoords;

    aput-object v4, v3, v0

    .line 983
    :cond_2
    add-int/lit8 v0, v0, 0x1

    .line 966
    :cond_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_0
.end method

.method public static isAnjianIm()Z
    .locals 1

    .prologue
    .line 166
    sget-boolean v0, Lcom/cyjh/event/Injector;->e:Z

    return v0
.end method

.method public static releasePointerInfoArray()V
    .locals 1

    .prologue
    .line 848
    const/4 v0, 0x0

    sput-object v0, Lcom/cyjh/event/Injector;->p:[Lcom/cyjh/event/Injector$a;

    .line 849
    return-void
.end method

.method public static resetIsAnjianIm()V
    .locals 1

    .prologue
    .line 176
    const/4 v0, 0x0

    sput-boolean v0, Lcom/cyjh/event/Injector;->e:Z

    .line 177
    invoke-static {}, Lcom/cyjh/event/Injector;->isAnjianIm()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 178
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->e()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/event/Injector;->switchToIm(Ljava/lang/String;)V

    .line 179
    :cond_0
    return-void
.end method

.method public static sendText(Ljava/lang/String;)V
    .locals 4

    .prologue
    .line 186
    invoke-static {}, Lcom/cyjh/event/Injector;->c()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 209
    :cond_0
    return-void

    .line 189
    :cond_1
    invoke-static {}, Lcom/cyjh/event/Injector;->isAnjianIm()Z

    move-result v0

    if-nez v0, :cond_2

    .line 191
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->f()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/event/Injector;->switchToIm(Ljava/lang/String;)V

    .line 192
    invoke-static {}, Lcom/cyjh/event/Injector;->d()V

    .line 194
    :cond_2
    const/16 v0, 0x190

    .line 195
    const/4 v1, 0x0

    sput-boolean v1, Lcom/cyjh/event/Injector;->c:Z

    .line 196
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v1

    const/16 v2, 0x26

    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v1

    invoke-virtual {v1, p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg2(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v1

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v1

    .line 197
    invoke-static {}, Lcom/cyjh/event/Injector;->b()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v2

    invoke-virtual {v2, v1}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 198
    :goto_0
    sget-boolean v1, Lcom/cyjh/event/Injector;->c:Z

    if-nez v1, :cond_0

    if-lez v0, :cond_0

    .line 202
    const-wide/16 v2, 0x5

    :try_start_0
    invoke-static {v2, v3}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    .line 203
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    .line 204
    :catch_0
    move-exception v1

    .line 206
    invoke-virtual {v1}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto :goto_0
.end method

.method public static setSyncReturnValue(ILjava/lang/String;)V
    .locals 1

    .prologue
    .line 643
    sput p0, Lcom/cyjh/event/Injector;->g:I

    .line 644
    sput-object p1, Lcom/cyjh/event/Injector;->h:Ljava/lang/String;

    .line 645
    const/4 v0, 0x1

    sput-boolean v0, Lcom/cyjh/event/Injector;->f:Z

    .line 646
    return-void
.end method

.method public static switchToIm(Ljava/lang/String;)V
    .locals 4

    .prologue
    .line 213
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "ime set "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " true"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->s()Z

    move-result v1

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Lcom/cyjh/mobileanjian/ipc/engine/utils/f;->a(Ljava/lang/String;ZI)Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;

    .line 216
    :try_start_0
    sget-object v0, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v2, 0xc8

    invoke-virtual {v0, v2, v3}, Ljava/util/concurrent/TimeUnit;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    .line 221
    :goto_0
    return-void

    .line 217
    :catch_0
    move-exception v0

    .line 219
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto :goto_0
.end method
