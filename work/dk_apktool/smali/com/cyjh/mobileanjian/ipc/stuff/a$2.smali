.class final Lcom/cyjh/mobileanjian/ipc/stuff/a$2;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/goldcoast/sdk/domain/AnalyseResult;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/mobileanjian/ipc/stuff/a;->a(Landroid/content/Context;)Lcom/goldcoast/sdk/domain/AnalyseResult;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onException(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 54
    const/4 v0, 0x3

    invoke-static {p1, v0}, Lcom/cyjh/mobileanjian/ipc/stuff/a;->a(Ljava/lang/String;I)V

    .line 55
    return-void
.end method

.method public onFailed(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 44
    const/4 v0, 0x1

    invoke-static {p1, v0}, Lcom/cyjh/mobileanjian/ipc/stuff/a;->a(Ljava/lang/String;I)V

    .line 45
    return-void
.end method

.method public onProgress(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 49
    const/4 v0, 0x2

    invoke-static {p1, v0}, Lcom/cyjh/mobileanjian/ipc/stuff/a;->a(Ljava/lang/String;I)V

    .line 50
    return-void
.end method

.method public onSuccess(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 39
    const/4 v0, 0x0

    invoke-static {p1, v0}, Lcom/cyjh/mobileanjian/ipc/stuff/a;->a(Ljava/lang/String;I)V

    .line 40
    return-void
.end method
