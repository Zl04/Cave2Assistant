.class Lcom/cyjh/elfin/mvp/managers/RootSetRequestManager$1;
.super Lcom/cyjh/elfin/net/volley/VolleyRequestManager;
.source "RootSetRequestManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/mvp/managers/RootSetRequestManager;->isRootRequired(Ljava/lang/String;Landroid/content/Context;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/mvp/managers/RootSetRequestManager;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/mvp/managers/RootSetRequestManager;Landroid/content/Context;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/mvp/managers/RootSetRequestManager;
    .param p2, "context"    # Landroid/content/Context;

    .prologue
    .line 26
    iput-object p1, p0, Lcom/cyjh/elfin/mvp/managers/RootSetRequestManager$1;->this$0:Lcom/cyjh/elfin/mvp/managers/RootSetRequestManager;

    invoke-direct {p0, p2}, Lcom/cyjh/elfin/net/volley/VolleyRequestManager;-><init>(Landroid/content/Context;)V

    return-void
.end method


# virtual methods
.method public onRequestErrorRes(Ljava/lang/String;)V
    .locals 3
    .param p1, "msg"    # Ljava/lang/String;

    .prologue
    .line 38
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v0

    new-instance v1, Lcom/cyjh/elfin/entity/MsgItem;

    const/16 v2, 0x3ed

    invoke-direct {v1, v2}, Lcom/cyjh/elfin/entity/MsgItem;-><init>(I)V

    invoke-virtual {v0, v1}, Lorg/greenrobot/eventbus/EventBus;->post(Ljava/lang/Object;)V

    .line 39
    return-void
.end method

.method public onRequestSuccessRes(Ljava/lang/String;)V
    .locals 5
    .param p1, "res"    # Ljava/lang/String;

    .prologue
    .line 29
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\u8fd4\u56de\u7684\u6570\u636e\uff1a"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {v2, v3}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 30
    new-instance v0, Lcom/google/gson/Gson;

    invoke-direct {v0}, Lcom/google/gson/Gson;-><init>()V

    .line 31
    .local v0, "gson":Lcom/google/gson/Gson;
    const-class v2, Lcom/cyjh/elfin/entity/RootRelatedEntity;

    invoke-virtual {v0, p1, v2}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/cyjh/elfin/entity/RootRelatedEntity;

    .line 32
    .local v1, "rootRelatedEntity":Lcom/cyjh/elfin/entity/RootRelatedEntity;
    iget-object v2, v1, Lcom/cyjh/elfin/entity/RootRelatedEntity;->Code:Ljava/lang/String;

    const/4 v3, 0x1

    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 33
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v2

    new-instance v3, Lcom/cyjh/elfin/entity/MsgItem$RootDataEvent;

    iget-object v4, v1, Lcom/cyjh/elfin/entity/RootRelatedEntity;->Data:Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;

    invoke-direct {v3, v4}, Lcom/cyjh/elfin/entity/MsgItem$RootDataEvent;-><init>(Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;)V

    invoke-virtual {v2, v3}, Lorg/greenrobot/eventbus/EventBus;->post(Ljava/lang/Object;)V

    .line 35
    :cond_0
    return-void
.end method
