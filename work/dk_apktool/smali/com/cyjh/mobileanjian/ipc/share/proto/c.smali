.class public Lcom/cyjh/mobileanjian/ipc/share/proto/c;
.super Lcom/cyjh/mobileanjian/ipc/share/proto/d;
.source "SourceFile"


# instance fields
.field private a:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;


# direct methods
.method public constructor <init>(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V
    .locals 1

    .prologue
    .line 10
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/d;-><init>()V

    .line 7
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/c;->a:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    .line 11
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/c;->a:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    .line 12
    return-void
.end method

.method public static final a(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;
    .locals 1

    .prologue
    .line 25
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public a()[B
    .locals 1

    .prologue
    .line 17
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/c;->a:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    if-nez v0, :cond_0

    .line 18
    const/4 v0, 0x0

    .line 19
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/c;->a:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->toByteArray()[B

    move-result-object v0

    goto :goto_0
.end method
