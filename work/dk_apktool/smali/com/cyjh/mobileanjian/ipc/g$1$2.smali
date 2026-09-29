.class Lcom/cyjh/mobileanjian/ipc/g$1$2;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/cyjh/mobileanjian/ipc/ui/c$a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/mobileanjian/ipc/g$1;->handleMessage(Landroid/os/Message;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/cyjh/mobileanjian/ipc/g$1;


# direct methods
.method constructor <init>(Lcom/cyjh/mobileanjian/ipc/g$1;)V
    .locals 0

    .prologue
    .line 172
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/g$1$2;->a:Lcom/cyjh/mobileanjian/ipc/g$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 176
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    const/16 v1, 0x43

    .line 177
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 178
    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg2(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 179
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    .line 180
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/g$1$2;->a:Lcom/cyjh/mobileanjian/ipc/g$1;

    iget-object v1, v1, Lcom/cyjh/mobileanjian/ipc/g$1;->a:Lcom/cyjh/mobileanjian/ipc/g;

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/g;->b(Lcom/cyjh/mobileanjian/ipc/g;)Lcom/cyjh/mobileanjian/ipc/d;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/d;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 181
    return-void
.end method
