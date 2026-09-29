.class public Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;
.super Landroid/widget/BaseAdapter;
.source "ImageShowAdapter.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$OnDeleteSelectImg;,
        Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$ViewHolder;
    }
.end annotation


# static fields
.field private static final PIC_COUNT_DEFAULT:I = 0x1

.field private static final PIC_COUNT_MAX:I = 0x4


# instance fields
.field private mData:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private mDeleteSelectImg:Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$OnDeleteSelectImg;

.field private mInflater:Landroid/view/LayoutInflater;


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
    .line 38
    .local p2, "datas":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    invoke-direct {p0}, Landroid/widget/BaseAdapter;-><init>()V

    .line 24
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;->mData:Ljava/util/List;

    .line 39
    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;->mInflater:Landroid/view/LayoutInflater;

    .line 40
    iput-object p2, p0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;->mData:Ljava/util/List;

    .line 42
    return-void
.end method

.method static synthetic access$000(Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;)Ljava/util/List;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;

    .prologue
    .line 22
    iget-object v0, p0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;->mData:Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$100(Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;)Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$OnDeleteSelectImg;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;

    .prologue
    .line 22
    iget-object v0, p0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;->mDeleteSelectImg:Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$OnDeleteSelectImg;

    return-object v0
.end method


# virtual methods
.method public getCount()I
    .locals 2

    .prologue
    const/4 v0, 0x4

    .line 46
    iget-object v1, p0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;->mData:Ljava/util/List;

    if-eqz v1, :cond_1

    .line 47
    iget-object v1, p0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;->mData:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-ge v1, v0, :cond_0

    .line 49
    iget-object v0, p0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;->mData:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    add-int/lit8 v0, v0, 0x1

    .line 55
    :cond_0
    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public getItem(I)Ljava/lang/Object;
    .locals 1
    .param p1, "position"    # I

    .prologue
    .line 60
    iget-object v0, p0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;->mData:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;->mData:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_0

    .line 61
    iget-object v0, p0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;->mData:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    .line 63
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public getItemId(I)J
    .locals 2
    .param p1, "position"    # I

    .prologue
    .line 68
    int-to-long v0, p1

    return-wide v0
.end method

.method public getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 6
    .param p1, "position"    # I
    .param p2, "convertView"    # Landroid/view/View;
    .param p3, "parent"    # Landroid/view/ViewGroup;

    .prologue
    const/4 v5, 0x4

    const/4 v4, 0x0

    .line 74
    if-nez p2, :cond_2

    .line 75
    iget-object v1, p0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;->mInflater:Landroid/view/LayoutInflater;

    sget v2, Lcom/cyjh/feedback/libraryfeedbackinfo/R$layout;->grid_view_item:I

    invoke-virtual {v1, v2, p3, v4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p2

    .line 76
    new-instance v0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$ViewHolder;

    invoke-direct {v0, p0}, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$ViewHolder;-><init>(Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;)V

    .line 77
    .local v0, "mHolder":Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$ViewHolder;
    sget v1, Lcom/cyjh/feedback/libraryfeedbackinfo/R$id;->id_iv_grid_item:I

    invoke-virtual {p2, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageView;

    iput-object v1, v0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$ViewHolder;->iv:Landroid/widget/ImageView;

    .line 78
    sget v1, Lcom/cyjh/feedback/libraryfeedbackinfo/R$id;->id_img_delete_select:I

    invoke-virtual {p2, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageView;

    iput-object v1, v0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$ViewHolder;->imgDeteleSelect:Landroid/widget/ImageView;

    .line 79
    invoke-virtual {p2, v0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    .line 84
    :goto_0
    iget-object v1, v0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$ViewHolder;->iv:Landroid/widget/ImageView;

    sget v2, Lcom/cyjh/feedback/libraryfeedbackinfo/R$mipmap;->img_add_img_select:I

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setImageResource(I)V

    .line 85
    iget-object v1, v0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$ViewHolder;->imgDeteleSelect:Landroid/widget/ImageView;

    invoke-virtual {v1, v5}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 87
    iget-object v1, p0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;->mData:Ljava/util/List;

    if-eqz v1, :cond_0

    invoke-virtual {p0}, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;->getCount()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    if-ge p1, v1, :cond_0

    .line 88
    invoke-static {}, Lcom/cyjh/feedback/lib/utils/ImageLoader;->getInstance()Lcom/cyjh/feedback/lib/utils/ImageLoader;

    move-result-object v2

    iget-object v1, p0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;->mData:Ljava/util/List;

    invoke-interface {v1, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    iget-object v3, v0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$ViewHolder;->iv:Landroid/widget/ImageView;

    invoke-virtual {v2, v1, v3}, Lcom/cyjh/feedback/lib/utils/ImageLoader;->imageLoader(Ljava/lang/String;Landroid/widget/ImageView;)V

    .line 89
    iget-object v1, v0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$ViewHolder;->imgDeteleSelect:Landroid/widget/ImageView;

    invoke-virtual {v1, v4}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 92
    :cond_0
    iget-object v1, p0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;->mData:Ljava/util/List;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;->mData:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-ne v1, v5, :cond_1

    .line 93
    invoke-static {}, Lcom/cyjh/feedback/lib/utils/ImageLoader;->getInstance()Lcom/cyjh/feedback/lib/utils/ImageLoader;

    move-result-object v2

    iget-object v1, p0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;->mData:Ljava/util/List;

    invoke-interface {v1, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    iget-object v3, v0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$ViewHolder;->iv:Landroid/widget/ImageView;

    invoke-virtual {v2, v1, v3}, Lcom/cyjh/feedback/lib/utils/ImageLoader;->imageLoader(Ljava/lang/String;Landroid/widget/ImageView;)V

    .line 94
    iget-object v1, v0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$ViewHolder;->imgDeteleSelect:Landroid/widget/ImageView;

    invoke-virtual {v1, v4}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 96
    :cond_1
    iget-object v1, v0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$ViewHolder;->imgDeteleSelect:Landroid/widget/ImageView;

    new-instance v2, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$1;

    invoke-direct {v2, p0, p1}, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$1;-><init>(Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;I)V

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 106
    return-object p2

    .line 81
    .end local v0    # "mHolder":Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$ViewHolder;
    :cond_2
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$ViewHolder;

    .restart local v0    # "mHolder":Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$ViewHolder;
    goto :goto_0
.end method

.method public setmData(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 35
    .local p1, "mData":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    iput-object p1, p0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;->mData:Ljava/util/List;

    .line 36
    return-void
.end method

.method public setmDeleteSelectImg(Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$OnDeleteSelectImg;)V
    .locals 0
    .param p1, "mDeleteSelectImg"    # Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$OnDeleteSelectImg;

    .prologue
    .line 127
    iput-object p1, p0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;->mDeleteSelectImg:Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$OnDeleteSelectImg;

    .line 128
    return-void
.end method
