.class Lcom/cyjh/elfin/fragment/AdFragment$2;
.super Ljava/lang/Object;
.source "AdFragment.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/fragment/AdFragment;->onClickImageXunFeiAd()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/fragment/AdFragment;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/fragment/AdFragment;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/fragment/AdFragment;

    .prologue
    .line 343
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/AdFragment$2;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    .prologue
    .line 346
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment$2;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/AdFragment;->access$400(Lcom/cyjh/elfin/fragment/AdFragment;)V

    .line 347
    return-void
.end method
