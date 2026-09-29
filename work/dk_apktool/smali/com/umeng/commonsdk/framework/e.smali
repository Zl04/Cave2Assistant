.class public Lcom/umeng/commonsdk/framework/e;
.super Ljava/lang/Object;
.source "UMWorkDispatchImpl.java"


# static fields
.field private static a:Landroid/os/HandlerThread; = null

.field private static b:Landroid/os/Handler; = null

.field private static c:Lcom/umeng/commonsdk/framework/d; = null

.field private static final d:I = 0x300

.field private static final e:I = 0x301

.field private static final f:I = 0x302


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 23
    sput-object v0, Lcom/umeng/commonsdk/framework/e;->a:Landroid/os/HandlerThread;

    .line 24
    sput-object v0, Lcom/umeng/commonsdk/framework/e;->b:Landroid/os/Handler;

    .line 26
    sput-object v0, Lcom/umeng/commonsdk/framework/e;->c:Lcom/umeng/commonsdk/framework/d;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 73
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 75
    return-void
.end method

.method private static a(Lorg/json/JSONObject;Lorg/json/JSONObject;Ljava/lang/String;)Lorg/json/JSONObject;
    .locals 5

    .prologue
    .line 151
    invoke-static {}, Lcom/umeng/commonsdk/framework/c;->a()Landroid/content/Context;

    move-result-object v2

    .line 153
    if-eqz p0, :cond_1

    if-eqz p1, :cond_1

    .line 154
    :try_start_0
    invoke-virtual {p0, p2}, Lorg/json/JSONObject;->opt(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-virtual {p0, p2}, Lorg/json/JSONObject;->opt(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    instance-of v0, v0, Lorg/json/JSONObject;

    if-eqz v0, :cond_1

    .line 155
    invoke-virtual {p0, p2}, Lorg/json/JSONObject;->opt(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/json/JSONObject;

    .line 156
    invoke-virtual {p1}, Lorg/json/JSONObject;->keys()Ljava/util/Iterator;

    move-result-object v3

    .line 157
    :cond_0
    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 158
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    .line 159
    if-eqz v1, :cond_0

    instance-of v4, v1, Ljava/lang/String;

    if-eqz v4, :cond_0

    .line 160
    check-cast v1, Ljava/lang/String;

    .line 161
    if-eqz v1, :cond_0

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->opt(Ljava/lang/String;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v4

    if-eqz v4, :cond_0

    .line 163
    :try_start_1
    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->opt(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v4

    invoke-virtual {v0, v1, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    .line 164
    :catch_0
    move-exception v1

    .line 165
    :try_start_2
    invoke-static {v2, v1}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_0

    .line 173
    :catch_1
    move-exception v0

    .line 174
    invoke-static {v2, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    .line 176
    :cond_1
    return-object p0
.end method

.method public static a()V
    .locals 2

    .prologue
    .line 250
    sget-object v0, Lcom/umeng/commonsdk/framework/e;->b:Landroid/os/Handler;

    if-eqz v0, :cond_0

    .line 251
    sget-object v0, Lcom/umeng/commonsdk/framework/e;->b:Landroid/os/Handler;

    invoke-virtual {v0}, Landroid/os/Handler;->obtainMessage()Landroid/os/Message;

    move-result-object v0

    .line 252
    const/16 v1, 0x302

    iput v1, v0, Landroid/os/Message;->what:I

    .line 253
    sget-object v1, Lcom/umeng/commonsdk/framework/e;->b:Landroid/os/Handler;

    invoke-virtual {v1, v0}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    .line 255
    :cond_0
    return-void
.end method

.method public static a(Landroid/content/Context;ILcom/umeng/commonsdk/framework/UMLogDataProtocol;Ljava/lang/Object;)V
    .locals 2

    .prologue
    .line 43
    if-eqz p0, :cond_0

    if-nez p2, :cond_2

    .line 44
    :cond_0
    const-string v0, "--->>> Context or UMLogDataProtocol parameter cannot be null!"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/e;->b(Ljava/lang/String;)V

    .line 68
    :cond_1
    :goto_0
    return-void

    .line 47
    :cond_2
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/commonsdk/framework/c;->a(Landroid/content/Context;)V

    .line 48
    invoke-static {p1, p2}, Lcom/umeng/commonsdk/framework/c;->a(ILcom/umeng/commonsdk/framework/UMLogDataProtocol;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 51
    sget-object v0, Lcom/umeng/commonsdk/framework/e;->a:Landroid/os/HandlerThread;

    if-eqz v0, :cond_3

    sget-object v0, Lcom/umeng/commonsdk/framework/e;->b:Landroid/os/Handler;

    if-nez v0, :cond_4

    .line 52
    :cond_3
    invoke-static {}, Lcom/umeng/commonsdk/framework/e;->e()V

    .line 54
    :cond_4
    sget-object v0, Lcom/umeng/commonsdk/framework/e;->b:Landroid/os/Handler;

    if-eqz v0, :cond_1

    .line 55
    sget-object v0, Lcom/umeng/commonsdk/framework/e;->c:Lcom/umeng/commonsdk/framework/d;

    if-nez v0, :cond_5

    .line 56
    invoke-static {p0}, Lcom/umeng/commonsdk/framework/b;->f(Landroid/content/Context;)V

    .line 57
    new-instance v0, Lcom/umeng/commonsdk/framework/d;

    sget-object v1, Lcom/umeng/commonsdk/framework/e;->b:Landroid/os/Handler;

    invoke-direct {v0, p0, v1}, Lcom/umeng/commonsdk/framework/d;-><init>(Landroid/content/Context;Landroid/os/Handler;)V

    sput-object v0, Lcom/umeng/commonsdk/framework/e;->c:Lcom/umeng/commonsdk/framework/d;

    .line 60
    :cond_5
    sget-object v0, Lcom/umeng/commonsdk/framework/e;->b:Landroid/os/Handler;

    invoke-virtual {v0}, Landroid/os/Handler;->obtainMessage()Landroid/os/Message;

    move-result-object v0

    .line 61
    const/16 v1, 0x300

    iput v1, v0, Landroid/os/Message;->what:I

    .line 62
    iput p1, v0, Landroid/os/Message;->arg1:I

    .line 64
    iput-object p3, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    .line 65
    sget-object v1, Lcom/umeng/commonsdk/framework/e;->b:Landroid/os/Handler;

    invoke-virtual {v1, v0}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    goto :goto_0
.end method

.method static synthetic a(Landroid/os/Message;)V
    .locals 0

    .prologue
    .line 20
    invoke-static {p0}, Lcom/umeng/commonsdk/framework/e;->b(Landroid/os/Message;)V

    return-void
.end method

.method static synthetic b()V
    .locals 0

    .prologue
    .line 20
    invoke-static {}, Lcom/umeng/commonsdk/framework/e;->d()V

    return-void
.end method

.method private static b(Landroid/os/Message;)V
    .locals 5

    .prologue
    .line 216
    iget v0, p0, Landroid/os/Message;->arg1:I

    .line 217
    iget-object v1, p0, Landroid/os/Message;->obj:Ljava/lang/Object;

    .line 218
    invoke-static {v0}, Lcom/umeng/commonsdk/framework/c;->a(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/umeng/commonsdk/framework/c;->a(Ljava/lang/String;)Lcom/umeng/commonsdk/framework/UMLogDataProtocol;

    move-result-object v2

    .line 220
    if-eqz v2, :cond_0

    .line 221
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "--->>> dispatch:handleEvent: call back workEvent with msg type [ 0x"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-static {v0}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "]"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/umeng/commonsdk/statistics/common/e;->b(Ljava/lang/String;)V

    .line 222
    invoke-interface {v2, v1, v0}, Lcom/umeng/commonsdk/framework/UMLogDataProtocol;->workEvent(Ljava/lang/Object;I)V

    .line 224
    :cond_0
    return-void
.end method

.method static synthetic c()V
    .locals 0

    .prologue
    .line 20
    invoke-static {}, Lcom/umeng/commonsdk/framework/e;->g()V

    return-void
.end method

.method private static d()V
    .locals 7

    .prologue
    .line 84
    const-string v0, "--->>> autoProcess Enter..."

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/e;->b(Ljava/lang/String;)V

    .line 87
    invoke-static {}, Lcom/umeng/commonsdk/framework/c;->a()Landroid/content/Context;

    move-result-object v4

    .line 88
    if-eqz v4, :cond_0

    .line 89
    invoke-static {v4}, Lcom/umeng/commonsdk/framework/UMEnvelopeBuild;->maxDataSpace(Landroid/content/Context;)J

    move-result-wide v2

    .line 90
    const-string v0, "analytics"

    invoke-static {v0}, Lcom/umeng/commonsdk/framework/c;->a(Ljava/lang/String;)Lcom/umeng/commonsdk/framework/UMLogDataProtocol;

    move-result-object v5

    .line 94
    const/4 v1, 0x0

    .line 98
    const/4 v0, 0x0

    .line 104
    :try_start_0
    sget-object v6, Lcom/umeng/commonsdk/framework/UMLogDataProtocol$UMBusinessType;->U_DPLUS:Lcom/umeng/commonsdk/framework/UMLogDataProtocol$UMBusinessType;

    invoke-static {v4, v6}, Lcom/umeng/commonsdk/framework/UMEnvelopeBuild;->isReadyBuild(Landroid/content/Context;Lcom/umeng/commonsdk/framework/UMLogDataProtocol$UMBusinessType;)Z

    move-result v6

    if-eqz v6, :cond_3

    .line 106
    if-eqz v5, :cond_3

    .line 109
    invoke-interface {v5, v2, v3}, Lcom/umeng/commonsdk/framework/UMLogDataProtocol;->setupReportData(J)Lorg/json/JSONObject;

    move-result-object v1

    .line 110
    if-eqz v1, :cond_2

    .line 111
    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    array-length v0, v0

    move v2, v0

    move-object v3, v1

    .line 117
    :goto_0
    if-eqz v3, :cond_0

    .line 119
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    .line 121
    :try_start_1
    const-string v0, "header"

    new-instance v6, Lorg/json/JSONObject;

    invoke-direct {v6}, Lorg/json/JSONObject;-><init>()V

    invoke-virtual {v1, v0, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 122
    const-string v0, "content"

    new-instance v6, Lorg/json/JSONObject;

    invoke-direct {v6}, Lorg/json/JSONObject;-><init>()V

    invoke-virtual {v1, v0, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    .line 127
    :goto_1
    if-eqz v3, :cond_1

    if-lez v2, :cond_1

    .line 128
    :try_start_2
    const-string v0, "header"

    invoke-virtual {v3, v0}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v2, "header"

    invoke-static {v1, v0, v2}, Lcom/umeng/commonsdk/framework/e;->a(Lorg/json/JSONObject;Lorg/json/JSONObject;Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    .line 129
    const-string v1, "content"

    invoke-virtual {v3, v1}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1

    const-string v2, "content"

    invoke-static {v0, v1, v2}, Lcom/umeng/commonsdk/framework/e;->a(Lorg/json/JSONObject;Lorg/json/JSONObject;Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    .line 132
    :goto_2
    if-eqz v0, :cond_0

    .line 134
    const-string v1, "header"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1

    const-string v2, "content"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    invoke-static {v4, v1, v0}, Lcom/umeng/commonsdk/framework/UMEnvelopeBuild;->buildEnvelopeWithExtHeader(Landroid/content/Context;Lorg/json/JSONObject;Lorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object v0

    .line 135
    if-eqz v0, :cond_0

    .line 137
    if-eqz v3, :cond_0

    .line 138
    invoke-interface {v5, v3}, Lcom/umeng/commonsdk/framework/UMLogDataProtocol;->removeCacheData(Ljava/lang/Object;)V

    .line 148
    :cond_0
    :goto_3
    return-void

    .line 123
    :catch_0
    move-exception v0

    .line 124
    invoke-static {v4, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_1

    .line 143
    :catch_1
    move-exception v0

    .line 144
    invoke-static {v4, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_3

    :cond_1
    move-object v0, v1

    goto :goto_2

    :cond_2
    move v2, v0

    move-object v3, v1

    goto :goto_0

    :cond_3
    move v2, v0

    move-object v3, v1

    goto :goto_0
.end method

.method private static e()V
    .locals 2

    .prologue
    .line 180
    const-string v0, "--->>> Dispatch: init Enter..."

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/e;->b(Ljava/lang/String;)V

    .line 181
    sget-object v0, Lcom/umeng/commonsdk/framework/e;->a:Landroid/os/HandlerThread;

    if-nez v0, :cond_0

    .line 182
    new-instance v0, Landroid/os/HandlerThread;

    const-string v1, "work_thread"

    invoke-direct {v0, v1}, Landroid/os/HandlerThread;-><init>(Ljava/lang/String;)V

    sput-object v0, Lcom/umeng/commonsdk/framework/e;->a:Landroid/os/HandlerThread;

    .line 183
    sget-object v0, Lcom/umeng/commonsdk/framework/e;->a:Landroid/os/HandlerThread;

    invoke-virtual {v0}, Landroid/os/HandlerThread;->start()V

    .line 185
    sget-object v0, Lcom/umeng/commonsdk/framework/e;->b:Landroid/os/Handler;

    if-nez v0, :cond_0

    .line 186
    new-instance v0, Lcom/umeng/commonsdk/framework/e$1;

    sget-object v1, Lcom/umeng/commonsdk/framework/e;->a:Landroid/os/HandlerThread;

    invoke-virtual {v1}, Landroid/os/HandlerThread;->getLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/umeng/commonsdk/framework/e$1;-><init>(Landroid/os/Looper;)V

    sput-object v0, Lcom/umeng/commonsdk/framework/e;->b:Landroid/os/Handler;

    .line 211
    :cond_0
    return-void
.end method

.method private static f()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 227
    sget-object v0, Lcom/umeng/commonsdk/framework/e;->a:Landroid/os/HandlerThread;

    if-eqz v0, :cond_0

    .line 228
    sput-object v1, Lcom/umeng/commonsdk/framework/e;->a:Landroid/os/HandlerThread;

    .line 230
    :cond_0
    sget-object v0, Lcom/umeng/commonsdk/framework/e;->b:Landroid/os/Handler;

    if-eqz v0, :cond_1

    .line 231
    sput-object v1, Lcom/umeng/commonsdk/framework/e;->b:Landroid/os/Handler;

    .line 234
    :cond_1
    sget-object v0, Lcom/umeng/commonsdk/framework/e;->c:Lcom/umeng/commonsdk/framework/d;

    if-eqz v0, :cond_2

    .line 235
    sput-object v1, Lcom/umeng/commonsdk/framework/e;->c:Lcom/umeng/commonsdk/framework/d;

    .line 238
    :cond_2
    return-void
.end method

.method private static g()V
    .locals 1

    .prologue
    .line 241
    sget-object v0, Lcom/umeng/commonsdk/framework/e;->c:Lcom/umeng/commonsdk/framework/d;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/umeng/commonsdk/framework/e;->a:Landroid/os/HandlerThread;

    if-eqz v0, :cond_0

    .line 242
    invoke-static {}, Lcom/umeng/commonsdk/framework/d;->a()V

    .line 243
    const-string v0, "--->>> handleQuit: Quit dispatch thread."

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/e;->b(Ljava/lang/String;)V

    .line 244
    sget-object v0, Lcom/umeng/commonsdk/framework/e;->a:Landroid/os/HandlerThread;

    invoke-virtual {v0}, Landroid/os/HandlerThread;->quit()Z

    .line 245
    invoke-static {}, Lcom/umeng/commonsdk/framework/e;->f()V

    .line 247
    :cond_0
    return-void
.end method
