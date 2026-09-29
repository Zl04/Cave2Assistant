.class public Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;
.super Ljava/lang/Object;
.source "BGAViewHolderHelper.java"

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/view/View$OnLongClickListener;
.implements Landroid/widget/CompoundButton$OnCheckedChangeListener;


# instance fields
.field protected mAdapterView:Landroid/view/ViewGroup;

.field protected mContext:Landroid/content/Context;

.field protected mConvertView:Landroid/view/View;

.field protected mObj:Ljava/lang/Object;

.field protected mOnItemChildCheckedChangeListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildCheckedChangeListener;

.field protected mOnItemChildClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildClickListener;

.field protected mOnItemChildLongClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildLongClickListener;

.field protected mPosition:I

.field protected mRecyclerView:Landroid/support/v7/widget/RecyclerView;

.field protected mRecyclerViewHolder:Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;

.field protected final mViews:Landroid/util/SparseArray;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/util/SparseArray",
            "<",
            "Landroid/view/View;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Landroid/support/v7/widget/RecyclerView;Landroid/view/View;)V
    .locals 1
    .param p1, "recyclerView"    # Landroid/support/v7/widget/RecyclerView;
    .param p2, "convertView"    # Landroid/view/View;

    .prologue
    .line 65
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 66
    new-instance v0, Landroid/util/SparseArray;

    invoke-direct {v0}, Landroid/util/SparseArray;-><init>()V

    iput-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mViews:Landroid/util/SparseArray;

    .line 67
    iput-object p1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mRecyclerView:Landroid/support/v7/widget/RecyclerView;

    .line 68
    iput-object p2, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mConvertView:Landroid/view/View;

    .line 69
    invoke-virtual {p2}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mContext:Landroid/content/Context;

    .line 70
    return-void
.end method

.method public constructor <init>(Landroid/view/ViewGroup;Landroid/view/View;)V
    .locals 1
    .param p1, "adapterView"    # Landroid/view/ViewGroup;
    .param p2, "convertView"    # Landroid/view/View;

    .prologue
    .line 58
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 59
    new-instance v0, Landroid/util/SparseArray;

    invoke-direct {v0}, Landroid/util/SparseArray;-><init>()V

    iput-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mViews:Landroid/util/SparseArray;

    .line 60
    iput-object p1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mAdapterView:Landroid/view/ViewGroup;

    .line 61
    iput-object p2, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mConvertView:Landroid/view/View;

    .line 62
    invoke-virtual {p2}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mContext:Landroid/content/Context;

    .line 63
    return-void
.end method


# virtual methods
.method public getConvertView()Landroid/view/View;
    .locals 1

    .prologue
    .line 222
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mConvertView:Landroid/view/View;

    return-object v0
.end method

