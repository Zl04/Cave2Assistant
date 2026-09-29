.class Lcom/cyjh/elfin/fragment/SplashFragment$ResetNetworkListener;
.super Ljava/lang/Object;
.source "SplashFragment.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/fragment/SplashFragment;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "ResetNetworkListener"
.end annotation


# instance fields
.field private mAlertDialog:Landroid/app/AlertDialog;

.field final synthetic this$0:Lcom/cyjh/elfin/fragment/SplashFragment;


# direct methods
.method public constructor <init>(Lcom/cyjh/elfin/fragment/SplashFragment;Landroid/app/AlertDialog;)V
    .locals 0
    .param p2, "alertDialog"    # Landroid/app/AlertDialog;

    .prologue
    .line 712
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$ResetNetworkListener;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 713
    iput-object p2, p0, Lcom/cyjh/elfin/fragment/SplashFragment$ResetNetworkListener;->mAlertDialog:Landroid/app/AlertDialog;

    .line 714
    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 717
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$ResetNetworkListener;->mAlertDialog:Landroid/app/AlertDialog;

    invoke-virtual {v1}, Landroid/app/AlertDialog;->dismiss()V

    .line 718
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$ResetNetworkListener;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-virtual {v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-static {v1}, Lcom/cyjh/elfin/util/NetworkUtils;->isAvailable(Landroid/content/Context;)Z

    move-result v0

    .line 719
    .local v0, "netFlag":Z
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$ResetNetworkListener;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v1, v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$2500(Lcom/cyjh/elfin/fragment/SplashFragment;Z)V

    .line 720
    return-void
.end method
