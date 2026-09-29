.class public Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;
.super Lcom/cyjh/feedback/lib/base/BaseDialog;
.source "FeedBackDialog.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/feedback/lib/dialog/FeedBackDialog$OnResultCode;
    }
.end annotation


# static fields
.field private static final DEFAULT:Ljava/lang/String;

.field private static final NO_ROOT:I = 0x2

.field private static final YES_ROOT:I = 0x1


# instance fields
.field private code:I

.field private mBtnBack:Landroid/widget/Button;

.field private mBtnCommit:Landroid/widget/Button;

.field private mContext:Landroid/content/Context;

.field private mFeedBackInfo:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

.field private mLoadingDialog:Lcom/cyjh/feedback/lib/dialog/LoadingDialog;

.field private mTvDeicesName:Landroid/widget/TextView;

.field private mTvDevicesRoot:Landroid/widget/TextView;

.field private mTvDevicesSystem:Landroid/widget/TextView;

.field private mTvFeedBackContent:Landroid/widget/TextView;

.field private onResultCode:Lcom/cyjh/feedback/lib/dialog/FeedBackDialog$OnResultCode;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 38
    const/4 v0, 0x0

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->DEFAULT:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "feedBackInfoBean"    # Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    .prologue
    .line 52
    sget v0, Lcom/cyjh/feedback/libraryfeedbackinfo/R$style;->Theme_Dialog:I

    invoke-direct {p0, p1, v0}, Lcom/cyjh/feedback/lib/base/BaseDialog;-><init>(Landroid/content/Context;I)V

    .line 50
    const/4 v0, 0x0

    iput v0, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->code:I

    .line 53
    iput-object p2, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mFeedBackInfo:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    .line 54
    iput-object p1, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mContext:Landroid/content/Context;

    .line 55
    return-void
.end method

.method static synthetic access$000(Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;)Lcom/cyjh/feedback/lib/dialog/LoadingDialog;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;

    .prologue
    .line 37
    iget-object v0, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mLoadingDialog:Lcom/cyjh/feedback/lib/dialog/LoadingDialog;

    return-object v0
.end method

.method static synthetic access$100(Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;Lorg/json/JSONObject;)V
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;
    .param p1, "x1"    # Lorg/json/JSONObject;

    .prologue
    .line 37
    invoke-direct {p0, p1}, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->parseJsonObject(Lorg/json/JSONObject;)V

    return-void
.end method

.method static synthetic access$200(Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;)Landroid/content/Context;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;

    .prologue
    .line 37
    iget-object v0, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mContext:Landroid/content/Context;

    return-object v0
.end method

.method private getTextPartColor(Ljava/lang/String;Ljava/lang/String;)Landroid/text/SpannableStringBuilder;
    .locals 5
    .param p1, "allStr"    # Ljava/lang/String;
    .param p2, "partStr"    # Ljava/lang/String;

    .prologue
    .line 112
    invoke-virtual {p1, p2}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v1

    .line 113
    .local v1, "start":I
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v3

    add-int v0, v1, v3

    .line 114
    .local v0, "end":I
    new-instance v2, Landroid/text/SpannableStringBuilder;

    invoke-direct {v2, p1}, Landroid/text/SpannableStringBuilder;-><init>(Ljava/lang/CharSequence;)V

    .line 115
    .local v2, "styleText":Landroid/text/SpannableStringBuilder;
    new-instance v3, Landroid/text/style/ForegroundColorSpan;

    const-string v4, "#3c7ac5"

    invoke-static {v4}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v4

    invoke-direct {v3, v4}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    const/16 v4, 0x22

    invoke-virtual {v2, v3, v1, v0, v4}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    .line 116
    return-object v2
.end method

