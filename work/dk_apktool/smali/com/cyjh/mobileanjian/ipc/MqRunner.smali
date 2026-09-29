.class public Lcom/cyjh/mobileanjian/ipc/MqRunner;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/cyjh/mobileanjian/ipc/interfaces/EngineStateObserver;
.implements Lcom/cyjh/mobileanjian/ipc/interfaces/OnRootApplyCallback;


# static fields
.field private static final a:I = 0x100

.field private static b:Lcom/cyjh/mobileanjian/ipc/MqRunner;


# instance fields
.field private c:Lcom/cyjh/mobileanjian/ipc/d;

.field private d:Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;

.field private e:Landroid/os/Handler;

.field private f:Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;

.field private g:Z

.field private h:Z

.field private i:Z

.field private j:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 32
    const/4 v0, 0x0

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->b:Lcom/cyjh/mobileanjian/ipc/MqRunner;

    return-void
.end method

.method private constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x0

    .line 46
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 33
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->c:Lcom/cyjh/mobileanjian/ipc/d;

    .line 35
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->e:Landroid/os/Handler;

    .line 39
    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->g:Z

    .line 40
    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->h:Z

    .line 41
    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->i:Z

    .line 43
    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->j:Z

    .line 47
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/MqRunner$1;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, p0, v1}, Lcom/cyjh/mobileanjian/ipc/MqRunner$1;-><init>(Lcom/cyjh/mobileanjian/ipc/MqRunner;Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->e:Landroid/os/Handler;

    .line 68
    return-void
.end method

.method private a()V
    .locals 4

    .prologue
    .line 85
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->j:Z

    if-eqz v0, :cond_0

    .line 92
    :goto_0
    return-void

    .line 88
    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->j:Z

    .line 89
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/h;->d()Ljava/io/File;

    move-result-object v0

    .line 90
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/j;->b()Lcom/cyjh/mobileanjian/ipc/j;

    move-result-object v1

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/j;->b(Ljava/lang/String;)Z

    .line 91
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->e:Landroid/os/Handler;

    const/16 v1, 0x100

    const-wide/16 v2, 0xbb8

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->sendEmptyMessageDelayed(IJ)Z

    goto :goto_0
.end method

.method private a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V
    .locals 1

    .prologue
    .line 239
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->g:Z

    if-eqz v0, :cond_0

    .line 241
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->c:Lcom/cyjh/mobileanjian/ipc/d;

    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/d;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 243
    :cond_0
    return-void
.end method

.method private a(Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;)V
    .locals 4

    .prologue
    .line 128
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->g:Z

    if-eqz v0, :cond_1

    .line 130
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    const/4 v1, 0x7

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v1

    .line 131
    const/4 v0, 0x0

    :goto_0
    const/4 v2, 0x5

    if-ge v0, v2, :cond_0

    .line 133
    packed-switch v0, :pswitch_data_0

    .line 131
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 136
    :pswitch_0
    iget v2, p1, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->trialTime:I

    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg1(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    .line 137
    iget-object v2, p1, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->lcPath:Ljava/lang/String;

    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg2(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    .line 138
    iget-wide v2, p1, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->encryptKey:J

    invoke-virtual {v1, v2, v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg4(J)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    goto :goto_1

    .line 141
    :pswitch_1
    iget v2, p1, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->repeat:I

    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg1(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    .line 142
    iget-object v2, p1, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->atcPath:Ljava/lang/String;

    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg2(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    goto :goto_1

    .line 145
    :pswitch_2
    iget v2, p1, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->duration:I

    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg1(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    .line 146
    iget-object v2, p1, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->uiCfgPath:Ljava/lang/String;

    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg2(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    goto :goto_1

    .line 149
    :pswitch_3
    iget-object v2, p1, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->appId:Ljava/lang/String;

    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg2(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    goto :goto_1

    .line 152
    :pswitch_4
    iget-object v2, p1, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->username:Ljava/lang/String;

    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg2(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    goto :goto_1

    .line 156
    :cond_0
    iget-boolean v0, p1, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->encrypt:Z

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setEncrypt(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    .line 158
    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 172
    :goto_2
    return-void

    .line 162
    :cond_1
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->h:Z

    .line 163
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/j;->b()Lcom/cyjh/mobileanjian/ipc/j;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/j;->a()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 165
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->a()V

    goto :goto_2

    .line 169
    :cond_2
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/i;->a()Lcom/cyjh/mobileanjian/ipc/i;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/i;->c()V

    goto :goto_2

    .line 133
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

.method static synthetic a(Lcom/cyjh/mobileanjian/ipc/MqRunner;Z)Z
    .locals 0

    .prologue
    .line 29
    iput-boolean p1, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->j:Z

    return p1
.end method

.method public static declared-synchronized getInstance()Lcom/cyjh/mobileanjian/ipc/MqRunner;
    .locals 2

    .prologue
    .line 72
    const-class v1, Lcom/cyjh/mobileanjian/ipc/MqRunner;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->b:Lcom/cyjh/mobileanjian/ipc/MqRunner;

    if-nez v0, :cond_0

    .line 74
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/MqRunner;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;-><init>()V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->b:Lcom/cyjh/mobileanjian/ipc/MqRunner;

    .line 77
    :cond_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->b:Lcom/cyjh/mobileanjian/ipc/MqRunner;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v1

    return-object v0

    .line 72
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method


# virtual methods
.method public isScriptStarted()Z
    .locals 1

    .prologue
    .line 101
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->c:Lcom/cyjh/mobileanjian/ipc/d;

    if-nez v0, :cond_0

    .line 102
    const/4 v0, 0x0

    .line 104
    :goto_0
    return v0

    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->c:Lcom/cyjh/mobileanjian/ipc/d;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/d;->e()Z

    move-result v0

    goto :goto_0
.end method

.method public notifyRotationStatus()V
    .locals 3

    .prologue
    .line 193
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/h;->a()Landroid/app/Application;

    move-result-object v0

    const-string v1, "window"

    invoke-virtual {v0, v1}, Landroid/app/Application;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    invoke-interface {v0}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v0

    .line 194
    invoke-virtual {v0}, Landroid/view/Display;->getRotation()I

    move-result v0

    .line 195
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v1

    const/16 v2, 0xf

    .line 196
    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v1

    .line 197
    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg1(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 198
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    .line 199
    invoke-direct {p0, v0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 200
    return-void
.end method

.method public notifyUiEvent(Lcom/google/protobuf/ByteString;)V
    .locals 2

    .prologue
    .line 229
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    const/16 v1, 0x41

    .line 230
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 231
    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setFileData(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 232
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    .line 233
    invoke-direct {p0, v0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 234
    return-void
.end method

.method public onConnected(Lcom/cyjh/mobileanjian/ipc/d;)V
    .locals 2

    .prologue
    .line 248
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->c:Lcom/cyjh/mobileanjian/ipc/d;

    .line 249
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->g:Z

    .line 251
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->h:Z

    if-eqz v0, :cond_0

    .line 253
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->h:Z

    .line 254
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->d:Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->setScript(Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;)Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->f:Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->setOnScriptListener(Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;)Lcom/cyjh/mobileanjian/ipc/MqRunner;

    .line 255
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->i:Z

    if-eqz v0, :cond_0

    .line 257
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->start()V

    .line 260
    :cond_0
    return-void
.end method

.method public onCrash(Lcom/cyjh/mobileanjian/ipc/c;)V
    .locals 1

    .prologue
    .line 271
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->g:Z

    .line 272
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->a()V

    .line 273
    return-void
.end method

.method public onExit()V
    .locals 1

    .prologue
    .line 265
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->g:Z

    .line 266
    return-void
.end method

.method public onObtained()V
    .locals 0

    .prologue
    .line 278
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->a()V

    .line 279
    return-void
.end method

.method public onRefused()V
    .locals 3

    .prologue
    .line 284
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->e:Landroid/os/Handler;

    const/4 v1, 0x4

    const-string v2, "User refused root."

    invoke-virtual {v0, v1, v2}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    .line 285
    return-void
.end method

.method public sendUiResponse(Lcom/google/protobuf/ByteString;)V
    .locals 2

    .prologue
    .line 220
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    const/16 v1, 0x40

    .line 221
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 222
    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setFileData(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 223
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    .line 224
    invoke-direct {p0, v0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 225
    return-void
.end method

.method public setOnScriptListener(Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;)Lcom/cyjh/mobileanjian/ipc/MqRunner;
    .locals 2

    .prologue
    .line 183
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->f:Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;

    .line 184
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->c:Lcom/cyjh/mobileanjian/ipc/d;

    if-eqz v0, :cond_0

    .line 186
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->c:Lcom/cyjh/mobileanjian/ipc/d;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->f:Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/d;->a(Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;)V

    .line 188
    :cond_0
    return-object p0
.end method

.method public setScript(Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;)Lcom/cyjh/mobileanjian/ipc/MqRunner;
    .locals 0

    .prologue
    .line 115
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->d:Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;

    .line 116
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->a(Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;)V

    .line 118
    return-object p0
.end method

.method public start()V
    .locals 2

    .prologue
    const/4 v1, 0x1

    .line 204
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->g:Z

    if-nez v0, :cond_0

    move v0, v1

    :goto_0
    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->i:Z

    .line 205
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->notifyRotationStatus()V

    .line 206
    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/c;->a(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 207
    return-void

    .line 204
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public stop()V
    .locals 1

    .prologue
    .line 211
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner;->g:Z

    if-eqz v0, :cond_0

    .line 213
    const/4 v0, 0x3

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/c;->a(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 215
    :cond_0
    return-void
.end method
