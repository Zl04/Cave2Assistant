.class final Lcom/orhanobut/logger/LoggerPrinter;
.super Ljava/lang/Object;
.source "LoggerPrinter.java"

# interfaces
.implements Lcom/orhanobut/logger/Printer;


# static fields
.field private static final BOTTOM_BORDER:Ljava/lang/String; = "\u255a\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550"

.field private static final BOTTOM_LEFT_CORNER:C = '\u255a'

.field private static final CHUNK_SIZE:I = 0xfa0

.field private static final DOUBLE_DIVIDER:Ljava/lang/String; = "\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550"

.field private static final HORIZONTAL_DOUBLE_LINE:C = '\u2551'

.field private static final JSON_INDENT:I = 0x4

.field private static final LOCAL_METHOD_COUNT:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal",
            "<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private static final LOCAL_TAG:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final MIDDLE_BORDER:Ljava/lang/String; = "\u255f\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500"

.field private static final MIDDLE_CORNER:C = '\u255f'

.field private static final MIN_STACK_OFFSET:I = 0x3

.field private static final SINGLE_DIVIDER:Ljava/lang/String; = "\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500"

.field private static TAG:Ljava/lang/String; = null

.field private static final TOP_BORDER:Ljava/lang/String; = "\u2554\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550"

.field private static final TOP_LEFT_CORNER:C = '\u2554'

.field private static final settings:Lcom/orhanobut/logger/Settings;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 49
    new-instance v0, Lcom/orhanobut/logger/Settings;

    invoke-direct {v0}, Lcom/orhanobut/logger/Settings;-><init>()V

    sput-object v0, Lcom/orhanobut/logger/LoggerPrinter;->settings:Lcom/orhanobut/logger/Settings;

    .line 68
    const-string v0, "PRETTYLOGGER"

    sput-object v0, Lcom/orhanobut/logger/LoggerPrinter;->TAG:Ljava/lang/String;

    .line 73
    new-instance v0, Ljava/lang/ThreadLocal;

    invoke-direct {v0}, Ljava/lang/ThreadLocal;-><init>()V

    sput-object v0, Lcom/orhanobut/logger/LoggerPrinter;->LOCAL_TAG:Ljava/lang/ThreadLocal;

    .line 74
    new-instance v0, Ljava/lang/ThreadLocal;

    invoke-direct {v0}, Ljava/lang/ThreadLocal;-><init>()V

    sput-object v0, Lcom/orhanobut/logger/LoggerPrinter;->LOCAL_METHOD_COUNT:Ljava/lang/ThreadLocal;

    return-void
.end method

