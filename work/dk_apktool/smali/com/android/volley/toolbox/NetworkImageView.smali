.class public Lcom/android/volley/toolbox/NetworkImageView;
.super Landroid/widget/ImageView;
.source "NetworkImageView.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/volley/toolbox/NetworkImageView$ImageURLBuilder;
    }
.end annotation


# instance fields
.field private mDefaultImageId:I

.field private mErrorImageId:I

.field private mImageContainer:Lcom/android/volley/toolbox/ImageLoader$ImageContainer;

.field private mImageLoader:Lcom/android/volley/toolbox/ImageLoader;

.field private mTransformation:Lcom/android/volley/toolbox/ImageRequest$Transformation;

.field private mUrl:Ljava/lang/String;

.field private mUrlBuilder:Lcom/android/volley/toolbox/NetworkImageView$ImageURLBuilder;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 74
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/android/volley/toolbox/NetworkImageView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 75
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .prologue
    .line 78
    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Lcom/android/volley/toolbox/NetworkImageView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 79
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;
    .param p3, "defStyle"    # I

    .prologue
    .line 82
    invoke-direct {p0, p1, p2, p3}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 83
    return-void
.end method

.method static synthetic access$000(Lcom/android/volley/toolbox/NetworkImageView;)I
    .locals 1
    .param p0, "x0"    # Lcom/android/volley/toolbox/NetworkImageView;

    .prologue
    .line 31
    iget v0, p0, Lcom/android/volley/toolbox/NetworkImageView;->mErrorImageId:I

    return v0
.end method

.method static synthetic access$100(Lcom/android/volley/toolbox/NetworkImageView;)I
    .locals 1
    .param p0, "x0"    # Lcom/android/volley/toolbox/NetworkImageView;

    .prologue
    .line 31
    iget v0, p0, Lcom/android/volley/toolbox/NetworkImageView;->mDefaultImageId:I

    return v0
.end method

.method private setDefaultImageOrNull()V
    .locals 1

    .prologue
    .line 225
    iget v0, p0, Lcom/android/volley/toolbox/NetworkImageView;->mDefaultImageId:I

    if-eqz v0, :cond_0

    .line 226
    iget v0, p0, Lcom/android/volley/toolbox/NetworkImageView;->mDefaultImageId:I

    invoke-virtual {p0, v0}, Lcom/android/volley/toolbox/NetworkImageView;->setImageResource(I)V

    .line 231
    :goto_0
    return-void

    .line 229
    :cond_0
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/android/volley/toolbox/NetworkImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    goto :goto_0
.end method


# virtual methods
.method protected drawableStateChanged()V
    .locals 0

    .prologue
    .line 254
    invoke-super {p0}, Landroid/widget/ImageView;->drawableStateChanged()V

    .line 255
    invoke-virtual {p0}, Lcom/android/volley/toolbox/NetworkImageView;->invalidate()V

    .line 256
    return-void
.end method

