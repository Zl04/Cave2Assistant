.class Lcom/cyjh/elfin/mvp/presenters/BlackListPresenter$1;
.super Ljava/lang/Object;
.source "BlackListPresenter.java"

# interfaces
.implements Lcom/cyjh/elfin/mvp/managers/Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/mvp/presenters/BlackListPresenter;->isSetBlackList(Landroid/content/Context;)V
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
        "Ljava/lang/String;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/mvp/presenters/BlackListPresenter;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/mvp/presenters/BlackListPresenter;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/mvp/presenters/BlackListPresenter;

    .prologue
    .line 26
    iput-object p1, p0, Lcom/cyjh/elfin/mvp/presenters/BlackListPresenter$1;->this$0:Lcom/cyjh/elfin/mvp/presenters/BlackListPresenter;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public error(Ljava/lang/String;)V
    .locals 0
    .param p1, "msg"    # Ljava/lang/String;

    .prologue
    .line 35
    return-void
.end method

.method public bridge synthetic finish(Ljava/lang/Object;)V
    .locals 0

    .prologue
    .line 26
    check-cast p1, Ljava/lang/String;

    invoke-virtual {p0, p1}, Lcom/cyjh/elfin/mvp/presenters/BlackListPresenter$1;->finish(Ljava/lang/String;)V

    return-void
.end method

.method public finish(Ljava/lang/String;)V
    .locals 1
    .param p1, "result"    # Ljava/lang/String;

    .prologue
    .line 29
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/BlackListPresenter$1;->this$0:Lcom/cyjh/elfin/mvp/presenters/BlackListPresenter;

    invoke-static {v0}, Lcom/cyjh/elfin/mvp/presenters/BlackListPresenter;->access$000(Lcom/cyjh/elfin/mvp/presenters/BlackListPresenter;)Lcom/cyjh/elfin/mvp/views/BlackListView;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/cyjh/elfin/mvp/views/BlackListView;->setBlackListResult(Ljava/lang/String;)V

    .line 30
    return-void
.end method
