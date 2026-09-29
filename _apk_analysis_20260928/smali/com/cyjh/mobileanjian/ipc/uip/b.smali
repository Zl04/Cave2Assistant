.class public Lcom/cyjh/mobileanjian/ipc/uip/b;
.super Landroid/widget/LinearLayout;
.source "SourceFile"

# interfaces
.implements Landroid/widget/RadioGroup$OnCheckedChangeListener;


# static fields
.field private static final a:I = 0x7

.field private static final b:[I


# instance fields
.field private c:Landroid/widget/RadioGroup;

.field private d:Landroid/widget/FrameLayout;

.field private e:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Landroid/widget/ScrollView;",
            ">;"
        }
    .end annotation
.end field

.field private f:I

.field private g:Landroid/widget/LinearLayout;

.field private h:Landroid/widget/ScrollView;

.field private i:I

.field private j:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 31
    const/4 v0, 0x7

    new-array v0, v0, [I

    fill-array-data v0, :array_0

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/uip/b;->b:[I

    return-void

    nop

    :array_0
    .array-data 4
        0x0
        0x1
        0x2
        0x3
        0x4
        0x5
        0x6
    .end array-data
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 45
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/cyjh/mobileanjian/ipc/uip/b;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 46
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1

    .prologue
    .line 50
    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Lcom/cyjh/mobileanjian/ipc/uip/b;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 51
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 8

    .prologue
    const/4 v7, 0x1

    const/4 v6, -0x1

    const/4 v5, 0x0

    .line 55
    invoke-direct {p0, p1, p2, p3}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 41
    iput v5, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->i:I

    .line 57
    const/high16 v0, 0x41200000    # 10.0f

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    invoke-static {v7, v0, v1}, Landroid/util/TypedValue;->applyDimension(IFLandroid/util/DisplayMetrics;)F

    move-result v0

    float-to-int v0, v0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->f:I

    .line 59
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v0, v6, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/uip/b;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 60
    invoke-virtual {p0, v5}, Lcom/cyjh/mobileanjian/ipc/uip/b;->setOrientation(I)V

    .line 62
    new-instance v0, Landroid/widget/LinearLayout;

    invoke-direct {v0, p1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 63
    new-instance v1, Landroid/widget/TableLayout$LayoutParams;

    invoke-direct {v1, v5, v6}, Landroid/widget/TableLayout$LayoutParams;-><init>(II)V

    .line 64
    const/high16 v2, 0x40f00000    # 7.5f

    iput v2, v1, Landroid/widget/TableLayout$LayoutParams;->weight:F

    .line 65
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 66
    const/16 v1, 0x10

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 67
    invoke-virtual {v0, v7}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 69
    new-instance v1, Landroid/widget/ScrollView;

    invoke-direct {v1, p1}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 74
    new-instance v2, Landroid/widget/RadioGroup;

    invoke-direct {v2, p1}, Landroid/widget/RadioGroup;-><init>(Landroid/content/Context;)V

    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->c:Landroid/widget/RadioGroup;

    .line 75
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->c:Landroid/widget/RadioGroup;

    invoke-virtual {v2, v7}, Landroid/widget/RadioGroup;->setOrientation(I)V

    .line 76
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->c:Landroid/widget/RadioGroup;

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->f:I

    iget v4, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->f:I

    neg-int v4, v4

    invoke-virtual {v2, v3, v5, v5, v4}, Landroid/widget/RadioGroup;->setPadding(IIII)V

    .line 77
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->c:Landroid/widget/RadioGroup;

    invoke-virtual {v1, v2}, Landroid/widget/ScrollView;->addView(Landroid/view/View;)V

    .line 78
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 79
    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/uip/b;->addView(Landroid/view/View;)V

    .line 82
    new-instance v0, Landroid/view/View;

    invoke-direct {v0, p1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 83
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v3

    invoke-static {v7, v2, v3}, Landroid/util/TypedValue;->applyDimension(IFLandroid/util/DisplayMetrics;)F

    move-result v2

    float-to-int v2, v2

    invoke-direct {v1, v2, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 84
    const/high16 v1, -0x1000000

    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundColor(I)V

    .line 85
    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/uip/b;->addView(Landroid/view/View;)V

    .line 87
    new-instance v0, Landroid/widget/FrameLayout;

    invoke-direct {v0, p1}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->d:Landroid/widget/FrameLayout;

    .line 88
    new-instance v0, Landroid/widget/TableLayout$LayoutParams;

    invoke-direct {v0, v5, v6}, Landroid/widget/TableLayout$LayoutParams;-><init>(II)V

    .line 89
    const/high16 v1, 0x40200000    # 2.5f

    iput v1, v0, Landroid/widget/TableLayout$LayoutParams;->weight:F

    .line 90
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->d:Landroid/widget/FrameLayout;

    invoke-virtual {v1, v0}, Landroid/widget/FrameLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 91
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->d:Landroid/widget/FrameLayout;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->f:I

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->f:I

    invoke-virtual {v0, v1, v5, v2, v5}, Landroid/widget/FrameLayout;->setPadding(IIII)V

    .line 92
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->d:Landroid/widget/FrameLayout;

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/uip/b;->addView(Landroid/view/View;)V

    .line 94
    new-instance v0, Ljava/util/ArrayList;

    const/4 v1, 0x7

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->e:Ljava/util/List;

    .line 96
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->c:Landroid/widget/RadioGroup;

    invoke-virtual {v0, p0}, Landroid/widget/RadioGroup;->setOnCheckedChangeListener(Landroid/widget/RadioGroup$OnCheckedChangeListener;)V

    .line 97
    return-void
.end method

.method private b()Landroid/widget/LinearLayout;
    .locals 3

    .prologue
    const/4 v2, -0x1

    .line 142
    new-instance v0, Landroid/widget/LinearLayout;

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/uip/b;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 143
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 144
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v1, v2, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 145
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 147
    return-object v0
.end method


# virtual methods
.method public a()V
    .locals 2

    .prologue
    .line 135
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->e:Ljava/util/List;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->h:Landroid/widget/ScrollView;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 136
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->i:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->i:I

    .line 137
    return-void
.end method

.method public a(Landroid/view/View;)V
    .locals 1

    .prologue
    .line 130
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->g:Landroid/widget/LinearLayout;

    invoke-virtual {v0, p1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 131
    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 5

    .prologue
    const/4 v4, -0x1

    const/4 v3, 0x0

    .line 107
    new-instance v0, Landroid/widget/RadioButton;

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/uip/b;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/widget/RadioButton;-><init>(Landroid/content/Context;)V

    .line 108
    sget-object v1, Lcom/cyjh/mobileanjian/ipc/uip/b;->b:[I

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->i:I

    aget v1, v1, v2

    invoke-virtual {v0, v1}, Landroid/widget/RadioButton;->setId(I)V

    .line 112
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->f:I

    invoke-virtual {v0, v3, v3, v3, v1}, Landroid/widget/RadioButton;->setPadding(IIII)V

    .line 113
    const/4 v1, 0x0

    .line 114
    new-instance v2, Landroid/graphics/drawable/BitmapDrawable;

    invoke-direct {v2, v1}, Landroid/graphics/drawable/BitmapDrawable;-><init>(Landroid/graphics/Bitmap;)V

    invoke-virtual {v0, v2}, Landroid/widget/RadioButton;->setButtonDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 115
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/uip/b;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    sget v2, Lcom/cyjh/rootipc/R$color;->selector_tab:I

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getColorStateList(I)Landroid/content/res/ColorStateList;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/RadioButton;->setTextColor(Landroid/content/res/ColorStateList;)V

    .line 116
    invoke-virtual {v0, p1}, Landroid/widget/RadioButton;->setText(Ljava/lang/CharSequence;)V

    .line 117
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/RadioButton;->setLines(I)V

    .line 118
    sget-object v1, Landroid/text/TextUtils$TruncateAt;->END:Landroid/text/TextUtils$TruncateAt;

    invoke-virtual {v0, v1}, Landroid/widget/RadioButton;->setEllipsize(Landroid/text/TextUtils$TruncateAt;)V

    .line 119
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->c:Landroid/widget/RadioGroup;

    invoke-virtual {v1, v0}, Landroid/widget/RadioGroup;->addView(Landroid/view/View;)V

    .line 121
    new-instance v0, Landroid/widget/ScrollView;

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/uip/b;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->h:Landroid/widget/ScrollView;

    .line 122
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->h:Landroid/widget/ScrollView;

    invoke-virtual {v0, p1}, Landroid/widget/ScrollView;->setTag(Ljava/lang/Object;)V

    .line 123
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->h:Landroid/widget/ScrollView;

    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v1, v4, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1}, Landroid/widget/ScrollView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 124
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/uip/b;->b()Landroid/widget/LinearLayout;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->g:Landroid/widget/LinearLayout;

    .line 125
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->h:Landroid/widget/ScrollView;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->g:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v1}, Landroid/widget/ScrollView;->addView(Landroid/view/View;)V

    .line 126
    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Landroid/widget/ScrollView;",
            ">;)V"
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 152
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->e:Ljava/util/List;

    .line 153
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v3

    move v1, v2

    :goto_0
    if-ge v1, v3, :cond_0

    .line 155
    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/widget/ScrollView;

    .line 156
    new-instance v4, Landroid/widget/RadioButton;

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/uip/b;->getContext()Landroid/content/Context;

    move-result-object v5

    invoke-direct {v4, v5}, Landroid/widget/RadioButton;-><init>(Landroid/content/Context;)V

    .line 157
    sget-object v5, Lcom/cyjh/mobileanjian/ipc/uip/b;->b:[I

    aget v5, v5, v1

    invoke-virtual {v4, v5}, Landroid/widget/RadioButton;->setId(I)V

    .line 158
    iget v5, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->f:I

    invoke-virtual {v4, v2, v2, v2, v5}, Landroid/widget/RadioButton;->setPadding(IIII)V

    .line 159
    const/4 v5, 0x0

    .line 160
    new-instance v6, Landroid/graphics/drawable/BitmapDrawable;

    invoke-direct {v6, v5}, Landroid/graphics/drawable/BitmapDrawable;-><init>(Landroid/graphics/Bitmap;)V

    invoke-virtual {v4, v6}, Landroid/widget/RadioButton;->setButtonDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 161
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/uip/b;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    sget v6, Lcom/cyjh/rootipc/R$color;->selector_tab:I

    invoke-virtual {v5, v6}, Landroid/content/res/Resources;->getColorStateList(I)Landroid/content/res/ColorStateList;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/widget/RadioButton;->setTextColor(Landroid/content/res/ColorStateList;)V

    .line 162
    invoke-virtual {v0}, Landroid/widget/ScrollView;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v4, v0}, Landroid/widget/RadioButton;->setText(Ljava/lang/CharSequence;)V

    .line 163
    const/4 v0, 0x1

    invoke-virtual {v4, v0}, Landroid/widget/RadioButton;->setLines(I)V

    .line 164
    sget-object v0, Landroid/text/TextUtils$TruncateAt;->END:Landroid/text/TextUtils$TruncateAt;

    invoke-virtual {v4, v0}, Landroid/widget/RadioButton;->setEllipsize(Landroid/text/TextUtils$TruncateAt;)V

    .line 165
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->c:Landroid/widget/RadioGroup;

    invoke-virtual {v0, v4}, Landroid/widget/RadioGroup;->addView(Landroid/view/View;)V

    .line 153
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 167
    :cond_0
    return-void
.end method

.method public getCurrentItem()I
    .locals 1

    .prologue
    .line 173
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->j:I

    return v0
.end method

.method public getScrollViewList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Landroid/widget/ScrollView;",
            ">;"
        }
    .end annotation

    .prologue
    .line 101
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->e:Ljava/util/List;

    return-object v0
.end method

.method public onCheckedChanged(Landroid/widget/RadioGroup;I)V
    .locals 0

    .prologue
    .line 196
    invoke-virtual {p0, p2}, Lcom/cyjh/mobileanjian/ipc/uip/b;->setSelectTab(I)V

    .line 197
    return-void
.end method

.method public setSelectTab(I)V
    .locals 2

    .prologue
    .line 178
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->e:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_0

    .line 191
    :goto_0
    return-void

    .line 181
    :cond_0
    if-ltz p1, :cond_1

    const/4 v0, 0x6

    if-le p1, v0, :cond_2

    .line 183
    :cond_1
    const/4 p1, 0x0

    .line 186
    :cond_2
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->j:I

    .line 188
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->c:Landroid/widget/RadioGroup;

    invoke-virtual {v0, p1}, Landroid/widget/RadioGroup;->check(I)V

    .line 189
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->d:Landroid/widget/FrameLayout;

    invoke-virtual {v0}, Landroid/widget/FrameLayout;->removeAllViews()V

    .line 190
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->d:Landroid/widget/FrameLayout;

    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/b;->e:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    goto :goto_0
.end method
