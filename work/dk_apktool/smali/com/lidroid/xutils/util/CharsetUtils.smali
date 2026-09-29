.class public Lcom/lidroid/xutils/util/CharsetUtils;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static final DEFAULT_ENCODING_CHARSET:Ljava/lang/String; = "ISO-8859-1"

.field public static final SUPPORT_CHARSET:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 63
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/lidroid/xutils/util/CharsetUtils;->SUPPORT_CHARSET:Ljava/util/List;

    .line 66
    sget-object v0, Lcom/lidroid/xutils/util/CharsetUtils;->SUPPORT_CHARSET:Ljava/util/List;

    const-string v1, "ISO-8859-1"

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 68
    sget-object v0, Lcom/lidroid/xutils/util/CharsetUtils;->SUPPORT_CHARSET:Ljava/util/List;

    const-string v1, "GB2312"

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 69
    sget-object v0, Lcom/lidroid/xutils/util/CharsetUtils;->SUPPORT_CHARSET:Ljava/util/List;

    const-string v1, "GBK"

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 70
    sget-object v0, Lcom/lidroid/xutils/util/CharsetUtils;->SUPPORT_CHARSET:Ljava/util/List;

    const-string v1, "GB18030"

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 72
    sget-object v0, Lcom/lidroid/xutils/util/CharsetUtils;->SUPPORT_CHARSET:Ljava/util/List;

    const-string v1, "US-ASCII"

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 73
    sget-object v0, Lcom/lidroid/xutils/util/CharsetUtils;->SUPPORT_CHARSET:Ljava/util/List;

    const-string v1, "ASCII"

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 75
    sget-object v0, Lcom/lidroid/xutils/util/CharsetUtils;->SUPPORT_CHARSET:Ljava/util/List;

    const-string v1, "ISO-2022-KR"

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 77
    sget-object v0, Lcom/lidroid/xutils/util/CharsetUtils;->SUPPORT_CHARSET:Ljava/util/List;

    const-string v1, "ISO-8859-2"

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 79
    sget-object v0, Lcom/lidroid/xutils/util/CharsetUtils;->SUPPORT_CHARSET:Ljava/util/List;

    const-string v1, "ISO-2022-JP"

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 80
    sget-object v0, Lcom/lidroid/xutils/util/CharsetUtils;->SUPPORT_CHARSET:Ljava/util/List;

    const-string v1, "ISO-2022-JP-2"

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 82
    sget-object v0, Lcom/lidroid/xutils/util/CharsetUtils;->SUPPORT_CHARSET:Ljava/util/List;

    const-string v1, "UTF-8"

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 83
    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 29
    return-void
.end method

.method public static getEncoding(Ljava/lang/String;I)Ljava/lang/String;
    .locals 4

    .prologue
    .line 42
    const-string v1, "ISO-8859-1"

    .line 43
    sget-object v0, Lcom/lidroid/xutils/util/CharsetUtils;->SUPPORT_CHARSET:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_1

    move-object v0, v1

    .line 49
    :goto_0
    return-object v0

    .line 43
    :cond_1
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 44
    invoke-static {p0, v0, p1}, Lcom/lidroid/xutils/util/CharsetUtils;->isCharset(Ljava/lang/String;Ljava/lang/String;I)Z

    move-result v3

    if-eqz v3, :cond_0

    goto :goto_0
.end method

.method public static isCharset(Ljava/lang/String;Ljava/lang/String;I)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 54
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    if-le v1, p2, :cond_0

    const/4 v1, 0x0

    invoke-virtual {p0, v1, p2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p0

    .line 55
    :cond_0
    new-instance v1, Ljava/lang/String;

    invoke-virtual {p0, p1}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v2

    invoke-direct {v1, v2, p1}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 57
    :goto_0
    return v0

    .line 56
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public static toCharset(Ljava/lang/String;Ljava/lang/String;I)Ljava/lang/String;
    .locals 2

    .prologue
    .line 33
    :try_start_0
    invoke-static {p0, p2}, Lcom/lidroid/xutils/util/CharsetUtils;->getEncoding(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v1

    .line 34
    new-instance v0, Ljava/lang/String;

    invoke-virtual {p0, v1}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v1

    invoke-direct {v0, v1, p1}, Ljava/lang/String;-><init>([BLjava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-object p0, v0

    .line 37
    :goto_0
    return-object p0

    .line 35
    :catch_0
    move-exception v0

    .line 36
    invoke-static {v0}, Lcom/lidroid/xutils/util/LogUtils;->w(Ljava/lang/Throwable;)V

    goto :goto_0
.end method