.method loadImageIfNecessary(Z)V
    .locals 19
    .param p1, "isInLayoutPass"    # Z

    .prologue
    .line 134
    invoke-virtual/range {p0 .. p0}, Lcom/android/volley/toolbox/NetworkImageView;->getWidth()I

    move-result v16

    .line 135
    .local v16, "width":I
    invoke-virtual/range {p0 .. p0}, Lcom/android/volley/toolbox/NetworkImageView;->getHeight()I

    move-result v13

    .line 136
    .local v13, "height":I
    invoke-virtual/range {p0 .. p0}, Lcom/android/volley/toolbox/NetworkImageView;->getScaleType()Landroid/widget/ImageView$ScaleType;

    move-result-object v11

    .line 138
    .local v11, "scaleType":Landroid/widget/ImageView$ScaleType;
    const/16 v18, 0x0

    .local v18, "wrapWidth":Z
    const/16 v17, 0x0

    .line 139
    .local v17, "wrapHeight":Z
    invoke-virtual/range {p0 .. p0}, Lcom/android/volley/toolbox/NetworkImageView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v2

    if-eqz v2, :cond_0

    .line 140
    invoke-virtual/range {p0 .. p0}, Lcom/android/volley/toolbox/NetworkImageView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v2

    iget v2, v2, Landroid/view/ViewGroup$LayoutParams;->width:I

    const/4 v3, -0x2

    if-ne v2, v3, :cond_2

    const/16 v18, 0x1

    .line 141
    :goto_0
    invoke-virtual/range {p0 .. p0}, Lcom/android/volley/toolbox/NetworkImageView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v2

    iget v2, v2, Landroid/view/ViewGroup$LayoutParams;->height:I

    const/4 v3, -0x2

    if-ne v2, v3, :cond_3

    const/16 v17, 0x1

    .line 146
    :cond_0
    :goto_1
    if-eqz v18, :cond_4

    if-eqz v17, :cond_4

    const/4 v14, 0x1

    .line 147
    .local v14, "isFullyWrapContent":Z
    :goto_2
    if-nez v16, :cond_5

    if-nez v13, :cond_5

    if-nez v14, :cond_5

    .line 222
    :cond_1
    :goto_3
    return-void

    .line 140
    .end local v14    # "isFullyWrapContent":Z
    :cond_2
    const/16 v18, 0x0

    goto :goto_0

    .line 141
    :cond_3
    const/16 v17, 0x0

    goto :goto_1

    .line 146
    :cond_4
    const/4 v14, 0x0

    goto :goto_2

    .line 153
    .restart local v14    # "isFullyWrapContent":Z
    :cond_5
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/volley/toolbox/NetworkImageView;->mUrl:Ljava/lang/String;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_7

    .line 154
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/volley/toolbox/NetworkImageView;->mImageContainer:Lcom/android/volley/toolbox/ImageLoader$ImageContainer;

    if-eqz v2, :cond_6

    .line 155
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/volley/toolbox/NetworkImageView;->mImageContainer:Lcom/android/volley/toolbox/ImageLoader$ImageContainer;

    invoke-virtual {v2}, Lcom/android/volley/toolbox/ImageLoader$ImageContainer;->cancelRequest()V

    .line 156
    const/4 v2, 0x0

    move-object/from16 v0, p0

    iput-object v2, v0, Lcom/android/volley/toolbox/NetworkImageView;->mImageContainer:Lcom/android/volley/toolbox/ImageLoader$ImageContainer;

    .line 158
    :cond_6
    invoke-direct/range {p0 .. p0}, Lcom/android/volley/toolbox/NetworkImageView;->setDefaultImageOrNull()V

    goto :goto_3

    .line 163
    :cond_7
    if-eqz v18, :cond_a

    const/4 v4, 0x0

    .line 164
    .local v4, "maxWidth":I
    :goto_4
    if-eqz v17, :cond_b

    const/4 v5, 0x0

    .line 167
    .local v5, "maxHeight":I
    :goto_5
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/android/volley/toolbox/NetworkImageView;->mUrl:Ljava/lang/String;

    .line 168
    .local v7, "tmpUrl":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/volley/toolbox/NetworkImageView;->mUrlBuilder:Lcom/android/volley/toolbox/NetworkImageView$ImageURLBuilder;

    if-eqz v2, :cond_8

    .line 169
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/volley/toolbox/NetworkImageView;->mUrlBuilder:Lcom/android/volley/toolbox/NetworkImageView$ImageURLBuilder;

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/android/volley/toolbox/NetworkImageView;->mUrl:Ljava/lang/String;

    invoke-virtual/range {p0 .. p0}, Lcom/android/volley/toolbox/NetworkImageView;->getScaleType()Landroid/widget/ImageView$ScaleType;

    move-result-object v6

    invoke-virtual/range {p0 .. p0}, Lcom/android/volley/toolbox/NetworkImageView;->getContext()Landroid/content/Context;

    move-result-object v8

    invoke-virtual {v8}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v7

    .end local v7    # "tmpUrl":Ljava/lang/String;
    invoke-interface/range {v2 .. v7}, Lcom/android/volley/toolbox/NetworkImageView$ImageURLBuilder;->buildUrl(Ljava/lang/String;IILandroid/widget/ImageView$ScaleType;Landroid/content/Context;)Ljava/lang/String;

    move-result-object v7

    .line 173
    .restart local v7    # "tmpUrl":Ljava/lang/String;
    :cond_8
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/volley/toolbox/NetworkImageView;->mImageContainer:Lcom/android/volley/toolbox/ImageLoader$ImageContainer;

    if-eqz v2, :cond_9

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/volley/toolbox/NetworkImageView;->mImageContainer:Lcom/android/volley/toolbox/ImageLoader$ImageContainer;

    invoke-virtual {v2}, Lcom/android/volley/toolbox/ImageLoader$ImageContainer;->getRequestUrl()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_9

    .line 174
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/volley/toolbox/NetworkImageView;->mImageContainer:Lcom/android/volley/toolbox/ImageLoader$ImageContainer;

    invoke-virtual {v2}, Lcom/android/volley/toolbox/ImageLoader$ImageContainer;->getRequestUrl()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 179
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/volley/toolbox/NetworkImageView;->mImageContainer:Lcom/android/volley/toolbox/ImageLoader$ImageContainer;

    invoke-virtual {v2}, Lcom/android/volley/toolbox/ImageLoader$ImageContainer;->cancelRequest()V

    .line 180
    invoke-direct/range {p0 .. p0}, Lcom/android/volley/toolbox/NetworkImageView;->setDefaultImageOrNull()V

    .line 187
    :cond_9
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/android/volley/toolbox/NetworkImageView;->mImageLoader:Lcom/android/volley/toolbox/ImageLoader;

    new-instance v8, Lcom/android/volley/toolbox/NetworkImageView$1;

    move-object/from16 v0, p0

    move/from16 v1, p1

    invoke-direct {v8, v0, v1}, Lcom/android/volley/toolbox/NetworkImageView$1;-><init>(Lcom/android/volley/toolbox/NetworkImageView;Z)V

    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/volley/toolbox/NetworkImageView;->mTransformation:Lcom/android/volley/toolbox/ImageRequest$Transformation;

    move v9, v4

    move v10, v5

    invoke-virtual/range {v6 .. v12}, Lcom/android/volley/toolbox/ImageLoader;->get(Ljava/lang/String;Lcom/android/volley/toolbox/ImageLoader$ImageListener;IILandroid/widget/ImageView$ScaleType;Lcom/android/volley/toolbox/ImageRequest$Transformation;)Lcom/android/volley/toolbox/ImageLoader$ImageContainer;

    move-result-object v15

    .line 221
    .local v15, "newContainer":Lcom/android/volley/toolbox/ImageLoader$ImageContainer;
    move-object/from16 v0, p0

    iput-object v15, v0, Lcom/android/volley/toolbox/NetworkImageView;->mImageContainer:Lcom/android/volley/toolbox/ImageLoader$ImageContainer;

    goto/16 :goto_3

    .end local v4    # "maxWidth":I
    .end local v5    # "maxHeight":I
    .end local v7    # "tmpUrl":Ljava/lang/String;
    .end local v15    # "newContainer":Lcom/android/volley/toolbox/ImageLoader$ImageContainer;
    :cond_a
    move/from16 v4, v16

    .line 163
    goto :goto_4

    .restart local v4    # "maxWidth":I
    :cond_b
    move v5, v13

    .line 164
    goto :goto_5
