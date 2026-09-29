.class Lcom/cyjh/elfin/fragment/SplashFragment$4;
.super Ljava/lang/Object;
.source "SplashFragment.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/fragment/SplashFragment;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/fragment/SplashFragment;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/fragment/SplashFragment;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 869
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$4;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1
    .param p1, "view"    # Landroid/view/View;

    .prologue
    .line 872
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$4;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0, p1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$1900(Lcom/cyjh/elfin/fragment/SplashFragment;Landroid/view/View;)V

    .line 873
    return-void
.end method
