.class Lcom/cyjh/elfin/mvp/managers/AdImageManager$1;
.super Lcom/cyjh/elfin/net/volley/VolleyRequestManager;
.source "AdImageManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/mvp/managers/AdImageManager;->adShow(ILjava/lang/String;Lcom/cyjh/elfin/mvp/managers/Callback;Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/mvp/managers/AdImageManager;

.field final synthetic val$callback:Lcom/cyjh/elfin/mvp/managers/Callback;

.field final synthetic val$site:I


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/mvp/managers/AdImageManager;Landroid/content/Context;ILcom/cyjh/elfin/mvp/managers/Callback;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/mvp/managers/AdImageManager;
    .param p2, "context"    # Landroid/content/Context;

    .prologue
    .line 36
    iput-object p1, p0, Lcom/cyjh/elfin/mvp/managers/AdImageManager$1;->this$0:Lcom/cyjh/elfin/mvp/managers/AdImageManager;

    iput p3, p0, Lcom/cyjh/elfin/mvp/managers/AdImageManager$1;->val$site:I

    iput-object p4, p0, Lcom/cyjh/elfin/mvp/managers/AdImageManager$1;->val$callback:Lcom/cyjh/elfin/mvp/managers/Callback;

    invoke-direct {p0, p2}, Lcom/cyjh/elfin/net/volley/VolleyRequestManager;-><init>(Landroid/content/Context;)V

    return-void
.end method


# virtual methods
.method public onRequestErrorRes(Ljava/lang/String;)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;

    .prologue
    .line 52
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/managers/AdImageManager$1;->val$callback:Lcom/cyjh/elfin/mvp/managers/Callback;

    invoke-interface {v0, p1}, Lcom/cyjh/elfin/mvp/managers/Callback;->error(Ljava/lang/String;)V

    .line 53
    return-void
.end method

.method public onRequestSuccessRes(Ljava/lang/String;)V
    .locals 5
    .param p1, "res"    # Ljava/lang/String;

    .prologue
    .line 39
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "\u5e7f\u544a\uff1a"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-static {v3, v4}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 41
    :try_start_0
    new-instance v2, Lcom/google/gson/Gson;

    invoke-direct {v2}, Lcom/google/gson/Gson;-><init>()V

    .line 42
    .local v2, "gson":Lcom/google/gson/Gson;
    const-class v3, Lcom/cyjh/elfin/entity/Ad;

    invoke-virtual {v2, p1, v3}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/entity/Ad;

    .line 43
    .local v0, "ad":Lcom/cyjh/elfin/entity/Ad;
    iget v3, p0, Lcom/cyjh/elfin/mvp/managers/AdImageManager$1;->val$site:I

    iput v3, v0, Lcom/cyjh/elfin/entity/Ad;->site:I

    .line 44
    iget-object v3, p0, Lcom/cyjh/elfin/mvp/managers/AdImageManager$1;->val$callback:Lcom/cyjh/elfin/mvp/managers/Callback;

    invoke-interface {v3, v0}, Lcom/cyjh/elfin/mvp/managers/Callback;->finish(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 48
    .end local v0    # "ad":Lcom/cyjh/elfin/entity/Ad;
    .end local v2    # "gson":Lcom/google/gson/Gson;
    :goto_0
    return-void

    .line 45
    :catch_0
    move-exception v1

    .line 46
    .local v1, "e":Ljava/lang/Exception;
    iget-object v3, p0, Lcom/cyjh/elfin/mvp/managers/AdImageManager$1;->val$callback:Lcom/cyjh/elfin/mvp/managers/Callback;

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/String;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v3, v4}, Lcom/cyjh/elfin/mvp/managers/Callback;->error(Ljava/lang/String;)V

    goto :goto_0
.end method
