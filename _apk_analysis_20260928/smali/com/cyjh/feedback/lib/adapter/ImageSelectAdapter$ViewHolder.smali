.class Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$ViewHolder;
.super Ljava/lang/Object;
.source "ImageSelectAdapter.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "ViewHolder"
.end annotation


# instance fields
.field imageButton:Landroid/widget/ImageButton;

.field imageView:Landroid/widget/ImageView;

.field final synthetic this$0:Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;


# direct methods
.method constructor <init>(Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;

    .prologue
    .line 118
    iput-object p1, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$ViewHolder;->this$0:Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
