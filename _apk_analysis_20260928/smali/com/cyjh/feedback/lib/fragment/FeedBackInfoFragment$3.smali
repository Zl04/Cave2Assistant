.class Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$3;
.super Ljava/lang/Object;
.source "FeedBackInfoFragment.java"

# interfaces
.implements Lcom/android/volley/Response$ErrorListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->requestNet()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;


# direct methods
.method constructor <init>(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    .prologue
    .line 285
    iput-object p1, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$3;->this$0:Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onErrorResponse(Lcom/android/volley/VolleyError;)V
    .locals 2
    .param p1, "error"    # Lcom/android/volley/VolleyError;

    .prologue
    .line 288
    invoke-virtual {p1}, Lcom/android/volley/VolleyError;->getMessage()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 289
    return-void
.end method
