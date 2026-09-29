.class Lcom/cyjh/elfin/fragment/SplashFragment$SettingNetworkListener;
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
    name = "SettingNetworkListener"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/fragment/SplashFragment;


# direct methods
.method private constructor <init>(Lcom/cyjh/elfin/fragment/SplashFragment;)V
    .locals 0

    .prologue
    .line 699
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$SettingNetworkListener;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 703
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$SettingNetworkListener;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    new-instance v1, Landroid/content/Intent;

    const-string v2, "android.settings.DATA_ROAMING_SETTINGS"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->startActivity(Landroid/content/Intent;)V

    .line 704
    return-void
.end method
