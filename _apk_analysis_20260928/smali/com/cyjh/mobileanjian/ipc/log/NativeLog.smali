.class public Lcom/cyjh/mobileanjian/ipc/log/NativeLog;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static a:Ljava/lang/StringBuffer;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 9
    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/log/NativeLog;->a:Ljava/lang/StringBuffer;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static appendLog(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 13
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/log/NativeLog;->a:Ljava/lang/StringBuffer;

    invoke-virtual {v0}, Ljava/lang/StringBuffer;->length()I

    move-result v0

    if-lez v0, :cond_0

    .line 15
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/log/NativeLog;->a:Ljava/lang/StringBuffer;

    const-string v1, "@_@"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 17
    :cond_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/log/NativeLog;->a:Ljava/lang/StringBuffer;

    invoke-virtual {v0, p0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 18
    return-void
.end method

.method public static getExtraLog()Ljava/lang/String;
    .locals 1

    .prologue
    .line 22
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/log/NativeLog;->a:Ljava/lang/StringBuffer;

    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static reset()V
    .locals 2

    .prologue
    .line 27
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/log/NativeLog;->a:Ljava/lang/StringBuffer;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->setLength(I)V

    .line 28
    return-void
.end method
