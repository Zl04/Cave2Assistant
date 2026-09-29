.class public Lcom/cyjh/mobileanjian/ipc/ui/i;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static final a:I = 0x1000

.field private static final b:Ljava/lang/String; = "first_row_tag"

.field private static final c:Ljava/lang/String; = "row_mark"

.field private static final v:I = 0x100

.field private static x:I


# instance fields
.field private d:Landroid/view/WindowManager;

.field private e:Landroid/view/WindowManager$LayoutParams;

.field private f:Lcom/cyjh/mobileanjian/ipc/view/ExToast;

.field private g:Landroid/content/Context;

.field private h:Landroid/widget/LinearLayout;

.field private i:Landroid/view/View$OnClickListener;

.field private j:Landroid/view/View$OnClickListener;

.field private k:Ljava/lang/String;

.field private l:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private m:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private n:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private o:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private p:Lcom/cyjh/mobileanjian/ipc/ui/g;

.field private q:Landroid/widget/LinearLayout;

.field private r:Landroid/widget/LinearLayout;

.field private s:Landroid/widget/TextView;

.field private t:Z

.field private u:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;",
            ">;"
        }
    .end annotation
.end field

.field private w:Landroid/os/Handler;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 355
    const/4 v0, 0x0

    sput v0, Lcom/cyjh/mobileanjian/ipc/ui/i;->x:I

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;II)V
    .locals 6

    .prologue
    .line 75
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 54
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->k:Ljava/lang/String;

    .line 57
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->l:Ljava/util/Set;

    .line 58
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->m:Ljava/util/Set;

    .line 61
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->n:Ljava/util/HashMap;

    .line 62
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->o:Ljava/util/HashMap;

    .line 70
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->t:Z

    .line 72
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->u:Ljava/util/ArrayList;

    .line 229
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/ui/i$3;

    invoke-direct {v0, p0}, Lcom/cyjh/mobileanjian/ipc/ui/i$3;-><init>(Lcom/cyjh/mobileanjian/ipc/ui/i;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->w:Landroid/os/Handler;

    .line 76
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->g:Landroid/content/Context;

    .line 77
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/ui/g;->a(Landroid/content/Context;)Lcom/cyjh/mobileanjian/ipc/ui/g;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->p:Lcom/cyjh/mobileanjian/ipc/ui/g;

    .line 78
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/ui/i;->g()V

    .line 79
    invoke-direct {p0, p3, p4}, Lcom/cyjh/mobileanjian/ipc/ui/i;->a(II)V

    .line 81
    invoke-direct {p0, p2}, Lcom/cyjh/mobileanjian/ipc/ui/i;->c(Ljava/lang/String;)V

    .line 82
    const/16 v1, 0x1000

    const-string v2, "row_mark"

    const/4 v4, -0x1

    const/4 v5, -0x2

    move-object v0, p0

    move-object v3, p2

    invoke-virtual/range {v0 .. v5}, Lcom/cyjh/mobileanjian/ipc/ui/i;->a(ILjava/lang/String;Ljava/lang/String;II)V

    .line 89
    return-void
.end method

.method static synthetic a(Lcom/cyjh/mobileanjian/ipc/ui/i;)Landroid/view/View$OnClickListener;
    .locals 1

    .prologue
    .line 38
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->i:Landroid/view/View$OnClickListener;

    return-object v0
.end method

.method private a(II)V
    .locals 7

    .prologue
    const/4 v6, 0x0

    const/16 v5, 0x28

    const/4 v0, -0x2

    const/16 v4, 0xc8

    .line 152
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->g:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    .line 153
    invoke-direct {p0, v5}, Lcom/cyjh/mobileanjian/ipc/ui/i;->c(I)I

    move-result v2

    add-int/2addr v2, p1

    iget v3, v1, Landroid/util/DisplayMetrics;->widthPixels:I

    if-lt v2, v3, :cond_2

    .line 155
    const/4 p1, -0x1

    .line 162
    :cond_0
    :goto_0
    invoke-direct {p0, v5}, Lcom/cyjh/mobileanjian/ipc/ui/i;->c(I)I

    move-result v2

    add-int/2addr v2, p2

    iget v1, v1, Landroid/util/DisplayMetrics;->heightPixels:I

    if-lt v2, v1, :cond_4

    move p2, v0

    .line 171
    :cond_1
    :goto_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->g:Landroid/content/Context;

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v1

    .line 172
    sget v0, Lcom/cyjh/rootipc/R$layout;->layout_ui_show:I

    invoke-virtual {v1, v0, v6}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->r:Landroid/widget/LinearLayout;

    .line 174
    sget v0, Lcom/cyjh/rootipc/R$layout;->layout_display:I

    invoke-virtual {v1, v0, v6}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    .line 175
    new-instance v1, Landroid/widget/RelativeLayout$LayoutParams;

    invoke-direct {v1, p1, p2}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 176
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 177
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->r:Landroid/widget/LinearLayout;

    const/16 v2, 0x11

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 178
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->r:Landroid/widget/LinearLayout;

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 180
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->r:Landroid/widget/LinearLayout;

    sget v1, Lcom/cyjh/rootipc/R$id;->title:I

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->s:Landroid/widget/TextView;

    .line 181
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->r:Landroid/widget/LinearLayout;

    sget v1, Lcom/cyjh/rootipc/R$id;->layout_user:I

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->h:Landroid/widget/LinearLayout;

    .line 183
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->r:Landroid/widget/LinearLayout;

    sget v1, Lcom/cyjh/rootipc/R$id;->exit:I

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->findViewById(I)Landroid/view/View;

    move-result-object v0

    new-instance v1, Lcom/cyjh/mobileanjian/ipc/ui/i$1;

    invoke-direct {v1, p0}, Lcom/cyjh/mobileanjian/ipc/ui/i$1;-><init>(Lcom/cyjh/mobileanjian/ipc/ui/i;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 193
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->r:Landroid/widget/LinearLayout;

    sget v1, Lcom/cyjh/rootipc/R$id;->next:I

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->findViewById(I)Landroid/view/View;

    move-result-object v0

    new-instance v1, Lcom/cyjh/mobileanjian/ipc/ui/i$2;

    invoke-direct {v1, p0}, Lcom/cyjh/mobileanjian/ipc/ui/i$2;-><init>(Lcom/cyjh/mobileanjian/ipc/ui/i;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 202
    return-void

    .line 157
    :cond_2
    if-lt p1, v0, :cond_3

    if-ltz p1, :cond_0

    invoke-direct {p0, v4}, Lcom/cyjh/mobileanjian/ipc/ui/i;->c(I)I

    move-result v2

    if-ge p1, v2, :cond_0

    .line 159
    :cond_3
    invoke-direct {p0, v4}, Lcom/cyjh/mobileanjian/ipc/ui/i;->c(I)I

    move-result p1

    goto :goto_0

    .line 166
    :cond_4
    if-lt p2, v0, :cond_5

    if-ltz p2, :cond_1

    invoke-direct {p0, v4}, Lcom/cyjh/mobileanjian/ipc/ui/i;->c(I)I

    move-result v0

    if-ge p2, v0, :cond_1

    .line 168
    :cond_5
    invoke-direct {p0, v4}, Lcom/cyjh/mobileanjian/ipc/ui/i;->c(I)I

    move-result p2

    goto/16 :goto_1
.end method

.method static synthetic b(Lcom/cyjh/mobileanjian/ipc/ui/i;)Landroid/view/View$OnClickListener;
    .locals 1

    .prologue
    .line 38
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->j:Landroid/view/View$OnClickListener;

    return-object v0
.end method

.method private c(I)I
    .locals 3

    .prologue
    .line 267
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->g:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    .line 268
    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    .line 269
    int-to-float v1, p1

    iget v0, v0, Landroid/util/DisplayMetrics;->densityDpi:I

    int-to-float v0, v0

    const/high16 v2, 0x43200000    # 160.0f

    div-float/2addr v0, v2

    mul-float/2addr v0, v1

    .line 270
    float-to-int v0, v0

    return v0
.end method

.method static synthetic c(Lcom/cyjh/mobileanjian/ipc/ui/i;)Landroid/widget/LinearLayout;
    .locals 1

    .prologue
    .line 38
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->h:Landroid/widget/LinearLayout;

    return-object v0
.end method

.method private c(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 129
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->k:Ljava/lang/String;

    .line 130
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/ui/i;->a(Ljava/lang/String;)V

    .line 131
    return-void
.end method

.method private g()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    const/4 v2, -0x1

    .line 206
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->g:Landroid/content/Context;

    const-string v1, "window"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->d:Landroid/view/WindowManager;

    .line 207
    new-instance v0, Landroid/view/WindowManager$LayoutParams;

    invoke-direct {v0}, Landroid/view/WindowManager$LayoutParams;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->e:Landroid/view/WindowManager$LayoutParams;

    .line 209
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x13

    if-lt v0, v1, :cond_0

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x18

    if-ge v0, v1, :cond_0

    .line 210
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->e:Landroid/view/WindowManager$LayoutParams;

    const/16 v1, 0x7d5

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->type:I

    .line 215
    :goto_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->e:Landroid/view/WindowManager$LayoutParams;

    const/4 v1, 0x1

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->format:I

    .line 218
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->e:Landroid/view/WindowManager$LayoutParams;

    const/16 v1, 0x10

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->gravity:I

    .line 220
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->e:Landroid/view/WindowManager$LayoutParams;

    iput v3, v0, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 221
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->e:Landroid/view/WindowManager$LayoutParams;

    iput v3, v0, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 222
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->e:Landroid/view/WindowManager$LayoutParams;

    const/high16 v1, 0x3f800000    # 1.0f

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->alpha:F

    .line 223
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->e:Landroid/view/WindowManager$LayoutParams;

    iput v2, v0, Landroid/view/WindowManager$LayoutParams;->width:I

    .line 224
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->e:Landroid/view/WindowManager$LayoutParams;

    iput v2, v0, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 225
    return-void

    .line 212
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->e:Landroid/view/WindowManager$LayoutParams;

    const/16 v1, 0x7d2

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->type:I

    goto :goto_0
.end method

.method private static h()Ljava/lang/String;
    .locals 3

    .prologue
    .line 358
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "first_row_"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget v1, Lcom/cyjh/mobileanjian/ipc/ui/i;->x:I

    add-int/lit8 v2, v1, 0x1

    sput v2, Lcom/cyjh/mobileanjian/ipc/ui/i;->x:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public a()Ljava/lang/String;
    .locals 1

    .prologue
    .line 104
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->s:Landroid/widget/TextView;

    invoke-virtual {v0}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public a(I)V
    .locals 1

    .prologue
    .line 109
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->s:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 110
    return-void
.end method

.method public a(ILjava/lang/String;Ljava/lang/String;II)V
    .locals 2

    .prologue
    .line 275
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 277
    const-string v0, "===== HERE NEW ROW"

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->d(Ljava/lang/String;)V

    .line 279
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->p:Lcom/cyjh/mobileanjian/ipc/ui/g;

    const-string v1, "row_mark"

    invoke-virtual {v0, p1, v1, p4, p5}, Lcom/cyjh/mobileanjian/ipc/ui/g;->b(ILjava/lang/String;II)Landroid/widget/LinearLayout;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->q:Landroid/widget/LinearLayout;

    .line 280
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->h:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->q:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 281
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->n:Ljava/util/HashMap;

    invoke-virtual {v0, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 290
    :cond_0
    :goto_0
    return-void

    .line 283
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->l:Ljava/util/Set;

    invoke-interface {v0, p3}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 285
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->h:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->o:Ljava/util/HashMap;

    invoke-virtual {v1, p3}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;

    .line 286
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->getViewPager()Landroid/support/v4/view/ViewPager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/view/ViewPager;->getAdapter()Landroid/support/v4/view/PagerAdapter;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/ui/j;

    .line 287
    invoke-virtual {v0, p2, p3, p4, p5}, Lcom/cyjh/mobileanjian/ipc/ui/j;->a(Ljava/lang/String;Ljava/lang/String;II)V

    .line 288
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->n:Ljava/util/HashMap;

    invoke-virtual {v0, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0
.end method

.method public a(Landroid/graphics/Typeface;I)V
    .locals 3

    .prologue
    .line 93
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->s:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 94
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->s:Landroid/widget/TextView;

    const/4 v1, 0x2

    int-to-float v2, p2

    invoke-virtual {v0, v1, v2}, Landroid/widget/TextView;->setTextSize(IF)V

    .line 95
    return-void
.end method

.method public a(Landroid/view/View$OnClickListener;)V
    .locals 0

    .prologue
    .line 386
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->i:Landroid/view/View$OnClickListener;

    .line 387
    return-void
.end method

.method public a(Landroid/view/View;Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 294
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "parentTag = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->d(Ljava/lang/String;)V

    .line 295
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "row tag: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->n:Ljava/util/HashMap;

    invoke-virtual {v0, p2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->d(Ljava/lang/String;)V

    .line 296
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->k:Ljava/lang/String;

    invoke-virtual {p2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 298
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->q:Landroid/widget/LinearLayout;

    invoke-virtual {v0, p1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 308
    :cond_0
    :goto_0
    return-void

    .line 302
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->l:Ljava/util/Set;

    invoke-interface {v0, p2}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 304
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->h:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->o:Ljava/util/HashMap;

    invoke-virtual {v1, p2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;

    .line 305
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->getViewPager()Landroid/support/v4/view/ViewPager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/view/ViewPager;->getAdapter()Landroid/support/v4/view/PagerAdapter;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/ui/j;

    .line 306
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->n:Ljava/util/HashMap;

    invoke-virtual {v1, p2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-virtual {v0, p1, p2, v1}, Lcom/cyjh/mobileanjian/ipc/ui/j;->a(Landroid/view/View;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public a(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 99
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->s:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 100
    return-void
.end method

.method public a(Ljava/lang/String;II)V
    .locals 6

    .prologue
    const/4 v3, 0x1

    .line 312
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->m:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 313
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->g:Landroid/content/Context;

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    sget v1, Lcom/cyjh/rootipc/R$layout;->ui_show_sliding_layout:I

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    .line 315
    sget v1, Lcom/cyjh/rootipc/R$id;->slidingTabLayout:I

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;

    .line 316
    invoke-virtual {v1, p1}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->setTag(Ljava/lang/Object;)V

    .line 317
    invoke-virtual {v1, v3}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->setDistributeEvenly(Z)V

    .line 318
    new-array v2, v3, [I

    const/4 v3, 0x0

    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->g:Landroid/content/Context;

    invoke-virtual {v4}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    sget v5, Lcom/cyjh/rootipc/R$color;->ui_show_blue:I

    invoke-virtual {v4, v5}, Landroid/content/res/Resources;->getColor(I)I

    move-result v4

    aput v4, v2, v3

    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->setSelectedIndicatorColors([I)V

    .line 319
    sget v2, Lcom/cyjh/rootipc/R$drawable;->bg_tab_host:I

    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->setBackgroundResource(I)V

    .line 320
    new-instance v2, Lcom/cyjh/mobileanjian/ipc/ui/i$4;

    invoke-direct {v2, p0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/i$4;-><init>(Lcom/cyjh/mobileanjian/ipc/ui/i;Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;)V

    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->setOnPageChangeListener(Landroid/support/v4/view/ViewPager$OnPageChangeListener;)V

    .line 343
    const/4 v2, -0x2

    if-ne p3, v2, :cond_0

    .line 344
    const/16 v2, 0xc8

    invoke-direct {p0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/i;->c(I)I

    move-result p3

    .line 345
    :cond_0
    sget v2, Lcom/cyjh/rootipc/R$id;->viewPager:I

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/support/v4/view/ViewPager;

    .line 346
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v4, -0x1

    invoke-direct {v3, v4, p3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v2, v3}, Landroid/support/v4/view/ViewPager;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 347
    new-instance v3, Lcom/cyjh/mobileanjian/ipc/ui/j;

    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    invoke-direct {v3, v4, v5}, Lcom/cyjh/mobileanjian/ipc/ui/j;-><init>(Ljava/util/List;Ljava/util/List;)V

    .line 348
    invoke-virtual {v2, v3}, Landroid/support/v4/view/ViewPager;->setAdapter(Landroid/support/v4/view/PagerAdapter;)V

    .line 349
    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->setViewPager(Landroid/support/v4/view/ViewPager;)V

    .line 350
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->h:Landroid/widget/LinearLayout;

    invoke-virtual {v2, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 352
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->u:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 353
    return-void
.end method

.method public a(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z
    .locals 7

    .prologue
    const/4 v1, 0x0

    .line 362
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->m:Ljava/util/Set;

    invoke-interface {v0, p3}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    move v0, v1

    .line 381
    :goto_0
    return v0

    .line 365
    :cond_0
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/ui/i;->h()Ljava/lang/String;

    move-result-object v2

    .line 367
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->l:Ljava/util/Set;

    invoke-interface {v0, p2}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 368
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->n:Ljava/util/HashMap;

    invoke-virtual {v0, p2, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 369
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->o:Ljava/util/HashMap;

    invoke-virtual {v0, p2, p3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 371
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->h:Landroid/widget/LinearLayout;

    invoke-virtual {v0, p3}, Landroid/widget/LinearLayout;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;

    .line 372
    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->p:Lcom/cyjh/mobileanjian/ipc/ui/g;

    invoke-virtual {v3, p1, p2}, Lcom/cyjh/mobileanjian/ipc/ui/g;->a(ILjava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v3

    .line 373
    invoke-virtual {v3, p1}, Landroid/widget/LinearLayout;->setId(I)V

    .line 376
    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->p:Lcom/cyjh/mobileanjian/ipc/ui/g;

    const/4 v5, -0x1

    const/4 v6, -0x2

    invoke-virtual {v4, v1, v2, v5, v6}, Lcom/cyjh/mobileanjian/ipc/ui/g;->b(ILjava/lang/String;II)Landroid/widget/LinearLayout;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->q:Landroid/widget/LinearLayout;

    .line 378
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->q:Landroid/widget/LinearLayout;

    invoke-virtual {v3, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 379
    invoke-virtual {v0, v3, p4}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->a(Landroid/widget/LinearLayout;Ljava/lang/String;)V

    .line 381
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public b(Ljava/lang/String;)Landroid/view/View;
    .locals 3

    .prologue
    .line 135
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->h:Landroid/widget/LinearLayout;

    invoke-virtual {v0, p1}, Landroid/widget/LinearLayout;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    .line 136
    if-nez v0, :cond_1

    .line 138
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->u:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;

    .line 140
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->getViewPager()Landroid/support/v4/view/ViewPager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/view/ViewPager;->getAdapter()Landroid/support/v4/view/PagerAdapter;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/ui/j;

    .line 141
    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/ui/j;->a(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    .line 142
    if-eqz v0, :cond_0

    .line 146
    :cond_1
    return-object v0
.end method

.method public b()Ljava/lang/String;
    .locals 1

    .prologue
    .line 124
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->k:Ljava/lang/String;

    return-object v0
.end method

.method public b(I)V
    .locals 6

    .prologue
    const/4 v5, 0x0

    const/4 v4, 0x4

    .line 114
    new-instance v0, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    .line 115
    invoke-virtual {v0, p1}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    .line 118
    const/16 v1, 0x8

    new-array v1, v1, [F

    const/4 v2, 0x0

    invoke-direct {p0, v4}, Lcom/cyjh/mobileanjian/ipc/ui/i;->c(I)I

    move-result v3

    int-to-float v3, v3

    aput v3, v1, v2

    const/4 v2, 0x1

    invoke-direct {p0, v4}, Lcom/cyjh/mobileanjian/ipc/ui/i;->c(I)I

    move-result v3

    int-to-float v3, v3

    aput v3, v1, v2

    const/4 v2, 0x2

    invoke-direct {p0, v4}, Lcom/cyjh/mobileanjian/ipc/ui/i;->c(I)I

    move-result v3

    int-to-float v3, v3

    aput v3, v1, v2

    const/4 v2, 0x3

    invoke-direct {p0, v4}, Lcom/cyjh/mobileanjian/ipc/ui/i;->c(I)I

    move-result v3

    int-to-float v3, v3

    aput v3, v1, v2

    aput v5, v1, v4

    const/4 v2, 0x5

    aput v5, v1, v2

    const/4 v2, 0x6

    aput v5, v1, v2

    const/4 v2, 0x7

    aput v5, v1, v2

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadii([F)V

    .line 119
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->s:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 120
    return-void
.end method

.method public b(Landroid/view/View$OnClickListener;)V
    .locals 0

    .prologue
    .line 391
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->j:Landroid/view/View$OnClickListener;

    .line 392
    return-void
.end method

.method public c()V
    .locals 4

    .prologue
    .line 245
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->w:Landroid/os/Handler;

    const/16 v1, 0x100

    const-wide/16 v2, 0xa

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->sendEmptyMessageDelayed(IJ)Z

    .line 246
    return-void
.end method

.method public d()V
    .locals 3

    .prologue
    .line 250
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->t:Z

    .line 251
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->d:Landroid/view/WindowManager;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->r:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->e:Landroid/view/WindowManager$LayoutParams;

    invoke-interface {v0, v1, v2}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 252
    return-void
.end method

.method public e()Z
    .locals 1

    .prologue
    .line 256
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->t:Z

    return v0
.end method

.method public f()V
    .locals 2

    .prologue
    .line 261
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->t:Z

    .line 262
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->d:Landroid/view/WindowManager;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/i;->r:Landroid/widget/LinearLayout;

    invoke-interface {v0, v1}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V

    .line 263
    return-void
.end method
