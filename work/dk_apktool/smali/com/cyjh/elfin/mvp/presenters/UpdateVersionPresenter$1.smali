.class Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter$1;
.super Lcom/lidroid/xutils/http/callback/RequestCallBack;
.source "UpdateVersionPresenter.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;->updateVersion(ZLandroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/lidroid/xutils/http/callback/RequestCallBack",
        "<",
        "Ljava/lang/String;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;

.field final synthetic val$context:Landroid/content/Context;

.field final synthetic val$isToast:Z


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;ZLandroid/content/Context;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;

    .prologue
    .line 51
    iput-object p1, p0, Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter$1;->this$0:Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;

    iput-boolean p2, p0, Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter$1;->val$isToast:Z

    iput-object p3, p0, Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter$1;->val$context:Landroid/content/Context;

    invoke-direct {p0}, Lcom/lidroid/xutils/http/callback/RequestCallBack;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailure(Lcom/lidroid/xutils/exception/HttpException;Ljava/lang/String;)V
    .locals 3
    .param p1, "error"    # Lcom/lidroid/xutils/exception/HttpException;
    .param p2, "msg"    # Ljava/lang/String;

    .prologue
    .line 54
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter$1;->this$0:Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;

    invoke-static {v0}, Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;->access$000(Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;)Lcom/cyjh/elfin/mvp/views/UpdateVersionView;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Lcom/lidroid/xutils/exception/HttpException;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/cyjh/elfin/mvp/views/UpdateVersionView;->onUpdateFailure(Ljava/lang/String;)V

    .line 55
    return-void
.end method

.method public onSuccess(Lcom/lidroid/xutils/http/ResponseInfo;)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/lidroid/xutils/http/ResponseInfo",
            "<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 59
    .local p1, "responseInfo":Lcom/lidroid/xutils/http/ResponseInfo;, "Lcom/lidroid/xutils/http/ResponseInfo<Ljava/lang/String;>;"
    iget-object v2, p0, Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter$1;->this$0:Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;

    invoke-static {v2}, Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;->access$100(Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;)Lcom/cyjh/elfin/log/CommonLog;

    move-result-object v3

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "responseInfo.result>>>"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v2, p1, Lcom/lidroid/xutils/http/ResponseInfo;->result:Ljava/lang/Object;

    check-cast v2, Ljava/lang/String;

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v3, v2}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 61
    iget-object v2, p1, Lcom/lidroid/xutils/http/ResponseInfo;->result:Ljava/lang/Object;

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    const-string v2, "null"

    iget-object v3, p1, Lcom/lidroid/xutils/http/ResponseInfo;->result:Ljava/lang/Object;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 62
    :cond_0
    iget-object v2, p0, Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter$1;->this$0:Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;

    invoke-static {v2}, Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;->access$000(Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;)Lcom/cyjh/elfin/mvp/views/UpdateVersionView;

    move-result-object v2

    invoke-interface {v2}, Lcom/cyjh/elfin/mvp/views/UpdateVersionView;->onUpdateEmpty()V

    .line 63
    iget-boolean v2, p0, Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter$1;->val$isToast:Z

    if-eqz v2, :cond_1

    .line 64
    invoke-static {}, Lcom/cyjh/elfin/AppContext;->getInstance()Lcom/cyjh/elfin/AppContext;

    move-result-object v2

    const v3, 0x7f080130

    invoke-static {v2, v3}, Lcom/cyjh/elfin/util/ToastUtils;->showToastLong(Landroid/content/Context;I)V

    .line 74
    :cond_1
    :goto_0
    return-void

    .line 68
    :cond_2
    new-instance v0, Lcom/google/gson/Gson;

    invoke-direct {v0}, Lcom/google/gson/Gson;-><init>()V

    .line 69
    .local v0, "gson":Lcom/google/gson/Gson;
    iget-object v2, p1, Lcom/lidroid/xutils/http/ResponseInfo;->result:Ljava/lang/Object;

    check-cast v2, Ljava/lang/String;

    const-class v3, [Lcom/cyjh/elfin/entity/UpdateInfo;

    invoke-virtual {v0, v2, v3}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [Lcom/cyjh/elfin/entity/UpdateInfo;

    const/4 v3, 0x0

    aget-object v1, v2, v3

    .line 70
    .local v1, "updateInfo":Lcom/cyjh/elfin/entity/UpdateInfo;
    if-eqz v1, :cond_1

    .line 71
    iget-object v2, p0, Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter$1;->val$context:Landroid/content/Context;

    iput-object v2, v1, Lcom/cyjh/elfin/entity/UpdateInfo;->mContext:Landroid/content/Context;

    .line 72
    iget-object v2, p0, Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter$1;->this$0:Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;

    invoke-static {v2}, Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;->access$000(Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;)Lcom/cyjh/elfin/mvp/views/UpdateVersionView;

    move-result-object v2

    invoke-interface {v2, v1}, Lcom/cyjh/elfin/mvp/views/UpdateVersionView;->onUpdateSuccessful(Lcom/cyjh/elfin/entity/UpdateInfo;)V

    goto :goto_0
.end method
