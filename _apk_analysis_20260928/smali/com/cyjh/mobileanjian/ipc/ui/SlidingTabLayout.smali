.class public Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;
.super Landroid/widget/HorizontalScrollView;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout$b;,
        Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout$a;,
        Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout$c;
    }
.end annotation


# static fields
.field private static final a:I = 0x18

.field private static final b:I = 0x4

.field private static final c:I = 0xc


# instance fields
.field private d:I

.field private e:I

.field private f:I

.field private g:Z

.field private h:Landroid/support/v4/view/ViewPager;

.field private i:Landroid/util/SparseArray;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/util/SparseArray",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private j:Landroid/support/v4/view/ViewPager$OnPageChangeListener;

.field private final k:Lcom/cyjh/mobileanjian/ipc/ui/d;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 82
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 83
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1

    .prologue
    .line 86
    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 87
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 3

    .prologue
    .line 90
    invoke-direct {p0, p1, p2, p3}, Landroid/widget/HorizontalScrollView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 76
    new-instance v0, Landroid/util/SparseArray;

    invoke-direct {v0}, Landroid/util/SparseArray;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->i:Landroid/util/SparseArray;

    .line 93
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->setHorizontalScrollBarEnabled(Z)V

    .line 95
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->setFillViewport(Z)V

    .line 97
    const/high16 v0, 0x41c00000    # 24.0f

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    iget v1, v1, Landroid/util/DisplayMetrics;->density:F

    mul-float/2addr v0, v1

    float-to-int v0, v0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->d:I

    .line 99
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/ui/d;

    invoke-direct {v0, p1}, Lcom/cyjh/mobileanjian/ipc/ui/d;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->k:Lcom/cyjh/mobileanjian/ipc/ui/d;

    .line 100
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->k:Lcom/cyjh/mobileanjian/ipc/ui/d;

    const/4 v1, -0x1

    const/4 v2, -0x2

    invoke-virtual {p0, v0, v1, v2}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->addView(Landroid/view/View;II)V

    .line 101
    return-void
.end method

.method static synthetic a(Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;)Lcom/cyjh/mobileanjian/ipc/ui/d;
    .locals 1

    .prologue
    .line 51
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->k:Lcom/cyjh/mobileanjian/ipc/ui/d;

    return-object v0
.end method

