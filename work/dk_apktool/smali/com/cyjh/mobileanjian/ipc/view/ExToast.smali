.class public Lcom/cyjh/mobileanjian/ipc/view/ExToast;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/mobileanjian/ipc/view/ExToast$a;
    }
.end annotation


# static fields
.field public static final LENGTH_LONG:I = 0xdac

.field public static final LENGTH_SHORT:I = 0x7d0

.field private static final g:I = 0x33


# instance fields
.field private a:Landroid/view/WindowManager;

.field private b:Landroid/view/WindowManager$LayoutParams;

.field private c:Ljava/util/Timer;

.field private d:Landroid/widget/Toast;

.field private e:Z

.field private f:I

.field private h:I

.field private i:I

.field private j:I

.field private k:Ljava/lang/CharSequence;

.field private l:I

.field private m:Lcom/cyjh/mobileanjian/ipc/view/ExToast$a;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 2

    .prologue
    const/4 v0, -0x1

    .line 38
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 31
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->i:I

    .line 32
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->j:I

    .line 35
    const/16 v0, 0x7d0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->l:I

    .line 98
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/view/ExToast$a;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/cyjh/mobileanjian/ipc/view/ExToast$a;-><init>(Lcom/cyjh/mobileanjian/ipc/view/ExToast;Lcom/cyjh/mobileanjian/ipc/view/ExToast$1;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->m:Lcom/cyjh/mobileanjian/ipc/view/ExToast$a;

    .line 39
    const-string v0, "window"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->a:Landroid/view/WindowManager;

    .line 40
    const-string v0, ""

    const/4 v1, 0x0

    invoke-static {p1, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->d:Landroid/widget/Toast;

    .line 45
    new-instance v0, Ljava/util/Timer;

    invoke-direct {v0}, Ljava/util/Timer;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->c:Ljava/util/Timer;

    .line 46
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->a(Landroid/content/Context;)V

    .line 47
    return-void
.end method

.method private a(ILjava/lang/CharSequence;III)V
    .locals 4

    .prologue
    const/16 v0, 0x7d0

    .line 121
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->b:Landroid/view/WindowManager$LayoutParams;

    iput p1, v1, Landroid/view/WindowManager$LayoutParams;->gravity:I

    .line 122
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->f:I

    if-ne p1, v1, :cond_1

    .line 124
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->b:Landroid/view/WindowManager$LayoutParams;

    const/4 v2, 0x0

    iput v2, v1, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 125
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->b:Landroid/view/WindowManager$LayoutParams;

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->h:I

    iput v2, v1, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 132
    :goto_0
    invoke-virtual {p0, p2}, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->setText(Ljava/lang/CharSequence;)V

    .line 133
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->a:Landroid/view/WindowManager;

    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->d:Landroid/widget/Toast;

    invoke-virtual {v2}, Landroid/widget/Toast;->getView()Landroid/view/View;

    move-result-object v2

    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->b:Landroid/view/WindowManager$LayoutParams;

    invoke-interface {v1, v2, v3}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 134
    new-instance v1, Lcom/cyjh/mobileanjian/ipc/view/ExToast$a;

    const/4 v2, 0x0

    invoke-direct {v1, p0, v2}, Lcom/cyjh/mobileanjian/ipc/view/ExToast$a;-><init>(Lcom/cyjh/mobileanjian/ipc/view/ExToast;Lcom/cyjh/mobileanjian/ipc/view/ExToast$1;)V

    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->m:Lcom/cyjh/mobileanjian/ipc/view/ExToast$a;

    .line 135
    if-gez p5, :cond_2

    .line 137
    const p5, 0x7fffffff

    .line 143
    :cond_0
    :goto_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->c:Ljava/util/Timer;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->m:Lcom/cyjh/mobileanjian/ipc/view/ExToast$a;

    int-to-long v2, p5

    invoke-virtual {v0, v1, v2, v3}, Ljava/util/Timer;->schedule(Ljava/util/TimerTask;J)V

    .line 144
    return-void

    .line 128
    :cond_1
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->b:Landroid/view/WindowManager$LayoutParams;

    iput p3, v1, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 129
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->b:Landroid/view/WindowManager$LayoutParams;

    iput p4, v1, Landroid/view/WindowManager$LayoutParams;->y:I

    goto :goto_0

    .line 139
    :cond_2
    if-ltz p5, :cond_0

    if-ge p5, v0, :cond_0

    move p5, v0

    .line 141
    goto :goto_1
.end method

.method private a(Landroid/content/Context;)V
    .locals 4

    .prologue
    const/4 v1, -0x2

    .line 76
    new-instance v0, Landroid/view/WindowManager$LayoutParams;

    invoke-direct {v0}, Landroid/view/WindowManager$LayoutParams;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->b:Landroid/view/WindowManager$LayoutParams;

    .line 77
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->b:Landroid/view/WindowManager$LayoutParams;

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 78
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->b:Landroid/view/WindowManager$LayoutParams;

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->width:I

    .line 79
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->b:Landroid/view/WindowManager$LayoutParams;

    const/4 v1, -0x3

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->format:I

    .line 80
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->b:Landroid/view/WindowManager$LayoutParams;

    const v1, 0x1030004

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->windowAnimations:I

    .line 81
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x13

    if-lt v0, v1, :cond_1

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x18

    if-ge v0, v1, :cond_1

    .line 82
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->b:Landroid/view/WindowManager$LayoutParams;

    const/16 v1, 0x7d5

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->type:I

    .line 85
    :goto_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->b:Landroid/view/WindowManager$LayoutParams;

    const/16 v1, 0x98

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 89
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "config_toastDefaultGravity"

    const-string v2, "Integer"

    const-string v3, "android"

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 90
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "config_toastDefaultGravity tempResId = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->d(Ljava/lang/String;)V

    .line 91
    if-nez v0, :cond_2

    const/16 v0, 0x51

    :goto_1
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->f:I

    .line 92
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "toast_y_offset"

    const-string v2, "dimen"

    const-string v3, "android"

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 93
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "toast_y_offset tempResId = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->d(Ljava/lang/String;)V

    .line 94
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    if-nez v0, :cond_0

    sget v0, Lcom/cyjh/rootipc/R$dimen;->toast_y_offset:I

    :cond_0
    invoke-virtual {v1, v0}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->h:I

    .line 95
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->b:Landroid/view/WindowManager$LayoutParams;

    const-string v1, "Toast"

    invoke-virtual {v0, v1}, Landroid/view/WindowManager$LayoutParams;->setTitle(Ljava/lang/CharSequence;)V

    .line 96
    return-void

    .line 84
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->b:Landroid/view/WindowManager$LayoutParams;

    const/16 v1, 0x7d2

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->type:I

    goto :goto_0

    .line 91
    :cond_2
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v0

    goto :goto_1
.end method

.method public static makeText(Landroid/content/Context;II)Lcom/cyjh/mobileanjian/ipc/view/ExToast;
    .locals 1

    .prologue
    .line 71
    invoke-virtual {p0, p1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0, p2}, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Lcom/cyjh/mobileanjian/ipc/view/ExToast;

    move-result-object v0

    return-object v0
.end method

.method public static makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Lcom/cyjh/mobileanjian/ipc/view/ExToast;
    .locals 1

    .prologue
    .line 62
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;

    invoke-direct {v0, p0}, Lcom/cyjh/mobileanjian/ipc/view/ExToast;-><init>(Landroid/content/Context;)V

    .line 63
    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->setText(Ljava/lang/CharSequence;)V

    .line 64
    invoke-virtual {v0, p2}, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->setDuration(I)V

    .line 66
    return-object v0
.end method


# virtual methods
.method public declared-synchronized hide()V
    .locals 2

    .prologue
    .line 111
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->m:Lcom/cyjh/mobileanjian/ipc/view/ExToast$a;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/view/ExToast$a;->cancel()Z

    .line 112
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->d:Landroid/widget/Toast;

    invoke-virtual {v0}, Landroid/widget/Toast;->getView()Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 114
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->a:Landroid/view/WindowManager;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->d:Landroid/widget/Toast;

    invoke-virtual {v1}, Landroid/widget/Toast;->getView()Landroid/view/View;

    move-result-object v1

    invoke-interface {v0, v1}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V

    .line 116
    :cond_0
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->e:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 117
    monitor-exit p0

    return-void

    .line 111
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public setDuration(I)V
    .locals 0

    .prologue
    .line 57
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->l:I

    .line 58
    return-void
.end method

.method public setText(Ljava/lang/CharSequence;)V
    .locals 1

    .prologue
    .line 51
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->k:Ljava/lang/CharSequence;

    .line 52
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->d:Landroid/widget/Toast;

    invoke-virtual {v0, p1}, Landroid/widget/Toast;->setText(Ljava/lang/CharSequence;)V

    .line 53
    return-void
.end method

.method public show()V
    .locals 6

    .prologue
    const/4 v3, 0x0

    .line 148
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->f:I

    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->k:Ljava/lang/CharSequence;

    iget v5, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->l:I

    move-object v0, p0

    move v4, v3

    invoke-direct/range {v0 .. v5}, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->a(ILjava/lang/CharSequence;III)V

    .line 149
    return-void
.end method

.method public declared-synchronized show(Ljava/lang/CharSequence;III)V
    .locals 6

    .prologue
    const/16 v0, 0x7d0

    const/4 v1, 0x1

    .line 153
    monitor-enter p0

    :try_start_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ExToast.show(): x="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", y="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", duration="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 157
    if-gez p2, :cond_0

    :try_start_1
    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->i:I

    if-ltz v2, :cond_2

    :cond_0
    if-gez p3, :cond_1

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->j:I

    if-ltz v2, :cond_2

    :cond_1
    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->i:I

    if-ne p2, v2, :cond_5

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->j:I

    if-ne p3, v2, :cond_5

    :cond_2
    move v2, v1

    .line 158
    :goto_0
    if-ltz p2, :cond_3

    if-gez p3, :cond_6

    :cond_3
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->f:I

    .line 159
    :goto_1
    iput p2, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->i:I

    .line 160
    iput p3, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->j:I

    .line 161
    iget-boolean v3, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->e:Z

    if-eqz v3, :cond_a

    .line 163
    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->m:Lcom/cyjh/mobileanjian/ipc/view/ExToast$a;

    invoke-virtual {v3}, Lcom/cyjh/mobileanjian/ipc/view/ExToast$a;->cancel()Z

    .line 164
    if-eqz v2, :cond_8

    .line 166
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->setText(Ljava/lang/CharSequence;)V

    .line 167
    new-instance v1, Lcom/cyjh/mobileanjian/ipc/view/ExToast$a;

    const/4 v2, 0x0

    invoke-direct {v1, p0, v2}, Lcom/cyjh/mobileanjian/ipc/view/ExToast$a;-><init>(Lcom/cyjh/mobileanjian/ipc/view/ExToast;Lcom/cyjh/mobileanjian/ipc/view/ExToast$1;)V

    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->m:Lcom/cyjh/mobileanjian/ipc/view/ExToast$a;

    .line 168
    if-gez p4, :cond_7

    .line 170
    const p4, 0x7fffffff

    .line 176
    :cond_4
    :goto_2
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->c:Ljava/util/Timer;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->m:Lcom/cyjh/mobileanjian/ipc/view/ExToast$a;

    int-to-long v2, p4

    invoke-virtual {v0, v1, v2, v3}, Ljava/util/Timer;->schedule(Ljava/util/TimerTask;J)V
    :try_end_1
    .catch Ljava/lang/IllegalStateException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 198
    :goto_3
    monitor-exit p0

    return-void

    .line 157
    :cond_5
    const/4 v1, 0x0

    move v2, v1

    goto :goto_0

    .line 158
    :cond_6
    const/16 v1, 0x33

    goto :goto_1

    .line 172
    :cond_7
    if-ltz p4, :cond_4

    if-ge p4, v0, :cond_4

    move p4, v0

    .line 174
    goto :goto_2

    .line 180
    :cond_8
    :try_start_2
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->d:Landroid/widget/Toast;

    invoke-virtual {v0}, Landroid/widget/Toast;->getView()Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    if-eqz v0, :cond_9

    .line 181
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->a:Landroid/view/WindowManager;

    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->d:Landroid/widget/Toast;

    invoke-virtual {v2}, Landroid/widget/Toast;->getView()Landroid/view/View;

    move-result-object v2

    invoke-interface {v0, v2}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V

    :cond_9
    move-object v0, p0

    move-object v2, p1

    move v3, p2

    move v4, p3

    move v5, p4

    .line 183
    invoke-direct/range {v0 .. v5}, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->a(ILjava/lang/CharSequence;III)V
    :try_end_2
    .catch Ljava/lang/IllegalStateException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_3

    .line 191
    :catch_0
    move-exception v0

    .line 193
    :try_start_3
    invoke-virtual {v0}, Ljava/lang/IllegalStateException;->printStackTrace()V

    .line 194
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->a:Landroid/view/WindowManager;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->d:Landroid/widget/Toast;

    invoke-virtual {v1}, Landroid/widget/Toast;->getView()Landroid/view/View;

    move-result-object v1

    invoke-interface {v0, v1}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V

    .line 195
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->c:Ljava/util/Timer;

    invoke-virtual {v0}, Ljava/util/Timer;->cancel()V

    .line 196
    new-instance v0, Ljava/util/Timer;

    invoke-direct {v0}, Ljava/util/Timer;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->c:Ljava/util/Timer;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_3

    .line 153
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    .line 188
    :cond_a
    const/4 v0, 0x1

    :try_start_4
    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->e:Z

    move-object v0, p0

    move-object v2, p1

    move v3, p2

    move v4, p3

    move v5, p4

    .line 189
    invoke-direct/range {v0 .. v5}, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->a(ILjava/lang/CharSequence;III)V
    :try_end_4
    .catch Ljava/lang/IllegalStateException; {:try_start_4 .. :try_end_4} :catch_0
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto :goto_3
.end method
