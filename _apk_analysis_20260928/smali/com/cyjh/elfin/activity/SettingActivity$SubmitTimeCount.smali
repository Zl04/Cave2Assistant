.class Lcom/cyjh/elfin/activity/SettingActivity$SubmitTimeCount;
.super Landroid/os/CountDownTimer;
.source "SettingActivity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/activity/SettingActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "SubmitTimeCount"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/activity/SettingActivity;


# direct methods
.method private constructor <init>(Lcom/cyjh/elfin/activity/SettingActivity;JJ)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/activity/SettingActivity;
    .param p2, "millisInFuture"    # J
    .param p4, "countDownInterval"    # J

    .prologue
    .line 231
    iput-object p1, p0, Lcom/cyjh/elfin/activity/SettingActivity$SubmitTimeCount;->this$0:Lcom/cyjh/elfin/activity/SettingActivity;

    .line 233
    invoke-direct {p0, p2, p3, p4, p5}, Landroid/os/CountDownTimer;-><init>(JJ)V

    .line 234
    return-void
.end method

.method synthetic constructor <init>(Lcom/cyjh/elfin/activity/SettingActivity;JJLcom/cyjh/elfin/activity/SettingActivity$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/cyjh/elfin/activity/SettingActivity;
    .param p2, "x1"    # J
    .param p4, "x2"    # J
    .param p6, "x3"    # Lcom/cyjh/elfin/activity/SettingActivity$1;

    .prologue
    .line 230
    invoke-direct/range {p0 .. p5}, Lcom/cyjh/elfin/activity/SettingActivity$SubmitTimeCount;-><init>(Lcom/cyjh/elfin/activity/SettingActivity;JJ)V

    return-void
.end method


# virtual methods
.method public onFinish()V
    .locals 1

    .prologue
    .line 238
    iget-object v0, p0, Lcom/cyjh/elfin/activity/SettingActivity$SubmitTimeCount;->this$0:Lcom/cyjh/elfin/activity/SettingActivity;

    invoke-static {v0}, Lcom/cyjh/elfin/activity/SettingActivity;->access$200(Lcom/cyjh/elfin/activity/SettingActivity;)Lcom/cyjh/feedback/lib/dialog/FeedBackCommitDialog;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/feedback/lib/dialog/FeedBackCommitDialog;->isShowing()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 239
    iget-object v0, p0, Lcom/cyjh/elfin/activity/SettingActivity$SubmitTimeCount;->this$0:Lcom/cyjh/elfin/activity/SettingActivity;

    invoke-static {v0}, Lcom/cyjh/elfin/activity/SettingActivity;->access$200(Lcom/cyjh/elfin/activity/SettingActivity;)Lcom/cyjh/feedback/lib/dialog/FeedBackCommitDialog;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/feedback/lib/dialog/FeedBackCommitDialog;->dismiss()V

    .line 241
    :cond_0
    return-void
.end method

.method public onTick(J)V
    .locals 0
    .param p1, "millisUntilFinished"    # J

    .prologue
    .line 246
    return-void
.end method
