.class public Lcom/cyjh/elfin/dialog/UpdateDialog;
.super Lcom/cyjh/elfin/dialog/BaseDialog;
.source "UpdateDialog.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field private mButtonCancel:Landroid/widget/Button;

.field private mButtonForceUpdate:Landroid/widget/Button;

.field private mButtonNextTime:Landroid/widget/Button;

.field private mButtonUpdate:Landroid/widget/Button;

.field private mHttpDownloadHandler:Lcom/lidroid/xutils/http/HttpHandler;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/lidroid/xutils/http/HttpHandler",
            "<",
            "Ljava/io/File;",
            ">;"
        }
    .end annotation
.end field

.field private mLinearLayoutDownload:Landroid/widget/LinearLayout;

.field private mLinearLayoutUpdate:Landroid/widget/LinearLayout;

.field private mProgressBarDownload:Landroid/widget/ProgressBar;

.field private mTextViewProgress:Landroid/widget/TextView;

.field private mTextViewSize:Landroid/widget/TextView;

.field private mTextViewUpdateContent:Landroid/widget/TextView;

.field private updateInfo:Lcom/cyjh/elfin/entity/UpdateInfo;


# direct methods
.method public constructor <init>(Landroid/content/Context;Lcom/cyjh/elfin/entity/UpdateInfo;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "updateInfo"    # Lcom/cyjh/elfin/entity/UpdateInfo;

    .prologue
    .line 48
    const v0, 0x7f0a00f8

    invoke-direct {p0, p1, v0}, Lcom/cyjh/elfin/dialog/BaseDialog;-><init>(Landroid/content/Context;I)V

    .line 49
    invoke-virtual {p2}, Lcom/cyjh/elfin/entity/UpdateInfo;->getIsDismissing()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 50
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x13

    if-lt v0, v1, :cond_1

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x18

    if-ge v0, v1, :cond_1

    .line 52
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/UpdateDialog;->getWindow()Landroid/view/Window;

    move-result-object v0

    const/16 v1, 0x7d5

    invoke-virtual {v0, v1}, Landroid/view/Window;->setType(I)V

    .line 58
    :cond_0
    :goto_0
    iput-object p2, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->updateInfo:Lcom/cyjh/elfin/entity/UpdateInfo;

    .line 59
    return-void

    .line 55
    :cond_1
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/UpdateDialog;->getWindow()Landroid/view/Window;

    move-result-object v0

    const/16 v1, 0x7d2

    invoke-virtual {v0, v1}, Landroid/view/Window;->setType(I)V

    goto :goto_0
.end method

.method static synthetic access$000(Lcom/cyjh/elfin/dialog/UpdateDialog;)Landroid/widget/TextView;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/dialog/UpdateDialog;

    .prologue
    .line 28
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->mTextViewProgress:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic access$100(Lcom/cyjh/elfin/dialog/UpdateDialog;)Landroid/widget/ProgressBar;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/dialog/UpdateDialog;

    .prologue
    .line 28
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->mProgressBarDownload:Landroid/widget/ProgressBar;

    return-object v0
.end method

.method static synthetic access$200(Lcom/cyjh/elfin/dialog/UpdateDialog;)Lcom/cyjh/elfin/entity/UpdateInfo;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/dialog/UpdateDialog;

    .prologue
    .line 28
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->updateInfo:Lcom/cyjh/elfin/entity/UpdateInfo;

    return-object v0
.end method

.method static synthetic access$300(Lcom/cyjh/elfin/dialog/UpdateDialog;)Landroid/widget/Button;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/dialog/UpdateDialog;

    .prologue
    .line 28
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->mButtonCancel:Landroid/widget/Button;

    return-object v0
.end method

.method private cancelDownload()V
    .locals 1

    .prologue
    .line 118
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->mHttpDownloadHandler:Lcom/lidroid/xutils/http/HttpHandler;

    invoke-virtual {v0}, Lcom/lidroid/xutils/http/HttpHandler;->cancel()V

    .line 119
    invoke-direct {p0}, Lcom/cyjh/elfin/dialog/UpdateDialog;->changeButtonsState()V

    .line 120
    return-void
.end method

.method private changeButtonsState()V
    .locals 4

    .prologue
    const/4 v3, 0x1

    const/16 v2, 0x8

    const/4 v1, 0x0

    .line 125
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->mLinearLayoutDownload:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 126
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->updateInfo:Lcom/cyjh/elfin/entity/UpdateInfo;

    invoke-virtual {v0}, Lcom/cyjh/elfin/entity/UpdateInfo;->getUpdateType()I

    move-result v0

    if-nez v0, :cond_0

    .line 127
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->mLinearLayoutUpdate:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 128
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->mButtonForceUpdate:Landroid/widget/Button;

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setVisibility(I)V

    .line 129
    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/dialog/UpdateDialog;->setCancelable(Z)V

    .line 130
    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/dialog/UpdateDialog;->setCanceledOnTouchOutside(Z)V

    .line 137
    :goto_0
    return-void

    .line 132
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->mLinearLayoutUpdate:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 133
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->mButtonForceUpdate:Landroid/widget/Button;

    invoke-virtual {v0, v2}, Landroid/widget/Button;->setVisibility(I)V

    .line 134
    invoke-virtual {p0, v3}, Lcom/cyjh/elfin/dialog/UpdateDialog;->setCancelable(Z)V

    .line 135
    invoke-virtual {p0, v3}, Lcom/cyjh/elfin/dialog/UpdateDialog;->setCanceledOnTouchOutside(Z)V

    goto :goto_0
.end method

.method private download()V
    .locals 4

    .prologue
    const/16 v3, 0x8

    const/4 v2, 0x0

    .line 143
    invoke-virtual {p0, v2}, Lcom/cyjh/elfin/dialog/UpdateDialog;->setCanceledOnTouchOutside(Z)V

    .line 144
    invoke-virtual {p0, v2}, Lcom/cyjh/elfin/dialog/UpdateDialog;->setCancelable(Z)V

    .line 145
    iget-object v1, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->mLinearLayoutDownload:Landroid/widget/LinearLayout;

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 146
    iget-object v1, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->mLinearLayoutUpdate:Landroid/widget/LinearLayout;

    invoke-virtual {v1, v3}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 147
    iget-object v1, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->mButtonForceUpdate:Landroid/widget/Button;

    invoke-virtual {v1, v3}, Landroid/widget/Button;->setVisibility(I)V

    .line 149
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/UpdateDialog;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ".apk"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 150
    .local v0, "target":Ljava/lang/String;
    iget-object v1, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "target>>>"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 152
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/UpdateDialog;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Lcom/cyjh/elfin/net/xutils/XUtilsHttpClient;->getInstence(Landroid/content/Context;)Lcom/lidroid/xutils/HttpUtils;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->updateInfo:Lcom/cyjh/elfin/entity/UpdateInfo;

    invoke-virtual {v2}, Lcom/cyjh/elfin/entity/UpdateInfo;->getDownLoadPath()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Lcom/cyjh/elfin/dialog/UpdateDialog$1;

    invoke-direct {v3, p0}, Lcom/cyjh/elfin/dialog/UpdateDialog$1;-><init>(Lcom/cyjh/elfin/dialog/UpdateDialog;)V

    invoke-virtual {v1, v2, v0, v3}, Lcom/lidroid/xutils/HttpUtils;->download(Ljava/lang/String;Ljava/lang/String;Lcom/lidroid/xutils/http/callback/RequestCallBack;)Lcom/lidroid/xutils/http/HttpHandler;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->mHttpDownloadHandler:Lcom/lidroid/xutils/http/HttpHandler;

    .line 191
    return-void
.end method

.method private initView()V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 70
    const v0, 0x7f0f016e

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/dialog/UpdateDialog;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->mTextViewSize:Landroid/widget/TextView;

    .line 71
    const v0, 0x7f0f016f

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/dialog/UpdateDialog;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->mTextViewUpdateContent:Landroid/widget/TextView;

    .line 72
    const v0, 0x7f0f0171

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/dialog/UpdateDialog;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->mTextViewProgress:Landroid/widget/TextView;

    .line 74
    const v0, 0x7f0f0174

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/dialog/UpdateDialog;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->mButtonForceUpdate:Landroid/widget/Button;

    .line 75
    const v0, 0x7f0f0177

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/dialog/UpdateDialog;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->mButtonUpdate:Landroid/widget/Button;

    .line 76
    const v0, 0x7f0f0176

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/dialog/UpdateDialog;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->mButtonNextTime:Landroid/widget/Button;

    .line 77
    const v0, 0x7f0f0173

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/dialog/UpdateDialog;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->mButtonCancel:Landroid/widget/Button;

    .line 79
    const v0, 0x7f0f0172

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/dialog/UpdateDialog;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ProgressBar;

    iput-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->mProgressBarDownload:Landroid/widget/ProgressBar;

    .line 81
    const v0, 0x7f0f0175

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/dialog/UpdateDialog;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->mLinearLayoutUpdate:Landroid/widget/LinearLayout;

    .line 82
    const v0, 0x7f0f0170

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/dialog/UpdateDialog;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->mLinearLayoutDownload:Landroid/widget/LinearLayout;

    .line 84
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->mButtonForceUpdate:Landroid/widget/Button;

    invoke-virtual {v0, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 85
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->mButtonUpdate:Landroid/widget/Button;

    invoke-virtual {v0, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 86
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->mButtonNextTime:Landroid/widget/Button;

    invoke-virtual {v0, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 87
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->mButtonCancel:Landroid/widget/Button;

    invoke-virtual {v0, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 88
    invoke-direct {p0}, Lcom/cyjh/elfin/dialog/UpdateDialog;->changeButtonsState()V

    .line 90
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->mTextViewSize:Landroid/widget/TextView;

    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setVisibility(I)V

    .line 91
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->mTextViewSize:Landroid/widget/TextView;

    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/UpdateDialog;->getContext()Landroid/content/Context;

    move-result-object v1

    const v2, 0x7f080034

    invoke-virtual {v1, v2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v3, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->updateInfo:Lcom/cyjh/elfin/entity/UpdateInfo;

    invoke-virtual {v3}, Lcom/cyjh/elfin/entity/UpdateInfo;->getFileSize()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v4

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 92
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->mTextViewUpdateContent:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/cyjh/elfin/dialog/UpdateDialog;->updateInfo:Lcom/cyjh/elfin/entity/UpdateInfo;

    invoke-virtual {v1}, Lcom/cyjh/elfin/entity/UpdateInfo;->getUpdateNotice()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 94
    return-void
.end method


# virtual methods
.method public dismiss()V
    .locals 0

    .prologue
    .line 200
    invoke-super {p0}, Lcom/cyjh/elfin/dialog/BaseDialog;->dismiss()V

    .line 201
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 98
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    packed-switch v0, :pswitch_data_0

    .line 115
    :goto_0
    :pswitch_0
    return-void

    .line 100
    :pswitch_1
    invoke-direct {p0}, Lcom/cyjh/elfin/dialog/UpdateDialog;->download()V

    goto :goto_0

    .line 103
    :pswitch_2
    invoke-direct {p0}, Lcom/cyjh/elfin/dialog/UpdateDialog;->download()V

    goto :goto_0

    .line 106
    :pswitch_3
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/UpdateDialog;->dismiss()V

    goto :goto_0

    .line 109
    :pswitch_4
    invoke-direct {p0}, Lcom/cyjh/elfin/dialog/UpdateDialog;->cancelDownload()V

    goto :goto_0

    .line 98
    :pswitch_data_0
    .packed-switch 0x7f0f0173
        :pswitch_4
        :pswitch_1
        :pswitch_0
        :pswitch_3
        :pswitch_2
    .end packed-switch
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 63
    invoke-super {p0, p1}, Lcom/cyjh/elfin/dialog/BaseDialog;->onCreate(Landroid/os/Bundle;)V

    .line 64
    const v0, 0x7f04007a

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/dialog/UpdateDialog;->setContentView(I)V

    .line 65
    const v0, 0x3f666666    # 0.9f

    const v1, 0x3f19999a    # 0.6f

    invoke-virtual {p0, v0, v1}, Lcom/cyjh/elfin/dialog/UpdateDialog;->setDialogSize(FF)V

    .line 66
    invoke-direct {p0}, Lcom/cyjh/elfin/dialog/UpdateDialog;->initView()V

    .line 67
    return-void
.end method

.method public show()V
    .locals 0

    .prologue
    .line 195
    invoke-super {p0}, Lcom/cyjh/elfin/dialog/BaseDialog;->show()V

    .line 196
    return-void
.end method
