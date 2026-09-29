.class Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$ViewHolder;
.super Ljava/lang/Object;
.source "ImageShowAdapter.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "ViewHolder"
.end annotation


# instance fields
.field imgDeteleSelect:Landroid/widget/ImageView;

.field iv:Landroid/widget/ImageView;

.field final synthetic this$0:Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;


# direct methods
.method constructor <init>(Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;

    .prologue
    .line 109
    iput-object p1, p0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$ViewHolder;->this$0:Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
