.class Lcom/cyjh/feedback/lib/dialog/FeedBackDialog$1;
.super Ljava/lang/Object;
.source "FeedBackDialog.java"

# interfaces
.implements Lcom/android/volley/Response$Listener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/android/volley/Response$Listener",
        "<",
        "Lorg/json/JSONObject;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;


# direct methods
.method constructor <init>(Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;

    .prologue
    .line 145
    iput-object p1, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog$1;->this$0:Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public bridge synthetic onResponse(Ljava/lang/Object;)V
    .locals 0

    .prologue
    .line 145
    check-cast p1, Lorg/json/JSONObject;

    invoke-virtual {p0, p1}, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog$1;->onResponse(Lorg/json/JSONObject;)V

    return-void
.end method

.method public onResponse(Lorg/json/JSONObject;)V
    .locals 3
    .param p1, "response"    # Lorg/json/JSONObject;

    .prologue
    const/4 v2, 0x0

    .line 148
    const-string v0, "http://api.mobileanjian.com/api/SetFeedBack"

    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 149
    iget-object v0, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog$1;->this$0:Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;

    invoke-static {v0}, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->access$000(Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;)Lcom/cyjh/feedback/lib/dialog/LoadingDialog;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/feedback/lib/dialog/LoadingDialog;->dismiss()V

    .line 150
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\u6210\u529f"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 151
    iget-object v0, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog$1;->this$0:Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;

    invoke-static {v0, p1}, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->access$100(Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;Lorg/json/JSONObject;)V

    .line 152
    return-void
.end method