.method private initData()V
    .locals 7

    .prologue
    const/4 v5, 0x1

    const/4 v6, 0x0

    .line 77
    iget-object v1, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mContext:Landroid/content/Context;

    sget v2, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->devices_name:I

    new-array v3, v5, [Ljava/lang/Object;

    iget-object v4, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mFeedBackInfo:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-virtual {v4}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->getModel()Ljava/lang/String;

    move-result-object v4

    aput-object v4, v3, v6

    invoke-virtual {v1, v2, v3}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 78
    .local v0, "str":Ljava/lang/String;
    iget-object v1, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mTvDeicesName:Landroid/widget/TextView;

    iget-object v2, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mFeedBackInfo:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-virtual {v2}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->getModel()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v0, v2}, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->getTextPartColor(Ljava/lang/String;Ljava/lang/String;)Landroid/text/SpannableStringBuilder;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 79
    iget-object v1, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mContext:Landroid/content/Context;

    sget v2, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->devices_use_system:I

    new-array v3, v5, [Ljava/lang/Object;

    iget-object v4, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mFeedBackInfo:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-virtual {v4}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->getAndoridData()Ljava/lang/String;

    move-result-object v4

    aput-object v4, v3, v6

    invoke-virtual {v1, v2, v3}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 80
    iget-object v1, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mTvDevicesSystem:Landroid/widget/TextView;

    iget-object v2, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mFeedBackInfo:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-virtual {v2}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->getAndoridData()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v0, v2}, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->getTextPartColor(Ljava/lang/String;Ljava/lang/String;)Landroid/text/SpannableStringBuilder;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 81
    iget-object v1, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mFeedBackInfo:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-virtual {v1}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->getRooStatus()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    packed-switch v1, :pswitch_data_0

    .line 93
    :goto_0
    iget-object v1, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mFeedBackInfo:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-virtual {v1}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->getFeedBack()Ljava/lang/String;

    move-result-object v1

    sget-object v2, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->DEFAULT:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 94
    iget-object v1, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mTvFeedBackContent:Landroid/widget/TextView;

    iget-object v2, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mFeedBackInfo:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-virtual {v2}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->getFeedBack()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 96
    :cond_0
    new-instance v1, Lcom/cyjh/feedback/lib/dialog/LoadingDialog;

    iget-object v2, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mContext:Landroid/content/Context;

    invoke-direct {v1, v2}, Lcom/cyjh/feedback/lib/dialog/LoadingDialog;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mLoadingDialog:Lcom/cyjh/feedback/lib/dialog/LoadingDialog;

    .line 97
    return-void

    .line 83
    :pswitch_0
    iget-object v1, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mContext:Landroid/content/Context;

    sget v2, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->devices_is_root:I

    new-array v3, v5, [Ljava/lang/Object;

    iget-object v4, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mContext:Landroid/content/Context;

    sget v5, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->devices_yes_root:I

    invoke-virtual {v4, v5}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v3, v6

    invoke-virtual {v1, v2, v3}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 84
    iget-object v1, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mTvDevicesRoot:Landroid/widget/TextView;

    iget-object v2, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mContext:Landroid/content/Context;

    sget v3, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->devices_yes_root:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v0, v2}, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->getTextPartColor(Ljava/lang/String;Ljava/lang/String;)Landroid/text/SpannableStringBuilder;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 87
    :pswitch_1
    iget-object v1, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mContext:Landroid/content/Context;

    sget v2, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->devices_is_root:I

    new-array v3, v5, [Ljava/lang/Object;

    iget-object v4, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mContext:Landroid/content/Context;

    sget v5, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->devices_no_root:I

    invoke-virtual {v4, v5}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v3, v6

    invoke-virtual {v1, v2, v3}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 88
    iget-object v1, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mTvDevicesRoot:Landroid/widget/TextView;

    iget-object v2, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mContext:Landroid/content/Context;

    sget v3, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->devices_no_root:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v0, v2}, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->getTextPartColor(Ljava/lang/String;Ljava/lang/String;)Landroid/text/SpannableStringBuilder;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 81
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method private initEvent()V
    .locals 1

    .prologue
    .line 100
    iget-object v0, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mBtnCommit:Landroid/widget/Button;

    invoke-virtual {v0, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 101
    iget-object v0, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mBtnBack:Landroid/widget/Button;

    invoke-virtual {v0, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 102
    return-void
.end method

.method private initView()V
    .locals 1

    .prologue
    .line 69
    sget v0, Lcom/cyjh/feedback/libraryfeedbackinfo/R$id;->id_tv_device_name:I

    invoke-virtual {p0, v0}, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mTvDeicesName:Landroid/widget/TextView;

    .line 70
    sget v0, Lcom/cyjh/feedback/libraryfeedbackinfo/R$id;->id_tv_device_system:I

    invoke-virtual {p0, v0}, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mTvDevicesSystem:Landroid/widget/TextView;

    .line 71
    sget v0, Lcom/cyjh/feedback/libraryfeedbackinfo/R$id;->id_tv_device_root:I

    invoke-virtual {p0, v0}, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mTvDevicesRoot:Landroid/widget/TextView;

    .line 72
    sget v0, Lcom/cyjh/feedback/libraryfeedbackinfo/R$id;->id_tv_feedback_content:I

    invoke-virtual {p0, v0}, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mTvFeedBackContent:Landroid/widget/TextView;

    .line 73
    sget v0, Lcom/cyjh/feedback/libraryfeedbackinfo/R$id;->id_btn_back:I

    invoke-virtual {p0, v0}, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mBtnBack:Landroid/widget/Button;

    .line 74
    sget v0, Lcom/cyjh/feedback/libraryfeedbackinfo/R$id;->id_btn_commit_feedback_info:I

    invoke-virtual {p0, v0}, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mBtnCommit:Landroid/widget/Button;

    .line 75
    return-void
.end method

.method private parseJsonObject(Lorg/json/JSONObject;)V
    .locals 3
    .param p1, "response"    # Lorg/json/JSONObject;

    .prologue
    .line 171
    if-eqz p1, :cond_0

    .line 173
    :try_start_0
    const-string v1, "Code"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    iput v1, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->code:I
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 178
    :cond_0
    :goto_0
    iget-object v1, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->onResultCode:Lcom/cyjh/feedback/lib/dialog/FeedBackDialog$OnResultCode;

    if-eqz v1, :cond_1

    .line 179
    iget-object v1, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->onResultCode:Lcom/cyjh/feedback/lib/dialog/FeedBackDialog$OnResultCode;

    iget v2, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->code:I

    invoke-interface {v1, v2}, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog$OnResultCode;->getResultCode(I)V

    .line 181
    :cond_1
    return-void

    .line 174
    :catch_0
    move-exception v0

    .line 175
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method


# virtual methods
.method public getCode()I
    .locals 1

    .prologue
    .line 184
    iget v0, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->code:I

    return v0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 12
    .param p1, "v"    # Landroid/view/View;

    .prologue
    const/4 v11, 0x0

    const/4 v1, 0x1

    .line 121
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v8

    .line 122
    .local v8, "id":I
    sget v2, Lcom/cyjh/feedback/libraryfeedbackinfo/R$id;->id_btn_back:I

    if-ne v8, v2, :cond_1

    .line 123
    invoke-virtual {p0}, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->dismiss()V

    .line 125
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mFeedBackInfo:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    .line 168
    :cond_0
    :goto_0
    return-void

    .line 126
    :cond_1
    sget v2, Lcom/cyjh/feedback/libraryfeedbackinfo/R$id;->id_btn_commit_feedback_info:I

    if-ne v8, v2, :cond_0

    .line 128
    invoke-virtual {p0}, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->dismiss()V

    .line 129
    iget-object v2, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mContext:Landroid/content/Context;

    invoke-static {v2}, Lcom/cyjh/feedback/lib/utils/NetUtils;->is3rd(Landroid/content/Context;)Z

    move-result v2

    if-nez v2, :cond_2

    iget-object v2, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mContext:Landroid/content/Context;

    invoke-static {v2}, Lcom/cyjh/feedback/lib/utils/NetUtils;->isWifiEnabled(Landroid/content/Context;)Z

    move-result v2

    if-nez v2, :cond_2

    .line 130
    iget-object v2, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mContext:Landroid/content/Context;

    iget-object v4, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mContext:Landroid/content/Context;

    sget v5, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->is_net_open:I

    invoke-virtual {v4, v5}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-static {v2, v4, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/Toast;->show()V

    goto :goto_0

    .line 133
    :cond_2
    iget-object v2, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mLoadingDialog:Lcom/cyjh/feedback/lib/dialog/LoadingDialog;

    invoke-virtual {v2}, Lcom/cyjh/feedback/lib/dialog/LoadingDialog;->show()V

    .line 134
    new-instance v7, Lcom/google/gson/Gson;

    invoke-direct {v7}, Lcom/google/gson/Gson;-><init>()V

    .line 135
    .local v7, "gson":Lcom/google/gson/Gson;
    iget-object v2, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->mFeedBackInfo:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-virtual {v7, v2}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v10

    .line 136
    .local v10, "jsonString":Ljava/lang/String;
    const/4 v3, 0x0

    .line 138
    .local v3, "jsonObject":Lorg/json/JSONObject;
    :try_start_0
    new-instance v9, Lorg/json/JSONObject;

    invoke-direct {v9, v10}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v3    # "jsonObject":Lorg/json/JSONObject;
    .local v9, "jsonObject":Lorg/json/JSONObject;
    move-object v3, v9

    .line 142
    .end local v9    # "jsonObject":Lorg/json/JSONObject;
    .restart local v3    # "jsonObject":Lorg/json/JSONObject;
    :goto_1
    new-array v2, v11, [Ljava/lang/Object;

    invoke-static {v10, v2}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 143
    invoke-static {}, Lcom/cyjh/feedback/lib/base/BaseDialog;->getmRequestQueue()Lcom/android/volley/RequestQueue;

    move-result-object v2

    const-string v4, "BaseDialog"

    invoke-virtual {v2, v4}, Lcom/android/volley/RequestQueue;->cancelAll(Ljava/lang/Object;)V

    .line 144
    new-instance v0, Lcom/android/volley/toolbox/JsonObjectRequest;

    const-string v2, "http://api.mobileanjian.com/api/SetFeedBack"

    new-instance v4, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog$1;

    invoke-direct {v4, p0}, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog$1;-><init>(Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;)V

    new-instance v5, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog$2;

    invoke-direct {v5, p0}, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog$2;-><init>(Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;)V

    invoke-direct/range {v0 .. v5}, Lcom/android/volley/toolbox/JsonObjectRequest;-><init>(ILjava/lang/String;Lorg/json/JSONObject;Lcom/android/volley/Response$Listener;Lcom/android/volley/Response$ErrorListener;)V

    .line 162
    .local v0, "mRequest":Lcom/android/volley/toolbox/JsonObjectRequest;
    new-instance v2, Lcom/android/volley/DefaultRetryPolicy;

    const/16 v4, 0x7530

    const/high16 v5, 0x3f800000    # 1.0f

    invoke-direct {v2, v4, v1, v5}, Lcom/android/volley/DefaultRetryPolicy;-><init>(IIF)V

    invoke-virtual {v0, v2}, Lcom/android/volley/toolbox/JsonObjectRequest;->setRetryPolicy(Lcom/android/volley/RetryPolicy;)Lcom/android/volley/Request;

    .line 163
    const-string v1, "BaseDialog"

    invoke-virtual {v0, v1}, Lcom/android/volley/toolbox/JsonObjectRequest;->setTag(Ljava/lang/Object;)Lcom/android/volley/Request;

    .line 165
    invoke-virtual {v0, v11}, Lcom/android/volley/toolbox/JsonObjectRequest;->setShouldCache(Z)Lcom/android/volley/Request;

    .line 166
    invoke-static {}, Lcom/cyjh/feedback/lib/base/BaseDialog;->getmRequestQueue()Lcom/android/volley/RequestQueue;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/android/volley/RequestQueue;->add(Lcom/android/volley/Request;)Lcom/android/volley/Request;

    goto :goto_0

    .line 139
    .end local v0    # "mRequest":Lcom/android/volley/toolbox/JsonObjectRequest;
    :catch_0
    move-exception v6

    .line 140
    .local v6, "e":Lorg/json/JSONException;
    invoke-virtual {v6}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_1
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 59
    invoke-super {p0, p1}, Lcom/cyjh/feedback/lib/base/BaseDialog;->onCreate(Landroid/os/Bundle;)V

    .line 60
    sget v0, Lcom/cyjh/feedback/libraryfeedbackinfo/R$layout;->dialog_feedback_info:I

    invoke-virtual {p0, v0}, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->setContentView(I)V

    .line 61
    const v0, 0x3e99999a    # 0.3f

    invoke-virtual {p0, v0}, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->setBlurEffect(F)V

    .line 62
    const v0, 0x3f4ccccd    # 0.8f

    const v1, 0x3f19999a    # 0.6f

    invoke-virtual {p0, v0, v1}, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->setDialogSize(FF)V

    .line 63
    invoke-direct {p0}, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->initView()V

    .line 64
    invoke-direct {p0}, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->initData()V

    .line 65
    invoke-direct {p0}, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->initEvent()V

    .line 66
    return-void
.end method

.method public setOnResultCode(Lcom/cyjh/feedback/lib/dialog/FeedBackDialog$OnResultCode;)V
    .locals 0
    .param p1, "onResultCode"    # Lcom/cyjh/feedback/lib/dialog/FeedBackDialog$OnResultCode;

    .prologue
    .line 200
    iput-object p1, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->onResultCode:Lcom/cyjh/feedback/lib/dialog/FeedBackDialog$OnResultCode;

    .line 201
    return-void
.end method
