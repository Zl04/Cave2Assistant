.class Lcom/cyjh/mobileanjian/ipc/ui/d;
.super Landroid/widget/LinearLayout;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/mobileanjian/ipc/ui/d$a;
    }
.end annotation


# static fields
.field private static final a:I = 0x0

.field private static final b:B = 0x26t

.field private static final c:I = 0x3

.field private static final d:I = -0xcc4a1b


# instance fields
.field private final e:I

.field private final f:Landroid/graphics/Paint;

.field private final g:I

.field private final h:Landroid/graphics/Paint;

.field private i:I

.field private j:F

.field private k:Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout$c;

.field private final l:Lcom/cyjh/mobileanjian/ipc/ui/d$a;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 47
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/cyjh/mobileanjian/ipc/ui/d;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 48
    return-void
.end method

.method constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 6

    .prologue
    const/4 v4, 0x1

    const/4 v5, 0x0

    .line 51
    invoke-direct {p0, p1, p2}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 52
    invoke-virtual {p0, v5}, Lcom/cyjh/mobileanjian/ipc/ui/d;->setWillNotDraw(Z)V

    .line 54
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/ui/d;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    .line 56
    new-instance v1, Landroid/util/TypedValue;

    invoke-direct {v1}, Landroid/util/TypedValue;-><init>()V

    .line 57
    invoke-virtual {p1}, Landroid/content/Context;->getTheme()Landroid/content/res/Resources$Theme;

    move-result-object v2

    const v3, 0x1010030

    invoke-virtual {v2, v3, v1, v4}, Landroid/content/res/Resources$Theme;->resolveAttribute(ILandroid/util/TypedValue;Z)Z

    .line 58
    iget v1, v1, Landroid/util/TypedValue;->data:I

    .line 60
    const/16 v2, 0x26

    invoke-static {v1, v2}, Lcom/cyjh/mobileanjian/ipc/ui/d;->a(IB)I

    move-result v1

    .line 63
    new-instance v2, Lcom/cyjh/mobileanjian/ipc/ui/d$a;

    const/4 v3, 0x0

    invoke-direct {v2, v3}, Lcom/cyjh/mobileanjian/ipc/ui/d$a;-><init>(Lcom/cyjh/mobileanjian/ipc/ui/d$1;)V

    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/d;->l:Lcom/cyjh/mobileanjian/ipc/ui/d$a;

    .line 64
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/d;->l:Lcom/cyjh/mobileanjian/ipc/ui/d$a;

    new-array v3, v4, [I

    const v4, -0xcc4a1b

    aput v4, v3, v5

    invoke-virtual {v2, v3}, Lcom/cyjh/mobileanjian/ipc/ui/d$a;->a([I)V

    .line 66
    const/4 v2, 0x0

    mul-float/2addr v2, v0

    float-to-int v2, v2

    iput v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/d;->e:I

    .line 67
    new-instance v2, Landroid/graphics/Paint;

    invoke-direct {v2}, Landroid/graphics/Paint;-><init>()V

    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/d;->f:Landroid/graphics/Paint;

    .line 68
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/d;->f:Landroid/graphics/Paint;

    invoke-virtual {v2, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 70
    const/high16 v1, 0x40400000    # 3.0f

    mul-float/2addr v0, v1

    float-to-int v0, v0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/d;->g:I

    .line 71
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/d;->h:Landroid/graphics/Paint;

    .line 72
    return-void
.end method

.method private static a(IB)I
    .locals 3

    .prologue
    .line 135
    invoke-static {p0}, Landroid/graphics/Color;->red(I)I

    move-result v0

    invoke-static {p0}, Landroid/graphics/Color;->green(I)I

    move-result v1

    invoke-static {p0}, Landroid/graphics/Color;->blue(I)I

    move-result v2

    invoke-static {p1, v0, v1, v2}, Landroid/graphics/Color;->argb(IIII)I

    move-result v0

    return v0
.end method

.method private static a(IIF)I
    .locals 5

    .prologue
    .line 145
    const/high16 v0, 0x3f800000    # 1.0f

    sub-float/2addr v0, p2

    .line 146
    invoke-static {p0}, Landroid/graphics/Color;->red(I)I

    move-result v1

    int-to-float v1, v1

    mul-float/2addr v1, p2

    invoke-static {p1}, Landroid/graphics/Color;->red(I)I

    move-result v2

    int-to-float v2, v2

    mul-float/2addr v2, v0

    add-float/2addr v1, v2

    .line 147
    invoke-static {p0}, Landroid/graphics/Color;->green(I)I

    move-result v2

    int-to-float v2, v2

    mul-float/2addr v2, p2

    invoke-static {p1}, Landroid/graphics/Color;->green(I)I

    move-result v3

    int-to-float v3, v3

    mul-float/2addr v3, v0

    add-float/2addr v2, v3

    .line 148
    invoke-static {p0}, Landroid/graphics/Color;->blue(I)I

    move-result v3

    int-to-float v3, v3

    mul-float/2addr v3, p2

    invoke-static {p1}, Landroid/graphics/Color;->blue(I)I

    move-result v4

    int-to-float v4, v4

    mul-float/2addr v0, v4

    add-float/2addr v0, v3

    .line 149
    float-to-int v1, v1

    float-to-int v2, v2

    float-to-int v0, v0

    invoke-static {v1, v2, v0}, Landroid/graphics/Color;->rgb(III)I

    move-result v0

    return v0
.end method


# virtual methods
.method a(IF)V
    .locals 0

    .prologue
    .line 87
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/ui/d;->i:I

    .line 88
    iput p2, p0, Lcom/cyjh/mobileanjian/ipc/ui/d;->j:F

    .line 89
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/ui/d;->invalidate()V

    .line 90
    return-void
.end method

.method a(Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout$c;)V
    .locals 0

    .prologue
    .line 75
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/ui/d;->k:Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout$c;

    .line 76
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/ui/d;->invalidate()V

    .line 77
    return-void
.end method

.method varargs a([I)V
    .locals 1

    .prologue
    .line 81
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/d;->k:Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout$c;

    .line 82
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/d;->l:Lcom/cyjh/mobileanjian/ipc/ui/d$a;

    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/ui/d$a;->a([I)V

    .line 83
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/ui/d;->invalidate()V

    .line 84
    return-void
.end method

.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 9

    .prologue
    const/high16 v8, 0x3f800000    # 1.0f

    const/4 v7, 0x0

    .line 94
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/ui/d;->getHeight()I

    move-result v6

    .line 95
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/ui/d;->getChildCount()I

    move-result v1

    .line 96
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/d;->k:Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout$c;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/d;->k:Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout$c;

    move-object v3, v0

    .line 101
    :goto_0
    if-lez v1, :cond_1

    .line 102
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/d;->i:I

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/ui/d;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    .line 103
    invoke-virtual {v0}, Landroid/view/View;->getLeft()I

    move-result v2

    .line 104
    invoke-virtual {v0}, Landroid/view/View;->getRight()I

    move-result v1

    .line 105
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/d;->i:I

    invoke-interface {v3, v0}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout$c;->a(I)I

    move-result v0

    .line 107
    iget v4, p0, Lcom/cyjh/mobileanjian/ipc/ui/d;->j:F

    cmpl-float v4, v4, v7

    if-lez v4, :cond_3

    iget v4, p0, Lcom/cyjh/mobileanjian/ipc/ui/d;->i:I

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/ui/d;->getChildCount()I

    move-result v5

    add-int/lit8 v5, v5, -0x1

    if-ge v4, v5, :cond_3

    .line 108
    iget v4, p0, Lcom/cyjh/mobileanjian/ipc/ui/d;->i:I

    add-int/lit8 v4, v4, 0x1

    invoke-interface {v3, v4}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout$c;->a(I)I

    move-result v3

    .line 109
    if-eq v0, v3, :cond_0

    .line 110
    iget v4, p0, Lcom/cyjh/mobileanjian/ipc/ui/d;->j:F

    invoke-static {v3, v0, v4}, Lcom/cyjh/mobileanjian/ipc/ui/d;->a(IIF)I

    move-result v0

    .line 114
    :cond_0
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/d;->i:I

    add-int/lit8 v3, v3, 0x1

    invoke-virtual {p0, v3}, Lcom/cyjh/mobileanjian/ipc/ui/d;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    .line 115
    iget v4, p0, Lcom/cyjh/mobileanjian/ipc/ui/d;->j:F

    invoke-virtual {v3}, Landroid/view/View;->getLeft()I

    move-result v5

    int-to-float v5, v5

    mul-float/2addr v4, v5

    iget v5, p0, Lcom/cyjh/mobileanjian/ipc/ui/d;->j:F

    sub-float v5, v8, v5

    int-to-float v2, v2

    mul-float/2addr v2, v5

    add-float/2addr v2, v4

    float-to-int v2, v2

    .line 117
    iget v4, p0, Lcom/cyjh/mobileanjian/ipc/ui/d;->j:F

    invoke-virtual {v3}, Landroid/view/View;->getRight()I

    move-result v3

    int-to-float v3, v3

    mul-float/2addr v3, v4

    iget v4, p0, Lcom/cyjh/mobileanjian/ipc/ui/d;->j:F

    sub-float v4, v8, v4

    int-to-float v1, v1

    mul-float/2addr v1, v4

    add-float/2addr v1, v3

    float-to-int v1, v1

    move v3, v1

    move v1, v2

    .line 121
    :goto_1
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/d;->h:Landroid/graphics/Paint;

    invoke-virtual {v2, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 123
    int-to-float v1, v1

    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/d;->g:I

    sub-int v0, v6, v0

    int-to-float v2, v0

    int-to-float v3, v3

    int-to-float v4, v6

    iget-object v5, p0, Lcom/cyjh/mobileanjian/ipc/ui/d;->h:Landroid/graphics/Paint;

    move-object v0, p1

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 128
    :cond_1
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/d;->e:I

    sub-int v0, v6, v0

    int-to-float v2, v0

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/ui/d;->getWidth()I

    move-result v0

    int-to-float v3, v0

    int-to-float v4, v6

    iget-object v5, p0, Lcom/cyjh/mobileanjian/ipc/ui/d;->f:Landroid/graphics/Paint;

    move-object v0, p1

    move v1, v7

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 129
    return-void

    .line 96
    :cond_2
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/d;->l:Lcom/cyjh/mobileanjian/ipc/ui/d$a;

    move-object v3, v0

    goto/16 :goto_0

    :cond_3
    move v3, v1

    move v1, v2

    goto :goto_1
.end method
