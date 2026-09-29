.class public final Lcom/orhanobut/logger/Logger;
.super Ljava/lang/Object;
.source "Logger.java"


# static fields
.field private static final DEFAULT_TAG:Ljava/lang/String; = "PRETTYLOGGER"

.field private static final printer:Lcom/orhanobut/logger/Printer;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 11
    new-instance v0, Lcom/orhanobut/logger/LoggerPrinter;

    invoke-direct {v0}, Lcom/orhanobut/logger/LoggerPrinter;-><init>()V

    sput-object v0, Lcom/orhanobut/logger/Logger;->printer:Lcom/orhanobut/logger/Printer;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 16
    return-void
.end method

.method public static varargs d(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .prologue
    .line 49
    sget-object v0, Lcom/orhanobut/logger/Logger;->printer:Lcom/orhanobut/logger/Printer;

    invoke-interface {v0, p0, p1}, Lcom/orhanobut/logger/Printer;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 50
    return-void
.end method

.method public static varargs e(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 2
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .prologue
    .line 53
    sget-object v0, Lcom/orhanobut/logger/Logger;->printer:Lcom/orhanobut/logger/Printer;

    const/4 v1, 0x0

    invoke-interface {v0, v1, p0, p1}, Lcom/orhanobut/logger/Printer;->e(Ljava/lang/Throwable;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 54
    return-void
.end method

.method public static varargs e(Ljava/lang/Throwable;Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .param p0, "throwable"    # Ljava/lang/Throwable;
    .param p1, "message"    # Ljava/lang/String;
    .param p2, "args"    # [Ljava/lang/Object;

    .prologue
    .line 57
    sget-object v0, Lcom/orhanobut/logger/Logger;->printer:Lcom/orhanobut/logger/Printer;

    invoke-interface {v0, p0, p1, p2}, Lcom/orhanobut/logger/Printer;->e(Ljava/lang/Throwable;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 58
    return-void
.end method

.method public static varargs i(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .prologue
    .line 61
    sget-object v0, Lcom/orhanobut/logger/Logger;->printer:Lcom/orhanobut/logger/Printer;

    invoke-interface {v0, p0, p1}, Lcom/orhanobut/logger/Printer;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 62
    return-void
.end method

.method public static init()Lcom/orhanobut/logger/Settings;
    .locals 2

    .prologue
    .line 24
    sget-object v0, Lcom/orhanobut/logger/Logger;->printer:Lcom/orhanobut/logger/Printer;

    const-string v1, "PRETTYLOGGER"

    invoke-interface {v0, v1}, Lcom/orhanobut/logger/Printer;->init(Ljava/lang/String;)Lcom/orhanobut/logger/Settings;

    move-result-object v0

    return-object v0
.end method

.method public static init(Ljava/lang/String;)Lcom/orhanobut/logger/Settings;
    .locals 1
    .param p0, "tag"    # Ljava/lang/String;

    .prologue
    .line 33
    sget-object v0, Lcom/orhanobut/logger/Logger;->printer:Lcom/orhanobut/logger/Printer;

    invoke-interface {v0, p0}, Lcom/orhanobut/logger/Printer;->init(Ljava/lang/String;)Lcom/orhanobut/logger/Settings;

    move-result-object v0

    return-object v0
.end method

.method public static json(Ljava/lang/String;)V
    .locals 1
    .param p0, "json"    # Ljava/lang/String;

    .prologue
    .line 82
    sget-object v0, Lcom/orhanobut/logger/Logger;->printer:Lcom/orhanobut/logger/Printer;

    invoke-interface {v0, p0}, Lcom/orhanobut/logger/Printer;->json(Ljava/lang/String;)V

    .line 83
    return-void
.end method

.method public static t(I)Lcom/orhanobut/logger/Printer;
    .locals 2
    .param p0, "methodCount"    # I

    .prologue
    .line 41
    sget-object v0, Lcom/orhanobut/logger/Logger;->printer:Lcom/orhanobut/logger/Printer;

    const/4 v1, 0x0

    invoke-interface {v0, v1, p0}, Lcom/orhanobut/logger/Printer;->t(Ljava/lang/String;I)Lcom/orhanobut/logger/Printer;

    move-result-object v0

    return-object v0
.end method

.method public static t(Ljava/lang/String;)Lcom/orhanobut/logger/Printer;
    .locals 2
    .param p0, "tag"    # Ljava/lang/String;

    .prologue
    .line 37
    sget-object v0, Lcom/orhanobut/logger/Logger;->printer:Lcom/orhanobut/logger/Printer;

    sget-object v1, Lcom/orhanobut/logger/Logger;->printer:Lcom/orhanobut/logger/Printer;

    invoke-interface {v1}, Lcom/orhanobut/logger/Printer;->getSettings()Lcom/orhanobut/logger/Settings;

    move-result-object v1

    invoke-virtual {v1}, Lcom/orhanobut/logger/Settings;->getMethodCount()I

    move-result v1

    invoke-interface {v0, p0, v1}, Lcom/orhanobut/logger/Printer;->t(Ljava/lang/String;I)Lcom/orhanobut/logger/Printer;

    move-result-object v0

    return-object v0
.end method

.method public static t(Ljava/lang/String;I)Lcom/orhanobut/logger/Printer;
    .locals 1
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "methodCount"    # I

    .prologue
    .line 45
    sget-object v0, Lcom/orhanobut/logger/Logger;->printer:Lcom/orhanobut/logger/Printer;

    invoke-interface {v0, p0, p1}, Lcom/orhanobut/logger/Printer;->t(Ljava/lang/String;I)Lcom/orhanobut/logger/Printer;

    move-result-object v0

    return-object v0
.end method

.method public static varargs v(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .prologue
    .line 65
    sget-object v0, Lcom/orhanobut/logger/Logger;->printer:Lcom/orhanobut/logger/Printer;

    invoke-interface {v0, p0, p1}, Lcom/orhanobut/logger/Printer;->v(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 66
    return-void
.end method

.method public static varargs w(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .prologue
    .line 69
    sget-object v0, Lcom/orhanobut/logger/Logger;->printer:Lcom/orhanobut/logger/Printer;

    invoke-interface {v0, p0, p1}, Lcom/orhanobut/logger/Printer;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 70
    return-void
.end method

.method public static varargs wtf(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .prologue
    .line 73
    sget-object v0, Lcom/orhanobut/logger/Logger;->printer:Lcom/orhanobut/logger/Printer;

    invoke-interface {v0, p0, p1}, Lcom/orhanobut/logger/Printer;->wtf(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 74
    return-void
.end method

.method public static xml(Ljava/lang/String;)V
    .locals 1
    .param p0, "xml"    # Ljava/lang/String;

    .prologue
    .line 91
    sget-object v0, Lcom/orhanobut/logger/Logger;->printer:Lcom/orhanobut/logger/Printer;

    invoke-interface {v0, p0}, Lcom/orhanobut/logger/Printer;->xml(Ljava/lang/String;)V

    .line 92
    return-void
.end method
