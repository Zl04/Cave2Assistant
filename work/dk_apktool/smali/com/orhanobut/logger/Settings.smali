.class public final Lcom/orhanobut/logger/Settings;
.super Ljava/lang/Object;
.source "Settings.java"


# instance fields
.field private logLevel:Lcom/orhanobut/logger/LogLevel;

.field private methodCount:I

.field private methodOffset:I

.field private showThreadInfo:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 8
    const/4 v0, 0x2

    iput v0, p0, Lcom/orhanobut/logger/Settings;->methodCount:I

    .line 9
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/orhanobut/logger/Settings;->showThreadInfo:Z

    .line 10
    const/4 v0, 0x0

    iput v0, p0, Lcom/orhanobut/logger/Settings;->methodOffset:I

    .line 15
    sget-object v0, Lcom/orhanobut/logger/LogLevel;->FULL:Lcom/orhanobut/logger/LogLevel;

    iput-object v0, p0, Lcom/orhanobut/logger/Settings;->logLevel:Lcom/orhanobut/logger/LogLevel;

    return-void
.end method


# virtual methods
.method public getLogLevel()Lcom/orhanobut/logger/LogLevel;
    .locals 1

    .prologue
    .line 49
    iget-object v0, p0, Lcom/orhanobut/logger/Settings;->logLevel:Lcom/orhanobut/logger/LogLevel;

    return-object v0
.end method

.method public getMethodCount()I
    .locals 1

    .prologue
    .line 41
    iget v0, p0, Lcom/orhanobut/logger/Settings;->methodCount:I

    return v0
.end method

.method public getMethodOffset()I
    .locals 1

    .prologue
    .line 53
    iget v0, p0, Lcom/orhanobut/logger/Settings;->methodOffset:I

    return v0
.end method

.method public hideThreadInfo()Lcom/orhanobut/logger/Settings;
    .locals 1

    .prologue
    .line 18
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/orhanobut/logger/Settings;->showThreadInfo:Z

    .line 19
    return-object p0
.end method

.method public isShowThreadInfo()Z
    .locals 1

    .prologue
    .line 45
    iget-boolean v0, p0, Lcom/orhanobut/logger/Settings;->showThreadInfo:Z

    return v0
.end method

.method public setLogLevel(Lcom/orhanobut/logger/LogLevel;)Lcom/orhanobut/logger/Settings;
    .locals 0
    .param p1, "logLevel"    # Lcom/orhanobut/logger/LogLevel;

    .prologue
    .line 31
    iput-object p1, p0, Lcom/orhanobut/logger/Settings;->logLevel:Lcom/orhanobut/logger/LogLevel;

    .line 32
    return-object p0
.end method

.method public setMethodCount(I)Lcom/orhanobut/logger/Settings;
    .locals 0
    .param p1, "methodCount"    # I

    .prologue
    .line 23
    if-gez p1, :cond_0

    .line 24
    const/4 p1, 0x0

    .line 26
    :cond_0
    iput p1, p0, Lcom/orhanobut/logger/Settings;->methodCount:I

    .line 27
    return-object p0
.end method

.method public setMethodOffset(I)Lcom/orhanobut/logger/Settings;
    .locals 0
    .param p1, "offset"    # I

    .prologue
    .line 36
    iput p1, p0, Lcom/orhanobut/logger/Settings;->methodOffset:I

    .line 37
    return-object p0
.end method
