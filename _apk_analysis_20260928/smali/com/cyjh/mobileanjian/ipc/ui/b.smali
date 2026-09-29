.class public Lcom/cyjh/mobileanjian/ipc/ui/b;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/mobileanjian/ipc/ui/b$a;
    }
.end annotation


# static fields
.field public static final a:I = 0x0

.field public static final b:I = 0x1

.field public static final c:I = 0x2

.field public static final d:I = 0x3

.field public static final e:I = 0x0

.field public static final f:I = 0x1

.field public static final g:I = 0x2

.field public static final h:I = 0x3


# instance fields
.field private i:Landroid/view/WindowManager;

.field private j:Landroid/view/WindowManager$LayoutParams;

.field private k:Landroid/view/View;

.field private l:Lcom/cyjh/mobileanjian/ipc/ui/b$a;

.field private m:I

.field private n:I

.field private o:Landroid/widget/LinearLayout;

.field private p:Landroid/widget/LinearLayout;

.field private q:Landroid/widget/Button;

.field private r:Landroid/widget/Button;

.field private s:Landroid/widget/Button;


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;IIILcom/cyjh/mobileanjian/ipc/ui/b$a;)V
    .locals 4

    .prologue
    const/16 v3, 0x8

    .line 52
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 56
    iput-object p6, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->l:Lcom/cyjh/mobileanjian/ipc/ui/b$a;

    .line 57
    const-string v0, "window"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->i:Landroid/view/WindowManager;

    .line 58
    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    sget v1, Lcom/cyjh/rootipc/R$layout;->dialog_alert:I

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->k:Landroid/view/View;

    .line 72
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->k:Landroid/view/View;

    sget v1, Lcom/cyjh/rootipc/R$id;->prompt:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 73
    invoke-direct {p0, p4, p5}, Lcom/cyjh/mobileanjian/ipc/ui/b;->a(II)V

    .line 74
    packed-switch p3, :pswitch_data_0

    .line 99
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->k:Landroid/view/View;

    sget v1, Lcom/cyjh/rootipc/R$id;->layout_type2:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    .line 100
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->k:Landroid/view/View;

    sget v1, Lcom/cyjh/rootipc/R$id;->layout_type3:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    .line 101
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->k:Landroid/view/View;

    sget v1, Lcom/cyjh/rootipc/R$id;->single_ok_button:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->q:Landroid/widget/Button;

    .line 105
    :goto_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->q:Landroid/widget/Button;

    if-eqz v0, :cond_0

    .line 107
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->q:Landroid/widget/Button;

    new-instance v1, Lcom/cyjh/mobileanjian/ipc/ui/b$1;

    invoke-direct {v1, p0, p3}, Lcom/cyjh/mobileanjian/ipc/ui/b$1;-><init>(Lcom/cyjh/mobileanjian/ipc/ui/b;I)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 118
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->r:Landroid/widget/Button;

    if-eqz v0, :cond_1

    .line 120
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->r:Landroid/widget/Button;

    new-instance v1, Lcom/cyjh/mobileanjian/ipc/ui/b$2;

    invoke-direct {v1, p0, p3}, Lcom/cyjh/mobileanjian/ipc/ui/b$2;-><init>(Lcom/cyjh/mobileanjian/ipc/ui/b;I)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 131
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->s:Landroid/widget/Button;

    if-eqz v0, :cond_2

    .line 133
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->s:Landroid/widget/Button;

    new-instance v1, Lcom/cyjh/mobileanjian/ipc/ui/b$3;

    invoke-direct {v1, p0}, Lcom/cyjh/mobileanjian/ipc/ui/b$3;-><init>(Lcom/cyjh/mobileanjian/ipc/ui/b;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 144
    :cond_2
    return-void

    .line 77
    :pswitch_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->k:Landroid/view/View;

    sget v1, Lcom/cyjh/rootipc/R$id;->single_ok_button:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    .line 78
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->k:Landroid/view/View;

    sget v1, Lcom/cyjh/rootipc/R$id;->layout_type3:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    .line 79
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->k:Landroid/view/View;

    sget v1, Lcom/cyjh/rootipc/R$id;->positive_button:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->q:Landroid/widget/Button;

    .line 80
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->k:Landroid/view/View;

    sget v1, Lcom/cyjh/rootipc/R$id;->negative_button:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->r:Landroid/widget/Button;

    goto :goto_0

    .line 83
    :pswitch_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->k:Landroid/view/View;

    sget v1, Lcom/cyjh/rootipc/R$id;->single_ok_button:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    .line 84
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->k:Landroid/view/View;

    sget v1, Lcom/cyjh/rootipc/R$id;->layout_type3:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    .line 85
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->k:Landroid/view/View;

    sget v1, Lcom/cyjh/rootipc/R$id;->positive_button:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->q:Landroid/widget/Button;

    .line 86
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->k:Landroid/view/View;

    sget v1, Lcom/cyjh/rootipc/R$id;->negative_button:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->r:Landroid/widget/Button;

    .line 87
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->q:Landroid/widget/Button;

    sget v1, Lcom/cyjh/rootipc/R$string;->dialog_yes_button:I

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(I)V

    .line 88
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->r:Landroid/widget/Button;

    sget v1, Lcom/cyjh/rootipc/R$string;->dialog_no_button:I

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(I)V

    goto/16 :goto_0

    .line 91
    :pswitch_2
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->k:Landroid/view/View;

    sget v1, Lcom/cyjh/rootipc/R$id;->single_ok_button:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    .line 92
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->k:Landroid/view/View;

    sget v1, Lcom/cyjh/rootipc/R$id;->layout_type2:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    .line 93
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->k:Landroid/view/View;

    sget v1, Lcom/cyjh/rootipc/R$id;->yes_button:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->q:Landroid/widget/Button;

    .line 94
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->k:Landroid/view/View;

    sget v1, Lcom/cyjh/rootipc/R$id;->no_button:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->r:Landroid/widget/Button;

    .line 95
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->k:Landroid/view/View;

    sget v1, Lcom/cyjh/rootipc/R$id;->cancel_button:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->s:Landroid/widget/Button;

    goto/16 :goto_0

    .line 74
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method

.method static synthetic a(Lcom/cyjh/mobileanjian/ipc/ui/b;)Lcom/cyjh/mobileanjian/ipc/ui/b$a;
    .locals 1

    .prologue
    .line 20
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->l:Lcom/cyjh/mobileanjian/ipc/ui/b$a;

    return-object v0
.end method

.method private a(II)V
    .locals 4

    .prologue
    const/4 v3, 0x0

    const/4 v2, -0x1

    .line 158
    new-instance v0, Landroid/view/WindowManager$LayoutParams;

    invoke-direct {v0}, Landroid/view/WindowManager$LayoutParams;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->j:Landroid/view/WindowManager$LayoutParams;

    .line 159
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x13

    if-lt v0, v1, :cond_0

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x18

    if-ge v0, v1, :cond_0

    .line 161
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->j:Landroid/view/WindowManager$LayoutParams;

    const/16 v1, 0x7d5

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->type:I

    .line 168
    :goto_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->j:Landroid/view/WindowManager$LayoutParams;

    const/4 v1, 0x1

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->format:I

    .line 171
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->j:Landroid/view/WindowManager$LayoutParams;

    const/16 v1, 0x10

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->gravity:I

    .line 173
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->j:Landroid/view/WindowManager$LayoutParams;

    iput v3, v0, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 174
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->j:Landroid/view/WindowManager$LayoutParams;

    iput v3, v0, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 175
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->j:Landroid/view/WindowManager$LayoutParams;

    const/high16 v1, 0x3f800000    # 1.0f

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->alpha:F

    .line 176
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->j:Landroid/view/WindowManager$LayoutParams;

    iput v2, v0, Landroid/view/WindowManager$LayoutParams;->width:I

    .line 177
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->j:Landroid/view/WindowManager$LayoutParams;

    iput v2, v0, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 178
    return-void

    .line 165
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->j:Landroid/view/WindowManager$LayoutParams;

    const/16 v1, 0x7d2

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->type:I

    goto :goto_0
.end method

.method private b()V
    .locals 2

    .prologue
    .line 153
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->i:Landroid/view/WindowManager;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->k:Landroid/view/View;

    invoke-interface {v0, v1}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V

    .line 154
    return-void
.end method

.method static synthetic b(Lcom/cyjh/mobileanjian/ipc/ui/b;)V
    .locals 0

    .prologue
    .line 20
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/ui/b;->b()V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 3

    .prologue
    .line 148
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->i:Landroid/view/WindowManager;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->k:Landroid/view/View;

    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/b;->j:Landroid/view/WindowManager$LayoutParams;

    invoke-interface {v0, v1, v2}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 149
    return-void
.end method
