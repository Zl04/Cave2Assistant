.class public Lcom/cyjh/mobileanjian/ipc/ui/c;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/mobileanjian/ipc/ui/c$a;
    }
.end annotation


# instance fields
.field private a:Landroid/view/View;

.field private b:Landroid/widget/EditText;

.field private c:Lcom/cyjh/mobileanjian/ipc/ui/c$a;

.field private d:Landroid/view/WindowManager;

.field private e:Landroid/view/WindowManager$LayoutParams;


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;IILcom/cyjh/mobileanjian/ipc/ui/c$a;)V
    .locals 3

    .prologue
    .line 34
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 35
    iput-object p5, p0, Lcom/cyjh/mobileanjian/ipc/ui/c;->c:Lcom/cyjh/mobileanjian/ipc/ui/c$a;

    .line 36
    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    sget v1, Lcom/cyjh/rootipc/R$layout;->dialog_input:I

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/c;->a:Landroid/view/View;

    .line 37
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/c;->a:Landroid/view/View;

    sget v1, Lcom/cyjh/rootipc/R$id;->prompt:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 38
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/c;->a:Landroid/view/View;

    sget v1, Lcom/cyjh/rootipc/R$id;->et_input:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/c;->b:Landroid/widget/EditText;

    .line 40
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/c;->a:Landroid/view/View;

    sget v1, Lcom/cyjh/rootipc/R$id;->single_ok_button:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    new-instance v1, Lcom/cyjh/mobileanjian/ipc/ui/c$1;

    invoke-direct {v1, p0}, Lcom/cyjh/mobileanjian/ipc/ui/c$1;-><init>(Lcom/cyjh/mobileanjian/ipc/ui/c;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 50
    const-string v0, "window"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/c;->d:Landroid/view/WindowManager;

    .line 51
    invoke-direct {p0, p3, p4}, Lcom/cyjh/mobileanjian/ipc/ui/c;->a(II)V

    .line 52
    return-void
.end method

.method static synthetic a(Lcom/cyjh/mobileanjian/ipc/ui/c;)Lcom/cyjh/mobileanjian/ipc/ui/c$a;
    .locals 1

    .prologue
    .line 19
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/c;->c:Lcom/cyjh/mobileanjian/ipc/ui/c$a;

    return-object v0
.end method

.method private a(II)V
    .locals 4

    .prologue
    const/4 v3, 0x0

    const/4 v2, -0x1

    .line 66
    new-instance v0, Landroid/view/WindowManager$LayoutParams;

    invoke-direct {v0}, Landroid/view/WindowManager$LayoutParams;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/c;->e:Landroid/view/WindowManager$LayoutParams;

    .line 67
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x13

    if-lt v0, v1, :cond_0

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x18

    if-ge v0, v1, :cond_0

    .line 68
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/c;->e:Landroid/view/WindowManager$LayoutParams;

    const/16 v1, 0x7d5

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->type:I

    .line 73
    :goto_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/c;->e:Landroid/view/WindowManager$LayoutParams;

    const/4 v1, 0x1

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->format:I

    .line 76
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/c;->e:Landroid/view/WindowManager$LayoutParams;

    const/16 v1, 0x11

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->gravity:I

    .line 78
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/c;->e:Landroid/view/WindowManager$LayoutParams;

    iput v3, v0, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 79
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/c;->e:Landroid/view/WindowManager$LayoutParams;

    iput v3, v0, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 80
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/c;->e:Landroid/view/WindowManager$LayoutParams;

    const/high16 v1, 0x3f800000    # 1.0f

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->alpha:F

    .line 81
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/c;->e:Landroid/view/WindowManager$LayoutParams;

    iput v2, v0, Landroid/view/WindowManager$LayoutParams;->width:I

    .line 82
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/c;->e:Landroid/view/WindowManager$LayoutParams;

    iput v2, v0, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 83
    return-void

    .line 70
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/c;->e:Landroid/view/WindowManager$LayoutParams;

    const/16 v1, 0x7d2

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->type:I

    goto :goto_0
.end method

.method static synthetic b(Lcom/cyjh/mobileanjian/ipc/ui/c;)Landroid/widget/EditText;
    .locals 1

    .prologue
    .line 19
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/c;->b:Landroid/widget/EditText;

    return-object v0
.end method

.method private b()V
    .locals 2

    .prologue
    .line 61
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/c;->d:Landroid/view/WindowManager;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/c;->a:Landroid/view/View;

    invoke-interface {v0, v1}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V

    .line 62
    return-void
.end method

.method static synthetic c(Lcom/cyjh/mobileanjian/ipc/ui/c;)V
    .locals 0

    .prologue
    .line 19
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/ui/c;->b()V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 3

    .prologue
    .line 56
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/c;->d:Landroid/view/WindowManager;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/c;->a:Landroid/view/View;

    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/c;->e:Landroid/view/WindowManager$LayoutParams;

    invoke-interface {v0, v1, v2}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 57
    return-void
.end method
