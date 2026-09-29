.class public Lorg/apache/harmony/awt/internal/nls/Messages;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static bundle:Ljava/util/ResourceBundle;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 50
    const/4 v0, 0x0

    sput-object v0, Lorg/apache/harmony/awt/internal/nls/Messages;->bundle:Ljava/util/ResourceBundle;

    .line 235
    :try_start_0
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v0

    .line 236
    const-string v1, "org.apache.harmony.awt.internal.nls.messages"

    .line 235
    invoke-static {v0, v1}, Lorg/apache/harmony/awt/internal/nls/Messages;->setLocale(Ljava/util/Locale;Ljava/lang/String;)Ljava/util/ResourceBundle;

    move-result-object v0

    sput-object v0, Lorg/apache/harmony/awt/internal/nls/Messages;->bundle:Ljava/util/ResourceBundle;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 47
    :goto_0
    return-void

    .line 237
    :catch_0
    move-exception v0

    .line 238
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    goto :goto_0
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 47
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 9

    .prologue
    const/16 v7, 0x7b

    const/4 v1, 0x0

    .line 162
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    .line 163
    array-length v3, p1

    mul-int/lit8 v3, v3, 0x14

    add-int/2addr v0, v3

    .line 162
    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 164
    array-length v0, p1

    new-array v3, v0, [Ljava/lang/String;

    move v0, v1

    .line 165
    :goto_0
    array-length v4, p1

    if-lt v0, v4, :cond_1

    .line 172
    invoke-virtual {p0, v7, v1}, Ljava/lang/String;->indexOf(II)I

    move-result v0

    :goto_1
    if-gez v0, :cond_3

    .line 205
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-ge v1, v0, :cond_0

    .line 206
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    invoke-virtual {p0, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 207
    :cond_0
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 166
    :cond_1
    aget-object v4, p1, v0

    if-nez v4, :cond_2

    .line 167
    const-string v4, "<null>"

    aput-object v4, v3, v0

    .line 165
    :goto_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 169
    :cond_2
    aget-object v4, p1, v0

    invoke-virtual {v4}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v4

    aput-object v4, v3, v0

    goto :goto_2

    .line 174
    :cond_3
    if-eqz v0, :cond_5

    add-int/lit8 v4, v0, -0x1

    invoke-virtual {p0, v4}, Ljava/lang/String;->charAt(I)C

    move-result v4

    const/16 v5, 0x5c

    if-ne v4, v5, :cond_5

    .line 176
    const/4 v4, 0x1

    if-eq v0, v4, :cond_4

    .line 177
    add-int/lit8 v4, v0, -0x1

    invoke-virtual {p0, v1, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 178
    :cond_4
    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 179
    add-int/lit8 v0, v0, 0x1

    .line 172
    :goto_3
    invoke-virtual {p0, v7, v0}, Ljava/lang/String;->indexOf(II)I

    move-result v1

    move v8, v1

    move v1, v0

    move v0, v8

    goto :goto_1

    .line 182
    :cond_5
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v4

    add-int/lit8 v4, v4, -0x3

    if-le v0, v4, :cond_6

    .line 184
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    invoke-virtual {p0, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 185
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    goto :goto_3

    .line 187
    :cond_6
    add-int/lit8 v4, v0, 0x1

    invoke-virtual {p0, v4}, Ljava/lang/String;->charAt(I)C

    move-result v4

    .line 188
    const/16 v5, 0xa

    .line 187
    invoke-static {v4, v5}, Ljava/lang/Character;->digit(CI)I

    move-result v4

    int-to-byte v4, v4

    .line 189
    if-ltz v4, :cond_7

    add-int/lit8 v5, v0, 0x2

    invoke-virtual {p0, v5}, Ljava/lang/String;->charAt(I)C

    move-result v5

    const/16 v6, 0x7d

    if-eq v5, v6, :cond_8

    .line 191
    :cond_7
    add-int/lit8 v4, v0, 0x1

    invoke-virtual {p0, v1, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 192
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 195
    :cond_8
    invoke-virtual {p0, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 196
    array-length v1, v3

    if-lt v4, v1, :cond_9

    .line 197
    const-string v1, "<missing argument>"

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 200
    :goto_4
    add-int/lit8 v0, v0, 0x3

    goto :goto_3

    .line 199
    :cond_9
    aget-object v1, v3, v4

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_4
.end method

.method public static getString(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 60
    sget-object v0, Lorg/apache/harmony/awt/internal/nls/Messages;->bundle:Ljava/util/ResourceBundle;

    if-nez v0, :cond_0

    .line 65
    :goto_0
    return-object p0

    .line 63
    :cond_0
    :try_start_0
    sget-object v0, Lorg/apache/harmony/awt/internal/nls/Messages;->bundle:Ljava/util/ResourceBundle;

    invoke-virtual {v0, p0}, Ljava/util/ResourceBundle;->getString(Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/util/MissingResourceException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object p0

    goto :goto_0

    .line 64
    :catch_0
    move-exception v0

    .line 65
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Missing message: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    goto :goto_0
.end method

.method public static getString(Ljava/lang/String;C)Ljava/lang/String;
    .locals 3

    .prologue
    .line 105
    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/Object;

    const/4 v1, 0x0

    invoke-static {p1}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v2

    aput-object v2, v0, v1

    invoke-static {p0, v0}, Lorg/apache/harmony/awt/internal/nls/Messages;->getString(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getString(Ljava/lang/String;I)Ljava/lang/String;
    .locals 3

    .prologue
    .line 92
    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/Object;

    const/4 v1, 0x0

    invoke-static {p1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v2

    aput-object v2, v0, v1

    invoke-static {p0, v0}, Lorg/apache/harmony/awt/internal/nls/Messages;->getString(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getString(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 79
    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/Object;

    const/4 v1, 0x0

    aput-object p1, v0, v1

    invoke-static {p0, v0}, Lorg/apache/harmony/awt/internal/nls/Messages;->getString(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getString(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 120
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/Object;

    const/4 v1, 0x0

    aput-object p1, v0, v1

    const/4 v1, 0x1

    aput-object p2, v0, v1

    invoke-static {p0, v0}, Lorg/apache/harmony/awt/internal/nls/Messages;->getString(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getString(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 133
    .line 135
    sget-object v0, Lorg/apache/harmony/awt/internal/nls/Messages;->bundle:Ljava/util/ResourceBundle;

    if-eqz v0, :cond_0

    .line 137
    :try_start_0
    sget-object v0, Lorg/apache/harmony/awt/internal/nls/Messages;->bundle:Ljava/util/ResourceBundle;

    invoke-virtual {v0, p0}, Ljava/util/ResourceBundle;->getString(Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/util/MissingResourceException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object p0

    .line 142
    :cond_0
    :goto_0
    invoke-static {p0, p1}, Lorg/apache/harmony/awt/internal/nls/Messages;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 138
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public static setLocale(Ljava/util/Locale;Ljava/lang/String;)Ljava/util/ResourceBundle;
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 219
    const/4 v0, 0x0

    .line 221
    :try_start_0
    new-instance v2, Lorg/apache/harmony/awt/internal/nls/Messages$1;

    invoke-direct {v2, p1, p0, v0}, Lorg/apache/harmony/awt/internal/nls/Messages$1;-><init>(Ljava/lang/String;Ljava/util/Locale;Ljava/lang/ClassLoader;)V

    invoke-static {v2}, Ljava/security/AccessController;->doPrivileged(Ljava/security/PrivilegedAction;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/ResourceBundle;
    :try_end_0
    .catch Ljava/util/MissingResourceException; {:try_start_0 .. :try_end_0} :catch_0

    .line 229
    :goto_0
    return-object v0

    .line 227
    :catch_0
    move-exception v0

    move-object v0, v1

    .line 229
    goto :goto_0
.end method
