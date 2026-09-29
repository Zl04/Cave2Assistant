.class public Lcom/lidroid/xutils/util/LogUtils;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lidroid/xutils/util/LogUtils$CustomLogger;
    }
.end annotation


# static fields
.field public static allowD:Z

.field public static allowE:Z

.field public static allowI:Z

.field public static allowV:Z

.field public static allowW:Z

.field public static allowWtf:Z

.field public static customLogger:Lcom/lidroid/xutils/util/LogUtils$CustomLogger;

.field public static customTagPrefix:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const/4 v1, 0x1

    .line 32
    const-string v0, ""

    sput-object v0, Lcom/lidroid/xutils/util/LogUtils;->customTagPrefix:Ljava/lang/String;

    .line 37
    sput-boolean v1, Lcom/lidroid/xutils/util/LogUtils;->allowD:Z

    .line 38
    sput-boolean v1, Lcom/lidroid/xutils/util/LogUtils;->allowE:Z

    .line 39
    sput-boolean v1, Lcom/lidroid/xutils/util/LogUtils;->allowI:Z

    .line 40
    sput-boolean v1, Lcom/lidroid/xutils/util/LogUtils;->allowV:Z

    .line 41
    sput-boolean v1, Lcom/lidroid/xutils/util/LogUtils;->allowW:Z

    .line 42
    sput-boolean v1, Lcom/lidroid/xutils/util/LogUtils;->allowWtf:Z

    .line 53
    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 34
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 35
    return-void
.end method

