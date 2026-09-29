.class public Lcom/lidroid/xutils/bitmap/BitmapCommonUtils;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static screenSize:Lcom/lidroid/xutils/bitmap/core/BitmapSize;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 32
    const/4 v0, 0x0

    sput-object v0, Lcom/lidroid/xutils/bitmap/BitmapCommonUtils;->screenSize:Lcom/lidroid/xutils/bitmap/core/BitmapSize;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 30
    return-void
.end method

.method private static getImageViewFieldValue(Ljava/lang/Object;Ljava/lang/String;)I
    .locals 3

    .prologue
    .line 76
    const/4 v1, 0x0

    .line 77
    instance-of v0, p0, Landroid/widget/ImageView;

    if-eqz v0, :cond_0

    .line 79
    :try_start_0
    const-class v0, Landroid/widget/ImageView;

    invoke-virtual {v0, p1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0

    .line 80
    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 81
    invoke-virtual {v0, p0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 82
    if-lez v0, :cond_0

    const v2, 0x7fffffff

    if-ge v0, v2, :cond_0

    .line 88
    :goto_0
    return v0

    .line 85
    :catch_0
    move-exception v0

    move v0, v1

    goto :goto_0

    :cond_0
    move v0, v1

    goto :goto_0
.end method

.method public static getScreenSize(Landroid/content/Context;)Lcom/lidroid/xutils/bitmap/core/BitmapSize;
    .locals 3

    .prologue
    .line 35
    sget-object v0, Lcom/lidroid/xutils/bitmap/BitmapCommonUtils;->screenSize:Lcom/lidroid/xutils/bitmap/core/BitmapSize;

    if-nez v0, :cond_0

    .line 36
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    .line 37
    new-instance v1, Lcom/lidroid/xutils/bitmap/core/BitmapSize;

    iget v2, v0, Landroid/util/DisplayMetrics;->widthPixels:I

    iget v0, v0, Landroid/util/DisplayMetrics;->heightPixels:I

    invoke-direct {v1, v2, v0}, Lcom/lidroid/xutils/bitmap/core/BitmapSize;-><init>(II)V

    sput-object v1, Lcom/lidroid/xutils/bitmap/BitmapCommonUtils;->screenSize:Lcom/lidroid/xutils/bitmap/core/BitmapSize;

    .line 39
    :cond_0
    sget-object v0, Lcom/lidroid/xutils/bitmap/BitmapCommonUtils;->screenSize:Lcom/lidroid/xutils/bitmap/core/BitmapSize;

    return-object v0
.end method

.method public static optimizeMaxSizeByView(Landroid/view/View;II)Lcom/lidroid/xutils/bitmap/core/BitmapSize;
    .locals 4

    .prologue
    const/4 v2, -0x2

    .line 43
    .line 46
    if-lez p1, :cond_0

    if-lez p2, :cond_0

    .line 47
    new-instance v0, Lcom/lidroid/xutils/bitmap/core/BitmapSize;

    invoke-direct {v0, p1, p2}, Lcom/lidroid/xutils/bitmap/core/BitmapSize;-><init>(II)V

    .line 72
    :goto_0
    return-object v0

    .line 50
    :cond_0
    invoke-virtual {p0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    .line 51
    if-eqz v0, :cond_8

    .line 52
    iget v1, v0, Landroid/view/ViewGroup$LayoutParams;->width:I

    if-lez v1, :cond_5

    .line 53
    iget p1, v0, Landroid/view/ViewGroup$LayoutParams;->width:I

    .line 58
    :cond_1
    :goto_1
    iget v1, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    if-lez v1, :cond_6

    .line 59
    iget p2, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    move v0, p2

    move v1, p1

    .line 65
    :goto_2
    if-gtz v1, :cond_2

    const-string v1, "mMaxWidth"

    invoke-static {p0, v1}, Lcom/lidroid/xutils/bitmap/BitmapCommonUtils;->getImageViewFieldValue(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v1

    .line 66
    :cond_2
    if-gtz v0, :cond_3

    const-string v0, "mMaxHeight"

    invoke-static {p0, v0}, Lcom/lidroid/xutils/bitmap/BitmapCommonUtils;->getImageViewFieldValue(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v0

    .line 68
    :cond_3
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Lcom/lidroid/xutils/bitmap/BitmapCommonUtils;->getScreenSize(Landroid/content/Context;)Lcom/lidroid/xutils/bitmap/core/BitmapSize;

    move-result-object v3

    .line 69
    if-gtz v1, :cond_7

    invoke-virtual {v3}, Lcom/lidroid/xutils/bitmap/core/BitmapSize;->getWidth()I

    move-result v1

    move v2, v1

    .line 70
    :goto_3
    if-gtz v0, :cond_4

    invoke-virtual {v3}, Lcom/lidroid/xutils/bitmap/core/BitmapSize;->getHeight()I

    move-result v0

    .line 72
    :cond_4
    new-instance v1, Lcom/lidroid/xutils/bitmap/core/BitmapSize;

    invoke-direct {v1, v2, v0}, Lcom/lidroid/xutils/bitmap/core/BitmapSize;-><init>(II)V

    move-object v0, v1

    goto :goto_0

    .line 54
    :cond_5
    iget v1, v0, Landroid/view/ViewGroup$LayoutParams;->width:I

    if-eq v1, v2, :cond_1

    .line 55
    invoke-virtual {p0}, Landroid/view/View;->getWidth()I

    move-result p1

    goto :goto_1

    .line 60
    :cond_6
    iget v0, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    if-eq v0, v2, :cond_8

    .line 61
    invoke-virtual {p0}, Landroid/view/View;->getHeight()I

    move-result p2

    move v0, p2

    move v1, p1

    goto :goto_2

    :cond_7
    move v2, v1

    goto :goto_3

    :cond_8
    move v0, p2

    move v1, p1

    goto :goto_2
.end method
