.class Lcom/cyjh/elfin/fragment/OptionFragment$4;
.super Landroid/os/Handler;
.source "OptionFragment.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/fragment/OptionFragment;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/fragment/OptionFragment;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/fragment/OptionFragment;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/fragment/OptionFragment;

    .prologue
    .line 1171
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$4;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 4
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v3, 0x1

    .line 1174
    invoke-super {p0, p1}, Landroid/os/Handler;->handleMessage(Landroid/os/Message;)V

    .line 1175
    iget v1, p1, Landroid/os/Message;->what:I

    packed-switch v1, :pswitch_data_0

    .line 1208
    :goto_0
    return-void

    .line 1177
    :pswitch_0
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$4;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    iget-object v1, v1, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v1, v1, Lcom/cyjh/elfin/AppContext;->sharedPreferences:Landroid/content/SharedPreferences;

    const-string v2, "com.cyjh.elfin.20150527"

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v1, "http.agent"

    .line 1178
    invoke-static {v1}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "MIUI"

    invoke-virtual {v1, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1179
    new-instance v0, Lcom/cyjh/elfin/dialog/MIUIGuideDialog;

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$4;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$500(Lcom/cyjh/elfin/fragment/OptionFragment;)Lcom/cyjh/elfin/activity/ElfinFreeActivity;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/cyjh/elfin/dialog/MIUIGuideDialog;-><init>(Landroid/content/Context;)V

    .line 1180
    .local v0, "miuiGuideDialog":Lcom/cyjh/elfin/dialog/MIUIGuideDialog;
    invoke-virtual {v0}, Lcom/cyjh/elfin/dialog/MIUIGuideDialog;->show()V

    goto :goto_0

    .line 1182
    .end local v0    # "miuiGuideDialog":Lcom/cyjh/elfin/dialog/MIUIGuideDialog;
    :cond_0
    invoke-static {}, Lcom/cyjh/elfin/rom/FloatWindowManager;->getInstance()Lcom/cyjh/elfin/rom/FloatWindowManager;

    move-result-object v1

    invoke-static {}, Lcom/cyjh/elfin/AppContext;->getInstance()Lcom/cyjh/elfin/AppContext;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/rom/FloatWindowManager;->checkPermission(Landroid/content/Context;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 1183
    invoke-static {}, Lcom/cyjh/elfin/rom/FloatWindowManager;->getInstance()Lcom/cyjh/elfin/rom/FloatWindowManager;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment$4;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-virtual {v2}, Lcom/cyjh/elfin/fragment/OptionFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/rom/FloatWindowManager;->applyPermission(Landroid/content/Context;)V

    goto :goto_0

    .line 1185
    :cond_1
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$4;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    iget-object v1, v1, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget v1, v1, Lcom/cyjh/elfin/AppContext;->STATE_SCRIPT:I

    if-nez v1, :cond_2

    .line 1186
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$4;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    iget-object v1, v1, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iput v3, v1, Lcom/cyjh/elfin/AppContext;->STATE_SCRIPT:I

    .line 1188
    :cond_2
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$4;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$500(Lcom/cyjh/elfin/fragment/OptionFragment;)Lcom/cyjh/elfin/activity/ElfinFreeActivity;

    move-result-object v1

    invoke-virtual {v1, v3}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->moveTaskToBack(Z)Z

    .line 1189
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$4;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    iget-object v1, v1, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    invoke-virtual {v1}, Lcom/cyjh/elfin/AppContext;->showFloatView()V

    .line 1190
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$4;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    iget-object v1, v1, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v1, v1, Lcom/cyjh/elfin/AppContext;->mElfinFloatView:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment$4;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-virtual {v2}, Lcom/cyjh/elfin/fragment/OptionFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->setmContext(Landroid/content/Context;)V

    goto :goto_0

    .line 1195
    :pswitch_1
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$4;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$1000(Lcom/cyjh/elfin/fragment/OptionFragment;)Lcom/cyjh/elfin/entity/Ad;

    move-result-object v1

    if-eqz v1, :cond_3

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$4;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$1000(Lcom/cyjh/elfin/fragment/OptionFragment;)Lcom/cyjh/elfin/entity/Ad;

    move-result-object v1

    iget-object v1, v1, Lcom/cyjh/elfin/entity/Ad;->Data:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_3

    .line 1196
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$4;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment$4;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v2}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$1000(Lcom/cyjh/elfin/fragment/OptionFragment;)Lcom/cyjh/elfin/entity/Ad;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$1100(Lcom/cyjh/elfin/fragment/OptionFragment;Lcom/cyjh/elfin/entity/Ad;)V

    goto/16 :goto_0

    .line 1198
    :cond_3
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$4;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    const/4 v2, 0x0

    invoke-static {v1, v2}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$1202(Lcom/cyjh/elfin/fragment/OptionFragment;Z)Z

    goto/16 :goto_0

    .line 1203
    :pswitch_2
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$4;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-virtual {v1}, Lcom/cyjh/elfin/fragment/OptionFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    const/4 v2, 0x4

    invoke-static {v1, v2}, Lcom/cyjh/elfin/mvp/managers/IFLYAdCountStatistics;->requestCountStatistics(Landroid/content/Context;I)V

    goto/16 :goto_0

    .line 1175
    :pswitch_data_0
    .packed-switch 0x64
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method
