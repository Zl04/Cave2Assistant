.class Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageSize;
.super Ljava/lang/Object;
.source "ImageLoader.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/feedback/lib/utils/ImageLoader;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "ImageSize"
.end annotation


# instance fields
.field imageHeight:I

.field imageWidth:I

.field final synthetic this$0:Lcom/cyjh/feedback/lib/utils/ImageLoader;


# direct methods
.method constructor <init>(Lcom/cyjh/feedback/lib/utils/ImageLoader;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/feedback/lib/utils/ImageLoader;

    .prologue
    .line 371
    iput-object p1, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageSize;->this$0:Lcom/cyjh/feedback/lib/utils/ImageLoader;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
