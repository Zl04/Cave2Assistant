.class public Lcom/cyjh/mobileanjian/ipc/view/a;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/mobileanjian/ipc/view/a$a;
    }
.end annotation


# static fields
.field public static final a:I = 0x0

.field public static final b:I = 0x2

.field public static final c:I = 0x4


# instance fields
.field private d:Landroid/widget/Toast;

.field private e:Landroid/content/Context;

.field private f:Z

.field private g:I

.field private h:I

.field private final i:I

.field private final j:I

.field private final k:I

.field private l:I

.field private m:I

.field private n:Ljava/lang/Object;

.field private o:Ljava/lang/reflect/Method;

.field private p:Ljava/lang/reflect/Method;

.field private q:Landroid/view/WindowManager;

.field private r:Landroid/view/WindowManager$LayoutParams;

.field private s:Landroid/view/WindowManager$LayoutParams;

.field private t:Landroid/view/View;

.field private u:Landroid/os/Handler;

.field private v:Ljava/util/Timer;

.field private w:Lcom/cyjh/mobileanjian/ipc/view/a$a;

.field private x:Ljava/lang/Runnable;


# direct methods
.method private constructor <init>(Landroid/content/Context;)V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 49
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 27
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->f:Z

    .line 28
    const/4 v0, -0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->g:I

    .line 29
    const/4 v0, 0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->h:I

    .line 41
    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->s:Landroid/view/WindowManager$LayoutParams;

    .line 44
    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->u:Landroid/os/Handler;

    .line 45
    new-instance v0, Ljava/util/Timer;

    const-string v1, "hideTimer"

    invoke-direct {v0, v1}, Ljava/util/Timer;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->v:Ljava/util/Timer;

    .line 46
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/view/a$a;

    invoke-direct {v0, p0, v2}, Lcom/cyjh/mobileanjian/ipc/view/a$a;-><init>(Lcom/cyjh/mobileanjian/ipc/view/a;Lcom/cyjh/mobileanjian/ipc/view/a$1;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->w:Lcom/cyjh/mobileanjian/ipc/view/a$a;

    .line 79
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/view/a$1;

    invoke-direct {v0, p0}, Lcom/cyjh/mobileanjian/ipc/view/a$1;-><init>(Lcom/cyjh/mobileanjian/ipc/view/a;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->x:Ljava/lang/Runnable;

    .line 50
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->e:Landroid/content/Context;

    .line 51
    new-instance v0, Landroid/widget/Toast;

    invoke-direct {v0, p1}, Landroid/widget/Toast;-><init>(Landroid/content/Context;)V

    .line 52
    invoke-virtual {v0}, Landroid/widget/Toast;->getGravity()I

    move-result v1

    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->i:I

    .line 53
    invoke-virtual {v0}, Landroid/widget/Toast;->getXOffset()I

    move-result v1

    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->j:I

    .line 54
    invoke-virtual {v0}, Landroid/widget/Toast;->getYOffset()I

    move-result v0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->k:I

    .line 56
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->j:I

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->l:I

    .line 57
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->k:I

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->m:I

    .line 59
    return-void
.end method

.method public static a(Landroid/content/Context;II)Lcom/cyjh/mobileanjian/ipc/view/a;
    .locals 2

    .prologue
    .line 72
    invoke-static {p0, p1, p2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object v0

    .line 73
    new-instance v1, Lcom/cyjh/mobileanjian/ipc/view/a;

    invoke-direct {v1, p0}, Lcom/cyjh/mobileanjian/ipc/view/a;-><init>(Landroid/content/Context;)V

    .line 74
    iput-object v0, v1, Lcom/cyjh/mobileanjian/ipc/view/a;->d:Landroid/widget/Toast;

    .line 75
    iput p2, v1, Lcom/cyjh/mobileanjian/ipc/view/a;->h:I

    .line 76
    return-object v1
.end method

.method public static a(Landroid/content/Context;Ljava/lang/CharSequence;I)Lcom/cyjh/mobileanjian/ipc/view/a;
    .locals 2

    .prologue
    .line 63
    invoke-static {p0, p1, p2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    .line 64
    new-instance v1, Lcom/cyjh/mobileanjian/ipc/view/a;

    invoke-direct {v1, p0}, Lcom/cyjh/mobileanjian/ipc/view/a;-><init>(Landroid/content/Context;)V

    .line 65
    iput-object v0, v1, Lcom/cyjh/mobileanjian/ipc/view/a;->d:Landroid/widget/Toast;

    .line 66
    iput p2, v1, Lcom/cyjh/mobileanjian/ipc/view/a;->h:I

    .line 67
    return-object v1
.end method

.method private b(Landroid/view/WindowManager$LayoutParams;)V
    .locals 2

    .prologue
    .line 277
    .line 280
    :try_start_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->d:Landroid/widget/Toast;

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    const-string v1, "mTN"

    invoke-virtual {v0, v1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0

    .line 281
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 282
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->d:Landroid/widget/Toast;

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->n:Ljava/lang/Object;

    .line 283
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->n:Ljava/lang/Object;

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    const-string v1, "mParams"

    invoke-virtual {v0, v1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0

    .line 284
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 285
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->n:Ljava/lang/Object;

    invoke-virtual {v0, v1, p1}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/NoSuchFieldException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_1

    .line 293
    :goto_0
    return-void

    .line 286
    :catch_0
    move-exception v0

    .line 288
    invoke-virtual {v0}, Ljava/lang/NoSuchFieldException;->printStackTrace()V

    goto :goto_0

    .line 289
    :catch_1
    move-exception v0

    .line 291
    invoke-virtual {v0}, Ljava/lang/IllegalAccessException;->printStackTrace()V

    goto :goto_0
.end method

.method private e()V
    .locals 3

    .prologue
    .line 235
    :try_start_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->d:Landroid/widget/Toast;

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    const-string v1, "mTN"

    invoke-virtual {v0, v1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0

    .line 236
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 237
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->d:Landroid/widget/Toast;

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->n:Ljava/lang/Object;

    .line 238
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->n:Ljava/lang/Object;

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    const-string v1, "show"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Class;

    invoke-virtual {v0, v1, v2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->o:Ljava/lang/reflect/Method;

    .line 239
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->n:Ljava/lang/Object;

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    const-string v1, "hide"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Class;

    invoke-virtual {v0, v1, v2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->p:Ljava/lang/reflect/Method;

    .line 241
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->n:Ljava/lang/Object;

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    const-string v1, "mParams"

    invoke-virtual {v0, v1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0

    .line 242
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 243
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->n:Ljava/lang/Object;

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager$LayoutParams;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->r:Landroid/view/WindowManager$LayoutParams;

    .line 245
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->s:Landroid/view/WindowManager$LayoutParams;

    if-eqz v0, :cond_0

    .line 247
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->r:Landroid/view/WindowManager$LayoutParams;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->s:Landroid/view/WindowManager$LayoutParams;

    iget v1, v1, Landroid/view/WindowManager$LayoutParams;->flags:I

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 248
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->r:Landroid/view/WindowManager$LayoutParams;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->s:Landroid/view/WindowManager$LayoutParams;

    iget v1, v1, Landroid/view/WindowManager$LayoutParams;->width:I

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->width:I

    .line 249
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->r:Landroid/view/WindowManager$LayoutParams;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->s:Landroid/view/WindowManager$LayoutParams;

    iget v1, v1, Landroid/view/WindowManager$LayoutParams;->height:I

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 250
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->r:Landroid/view/WindowManager$LayoutParams;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->s:Landroid/view/WindowManager$LayoutParams;

    iget v1, v1, Landroid/view/WindowManager$LayoutParams;->gravity:I

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->gravity:I

    .line 251
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->r:Landroid/view/WindowManager$LayoutParams;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->s:Landroid/view/WindowManager$LayoutParams;

    iget v1, v1, Landroid/view/WindowManager$LayoutParams;->windowAnimations:I

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->windowAnimations:I

    .line 255
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->g:I

    const/4 v1, -0x1

    if-eq v0, v1, :cond_1

    .line 257
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->r:Landroid/view/WindowManager$LayoutParams;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->g:I

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->windowAnimations:I

    .line 262
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->n:Ljava/lang/Object;

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    const-string v1, "mNextView"

    invoke-virtual {v0, v1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0

    .line 263
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 264
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->n:Ljava/lang/Object;

    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->d:Landroid/widget/Toast;

    invoke-virtual {v2}, Landroid/widget/Toast;->getView()Landroid/view/View;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 273
    :goto_0
    return-void

    .line 267
    :catch_0
    move-exception v0

    .line 269
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method


# virtual methods
.method public a()V
    .locals 4

    .prologue
    .line 132
    :try_start_0
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->f:Z

    if-eqz v0, :cond_1

    .line 134
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->w:Lcom/cyjh/mobileanjian/ipc/view/a$a;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/view/a$a;->cancel()Z

    .line 135
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/view/a$a;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/cyjh/mobileanjian/ipc/view/a$a;-><init>(Lcom/cyjh/mobileanjian/ipc/view/a;Lcom/cyjh/mobileanjian/ipc/view/a$1;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->w:Lcom/cyjh/mobileanjian/ipc/view/a$a;

    .line 136
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->v:Ljava/util/Timer;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->w:Lcom/cyjh/mobileanjian/ipc/view/a$a;

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->h:I

    mul-int/lit16 v2, v2, 0x3e8

    int-to-long v2, v2

    invoke-virtual {v0, v1, v2, v3}, Ljava/util/Timer;->schedule(Ljava/util/TimerTask;J)V

    .line 168
    :cond_0
    :goto_0
    return-void

    .line 140
    :cond_1
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/view/a;->e()V

    .line 141
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->o:Ljava/lang/reflect/Method;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->n:Ljava/lang/Object;

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 143
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->f:Z

    .line 149
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->h:I

    if-lez v0, :cond_0

    .line 151
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->w:Lcom/cyjh/mobileanjian/ipc/view/a$a;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/view/a$a;->cancel()Z

    .line 152
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/view/a$a;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/cyjh/mobileanjian/ipc/view/a$a;-><init>(Lcom/cyjh/mobileanjian/ipc/view/a;Lcom/cyjh/mobileanjian/ipc/view/a$1;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->w:Lcom/cyjh/mobileanjian/ipc/view/a$a;

    .line 153
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->v:Ljava/util/Timer;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->w:Lcom/cyjh/mobileanjian/ipc/view/a$a;

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->h:I

    mul-int/lit16 v2, v2, 0x3e8

    int-to-long v2, v2

    invoke-virtual {v0, v1, v2, v3}, Ljava/util/Timer;->schedule(Ljava/util/TimerTask;J)V
    :try_end_0
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_2

    goto :goto_0

    .line 155
    :catch_0
    move-exception v0

    .line 157
    invoke-virtual {v0}, Ljava/lang/reflect/InvocationTargetException;->printStackTrace()V

    goto :goto_0

    .line 158
    :catch_1
    move-exception v0

    .line 160
    invoke-virtual {v0}, Ljava/lang/IllegalAccessException;->printStackTrace()V

    goto :goto_0

    .line 161
    :catch_2
    move-exception v0

    .line 163
    invoke-virtual {v0}, Ljava/lang/IllegalStateException;->printStackTrace()V

    .line 164
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/view/a;->d()V

    .line 165
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->v:Ljava/util/Timer;

    invoke-virtual {v0}, Ljava/util/Timer;->cancel()V

    .line 166
    new-instance v0, Ljava/util/Timer;

    invoke-direct {v0}, Ljava/util/Timer;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->v:Ljava/util/Timer;

    goto :goto_0
.end method

.method public a(I)V
    .locals 0

    .prologue
    .line 187
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->h:I

    .line 188
    return-void
.end method

.method public a(III)V
    .locals 1

    .prologue
    .line 172
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->d:Landroid/widget/Toast;

    invoke-virtual {v0, p1, p2, p3}, Landroid/widget/Toast;->setGravity(III)V

    .line 173
    return-void
.end method

.method public a(Landroid/view/View;)V
    .locals 1

    .prologue
    .line 177
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->d:Landroid/widget/Toast;

    invoke-virtual {v0, p1}, Landroid/widget/Toast;->setView(Landroid/view/View;)V

    .line 178
    return-void
.end method

.method public a(Landroid/view/WindowManager$LayoutParams;)V
    .locals 0

    .prologue
    .line 297
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->s:Landroid/view/WindowManager$LayoutParams;

    .line 298
    return-void
.end method

.method public a(Ljava/lang/CharSequence;)V
    .locals 1

    .prologue
    .line 197
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->d:Landroid/widget/Toast;

    invoke-virtual {v0, p1}, Landroid/widget/Toast;->setText(Ljava/lang/CharSequence;)V

    .line 198
    return-void
.end method

.method public a(Ljava/lang/CharSequence;II)V
    .locals 4

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 90
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->e:Landroid/content/Context;

    invoke-static {v2, p1, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v2

    invoke-virtual {v2}, Landroid/widget/Toast;->show()V

    .line 93
    if-gez p2, :cond_0

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->l:I

    if-ltz v2, :cond_2

    :cond_0
    if-gez p3, :cond_1

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->m:I

    if-ltz v2, :cond_2

    :cond_1
    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->l:I

    if-ne p2, v2, :cond_4

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->m:I

    if-ne p3, v2, :cond_4

    :cond_2
    move v2, v0

    .line 94
    :goto_0
    if-ltz p2, :cond_3

    if-gez p3, :cond_5

    .line 95
    :cond_3
    :goto_1
    iput p2, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->l:I

    .line 96
    iput p3, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->m:I

    .line 98
    if-eqz v2, :cond_6

    .line 100
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/view/a;->a(Ljava/lang/CharSequence;)V

    .line 113
    :goto_2
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/view/a;->a()V

    .line 126
    return-void

    :cond_4
    move v2, v1

    .line 93
    goto :goto_0

    :cond_5
    move v0, v1

    .line 94
    goto :goto_1

    .line 103
    :cond_6
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/view/a;->d()V

    .line 104
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->e:Landroid/content/Context;

    invoke-static {v2, p1, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->d:Landroid/widget/Toast;

    .line 105
    if-eqz v0, :cond_7

    .line 107
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->d:Landroid/widget/Toast;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->i:I

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->j:I

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->k:I

    invoke-virtual {v0, v1, v2, v3}, Landroid/widget/Toast;->setGravity(III)V

    goto :goto_2

    .line 110
    :cond_7
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->d:Landroid/widget/Toast;

    const/16 v1, 0x33

    invoke-virtual {v0, v1, p2, p3}, Landroid/widget/Toast;->setGravity(III)V

    goto :goto_2
.end method

.method public b()Landroid/view/View;
    .locals 1

    .prologue
    .line 182
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->d:Landroid/widget/Toast;

    invoke-virtual {v0}, Landroid/widget/Toast;->getView()Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method public b(I)V
    .locals 1

    .prologue
    .line 192
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->e:Landroid/content/Context;

    invoke-virtual {v0, p1}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/view/a;->a(Ljava/lang/CharSequence;)V

    .line 193
    return-void
.end method

.method public c()I
    .locals 1

    .prologue
    .line 202
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->g:I

    return v0
.end method

.method public c(I)V
    .locals 0

    .prologue
    .line 207
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->g:I

    .line 208
    return-void
.end method

.method public d()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 217
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->f:Z

    if-nez v0, :cond_0

    .line 229
    :goto_0
    return-void

    .line 220
    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->p:Ljava/lang/reflect/Method;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->n:Ljava/lang/Object;

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_1

    .line 228
    :goto_1
    iput-boolean v3, p0, Lcom/cyjh/mobileanjian/ipc/view/a;->f:Z

    goto :goto_0

    .line 221
    :catch_0
    move-exception v0

    .line 223
    invoke-virtual {v0}, Ljava/lang/reflect/InvocationTargetException;->printStackTrace()V

    goto :goto_1

    .line 224
    :catch_1
    move-exception v0

    .line 226
    invoke-virtual {v0}, Ljava/lang/IllegalAccessException;->printStackTrace()V

    goto :goto_1
.end method
