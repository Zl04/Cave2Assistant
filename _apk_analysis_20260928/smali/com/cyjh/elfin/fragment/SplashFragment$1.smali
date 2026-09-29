.class Lcom/cyjh/elfin/fragment/SplashFragment$1;
.super Landroid/os/Handler;
.source "SplashFragment.java"


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
    .line 139
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 5
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v4, 0x1

    .line 142
    invoke-super {p0, p1}, Landroid/os/Handler;->handleMessage(Landroid/os/Message;)V

    .line 143
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    iget-object v1, v1, Lcom/cyjh/elfin/fragment/SplashFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "handler\u53d1\u9001\u6d88\u606f\uff1a"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Landroid/os/Message;->what:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 144
    iget v1, p1, Landroid/os/Message;->what:I

    packed-switch v1, :pswitch_data_0

    .line 223
    :cond_0
    :goto_0
    return-void

    .line 146
    :pswitch_0
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$000(Lcom/cyjh/elfin/fragment/SplashFragment;)Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter;

    move-result-object v1

    const-class v2, Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-virtual {v2}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-virtual {v3}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v3

    const-string v4, "GetTemplateManager"

    invoke-virtual {v1, v2, v3, v4}, Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter;->singleApkOrTemplateChecked(Ljava/lang/String;Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_0

    .line 150
    :pswitch_1
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$000(Lcom/cyjh/elfin/fragment/SplashFragment;)Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter;

    move-result-object v1

    const-class v2, Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-virtual {v2}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-virtual {v3}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v3

    const-string v4, "GetMonomerInstallationPackage"

    invoke-virtual {v1, v2, v3, v4}, Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter;->singleApkOrTemplateChecked(Ljava/lang/String;Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_0

    .line 154
    :pswitch_2
    const-string v1, "zzz"

    const-string v2, "SplashFragment--Handler mHandler-BACK_AD_REQ_MESSAGE---1"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 155
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    iget-object v1, v1, Lcom/cyjh/elfin/fragment/SplashFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v2, "BACK_AD_REQ_MESSAGE"

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 156
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$100(Lcom/cyjh/elfin/fragment/SplashFragment;)Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-virtual {v2}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    const-class v3, Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-virtual {v3}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v4, v3}, Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;->adShow(Landroid/content/Context;ILjava/lang/String;)V

    goto :goto_0

    .line 159
    :pswitch_3
    const-string v1, "zzz"

    const-string v2, "SplashFragment---OTHERS_AD_REQ_MESSAGE---1"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 160
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$200(Lcom/cyjh/elfin/fragment/SplashFragment;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 163
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v1, v4}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$202(Lcom/cyjh/elfin/fragment/SplashFragment;Z)Z

    .line 164
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$300(Lcom/cyjh/elfin/fragment/SplashFragment;)Lcom/iflytek/voiceads/IFLYNativeAd;

    move-result-object v1

    invoke-virtual {v1, v4}, Lcom/iflytek/voiceads/IFLYNativeAd;->loadAd(I)V

    .line 165
    const-string v1, "zzz"

    const-string v2, "SplashFragment---OTHERS_AD_REQ_MESSAGE---2"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 166
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$400(Lcom/cyjh/elfin/fragment/SplashFragment;)Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;

    move-result-object v1

    if-nez v1, :cond_1

    .line 167
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    new-instance v2, Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;

    iget-object v3, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-direct {v2, v3}, Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;-><init>(Lcom/cyjh/elfin/fragment/SplashFragment;)V

    invoke-static {v1, v2}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$402(Lcom/cyjh/elfin/fragment/SplashFragment;Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;)Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;

    .line 169
    :cond_1
    const-string v1, "zzz"

    const-string v2, "SplashFragment---OTHERS_AD_REQ_MESSAGE---3\u5f00\u542f\u5b9a\u65f6\u5668"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 170
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$400(Lcom/cyjh/elfin/fragment/SplashFragment;)Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;

    move-result-object v1

    invoke-virtual {v1}, Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;->onStart()V

    .line 172
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    iget-object v1, v1, Lcom/cyjh/elfin/fragment/SplashFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v2, "\u5f00\u59cb\u52a0\u8f7d\u8baf\u98de\u63d2\u4ef6\u5e7f\u544ahandleMessage"

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    goto/16 :goto_0

    .line 175
    :pswitch_4
    const-string v1, "zzz"

    const-string v2, "SplashFragment---CHECKED_XUNFEI_REQ_MESSAGE"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 176
    new-instance v0, Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;

    invoke-direct {v0}, Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;-><init>()V

    .line 177
    .local v0, "iflySwitchManager":Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-virtual {v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-virtual {v0, v1, v4}, Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;->checkedSwitchAd(Landroid/content/Context;I)V

    goto/16 :goto_0

    .line 180
    .end local v0    # "iflySwitchManager":Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;
    :pswitch_5
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-virtual {v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    const/4 v2, 0x2

    invoke-static {v1, v2}, Lcom/cyjh/elfin/mvp/managers/IFLYAdCountStatistics;->requestCountStatistics(Landroid/content/Context;I)V

    goto/16 :goto_0

    .line 183
    :pswitch_6
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$500(Lcom/cyjh/elfin/fragment/SplashFragment;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$600(Lcom/cyjh/elfin/fragment/SplashFragment;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 184
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    iget-object v1, v1, Lcom/cyjh/elfin/fragment/SplashFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ILFY_AD_REPLACE_MESSAGE=="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v3}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$700(Lcom/cyjh/elfin/fragment/SplashFragment;)Lcom/cyjh/elfin/entity/Ad$DataBean;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 185
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$700(Lcom/cyjh/elfin/fragment/SplashFragment;)Lcom/cyjh/elfin/entity/Ad$DataBean;

    move-result-object v1

    if-nez v1, :cond_2

    .line 186
    const-string v1, "zzz"

    const-string v2, "SplashFragment---\u5f00\u5c4f\u5e7f\u544a\u5c55\u793a"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 188
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$800(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/os/Handler;

    move-result-object v1

    const/16 v2, 0xc

    invoke-virtual {v1, v2}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v1

    invoke-virtual {v1}, Landroid/os/Message;->sendToTarget()V

    goto/16 :goto_0

    .line 191
    :cond_2
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    iget-object v1, v1, Lcom/cyjh/elfin/fragment/SplashFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    invoke-static {v1}, Lcom/squareup/picasso/Picasso;->with(Landroid/content/Context;)Lcom/squareup/picasso/Picasso;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v2}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$700(Lcom/cyjh/elfin/fragment/SplashFragment;)Lcom/cyjh/elfin/entity/Ad$DataBean;

    move-result-object v2

    iget-object v2, v2, Lcom/cyjh/elfin/entity/Ad$DataBean;->Url:Ljava/lang/String;

    invoke-virtual {v1, v2}, Lcom/squareup/picasso/Picasso;->load(Ljava/lang/String;)Lcom/squareup/picasso/RequestCreator;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v2}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$900(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/widget/ImageView;

    move-result-object v2

    new-instance v3, Lcom/cyjh/elfin/fragment/SplashFragment$1$1;

    invoke-direct {v3, p0}, Lcom/cyjh/elfin/fragment/SplashFragment$1$1;-><init>(Lcom/cyjh/elfin/fragment/SplashFragment$1;)V

    invoke-virtual {v1, v2, v3}, Lcom/squareup/picasso/RequestCreator;->into(Landroid/widget/ImageView;Lcom/squareup/picasso/Callback;)V

    goto/16 :goto_0

    .line 144
    :pswitch_data_0
    .packed-switch 0xa
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
        :pswitch_6
    .end packed-switch
.end method
