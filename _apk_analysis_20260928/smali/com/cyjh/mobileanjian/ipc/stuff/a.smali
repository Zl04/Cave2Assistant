.class public Lcom/cyjh/mobileanjian/ipc/stuff/a;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static a:Landroid/content/Context;

.field private static b:Landroid/os/Handler;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 18
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/stuff/a$1;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/stuff/a$1;-><init>()V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/stuff/a;->b:Landroid/os/Handler;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic a()Landroid/content/Context;
    .locals 1

    .prologue
    .line 15
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/stuff/a;->a:Landroid/content/Context;

    return-object v0
.end method

.method public static a(Landroid/content/Context;)Lcom/goldcoast/sdk/domain/AnalyseResult;
    .locals 1

    .prologue
    .line 34
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/stuff/a;->a:Landroid/content/Context;

    .line 35
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/stuff/a$2;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/stuff/a$2;-><init>()V

    return-object v0
.end method

.method public static a(Landroid/content/Context;Landroid/os/Handler;)Lcom/goldcoast/sdk/domain/AnalyseResult;
    .locals 1

    .prologue
    .line 59
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/stuff/a;->a:Landroid/content/Context;

    .line 60
    const/4 v0, 0x0

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/stuff/a;->b:Landroid/os/Handler;

    .line 61
    sput-object p1, Lcom/cyjh/mobileanjian/ipc/stuff/a;->b:Landroid/os/Handler;

    .line 62
    invoke-static {p0}, Lcom/cyjh/mobileanjian/ipc/stuff/a;->a(Landroid/content/Context;)Lcom/goldcoast/sdk/domain/AnalyseResult;

    move-result-object v0

    return-object v0
.end method

.method static synthetic a(Ljava/lang/String;I)V
    .locals 0

    .prologue
    .line 15
    invoke-static {p0, p1}, Lcom/cyjh/mobileanjian/ipc/stuff/a;->b(Ljava/lang/String;I)V

    return-void
.end method

.method private static b(Ljava/lang/String;I)V
    .locals 3

    .prologue
    .line 66
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/stuff/a;->b:Landroid/os/Handler;

    if-nez v0, :cond_0

    .line 75
    :goto_0
    return-void

    .line 69
    :cond_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/stuff/a;->b:Landroid/os/Handler;

    invoke-virtual {v0}, Landroid/os/Handler;->obtainMessage()Landroid/os/Message;

    move-result-object v0

    .line 70
    new-instance v1, Landroid/os/Bundle;

    invoke-direct {v1}, Landroid/os/Bundle;-><init>()V

    .line 71
    const-string v2, "result"

    invoke-virtual {v1, v2, p0}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 72
    const-string v2, "status"

    invoke-virtual {v1, v2, p1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 73
    invoke-virtual {v0, v1}, Landroid/os/Message;->setData(Landroid/os/Bundle;)V

    .line 74
    sget-object v1, Lcom/cyjh/mobileanjian/ipc/stuff/a;->b:Landroid/os/Handler;

    invoke-virtual {v1, v0}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    goto :goto_0
.end method