.method public static d(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 86
    sget-boolean v0, Lcom/lidroid/xutils/util/LogUtils;->allowD:Z

    if-nez v0, :cond_0

    .line 95
    :goto_0
    return-void

    .line 87
    :cond_0
    invoke-static {}, Lcom/lidroid/xutils/util/OtherUtils;->getCallerStackTraceElement()Ljava/lang/StackTraceElement;

    move-result-object v0

    .line 88
    invoke-static {v0}, Lcom/lidroid/xutils/util/LogUtils;->generateTag(Ljava/lang/StackTraceElement;)Ljava/lang/String;

    move-result-object v0

    .line 90
    sget-object v1, Lcom/lidroid/xutils/util/LogUtils;->customLogger:Lcom/lidroid/xutils/util/LogUtils$CustomLogger;

    if-eqz v1, :cond_1

    .line 91
    sget-object v1, Lcom/lidroid/xutils/util/LogUtils;->customLogger:Lcom/lidroid/xutils/util/LogUtils$CustomLogger;

    invoke-interface {v1, v0, p0}, Lcom/lidroid/xutils/util/LogUtils$CustomLogger;->d(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 93
    :cond_1
    invoke-static {v0, p0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static d(Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 2

    .prologue
    .line 98
    sget-boolean v0, Lcom/lidroid/xutils/util/LogUtils;->allowD:Z

    if-nez v0, :cond_0

    .line 107
    :goto_0
    return-void

    .line 99
    :cond_0
    invoke-static {}, Lcom/lidroid/xutils/util/OtherUtils;->getCallerStackTraceElement()Ljava/lang/StackTraceElement;

    move-result-object v0

    .line 100
    invoke-static {v0}, Lcom/lidroid/xutils/util/LogUtils;->generateTag(Ljava/lang/StackTraceElement;)Ljava/lang/String;

    move-result-object v0

    .line 102
    sget-object v1, Lcom/lidroid/xutils/util/LogUtils;->customLogger:Lcom/lidroid/xutils/util/LogUtils$CustomLogger;

    if-eqz v1, :cond_1

    .line 103
    sget-object v1, Lcom/lidroid/xutils/util/LogUtils;->customLogger:Lcom/lidroid/xutils/util/LogUtils$CustomLogger;

    invoke-interface {v1, v0, p0, p1}, Lcom/lidroid/xutils/util/LogUtils$CustomLogger;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0

    .line 105
    :cond_1
    invoke-static {v0, p0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0
.end method

.method public static e(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 110
    sget-boolean v0, Lcom/lidroid/xutils/util/LogUtils;->allowE:Z

    if-nez v0, :cond_0

    .line 119
    :goto_0
    return-void

    .line 111
    :cond_0
    invoke-static {}, Lcom/lidroid/xutils/util/OtherUtils;->getCallerStackTraceElement()Ljava/lang/StackTraceElement;

    move-result-object v0

    .line 112
    invoke-static {v0}, Lcom/lidroid/xutils/util/LogUtils;->generateTag(Ljava/lang/StackTraceElement;)Ljava/lang/String;

    move-result-object v0

    .line 114
    sget-object v1, Lcom/lidroid/xutils/util/LogUtils;->customLogger:Lcom/lidroid/xutils/util/LogUtils$CustomLogger;

    if-eqz v1, :cond_1

    .line 115
    sget-object v1, Lcom/lidroid/xutils/util/LogUtils;->customLogger:Lcom/lidroid/xutils/util/LogUtils$CustomLogger;

    invoke-interface {v1, v0, p0}, Lcom/lidroid/xutils/util/LogUtils$CustomLogger;->e(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 117
    :cond_1
    invoke-static {v0, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static e(Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 2

    .prologue
    .line 122
    sget-boolean v0, Lcom/lidroid/xutils/util/LogUtils;->allowE:Z

    if-nez v0, :cond_0

    .line 131
    :goto_0
    return-void

    .line 123
    :cond_0
    invoke-static {}, Lcom/lidroid/xutils/util/OtherUtils;->getCallerStackTraceElement()Ljava/lang/StackTraceElement;

    move-result-object v0

    .line 124
    invoke-static {v0}, Lcom/lidroid/xutils/util/LogUtils;->generateTag(Ljava/lang/StackTraceElement;)Ljava/lang/String;

    move-result-object v0

    .line 126
    sget-object v1, Lcom/lidroid/xutils/util/LogUtils;->customLogger:Lcom/lidroid/xutils/util/LogUtils$CustomLogger;

    if-eqz v1, :cond_1

    .line 127
    sget-object v1, Lcom/lidroid/xutils/util/LogUtils;->customLogger:Lcom/lidroid/xutils/util/LogUtils$CustomLogger;

    invoke-interface {v1, v0, p0, p1}, Lcom/lidroid/xutils/util/LogUtils$CustomLogger;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0

    .line 129
    :cond_1
    invoke-static {v0, p0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0
.end method

.method private static generateTag(Ljava/lang/StackTraceElement;)Ljava/lang/String;
    .locals 4

    .prologue
    .line 45
    const-string v0, "%s.%s(L:%d)"

    .line 46
    invoke-virtual {p0}, Ljava/lang/StackTraceElement;->getClassName()Ljava/lang/String;

    move-result-object v1

    .line 47
    const-string v2, "."

    invoke-virtual {v1, v2}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v2

    add-int/lit8 v2, v2, 0x1

    invoke-virtual {v1, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    .line 48
    const/4 v2, 0x3

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object v1, v2, v3

    const/4 v1, 0x1

    invoke-virtual {p0}, Ljava/lang/StackTraceElement;->getMethodName()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v1

    const/4 v1, 0x2

    invoke-virtual {p0}, Ljava/lang/StackTraceElement;->getLineNumber()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v2, v1

    invoke-static {v0, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 49
    sget-object v1, Lcom/lidroid/xutils/util/LogUtils;->customTagPrefix:Ljava/lang/String;

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 50
    :goto_0
    return-object v0

    .line 49
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    sget-object v2, Lcom/lidroid/xutils/util/LogUtils;->customTagPrefix:Ljava/lang/String;

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v2, ":"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public static i(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 134
    sget-boolean v0, Lcom/lidroid/xutils/util/LogUtils;->allowI:Z

    if-nez v0, :cond_0

    .line 143
    :goto_0
    return-void

    .line 135
    :cond_0
    invoke-static {}, Lcom/lidroid/xutils/util/OtherUtils;->getCallerStackTraceElement()Ljava/lang/StackTraceElement;

    move-result-object v0

    .line 136
    invoke-static {v0}, Lcom/lidroid/xutils/util/LogUtils;->generateTag(Ljava/lang/StackTraceElement;)Ljava/lang/String;

    move-result-object v0

    .line 138
    sget-object v1, Lcom/lidroid/xutils/util/LogUtils;->customLogger:Lcom/lidroid/xutils/util/LogUtils$CustomLogger;

    if-eqz v1, :cond_1

    .line 139
    sget-object v1, Lcom/lidroid/xutils/util/LogUtils;->customLogger:Lcom/lidroid/xutils/util/LogUtils$CustomLogger;

    invoke-interface {v1, v0, p0}, Lcom/lidroid/xutils/util/LogUtils$CustomLogger;->i(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 141
    :cond_1
    invoke-static {v0, p0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static i(Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 2

    .prologue
    .line 146
    sget-boolean v0, Lcom/lidroid/xutils/util/LogUtils;->allowI:Z

    if-nez v0, :cond_0

    .line 155
    :goto_0
    return-void

    .line 147
    :cond_0
    invoke-static {}, Lcom/lidroid/xutils/util/OtherUtils;->getCallerStackTraceElement()Ljava/lang/StackTraceElement;

    move-result-object v0

    .line 148
    invoke-static {v0}, Lcom/lidroid/xutils/util/LogUtils;->generateTag(Ljava/lang/StackTraceElement;)Ljava/lang/String;

    move-result-object v0

    .line 150
    sget-object v1, Lcom/lidroid/xutils/util/LogUtils;->customLogger:Lcom/lidroid/xutils/util/LogUtils$CustomLogger;

    if-eqz v1, :cond_1

    .line 151
    sget-object v1, Lcom/lidroid/xutils/util/LogUtils;->customLogger:Lcom/lidroid/xutils/util/LogUtils$CustomLogger;

    invoke-interface {v1, v0, p0, p1}, Lcom/lidroid/xutils/util/LogUtils$CustomLogger;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0

    .line 153
    :cond_1
    invoke-static {v0, p0, p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0
.end method

.method public static v(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 158
    sget-boolean v0, Lcom/lidroid/xutils/util/LogUtils;->allowV:Z

    if-nez v0, :cond_0

    .line 167
    :goto_0
    return-void

    .line 159
    :cond_0
    invoke-static {}, Lcom/lidroid/xutils/util/OtherUtils;->getCallerStackTraceElement()Ljava/lang/StackTraceElement;

    move-result-object v0

    .line 160
    invoke-static {v0}, Lcom/lidroid/xutils/util/LogUtils;->generateTag(Ljava/lang/StackTraceElement;)Ljava/lang/String;

    move-result-object v0

    .line 162
    sget-object v1, Lcom/lidroid/xutils/util/LogUtils;->customLogger:Lcom/lidroid/xutils/util/LogUtils$CustomLogger;

    if-eqz v1, :cond_1

    .line 163
    sget-object v1, Lcom/lidroid/xutils/util/LogUtils;->customLogger:Lcom/lidroid/xutils/util/LogUtils$CustomLogger;

    invoke-interface {v1, v0, p0}, Lcom/lidroid/xutils/util/LogUtils$CustomLogger;->v(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 165
    :cond_1
    invoke-static {v0, p0}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static v(Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 2

    .prologue
    .line 170
    sget-boolean v0, Lcom/lidroid/xutils/util/LogUtils;->allowV:Z

    if-nez v0, :cond_0

    .line 179
    :goto_0
    return-void

    .line 171
    :cond_0
    invoke-static {}, Lcom/lidroid/xutils/util/OtherUtils;->getCallerStackTraceElement()Ljava/lang/StackTraceElement;

    move-result-object v0

    .line 172
    invoke-static {v0}, Lcom/lidroid/xutils/util/LogUtils;->generateTag(Ljava/lang/StackTraceElement;)Ljava/lang/String;

    move-result-object v0

    .line 174
    sget-object v1, Lcom/lidroid/xutils/util/LogUtils;->customLogger:Lcom/lidroid/xutils/util/LogUtils$CustomLogger;

    if-eqz v1, :cond_1

    .line 175
    sget-object v1, Lcom/lidroid/xutils/util/LogUtils;->customLogger:Lcom/lidroid/xutils/util/LogUtils$CustomLogger;

    invoke-interface {v1, v0, p0, p1}, Lcom/lidroid/xutils/util/LogUtils$CustomLogger;->v(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0

    .line 177
    :cond_1
    invoke-static {v0, p0, p1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0
.end method

.method public static w(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 182
    sget-boolean v0, Lcom/lidroid/xutils/util/LogUtils;->allowW:Z

    if-nez v0, :cond_0

    .line 191
    :goto_0
    return-void

    .line 183
    :cond_0
    invoke-static {}, Lcom/lidroid/xutils/util/OtherUtils;->getCallerStackTraceElement()Ljava/lang/StackTraceElement;

    move-result-object v0

    .line 184
    invoke-static {v0}, Lcom/lidroid/xutils/util/LogUtils;->generateTag(Ljava/lang/StackTraceElement;)Ljava/lang/String;

    move-result-object v0

    .line 186
    sget-object v1, Lcom/lidroid/xutils/util/LogUtils;->customLogger:Lcom/lidroid/xutils/util/LogUtils$CustomLogger;

    if-eqz v1, :cond_1

    .line 187
    sget-object v1, Lcom/lidroid/xutils/util/LogUtils;->customLogger:Lcom/lidroid/xutils/util/LogUtils$CustomLogger;

    invoke-interface {v1, v0, p0}, Lcom/lidroid/xutils/util/LogUtils$CustomLogger;->w(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 189
    :cond_1
    invoke-static {v0, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static w(Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 2

    .prologue
    .line 194
    sget-boolean v0, Lcom/lidroid/xutils/util/LogUtils;->allowW:Z

    if-nez v0, :cond_0

    .line 203
    :goto_0
    return-void

    .line 195
    :cond_0
    invoke-static {}, Lcom/lidroid/xutils/util/OtherUtils;->getCallerStackTraceElement()Ljava/lang/StackTraceElement;

    move-result-object v0

    .line 196
    invoke-static {v0}, Lcom/lidroid/xutils/util/LogUtils;->generateTag(Ljava/lang/StackTraceElement;)Ljava/lang/String;

    move-result-object v0

    .line 198
    sget-object v1, Lcom/lidroid/xutils/util/LogUtils;->customLogger:Lcom/lidroid/xutils/util/LogUtils$CustomLogger;

    if-eqz v1, :cond_1

    .line 199
    sget-object v1, Lcom/lidroid/xutils/util/LogUtils;->customLogger:Lcom/lidroid/xutils/util/LogUtils$CustomLogger;

    invoke-interface {v1, v0, p0, p1}, Lcom/lidroid/xutils/util/LogUtils$CustomLogger;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0

    .line 201
    :cond_1
    invoke-static {v0, p0, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0
.end method

.method public static w(Ljava/lang/Throwable;)V
    .locals 2

    .prologue
    .line 206
    sget-boolean v0, Lcom/lidroid/xutils/util/LogUtils;->allowW:Z

    if-nez v0, :cond_0

    .line 215
    :goto_0
    return-void

    .line 207
    :cond_0
    invoke-static {}, Lcom/lidroid/xutils/util/OtherUtils;->getCallerStackTraceElement()Ljava/lang/StackTraceElement;

    move-result-object v0

    .line 208
    invoke-static {v0}, Lcom/lidroid/xutils/util/LogUtils;->generateTag(Ljava/lang/StackTraceElement;)Ljava/lang/String;

    move-result-object v0

    .line 210
    sget-object v1, Lcom/lidroid/xutils/util/LogUtils;->customLogger:Lcom/lidroid/xutils/util/LogUtils$CustomLogger;

    if-eqz v1, :cond_1

    .line 211
    sget-object v1, Lcom/lidroid/xutils/util/LogUtils;->customLogger:Lcom/lidroid/xutils/util/LogUtils$CustomLogger;

    invoke-interface {v1, v0, p0}, Lcom/lidroid/xutils/util/LogUtils$CustomLogger;->w(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0

    .line 213
    :cond_1
    invoke-static {v0, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0
.end method

.method public static wtf(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 219
    sget-boolean v0, Lcom/lidroid/xutils/util/LogUtils;->allowWtf:Z

    if-nez v0, :cond_0

    .line 228
    :goto_0
    return-void

    .line 220
    :cond_0
    invoke-static {}, Lcom/lidroid/xutils/util/OtherUtils;->getCallerStackTraceElement()Ljava/lang/StackTraceElement;

    move-result-object v0

    .line 221
    invoke-static {v0}, Lcom/lidroid/xutils/util/LogUtils;->generateTag(Ljava/lang/StackTraceElement;)Ljava/lang/String;

    move-result-object v0

    .line 223
    sget-object v1, Lcom/lidroid/xutils/util/LogUtils;->customLogger:Lcom/lidroid/xutils/util/LogUtils$CustomLogger;

    if-eqz v1, :cond_1

    .line 224
    sget-object v1, Lcom/lidroid/xutils/util/LogUtils;->customLogger:Lcom/lidroid/xutils/util/LogUtils$CustomLogger;

    invoke-interface {v1, v0, p0}, Lcom/lidroid/xutils/util/LogUtils$CustomLogger;->wtf(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 226
    :cond_1
    invoke-static {v0, p0}, Landroid/util/Log;->wtf(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static wtf(Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 2

    .prologue
    .line 231
    sget-boolean v0, Lcom/lidroid/xutils/util/LogUtils;->allowWtf:Z

    if-nez v0, :cond_0

    .line 240
    :goto_0
    return-void

    .line 232
    :cond_0
    invoke-static {}, Lcom/lidroid/xutils/util/OtherUtils;->getCallerStackTraceElement()Ljava/lang/StackTraceElement;

    move-result-object v0

    .line 233
    invoke-static {v0}, Lcom/lidroid/xutils/util/LogUtils;->generateTag(Ljava/lang/StackTraceElement;)Ljava/lang/String;

    move-result-object v0

    .line 235
    sget-object v1, Lcom/lidroid/xutils/util/LogUtils;->customLogger:Lcom/lidroid/xutils/util/LogUtils$CustomLogger;

    if-eqz v1, :cond_1

    .line 236
    sget-object v1, Lcom/lidroid/xutils/util/LogUtils;->customLogger:Lcom/lidroid/xutils/util/LogUtils$CustomLogger;

    invoke-interface {v1, v0, p0, p1}, Lcom/lidroid/xutils/util/LogUtils$CustomLogger;->wtf(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0

    .line 238
    :cond_1
    invoke-static {v0, p0, p1}, Landroid/util/Log;->wtf(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0
.end method

.method public static wtf(Ljava/lang/Throwable;)V
    .locals 2

    .prologue
    .line 243
    sget-boolean v0, Lcom/lidroid/xutils/util/LogUtils;->allowWtf:Z

    if-nez v0, :cond_0

    .line 252
    :goto_0
    return-void

    .line 244
    :cond_0
    invoke-static {}, Lcom/lidroid/xutils/util/OtherUtils;->getCallerStackTraceElement()Ljava/lang/StackTraceElement;

    move-result-object v0

    .line 245
    invoke-static {v0}, Lcom/lidroid/xutils/util/LogUtils;->generateTag(Ljava/lang/StackTraceElement;)Ljava/lang/String;

    move-result-object v0

    .line 247
    sget-object v1, Lcom/lidroid/xutils/util/LogUtils;->customLogger:Lcom/lidroid/xutils/util/LogUtils$CustomLogger;

    if-eqz v1, :cond_1

    .line 248
    sget-object v1, Lcom/lidroid/xutils/util/LogUtils;->customLogger:Lcom/lidroid/xutils/util/LogUtils$CustomLogger;

    invoke-interface {v1, v0, p0}, Lcom/lidroid/xutils/util/LogUtils$CustomLogger;->wtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0

    .line 250
    :cond_1
    invoke-static {v0, p0}, Landroid/util/Log;->wtf(Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0
.end method