.method public getImageView(I)Landroid/widget/ImageView;
    .locals 1
    .param p1, "viewId"    # I
        .annotation build Landroid/support/annotation/IdRes;
        .end annotation
    .end param

    .prologue
    .line 203
    invoke-virtual {p0, p1}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->getView(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    return-object v0
.end method

.method public getObj()Ljava/lang/Object;
    .locals 1

    .prologue
    .line 230
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mObj:Ljava/lang/Object;

    return-object v0
.end method

.method public getPosition()I
    .locals 1

    .prologue
    .line 85
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mRecyclerViewHolder:Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;

    if-eqz v0, :cond_0

    .line 86
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mRecyclerViewHolder:Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;

    invoke-virtual {v0}, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;->getAdapterPosition()I

    move-result v0

    .line 88
    :goto_0
    return v0

    :cond_0
    iget v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mPosition:I

    goto :goto_0
.end method

.method public getRecyclerViewHolder()Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;
    .locals 1

    .prologue
    .line 77
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mRecyclerViewHolder:Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;

    return-object v0
.end method

.method public getTextView(I)Landroid/widget/TextView;
    .locals 1
    .param p1, "viewId"    # I
        .annotation build Landroid/support/annotation/IdRes;
        .end annotation
    .end param

    .prologue
    .line 213
    invoke-virtual {p0, p1}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->getView(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    return-object v0
.end method

.method public getView(I)Landroid/view/View;
    .locals 2
    .param p1, "viewId"    # I
        .annotation build Landroid/support/annotation/IdRes;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Landroid/view/View;",
            ">(I)TT;"
        }
    .end annotation

    .prologue
    .line 188
    iget-object v1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mViews:Landroid/util/SparseArray;

    invoke-virtual {v1, p1}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    .line 189
    .local v0, "view":Landroid/view/View;
    if-nez v0, :cond_0

    .line 190
    iget-object v1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mConvertView:Landroid/view/View;

    invoke-virtual {v1, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    .line 191
    iget-object v1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mViews:Landroid/util/SparseArray;

    invoke-virtual {v1, p1, v0}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    .line 193
    :cond_0
    return-object v0
.end method

.method public onCheckedChanged(Landroid/widget/CompoundButton;Z)V
    .locals 3
    .param p1, "buttonView"    # Landroid/widget/CompoundButton;
    .param p2, "isChecked"    # Z

    .prologue
    .line 172
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mOnItemChildCheckedChangeListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildCheckedChangeListener;

    if-eqz v0, :cond_0

    .line 173
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mRecyclerView:Landroid/support/v7/widget/RecyclerView;

    if-eqz v0, :cond_1

    .line 174
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mOnItemChildCheckedChangeListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildCheckedChangeListener;

    iget-object v1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mRecyclerView:Landroid/support/v7/widget/RecyclerView;

    invoke-virtual {p0}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->getPosition()I

    move-result v2

    invoke-interface {v0, v1, p1, v2, p2}, Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildCheckedChangeListener;->onItemChildCheckedChanged(Landroid/view/ViewGroup;Landroid/widget/CompoundButton;IZ)V

    .line 179
    :cond_0
    :goto_0
    return-void

    .line 175
    :cond_1
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mAdapterView:Landroid/view/ViewGroup;

    if-eqz v0, :cond_0

    .line 176
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mOnItemChildCheckedChangeListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildCheckedChangeListener;

    iget-object v1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mAdapterView:Landroid/view/ViewGroup;

    invoke-virtual {p0}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->getPosition()I

    move-result v2

    invoke-interface {v0, v1, p1, v2, p2}, Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildCheckedChangeListener;->onItemChildCheckedChanged(Landroid/view/ViewGroup;Landroid/widget/CompoundButton;IZ)V

    goto :goto_0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 3
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 149
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mOnItemChildClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildClickListener;

    if-eqz v0, :cond_0

    .line 150
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mRecyclerView:Landroid/support/v7/widget/RecyclerView;

    if-eqz v0, :cond_1

    .line 151
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mOnItemChildClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildClickListener;

    iget-object v1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mRecyclerView:Landroid/support/v7/widget/RecyclerView;

    invoke-virtual {p0}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->getPosition()I

    move-result v2

    invoke-interface {v0, v1, p1, v2}, Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildClickListener;->onItemChildClick(Landroid/view/ViewGroup;Landroid/view/View;I)V

    .line 156
    :cond_0
    :goto_0
    return-void

    .line 152
    :cond_1
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mAdapterView:Landroid/view/ViewGroup;

    if-eqz v0, :cond_0

    .line 153
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mOnItemChildClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildClickListener;

    iget-object v1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mAdapterView:Landroid/view/ViewGroup;

    invoke-virtual {p0}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->getPosition()I

    move-result v2

    invoke-interface {v0, v1, p1, v2}, Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildClickListener;->onItemChildClick(Landroid/view/ViewGroup;Landroid/view/View;I)V

    goto :goto_0
.end method

.method public onLongClick(Landroid/view/View;)Z
    .locals 3
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 160
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mOnItemChildLongClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildLongClickListener;

    if-eqz v0, :cond_1

    .line 161
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mRecyclerView:Landroid/support/v7/widget/RecyclerView;

    if-eqz v0, :cond_0

    .line 162
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mOnItemChildLongClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildLongClickListener;

    iget-object v1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mRecyclerView:Landroid/support/v7/widget/RecyclerView;

    invoke-virtual {p0}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->getPosition()I

    move-result v2

    invoke-interface {v0, v1, p1, v2}, Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildLongClickListener;->onItemChildLongClick(Landroid/view/ViewGroup;Landroid/view/View;I)Z

    move-result v0

    .line 167
    :goto_0
    return v0

    .line 163
    :cond_0
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mAdapterView:Landroid/view/ViewGroup;

    if-eqz v0, :cond_1

    .line 164
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mOnItemChildLongClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildLongClickListener;

    iget-object v1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mAdapterView:Landroid/view/ViewGroup;

    invoke-virtual {p0}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->getPosition()I

    move-result v2

    invoke-interface {v0, v1, p1, v2}, Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildLongClickListener;->onItemChildLongClick(Landroid/view/ViewGroup;Landroid/view/View;I)Z

    move-result v0

    goto :goto_0

    .line 167
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public setBackgroundColor(II)Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;
    .locals 1
    .param p1, "viewId"    # I
        .annotation build Landroid/support/annotation/IdRes;
        .end annotation
    .end param
    .param p2, "color"    # I

    .prologue
    .line 354
    invoke-virtual {p0, p1}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->getView(I)Landroid/view/View;

    move-result-object v0

    .line 355
    .local v0, "view":Landroid/view/View;
    invoke-virtual {v0, p2}, Landroid/view/View;->setBackgroundColor(I)V

    .line 356
    return-object p0
.end method

.method public setBackgroundColorRes(II)Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;
    .locals 2
    .param p1, "viewId"    # I
        .annotation build Landroid/support/annotation/IdRes;
        .end annotation
    .end param
    .param p2, "colorResId"    # I
        .annotation build Landroid/support/annotation/ColorRes;
        .end annotation
    .end param

    .prologue
    .line 365
    invoke-virtual {p0, p1}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->getView(I)Landroid/view/View;

    move-result-object v0

    .line 366
    .local v0, "view":Landroid/view/View;
    iget-object v1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, p2}, Landroid/content/res/Resources;->getColor(I)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundColor(I)V

    .line 367
    return-object p0
.end method

.method public setBackgroundRes(II)Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;
    .locals 1
    .param p1, "viewId"    # I
        .annotation build Landroid/support/annotation/IdRes;
        .end annotation
    .end param
    .param p2, "backgroundResId"    # I

    .prologue
    .line 343
    invoke-virtual {p0, p1}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->getView(I)Landroid/view/View;

    move-result-object v0

    .line 344
    .local v0, "view":Landroid/view/View;
    invoke-virtual {v0, p2}, Landroid/view/View;->setBackgroundResource(I)V

    .line 345
    return-object p0
.end method

.method public setChecked(IZ)Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;
    .locals 1
    .param p1, "viewId"    # I
        .annotation build Landroid/support/annotation/IdRes;
        .end annotation
    .end param
    .param p2, "checked"    # Z

    .prologue
    .line 280
    invoke-virtual {p0, p1}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->getView(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Checkable;

    .line 281
    .local v0, "view":Landroid/widget/Checkable;
    invoke-interface {v0, p2}, Landroid/widget/Checkable;->setChecked(Z)V

    .line 282
    return-object p0
.end method

.method public setHtml(ILjava/lang/String;)Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;
    .locals 2
    .param p1, "viewId"    # I
        .annotation build Landroid/support/annotation/IdRes;
        .end annotation
    .end param
    .param p2, "source"    # Ljava/lang/String;

    .prologue
    .line 267
    invoke-virtual {p0, p1}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->getView(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 268
    .local v0, "view":Landroid/widget/TextView;
    invoke-static {p2}, Landroid/text/Html;->fromHtml(Ljava/lang/String;)Landroid/text/Spanned;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 269
    return-object p0
.end method

.method public setImageBitmap(ILandroid/graphics/Bitmap;)Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;
    .locals 1
    .param p1, "viewId"    # I
        .annotation build Landroid/support/annotation/IdRes;
        .end annotation
    .end param
    .param p2, "bitmap"    # Landroid/graphics/Bitmap;

    .prologue
    .line 304
    invoke-virtual {p0, p1}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->getView(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    .line 305
    .local v0, "view":Landroid/widget/ImageView;
    invoke-virtual {v0, p2}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    .line 306
    return-object p0
.end method

.method public setImageDrawable(ILandroid/graphics/drawable/Drawable;)Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;
    .locals 1
    .param p1, "viewId"    # I
        .annotation build Landroid/support/annotation/IdRes;
        .end annotation
    .end param
    .param p2, "drawable"    # Landroid/graphics/drawable/Drawable;

    .prologue
    .line 310
    invoke-virtual {p0, p1}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->getView(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    .line 311
    .local v0, "view":Landroid/widget/ImageView;
    invoke-virtual {v0, p2}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 312
    return-object p0
.end method

.method public setImageResource(II)Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;
    .locals 1
    .param p1, "viewId"    # I
        .annotation build Landroid/support/annotation/IdRes;
        .end annotation
    .end param
    .param p2, "imageResId"    # I
        .annotation build Landroid/support/annotation/DrawableRes;
        .end annotation
    .end param

    .prologue
    .line 376
    invoke-virtual {p0, p1}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->getView(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    .line 377
    .local v0, "view":Landroid/widget/ImageView;
    invoke-virtual {v0, p2}, Landroid/widget/ImageView;->setImageResource(I)V

    .line 378
    return-object p0
.end method

.method public setItemChildCheckedChangeListener(I)V
    .locals 1
    .param p1, "viewId"    # I
        .annotation build Landroid/support/annotation/IdRes;
        .end annotation
    .end param

    .prologue
    .line 142
    invoke-virtual {p0, p1}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->getView(I)Landroid/view/View;

    move-result-object v0

    instance-of v0, v0, Landroid/widget/CompoundButton;

    if-eqz v0, :cond_0

    .line 143
    invoke-virtual {p0, p1}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->getView(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/CompoundButton;

    invoke-virtual {v0, p0}, Landroid/widget/CompoundButton;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 145
    :cond_0
    return-void
.end method

.method public setItemChildClickListener(I)V
    .locals 1
    .param p1, "viewId"    # I
        .annotation build Landroid/support/annotation/IdRes;
        .end annotation
    .end param

    .prologue
    .line 106
    invoke-virtual {p0, p1}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->getView(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 107
    return-void
.end method

.method public setItemChildLongClickListener(I)V
    .locals 1
    .param p1, "viewId"    # I
        .annotation build Landroid/support/annotation/IdRes;
        .end annotation
    .end param

    .prologue
    .line 124
    invoke-virtual {p0, p1}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->getView(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    .line 125
    return-void
.end method

.method public setObj(Ljava/lang/Object;)V
    .locals 0
    .param p1, "obj"    # Ljava/lang/Object;

    .prologue
    .line 226
    iput-object p1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mObj:Ljava/lang/Object;

    .line 227
    return-void
.end method

.method public setOnItemChildCheckedChangeListener(Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildCheckedChangeListener;)V
    .locals 0
    .param p1, "onItemChildCheckedChangeListener"    # Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildCheckedChangeListener;

    .prologue
    .line 133
    iput-object p1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mOnItemChildCheckedChangeListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildCheckedChangeListener;

    .line 134
    return-void
.end method

.method public setOnItemChildClickListener(Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildClickListener;)V
    .locals 0
    .param p1, "onItemChildClickListener"    # Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildClickListener;

    .prologue
    .line 97
    iput-object p1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mOnItemChildClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildClickListener;

    .line 98
    return-void
.end method

.method public setOnItemChildLongClickListener(Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildLongClickListener;)V
    .locals 0
    .param p1, "onItemChildLongClickListener"    # Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildLongClickListener;

    .prologue
    .line 115
    iput-object p1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mOnItemChildLongClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildLongClickListener;

    .line 116
    return-void
.end method

.method public setPosition(I)V
    .locals 0
    .param p1, "position"    # I

    .prologue
    .line 81
    iput p1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mPosition:I

    .line 82
    return-void
.end method

.method public setRecyclerViewHolder(Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;)V
    .locals 0
    .param p1, "recyclerViewHolder"    # Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;

    .prologue
    .line 73
    iput-object p1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mRecyclerViewHolder:Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;

    .line 74
    return-void
.end method

.method public setTag(IILjava/lang/Object;)Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;
    .locals 1
    .param p1, "viewId"    # I
        .annotation build Landroid/support/annotation/IdRes;
        .end annotation
    .end param
    .param p2, "key"    # I
    .param p3, "tag"    # Ljava/lang/Object;

    .prologue
    .line 292
    invoke-virtual {p0, p1}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->getView(I)Landroid/view/View;

    move-result-object v0

    .line 293
    .local v0, "view":Landroid/view/View;
    invoke-virtual {v0, p2, p3}, Landroid/view/View;->setTag(ILjava/lang/Object;)V

    .line 294
    return-object p0
.end method

.method public setTag(ILjava/lang/Object;)Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;
    .locals 1
    .param p1, "viewId"    # I
        .annotation build Landroid/support/annotation/IdRes;
        .end annotation
    .end param
    .param p2, "tag"    # Ljava/lang/Object;

    .prologue
    .line 286
    invoke-virtual {p0, p1}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->getView(I)Landroid/view/View;

    move-result-object v0

    .line 287
    .local v0, "view":Landroid/view/View;
    invoke-virtual {v0, p2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    .line 288
    return-object p0
.end method

.method public setText(II)Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;
    .locals 1
    .param p1, "viewId"    # I
        .annotation build Landroid/support/annotation/IdRes;
        .end annotation
    .end param
    .param p2, "stringResId"    # I
        .annotation build Landroid/support/annotation/StringRes;
        .end annotation
    .end param

    .prologue
    .line 254
    invoke-virtual {p0, p1}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->getView(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 255
    .local v0, "view":Landroid/widget/TextView;
    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setText(I)V

    .line 256
    return-object p0
.end method

.method public setText(ILjava/lang/CharSequence;)Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;
    .locals 1
    .param p1, "viewId"    # I
        .annotation build Landroid/support/annotation/IdRes;
        .end annotation
    .end param
    .param p2, "text"    # Ljava/lang/CharSequence;

    .prologue
    .line 241
    invoke-virtual {p0, p1}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->getView(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 242
    .local v0, "view":Landroid/widget/TextView;
    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 243
    return-object p0
.end method

.method public setTextColor(II)Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;
    .locals 1
    .param p1, "viewId"    # I
        .annotation build Landroid/support/annotation/IdRes;
        .end annotation
    .end param
    .param p2, "textColor"    # I

    .prologue
    .line 332
    invoke-virtual {p0, p1}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->getView(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 333
    .local v0, "view":Landroid/widget/TextView;
    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setTextColor(I)V

    .line 334
    return-object p0
.end method

.method public setTextColorRes(II)Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;
    .locals 2
    .param p1, "viewId"    # I
        .annotation build Landroid/support/annotation/IdRes;
        .end annotation
    .end param
    .param p2, "textColorResId"    # I
        .annotation build Landroid/support/annotation/ColorRes;
        .end annotation
    .end param

    .prologue
    .line 321
    invoke-virtual {p0, p1}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->getView(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 322
    .local v0, "view":Landroid/widget/TextView;
    iget-object v1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, p2}, Landroid/content/res/Resources;->getColor(I)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 323
    return-object p0
.end method

.method public setVisibility(II)Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;
    .locals 1
    .param p1, "viewId"    # I
        .annotation build Landroid/support/annotation/IdRes;
        .end annotation
    .end param
    .param p2, "visibility"    # I

    .prologue
    .line 298
    invoke-virtual {p0, p1}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->getView(I)Landroid/view/View;

    move-result-object v0

    .line 299
    .local v0, "view":Landroid/view/View;
    invoke-virtual {v0, p2}, Landroid/view/View;->setVisibility(I)V

    .line 300
    return-object p0
.end method
