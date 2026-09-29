.class Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageHolder;
.super Ljava/lang/Object;
.source "ImageLoader.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/feedback/lib/utils/ImageLoader;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "ImageHolder"
.end annotation


# instance fields
.field bitmap:Landroid/graphics/Bitmap;

.field imageView:Landroid/widget/ImageView;

.field path:Ljava/lang/String;

.field final synthetic this$0:Lcom/cyjh/feedback/lib/utils/ImageLoader;


# direct methods
.method constructor <init>(Lcom/cyjh/feedback/lib/utils/ImageLoader;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/feedback/lib/utils/ImageLoader;

    .prologue
    .line 365
    iput-object p1, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageHolder;->this$0:Lcom/cyjh/feedback/lib/utils/ImageLoader;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
