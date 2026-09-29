.class Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$2;
.super Ljava/lang/Object;
.source "FeedBackInfoFragment.java"

# interfaces
.implements Lcom/android/volley/Response$Listener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->requestNet()V
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
        "Ljava/lang/String;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;


# direct methods
.method constructor <init>(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    .prologue
    .line 250
    iput-object p1, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$2;->this$0:Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public bridge synthetic onResponse(Ljava/lang/Object;)V
    .locals 0

    .prologue
    .line 250
    check-cast p1, Ljava/lang/String;

    invoke-virtual {p0, p1}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$2;->onResponse(Ljava/lang/String;)V

    return-void
.end method

.method public onResponse(Ljava/lang/String;)V
    .locals 8
    .param p1, "response"    # Ljava/lang/String;

    .prologue
    const/16 v5, 0x8

    const/4 v7, 0x0

    .line 254
    new-array v4, v7, [Ljava/lang/Object;

    invoke-static {p1, v4}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 256
    const-string v0, ""

    .line 258
    .local v0, "authorContact":Ljava/lang/String;
    :try_start_0
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_0

    .line 259
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 260
    .local v3, "jsonObject":Lorg/json/JSONObject;
    const-string v4, "Code"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 261
    .local v1, "code":Ljava/lang/String;
    const/4 v4, 0x1

    invoke-static {v4}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 262
    const-string v4, "Data"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 269
    .end local v1    # "code":Ljava/lang/String;
    .end local v3    # "jsonObject":Lorg/json/JSONObject;
    :cond_0
    :goto_0
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_1

    .line 270
    iget-object v4, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$2;->this$0:Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    invoke-static {v4}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->access$400(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)Landroid/widget/TextView;

    move-result-object v4

    invoke-virtual {v4, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 271
    iget-object v4, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$2;->this$0:Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    invoke-static {v4}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->access$400(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)Landroid/widget/TextView;

    move-result-object v4

    invoke-virtual {v4, v7}, Landroid/widget/TextView;->setVisibility(I)V

    .line 272
    iget-object v4, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$2;->this$0:Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    invoke-static {v4}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->access$500(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)Landroid/view/View;

    move-result-object v4

    invoke-virtual {v4, v7}, Landroid/view/View;->setVisibility(I)V

    .line 284
    :goto_1
    return-void

    .line 265
    :catch_0
    move-exception v2

    .line 266
    .local v2, "e":Lorg/json/JSONException;
    invoke-virtual {v2}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0

    .line 275
    .end local v2    # "e":Lorg/json/JSONException;
    :cond_1
    iget-object v4, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$2;->this$0:Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    invoke-static {v4}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->access$600(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)Z

    move-result v4

    if-nez v4, :cond_2

    .line 276
    iget-object v4, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$2;->this$0:Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    invoke-static {v4}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->access$400(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)Landroid/widget/TextView;

    move-result-object v4

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setVisibility(I)V

    .line 277
    iget-object v4, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$2;->this$0:Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    invoke-static {v4}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->access$500(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)Landroid/view/View;

    move-result-object v4

    invoke-virtual {v4, v5}, Landroid/view/View;->setVisibility(I)V

    goto :goto_1

    .line 279
    :cond_2
    iget-object v4, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$2;->this$0:Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    invoke-static {v4}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->access$500(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)Landroid/view/View;

    move-result-object v4

    invoke-virtual {v4, v7}, Landroid/view/View;->setVisibility(I)V

    .line 280
    iget-object v4, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$2;->this$0:Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    invoke-static {v4}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->access$400(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)Landroid/widget/TextView;

    move-result-object v4

    iget-object v5, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$2;->this$0:Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    sget v6, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->formal_complaints_qq:I

    invoke-virtual {v5, v6}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 281
    iget-object v4, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$2;->this$0:Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    invoke-static {v4}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->access$400(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)Landroid/widget/TextView;

    move-result-object v4

    invoke-virtual {v4, v7}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_1
.end method