.end method

.method protected onDetachedFromWindow()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 241
    iget-object v0, p0, Lcom/android/volley/toolbox/NetworkImageView;->mImageContainer:Lcom/android/volley/toolbox/ImageLoader$ImageContainer;

    if-eqz v0, :cond_0

    .line 244
    iget-object v0, p0, Lcom/android/volley/toolbox/NetworkImageView;->mImageContainer:Lcom/android/volley/toolbox/ImageLoader$ImageContainer;

    invoke-virtual {v0}, Lcom/android/volley/toolbox/ImageLoader$ImageContainer;->cancelRequest()V

    .line 245
    invoke-virtual {p0, v1}, Lcom/android/volley/toolbox/NetworkImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    .line 247
    iput-object v1, p0, Lcom/android/volley/toolbox/NetworkImageView;->mImageContainer:Lcom/android/volley/toolbox/ImageLoader$ImageContainer;

    .line 249
    :cond_0
    invoke-super {p0}, Landroid/widget/ImageView;->onDetachedFromWindow()V

    .line 250
    return-void
.end method

.method protected onLayout(ZIIII)V
    .locals 1
    .param p1, "changed"    # Z
    .param p2, "left"    # I
    .param p3, "top"    # I
    .param p4, "right"    # I
    .param p5, "bottom"    # I

    .prologue
    .line 235
    invoke-super/range {p0 .. p5}, Landroid/widget/ImageView;->onLayout(ZIIII)V

    .line 236
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/android/volley/toolbox/NetworkImageView;->loadImageIfNecessary(Z)V

    .line 237
    return-void
