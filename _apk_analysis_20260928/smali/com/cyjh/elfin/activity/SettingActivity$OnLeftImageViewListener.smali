.class Lcom/cyjh/elfin/activity/SettingActivity$OnLeftImageViewListener;
.super Ljava/lang/Object;
.source "SettingActivity.java"

# interfaces
.implements Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/activity/SettingActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "OnLeftImageViewListener"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/activity/SettingActivity;


# direct methods
.method private constructor <init>(Lcom/cyjh/elfin/activity/SettingActivity;)V
    .locals 0

    .prologue
    .line 150
    iput-object p1, p0, Lcom/cyjh/elfin/activity/SettingActivity$OnLeftImageViewListener;->this$0:Lcom/cyjh/elfin/activity/SettingActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/cyjh/elfin/activity/SettingActivity;Lcom/cyjh/elfin/activity/SettingActivity$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/cyjh/elfin/activity/SettingActivity;
    .param p2, "x1"    # Lcom/cyjh/elfin/activity/SettingActivity$1;

    .prologue
    .line 150
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/activity/SettingActivity$OnLeftImageViewListener;-><init>(Lcom/cyjh/elfin/activity/SettingActivity;)V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1
    .param p1, "view"    # Landroid/view/View;

    .prologue
    .line 153
    iget-object v0, p0, Lcom/cyjh/elfin/activity/SettingActivity$OnLeftImageViewListener;->this$0:Lcom/cyjh/elfin/activity/SettingActivity;

    invoke-virtual {v0}, Lcom/cyjh/elfin/activity/SettingActivity;->finish()V

    .line 154
    return-void
.end method
