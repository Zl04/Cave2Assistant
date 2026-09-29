.class Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment$4;
.super Ljava/lang/Object;
.source "ImageSelectFragment.java"

# interfaces
.implements Ljava/io/FilenameFilter;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->gridViewDatas(Lcom/cyjh/feedback/lib/entities/FolderBean;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;


# direct methods
.method constructor <init>(Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;

    .prologue
    .line 244
    iput-object p1, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment$4;->this$0:Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public accept(Ljava/io/File;Ljava/lang/String;)Z
    .locals 1
    .param p1, "dir"    # Ljava/io/File;
    .param p2, "filename"    # Ljava/lang/String;

    .prologue
    .line 247
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment$4;->this$0:Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;

    invoke-static {v0, p2}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->access$300(Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;Ljava/lang/String;)Z

    move-result v0

    return v0
.end method
