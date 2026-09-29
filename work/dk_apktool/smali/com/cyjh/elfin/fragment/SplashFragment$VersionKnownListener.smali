.class Lcom/cyjh/elfin/fragment/SplashFragment$VersionKnownListener;
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
    name = "VersionKnownListener"
.end annotation


# instance fields
.field private mAlertDialog:Landroid/app/AlertDialog;

.field private returnCode:I

.field final synthetic this$0:Lcom/cyjh/elfin/fragment/SplashFragment;


# direct methods
.method public constructor <init>(Lcom/cyjh/elfin/fragment/SplashFragment;Landroid/app/AlertDialog;I)V
    .locals 0
    .param p2, "alertDialog"    # Landroid/app/AlertDialog;
    .param p3, "returnCode"    # I

    .prologue
    .line 729
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$VersionKnownListener;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 730
    iput-object p2, p0, Lcom/cyjh/elfin/fragment/SplashFragment$VersionKnownListener;->mAlertDialog:Landroid/app/AlertDialog;

    .line 731
    iput p3, p0, Lcom/cyjh/elfin/fragment/SplashFragment$VersionKnownListener;->returnCode:I

    .line 732
    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 4
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 735
    iget v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$VersionKnownListener;->returnCode:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 736
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$VersionKnownListener;->mAlertDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->dismiss()V

    .line 737
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$VersionKnownListener;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v0, v0, Lcom/cyjh/elfin/AppContext;->mSharePre:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "server_time"

    const-wide/16 v2, 0x0

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 738
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$VersionKnownListener;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-virtual {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    new-instance v1, Landroid/content/Intent;

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment$VersionKnownListener;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-virtual {v2}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    const-class v3, Lcom/cyjh/elfin/services/PhoneStateService;

    invoke-direct {v1, v2, v3}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {v0, v1}, Landroid/support/v4/app/FragmentActivity;->stopService(Landroid/content/Intent;)Z

    .line 739
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$VersionKnownListener;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-virtual {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    new-instance v1, Landroid/content/Intent;

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment$VersionKnownListener;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-virtual {v2}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    const-class v3, Lcom/cyjh/mobileanjian/ipc/IpcService;

    invoke-direct {v1, v2, v3}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {v0, v1}, Landroid/support/v4/app/FragmentActivity;->stopService(Landroid/content/Intent;)Z

    .line 740
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$VersionKnownListener;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-virtual {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentActivity;->finish()V

    .line 741
    const/4 v0, 0x0

    invoke-static {v0}, Ljava/lang/System;->exit(I)V

    .line 746
    :goto_0
    return-void

    .line 743
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$VersionKnownListener;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$800(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/os/Handler;

    move-result-object v0

    const/16 v1, 0xe

    invoke-virtual {v0, v1}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    .line 744
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$VersionKnownListener;->mAlertDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->dismiss()V

    goto :goto_0
.end method