.method constructor <init>()V
    .locals 0

    .prologue
    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private varargs createMessage(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 1
    .param p1, "message"    # Ljava/lang/String;
    .param p2, "args"    # [Ljava/lang/Object;

    .prologue
    .line 346
    array-length v0, p2

    if-nez v0, :cond_0

    .end local p1    # "message":Ljava/lang/String;
    :goto_0
    return-object p1

    .restart local p1    # "message":Ljava/lang/String;
    :cond_0
    invoke-static {p1, p2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    goto :goto_0
.end method

.method private formatTag(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "tag"    # Ljava/lang/String;

    .prologue
    .line 327
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Lcom/orhanobut/logger/LoggerPrinter;->TAG:Ljava/lang/String;

    invoke-static {v0, p1}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 328
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/orhanobut/logger/LoggerPrinter;->TAG:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "-"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 330
    :goto_0
    return-object v0

    :cond_0
    sget-object v0, Lcom/orhanobut/logger/LoggerPrinter;->TAG:Ljava/lang/String;

    goto :goto_0
.end method

.method private getMethodCount()I
    .locals 4

    .prologue
    .line 350
    sget-object v2, Lcom/orhanobut/logger/LoggerPrinter;->LOCAL_METHOD_COUNT:Ljava/lang/ThreadLocal;

    invoke-virtual {v2}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 351
    .local v0, "count":Ljava/lang/Integer;
    sget-object v2, Lcom/orhanobut/logger/LoggerPrinter;->settings:Lcom/orhanobut/logger/Settings;

    invoke-virtual {v2}, Lcom/orhanobut/logger/Settings;->getMethodCount()I

    move-result v1

    .line 352
    .local v1, "result":I
    if-eqz v0, :cond_0

    .line 353
    sget-object v2, Lcom/orhanobut/logger/LoggerPrinter;->LOCAL_METHOD_COUNT:Ljava/lang/ThreadLocal;

    invoke-virtual {v2}, Ljava/lang/ThreadLocal;->remove()V

    .line 354
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v1

    .line 356
    :cond_0
    if-gez v1, :cond_1

    .line 357
    new-instance v2, Ljava/lang/IllegalStateException;

    const-string v3, "methodCount cannot be negative"

    invoke-direct {v2, v3}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 359
    :cond_1
    return v1
.end method

.method private getSimpleClassName(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;

    .prologue
    .line 322
    const-string v1, "."

    invoke-virtual {p1, v1}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v0

    .line 323
    .local v0, "lastIndex":I
    add-int/lit8 v1, v0, 0x1

    invoke-virtual {p1, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method private getStackOffset([Ljava/lang/StackTraceElement;)I
    .locals 4
    .param p1, "trace"    # [Ljava/lang/StackTraceElement;

    .prologue
    .line 369
    const/4 v1, 0x3

    .local v1, "i":I
    :goto_0
    array-length v3, p1

    if-ge v1, v3, :cond_1

    .line 370
    aget-object v0, p1, v1

    .line 371
    .local v0, "e":Ljava/lang/StackTraceElement;
    invoke-virtual {v0}, Ljava/lang/StackTraceElement;->getClassName()Ljava/lang/String;

    move-result-object v2

    .line 372
    .local v2, "name":Ljava/lang/String;
    const-class v3, Lcom/orhanobut/logger/LoggerPrinter;

    invoke-virtual {v3}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_0

    const-class v3, Lcom/orhanobut/logger/Logger;

    invoke-virtual {v3}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_0

    .line 373
    add-int/lit8 v1, v1, -0x1

    move v3, v1

    .line 376
    .end local v0    # "e":Ljava/lang/StackTraceElement;
    .end local v2    # "name":Ljava/lang/String;
    :goto_1
    return v3

    .line 369
    .restart local v0    # "e":Ljava/lang/StackTraceElement;
    .restart local v2    # "name":Ljava/lang/String;
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 376
    .end local v0    # "e":Ljava/lang/StackTraceElement;
    .end local v2    # "name":Ljava/lang/String;
    :cond_1
    const/4 v3, -0x1

    goto :goto_1
.end method

.method private getTag()Ljava/lang/String;
    .locals 2

    .prologue
    .line 337
    sget-object v1, Lcom/orhanobut/logger/LoggerPrinter;->LOCAL_TAG:Ljava/lang/ThreadLocal;

    invoke-virtual {v1}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 338
    .local v0, "tag":Ljava/lang/String;
    if-eqz v0, :cond_0

    .line 339
    sget-object v1, Lcom/orhanobut/logger/LoggerPrinter;->LOCAL_TAG:Ljava/lang/ThreadLocal;

    invoke-virtual {v1}, Ljava/lang/ThreadLocal;->remove()V

    .line 342
    .end local v0    # "tag":Ljava/lang/String;
    :goto_0
    return-object v0

    .restart local v0    # "tag":Ljava/lang/String;
    :cond_0
    sget-object v0, Lcom/orhanobut/logger/LoggerPrinter;->TAG:Ljava/lang/String;

    goto :goto_0
.end method

.method private varargs declared-synchronized log(ILjava/lang/String;[Ljava/lang/Object;)V
    .locals 10
    .param p1, "logType"    # I
    .param p2, "msg"    # Ljava/lang/String;
    .param p3, "args"    # [Ljava/lang/Object;

    .prologue
    const/16 v9, 0xfa0

    .line 207
    monitor-enter p0

    :try_start_0
    sget-object v7, Lcom/orhanobut/logger/LoggerPrinter;->settings:Lcom/orhanobut/logger/Settings;

    invoke-virtual {v7}, Lcom/orhanobut/logger/Settings;->getLogLevel()Lcom/orhanobut/logger/LogLevel;

    move-result-object v7

    sget-object v8, Lcom/orhanobut/logger/LogLevel;->NONE:Lcom/orhanobut/logger/LogLevel;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-ne v7, v8, :cond_0

    .line 237
    :goto_0
    monitor-exit p0

    return-void

    .line 210
    :cond_0
    :try_start_1
    invoke-direct {p0}, Lcom/orhanobut/logger/LoggerPrinter;->getTag()Ljava/lang/String;

    move-result-object v6

    .line 211
    .local v6, "tag":Ljava/lang/String;
    invoke-direct {p0, p2, p3}, Lcom/orhanobut/logger/LoggerPrinter;->createMessage(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    .line 212
    .local v4, "message":Ljava/lang/String;
    invoke-direct {p0}, Lcom/orhanobut/logger/LoggerPrinter;->getMethodCount()I

    move-result v5

    .line 214
    .local v5, "methodCount":I
    invoke-direct {p0, p1, v6}, Lcom/orhanobut/logger/LoggerPrinter;->logTopBorder(ILjava/lang/String;)V

    .line 215
    invoke-direct {p0, p1, v6, v5}, Lcom/orhanobut/logger/LoggerPrinter;->logHeaderContent(ILjava/lang/String;I)V

    .line 218
    invoke-virtual {v4}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    .line 219
    .local v0, "bytes":[B
    array-length v3, v0

    .line 220
    .local v3, "length":I
    if-gt v3, v9, :cond_2

    .line 221
    if-lez v5, :cond_1

    .line 222
    invoke-direct {p0, p1, v6}, Lcom/orhanobut/logger/LoggerPrinter;->logDivider(ILjava/lang/String;)V

    .line 224
    :cond_1
    invoke-direct {p0, p1, v6, v4}, Lcom/orhanobut/logger/LoggerPrinter;->logContent(ILjava/lang/String;Ljava/lang/String;)V

    .line 225
    invoke-direct {p0, p1, v6}, Lcom/orhanobut/logger/LoggerPrinter;->logBottomBorder(ILjava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 207
    .end local v0    # "bytes":[B
    .end local v3    # "length":I
    .end local v4    # "message":Ljava/lang/String;
    .end local v5    # "methodCount":I
    .end local v6    # "tag":Ljava/lang/String;
    :catchall_0
    move-exception v7

    monitor-exit p0

    throw v7

    .line 228
    .restart local v0    # "bytes":[B
    .restart local v3    # "length":I
    .restart local v4    # "message":Ljava/lang/String;
    .restart local v5    # "methodCount":I
    .restart local v6    # "tag":Ljava/lang/String;
    :cond_2
    if-lez v5, :cond_3

    .line 229
    :try_start_2
    invoke-direct {p0, p1, v6}, Lcom/orhanobut/logger/LoggerPrinter;->logDivider(ILjava/lang/String;)V

    .line 231
    :cond_3
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_1
    if-ge v2, v3, :cond_4

    .line 232
    sub-int v7, v3, v2

    const/16 v8, 0xfa0

    invoke-static {v7, v8}, Ljava/lang/Math;->min(II)I

    move-result v1

    .line 234
    .local v1, "count":I
    new-instance v7, Ljava/lang/String;

    invoke-direct {v7, v0, v2, v1}, Ljava/lang/String;-><init>([BII)V

    invoke-direct {p0, p1, v6, v7}, Lcom/orhanobut/logger/LoggerPrinter;->logContent(ILjava/lang/String;Ljava/lang/String;)V

    .line 231
    add-int/lit16 v2, v2, 0xfa0

    goto :goto_1

    .line 236
    .end local v1    # "count":I
    :cond_4
    invoke-direct {p0, p1, v6}, Lcom/orhanobut/logger/LoggerPrinter;->logBottomBorder(ILjava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0
.end method

.method private logBottomBorder(ILjava/lang/String;)V
    .locals 1
    .param p1, "logType"    # I
    .param p2, "tag"    # Ljava/lang/String;

    .prologue
    .line 281
    const-string v0, "\u255a\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550"

    invoke-direct {p0, p1, p2, v0}, Lcom/orhanobut/logger/LoggerPrinter;->logChunk(ILjava/lang/String;Ljava/lang/String;)V

    .line 282
    return-void
.end method

.method private logChunk(ILjava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "logType"    # I
    .param p2, "tag"    # Ljava/lang/String;
    .param p3, "chunk"    # Ljava/lang/String;

    .prologue
    .line 296
    invoke-direct {p0, p2}, Lcom/orhanobut/logger/LoggerPrinter;->formatTag(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 297
    .local v0, "finalTag":Ljava/lang/String;
    packed-switch p1, :pswitch_data_0

    .line 316
    :pswitch_0
    invoke-static {v0, p3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 319
    :goto_0
    return-void

    .line 299
    :pswitch_1
    invoke-static {v0, p3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 302
    :pswitch_2
    invoke-static {v0, p3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 305
    :pswitch_3
    invoke-static {v0, p3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 308
    :pswitch_4
    invoke-static {v0, p3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 311
    :pswitch_5
    invoke-static {v0, p3}, Landroid/util/Log;->wtf(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 297
    nop

    :pswitch_data_0
    .packed-switch 0x2
        :pswitch_3
        :pswitch_0
        :pswitch_2
        :pswitch_4
        :pswitch_1
        :pswitch_5
    .end packed-switch
.end method

.method private logContent(ILjava/lang/String;Ljava/lang/String;)V
    .locals 7
    .param p1, "logType"    # I
    .param p2, "tag"    # Ljava/lang/String;
    .param p3, "chunk"    # Ljava/lang/String;

    .prologue
    .line 289
    const-string v5, "line.separator"

    invoke-static {v5}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p3, v5}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v4

    .line 290
    .local v4, "lines":[Ljava/lang/String;
    move-object v0, v4

    .local v0, "arr$":[Ljava/lang/String;
    array-length v2, v0

    .local v2, "len$":I
    const/4 v1, 0x0

    .local v1, "i$":I
    :goto_0
    if-ge v1, v2, :cond_0

    aget-object v3, v0, v1

    .line 291
    .local v3, "line":Ljava/lang/String;
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "\u2551 "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {p0, p1, p2, v5}, Lcom/orhanobut/logger/LoggerPrinter;->logChunk(ILjava/lang/String;Ljava/lang/String;)V

    .line 290
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 293
    .end local v3    # "line":Ljava/lang/String;
    :cond_0
    return-void
.end method

.method private logDivider(ILjava/lang/String;)V
    .locals 1
    .param p1, "logType"    # I
    .param p2, "tag"    # Ljava/lang/String;

    .prologue
    .line 285
    const-string v0, "\u255f\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500"

    invoke-direct {p0, p1, p2, v0}, Lcom/orhanobut/logger/LoggerPrinter;->logChunk(ILjava/lang/String;Ljava/lang/String;)V

    .line 286
    return-void
.end method

.method private logHeaderContent(ILjava/lang/String;I)V
    .locals 8
    .param p1, "logType"    # I
    .param p2, "tag"    # Ljava/lang/String;
    .param p3, "methodCount"    # I

    .prologue
    .line 244
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/Thread;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object v5

    .line 245
    .local v5, "trace":[Ljava/lang/StackTraceElement;
    sget-object v6, Lcom/orhanobut/logger/LoggerPrinter;->settings:Lcom/orhanobut/logger/Settings;

    invoke-virtual {v6}, Lcom/orhanobut/logger/Settings;->isShowThreadInfo()Z

    move-result v6

    if-eqz v6, :cond_0

    .line 246
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "\u2551 Thread: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/Thread;->getName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {p0, p1, p2, v6}, Lcom/orhanobut/logger/LoggerPrinter;->logChunk(ILjava/lang/String;Ljava/lang/String;)V

    .line 247
    invoke-direct {p0, p1, p2}, Lcom/orhanobut/logger/LoggerPrinter;->logDivider(ILjava/lang/String;)V

    .line 249
    :cond_0
    const-string v2, ""

    .line 251
    .local v2, "level":Ljava/lang/String;
    invoke-direct {p0, v5}, Lcom/orhanobut/logger/LoggerPrinter;->getStackOffset([Ljava/lang/StackTraceElement;)I

    move-result v6

    sget-object v7, Lcom/orhanobut/logger/LoggerPrinter;->settings:Lcom/orhanobut/logger/Settings;

    invoke-virtual {v7}, Lcom/orhanobut/logger/Settings;->getMethodOffset()I

    move-result v7

    add-int v4, v6, v7

    .line 254
    .local v4, "stackOffset":I
    add-int v6, p3, v4

    array-length v7, v5

    if-le v6, v7, :cond_1

    .line 255
    array-length v6, v5

    sub-int/2addr v6, v4

    add-int/lit8 p3, v6, -0x1

    .line 258
    :cond_1
    move v1, p3

    .local v1, "i":I
    :goto_0
    if-lez v1, :cond_3

    .line 259
    add-int v3, v1, v4

    .line 260
    .local v3, "stackIndex":I
    array-length v6, v5

    if-lt v3, v6, :cond_2

    .line 258
    :goto_1
    add-int/lit8 v1, v1, -0x1

    goto :goto_0

    .line 263
    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 264
    .local v0, "builder":Ljava/lang/StringBuilder;
    const-string v6, "\u2551 "

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    aget-object v7, v5, v3

    invoke-virtual {v7}, Ljava/lang/StackTraceElement;->getClassName()Ljava/lang/String;

    move-result-object v7

    invoke-direct {p0, v7}, Lcom/orhanobut/logger/LoggerPrinter;->getSimpleClassName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "."

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    aget-object v7, v5, v3

    invoke-virtual {v7}, Ljava/lang/StackTraceElement;->getMethodName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " ("

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    aget-object v7, v5, v3

    invoke-virtual {v7}, Ljava/lang/StackTraceElement;->getFileName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ":"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    aget-object v7, v5, v3

    invoke-virtual {v7}, Ljava/lang/StackTraceElement;->getLineNumber()I

    move-result v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ")"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 275
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "   "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 276
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {p0, p1, p2, v6}, Lcom/orhanobut/logger/LoggerPrinter;->logChunk(ILjava/lang/String;Ljava/lang/String;)V

    goto :goto_1

    .line 278
    .end local v0    # "builder":Ljava/lang/StringBuilder;
    .end local v3    # "stackIndex":I
    :cond_3
    return-void
.end method

.method private logTopBorder(ILjava/lang/String;)V
    .locals 1
    .param p1, "logType"    # I
    .param p2, "tag"    # Ljava/lang/String;

    .prologue
    .line 240
    const-string v0, "\u2554\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550"

    invoke-direct {p0, p1, p2, v0}, Lcom/orhanobut/logger/LoggerPrinter;->logChunk(ILjava/lang/String;Ljava/lang/String;)V

    .line 241
    return-void
.end method


# virtual methods
.method public varargs d(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .param p1, "message"    # Ljava/lang/String;
    .param p2, "args"    # [Ljava/lang/Object;

    .prologue
    .line 109
    const/4 v0, 0x3

    invoke-direct {p0, v0, p1, p2}, Lcom/orhanobut/logger/LoggerPrinter;->log(ILjava/lang/String;[Ljava/lang/Object;)V

    .line 110
    return-void
.end method

.method public varargs e(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .param p1, "message"    # Ljava/lang/String;
    .param p2, "args"    # [Ljava/lang/Object;

    .prologue
    .line 114
    const/4 v0, 0x0

    invoke-virtual {p0, v0, p1, p2}, Lcom/orhanobut/logger/LoggerPrinter;->e(Ljava/lang/Throwable;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 115
    return-void
.end method

.method public varargs e(Ljava/lang/Throwable;Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 2
    .param p1, "throwable"    # Ljava/lang/Throwable;
    .param p2, "message"    # Ljava/lang/String;
    .param p3, "args"    # [Ljava/lang/Object;

    .prologue
    .line 119
    if-eqz p1, :cond_0

    if-eqz p2, :cond_0

    .line 120
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/Throwable;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    .line 122
    :cond_0
    if-eqz p1, :cond_1

    if-nez p2, :cond_1

    .line 123
    invoke-virtual {p1}, Ljava/lang/Throwable;->toString()Ljava/lang/String;

    move-result-object p2

    .line 125
    :cond_1
    if-nez p2, :cond_2

    .line 126
    const-string p2, "No message/exception is set"

    .line 128
    :cond_2
    const/4 v0, 0x6

    invoke-direct {p0, v0, p2, p3}, Lcom/orhanobut/logger/LoggerPrinter;->log(ILjava/lang/String;[Ljava/lang/Object;)V

    .line 129
    return-void
.end method

.method public getSettings()Lcom/orhanobut/logger/Settings;
    .locals 1

    .prologue
    .line 95
    sget-object v0, Lcom/orhanobut/logger/LoggerPrinter;->settings:Lcom/orhanobut/logger/Settings;

    return-object v0
.end method

.method public varargs i(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .param p1, "message"    # Ljava/lang/String;
    .param p2, "args"    # [Ljava/lang/Object;

    .prologue
    .line 138
    const/4 v0, 0x4

    invoke-direct {p0, v0, p1, p2}, Lcom/orhanobut/logger/LoggerPrinter;->log(ILjava/lang/String;[Ljava/lang/Object;)V

    .line 139
    return-void
.end method

.method public init(Ljava/lang/String;)Lcom/orhanobut/logger/Settings;
    .locals 2
    .param p1, "tag"    # Ljava/lang/String;

    .prologue
    .line 83
    if-nez p1, :cond_0

    .line 84
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "tag may not be null"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 86
    :cond_0
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    .line 87
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "tag may not be empty"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 89
    :cond_1
    sput-object p1, Lcom/orhanobut/logger/LoggerPrinter;->TAG:Ljava/lang/String;

    .line 90
    sget-object v0, Lcom/orhanobut/logger/LoggerPrinter;->settings:Lcom/orhanobut/logger/Settings;

    return-object v0
.end method

.method public json(Ljava/lang/String;)V
    .locals 7
    .param p1, "json"    # Ljava/lang/String;

    .prologue
    const/4 v6, 0x0

    .line 158
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 159
    const-string v4, "Empty/Null json content"

    new-array v5, v6, [Ljava/lang/Object;

    invoke-virtual {p0, v4, v5}, Lcom/orhanobut/logger/LoggerPrinter;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 177
    :cond_0
    :goto_0
    return-void

    .line 163
    :cond_1
    :try_start_0
    const-string v4, "{"

    invoke-virtual {p1, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 164
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 165
    .local v2, "jsonObject":Lorg/json/JSONObject;
    const/4 v4, 0x4

    invoke-virtual {v2, v4}, Lorg/json/JSONObject;->toString(I)Ljava/lang/String;

    move-result-object v3

    .line 166
    .local v3, "message":Ljava/lang/String;
    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {p0, v3, v4}, Lcom/orhanobut/logger/LoggerPrinter;->d(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 174
    .end local v2    # "jsonObject":Lorg/json/JSONObject;
    .end local v3    # "message":Ljava/lang/String;
    :catch_0
    move-exception v0

    .line 175
    .local v0, "e":Lorg/json/JSONException;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0}, Lorg/json/JSONException;->getCause()Ljava/lang/Throwable;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "\n"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    new-array v5, v6, [Ljava/lang/Object;

    invoke-virtual {p0, v4, v5}, Lcom/orhanobut/logger/LoggerPrinter;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_0

    .line 169
    .end local v0    # "e":Lorg/json/JSONException;
    :cond_2
    :try_start_1
    const-string v4, "["

    invoke-virtual {p1, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 170
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1, p1}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    .line 171
    .local v1, "jsonArray":Lorg/json/JSONArray;
    const/4 v4, 0x4

    invoke-virtual {v1, v4}, Lorg/json/JSONArray;->toString(I)Ljava/lang/String;

    move-result-object v3

    .line 172
    .restart local v3    # "message":Ljava/lang/String;
    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {p0, v3, v4}, Lcom/orhanobut/logger/LoggerPrinter;->d(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0
.end method

.method public t(Ljava/lang/String;I)Lcom/orhanobut/logger/Printer;
    .locals 2
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "methodCount"    # I

    .prologue
    .line 100
    if-eqz p1, :cond_0

    .line 101
    sget-object v0, Lcom/orhanobut/logger/LoggerPrinter;->LOCAL_TAG:Ljava/lang/ThreadLocal;

    invoke-virtual {v0, p1}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    .line 103
    :cond_0
    sget-object v0, Lcom/orhanobut/logger/LoggerPrinter;->LOCAL_METHOD_COUNT:Ljava/lang/ThreadLocal;

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    .line 104
    return-object p0
.end method

.method public varargs v(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .param p1, "message"    # Ljava/lang/String;
    .param p2, "args"    # [Ljava/lang/Object;

    .prologue
    .line 143
    const/4 v0, 0x2

    invoke-direct {p0, v0, p1, p2}, Lcom/orhanobut/logger/LoggerPrinter;->log(ILjava/lang/String;[Ljava/lang/Object;)V

    .line 144
    return-void
.end method

.method public varargs w(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .param p1, "message"    # Ljava/lang/String;
    .param p2, "args"    # [Ljava/lang/Object;

    .prologue
    .line 133
    const/4 v0, 0x5

    invoke-direct {p0, v0, p1, p2}, Lcom/orhanobut/logger/LoggerPrinter;->log(ILjava/lang/String;[Ljava/lang/Object;)V

    .line 134
    return-void
.end method

.method public varargs wtf(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .param p1, "message"    # Ljava/lang/String;
    .param p2, "args"    # [Ljava/lang/Object;

    .prologue
    .line 148
    const/4 v0, 0x7

    invoke-direct {p0, v0, p1, p2}, Lcom/orhanobut/logger/LoggerPrinter;->log(ILjava/lang/String;[Ljava/lang/Object;)V

    .line 149
    return-void
.end method

.method public xml(Ljava/lang/String;)V
    .locals 8
    .param p1, "xml"    # Ljava/lang/String;

    .prologue
    const/4 v7, 0x0

    .line 186
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 187
    const-string v4, "Empty/Null xml content"

    new-array v5, v7, [Ljava/lang/Object;

    invoke-virtual {p0, v4, v5}, Lcom/orhanobut/logger/LoggerPrinter;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 201
    :goto_0
    return-void

    .line 191
    :cond_0
    :try_start_0
    new-instance v2, Ljavax/xml/transform/stream/StreamSource;

    new-instance v4, Ljava/io/StringReader;

    invoke-direct {v4, p1}, Ljava/io/StringReader;-><init>(Ljava/lang/String;)V

    invoke-direct {v2, v4}, Ljavax/xml/transform/stream/StreamSource;-><init>(Ljava/io/Reader;)V

    .line 192
    .local v2, "xmlInput":Ljavax/xml/transform/Source;
    new-instance v3, Ljavax/xml/transform/stream/StreamResult;

    new-instance v4, Ljava/io/StringWriter;

    invoke-direct {v4}, Ljava/io/StringWriter;-><init>()V

    invoke-direct {v3, v4}, Ljavax/xml/transform/stream/StreamResult;-><init>(Ljava/io/Writer;)V

    .line 193
    .local v3, "xmlOutput":Ljavax/xml/transform/stream/StreamResult;
    invoke-static {}, Ljavax/xml/transform/TransformerFactory;->newInstance()Ljavax/xml/transform/TransformerFactory;

    move-result-object v4

    invoke-virtual {v4}, Ljavax/xml/transform/TransformerFactory;->newTransformer()Ljavax/xml/transform/Transformer;

    move-result-object v1

    .line 194
    .local v1, "transformer":Ljavax/xml/transform/Transformer;
    const-string v4, "indent"

    const-string v5, "yes"

    invoke-virtual {v1, v4, v5}, Ljavax/xml/transform/Transformer;->setOutputProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 195
    const-string v4, "{http://xml.apache.org/xslt}indent-amount"

    const-string v5, "2"

    invoke-virtual {v1, v4, v5}, Ljavax/xml/transform/Transformer;->setOutputProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 196
    invoke-virtual {v1, v2, v3}, Ljavax/xml/transform/Transformer;->transform(Ljavax/xml/transform/Source;Ljavax/xml/transform/Result;)V

    .line 197
    invoke-virtual {v3}, Ljavax/xml/transform/stream/StreamResult;->getWriter()Ljava/io/Writer;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v4

    const-string v5, ">"

    const-string v6, ">\n"

    invoke-virtual {v4, v5, v6}, Ljava/lang/String;->replaceFirst(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    invoke-virtual {p0, v4, v5}, Lcom/orhanobut/logger/LoggerPrinter;->d(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_0
    .catch Ljavax/xml/transform/TransformerException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 198
    .end local v1    # "transformer":Ljavax/xml/transform/Transformer;
    .end local v2    # "xmlInput":Ljavax/xml/transform/Source;
    .end local v3    # "xmlOutput":Ljavax/xml/transform/stream/StreamResult;
    :catch_0
    move-exception v0

    .line 199
    .local v0, "e":Ljavax/xml/transform/TransformerException;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0}, Ljavax/xml/transform/TransformerException;->getCause()Ljava/lang/Throwable;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "\n"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    new-array v5, v7, [Ljava/lang/Object;

    invoke-virtual {p0, v4, v5}, Lcom/orhanobut/logger/LoggerPrinter;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_0
.end method
