.class Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter$1;
.super Ljava/lang/Object;
.source "AdImagePresenter.java"

# interfaces
.implements Lcom/cyjh/elfin/mvp/managers/Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;->adShow(Landroid/content/Context;ILjava/lang/String;)V
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
        "Lcom/cyjh/elfin/entity/Ad;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;

.field final synthetic val$site:I


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;I)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;

    .prologue
    .line 36
    iput-object p1, p0, Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter$1;->this$0:Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;

    iput p2, p0, Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter$1;->val$site:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public error(Ljava/lang/String;)V
    .locals 3
    .param p1, "msg"    # Ljava/lang/String;

    .prologue
    .line 45
    const-string v0, "zzz"

    const-string v1, "AdImagePresenter--- error--1"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 46
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "error message:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 47
    iget v0, p0, Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter$1;->val$site:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    .line 50
    const-string v0, "zzz"

    const-string v1, "AdImagePresenter--- error--2"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 51
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v0

    new-instance v1, Lcom/cyjh/elfin/entity/MsgItem;

    const/16 v2, 0x3ee

    invoke-direct {v1, v2}, Lcom/cyjh/elfin/entity/MsgItem;-><init>(I)V

    invoke-virtual {v0, v1}, Lorg/greenrobot/eventbus/EventBus;->post(Ljava/lang/Object;)V

    .line 56
    :cond_0
    :goto_0
    return-void

    .line 52
    :cond_1
    iget v0, p0, Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter$1;->val$site:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    .line 54
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v0

    new-instance v1, Lcom/cyjh/elfin/entity/MsgItem;

    const/16 v2, 0x3f4

    invoke-direct {v1, v2}, Lcom/cyjh/elfin/entity/MsgItem;-><init>(I)V

    invoke-virtual {v0, v1}, Lorg/greenrobot/eventbus/EventBus;->post(Ljava/lang/Object;)V

    goto :goto_0
.end method

.method public finish(Lcom/cyjh/elfin/entity/Ad;)V
    .locals 3
    .param p1, "ad"    # Lcom/cyjh/elfin/entity/Ad;

    .prologue
    .line 39
    const-string v0, "zzz"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "AdImagePresenter--- adShow--1"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 40
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter$1;->this$0:Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;

    invoke-static {v0}, Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;->access$000(Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;)Lcom/cyjh/elfin/mvp/views/AdImageView;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/cyjh/elfin/mvp/views/AdImageView;->imgAdResult(Lcom/cyjh/elfin/entity/Ad;)V

    .line 41
    return-void
.end method

.method public bridge synthetic finish(Ljava/lang/Object;)V
    .locals 0

    .prologue
    .line 36
    check-cast p1, Lcom/cyjh/elfin/entity/Ad;

    invoke-virtual {p0, p1}, Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter$1;->finish(Lcom/cyjh/elfin/entity/Ad;)V

    return-void
.end method
