.class public Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;
.super Landroid/widget/BaseAdapter;
.source "ImageSelectAdapter.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$OnSelectImgNumber;,
        Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$ViewHolder;
    }
.end annotation


# instance fields
.field private context:Landroid/content/Context;

.field private mImgPaths:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private mInflater:Landroid/view/LayoutInflater;

.field private mSelectImgNumber:Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$OnSelectImgNumber;

.field private mSetSelect:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/util/List;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 33
    .local p2, "dataList":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    invoke-direct {p0}, Landroid/widget/BaseAdapter;-><init>()V

    .line 32
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;->mSetSelect:Ljava/util/Set;

    .line 34
    iput-object p1, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;->context:Landroid/content/Context;

    .line 35
    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;->mInflater:Landroid/view/LayoutInflater;

    .line 36
    iput-object p2, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;->mImgPaths:Ljava/util/List;

    .line 37
    return-void
.end method

.method static synthetic access$000(Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;)Landroid/content/Context;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;

    .prologue
    .line 28
    iget-object v0, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;->context:Landroid/content/Context;

    return-object v0
.end method

.method static synthetic access$100(Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;)Ljava/util/Set;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;

    .prologue
    .line 28
    iget-object v0, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;->mSetSelect:Ljava/util/Set;

    return-object v0
.end method

.method static synthetic access$200(Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;)Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$OnSelectImgNumber;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;

    .prologue
    .line 28
    iget-object v0, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;->mSelectImgNumber:Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$OnSelectImgNumber;

    return-object v0
.end method


# virtual methods
.method public getCount()I
    .locals 1

    .prologue
    .line 41
    iget-object v0, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;->mImgPaths:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public getItem(I)Ljava/lang/Object;
    .locals 1
    .param p1, "position"    # I

    .prologue
    .line 46
    iget-object v0, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;->mImgPaths:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public getItemId(I)J
    .locals 2
    .param p1, "position"    # I

    .prologue
    .line 51
    int-to-long v0, p1

    return-wide v0
.end method

.method public getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 5
    .param p1, "position"    # I
    .param p2, "convertView"    # Landroid/view/View;
    .param p3, "parent"    # Landroid/view/ViewGroup;

    .prologue
    const/4 v4, 0x0

    .line 57
    if-nez p2, :cond_1

    .line 58
    new-instance v0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$ViewHolder;

    invoke-direct {v0, p0}, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$ViewHolder;-><init>(Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;)V

    .line 59
    .local v0, "mHolder":Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$ViewHolder;
    iget-object v2, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;->mInflater:Landroid/view/LayoutInflater;

    sget v3, Lcom/cyjh/feedback/libraryfeedbackinfo/R$layout;->image_adapter_item:I

    invoke-virtual {v2, v3, p3, v4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p2

    .line 60
    sget v2, Lcom/cyjh/feedback/libraryfeedbackinfo/R$id;->id_img_select_grid_item:I

    invoke-virtual {p2, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/ImageButton;

    iput-object v2, v0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$ViewHolder;->imageButton:Landroid/widget/ImageButton;

    .line 61
    sget v2, Lcom/cyjh/feedback/libraryfeedbackinfo/R$id;->id_img_grid_item:I

    invoke-virtual {p2, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/ImageView;

    iput-object v2, v0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$ViewHolder;->imageView:Landroid/widget/ImageView;

    .line 62
    invoke-virtual {p2, v0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    .line 67
    :goto_0
    iget-object v2, v0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$ViewHolder;->imageView:Landroid/widget/ImageView;

    sget v3, Lcom/cyjh/feedback/libraryfeedbackinfo/R$mipmap;->pictures_no:I

    invoke-virtual {v2, v3}, Landroid/widget/ImageView;->setImageResource(I)V

    .line 68
    iget-object v2, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;->mImgPaths:Ljava/util/List;

    invoke-interface {v2, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 70
    .local v1, "path":Ljava/lang/String;
    sget-object v2, Lcom/cyjh/feedback/lib/utils/ImageLoader$Type;->FILO:Lcom/cyjh/feedback/lib/utils/ImageLoader$Type;

    const/4 v3, 0x3

    invoke-static {v2, v3}, Lcom/cyjh/feedback/lib/utils/ImageLoader;->getInstance(Lcom/cyjh/feedback/lib/utils/ImageLoader$Type;I)Lcom/cyjh/feedback/lib/utils/ImageLoader;

    move-result-object v2

    iget-object v3, v0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$ViewHolder;->imageView:Landroid/widget/ImageView;

    invoke-virtual {v2, v1, v3}, Lcom/cyjh/feedback/lib/utils/ImageLoader;->imageLoader(Ljava/lang/String;Landroid/widget/ImageView;)V

    .line 72
    iget-object v2, v0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$ViewHolder;->imageView:Landroid/widget/ImageView;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/widget/ImageView;->setColorFilter(Landroid/graphics/ColorFilter;)V

    .line 73
    iget-object v2, v0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$ViewHolder;->imageButton:Landroid/widget/ImageButton;

    const/4 v3, 0x4

    invoke-virtual {v2, v3}, Landroid/widget/ImageButton;->setVisibility(I)V

    .line 75
    iget-object v2, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;->mSetSelect:Ljava/util/Set;

    invoke-interface {v2, v1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 76
    iget-object v2, v0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$ViewHolder;->imageView:Landroid/widget/ImageView;

    const-string v3, "#77000000"

    invoke-static {v3}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/widget/ImageView;->setColorFilter(I)V

    .line 77
    iget-object v2, v0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$ViewHolder;->imageButton:Landroid/widget/ImageButton;

    invoke-virtual {v2, v4}, Landroid/widget/ImageButton;->setVisibility(I)V

    .line 79
    :cond_0
    iget-object v2, v0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$ViewHolder;->imageView:Landroid/widget/ImageView;

    new-instance v3, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$1;

    invoke-direct {v3, p0, v1, v0}, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$1;-><init>(Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;Ljava/lang/String;Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$ViewHolder;)V

    invoke-virtual {v2, v3}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 111
    return-object p2

    .line 64
    .end local v0    # "mHolder":Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$ViewHolder;
    .end local v1    # "path":Ljava/lang/String;
    :cond_1
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$ViewHolder;

    .restart local v0    # "mHolder":Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$ViewHolder;
    goto :goto_0
.end method

.method public getmSetSelect()Ljava/util/Set;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Set",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 115
    iget-object v0, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;->mSetSelect:Ljava/util/Set;

    return-object v0
.end method

.method public setOnSelectImgNumber(Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$OnSelectImgNumber;)V
    .locals 0
    .param p1, "onSelectImgNumber"    # Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$OnSelectImgNumber;

    .prologue
    .line 134
    iput-object p1, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;->mSelectImgNumber:Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$OnSelectImgNumber;

    .line 135
    return-void
.end method
