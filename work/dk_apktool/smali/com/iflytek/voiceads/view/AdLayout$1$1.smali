.class Lcom/iflytek/voiceads/view/AdLayout$1$1;
.super Ljava/lang/Object;
.source "AdLayout.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/iflytek/voiceads/view/AdLayout$1;->onAdDestroy()Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/iflytek/voiceads/view/AdLayout$1;


# direct methods
.method constructor <init>(Lcom/iflytek/voiceads/view/AdLayout$1;)V
    .locals 0

    .prologue
    .line 28
    iput-object p1, p0, Lcom/iflytek/voiceads/view/AdLayout$1$1;->this$1:Lcom/iflytek/voiceads/view/AdLayout$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    .prologue
    .line 32
    iget-object v0, p0, Lcom/iflytek/voiceads/view/AdLayout$1$1;->this$1:Lcom/iflytek/voiceads/view/AdLayout$1;

    iget-object v0, v0, Lcom/iflytek/voiceads/view/AdLayout$1;->this$0:Lcom/iflytek/voiceads/view/AdLayout;

    invoke-virtual {v0}, Lcom/iflytek/voiceads/view/AdLayout;->destroy()V

    .line 33
    return-void
.end method
