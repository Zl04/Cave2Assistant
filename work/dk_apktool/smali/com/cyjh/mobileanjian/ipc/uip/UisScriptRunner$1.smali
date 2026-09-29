.class Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner$1;
.super Ljava/lang/Thread;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;->startLoop(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;


# direct methods
.method constructor <init>(Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 43
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner$1;->b:Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;

    iput-object p2, p0, Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner$1;->a:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    .line 47
    invoke-super {p0}, Ljava/lang/Thread;->run()V

    .line 48
    const-string v0, "\u5f00\u59cb\u8fd0\u884cUIS\u811a\u672c"

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 49
    const/4 v0, 0x1

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;->a(Z)Z

    .line 50
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner$1;->b:Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;->a(Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;)Lcom/cyjh/mqm/MQUipStub;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner$1;->a:Ljava/lang/String;

    const-wide/16 v2, 0x0

    invoke-virtual {v0, v1, v2, v3}, Lcom/cyjh/mqm/MQUipStub;->StartLoop(Ljava/lang/String;J)I

    .line 51
    const-string v0, "\u5df2\u505c\u6b62UIS\u811a\u672c"

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 52
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;->a(Z)Z

    .line 53
    return-void
.end method
