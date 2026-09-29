.class Lcom/cyjh/feedback/lib/utils/ImageLoader$3;
.super Landroid/os/Handler;
.source "ImageLoader.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/feedback/lib/utils/ImageLoader;->imageLoader(Ljava/lang/String;Landroid/widget/ImageView;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/feedback/lib/utils/ImageLoader;


# direct methods
.method constructor <init>(Lcom/cyjh/feedback/lib/utils/ImageLoader;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/feedback/lib/utils/ImageLoader;

    .prologue
    .line 175
    iput-object p1, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader$3;->this$0:Lcom/cyjh/feedback/lib/utils/ImageLoader;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 5
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 179
    iget-object v2, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v2, Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageHolder;

    .line 180
    .local v2, "mHolder":Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageHolder;
    iget-object v0, v2, Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageHolder;->bitmap:Landroid/graphics/Bitmap;

    .line 181
    .local v0, "bitmap":Landroid/graphics/Bitmap;
    iget-object v3, v2, Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageHolder;->path:Ljava/lang/String;

    .line 182
    .local v3, "path":Ljava/lang/String;
    iget-object v1, v2, Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageHolder;->imageView:Landroid/widget/ImageView;

    .line 183
    .local v1, "imageview":Landroid/widget/ImageView;
    invoke-virtual {v1}, Landroid/widget/ImageView;->getTag()Ljava/lang/Object;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 184
    invoke-virtual {v1, v0}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    .line 186
    :cond_0
    return-void
.end method