.end method

.method public setDefaultImageResId(I)V
    .locals 0
    .param p1, "defaultImage"    # I

    .prologue
    .line 114
    iput p1, p0, Lcom/android/volley/toolbox/NetworkImageView;->mDefaultImageId:I

    .line 115
    return-void
.end method

.method public setErrorImageResId(I)V
    .locals 0
    .param p1, "errorImage"    # I

    .prologue
    .line 122
    iput p1, p0, Lcom/android/volley/toolbox/NetworkImageView;->mErrorImageId:I

    .line 123
    return-void
.end method

.method public setImageUrl(Ljava/lang/String;Lcom/android/volley/toolbox/ImageLoader;)V
    .locals 1
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "imageLoader"    # Lcom/android/volley/toolbox/ImageLoader;

    .prologue
    .line 98
    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0}, Lcom/android/volley/toolbox/NetworkImageView;->setImageUrl(Ljava/lang/String;Lcom/android/volley/toolbox/ImageLoader;Lcom/android/volley/toolbox/NetworkImageView$ImageURLBuilder;)V

    .line 99
    return-void
.end method

.method public setImageUrl(Ljava/lang/String;Lcom/android/volley/toolbox/ImageLoader;Lcom/android/volley/toolbox/NetworkImageView$ImageURLBuilder;)V
    .locals 1
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "imageLoader"    # Lcom/android/volley/toolbox/ImageLoader;
    .param p3, "urlBuilder"    # Lcom/android/volley/toolbox/NetworkImageView$ImageURLBuilder;

    .prologue
    .line 102
    iput-object p1, p0, Lcom/android/volley/toolbox/NetworkImageView;->mUrl:Ljava/lang/String;

    .line 103
    iput-object p2, p0, Lcom/android/volley/toolbox/NetworkImageView;->mImageLoader:Lcom/android/volley/toolbox/ImageLoader;

    .line 104
    iput-object p3, p0, Lcom/android/volley/toolbox/NetworkImageView;->mUrlBuilder:Lcom/android/volley/toolbox/NetworkImageView$ImageURLBuilder;

    .line 106
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/android/volley/toolbox/NetworkImageView;->loadImageIfNecessary(Z)V

    .line 107
    return-void
.end method

.method public setTransformation(Lcom/android/volley/toolbox/ImageRequest$Transformation;)V
    .locals 0
    .param p1, "transformation"    # Lcom/android/volley/toolbox/ImageRequest$Transformation;

    .prologue
    .line 126
    iput-object p1, p0, Lcom/android/volley/toolbox/NetworkImageView;->mTransformation:Lcom/android/volley/toolbox/ImageRequest$Transformation;

    .line 127
    return-void
.end method
