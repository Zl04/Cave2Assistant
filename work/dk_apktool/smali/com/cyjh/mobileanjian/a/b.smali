.class public Lcom/cyjh/mobileanjian/a/b;
.super Ljava/lang/Thread;
.source "SourceFile"


# static fields
.field private static s:I

.field private static t:Z

.field private static u:I

.field private static v:Z

.field private static w:Z

.field private static final y:Ljava/lang/Class;


# instance fields
.field public a:Ljava/lang/StringBuffer;

.field private b:I

.field private c:Z

.field private d:Z

.field private e:Z

.field private f:Z

.field private g:Z

.field private h:I

.field private i:I

.field private j:I

.field private k:I

.field private l:I

.field private m:I

.field private n:J

.field private o:J

.field private p:J

.field private q:[I

.field private r:J

.field private x:Lcom/cyjh/recordscripts/jni/InputUtility;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 42
    sput v0, Lcom/cyjh/mobileanjian/a/b;->s:I

    .line 44
    sput-boolean v0, Lcom/cyjh/mobileanjian/a/b;->t:Z

    .line 46
    sput v0, Lcom/cyjh/mobileanjian/a/b;->u:I

    .line 47
    sput-boolean v0, Lcom/cyjh/mobileanjian/a/b;->v:Z

    .line 48
    sput-boolean v0, Lcom/cyjh/mobileanjian/a/b;->w:Z

    .line 51
    const-class v0, Lcom/cyjh/mobileanjian/a/b;

    sput-object v0, Lcom/cyjh/mobileanjian/a/b;->y:Ljava/lang/Class;

    return-void
.end method

.method public constructor <init>()V
    .locals 6

    .prologue
    const-wide/16 v4, 0x0

    const/4 v2, 0x1

    const/4 v1, -0x1

    .line 54
    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    .line 17
    const/4 v0, 0x0

    iput v0, p0, Lcom/cyjh/mobileanjian/a/b;->b:I

    .line 20
    iput-boolean v2, p0, Lcom/cyjh/mobileanjian/a/b;->c:Z

    .line 21
    iput-boolean v2, p0, Lcom/cyjh/mobileanjian/a/b;->d:Z

    .line 22
    iput-boolean v2, p0, Lcom/cyjh/mobileanjian/a/b;->e:Z

    .line 23
    iput-boolean v2, p0, Lcom/cyjh/mobileanjian/a/b;->f:Z

    .line 24
    iput-boolean v2, p0, Lcom/cyjh/mobileanjian/a/b;->g:Z

    .line 26
    iput v1, p0, Lcom/cyjh/mobileanjian/a/b;->h:I

    .line 27
    iput v1, p0, Lcom/cyjh/mobileanjian/a/b;->i:I

    .line 28
    iput v1, p0, Lcom/cyjh/mobileanjian/a/b;->j:I

    .line 29
    iput v1, p0, Lcom/cyjh/mobileanjian/a/b;->k:I

    .line 32
    iput v1, p0, Lcom/cyjh/mobileanjian/a/b;->l:I

    .line 33
    iput v1, p0, Lcom/cyjh/mobileanjian/a/b;->m:I

    .line 35
    iput-wide v4, p0, Lcom/cyjh/mobileanjian/a/b;->n:J

    .line 36
    iput-wide v4, p0, Lcom/cyjh/mobileanjian/a/b;->o:J

    .line 37
    iput-wide v4, p0, Lcom/cyjh/mobileanjian/a/b;->p:J

    .line 39
    const/4 v0, 0x5

    new-array v0, v0, [I

    iput-object v0, p0, Lcom/cyjh/mobileanjian/a/b;->q:[I

    .line 40
    iput-wide v4, p0, Lcom/cyjh/mobileanjian/a/b;->r:J

    .line 50
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/a/b;->x:Lcom/cyjh/recordscripts/jni/InputUtility;

    .line 55
    new-instance v0, Lcom/cyjh/recordscripts/jni/InputUtility;

    invoke-direct {v0}, Lcom/cyjh/recordscripts/jni/InputUtility;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/a/b;->x:Lcom/cyjh/recordscripts/jni/InputUtility;

    .line 56
    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/a/b;->a:Ljava/lang/StringBuffer;

    .line 57
    return-void
.end method

.method public static a()I
    .locals 1

    .prologue
    .line 64
    sget v0, Lcom/cyjh/mobileanjian/a/b;->u:I

    return v0
.end method

.method public static a(I)V
    .locals 0

    .prologue
    .line 60
    sput p0, Lcom/cyjh/mobileanjian/a/b;->u:I

    .line 61
    return-void
.end method

.method public static a(Z)V
    .locals 0

    .prologue
    .line 69
    sput-boolean p0, Lcom/cyjh/mobileanjian/a/b;->t:Z

    .line 70
    return-void
.end method

.method private b(Z)Z
    .locals 2

    .prologue
    .line 273
    iget v0, p0, Lcom/cyjh/mobileanjian/a/b;->k:I

    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    .line 274
    const/4 v0, 0x1

    .line 275
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/a/b;->g()V

    .line 276
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/a/b;->j()V

    .line 286
    :goto_0
    return v0

    .line 278
    :cond_0
    if-eqz p1, :cond_1

    .line 279
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/a/b;->g()V

    .line 280
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/a/b;->h()V

    .line 284
    :goto_1
    const/4 v0, 0x0

    goto :goto_0

    .line 282
    :cond_1
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/a/b;->i()V

    goto :goto_1
.end method

.method private d()J
    .locals 2

    .prologue
    .line 216
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    return-wide v0
.end method

.method private e()V
    .locals 3

    .prologue
    const/4 v2, 0x1

    .line 227
    iget v0, p0, Lcom/cyjh/mobileanjian/a/b;->l:I

    const/16 v1, 0x18

    if-ne v0, v1, :cond_1

    .line 228
    iget v0, p0, Lcom/cyjh/mobileanjian/a/b;->m:I

    if-nez v0, :cond_0

    .line 229
    const/4 v0, 0x3

    invoke-static {v0}, Lcom/cyjh/mobileanjian/a/b;->a(I)V

    .line 230
    const/4 v0, 0x0

    sput-boolean v0, Lcom/cyjh/mobileanjian/a/b;->v:Z

    .line 231
    sput-boolean v2, Lcom/cyjh/mobileanjian/a/b;->w:Z

    .line 241
    :cond_0
    :goto_0
    return-void

    .line 234
    :cond_1
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/a/b;->g()V

    .line 235
    iget v0, p0, Lcom/cyjh/mobileanjian/a/b;->m:I

    if-ne v0, v2, :cond_2

    .line 236
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/a/b;->k()V

    goto :goto_0

    .line 237
    :cond_2
    iget v0, p0, Lcom/cyjh/mobileanjian/a/b;->m:I

    if-nez v0, :cond_0

    .line 238
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/a/b;->l()V

    goto :goto_0
.end method

.method private f()V
    .locals 1

    .prologue
    .line 247
    iget v0, p0, Lcom/cyjh/mobileanjian/a/b;->j:I

    packed-switch v0, :pswitch_data_0

    .line 268
    :goto_0
    :pswitch_0
    return-void

    .line 250
    :pswitch_1
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/a/b;->c:Z

    invoke-direct {p0, v0}, Lcom/cyjh/mobileanjian/a/b;->b(Z)Z

    move-result v0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/a/b;->c:Z

    goto :goto_0

    .line 253
    :pswitch_2
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/a/b;->d:Z

    invoke-direct {p0, v0}, Lcom/cyjh/mobileanjian/a/b;->b(Z)Z

    move-result v0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/a/b;->d:Z

    goto :goto_0

    .line 256
    :pswitch_3
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/a/b;->e:Z

    invoke-direct {p0, v0}, Lcom/cyjh/mobileanjian/a/b;->b(Z)Z

    move-result v0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/a/b;->e:Z

    goto :goto_0

    .line 259
    :pswitch_4
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/a/b;->f:Z

    invoke-direct {p0, v0}, Lcom/cyjh/mobileanjian/a/b;->b(Z)Z

    move-result v0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/a/b;->f:Z

    goto :goto_0

    .line 262
    :pswitch_5
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/a/b;->g:Z

    invoke-direct {p0, v0}, Lcom/cyjh/mobileanjian/a/b;->b(Z)Z

    move-result v0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/a/b;->g:Z

    goto :goto_0

    .line 247
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_0
        :pswitch_5
    .end packed-switch
.end method

.method private g()V
    .locals 6

    .prologue
    .line 296
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v0

    const-string v1, "Delay %d- TickCount()\n "

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    iget-wide v4, p0, Lcom/cyjh/mobileanjian/a/b;->p:J

    invoke-static {v4, v5}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-static {v0, v1, v2}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 298
    iget-object v1, p0, Lcom/cyjh/mobileanjian/a/b;->a:Ljava/lang/StringBuffer;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 299
    return-void
.end method

.method private h()V
    .locals 5

    .prologue
    .line 302
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v0

    const-string v1, "TouchDownEvent %d,%d,%d\n"

    const/4 v2, 0x3

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    iget v4, p0, Lcom/cyjh/mobileanjian/a/b;->h:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v2, v3

    const/4 v3, 0x1

    iget v4, p0, Lcom/cyjh/mobileanjian/a/b;->i:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v2, v3

    const/4 v3, 0x2

    iget v4, p0, Lcom/cyjh/mobileanjian/a/b;->j:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-static {v0, v1, v2}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 304
    iget-object v1, p0, Lcom/cyjh/mobileanjian/a/b;->a:Ljava/lang/StringBuffer;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 305
    return-void
.end method

.method private i()V
    .locals 6

    .prologue
    .line 308
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v0

    const-string v1, "TouchMoveEvent %d,%d,%d,%d\n"

    const/4 v2, 0x4

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    iget v4, p0, Lcom/cyjh/mobileanjian/a/b;->h:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v2, v3

    const/4 v3, 0x1

    iget v4, p0, Lcom/cyjh/mobileanjian/a/b;->i:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v2, v3

    const/4 v3, 0x2

    iget v4, p0, Lcom/cyjh/mobileanjian/a/b;->j:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v2, v3

    const/4 v3, 0x3

    iget-wide v4, p0, Lcom/cyjh/mobileanjian/a/b;->o:J

    invoke-static {v4, v5}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-static {v0, v1, v2}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 310
    iget-object v1, p0, Lcom/cyjh/mobileanjian/a/b;->a:Ljava/lang/StringBuffer;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 311
    return-void
.end method

.method private j()V
    .locals 5

    .prologue
    .line 314
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v0

    const-string v1, "TouchUpEvent %d\n"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    iget v4, p0, Lcom/cyjh/mobileanjian/a/b;->j:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-static {v0, v1, v2}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 316
    iget-object v1, p0, Lcom/cyjh/mobileanjian/a/b;->a:Ljava/lang/StringBuffer;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 317
    return-void
.end method

.method private k()V
    .locals 5

    .prologue
    .line 320
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v0

    const-string v1, "KeyDown %d\n"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    iget v4, p0, Lcom/cyjh/mobileanjian/a/b;->l:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-static {v0, v1, v2}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 322
    iget-object v1, p0, Lcom/cyjh/mobileanjian/a/b;->a:Ljava/lang/StringBuffer;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 323
    return-void
.end method

.method private l()V
    .locals 5

    .prologue
    .line 326
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v0

    const-string v1, "KeyUp %d\n"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    iget v4, p0, Lcom/cyjh/mobileanjian/a/b;->l:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-static {v0, v1, v2}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 328
    iget-object v1, p0, Lcom/cyjh/mobileanjian/a/b;->a:Ljava/lang/StringBuffer;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 329
    return-void
.end method


# virtual methods
.method public b()V
    .locals 1

    .prologue
    .line 74
    const/4 v0, 0x1

    sput-boolean v0, Lcom/cyjh/mobileanjian/a/b;->v:Z

    .line 75
    const/4 v0, 0x0

    sput-boolean v0, Lcom/cyjh/mobileanjian/a/b;->w:Z

    .line 76
    iget-object v0, p0, Lcom/cyjh/mobileanjian/a/b;->x:Lcom/cyjh/recordscripts/jni/InputUtility;

    invoke-virtual {v0}, Lcom/cyjh/recordscripts/jni/InputUtility;->Cancel()V

    .line 77
    return-void
.end method

.method public c()V
    .locals 1

    .prologue
    .line 81
    const/4 v0, 0x0

    sput-boolean v0, Lcom/cyjh/mobileanjian/a/b;->v:Z

    .line 82
    iget-object v0, p0, Lcom/cyjh/mobileanjian/a/b;->x:Lcom/cyjh/recordscripts/jni/InputUtility;

    invoke-virtual {v0}, Lcom/cyjh/recordscripts/jni/InputUtility;->Cancel()V

    .line 83
    return-void
.end method

.method public run()V
    .locals 9

    .prologue
    const/4 v8, 0x3

    const/4 v7, -0x1

    const/4 v6, 0x1

    const/4 v5, 0x2

    const/4 v4, 0x0

    .line 90
    :cond_0
    invoke-static {}, Lcom/cyjh/mobileanjian/a/b;->a()I

    move-result v0

    if-ne v0, v6, :cond_3

    .line 91
    iget-object v0, p0, Lcom/cyjh/mobileanjian/a/b;->x:Lcom/cyjh/recordscripts/jni/InputUtility;

    if-nez v0, :cond_1

    .line 92
    new-instance v0, Lcom/cyjh/recordscripts/jni/InputUtility;

    invoke-direct {v0}, Lcom/cyjh/recordscripts/jni/InputUtility;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/a/b;->x:Lcom/cyjh/recordscripts/jni/InputUtility;

    .line 95
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/a/b;->x:Lcom/cyjh/recordscripts/jni/InputUtility;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/a/b;->q:[I

    invoke-virtual {v0, v1}, Lcom/cyjh/recordscripts/jni/InputUtility;->GetInput([I)I

    move-result v0

    .line 96
    if-ne v0, v7, :cond_2

    .line 97
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "GetInput return error. Thread exit! iRet="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/cyjh/mobileanjian/a/b;->y:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 98
    invoke-static {v4}, Lcom/cyjh/mobileanjian/a/b;->a(I)V

    .line 99
    sput v7, Lcom/cyjh/mobileanjian/a/b;->s:I

    .line 100
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    const/16 v1, 0x15

    .line 101
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    sget v1, Lcom/cyjh/mobileanjian/a/b;->s:I

    .line 102
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg1(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 103
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    .line 104
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/ClientService;->a()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 213
    :goto_0
    return-void

    .line 110
    :cond_2
    iget-object v0, p0, Lcom/cyjh/mobileanjian/a/b;->q:[I

    aget v0, v0, v4

    iput v0, p0, Lcom/cyjh/mobileanjian/a/b;->b:I

    .line 111
    iget-object v0, p0, Lcom/cyjh/mobileanjian/a/b;->q:[I

    aget v0, v0, v6

    iput v0, p0, Lcom/cyjh/mobileanjian/a/b;->l:I

    .line 112
    iget-object v0, p0, Lcom/cyjh/mobileanjian/a/b;->q:[I

    aget v0, v0, v5

    iput v0, p0, Lcom/cyjh/mobileanjian/a/b;->m:I

    .line 115
    iget v0, p0, Lcom/cyjh/mobileanjian/a/b;->b:I

    const/16 v1, 0x64

    if-ge v0, v1, :cond_8

    .line 116
    iget v0, p0, Lcom/cyjh/mobileanjian/a/b;->l:I

    const/16 v1, 0x18

    if-ne v0, v1, :cond_8

    sget-boolean v0, Lcom/cyjh/mobileanjian/a/b;->t:Z

    if-eqz v0, :cond_8

    .line 117
    iget v0, p0, Lcom/cyjh/mobileanjian/a/b;->m:I

    if-nez v0, :cond_8

    .line 118
    const-string v0, "\u901a\u8fc7\u97f3\u91cf\u952e\u542f\u52a8\u5f55\u5236\u7ebf\u7a0b"

    sget-object v1, Lcom/cyjh/mobileanjian/a/b;->y:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 119
    invoke-static {v5}, Lcom/cyjh/mobileanjian/a/b;->a(I)V

    .line 120
    sput v4, Lcom/cyjh/mobileanjian/a/b;->s:I

    .line 121
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    const/16 v1, 0x15

    .line 122
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    sget v1, Lcom/cyjh/mobileanjian/a/b;->s:I

    .line 123
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg1(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 124
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    .line 125
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/ClientService;->a()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 126
    sput-boolean v6, Lcom/cyjh/mobileanjian/a/b;->v:Z

    .line 127
    sput-boolean v4, Lcom/cyjh/mobileanjian/a/b;->w:Z

    .line 152
    :cond_3
    :goto_1
    const-string v0, "-----\u5f55\u5236\u7684While\u5faa\u73af\u5f00\u59cb-----"

    sget-object v1, Lcom/cyjh/mobileanjian/a/b;->y:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 153
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/a/b;->d()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/cyjh/mobileanjian/a/b;->r:J

    .line 154
    :goto_2
    invoke-static {}, Lcom/cyjh/mobileanjian/a/b;->a()I

    move-result v0

    if-ne v0, v5, :cond_5

    .line 156
    iget-object v0, p0, Lcom/cyjh/mobileanjian/a/b;->x:Lcom/cyjh/recordscripts/jni/InputUtility;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/a/b;->q:[I

    invoke-virtual {v0, v1}, Lcom/cyjh/recordscripts/jni/InputUtility;->GetInput([I)I

    .line 157
    iget-wide v0, p0, Lcom/cyjh/mobileanjian/a/b;->n:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-nez v0, :cond_4

    .line 158
    iget-wide v0, p0, Lcom/cyjh/mobileanjian/a/b;->r:J

    iput-wide v0, p0, Lcom/cyjh/mobileanjian/a/b;->n:J

    .line 162
    :cond_4
    sget-boolean v0, Lcom/cyjh/mobileanjian/a/b;->v:Z

    if-nez v0, :cond_9

    invoke-static {}, Lcom/cyjh/mobileanjian/a/b;->a()I

    move-result v0

    if-ne v0, v5, :cond_9

    .line 163
    const-string v0, "\u624b\u52a8\u505c\u6b62\u5f55\u5236\u7ebf\u7a0b\uff0c\u5f55\u5236\u7ed3\u675f"

    sget-object v1, Lcom/cyjh/mobileanjian/a/b;->y:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 164
    invoke-static {v8}, Lcom/cyjh/mobileanjian/a/b;->a(I)V

    .line 191
    :cond_5
    invoke-static {}, Lcom/cyjh/mobileanjian/a/b;->a()I

    move-result v0

    if-ne v0, v8, :cond_7

    .line 193
    sget-boolean v0, Lcom/cyjh/mobileanjian/a/b;->w:Z

    if-nez v0, :cond_6

    .line 195
    iget-object v0, p0, Lcom/cyjh/mobileanjian/a/b;->a:Ljava/lang/StringBuffer;

    const-string v1, "TouchDownEvent"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->lastIndexOf(Ljava/lang/String;)I

    move-result v0

    .line 196
    if-eq v0, v7, :cond_6

    .line 198
    iget-object v1, p0, Lcom/cyjh/mobileanjian/a/b;->a:Ljava/lang/StringBuffer;

    invoke-virtual {v1}, Ljava/lang/StringBuffer;->length()I

    move-result v1

    .line 199
    iget-object v2, p0, Lcom/cyjh/mobileanjian/a/b;->a:Ljava/lang/StringBuffer;

    invoke-virtual {v2, v0, v1}, Ljava/lang/StringBuffer;->delete(II)Ljava/lang/StringBuffer;

    .line 204
    :cond_6
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    const/16 v1, 0x17

    .line 205
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/a/b;->a:Ljava/lang/StringBuffer;

    .line 206
    invoke-virtual {v1}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg2(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 207
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    .line 208
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/ClientService;->a()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 209
    invoke-static {v4}, Lcom/cyjh/mobileanjian/a/b;->a(I)V

    .line 212
    :cond_7
    iget-object v0, p0, Lcom/cyjh/mobileanjian/a/b;->x:Lcom/cyjh/recordscripts/jni/InputUtility;

    invoke-virtual {v0}, Lcom/cyjh/recordscripts/jni/InputUtility;->CloseInput()V

    goto/16 :goto_0

    .line 133
    :cond_8
    sget-boolean v0, Lcom/cyjh/mobileanjian/a/b;->v:Z

    if-eqz v0, :cond_0

    invoke-static {}, Lcom/cyjh/mobileanjian/a/b;->a()I

    move-result v0

    if-ne v0, v6, :cond_0

    .line 134
    const-string v0, "\u901a\u8fc7\u6309\u94ae\u624b\u52a8\u89e6\u53d1\u542f\u52a8\u5f55\u5236\u7ebf\u7a0b"

    sget-object v1, Lcom/cyjh/mobileanjian/a/b;->y:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 135
    invoke-static {v5}, Lcom/cyjh/mobileanjian/a/b;->a(I)V

    .line 136
    sput v4, Lcom/cyjh/mobileanjian/a/b;->s:I

    .line 137
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    const/16 v1, 0x15

    .line 138
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    sget v1, Lcom/cyjh/mobileanjian/a/b;->s:I

    .line 139
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg1(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 140
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    .line 141
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/ClientService;->a()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 143
    iget-object v0, p0, Lcom/cyjh/mobileanjian/a/b;->x:Lcom/cyjh/recordscripts/jni/InputUtility;

    invoke-virtual {v0}, Lcom/cyjh/recordscripts/jni/InputUtility;->CloseInput()V

    .line 144
    new-instance v0, Lcom/cyjh/recordscripts/jni/InputUtility;

    invoke-direct {v0}, Lcom/cyjh/recordscripts/jni/InputUtility;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/a/b;->x:Lcom/cyjh/recordscripts/jni/InputUtility;

    goto/16 :goto_1

    .line 168
    :cond_9
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/a/b;->d()J

    move-result-wide v0

    iget-wide v2, p0, Lcom/cyjh/mobileanjian/a/b;->n:J

    sub-long/2addr v0, v2

    iput-wide v0, p0, Lcom/cyjh/mobileanjian/a/b;->o:J

    .line 169
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/a/b;->d()J

    move-result-wide v0

    iget-wide v2, p0, Lcom/cyjh/mobileanjian/a/b;->r:J

    sub-long/2addr v0, v2

    iput-wide v0, p0, Lcom/cyjh/mobileanjian/a/b;->p:J

    .line 170
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/a/b;->d()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/cyjh/mobileanjian/a/b;->n:J

    .line 172
    iget-object v0, p0, Lcom/cyjh/mobileanjian/a/b;->q:[I

    aget v0, v0, v4

    iput v0, p0, Lcom/cyjh/mobileanjian/a/b;->b:I

    .line 174
    iget-object v0, p0, Lcom/cyjh/mobileanjian/a/b;->q:[I

    aget v0, v0, v6

    iput v0, p0, Lcom/cyjh/mobileanjian/a/b;->j:I

    iput v0, p0, Lcom/cyjh/mobileanjian/a/b;->l:I

    .line 176
    iget-object v0, p0, Lcom/cyjh/mobileanjian/a/b;->q:[I

    aget v0, v0, v5

    iput v0, p0, Lcom/cyjh/mobileanjian/a/b;->h:I

    iput v0, p0, Lcom/cyjh/mobileanjian/a/b;->m:I

    .line 178
    iget-object v0, p0, Lcom/cyjh/mobileanjian/a/b;->q:[I

    aget v0, v0, v8

    iput v0, p0, Lcom/cyjh/mobileanjian/a/b;->i:I

    .line 180
    iget-object v0, p0, Lcom/cyjh/mobileanjian/a/b;->q:[I

    const/4 v1, 0x4

    aget v0, v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/a/b;->k:I

    .line 183
    iget v0, p0, Lcom/cyjh/mobileanjian/a/b;->b:I

    const/16 v1, 0x64

    if-ge v0, v1, :cond_a

    .line 184
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/a/b;->e()V

    goto/16 :goto_2

    .line 186
    :cond_a
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/a/b;->f()V

    goto/16 :goto_2
.end method
