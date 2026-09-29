.class public Lcom/cyjh/mobileanjian/ipc/g;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static final a:Ljava/lang/String; = "/.input.inputkb"

.field private static final f:I = 0x1

.field private static final g:I = 0x2

.field private static final h:I = 0x3

.field private static final i:I = 0x4

.field private static final j:I = 0x5

.field private static final k:I = 0x6

.field private static final l:I = 0x7

.field private static final m:I = 0x8

.field private static final n:I = 0x9

.field private static final o:I = 0x10

.field private static final p:I = 0x11

.field private static final q:I = 0x12


# instance fields
.field private b:Landroid/content/Context;

.field private c:Lcom/cyjh/mobileanjian/ipc/a;

.field private d:Lcom/cyjh/mobileanjian/ipc/d;

.field private e:Lcom/cyjh/mobileanjian/ipc/ui/h;

.field private r:Landroid/os/Handler;


# direct methods
.method public constructor <init>(Landroid/content/Context;Lcom/cyjh/mobileanjian/ipc/d;)V
    .locals 2

    .prologue
    const/4 v0, 0x0

    .line 190
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 42
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->b:Landroid/content/Context;

    .line 43
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->c:Lcom/cyjh/mobileanjian/ipc/a;

    .line 44
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->d:Lcom/cyjh/mobileanjian/ipc/d;

    .line 62
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/g$1;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, p0, v1}, Lcom/cyjh/mobileanjian/ipc/g$1;-><init>(Lcom/cyjh/mobileanjian/ipc/g;Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->r:Landroid/os/Handler;

    .line 191
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/g;->b:Landroid/content/Context;

    .line 192
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/ui/h;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/g;->b:Landroid/content/Context;

    invoke-direct {v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/h;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->e:Lcom/cyjh/mobileanjian/ipc/ui/h;

    .line 193
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/a;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/g;->b:Landroid/content/Context;

    invoke-direct {v0, v1}, Lcom/cyjh/mobileanjian/ipc/a;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->c:Lcom/cyjh/mobileanjian/ipc/a;

    .line 194
    iput-object p2, p0, Lcom/cyjh/mobileanjian/ipc/g;->d:Lcom/cyjh/mobileanjian/ipc/d;

    .line 195
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/g;->d()V

    .line 196
    return-void
.end method

.method static synthetic a(Lcom/cyjh/mobileanjian/ipc/g;)Landroid/content/Context;
    .locals 1

    .prologue
    .line 39
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->b:Landroid/content/Context;

    return-object v0
.end method

.method private a()V
    .locals 2

    .prologue
    .line 417
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->d:Lcom/cyjh/mobileanjian/ipc/d;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/d;->a(Z)V

    .line 418
    sget v0, Lcom/cyjh/rootipc/R$string;->toast_on_start_script:I

    invoke-direct {p0, v0}, Lcom/cyjh/mobileanjian/ipc/g;->a(I)V

    .line 419
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->r:Landroid/os/Handler;

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    .line 420
    return-void
.end method

.method private a(I)V
    .locals 2

    .prologue
    .line 551
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->r:Landroid/os/Handler;

    const/4 v1, 0x5

    invoke-virtual {v0, v1}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    .line 552
    iput p1, v0, Landroid/os/Message;->arg1:I

    .line 553
    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    .line 554
    return-void
.end method

.method private a(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 558
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->r:Landroid/os/Handler;

    const/4 v1, 0x5

    invoke-virtual {v0, v1, p1}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    .line 559
    return-void
.end method

.method static synthetic b(Lcom/cyjh/mobileanjian/ipc/g;)Lcom/cyjh/mobileanjian/ipc/d;
    .locals 1

    .prologue
    .line 39
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->d:Lcom/cyjh/mobileanjian/ipc/d;

    return-object v0
.end method

.method private b()V
    .locals 2

    .prologue
    .line 423
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->r:Landroid/os/Handler;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    .line 424
    return-void
.end method

.method private b(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V
    .locals 5

    .prologue
    const/4 v1, 0x0

    .line 386
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1Count()I

    move-result v3

    .line 387
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[APP SERVER] size of Arg1 is "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->d(Ljava/lang/String;)V

    move v2, v1

    .line 388
    :goto_0
    if-ge v2, v3, :cond_1

    .line 390
    packed-switch v2, :pswitch_data_0

    .line 388
    :goto_1
    :pswitch_0
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_0

    .line 393
    :pswitch_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "root pid is "

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v4

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    goto :goto_1

    .line 396
    :pswitch_2
    invoke-virtual {p1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/stuff/b;->d(I)V

    goto :goto_1

    .line 399
    :pswitch_3
    invoke-virtual {p1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_2
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/stuff/b;->a(Z)V

    goto :goto_1

    :cond_0
    move v0, v1

    goto :goto_2

    .line 409
    :cond_1
    return-void

    .line 390
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_0
    .end packed-switch
.end method

.method static synthetic c(Lcom/cyjh/mobileanjian/ipc/g;)Lcom/cyjh/mobileanjian/ipc/ui/h;
    .locals 1

    .prologue
    .line 39
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->e:Lcom/cyjh/mobileanjian/ipc/ui/h;

    return-object v0
.end method

.method private c()V
    .locals 2

    .prologue
    .line 427
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->r:Landroid/os/Handler;

    const/16 v1, 0x9

    invoke-virtual {v0, v1}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    .line 428
    return-void
.end method

.method private c(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 435
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->c:Lcom/cyjh/mobileanjian/ipc/a;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/a;->d()V

    .line 436
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->c:Lcom/cyjh/mobileanjian/ipc/a;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/a;->a()V

    .line 437
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->c:Lcom/cyjh/mobileanjian/ipc/a;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/a;->h()V

    .line 439
    invoke-virtual {p1, v4}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v0

    .line 440
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/g;->d:Lcom/cyjh/mobileanjian/ipc/d;

    invoke-virtual {v1, v4}, Lcom/cyjh/mobileanjian/ipc/d;->a(Z)V

    .line 441
    const/16 v1, 0x69

    if-eq v0, v1, :cond_0

    if-nez v0, :cond_2

    .line 443
    :cond_0
    sget v1, Lcom/cyjh/rootipc/R$string;->toast_on_stop_script:I

    invoke-direct {p0, v1}, Lcom/cyjh/mobileanjian/ipc/g;->a(I)V

    .line 453
    :cond_1
    :goto_0
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/g;->r:Landroid/os/Handler;

    const/4 v2, 0x3

    invoke-virtual {p1, v4}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg2(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v0, v4, v3}, Landroid/os/Handler;->obtainMessage(IIILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    .line 454
    return-void

    .line 445
    :cond_2
    const/16 v1, 0x66

    if-ne v0, v1, :cond_3

    .line 447
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/g;->b:Landroid/content/Context;

    sget v2, Lcom/cyjh/rootipc/R$string;->toast_run_failed:I

    invoke-virtual {v1, v2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v2, v4

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/cyjh/mobileanjian/ipc/g;->a(Ljava/lang/String;)V

    goto :goto_0

    .line 449
    :cond_3
    const/16 v1, 0x3ea

    if-ne v0, v1, :cond_1

    goto :goto_0
.end method

.method private d()V
    .locals 9

    .prologue
    .line 497
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->c:Lcom/cyjh/mobileanjian/ipc/a;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/a;->f()Ljava/lang/String;

    move-result-object v1

    .line 498
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->c:Lcom/cyjh/mobileanjian/ipc/a;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/a;->e()Ljava/lang/String;

    move-result-object v0

    .line 499
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/g;->c:Lcom/cyjh/mobileanjian/ipc/a;

    invoke-virtual {v2}, Lcom/cyjh/mobileanjian/ipc/a;->b()Ljava/lang/String;

    move-result-object v4

    .line 500
    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v2

    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v5

    .line 503
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/log/b;->a()Lcom/cyjh/mobileanjian/ipc/log/b;

    move-result-object v2

    iget-boolean v2, v2, Lcom/cyjh/mobileanjian/ipc/log/b;->n:Z

    if-eqz v2, :cond_0

    .line 504
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/log/b;->a()Lcom/cyjh/mobileanjian/ipc/log/b;

    move-result-object v3

    iget-object v3, v3, Lcom/cyjh/mobileanjian/ipc/log/b;->g:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "/.input.inputkb"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    move-object v3, v2

    .line 508
    :goto_0
    if-nez v1, :cond_1

    const-string v1, "UNKNOW"

    move-object v2, v1

    .line 509
    :goto_1
    if-nez v0, :cond_2

    const-string v0, "UNKNOW"

    move-object v1, v0

    .line 511
    :goto_2
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->b:Landroid/content/Context;

    const-string v6, "window"

    invoke-virtual {v0, v6}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    .line 512
    new-instance v6, Landroid/util/DisplayMetrics;

    invoke-direct {v6}, Landroid/util/DisplayMetrics;-><init>()V

    .line 513
    invoke-interface {v0}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v0

    invoke-virtual {v0, v6}, Landroid/view/Display;->getMetrics(Landroid/util/DisplayMetrics;)V

    .line 514
    iget v6, v6, Landroid/util/DisplayMetrics;->densityDpi:I

    .line 515
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "device dpi is: "

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 517
    invoke-static {v2}, Lcom/cyjh/mobileanjian/ipc/stuff/b;->b(Ljava/lang/String;)V

    .line 518
    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/stuff/b;->a(Ljava/lang/String;)V

    .line 519
    invoke-static {v4}, Lcom/cyjh/mobileanjian/ipc/stuff/b;->c(Ljava/lang/String;)V

    .line 520
    invoke-static {v3}, Lcom/cyjh/mobileanjian/ipc/stuff/b;->d(Ljava/lang/String;)V

    .line 521
    invoke-static {v5}, Lcom/cyjh/mobileanjian/ipc/stuff/b;->e(Ljava/lang/String;)V

    .line 523
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    const/16 v7, 0xe

    invoke-virtual {v0, v7}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v7

    .line 524
    const/4 v0, 0x0

    :goto_3
    const/4 v8, 0x5

    if-ge v0, v8, :cond_3

    .line 526
    packed-switch v0, :pswitch_data_0

    .line 524
    :goto_4
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 506
    :cond_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/log/b;->a()Lcom/cyjh/mobileanjian/ipc/log/b;

    move-result-object v3

    iget-object v3, v3, Lcom/cyjh/mobileanjian/ipc/log/b;->g:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "/com.cyjh.mobileanjian.input.inputkb"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    move-object v3, v2

    goto :goto_0

    :cond_1
    move-object v2, v1

    .line 508
    goto :goto_1

    :cond_2
    move-object v1, v0

    .line 509
    goto :goto_2

    .line 529
    :pswitch_0
    invoke-virtual {v7, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg2(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    .line 530
    invoke-virtual {v7, v6}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg1(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    goto :goto_4

    .line 533
    :pswitch_1
    invoke-virtual {v7, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg2(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    goto :goto_4

    .line 536
    :pswitch_2
    invoke-virtual {v7, v4}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg2(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    goto :goto_4

    .line 539
    :pswitch_3
    invoke-virtual {v7, v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg2(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    goto :goto_4

    .line 542
    :pswitch_4
    invoke-virtual {v7, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg2(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    goto :goto_4

    .line 546
    :cond_3
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->d:Lcom/cyjh/mobileanjian/ipc/d;

    invoke-virtual {v7}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/d;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 547
    return-void

    .line 526
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
    .end packed-switch
.end method

.method private d(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V
    .locals 2

    .prologue
    .line 458
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->d:Lcom/cyjh/mobileanjian/ipc/d;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/d;->m()Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptMessageCallback;

    move-result-object v0

    .line 459
    if-eqz v0, :cond_0

    .line 460
    const/4 v1, 0x0

    invoke-virtual {p1, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg2(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptMessageCallback;->onTracePrint(Ljava/lang/String;)V

    .line 461
    :cond_0
    return-void
.end method

.method private e(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V
    .locals 2

    .prologue
    .line 465
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->d:Lcom/cyjh/mobileanjian/ipc/d;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/d;->m()Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptMessageCallback;

    move-result-object v0

    .line 466
    if-eqz v0, :cond_0

    .line 467
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getFileData()Lcom/google/protobuf/ByteString;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptMessageCallback;->onDebugMessage(Lcom/google/protobuf/ByteString;)V

    .line 468
    :cond_0
    return-void
.end method

.method private f(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 472
    invoke-virtual {p1, v4}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v0

    .line 473
    const/4 v1, 0x1

    invoke-virtual {p1, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v1

    .line 474
    const/4 v2, 0x2

    invoke-virtual {p1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v2

    .line 475
    shl-int/lit8 v0, v0, 0x10

    or-int/2addr v0, v1

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    .line 476
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/g;->d:Lcom/cyjh/mobileanjian/ipc/d;

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/d;->k()Lcom/cyjh/mobileanjian/ipc/interfaces/OnScreenShotCallback;

    move-result-object v1

    .line 477
    if-nez v2, :cond_0

    .line 478
    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/g;->d:Lcom/cyjh/mobileanjian/ipc/d;

    invoke-virtual {v3, v4}, Lcom/cyjh/mobileanjian/ipc/d;->b(Z)V

    .line 479
    :cond_0
    if-eqz v1, :cond_1

    .line 480
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getFileData()Lcom/google/protobuf/ByteString;

    move-result-object v3

    invoke-interface {v1, v0, v3}, Lcom/cyjh/mobileanjian/ipc/interfaces/OnScreenShotCallback;->onScreenShotDone(Ljava/lang/String;Lcom/google/protobuf/ByteString;)V

    .line 481
    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "screen shot remain pic count: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 482
    return-void
.end method


# virtual methods
.method public a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V
    .locals 7

    .prologue
    const/4 v6, 0x1

    const/4 v5, 0x0

    .line 200
    if-nez p1, :cond_1

    .line 380
    :cond_0
    :goto_0
    :sswitch_0
    return-void

    .line 203
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->d:Lcom/cyjh/mobileanjian/ipc/d;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/d;->j()Lcom/cyjh/mobileanjian/ipc/interfaces/OnRecordScriptCallback;

    move-result-object v0

    .line 204
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getCmd()I

    move-result v1

    sparse-switch v1, :sswitch_data_0

    goto :goto_0

    .line 214
    :sswitch_1
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/g;->a()V

    goto :goto_0

    .line 207
    :sswitch_2
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->d:Lcom/cyjh/mobileanjian/ipc/d;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/d;->o()V

    goto :goto_0

    .line 210
    :sswitch_3
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/g;->b(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 211
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->d:Lcom/cyjh/mobileanjian/ipc/d;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/d;->n()V

    goto :goto_0

    .line 217
    :sswitch_4
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/g;->b()V

    goto :goto_0

    .line 220
    :sswitch_5
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/g;->c()V

    goto :goto_0

    .line 223
    :sswitch_6
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/g;->c(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    goto :goto_0

    .line 226
    :sswitch_7
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->r:Landroid/os/Handler;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    goto :goto_0

    .line 229
    :sswitch_8
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->r:Landroid/os/Handler;

    invoke-virtual {v0, v6, p1}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    goto :goto_0

    .line 232
    :sswitch_9
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/g;->d(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    goto :goto_0

    .line 235
    :sswitch_a
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/g;->f(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    goto :goto_0

    .line 238
    :sswitch_b
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->c:Lcom/cyjh/mobileanjian/ipc/a;

    invoke-virtual {p1, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/a;->a(I)V

    goto :goto_0

    .line 241
    :sswitch_c
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->c:Lcom/cyjh/mobileanjian/ipc/a;

    invoke-virtual {p1, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg2(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/a;->d(Ljava/lang/String;)V

    goto :goto_0

    .line 244
    :sswitch_d
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->c:Lcom/cyjh/mobileanjian/ipc/a;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/a;->h()V

    goto :goto_0

    .line 247
    :sswitch_e
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->c:Lcom/cyjh/mobileanjian/ipc/a;

    invoke-virtual {p1, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/a;->c(I)V

    goto :goto_0

    .line 250
    :sswitch_f
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->c:Lcom/cyjh/mobileanjian/ipc/a;

    invoke-virtual {p1, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg2(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/a;->a(Ljava/lang/String;)Z

    goto :goto_0

    .line 253
    :sswitch_10
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->c:Lcom/cyjh/mobileanjian/ipc/a;

    invoke-virtual {p1, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg2(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/a;->b(Ljava/lang/String;)Z

    goto :goto_0

    .line 256
    :sswitch_11
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->c:Lcom/cyjh/mobileanjian/ipc/a;

    invoke-virtual {p1, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg2(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/a;->c(Ljava/lang/String;)V

    .line 257
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->d:Lcom/cyjh/mobileanjian/ipc/d;

    const/16 v1, 0x26

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/c;->a(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/d;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    goto/16 :goto_0

    .line 260
    :sswitch_12
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->r:Landroid/os/Handler;

    const/16 v1, 0x11

    invoke-virtual {p1, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v2

    invoke-virtual {v0, v1, v2, v5}, Landroid/os/Handler;->obtainMessage(III)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    goto/16 :goto_0

    .line 263
    :sswitch_13
    if-eqz v0, :cond_0

    .line 264
    invoke-interface {v0}, Lcom/cyjh/mobileanjian/ipc/interfaces/OnRecordScriptCallback;->onOpenRecord()V

    goto/16 :goto_0

    .line 267
    :sswitch_14
    invoke-virtual {p1, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v1

    .line 268
    if-eqz v0, :cond_0

    .line 269
    invoke-interface {v0, v1}, Lcom/cyjh/mobileanjian/ipc/interfaces/OnRecordScriptCallback;->onStartRecord(I)V

    goto/16 :goto_0

    .line 272
    :sswitch_15
    invoke-virtual {p1, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg2(I)Ljava/lang/String;

    move-result-object v1

    .line 273
    if-eqz v0, :cond_0

    .line 274
    invoke-interface {v0, v1}, Lcom/cyjh/mobileanjian/ipc/interfaces/OnRecordScriptCallback;->onFinishRecord(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 277
    :sswitch_16
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->r:Landroid/os/Handler;

    const/16 v1, 0x10

    const/high16 v2, 0x42c80000    # 100.0f

    invoke-virtual {p1, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg3(I)F

    move-result v3

    mul-float/2addr v2, v3

    float-to-int v2, v2

    invoke-virtual {p1, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v3

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->obtainMessage(III)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    goto/16 :goto_0

    .line 282
    :sswitch_17
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getPkgName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getClassName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getMethodName()Ljava/lang/String;

    move-result-object v2

    .line 283
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getTypesList()Ljava/util/List;

    move-result-object v3

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getParamsList()Ljava/util/List;

    move-result-object v4

    .line 282
    invoke-static/range {v0 .. v5}, Lcom/cyjh/mobileanjian/ipc/rpc/Invocator;->invoke(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;I)Ljava/lang/Object;

    move-result-object v0

    .line 284
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "retObj = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->d(Ljava/lang/String;)V

    .line 285
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "errno = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->d(Ljava/lang/String;)V

    .line 288
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getIsSyncCall()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 290
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getRetValue()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    move-result-object v1

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    move-result-object v1

    .line 291
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v2

    invoke-virtual {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->setType(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v2

    .line 292
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v3

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getCmd()I

    move-result v4

    invoke-virtual {v3, v4}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v3

    invoke-virtual {v3, v6}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setIsSyncCall(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v3

    .line 293
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getWaitId()I

    move-result v4

    invoke-virtual {v3, v4}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setWaitId(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v3

    .line 297
    :try_start_0
    sget-object v4, Lcom/cyjh/mobileanjian/ipc/g$2;->a:[I

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->ordinal()I

    move-result v5

    aget v4, v4, v5
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    packed-switch v4, :pswitch_data_0

    .line 323
    :goto_1
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->VOID:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    if-eq v1, v0, :cond_2

    .line 324
    invoke-virtual {v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    move-result-object v0

    invoke-virtual {v3, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setRetValue(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    .line 325
    :cond_2
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->d:Lcom/cyjh/mobileanjian/ipc/d;

    invoke-virtual {v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/d;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    goto/16 :goto_0

    .line 300
    :pswitch_0
    :try_start_1
    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    invoke-virtual {v2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->setValBoolean(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1

    .line 318
    :catch_0
    move-exception v0

    .line 320
    const-string v4, "Illigal RETURN_TYPE"

    invoke-static {v4}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->e(Ljava/lang/String;)V

    .line 321
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    goto :goto_1

    .line 303
    :pswitch_1
    :try_start_2
    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-virtual {v2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->setValInt(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    goto :goto_1

    .line 306
    :pswitch_2
    check-cast v0, Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v4

    invoke-virtual {v2, v4, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->setValLong(J)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    goto :goto_1

    .line 309
    :pswitch_3
    check-cast v0, Ljava/lang/Float;

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v0

    invoke-virtual {v2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->setValFloat(F)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    goto :goto_1

    .line 312
    :pswitch_4
    check-cast v0, Ljava/lang/Double;

    invoke-virtual {v0}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v4

    invoke-virtual {v2, v4, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->setValDouble(D)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    goto :goto_1

    .line 315
    :pswitch_5
    if-nez v0, :cond_3

    const-string v0, ""

    :goto_2
    invoke-virtual {v2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->setValString(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    goto :goto_1

    :cond_3
    check-cast v0, Ljava/lang/String;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_2

    .line 329
    :sswitch_18
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/g;->e(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    goto/16 :goto_0

    .line 332
    :sswitch_19
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->d:Lcom/cyjh/mobileanjian/ipc/d;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/d;->c()Lcom/cyjh/mobileanjian/ipc/interfaces/OnRpcCallback;

    move-result-object v0

    invoke-virtual {p1, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg2(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/cyjh/mobileanjian/ipc/interfaces/OnRpcCallback;->onRpcReturn(Ljava/lang/Object;)V

    .line 333
    const-string v0, " === sync_get_cpu_info_returned...."

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 336
    :sswitch_1a
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->c:Lcom/cyjh/mobileanjian/ipc/a;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/a;->g()V

    goto/16 :goto_0

    .line 341
    :sswitch_1b
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->r:Landroid/os/Handler;

    const/16 v1, 0x12

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getFileData()Lcom/google/protobuf/ByteString;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    goto/16 :goto_0

    .line 349
    :sswitch_1c
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->b:Landroid/content/Context;

    invoke-virtual {p1, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg2(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v6}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg2(I)Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x2

    invoke-virtual {p1, v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg2(I)Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v1, v2, v3}, Lcom/cyjh/mobileanjian/ipc/utils/c;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    goto/16 :goto_0

    .line 352
    :sswitch_1d
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->b:Landroid/content/Context;

    invoke-virtual {p1, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg2(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/utils/c;->a(Landroid/content/Context;Ljava/lang/String;)V

    goto/16 :goto_0

    .line 355
    :sswitch_1e
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->b:Landroid/content/Context;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/c;->a(Landroid/content/Context;)V

    goto/16 :goto_0

    .line 359
    :sswitch_1f
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->c:Lcom/cyjh/mobileanjian/ipc/a;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/a;->i()V

    goto/16 :goto_0

    .line 362
    :sswitch_20
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->c:Lcom/cyjh/mobileanjian/ipc/a;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/a;->j()V

    goto/16 :goto_0

    .line 365
    :sswitch_21
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->c:Lcom/cyjh/mobileanjian/ipc/a;

    invoke-virtual {p1, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/a;->d(I)V

    goto/16 :goto_0

    .line 368
    :sswitch_22
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->c:Lcom/cyjh/mobileanjian/ipc/a;

    invoke-virtual {p1, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/a;->e(I)V

    goto/16 :goto_0

    .line 371
    :sswitch_23
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->c:Lcom/cyjh/mobileanjian/ipc/a;

    invoke-virtual {p1, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/a;->f(I)V

    goto/16 :goto_0

    .line 374
    :sswitch_24
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->r:Landroid/os/Handler;

    const/4 v1, 0x6

    invoke-virtual {v0, v1, p1}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    goto/16 :goto_0

    .line 377
    :sswitch_25
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g;->r:Landroid/os/Handler;

    const/4 v1, 0x7

    invoke-virtual {v0, v1, p1}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    goto/16 :goto_0

    .line 204
    :sswitch_data_0
    .sparse-switch
        0x4 -> :sswitch_1
        0x5 -> :sswitch_7
        0x6 -> :sswitch_6
        0xe -> :sswitch_3
        0x13 -> :sswitch_13
        0x15 -> :sswitch_14
        0x17 -> :sswitch_15
        0x19 -> :sswitch_a
        0x20 -> :sswitch_9
        0x21 -> :sswitch_8
        0x22 -> :sswitch_b
        0x23 -> :sswitch_c
        0x24 -> :sswitch_f
        0x25 -> :sswitch_e
        0x26 -> :sswitch_11
        0x27 -> :sswitch_10
        0x28 -> :sswitch_16
        0x29 -> :sswitch_1a
        0x2a -> :sswitch_4
        0x2b -> :sswitch_5
        0x30 -> :sswitch_17
        0x32 -> :sswitch_19
        0x33 -> :sswitch_d
        0x34 -> :sswitch_1c
        0x35 -> :sswitch_1d
        0x36 -> :sswitch_1e
        0x37 -> :sswitch_1f
        0x38 -> :sswitch_20
        0x39 -> :sswitch_21
        0x3a -> :sswitch_22
        0x3b -> :sswitch_23
        0x40 -> :sswitch_1b
        0x41 -> :sswitch_0
        0x42 -> :sswitch_24
        0x43 -> :sswitch_25
        0x81 -> :sswitch_12
        0x101 -> :sswitch_18
        0xffff -> :sswitch_2
    .end sparse-switch

    .line 297
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
    .end packed-switch
.end method
