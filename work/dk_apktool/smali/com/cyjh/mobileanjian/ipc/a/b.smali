.class public Lcom/cyjh/mobileanjian/ipc/a/b;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/mobileanjian/ipc/a/b$a;,
        Lcom/cyjh/mobileanjian/ipc/a/b$b;
    }
.end annotation


# static fields
.field private static final a:Ljava/lang/Class;


# instance fields
.field private b:Lcom/cyjh/mobileanjian/ipc/b/b;

.field private c:Lcom/cyjh/mobileanjian/ipc/a/c;

.field private final d:Lcom/cyjh/mobileanjian/ipc/a/b$a;

.field private e:Lcom/cyjh/mobileanjian/a/b;

.field private f:Lcom/cyjh/mqm/MQLanguageStub$MQAuxiliary;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 30
    const-class v0, Lcom/cyjh/mobileanjian/ipc/a/b;

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/a/b;->a:Ljava/lang/Class;

    return-void
.end method

.method public constructor <init>(Lcom/cyjh/mobileanjian/ipc/b/b;)V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 37
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 31
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->b:Lcom/cyjh/mobileanjian/ipc/b/b;

    .line 32
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/a/c;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/a/c;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->c:Lcom/cyjh/mobileanjian/ipc/a/c;

    .line 33
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/a/b$a;

    invoke-direct {v0, p0, v1}, Lcom/cyjh/mobileanjian/ipc/a/b$a;-><init>(Lcom/cyjh/mobileanjian/ipc/a/b;Lcom/cyjh/mobileanjian/ipc/a/b$1;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->d:Lcom/cyjh/mobileanjian/ipc/a/b$a;

    .line 34
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->e:Lcom/cyjh/mobileanjian/a/b;

    .line 403
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->f:Lcom/cyjh/mqm/MQLanguageStub$MQAuxiliary;

    .line 38
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->b:Lcom/cyjh/mobileanjian/ipc/b/b;

    .line 39
    return-void
.end method

.method static synthetic a(Lcom/cyjh/mobileanjian/ipc/a/b;)Lcom/cyjh/mqm/MQLanguageStub$MQAuxiliary;
    .locals 1

    .prologue
    .line 28
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/a/b;->k()Lcom/cyjh/mqm/MQLanguageStub$MQAuxiliary;

    move-result-object v0

    return-object v0
.end method

.method private a(I)V
    .locals 1

    .prologue
    .line 340
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/a/b$b;

    invoke-direct {v0, p0, p1}, Lcom/cyjh/mobileanjian/ipc/a/b$b;-><init>(Lcom/cyjh/mobileanjian/ipc/a/b;I)V

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/a/b$b;->start()V

    .line 341
    return-void
.end method

.method static synthetic b(Lcom/cyjh/mobileanjian/ipc/a/b;)Lcom/cyjh/mobileanjian/ipc/b/b;
    .locals 1

    .prologue
    .line 28
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->b:Lcom/cyjh/mobileanjian/ipc/b/b;

    return-object v0
.end method

.method static synthetic b()Ljava/lang/Class;
    .locals 1

    .prologue
    .line 28
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/a/b;->a:Ljava/lang/Class;

    return-object v0
.end method

.method private b(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V
    .locals 2

    .prologue
    .line 43
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "root got command ==> "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getCmd()I

    move-result v1

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/a;->a(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/a/b;->a:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 44
    return-void
.end method

.method private c()V
    .locals 2

    .prologue
    .line 162
    invoke-static {}, Lcom/cyjh/mobileanjian/a/b;->a()I

    move-result v0

    if-eqz v0, :cond_0

    .line 163
    const-string v0, "\u6b63\u5728\u5f55\u5236\u4e2d\uff0c\u4e0d\u5141\u8bb8\u91cd\u590d\u542f\u52a8"

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/a/b;->a:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->e(Ljava/lang/String;Ljava/lang/Class;)V

    .line 171
    :goto_0
    return-void

    .line 166
    :cond_0
    const-string v0, "openRecord..."

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/a/b;->a:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 167
    const/4 v0, 0x1

    invoke-static {v0}, Lcom/cyjh/mobileanjian/a/b;->a(I)V

    .line 168
    new-instance v0, Lcom/cyjh/mobileanjian/a/b;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/a/b;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->e:Lcom/cyjh/mobileanjian/a/b;

    .line 169
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->e:Lcom/cyjh/mobileanjian/a/b;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/a/b;->start()V

    .line 170
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->b:Lcom/cyjh/mobileanjian/ipc/b/b;

    const/16 v1, 0x13

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/c;->a(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    goto :goto_0
.end method

.method private c(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V
    .locals 3

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 175
    invoke-virtual {p1, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v2

    if-ne v2, v0, :cond_0

    :goto_0
    invoke-static {v0}, Lcom/cyjh/mobileanjian/a/b;->a(Z)V

    .line 176
    return-void

    :cond_0
    move v0, v1

    .line 175
    goto :goto_0
.end method

.method private d()V
    .locals 2

    .prologue
    .line 180
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->e:Lcom/cyjh/mobileanjian/a/b;

    if-eqz v0, :cond_0

    .line 181
    const-string v0, "startRecord..."

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/a/b;->a:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 182
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->e:Lcom/cyjh/mobileanjian/a/b;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/a/b;->b()V

    .line 184
    :cond_0
    return-void
.end method

.method private d(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V
    .locals 3

    .prologue
    .line 207
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg2Count()I

    move-result v1

    .line 208
    const/4 v0, 0x0

    :goto_0
    if-ge v0, v1, :cond_0

    .line 210
    packed-switch v0, :pswitch_data_0

    .line 208
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 213
    :pswitch_0
    invoke-virtual {p1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v2

    invoke-static {v2}, Lcom/cyjh/mobileanjian/ipc/a/a;->c(I)V

    .line 214
    invoke-virtual {p1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg2(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/cyjh/mobileanjian/ipc/a/a;->b(Ljava/lang/String;)V

    goto :goto_1

    .line 217
    :pswitch_1
    invoke-virtual {p1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg2(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/cyjh/mobileanjian/ipc/a/a;->a(Ljava/lang/String;)V

    goto :goto_1

    .line 220
    :pswitch_2
    invoke-virtual {p1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg2(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/cyjh/mobileanjian/ipc/a/a;->c(Ljava/lang/String;)V

    goto :goto_1

    .line 223
    :pswitch_3
    invoke-virtual {p1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg2(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/cyjh/mobileanjian/ipc/a/a;->d(Ljava/lang/String;)V

    goto :goto_1

    .line 226
    :pswitch_4
    invoke-virtual {p1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg2(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/cyjh/mobileanjian/ipc/a/a;->e(Ljava/lang/String;)V

    goto :goto_1

    .line 231
    :cond_0
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->b()V

    .line 232
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->y()V

    .line 233
    return-void

    .line 210
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

.method private e()V
    .locals 2

    .prologue
    .line 188
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->e:Lcom/cyjh/mobileanjian/a/b;

    if-eqz v0, :cond_0

    .line 189
    const-string v0, "closeRecord..."

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/a/b;->a:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 190
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->e:Lcom/cyjh/mobileanjian/a/b;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/a/b;->c()V

    .line 192
    :cond_0
    return-void
.end method

.method private e(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V
    .locals 6

    .prologue
    const/4 v1, 0x0

    .line 272
    new-instance v2, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;

    invoke-direct {v2}, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;-><init>()V

    .line 273
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1Count()I

    move-result v0

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg2Count()I

    move-result v3

    invoke-static {v0, v3}, Ljava/lang/Math;->max(II)I

    move-result v3

    .line 275
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getFileData()Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 276
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_0

    .line 278
    iput-object v0, v2, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->c:Lcom/google/protobuf/ByteString;

    :cond_0
    move v0, v1

    .line 281
    :goto_0
    if-ge v0, v3, :cond_1

    .line 283
    packed-switch v0, :pswitch_data_0

    .line 281
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 286
    :pswitch_0
    invoke-virtual {p1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v4

    iput v4, v2, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->k:I

    .line 287
    invoke-virtual {p1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg2(I)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/cyjh/mobileanjian/ipc/a/a;->f(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v2, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->b:Ljava/lang/String;

    .line 288
    invoke-virtual {p1, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg4(I)J

    move-result-wide v4

    iput-wide v4, v2, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->n:J

    goto :goto_1

    .line 291
    :pswitch_1
    invoke-virtual {p1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v4

    iput v4, v2, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->m:I

    .line 292
    invoke-virtual {p1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg2(I)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/cyjh/mobileanjian/ipc/a/a;->f(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v2, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->d:Ljava/lang/String;

    goto :goto_1

    .line 295
    :pswitch_2
    invoke-virtual {p1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v4

    iput v4, v2, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->l:I

    .line 296
    invoke-virtual {p1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg2(I)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/cyjh/mobileanjian/ipc/a/a;->f(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v2, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->e:Ljava/lang/String;

    goto :goto_1

    .line 299
    :pswitch_3
    invoke-virtual {p1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg2(I)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/cyjh/mobileanjian/ipc/a/a;->f(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v2, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->f:Ljava/lang/String;

    goto :goto_1

    .line 302
    :pswitch_4
    invoke-virtual {p1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg2(I)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/cyjh/mobileanjian/ipc/a/a;->f(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v2, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->g:Ljava/lang/String;

    goto :goto_1

    .line 307
    :cond_1
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getEncrypt()Z

    move-result v0

    iput-boolean v0, v2, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->o:Z

    .line 309
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->c:Lcom/cyjh/mobileanjian/ipc/a/c;

    invoke-virtual {v0, v2}, Lcom/cyjh/mobileanjian/ipc/a/c;->a(Lcom/cyjh/mobileanjian/ipc/engine/utils/d;)V

    .line 310
    return-void

    .line 283
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
    .end packed-switch
.end method

.method private f()V
    .locals 3

    .prologue
    .line 248
    new-instance v1, Ljava/io/File;

    sget-object v0, Lcom/cyjh/mobileanjian/ipc/engine/utils/g;->d:Ljava/lang/String;

    if-nez v0, :cond_0

    sget-object v0, Lcom/cyjh/mobileanjian/ipc/engine/utils/g;->c:Ljava/lang/String;

    :goto_0
    invoke-direct {v1, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 249
    invoke-virtual {v1}, Ljava/io/File;->getParent()Ljava/lang/String;

    move-result-object v0

    .line 251
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "ajRootPath = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->q()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/a/b;->a:Ljava/lang/Class;

    invoke-static {v1, v2}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 252
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->c:Lcom/cyjh/mobileanjian/ipc/a/c;

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/a/c;->d()Lcom/cyjh/mqm/MQLanguageStub;

    move-result-object v1

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->q()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Lcom/cyjh/mqm/MQLanguageStub;->SetLocalDir(Ljava/lang/String;Ljava/lang/String;)V

    .line 254
    return-void

    .line 248
    :cond_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/engine/utils/g;->d:Ljava/lang/String;

    goto :goto_0
.end method

.method private g()V
    .locals 1

    .prologue
    .line 258
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->d:Lcom/cyjh/mobileanjian/ipc/a/b$a;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/a/b$a;->start()V

    .line 259
    return-void
.end method

.method private h()V
    .locals 1

    .prologue
    .line 263
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->c:Lcom/cyjh/mobileanjian/ipc/a/c;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/a/c;->c()V

    .line 264
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->b:Lcom/cyjh/mobileanjian/ipc/b/b;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/b/b;->a()V

    .line 266
    return-void
.end method

.method private i()V
    .locals 3

    .prologue
    .line 314
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/engine/utils/i;->a()Ljava/lang/String;

    move-result-object v0

    .line 315
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "cpuinfo: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/a/b;->a:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 316
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    const/16 v1, 0x32

    .line 317
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 318
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/engine/utils/i;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg2(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 319
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    .line 320
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->b:Lcom/cyjh/mobileanjian/ipc/b/b;

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 321
    return-void
.end method

.method private j()V
    .locals 4

    .prologue
    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 326
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    const/16 v3, 0xe

    .line 327
    invoke-virtual {v0, v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 328
    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v3

    invoke-virtual {v0, v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg1(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v3

    .line 329
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->s()Z

    move-result v0

    if-eqz v0, :cond_0

    move v0, v1

    :goto_0
    invoke-virtual {v3, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg1(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 330
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->p()Z

    move-result v3

    if-eqz v3, :cond_1

    :goto_1
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg1(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 331
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    .line 333
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->b:Lcom/cyjh/mobileanjian/ipc/b/b;

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 334
    return-void

    :cond_0
    move v0, v2

    .line 329
    goto :goto_0

    :cond_1
    move v1, v2

    .line 330
    goto :goto_1
.end method

.method private k()Lcom/cyjh/mqm/MQLanguageStub$MQAuxiliary;
    .locals 2

    .prologue
    .line 406
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->f:Lcom/cyjh/mqm/MQLanguageStub$MQAuxiliary;

    if-nez v0, :cond_0

    .line 407
    new-instance v0, Lcom/cyjh/mqm/MQLanguageStub$MQAuxiliary;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->c:Lcom/cyjh/mobileanjian/ipc/a/c;

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/a/c;->d()Lcom/cyjh/mqm/MQLanguageStub;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-direct {v0, v1}, Lcom/cyjh/mqm/MQLanguageStub$MQAuxiliary;-><init>(Lcom/cyjh/mqm/MQLanguageStub;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->f:Lcom/cyjh/mqm/MQLanguageStub$MQAuxiliary;

    .line 408
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->f:Lcom/cyjh/mqm/MQLanguageStub$MQAuxiliary;

    return-object v0
.end method


# virtual methods
.method public a()V
    .locals 3

    .prologue
    .line 49
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->c:Lcom/cyjh/mobileanjian/ipc/a/c;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/a/c;->c()V

    .line 50
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->d:Lcom/cyjh/mobileanjian/ipc/a/b$a;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/a/b$a;->interrupt()V

    .line 51
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->t()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 53
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "am force-stop "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->u()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->s()Z

    move-result v1

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Lcom/cyjh/mobileanjian/ipc/engine/utils/f;->a(Ljava/lang/String;ZI)Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;

    .line 55
    :cond_0
    return-void
.end method

.method public a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V
    .locals 4

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 59
    if-nez p1, :cond_1

    .line 157
    :cond_0
    :goto_0
    return-void

    .line 62
    :cond_1
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/a/b;->b(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 64
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getCmd()I

    move-result v2

    sparse-switch v2, :sswitch_data_0

    goto :goto_0

    .line 89
    :sswitch_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->c:Lcom/cyjh/mobileanjian/ipc/a/c;

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/a/c;->a(Z)V

    goto :goto_0

    .line 67
    :sswitch_1
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/a/b;->h()V

    goto :goto_0

    .line 70
    :sswitch_2
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->a()Z

    move-result v0

    if-nez v0, :cond_2

    .line 72
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/a/b;->f()V

    .line 73
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/a/b;->d(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 75
    :cond_2
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/a/b;->g()V

    .line 76
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/a/b;->j()V

    goto :goto_0

    .line 79
    :sswitch_3
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "set screen rotation "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/a/b;->a:Ljava/lang/Class;

    invoke-static {v0, v2}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 80
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/a/b;->k()Lcom/cyjh/mqm/MQLanguageStub$MQAuxiliary;

    move-result-object v0

    invoke-virtual {p1, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mqm/MQLanguageStub$MQAuxiliary;->SetScreenRotation(I)V

    goto :goto_0

    .line 83
    :sswitch_4
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/a/b;->e(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    goto :goto_0

    .line 86
    :sswitch_5
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->c:Lcom/cyjh/mobileanjian/ipc/a/c;

    invoke-virtual {p1, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg2(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg2(I)Ljava/lang/String;

    move-result-object v0

    const/4 v3, 0x2

    invoke-virtual {p1, v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg2(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v1, v0, v3}, Lcom/cyjh/mobileanjian/ipc/a/c;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 92
    :sswitch_6
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->c:Lcom/cyjh/mobileanjian/ipc/a/c;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/a/c;->c()V

    goto :goto_0

    .line 95
    :sswitch_7
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->c:Lcom/cyjh/mobileanjian/ipc/a/c;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/a/c;->a()V

    goto :goto_0

    .line 98
    :sswitch_8
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->c:Lcom/cyjh/mobileanjian/ipc/a/c;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/a/c;->b()V

    goto :goto_0

    .line 101
    :sswitch_9
    invoke-virtual {p1, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v0

    invoke-direct {p0, v0}, Lcom/cyjh/mobileanjian/ipc/a/b;->a(I)V

    goto/16 :goto_0

    .line 104
    :sswitch_a
    invoke-static {}, Lcom/cyjh/event/Injector;->finishInput()V

    goto/16 :goto_0

    .line 107
    :sswitch_b
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getIsSyncCall()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 109
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getRetValue()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    move-result-object v0

    .line 110
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "return rv: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/a/b;->a:Ljava/lang/Class;

    invoke-static {v1, v2}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 111
    invoke-static {v0}, Lcom/cyjh/mobileanjian/rpc/Rpc;->setReturnValue(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;)V

    .line 112
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getWaitId()I

    move-result v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/rpc/Rpc;->releaseWaitId(I)V

    goto/16 :goto_0

    .line 117
    :sswitch_c
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/a/b;->c:Lcom/cyjh/mobileanjian/ipc/a/c;

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/a/c;->a(Z)V

    goto/16 :goto_0

    .line 120
    :sswitch_d
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getFileData()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/event/a;->a(Lcom/google/protobuf/ByteString;)V

    .line 121
    const-string v0, "debug message already called"

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/a/b;->a:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->d(Ljava/lang/String;Ljava/lang/Class;)V

    goto/16 :goto_0

    .line 124
    :sswitch_e
    invoke-virtual {p1, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v2

    if-nez v2, :cond_3

    :goto_1
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/a/a;->b(Z)V

    goto/16 :goto_0

    :cond_3
    move v0, v1

    goto :goto_1

    .line 127
    :sswitch_f
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/a/b;->i()V

    goto/16 :goto_0

    .line 130
    :sswitch_10
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/a/b;->c()V

    goto/16 :goto_0

    .line 133
    :sswitch_11
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/a/b;->c(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    goto/16 :goto_0

    .line 136
    :sswitch_12
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/a/b;->d()V

    goto/16 :goto_0

    .line 139
    :sswitch_13
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/a/b;->e()V

    goto/16 :goto_0

    .line 144
    :sswitch_14
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getFileData()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/event/b;->a(Lcom/google/protobuf/ByteString;)V

    goto/16 :goto_0

    .line 148
    :sswitch_15
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getFileData()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/event/b;->b(Lcom/google/protobuf/ByteString;)V

    goto/16 :goto_0

    .line 151
    :sswitch_16
    invoke-virtual {p1, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v0

    const-string v1, ""

    invoke-static {v0, v1}, Lcom/cyjh/event/Injector;->setSyncReturnValue(ILjava/lang/String;)V

    goto/16 :goto_0

    .line 154
    :sswitch_17
    invoke-virtual {p1, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg2(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/cyjh/event/Injector;->setSyncReturnValue(ILjava/lang/String;)V

    goto/16 :goto_0

    .line 64
    nop

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_0
        0x2 -> :sswitch_7
        0x3 -> :sswitch_6
        0x7 -> :sswitch_4
        0x8 -> :sswitch_5
        0x9 -> :sswitch_8
        0xd -> :sswitch_e
        0xe -> :sswitch_2
        0xf -> :sswitch_3
        0x12 -> :sswitch_10
        0x14 -> :sswitch_12
        0x16 -> :sswitch_13
        0x18 -> :sswitch_9
        0x1a -> :sswitch_11
        0x26 -> :sswitch_a
        0x30 -> :sswitch_b
        0x32 -> :sswitch_f
        0x40 -> :sswitch_14
        0x41 -> :sswitch_15
        0x42 -> :sswitch_16
        0x43 -> :sswitch_17
        0x100 -> :sswitch_c
        0x101 -> :sswitch_d
        0xffff -> :sswitch_1
    .end sparse-switch
.end method
