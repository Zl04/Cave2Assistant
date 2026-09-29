.class Lcom/iflytek/voiceads/view/AdLayout$1;
.super Ljava/lang/Object;
.source "AdLayout.java"

# interfaces
.implements Lcom/iflytek/voiceads/listener/InternalListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/iflytek/voiceads/view/AdLayout;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/iflytek/voiceads/view/AdLayout;


# direct methods
.method constructor <init>(Lcom/iflytek/voiceads/view/AdLayout;)V
    .locals 0

    .prologue
    .line 21
    iput-object p1, p0, Lcom/iflytek/voiceads/view/AdLayout$1;->this$0:Lcom/iflytek/voiceads/view/AdLayout;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAdDestroy()Z
    .locals 3

    .prologue
    const/4 v0, 0x1

    .line 26
    iget-object v1, p0, Lcom/iflytek/voiceads/view/AdLayout$1;->this$0:Lcom/iflytek/voiceads/view/AdLayout;

    invoke-static {v1}, Lcom/iflytek/voiceads/view/AdLayout;->access$000(Lcom/iflytek/voiceads/view/AdLayout;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 27
    iget-object v1, p0, Lcom/iflytek/voiceads/view/AdLayout$1;->this$0:Lcom/iflytek/voiceads/view/AdLayout;

    invoke-static {v1, v0}, Lcom/iflytek/voiceads/view/AdLayout;->access$002(Lcom/iflytek/voiceads/view/AdLayout;Z)Z

    .line 28
    iget-object v1, p0, Lcom/iflytek/voiceads/view/AdLayout$1;->this$0:Lcom/iflytek/voiceads/view/AdLayout;

    iget-object v1, v1, Lcom/iflytek/voiceads/view/AdLayout;->mAdActivity:Landroid/app/Activity;

    new-instance v2, Lcom/iflytek/voiceads/view/AdLayout$1$1;

    invoke-direct {v2, p0}, Lcom/iflytek/voiceads/view/AdLayout$1$1;-><init>(Lcom/iflytek/voiceads/view/AdLayout$1;)V

    invoke-virtual {v1, v2}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 37
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method
