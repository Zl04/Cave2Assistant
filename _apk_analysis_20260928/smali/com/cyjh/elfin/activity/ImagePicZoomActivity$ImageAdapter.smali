.class Lcom/cyjh/elfin/activity/ImagePicZoomActivity$ImageAdapter;
.super Landroid/support/v4/view/PagerAdapter;
.source "ImagePicZoomActivity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/activity/ImagePicZoomActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "ImageAdapter"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/activity/ImagePicZoomActivity;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/activity/ImagePicZoomActivity;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/activity/ImagePicZoomActivity;

    .prologue
    .line 65
    iput-object p1, p0, Lcom/cyjh/elfin/activity/ImagePicZoomActivity$ImageAdapter;->this$0:Lcom/cyjh/elfin/activity/ImagePicZoomActivity;

    invoke-direct {p0}, Landroid/support/v4/view/PagerAdapter;-><init>()V

    return-void
.end method


# virtual methods
.method public destroyItem(Landroid/view/ViewGroup;ILjava/lang/Object;)V
    .locals 1
    .param p1, "container"    # Landroid/view/ViewGroup;
    .param p2, "position"    # I
    .param p3, "object"    # Ljava/lang/Object;

    .prologue
    .line 79
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ImagePicZoomActivity$ImageAdapter;->this$0:Lcom/cyjh/elfin/activity/ImagePicZoomActivity;

    invoke-static {v0}, Lcom/cyjh/elfin/activity/ImagePicZoomActivity;->access$100(Lcom/cyjh/elfin/activity/ImagePicZoomActivity;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V

    .line 80
    return-void
.end method

.method public getCount()I
    .locals 1

    .prologue
    .line 69
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ImagePicZoomActivity$ImageAdapter;->this$0:Lcom/cyjh/elfin/activity/ImagePicZoomActivity;

    invoke-static {v0}, Lcom/cyjh/elfin/activity/ImagePicZoomActivity;->access$000(Lcom/cyjh/elfin/activity/ImagePicZoomActivity;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public instantiateItem(Landroid/view/ViewGroup;I)Ljava/lang/Object;
    .locals 2
    .param p1, "container"    # Landroid/view/ViewGroup;
    .param p2, "position"    # I

    .prologue
    .line 84
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ImagePicZoomActivity$ImageAdapter;->this$0:Lcom/cyjh/elfin/activity/ImagePicZoomActivity;

    invoke-static {v0}, Lcom/squareup/picasso/Picasso;->with(Landroid/content/Context;)Lcom/squareup/picasso/Picasso;

    move-result-object v1

    iget-object v0, p0, Lcom/cyjh/elfin/activity/ImagePicZoomActivity$ImageAdapter;->this$0:Lcom/cyjh/elfin/activity/ImagePicZoomActivity;

    invoke-static {v0}, Lcom/cyjh/elfin/activity/ImagePicZoomActivity;->access$000(Lcom/cyjh/elfin/activity/ImagePicZoomActivity;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v1, v0}, Lcom/squareup/picasso/Picasso;->load(Ljava/lang/String;)Lcom/squareup/picasso/RequestCreator;

    move-result-object v1

    iget-object v0, p0, Lcom/cyjh/elfin/activity/ImagePicZoomActivity$ImageAdapter;->this$0:Lcom/cyjh/elfin/activity/ImagePicZoomActivity;

    invoke-static {v0}, Lcom/cyjh/elfin/activity/ImagePicZoomActivity;->access$100(Lcom/cyjh/elfin/activity/ImagePicZoomActivity;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    invoke-virtual {v1, v0}, Lcom/squareup/picasso/RequestCreator;->into(Landroid/widget/ImageView;)V

    .line 85
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ImagePicZoomActivity$ImageAdapter;->this$0:Lcom/cyjh/elfin/activity/ImagePicZoomActivity;

    invoke-static {v0}, Lcom/cyjh/elfin/activity/ImagePicZoomActivity;->access$100(Lcom/cyjh/elfin/activity/ImagePicZoomActivity;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    .line 86
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ImagePicZoomActivity$ImageAdapter;->this$0:Lcom/cyjh/elfin/activity/ImagePicZoomActivity;

    invoke-static {v0}, Lcom/cyjh/elfin/activity/ImagePicZoomActivity;->access$100(Lcom/cyjh/elfin/activity/ImagePicZoomActivity;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    new-instance v1, Lcom/cyjh/elfin/activity/ImagePicZoomActivity$ImageAdapter$1;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/activity/ImagePicZoomActivity$ImageAdapter$1;-><init>(Lcom/cyjh/elfin/activity/ImagePicZoomActivity$ImageAdapter;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 92
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ImagePicZoomActivity$ImageAdapter;->this$0:Lcom/cyjh/elfin/activity/ImagePicZoomActivity;

    invoke-static {v0}, Lcom/cyjh/elfin/activity/ImagePicZoomActivity;->access$100(Lcom/cyjh/elfin/activity/ImagePicZoomActivity;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public isViewFromObject(Landroid/view/View;Ljava/lang/Object;)Z
    .locals 1
    .param p1, "view"    # Landroid/view/View;
    .param p2, "object"    # Ljava/lang/Object;

    .prologue
    .line 74
    if-ne p1, p2, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method
