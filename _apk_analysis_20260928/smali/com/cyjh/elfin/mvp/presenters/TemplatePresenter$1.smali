.class Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter$1;
.super Ljava/lang/Object;
.source "TemplatePresenter.java"

# interfaces
.implements Lcom/cyjh/elfin/mvp/managers/Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter;->singleApkOrTemplateChecked(Ljava/lang/String;Landroid/content/Context;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/cyjh/elfin/mvp/managers/Callback",
        "<",
        "Lcom/cyjh/elfin/entity/TemplateStatus;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter;

.field final synthetic val$interfaceName:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter;Ljava/lang/String;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter;

    .prologue
    .line 35
    iput-object p1, p0, Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter$1;->this$0:Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter;

    iput-object p2, p0, Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter$1;->val$interfaceName:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public error(Ljava/lang/String;)V
    .locals 4
    .param p1, "msg"    # Ljava/lang/String;

    .prologue
    .line 43
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "\u7f51\u7edc\u52a0\u8f7d\u9519\u8bef\uff1a"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v1, v2}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 45
    iget-object v1, p0, Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter$1;->val$interfaceName:Ljava/lang/String;

    const-string v2, "GetMonomerInstallationPackage"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 46
    const/16 v0, 0xb

    .line 50
    .local v0, "startSuffix":I
    :goto_0
    iget-object v1, p0, Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter$1;->this$0:Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter;

    invoke-static {v1}, Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter;->access$000(Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter;)Lcom/cyjh/elfin/mvp/views/TemplateView;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    invoke-interface {v1, v2, v3}, Lcom/cyjh/elfin/mvp/views/TemplateView;->onErrorMsg(Ljava/lang/String;Ljava/lang/String;)V

    .line 51
    return-void

    .line 48
    .end local v0    # "startSuffix":I
    :cond_0
    const/16 v0, 0xa

    .restart local v0    # "startSuffix":I
    goto :goto_0
.end method

.method public finish(Lcom/cyjh/elfin/entity/TemplateStatus;)V
    .locals 1
    .param p1, "templateStatus"    # Lcom/cyjh/elfin/entity/TemplateStatus;

    .prologue
    .line 38
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter$1;->this$0:Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter;

    invoke-static {v0}, Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter;->access$000(Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter;)Lcom/cyjh/elfin/mvp/views/TemplateView;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/cyjh/elfin/mvp/views/TemplateView;->apkCheckedResult(Lcom/cyjh/elfin/entity/TemplateStatus;)V

    .line 39
    return-void
.end method

.method public bridge synthetic finish(Ljava/lang/Object;)V
    .locals 0

    .prologue
    .line 35
    check-cast p1, Lcom/cyjh/elfin/entity/TemplateStatus;

    invoke-virtual {p0, p1}, Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter$1;->finish(Lcom/cyjh/elfin/entity/TemplateStatus;)V

    return-void
.end method
