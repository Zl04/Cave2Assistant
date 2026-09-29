.class public Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;
.super Lcom/kaopu/download/abst/ADownloadDisplayHelper;
.source "GameDownloadView.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/customview/GameDownloadView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "DownloadDisplayHelper"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/kaopu/download/abst/ADownloadDisplayHelper",
        "<",
        "Lcom/kaopu/download/kernel/BaseDownloadInfo;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/customview/GameDownloadView;


# direct methods
.method public constructor <init>(Lcom/cyjh/elfin/customview/GameDownloadView;Lcom/kaopu/download/intf/IDownloadView;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/customview/GameDownloadView;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/kaopu/download/intf/IDownloadView",
            "<",
            "Lcom/kaopu/download/kernel/BaseDownloadInfo;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 120
    .local p2, "downloadView":Lcom/kaopu/download/intf/IDownloadView;, "Lcom/kaopu/download/intf/IDownloadView<Lcom/kaopu/download/kernel/BaseDownloadInfo;>;"
    iput-object p1, p0, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;->this$0:Lcom/cyjh/elfin/customview/GameDownloadView;

    .line 121
    invoke-direct {p0, p2}, Lcom/kaopu/download/abst/ADownloadDisplayHelper;-><init>(Lcom/kaopu/download/intf/IDownloadView;)V

    .line 122
    return-void
.end method


# virtual methods
.method public getDownloadInfo()Lcom/kaopu/download/kernel/BaseDownloadInfo;
    .locals 1

    .prologue
    .line 129
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;->this$0:Lcom/cyjh/elfin/customview/GameDownloadView;

    invoke-static {v0}, Lcom/cyjh/elfin/customview/GameDownloadView;->access$100(Lcom/cyjh/elfin/customview/GameDownloadView;)Lcom/kaopu/download/kernel/BaseDownloadInfo;

    move-result-object v0

    return-object v0
.end method

.method public onDownloadCancelingDisplay()V
    .locals 6

    .prologue
    .line 177
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;->this$0:Lcom/cyjh/elfin/customview/GameDownloadView;

    invoke-static {v0}, Lcom/cyjh/elfin/customview/GameDownloadView;->access$200(Lcom/cyjh/elfin/customview/GameDownloadView;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 178
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;->this$0:Lcom/cyjh/elfin/customview/GameDownloadView;

    invoke-static {v0}, Lcom/cyjh/elfin/customview/GameDownloadView;->access$400(Lcom/cyjh/elfin/customview/GameDownloadView;)Landroid/widget/TextView;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;->this$0:Lcom/cyjh/elfin/customview/GameDownloadView;

    invoke-virtual {v1}, Lcom/cyjh/elfin/customview/GameDownloadView;->getContext()Landroid/content/Context;

    move-result-object v1

    const v2, 0x7f08002f

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    iget-object v5, p0, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;->this$0:Lcom/cyjh/elfin/customview/GameDownloadView;

    invoke-static {v5}, Lcom/cyjh/elfin/customview/GameDownloadView;->access$300(Lcom/cyjh/elfin/customview/GameDownloadView;)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-virtual {v1, v2, v3}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 183
    :goto_0
    return-void

    .line 180
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;->this$0:Lcom/cyjh/elfin/customview/GameDownloadView;

    const v1, 0x7f080062

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/GameDownloadView;->showUnDownload(I)V

    goto :goto_0
.end method

.method public onDownloadConnectDisplay()V
    .locals 0

    .prologue
    .line 207
    return-void
.end method

.method public onDownloadFailedDisplay()V
    .locals 7

    .prologue
    .line 187
    iget-object v1, p0, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;->this$0:Lcom/cyjh/elfin/customview/GameDownloadView;

    invoke-static {v1}, Lcom/cyjh/elfin/customview/GameDownloadView;->access$200(Lcom/cyjh/elfin/customview/GameDownloadView;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 188
    iget-object v1, p0, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;->this$0:Lcom/cyjh/elfin/customview/GameDownloadView;

    invoke-static {v1}, Lcom/cyjh/elfin/customview/GameDownloadView;->access$400(Lcom/cyjh/elfin/customview/GameDownloadView;)Landroid/widget/TextView;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;->this$0:Lcom/cyjh/elfin/customview/GameDownloadView;

    invoke-virtual {v2}, Lcom/cyjh/elfin/customview/GameDownloadView;->getContext()Landroid/content/Context;

    move-result-object v2

    const v3, 0x7f08002f

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    iget-object v6, p0, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;->this$0:Lcom/cyjh/elfin/customview/GameDownloadView;

    invoke-static {v6}, Lcom/cyjh/elfin/customview/GameDownloadView;->access$300(Lcom/cyjh/elfin/customview/GameDownloadView;)Ljava/lang/String;

    move-result-object v6

    aput-object v6, v4, v5

    invoke-virtual {v2, v3, v4}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 192
    :goto_0
    new-instance v0, Ljava/io/File;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;->this$0:Lcom/cyjh/elfin/customview/GameDownloadView;

    invoke-static {v2}, Lcom/cyjh/elfin/customview/GameDownloadView;->access$100(Lcom/cyjh/elfin/customview/GameDownloadView;)Lcom/kaopu/download/kernel/BaseDownloadInfo;

    move-result-object v2

    .line 193
    invoke-virtual {v2}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getSaveDir()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;->this$0:Lcom/cyjh/elfin/customview/GameDownloadView;

    invoke-static {v2}, Lcom/cyjh/elfin/customview/GameDownloadView;->access$100(Lcom/cyjh/elfin/customview/GameDownloadView;)Lcom/kaopu/download/kernel/BaseDownloadInfo;

    move-result-object v2

    invoke-virtual {v2}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getSaveName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 194
    .local v0, "apkFile":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    .line 196
    :cond_0
    return-void

    .line 190
    .end local v0    # "apkFile":Ljava/io/File;
    :cond_1
    iget-object v1, p0, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;->this$0:Lcom/cyjh/elfin/customview/GameDownloadView;

    const v2, 0x7f080062

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/customview/GameDownloadView;->showUnDownload(I)V

    goto :goto_0
.end method

.method public onDownloadNewDisplay()V
    .locals 6

    .prologue
    .line 133
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;->this$0:Lcom/cyjh/elfin/customview/GameDownloadView;

    invoke-static {v0}, Lcom/cyjh/elfin/customview/GameDownloadView;->access$200(Lcom/cyjh/elfin/customview/GameDownloadView;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 134
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;->this$0:Lcom/cyjh/elfin/customview/GameDownloadView;

    invoke-static {v0}, Lcom/cyjh/elfin/customview/GameDownloadView;->access$400(Lcom/cyjh/elfin/customview/GameDownloadView;)Landroid/widget/TextView;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;->this$0:Lcom/cyjh/elfin/customview/GameDownloadView;

    invoke-virtual {v1}, Lcom/cyjh/elfin/customview/GameDownloadView;->getContext()Landroid/content/Context;

    move-result-object v1

    const v2, 0x7f08002f

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    iget-object v5, p0, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;->this$0:Lcom/cyjh/elfin/customview/GameDownloadView;

    invoke-static {v5}, Lcom/cyjh/elfin/customview/GameDownloadView;->access$300(Lcom/cyjh/elfin/customview/GameDownloadView;)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-virtual {v1, v2, v3}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 139
    :goto_0
    return-void

    .line 136
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;->this$0:Lcom/cyjh/elfin/customview/GameDownloadView;

    const v1, 0x7f080062

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/GameDownloadView;->showUnDownload(I)V

    goto :goto_0
.end method

.method public onDownloadNoneDisplay()V
    .locals 0

    .prologue
    .line 201
    return-void
.end method

.method public onDownloadPausedDisplay()V
    .locals 2

    .prologue
    .line 171
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;->this$0:Lcom/cyjh/elfin/customview/GameDownloadView;

    const v1, 0x7f080064

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/GameDownloadView;->showUnDownload(I)V

    .line 173
    return-void
.end method

.method public onDownloadPausingDisplay()V
    .locals 2

    .prologue
    .line 164
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;->this$0:Lcom/cyjh/elfin/customview/GameDownloadView;

    const v1, 0x7f080064

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/GameDownloadView;->showUnDownload(I)V

    .line 167
    return-void
.end method

.method public onDownloadWaitDisplay()V
    .locals 0

    .prologue
    .line 143
    return-void
.end method

.method public onDownloadedDisplay()V
    .locals 2

    .prologue
    .line 153
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;->this$0:Lcom/cyjh/elfin/customview/GameDownloadView;

    const v1, 0x7f080038

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/GameDownloadView;->showUnDownload(I)V

    .line 154
    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    new-instance v1, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper$1;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper$1;-><init>(Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 160
    return-void
.end method

.method public onDownloadingDisplay()V
    .locals 1

    .prologue
    .line 147
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;->this$0:Lcom/cyjh/elfin/customview/GameDownloadView;

    invoke-virtual {v0}, Lcom/cyjh/elfin/customview/GameDownloadView;->showDownload()V

    .line 149
    return-void
.end method

.method public setDownloadInfo(Lcom/kaopu/download/kernel/BaseDownloadInfo;)V
    .locals 1
    .param p1, "baseDownloadInfo"    # Lcom/kaopu/download/kernel/BaseDownloadInfo;

    .prologue
    .line 125
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;->this$0:Lcom/cyjh/elfin/customview/GameDownloadView;

    invoke-static {v0, p1}, Lcom/cyjh/elfin/customview/GameDownloadView;->access$102(Lcom/cyjh/elfin/customview/GameDownloadView;Lcom/kaopu/download/kernel/BaseDownloadInfo;)Lcom/kaopu/download/kernel/BaseDownloadInfo;

    .line 126
    return-void
.end method
