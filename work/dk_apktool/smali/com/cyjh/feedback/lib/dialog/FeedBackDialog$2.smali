.class Lcom/cyjh/feedback/lib/dialog/FeedBackDialog$2;
.super Ljava/lang/Object;
.source "FeedBackDialog.java"

# interfaces
.implements Lcom/android/volley/Response$ErrorListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;


# direct methods
.method constructor <init>(Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;

    .prologue
    .line 153
    iput-object p1, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog$2;->this$0:Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onErrorResponse(Lcom/android/volley/VolleyError;)V
    .locals 3
    .param p1, "error"    # Lcom/android/volley/VolleyError;

    .prologue
    .line 156
    iget-object v0, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog$2;->this$0:Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;

    invoke-static {v0}, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->access$000(Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;)Lcom/cyjh/feedback/lib/dialog/LoadingDialog;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/feedback/lib/dialog/LoadingDialog;->dismiss()V

    .line 157
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\u5931\u8d25"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Lcom/android/volley/VolleyError;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 158
    iget-object v0, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog$2;->this$0:Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;

    invoke-static {v0}, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->access$200(Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;)Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog$2;->this$0:Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;

    invoke-static {v1}, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->access$200(Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;)Landroid/content/Context;

    move-result-object v1

    sget v2, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->commit_data_error:I

    invoke-virtual {v1, v2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x1

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 159
    return-void
.end method
