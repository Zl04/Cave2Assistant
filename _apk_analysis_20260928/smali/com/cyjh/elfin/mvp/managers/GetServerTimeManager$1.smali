.class Lcom/cyjh/elfin/mvp/managers/GetServerTimeManager$1;
.super Lcom/cyjh/elfin/net/volley/VolleyRequestManager;
.source "GetServerTimeManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/mvp/managers/GetServerTimeManager;->getServerTime(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/mvp/managers/GetServerTimeManager;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/mvp/managers/GetServerTimeManager;Landroid/content/Context;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/mvp/managers/GetServerTimeManager;
    .param p2, "context"    # Landroid/content/Context;

    .prologue
    .line 23
    iput-object p1, p0, Lcom/cyjh/elfin/mvp/managers/GetServerTimeManager$1;->this$0:Lcom/cyjh/elfin/mvp/managers/GetServerTimeManager;

    invoke-direct {p0, p2}, Lcom/cyjh/elfin/net/volley/VolleyRequestManager;-><init>(Landroid/content/Context;)V

    return-void
.end method


# virtual methods
.method public onRequestErrorRes(Ljava/lang/String;)V
    .locals 3
    .param p1, "msg"    # Ljava/lang/String;

    .prologue
    .line 31
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v0

    new-instance v1, Lcom/cyjh/elfin/entity/MsgItem;

    const/16 v2, 0x3ef

    invoke-direct {v1, v2}, Lcom/cyjh/elfin/entity/MsgItem;-><init>(I)V

    invoke-virtual {v0, v1}, Lorg/greenrobot/eventbus/EventBus;->post(Ljava/lang/Object;)V

    .line 32
    return-void
.end method

.method public onRequestSuccessRes(Ljava/lang/String;)V
    .locals 2
    .param p1, "res"    # Ljava/lang/String;

    .prologue
    .line 26
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v0

    new-instance v1, Lcom/cyjh/elfin/entity/MsgItem$GetServerTime;

    invoke-direct {v1, p1}, Lcom/cyjh/elfin/entity/MsgItem$GetServerTime;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Lorg/greenrobot/eventbus/EventBus;->post(Ljava/lang/Object;)V

    .line 27
    return-void
.end method