.method private a()V
    .locals 9

    .prologue
    const/4 v5, 0x0

    const/4 v3, 0x0

    .line 205
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->h:Landroid/support/v4/view/ViewPager;

    invoke-virtual {v0}, Landroid/support/v4/view/ViewPager;->getAdapter()Landroid/support/v4/view/PagerAdapter;

    move-result-object v6

    .line 206
    new-instance v7, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout$b;

    invoke-direct {v7, p0, v5}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout$b;-><init>(Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout$1;)V

    move v2, v3

    .line 208
    :goto_0
    invoke-virtual {v6}, Landroid/support/v4/view/PagerAdapter;->getCount()I

    move-result v0

    if-ge v2, v0, :cond_4

    .line 212
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->e:I

    if-eqz v0, :cond_6

    .line 214
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->e:I

    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->k:Lcom/cyjh/mobileanjian/ipc/ui/d;

    invoke-virtual {v0, v1, v4, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v1

    .line 216
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->f:I

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 219
    :goto_1
    if-nez v1, :cond_0

    .line 220
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->a(Landroid/content/Context;)Landroid/widget/TextView;

    move-result-object v1

    .line 223
    :cond_0
    if-nez v0, :cond_5

    const-class v4, Landroid/widget/TextView;

    invoke-virtual {v4, v1}, Ljava/lang/Class;->isInstance(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_5

    move-object v0, v1

    .line 224
    check-cast v0, Landroid/widget/TextView;

    move-object v4, v0

    .line 227
    :goto_2
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->g:Z

    if-eqz v0, :cond_1

    .line 228
    invoke-virtual {v1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout$LayoutParams;

    .line 229
    iput v3, v0, Landroid/widget/LinearLayout$LayoutParams;->width:I

    .line 230
    const/high16 v8, 0x3f800000    # 1.0f

    iput v8, v0, Landroid/widget/LinearLayout$LayoutParams;->weight:F

    .line 233
    :cond_1
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    sget v8, Lcom/cyjh/rootipc/R$color;->selector_tab:I

    invoke-virtual {v0, v8}, Landroid/content/res/Resources;->getColorStateList(I)Landroid/content/res/ColorStateList;

    move-result-object v0

    invoke-virtual {v4, v0}, Landroid/widget/TextView;->setTextColor(Landroid/content/res/ColorStateList;)V

    .line 234
    const/4 v0, 0x2

    const/high16 v8, 0x41600000    # 14.0f

    invoke-virtual {v4, v0, v8}, Landroid/widget/TextView;->setTextSize(IF)V

    .line 235
    invoke-virtual {v6, v2}, Landroid/support/v4/view/PagerAdapter;->getPageTitle(I)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-virtual {v4, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 236
    invoke-virtual {v4, v3}, Landroid/widget/TextView;->setAllCaps(Z)V

    .line 237
    invoke-virtual {v1, v7}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 238
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->i:Landroid/util/SparseArray;

    invoke-virtual {v0, v2, v5}, Landroid/util/SparseArray;->get(ILjava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 239
    if-eqz v0, :cond_2

    .line 240
    invoke-virtual {v1, v0}, Landroid/view/View;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 243
    :cond_2
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->k:Lcom/cyjh/mobileanjian/ipc/ui/d;

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/d;->addView(Landroid/view/View;)V

    .line 244
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->h:Landroid/support/v4/view/ViewPager;

    invoke-virtual {v0}, Landroid/support/v4/view/ViewPager;->getCurrentItem()I

    move-result v0

    if-ne v2, v0, :cond_3

    .line 245
    const/4 v0, 0x1

    invoke-virtual {v1, v0}, Landroid/view/View;->setSelected(Z)V

    .line 208
    :cond_3
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto/16 :goto_0

    .line 248
    :cond_4
    return-void

    :cond_5
    move-object v4, v0

    goto :goto_2

    :cond_6
    move-object v0, v5

    move-object v1, v5

    goto :goto_1
.end method

.method static synthetic a(Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;II)V
    .locals 0

    .prologue
    .line 51
    invoke-direct {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->b(II)V

    return-void
.end method

.method static synthetic b(Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;)Landroid/support/v4/view/ViewPager$OnPageChangeListener;
    .locals 1

    .prologue
    .line 51
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->j:Landroid/support/v4/view/ViewPager$OnPageChangeListener;

    return-object v0
.end method

.method private b(II)V
    .locals 2

    .prologue
    .line 264
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->k:Lcom/cyjh/mobileanjian/ipc/ui/d;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/ui/d;->getChildCount()I

    move-result v0

    .line 265
    if-eqz v0, :cond_0

    if-ltz p1, :cond_0

    if-lt p1, v0, :cond_1

    .line 280
    :cond_0
    :goto_0
    return-void

    .line 269
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->k:Lcom/cyjh/mobileanjian/ipc/ui/d;

    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/ui/d;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    .line 270
    if-eqz v0, :cond_0

    .line 271
    invoke-virtual {v0}, Landroid/view/View;->getLeft()I

    move-result v0

    add-int/2addr v0, p2

    .line 273
    if-gtz p1, :cond_2

    if-lez p2, :cond_3

    .line 275
    :cond_2
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->d:I

    sub-int/2addr v0, v1

    .line 278
    :cond_3
    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->scrollTo(II)V

    goto :goto_0
.end method

.method static synthetic c(Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;)Landroid/support/v4/view/ViewPager;
    .locals 1

    .prologue
    .line 51
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->h:Landroid/support/v4/view/ViewPager;

    return-object v0
.end method


# virtual methods
.method protected a(Landroid/content/Context;)Landroid/widget/TextView;
    .locals 5

    .prologue
    const/4 v3, -0x2

    const/4 v4, 0x1

    .line 185
    new-instance v0, Landroid/widget/TextView;

    invoke-direct {v0, p1}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 186
    const/16 v1, 0x11

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setGravity(I)V

    .line 187
    const/4 v1, 0x2

    const/high16 v2, 0x41400000    # 12.0f

    invoke-virtual {v0, v1, v2}, Landroid/widget/TextView;->setTextSize(IF)V

    .line 189
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v1, v3, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 192
    new-instance v1, Landroid/util/TypedValue;

    invoke-direct {v1}, Landroid/util/TypedValue;-><init>()V

    .line 193
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getTheme()Landroid/content/res/Resources$Theme;

    move-result-object v2

    const v3, 0x101030e

    invoke-virtual {v2, v3, v1, v4}, Landroid/content/res/Resources$Theme;->resolveAttribute(ILandroid/util/TypedValue;Z)Z

    .line 195
    iget v1, v1, Landroid/util/TypedValue;->resourceId:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setBackgroundResource(I)V

    .line 196
    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setAllCaps(Z)V

    .line 198
    const/high16 v1, 0x40800000    # 4.0f

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v2

    iget v2, v2, Landroid/util/DisplayMetrics;->density:F

    mul-float/2addr v1, v2

    float-to-int v1, v1

    .line 199
    invoke-virtual {v0, v1, v1, v1, v1}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 200
    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setSingleLine(Z)V

    .line 201
    return-object v0
.end method

.method public a(II)V
    .locals 0

    .prologue
    .line 144
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->e:I

    .line 145
    iput p2, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->f:I

    .line 146
    return-void
.end method

.method public a(ILjava/lang/String;)V
    .locals 1

    .prologue
    .line 251
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->i:Landroid/util/SparseArray;

    invoke-virtual {v0, p1, p2}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    .line 252
    return-void
.end method

.method public a(Landroid/widget/LinearLayout;Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 174
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->h:Landroid/support/v4/view/ViewPager;

    invoke-virtual {v0}, Landroid/support/v4/view/ViewPager;->getAdapter()Landroid/support/v4/view/PagerAdapter;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/ui/j;

    .line 175
    invoke-virtual {v0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/ui/j;->a(Landroid/widget/LinearLayout;Ljava/lang/String;)V

    .line 176
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->h:Landroid/support/v4/view/ViewPager;

    invoke-virtual {v1, v0}, Landroid/support/v4/view/ViewPager;->setAdapter(Landroid/support/v4/view/PagerAdapter;)V

    .line 177
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->h:Landroid/support/v4/view/ViewPager;

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->setViewPager(Landroid/support/v4/view/ViewPager;)V

    .line 178
    return-void
.end method

.method public getViewPager()Landroid/support/v4/view/ViewPager;
    .locals 1

    .prologue
    .line 164
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->h:Landroid/support/v4/view/ViewPager;

    return-object v0
.end method

.method protected onAttachedToWindow()V
    .locals 2

    .prologue
    .line 256
    invoke-super {p0}, Landroid/widget/HorizontalScrollView;->onAttachedToWindow()V

    .line 258
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->h:Landroid/support/v4/view/ViewPager;

    if-eqz v0, :cond_0

    .line 259
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->h:Landroid/support/v4/view/ViewPager;

    invoke-virtual {v0}, Landroid/support/v4/view/ViewPager;->getCurrentItem()I

    move-result v0

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->b(II)V

    .line 261
    :cond_0
    return-void
.end method

.method public setCustomTabColorizer(Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout$c;)V
    .locals 1

    .prologue
    .line 111
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->k:Lcom/cyjh/mobileanjian/ipc/ui/d;

    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/ui/d;->a(Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout$c;)V

    .line 112
    return-void
.end method

.method public setDistributeEvenly(Z)V
    .locals 0

    .prologue
    .line 115
    iput-boolean p1, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->g:Z

    .line 116
    return-void
.end method

.method public setOnPageChangeListener(Landroid/support/v4/view/ViewPager$OnPageChangeListener;)V
    .locals 0

    .prologue
    .line 134
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->j:Landroid/support/v4/view/ViewPager$OnPageChangeListener;

    .line 135
    return-void
.end method

.method public varargs setSelectedIndicatorColors([I)V
    .locals 1

    .prologue
    .line 123
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->k:Lcom/cyjh/mobileanjian/ipc/ui/d;

    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/ui/d;->a([I)V

    .line 124
    return-void
.end method

.method public setViewPager(Landroid/support/v4/view/ViewPager;)V
    .locals 2

    .prologue
    .line 153
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->k:Lcom/cyjh/mobileanjian/ipc/ui/d;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/ui/d;->removeAllViews()V

    .line 155
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->h:Landroid/support/v4/view/ViewPager;

    .line 156
    if-eqz p1, :cond_0

    .line 157
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout$a;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout$a;-><init>(Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout$1;)V

    invoke-virtual {p1, v0}, Landroid/support/v4/view/ViewPager;->setOnPageChangeListener(Landroid/support/v4/view/ViewPager$OnPageChangeListener;)V

    .line 158
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->a()V

    .line 160
    :cond_0
    return-void
.end method
