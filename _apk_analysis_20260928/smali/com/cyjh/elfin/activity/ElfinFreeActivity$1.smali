.class Lcom/cyjh/elfin/activity/ElfinFreeActivity$1;
.super Ljava/lang/Object;
.source "ElfinFreeActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/activity/ElfinFreeActivity;->onBackPressed()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/activity/ElfinFreeActivity;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/activity/ElfinFreeActivity;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/activity/ElfinFreeActivity;

    .prologue
    .line 205
    iput-object p1, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity$1;->this$0:Lcom/cyjh/elfin/activity/ElfinFreeActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 208
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity$1;->this$0:Lcom/cyjh/elfin/activity/ElfinFreeActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->access$102(Lcom/cyjh/elfin/activity/ElfinFreeActivity;Z)Z

    .line 209
    return-void
.end method
