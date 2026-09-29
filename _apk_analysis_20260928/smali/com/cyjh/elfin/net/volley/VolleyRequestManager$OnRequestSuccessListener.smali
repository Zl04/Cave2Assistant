.class Lcom/cyjh/elfin/net/volley/VolleyRequestManager$OnRequestSuccessListener;
.super Ljava/lang/Object;
.source "VolleyRequestManager.java"

# interfaces
.implements Lcom/android/volley/Response$Listener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/net/volley/VolleyRequestManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "OnRequestSuccessListener"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/android/volley/Response$Listener",
        "<",
        "Ljava/lang/String;",
        ">;"
    }
.end annotation


# instance fields
.field private context:Landroid/content/Context;

.field final synthetic this$0:Lcom/cyjh/elfin/net/volley/VolleyRequestManager;


# direct methods
.method public constructor <init>(Lcom/cyjh/elfin/net/volley/VolleyRequestManager;Landroid/content/Context;)V
    .locals 0
    .param p2, "context"    # Landroid/content/Context;

    .prologue
    .line 46
    iput-object p1, p0, Lcom/cyjh/elfin/net/volley/VolleyRequestManager$OnRequestSuccessListener;->this$0:Lcom/cyjh/elfin/net/volley/VolleyRequestManager;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 47
    iput-object p2, p0, Lcom/cyjh/elfin/net/volley/VolleyRequestManager$OnRequestSuccessListener;->context:Landroid/content/Context;

    .line 48
    return-void
.end method


# virtual methods
.method public bridge synthetic onResponse(Ljava/lang/Object;)V
    .locals 0

    .prologue
    .line 43
    check-cast p1, Ljava/lang/String;

    invoke-virtual {p0, p1}, Lcom/cyjh/elfin/net/volley/VolleyRequestManager$OnRequestSuccessListener;->onResponse(Ljava/lang/String;)V

    return-void
.end method

.method public onResponse(Ljava/lang/String;)V
    .locals 5
    .param p1, "response"    # Ljava/lang/String;

    .prologue
    .line 52
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "\t\t\t"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/net/volley/VolleyRequestManager$OnRequestSuccessListener;->this$0:Lcom/cyjh/elfin/net/volley/VolleyRequestManager;

    iget-object v2, v2, Lcom/cyjh/elfin/net/volley/VolleyRequestManager;->networkTime:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\nnetwork request successful response message\n"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 53
    .local v0, "msg":Ljava/lang/String;
    iget-object v1, p0, Lcom/cyjh/elfin/net/volley/VolleyRequestManager$OnRequestSuccessListener;->context:Landroid/content/Context;

    if-eqz v1, :cond_0

    .line 54
    new-instance v1, Lcom/cyjh/elfin/async/NetworkReqMessageTask;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\n\trequest end\n\n\n"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/cyjh/elfin/net/volley/VolleyRequestManager$OnRequestSuccessListener;->context:Landroid/content/Context;

    invoke-direct {v1, v2, v3}, Lcom/cyjh/elfin/async/NetworkReqMessageTask;-><init>(Ljava/lang/String;Landroid/content/Context;)V

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/io/File;

    const/4 v3, 0x0

    iget-object v4, p0, Lcom/cyjh/elfin/net/volley/VolleyRequestManager$OnRequestSuccessListener;->context:Landroid/content/Context;

    invoke-static {v4}, Lcom/cyjh/elfin/constant/Constants;->getNetworkErrorLogFile(Landroid/content/Context;)Ljava/io/File;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/async/NetworkReqMessageTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    .line 56
    :cond_0
    iget-object v1, p0, Lcom/cyjh/elfin/net/volley/VolleyRequestManager$OnRequestSuccessListener;->this$0:Lcom/cyjh/elfin/net/volley/VolleyRequestManager;

    invoke-virtual {v1, p1}, Lcom/cyjh/elfin/net/volley/VolleyRequestManager;->onRequestSuccessRes(Ljava/lang/String;)V

    .line 57
    return-void
.end method
