.class public Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static final columnType_columnConverter_map:Ljava/util/concurrent/ConcurrentHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ConcurrentHashMap",
            "<",
            "Ljava/lang/String;",
            "Lcom/lidroid/xutils/db/converter/ColumnConverter;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    .line 65
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    sput-object v0, Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;->columnType_columnConverter_map:Ljava/util/concurrent/ConcurrentHashMap;

    .line 67
    new-instance v0, Lcom/lidroid/xutils/db/converter/BooleanColumnConverter;

    invoke-direct {v0}, Lcom/lidroid/xutils/db/converter/BooleanColumnConverter;-><init>()V

    .line 68
    sget-object v1, Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;->columnType_columnConverter_map:Ljava/util/concurrent/ConcurrentHashMap;

    sget-object v2, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 69
    sget-object v1, Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;->columnType_columnConverter_map:Ljava/util/concurrent/ConcurrentHashMap;

    const-class v2, Ljava/lang/Boolean;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 71
    new-instance v0, Lcom/lidroid/xutils/db/converter/ByteArrayColumnConverter;

    invoke-direct {v0}, Lcom/lidroid/xutils/db/converter/ByteArrayColumnConverter;-><init>()V

    .line 72
    sget-object v1, Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;->columnType_columnConverter_map:Ljava/util/concurrent/ConcurrentHashMap;

    const-class v2, [B

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 74
    new-instance v0, Lcom/lidroid/xutils/db/converter/ByteColumnConverter;

    invoke-direct {v0}, Lcom/lidroid/xutils/db/converter/ByteColumnConverter;-><init>()V

    .line 75
    sget-object v1, Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;->columnType_columnConverter_map:Ljava/util/concurrent/ConcurrentHashMap;

    sget-object v2, Ljava/lang/Byte;->TYPE:Ljava/lang/Class;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 76
    sget-object v1, Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;->columnType_columnConverter_map:Ljava/util/concurrent/ConcurrentHashMap;

    const-class v2, Ljava/lang/Byte;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 78
    new-instance v0, Lcom/lidroid/xutils/db/converter/CharColumnConverter;

    invoke-direct {v0}, Lcom/lidroid/xutils/db/converter/CharColumnConverter;-><init>()V

    .line 79
    sget-object v1, Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;->columnType_columnConverter_map:Ljava/util/concurrent/ConcurrentHashMap;

    sget-object v2, Ljava/lang/Character;->TYPE:Ljava/lang/Class;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 80
    sget-object v1, Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;->columnType_columnConverter_map:Ljava/util/concurrent/ConcurrentHashMap;

    const-class v2, Ljava/lang/Character;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 82
    new-instance v0, Lcom/lidroid/xutils/db/converter/DateColumnConverter;

    invoke-direct {v0}, Lcom/lidroid/xutils/db/converter/DateColumnConverter;-><init>()V

    .line 83
    sget-object v1, Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;->columnType_columnConverter_map:Ljava/util/concurrent/ConcurrentHashMap;

    const-class v2, Ljava/util/Date;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 85
    new-instance v0, Lcom/lidroid/xutils/db/converter/DoubleColumnConverter;

    invoke-direct {v0}, Lcom/lidroid/xutils/db/converter/DoubleColumnConverter;-><init>()V

    .line 86
    sget-object v1, Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;->columnType_columnConverter_map:Ljava/util/concurrent/ConcurrentHashMap;

    sget-object v2, Ljava/lang/Double;->TYPE:Ljava/lang/Class;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 87
    sget-object v1, Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;->columnType_columnConverter_map:Ljava/util/concurrent/ConcurrentHashMap;

    const-class v2, Ljava/lang/Double;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 89
    new-instance v0, Lcom/lidroid/xutils/db/converter/FloatColumnConverter;

    invoke-direct {v0}, Lcom/lidroid/xutils/db/converter/FloatColumnConverter;-><init>()V

    .line 90
    sget-object v1, Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;->columnType_columnConverter_map:Ljava/util/concurrent/ConcurrentHashMap;

    sget-object v2, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 91
    sget-object v1, Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;->columnType_columnConverter_map:Ljava/util/concurrent/ConcurrentHashMap;

    const-class v2, Ljava/lang/Float;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 93
    new-instance v0, Lcom/lidroid/xutils/db/converter/IntegerColumnConverter;

    invoke-direct {v0}, Lcom/lidroid/xutils/db/converter/IntegerColumnConverter;-><init>()V

    .line 94
    sget-object v1, Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;->columnType_columnConverter_map:Ljava/util/concurrent/ConcurrentHashMap;

    sget-object v2, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 95
    sget-object v1, Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;->columnType_columnConverter_map:Ljava/util/concurrent/ConcurrentHashMap;

    const-class v2, Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 97
    new-instance v0, Lcom/lidroid/xutils/db/converter/LongColumnConverter;

    invoke-direct {v0}, Lcom/lidroid/xutils/db/converter/LongColumnConverter;-><init>()V

    .line 98
    sget-object v1, Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;->columnType_columnConverter_map:Ljava/util/concurrent/ConcurrentHashMap;

    sget-object v2, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 99
    sget-object v1, Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;->columnType_columnConverter_map:Ljava/util/concurrent/ConcurrentHashMap;

    const-class v2, Ljava/lang/Long;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 101
    new-instance v0, Lcom/lidroid/xutils/db/converter/ShortColumnConverter;

    invoke-direct {v0}, Lcom/lidroid/xutils/db/converter/ShortColumnConverter;-><init>()V

    .line 102
    sget-object v1, Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;->columnType_columnConverter_map:Ljava/util/concurrent/ConcurrentHashMap;

    sget-object v2, Ljava/lang/Short;->TYPE:Ljava/lang/Class;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 103
    sget-object v1, Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;->columnType_columnConverter_map:Ljava/util/concurrent/ConcurrentHashMap;

    const-class v2, Ljava/lang/Short;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 105
    new-instance v0, Lcom/lidroid/xutils/db/converter/SqlDateColumnConverter;

    invoke-direct {v0}, Lcom/lidroid/xutils/db/converter/SqlDateColumnConverter;-><init>()V

    .line 106
    sget-object v1, Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;->columnType_columnConverter_map:Ljava/util/concurrent/ConcurrentHashMap;

    const-class v2, Ljava/sql/Date;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 108
    new-instance v0, Lcom/lidroid/xutils/db/converter/StringColumnConverter;

    invoke-direct {v0}, Lcom/lidroid/xutils/db/converter/StringColumnConverter;-><init>()V

    .line 109
    sget-object v1, Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;->columnType_columnConverter_map:Ljava/util/concurrent/ConcurrentHashMap;

    const-class v2, Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 110
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

.method public static getColumnConverter(Ljava/lang/Class;)Lcom/lidroid/xutils/db/converter/ColumnConverter;
    .locals 3

    .prologue
    .line 19
    sget-object v0, Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;->columnType_columnConverter_map:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {p0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/concurrent/ConcurrentHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 20
    sget-object v0, Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;->columnType_columnConverter_map:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {p0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lidroid/xutils/db/converter/ColumnConverter;

    .line 31
    :cond_0
    :goto_0
    return-object v0

    .line 21
    :cond_1
    const-class v0, Lcom/lidroid/xutils/db/converter/ColumnConverter;

    invoke-virtual {v0, p0}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 23
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/Class;->newInstance()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lidroid/xutils/db/converter/ColumnConverter;

    .line 24
    if-eqz v0, :cond_0

    .line 25
    sget-object v1, Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;->columnType_columnConverter_map:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {p0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 28
    :catch_0
    move-exception v0

    .line 31
    :cond_2
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static getDbColumnType(Ljava/lang/Class;)Lcom/lidroid/xutils/db/sqlite/ColumnDbType;
    .locals 1

    .prologue
    .line 35
    invoke-static {p0}, Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;->getColumnConverter(Ljava/lang/Class;)Lcom/lidroid/xutils/db/converter/ColumnConverter;

    move-result-object v0

    .line 36
    if-eqz v0, :cond_0

    .line 37
    invoke-interface {v0}, Lcom/lidroid/xutils/db/converter/ColumnConverter;->getColumnDbType()Lcom/lidroid/xutils/db/sqlite/ColumnDbType;

    move-result-object v0

    .line 39
    :goto_0
    return-object v0

    :cond_0
    sget-object v0, Lcom/lidroid/xutils/db/sqlite/ColumnDbType;->TEXT:Lcom/lidroid/xutils/db/sqlite/ColumnDbType;

    goto :goto_0
.end method

.method public static isSupportColumnConverter(Ljava/lang/Class;)Z
    .locals 5

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 47
    sget-object v0, Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;->columnType_columnConverter_map:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {p0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/util/concurrent/ConcurrentHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    move v0, v1

    .line 59
    :goto_0
    return v0

    .line 49
    :cond_0
    const-class v0, Lcom/lidroid/xutils/db/converter/ColumnConverter;

    invoke-virtual {v0, p0}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 51
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/Class;->newInstance()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lidroid/xutils/db/converter/ColumnConverter;

    .line 52
    if-eqz v0, :cond_1

    .line 53
    sget-object v3, Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;->columnType_columnConverter_map:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {p0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4, v0}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 55
    :cond_1
    if-nez v0, :cond_2

    move v0, v1

    goto :goto_0

    :cond_2
    move v0, v2

    goto :goto_0

    .line 56
    :catch_0
    move-exception v0

    :cond_3
    move v0, v2

    .line 59
    goto :goto_0
.end method

.method public static registerColumnConverter(Ljava/lang/Class;Lcom/lidroid/xutils/db/converter/ColumnConverter;)V
    .locals 2

    .prologue
    .line 43
    sget-object v0, Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;->columnType_columnConverter_map:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {p0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, p1}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 44
    return-void
.end method
