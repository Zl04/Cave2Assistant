.class Lcom/cyjh/elfin/activity/ImagePicZoomActivity$ImageAdapter$1;
.super Ljava/lang/Object;
.source "ImagePicZoomActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/activity/ImagePicZoomActivity$ImageAdapter;->instantiateItem(Landroid/view/ViewGroup;I)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/cyjh/elfin/activity/ImagePicZoomActivity$ImageAdapter;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/activity/ImagePicZoomActivity$ImageAdapter;)V
    .locals 0
    .param p1, "this$1"    # Lcom/cyjh/elfin/activity/ImagePicZoomActivity$ImageAdapter;

    .prologue
    .line 86
    iput-object p1, p0, Lcom/cyjh/elfin/activity/ImagePicZoomActivity$ImageAdapter$1;->this$1:Lcom/cyjh/elfin/activity/ImagePicZoomActivity$ImageAdapter;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 89
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ImagePicZoomActivity$ImageAdapter$1;->this$1:Lcom/cyjh/elfin/activity/ImagePicZoomActivity$ImageAdapter;

    iget-object v0, v0, Lcom/cyjh/elfin/activity/ImagePicZoomActivity$ImageAdapter;->this$0:Lcom/cyjh/elfin/activity/ImagePicZoomActivity;

    invoke-virtual {v0}, Lcom/cyjh/elfin/activity/ImagePicZoomActivity;->finish()V

    .line 90
    return-void
.end method
