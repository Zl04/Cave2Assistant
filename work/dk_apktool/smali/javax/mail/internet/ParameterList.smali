.class public Ljavax/mail/internet/ParameterList;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ljavax/mail/internet/ParameterList$MultiValue;,
        Ljavax/mail/internet/ParameterList$ParamEnum;,
        Ljavax/mail/internet/ParameterList$ToStringBuffer;,
        Ljavax/mail/internet/ParameterList$Value;
    }
.end annotation


# static fields
.field private static applehack:Z

.field private static decodeParameters:Z

.field private static decodeParametersStrict:Z

.field private static encodeParameters:Z

.field private static final hex:[C


# instance fields
.field private lastName:Ljava/lang/String;

.field private list:Ljava/util/Map;

.field private multisegmentNames:Ljava/util/Set;

.field private slist:Ljava/util/Map;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 129
    sput-boolean v1, Ljavax/mail/internet/ParameterList;->encodeParameters:Z

    .line 130
    sput-boolean v1, Ljavax/mail/internet/ParameterList;->decodeParameters:Z

    .line 131
    sput-boolean v1, Ljavax/mail/internet/ParameterList;->decodeParametersStrict:Z

    .line 132
    sput-boolean v1, Ljavax/mail/internet/ParameterList;->applehack:Z

    .line 136
    :try_start_0
    const-string v2, "mail.mime.encodeparameters"

    invoke-static {v2}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 138
    if-eqz v2, :cond_0

    const-string v3, "true"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    move v2, v0

    :goto_0
    sput-boolean v2, Ljavax/mail/internet/ParameterList;->encodeParameters:Z

    .line 139
    const-string v2, "mail.mime.decodeparameters"

    invoke-static {v2}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 141
    if-eqz v2, :cond_1

    const-string v3, "true"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    move v2, v0

    :goto_1
    sput-boolean v2, Ljavax/mail/internet/ParameterList;->decodeParameters:Z

    .line 142
    const-string v2, "mail.mime.decodeparameters.strict"

    invoke-static {v2}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 144
    if-eqz v2, :cond_2

    const-string v3, "true"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    move v2, v0

    :goto_2
    sput-boolean v2, Ljavax/mail/internet/ParameterList;->decodeParametersStrict:Z

    .line 145
    const-string v2, "mail.mime.applefilenames"

    invoke-static {v2}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 147
    if-eqz v2, :cond_3

    const-string v3, "true"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    :goto_3
    sput-boolean v0, Ljavax/mail/internet/ParameterList;->applehack:Z
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    .line 653
    :goto_4
    const/16 v0, 0x10

    new-array v0, v0, [C

    fill-array-data v0, :array_0

    sput-object v0, Ljavax/mail/internet/ParameterList;->hex:[C

    .line 66
    return-void

    :cond_0
    move v2, v1

    .line 138
    goto :goto_0

    :cond_1
    move v2, v1

    .line 141
    goto :goto_1

    :cond_2
    move v2, v1

    .line 144
    goto :goto_2

    :cond_3
    move v0, v1

    .line 147
    goto :goto_3

    .line 148
    :catch_0
    move-exception v0

    goto :goto_4

    .line 653
    nop

    :array_0
    .array-data 2
        0x30s
        0x31s
        0x32s
        0x33s
        0x34s
        0x35s
        0x36s
        0x37s
        0x38s
        0x39s
        0x41s
        0x42s
        0x43s
        0x44s
        0x45s
        0x46s
    .end array-data
.end method

.method public constructor <init>()V
    .locals 1

    .prologue
    .line 202
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 80
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    iput-object v0, p0, Ljavax/mail/internet/ParameterList;->list:Ljava/util/Map;

    .line 127
    const/4 v0, 0x0

    iput-object v0, p0, Ljavax/mail/internet/ParameterList;->lastName:Ljava/lang/String;

    .line 204
    sget-boolean v0, Ljavax/mail/internet/ParameterList;->decodeParameters:Z

    if-eqz v0, :cond_0

    .line 205
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Ljavax/mail/internet/ParameterList;->multisegmentNames:Ljava/util/Set;

    .line 206
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Ljavax/mail/internet/ParameterList;->slist:Ljava/util/Map;

    .line 208
    :cond_0
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/internet/ParseException;
        }
    .end annotation

    .prologue
    const/4 v6, -0x4

    const/4 v5, -0x1

    .line 221
    invoke-direct {p0}, Ljavax/mail/internet/ParameterList;-><init>()V

    .line 223
    new-instance v1, Ljavax/mail/internet/HeaderTokenizer;

    const-string v0, "()<>@,;:\\\"\t []/?="

    invoke-direct {v1, p1, v0}, Ljavax/mail/internet/HeaderTokenizer;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 225
    :goto_0
    invoke-virtual {v1}, Ljavax/mail/internet/HeaderTokenizer;->next()Ljavax/mail/internet/HeaderTokenizer$Token;

    move-result-object v2

    .line 226
    invoke-virtual {v2}, Ljavax/mail/internet/HeaderTokenizer$Token;->getType()I

    move-result v0

    .line 229
    if-ne v0, v6, :cond_2

    .line 287
    :cond_0
    sget-boolean v0, Ljavax/mail/internet/ParameterList;->decodeParameters:Z

    if-eqz v0, :cond_1

    .line 292
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Ljavax/mail/internet/ParameterList;->combineMultisegmentNames(Z)V

    .line 294
    :cond_1
    return-void

    .line 232
    :cond_2
    int-to-char v3, v0

    const/16 v4, 0x3b

    if-ne v3, v4, :cond_7

    .line 234
    invoke-virtual {v1}, Ljavax/mail/internet/HeaderTokenizer;->next()Ljavax/mail/internet/HeaderTokenizer$Token;

    move-result-object v0

    .line 236
    invoke-virtual {v0}, Ljavax/mail/internet/HeaderTokenizer$Token;->getType()I

    move-result v2

    if-eq v2, v6, :cond_0

    .line 239
    invoke-virtual {v0}, Ljavax/mail/internet/HeaderTokenizer$Token;->getType()I

    move-result v2

    if-eq v2, v5, :cond_3

    .line 240
    new-instance v1, Ljavax/mail/internet/ParseException;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Expected parameter name, got \""

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 241
    invoke-virtual {v0}, Ljavax/mail/internet/HeaderTokenizer$Token;->getValue()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "\""

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 240
    invoke-direct {v1, v0}, Ljavax/mail/internet/ParseException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 242
    :cond_3
    invoke-virtual {v0}, Ljavax/mail/internet/HeaderTokenizer$Token;->getValue()Ljava/lang/String;

    move-result-object v0

    sget-object v2, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {v0, v2}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    .line 245
    invoke-virtual {v1}, Ljavax/mail/internet/HeaderTokenizer;->next()Ljavax/mail/internet/HeaderTokenizer$Token;

    move-result-object v2

    .line 246
    invoke-virtual {v2}, Ljavax/mail/internet/HeaderTokenizer$Token;->getType()I

    move-result v3

    int-to-char v3, v3

    const/16 v4, 0x3d

    if-eq v3, v4, :cond_4

    .line 247
    new-instance v0, Ljavax/mail/internet/ParseException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v3, "Expected \'=\', got \""

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 248
    invoke-virtual {v2}, Ljavax/mail/internet/HeaderTokenizer$Token;->getValue()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 247
    invoke-direct {v0, v1}, Ljavax/mail/internet/ParseException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 251
    :cond_4
    invoke-virtual {v1}, Ljavax/mail/internet/HeaderTokenizer;->next()Ljavax/mail/internet/HeaderTokenizer$Token;

    move-result-object v2

    .line 252
    invoke-virtual {v2}, Ljavax/mail/internet/HeaderTokenizer$Token;->getType()I

    move-result v3

    .line 254
    if-eq v3, v5, :cond_5

    .line 255
    const/4 v4, -0x2

    if-eq v3, v4, :cond_5

    .line 256
    new-instance v0, Ljavax/mail/internet/ParseException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v3, "Expected parameter value, got \""

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 257
    invoke-virtual {v2}, Ljavax/mail/internet/HeaderTokenizer$Token;->getValue()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 256
    invoke-direct {v0, v1}, Ljavax/mail/internet/ParseException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 259
    :cond_5
    invoke-virtual {v2}, Ljavax/mail/internet/HeaderTokenizer$Token;->getValue()Ljava/lang/String;

    move-result-object v2

    .line 260
    iput-object v0, p0, Ljavax/mail/internet/ParameterList;->lastName:Ljava/lang/String;

    .line 261
    sget-boolean v3, Ljavax/mail/internet/ParameterList;->decodeParameters:Z

    if-eqz v3, :cond_6

    .line 262
    invoke-direct {p0, v0, v2}, Ljavax/mail/internet/ParameterList;->putEncodedName(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_0

    .line 264
    :cond_6
    iget-object v3, p0, Ljavax/mail/internet/ParameterList;->list:Ljava/util/Map;

    invoke-interface {v3, v0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto/16 :goto_0

    .line 272
    :cond_7
    sget-boolean v3, Ljavax/mail/internet/ParameterList;->applehack:Z

    if-eqz v3, :cond_9

    if-ne v0, v5, :cond_9

    .line 273
    iget-object v0, p0, Ljavax/mail/internet/ParameterList;->lastName:Ljava/lang/String;

    if-eqz v0, :cond_9

    .line 274
    iget-object v0, p0, Ljavax/mail/internet/ParameterList;->lastName:Ljava/lang/String;

    const-string v3, "name"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_8

    .line 275
    iget-object v0, p0, Ljavax/mail/internet/ParameterList;->lastName:Ljava/lang/String;

    const-string v3, "filename"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_9

    .line 277
    :cond_8
    iget-object v0, p0, Ljavax/mail/internet/ParameterList;->list:Ljava/util/Map;

    iget-object v3, p0, Ljavax/mail/internet/ParameterList;->lastName:Ljava/lang/String;

    invoke-interface {v0, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 278
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v0, " "

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v2}, Ljavax/mail/internet/HeaderTokenizer$Token;->getValue()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 279
    iget-object v2, p0, Ljavax/mail/internet/ParameterList;->list:Ljava/util/Map;

    iget-object v3, p0, Ljavax/mail/internet/ParameterList;->lastName:Ljava/lang/String;

    invoke-interface {v2, v3, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto/16 :goto_0

    .line 281
    :cond_9
    new-instance v0, Ljavax/mail/internet/ParseException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v3, "Expected \';\', got \""

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 282
    invoke-virtual {v2}, Ljavax/mail/internet/HeaderTokenizer$Token;->getValue()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 281
    invoke-direct {v0, v1}, Ljavax/mail/internet/ParseException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method static synthetic access$0(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 649
    invoke-static {p0}, Ljavax/mail/internet/ParameterList;->quote(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private combineMultisegmentNames(Z)V
    .locals 12
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/internet/ParseException;
        }
    .end annotation

    .prologue
    const/4 v3, 0x0

    .line 346
    .line 348
    :try_start_0
    iget-object v0, p0, Ljavax/mail/internet/ParameterList;->multisegmentNames:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v7

    .line 349
    :goto_0
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    if-nez v0, :cond_3

    .line 418
    if-nez p1, :cond_0

    .line 421
    :cond_0
    iget-object v0, p0, Ljavax/mail/internet/ParameterList;->slist:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->size()I

    move-result v0

    if-lez v0, :cond_2

    .line 423
    iget-object v0, p0, Ljavax/mail/internet/ParameterList;->slist:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .line 424
    :cond_1
    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_e

    .line 433
    iget-object v0, p0, Ljavax/mail/internet/ParameterList;->list:Ljava/util/Map;

    iget-object v1, p0, Ljavax/mail/internet/ParameterList;->slist:Ljava/util/Map;

    invoke-interface {v0, v1}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    .line 437
    :cond_2
    iget-object v0, p0, Ljavax/mail/internet/ParameterList;->multisegmentNames:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->clear()V

    .line 438
    iget-object v0, p0, Ljavax/mail/internet/ParameterList;->slist:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->clear()V

    .line 441
    return-void

    .line 350
    :cond_3
    :try_start_1
    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 351
    new-instance v8, Ljava/lang/StringBuffer;

    invoke-direct {v8}, Ljava/lang/StringBuffer;-><init>()V

    .line 352
    new-instance v9, Ljavax/mail/internet/ParameterList$MultiValue;

    const/4 v1, 0x0

    invoke-direct {v9, v1}, Ljavax/mail/internet/ParameterList$MultiValue;-><init>(Ljavax/mail/internet/ParameterList$MultiValue;)V

    .line 359
    const/4 v1, 0x0

    move v6, v1

    move-object v5, v3

    .line 360
    :goto_2
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v2, "*"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    .line 361
    iget-object v1, p0, Ljavax/mail/internet/ParameterList;->slist:Ljava/util/Map;

    invoke-interface {v1, v10}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 362
    if-nez v1, :cond_4

    .line 403
    :goto_3
    if-nez v6, :cond_9

    .line 405
    iget-object v1, p0, Ljavax/mail/internet/ParameterList;->list:Ljava/util/Map;

    invoke-interface {v1, v0}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 412
    :catchall_0
    move-exception v0

    move-object v1, v0

    .line 418
    if-nez p1, :cond_a

    .line 440
    :goto_4
    throw v1

    .line 364
    :cond_4
    :try_start_2
    invoke-virtual {v9, v1}, Ljavax/mail/internet/ParameterList$MultiValue;->add(Ljava/lang/Object;)Z

    .line 366
    instance-of v2, v1, Ljavax/mail/internet/ParameterList$Value;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    if-eqz v2, :cond_8

    .line 368
    :try_start_3
    check-cast v1, Ljavax/mail/internet/ParameterList$Value;

    .line 369
    iget-object v2, v1, Ljavax/mail/internet/ParameterList$Value;->encodedValue:Ljava/lang/String;
    :try_end_3
    .catch Ljava/lang/NumberFormatException; {:try_start_3 .. :try_end_3} :catch_8
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_3 .. :try_end_3} :catch_5
    .catch Ljava/lang/StringIndexOutOfBoundsException; {:try_start_3 .. :try_end_3} :catch_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 371
    if-nez v6, :cond_6

    .line 374
    :try_start_4
    invoke-static {v2}, Ljavax/mail/internet/ParameterList;->decodeValue(Ljava/lang/String;)Ljavax/mail/internet/ParameterList$Value;

    move-result-object v11

    .line 375
    iget-object v4, v11, Ljavax/mail/internet/ParameterList$Value;->charset:Ljava/lang/String;

    iput-object v4, v1, Ljavax/mail/internet/ParameterList$Value;->charset:Ljava/lang/String;
    :try_end_4
    .catch Ljava/lang/NumberFormatException; {:try_start_4 .. :try_end_4} :catch_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_4 .. :try_end_4} :catch_6
    .catch Ljava/lang/StringIndexOutOfBoundsException; {:try_start_4 .. :try_end_4} :catch_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 376
    :try_start_5
    iget-object v5, v11, Ljavax/mail/internet/ParameterList$Value;->value:Ljava/lang/String;

    iput-object v5, v1, Ljavax/mail/internet/ParameterList$Value;->value:Ljava/lang/String;
    :try_end_5
    .catch Ljava/lang/NumberFormatException; {:try_start_5 .. :try_end_5} :catch_7
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_5 .. :try_end_5} :catch_1
    .catch Ljava/lang/StringIndexOutOfBoundsException; {:try_start_5 .. :try_end_5} :catch_2
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    move-object v2, v5

    move-object v5, v4

    .line 400
    :cond_5
    :goto_5
    :try_start_6
    invoke-virtual {v8, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 401
    iget-object v1, p0, Ljavax/mail/internet/ParameterList;->slist:Ljava/util/Map;

    invoke-interface {v1, v10}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    .line 359
    add-int/lit8 v1, v6, 0x1

    move v6, v1

    goto :goto_2

    .line 378
    :cond_6
    if-nez v5, :cond_7

    .line 380
    :try_start_7
    iget-object v1, p0, Ljavax/mail/internet/ParameterList;->multisegmentNames:Ljava/util/Set;

    invoke-interface {v1, v0}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z
    :try_end_7
    .catch Ljava/lang/NumberFormatException; {:try_start_7 .. :try_end_7} :catch_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_7 .. :try_end_7} :catch_6
    .catch Ljava/lang/StringIndexOutOfBoundsException; {:try_start_7 .. :try_end_7} :catch_4
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    goto :goto_3

    .line 385
    :catch_0
    move-exception v1

    move-object v4, v5

    .line 386
    :goto_6
    :try_start_8
    sget-boolean v5, Ljavax/mail/internet/ParameterList;->decodeParametersStrict:Z

    if-eqz v5, :cond_f

    .line 387
    new-instance v0, Ljavax/mail/internet/ParseException;

    invoke-virtual {v1}, Ljava/lang/NumberFormatException;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljavax/mail/internet/ParseException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    .line 383
    :cond_7
    :try_start_9
    invoke-static {v2, v5}, Ljavax/mail/internet/ParameterList;->decodeBytes(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v1, Ljavax/mail/internet/ParameterList$Value;->value:Ljava/lang/String;
    :try_end_9
    .catch Ljava/lang/NumberFormatException; {:try_start_9 .. :try_end_9} :catch_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_9 .. :try_end_9} :catch_6
    .catch Ljava/lang/StringIndexOutOfBoundsException; {:try_start_9 .. :try_end_9} :catch_4
    .catchall {:try_start_9 .. :try_end_9} :catchall_0

    move-object v2, v4

    goto :goto_5

    .line 388
    :catch_1
    move-exception v1

    move-object v5, v4

    .line 389
    :goto_7
    :try_start_a
    sget-boolean v4, Ljavax/mail/internet/ParameterList;->decodeParametersStrict:Z

    if-eqz v4, :cond_5

    .line 390
    new-instance v0, Ljavax/mail/internet/ParseException;

    invoke-virtual {v1}, Ljava/io/UnsupportedEncodingException;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljavax/mail/internet/ParseException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 391
    :catch_2
    move-exception v1

    move-object v5, v4

    .line 392
    :goto_8
    sget-boolean v4, Ljavax/mail/internet/ParameterList;->decodeParametersStrict:Z

    if-eqz v4, :cond_5

    .line 393
    new-instance v0, Ljavax/mail/internet/ParseException;

    invoke-virtual {v1}, Ljava/lang/StringIndexOutOfBoundsException;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljavax/mail/internet/ParseException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 398
    :cond_8
    check-cast v1, Ljava/lang/String;

    move-object v2, v1

    goto :goto_5

    .line 407
    :cond_9
    invoke-virtual {v8}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v9, Ljavax/mail/internet/ParameterList$MultiValue;->value:Ljava/lang/String;

    .line 408
    iget-object v1, p0, Ljavax/mail/internet/ParameterList;->list:Ljava/util/Map;

    invoke-interface {v1, v0, v9}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_0

    goto/16 :goto_0

    .line 421
    :cond_a
    iget-object v0, p0, Ljavax/mail/internet/ParameterList;->slist:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->size()I

    move-result v0

    if-lez v0, :cond_c

    .line 423
    iget-object v0, p0, Ljavax/mail/internet/ParameterList;->slist:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v2

    .line 424
    :cond_b
    :goto_9
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_d

    .line 433
    iget-object v0, p0, Ljavax/mail/internet/ParameterList;->list:Ljava/util/Map;

    iget-object v2, p0, Ljavax/mail/internet/ParameterList;->slist:Ljava/util/Map;

    invoke-interface {v0, v2}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    .line 437
    :cond_c
    iget-object v0, p0, Ljavax/mail/internet/ParameterList;->multisegmentNames:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->clear()V

    .line 438
    iget-object v0, p0, Ljavax/mail/internet/ParameterList;->slist:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->clear()V

    goto/16 :goto_4

    .line 425
    :cond_d
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    .line 426
    instance-of v3, v0, Ljavax/mail/internet/ParameterList$Value;

    if-eqz v3, :cond_b

    .line 427
    check-cast v0, Ljavax/mail/internet/ParameterList$Value;

    .line 428
    iget-object v3, v0, Ljavax/mail/internet/ParameterList$Value;->encodedValue:Ljava/lang/String;

    invoke-static {v3}, Ljavax/mail/internet/ParameterList;->decodeValue(Ljava/lang/String;)Ljavax/mail/internet/ParameterList$Value;

    move-result-object v3

    .line 429
    iget-object v4, v3, Ljavax/mail/internet/ParameterList$Value;->charset:Ljava/lang/String;

    iput-object v4, v0, Ljavax/mail/internet/ParameterList$Value;->charset:Ljava/lang/String;

    .line 430
    iget-object v3, v3, Ljavax/mail/internet/ParameterList$Value;->value:Ljava/lang/String;

    iput-object v3, v0, Ljavax/mail/internet/ParameterList$Value;->value:Ljava/lang/String;

    goto :goto_9

    .line 425
    :cond_e
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    .line 426
    instance-of v2, v0, Ljavax/mail/internet/ParameterList$Value;

    if-eqz v2, :cond_1

    .line 427
    check-cast v0, Ljavax/mail/internet/ParameterList$Value;

    .line 428
    iget-object v2, v0, Ljavax/mail/internet/ParameterList$Value;->encodedValue:Ljava/lang/String;

    invoke-static {v2}, Ljavax/mail/internet/ParameterList;->decodeValue(Ljava/lang/String;)Ljavax/mail/internet/ParameterList$Value;

    move-result-object v2

    .line 429
    iget-object v3, v2, Ljavax/mail/internet/ParameterList$Value;->charset:Ljava/lang/String;

    iput-object v3, v0, Ljavax/mail/internet/ParameterList$Value;->charset:Ljava/lang/String;

    .line 430
    iget-object v2, v2, Ljavax/mail/internet/ParameterList$Value;->value:Ljava/lang/String;

    iput-object v2, v0, Ljavax/mail/internet/ParameterList$Value;->value:Ljava/lang/String;

    goto/16 :goto_1

    .line 391
    :catch_3
    move-exception v1

    move-object v2, v3

    goto :goto_8

    :catch_4
    move-exception v1

    goto/16 :goto_8

    .line 388
    :catch_5
    move-exception v1

    move-object v2, v3

    goto/16 :goto_7

    :catch_6
    move-exception v1

    goto/16 :goto_7

    .line 385
    :catch_7
    move-exception v1

    goto/16 :goto_6

    :catch_8
    move-exception v1

    move-object v2, v3

    move-object v4, v5

    goto/16 :goto_6

    :cond_f
    move-object v5, v4

    goto/16 :goto_5
.end method

.method private static decodeBytes(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/UnsupportedEncodingException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 745
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    new-array v5, v0, [B

    move v0, v1

    move v2, v1

    .line 747
    :goto_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v3

    if-lt v2, v3, :cond_0

    .line 756
    new-instance v2, Ljava/lang/String;

    invoke-static {p1}, Ljavax/mail/internet/MimeUtility;->javaCharset(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v5, v1, v0, v3}, Ljava/lang/String;-><init>([BIILjava/lang/String;)V

    return-object v2

    .line 748
    :cond_0
    invoke-virtual {p0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v3

    .line 749
    const/16 v4, 0x25

    if-ne v3, v4, :cond_1

    .line 750
    add-int/lit8 v3, v2, 0x1

    add-int/lit8 v4, v2, 0x3

    invoke-virtual {p0, v3, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    .line 751
    const/16 v4, 0x10

    invoke-static {v3, v4}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;I)I

    move-result v3

    int-to-char v3, v3

    .line 752
    add-int/lit8 v2, v2, 0x2

    move v4, v2

    .line 754
    :goto_1
    add-int/lit8 v2, v0, 0x1

    int-to-byte v3, v3

    aput-byte v3, v5, v0

    .line 747
    add-int/lit8 v0, v4, 0x1

    move v6, v2

    move v2, v0

    move v0, v6

    goto :goto_0

    :cond_1
    move v4, v2

    goto :goto_1
.end method

.method private static decodeValue(Ljava/lang/String;)Ljavax/mail/internet/ParameterList$Value;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/internet/ParseException;
        }
    .end annotation

    .prologue
    .line 696
    new-instance v0, Ljavax/mail/internet/ParameterList$Value;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljavax/mail/internet/ParameterList$Value;-><init>(Ljavax/mail/internet/ParameterList$Value;)V

    .line 697
    iput-object p0, v0, Ljavax/mail/internet/ParameterList$Value;->encodedValue:Ljava/lang/String;

    .line 698
    iput-object p0, v0, Ljavax/mail/internet/ParameterList$Value;->value:Ljava/lang/String;

    .line 700
    const/16 v1, 0x27

    :try_start_0
    invoke-virtual {p0, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    .line 701
    if-gtz v1, :cond_0

    .line 702
    sget-boolean v1, Ljavax/mail/internet/ParameterList;->decodeParametersStrict:Z

    if-eqz v1, :cond_2

    .line 703
    new-instance v1, Ljavax/mail/internet/ParseException;

    .line 704
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Missing charset in encoded value: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 703
    invoke-direct {v1, v2}, Ljavax/mail/internet/ParseException;-><init>(Ljava/lang/String;)V

    throw v1
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/StringIndexOutOfBoundsException; {:try_start_0 .. :try_end_0} :catch_2

    .line 719
    :catch_0
    move-exception v1

    .line 720
    sget-boolean v2, Ljavax/mail/internet/ParameterList;->decodeParametersStrict:Z

    if-eqz v2, :cond_2

    .line 721
    new-instance v0, Ljavax/mail/internet/ParseException;

    invoke-virtual {v1}, Ljava/lang/NumberFormatException;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljavax/mail/internet/ParseException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 707
    :cond_0
    const/4 v2, 0x0

    :try_start_1
    invoke-virtual {p0, v2, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    .line 708
    const/16 v3, 0x27

    add-int/lit8 v4, v1, 0x1

    invoke-virtual {p0, v3, v4}, Ljava/lang/String;->indexOf(II)I

    move-result v3

    .line 709
    if-gez v3, :cond_1

    .line 710
    sget-boolean v1, Ljavax/mail/internet/ParameterList;->decodeParametersStrict:Z

    if-eqz v1, :cond_2

    .line 711
    new-instance v1, Ljavax/mail/internet/ParseException;

    .line 712
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Missing language in encoded value: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 711
    invoke-direct {v1, v2}, Ljavax/mail/internet/ParseException;-><init>(Ljava/lang/String;)V

    throw v1
    :try_end_1
    .catch Ljava/lang/NumberFormatException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/StringIndexOutOfBoundsException; {:try_start_1 .. :try_end_1} :catch_2

    .line 722
    :catch_1
    move-exception v1

    .line 723
    sget-boolean v2, Ljavax/mail/internet/ParameterList;->decodeParametersStrict:Z

    if-eqz v2, :cond_2

    .line 724
    new-instance v0, Ljavax/mail/internet/ParseException;

    invoke-virtual {v1}, Ljava/io/UnsupportedEncodingException;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljavax/mail/internet/ParseException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 715
    :cond_1
    add-int/lit8 v1, v1, 0x1

    :try_start_2
    invoke-virtual {p0, v1, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    .line 716
    add-int/lit8 v1, v3, 0x1

    invoke-virtual {p0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    .line 717
    iput-object v2, v0, Ljavax/mail/internet/ParameterList$Value;->charset:Ljava/lang/String;

    .line 718
    invoke-static {v1, v2}, Ljavax/mail/internet/ParameterList;->decodeBytes(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Ljavax/mail/internet/ParameterList$Value;->value:Ljava/lang/String;
    :try_end_2
    .catch Ljava/lang/NumberFormatException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/lang/StringIndexOutOfBoundsException; {:try_start_2 .. :try_end_2} :catch_2

    .line 729
    :cond_2
    return-object v0

    .line 725
    :catch_2
    move-exception v1

    .line 726
    sget-boolean v2, Ljavax/mail/internet/ParameterList;->decodeParametersStrict:Z

    if-eqz v2, :cond_2

    .line 727
    new-instance v0, Ljavax/mail/internet/ParseException;

    invoke-virtual {v1}, Ljava/lang/StringIndexOutOfBoundsException;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljavax/mail/internet/ParseException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static encodeValue(Ljava/lang/String;Ljava/lang/String;)Ljavax/mail/internet/ParameterList$Value;
    .locals 9

    .prologue
    const/16 v8, 0x25

    const/4 v1, 0x0

    .line 665
    invoke-static {p0}, Ljavax/mail/internet/MimeUtility;->checkAscii(Ljava/lang/String;)I

    move-result v0

    const/4 v2, 0x1

    if-ne v0, v2, :cond_0

    move-object v0, v1

    .line 689
    :goto_0
    return-object v0

    .line 670
    :cond_0
    :try_start_0
    invoke-static {p1}, Ljavax/mail/internet/MimeUtility;->javaCharset(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 674
    new-instance v3, Ljava/lang/StringBuffer;

    array-length v0, v2

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v4

    add-int/2addr v0, v4

    add-int/lit8 v0, v0, 0x2

    invoke-direct {v3, v0}, Ljava/lang/StringBuffer;-><init>(I)V

    .line 675
    invoke-virtual {v3, p1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v0

    const-string v4, "\'\'"

    invoke-virtual {v0, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 676
    const/4 v0, 0x0

    :goto_1
    array-length v4, v2

    if-lt v0, v4, :cond_1

    .line 685
    new-instance v0, Ljavax/mail/internet/ParameterList$Value;

    invoke-direct {v0, v1}, Ljavax/mail/internet/ParameterList$Value;-><init>(Ljavax/mail/internet/ParameterList$Value;)V

    .line 686
    iput-object p1, v0, Ljavax/mail/internet/ParameterList$Value;->charset:Ljava/lang/String;

    .line 687
    iput-object p0, v0, Ljavax/mail/internet/ParameterList$Value;->value:Ljava/lang/String;

    .line 688
    invoke-virtual {v3}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Ljavax/mail/internet/ParameterList$Value;->encodedValue:Ljava/lang/String;

    goto :goto_0

    .line 671
    :catch_0
    move-exception v0

    move-object v0, v1

    .line 672
    goto :goto_0

    .line 677
    :cond_1
    aget-byte v4, v2, v0

    and-int/lit16 v4, v4, 0xff

    int-to-char v4, v4

    .line 679
    const/16 v5, 0x20

    if-le v4, v5, :cond_2

    const/16 v5, 0x7f

    if-ge v4, v5, :cond_2

    const/16 v5, 0x2a

    if-eq v4, v5, :cond_2

    const/16 v5, 0x27

    if-eq v4, v5, :cond_2

    if-eq v4, v8, :cond_2

    .line 680
    const-string v5, "()<>@,;:\\\"\t []/?="

    invoke-virtual {v5, v4}, Ljava/lang/String;->indexOf(I)I

    move-result v5

    if-ltz v5, :cond_3

    .line 681
    :cond_2
    invoke-virtual {v3, v8}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    move-result-object v5

    sget-object v6, Ljavax/mail/internet/ParameterList;->hex:[C

    shr-int/lit8 v7, v4, 0x4

    aget-char v6, v6, v7

    invoke-virtual {v5, v6}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    move-result-object v5

    sget-object v6, Ljavax/mail/internet/ParameterList;->hex:[C

    and-int/lit8 v4, v4, 0xf

    aget-char v4, v6, v4

    invoke-virtual {v5, v4}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 676
    :goto_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 683
    :cond_3
    invoke-virtual {v3, v4}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    goto :goto_2
.end method

.method private putEncodedName(Ljava/lang/String;Ljava/lang/String;)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/internet/ParseException;
        }
    .end annotation

    .prologue
    const/4 v3, 0x0

    .line 308
    const/16 v0, 0x2a

    invoke-virtual {p1, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    .line 309
    if-gez v0, :cond_0

    .line 311
    iget-object v0, p0, Ljavax/mail/internet/ParameterList;->list:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 335
    :goto_0
    return-void

    .line 312
    :cond_0
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    if-ne v0, v1, :cond_1

    .line 314
    invoke-virtual {p1, v3, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    .line 315
    iget-object v1, p0, Ljavax/mail/internet/ParameterList;->list:Ljava/util/Map;

    invoke-static {p2}, Ljavax/mail/internet/ParameterList;->decodeValue(Ljava/lang/String;)Ljavax/mail/internet/ParameterList$Value;

    move-result-object v2

    invoke-interface {v1, v0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    .line 318
    :cond_1
    invoke-virtual {p1, v3, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    .line 319
    iget-object v1, p0, Ljavax/mail/internet/ParameterList;->multisegmentNames:Ljava/util/Set;

    invoke-interface {v1, v0}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 320
    iget-object v1, p0, Ljavax/mail/internet/ParameterList;->list:Ljava/util/Map;

    const-string v2, ""

    invoke-interface {v1, v0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 323
    const-string v0, "*"

    invoke-virtual {p1, v0}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 325
    new-instance v1, Ljavax/mail/internet/ParameterList$Value;

    const/4 v0, 0x0

    invoke-direct {v1, v0}, Ljavax/mail/internet/ParameterList$Value;-><init>(Ljavax/mail/internet/ParameterList$Value;)V

    move-object v0, v1

    .line 326
    check-cast v0, Ljavax/mail/internet/ParameterList$Value;

    iput-object p2, v0, Ljavax/mail/internet/ParameterList$Value;->encodedValue:Ljava/lang/String;

    move-object v0, v1

    .line 327
    check-cast v0, Ljavax/mail/internet/ParameterList$Value;

    iput-object p2, v0, Ljavax/mail/internet/ParameterList$Value;->value:Ljava/lang/String;

    .line 328
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    invoke-virtual {p1, v3, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p1

    .line 333
    :goto_1
    iget-object v0, p0, Ljavax/mail/internet/ParameterList;->slist:Ljava/util/Map;

    invoke-interface {v0, p1, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    :cond_2
    move-object v1, p2

    .line 331
    goto :goto_1
.end method

.method private static quote(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 650
    const-string v0, "()<>@,;:\\\"\t []/?="

    invoke-static {p0, v0}, Ljavax/mail/internet/MimeUtility;->quote(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public get(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 463
    iget-object v0, p0, Ljavax/mail/internet/ParameterList;->list:Ljava/util/Map;

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    sget-object v2, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {v1, v2}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 464
    instance-of v1, v0, Ljavax/mail/internet/ParameterList$MultiValue;

    if-eqz v1, :cond_0

    .line 465
    check-cast v0, Ljavax/mail/internet/ParameterList$MultiValue;

    iget-object v0, v0, Ljavax/mail/internet/ParameterList$MultiValue;->value:Ljava/lang/String;

    .line 470
    :goto_0
    return-object v0

    .line 466
    :cond_0
    instance-of v1, v0, Ljavax/mail/internet/ParameterList$Value;

    if-eqz v1, :cond_1

    .line 467
    check-cast v0, Ljavax/mail/internet/ParameterList$Value;

    iget-object v0, v0, Ljavax/mail/internet/ParameterList$Value;->value:Ljava/lang/String;

    goto :goto_0

    .line 469
    :cond_1
    check-cast v0, Ljava/lang/String;

    goto :goto_0
.end method

.method public getNames()Ljava/util/Enumeration;
    .locals 2

    .prologue
    .line 552
    new-instance v0, Ljavax/mail/internet/ParameterList$ParamEnum;

    iget-object v1, p0, Ljavax/mail/internet/ParameterList;->list:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    invoke-direct {v0, v1}, Ljavax/mail/internet/ParameterList$ParamEnum;-><init>(Ljava/util/Iterator;)V

    return-object v0
.end method

.method public remove(Ljava/lang/String;)V
    .locals 3

    .prologue
    .line 542
    iget-object v0, p0, Ljavax/mail/internet/ParameterList;->list:Ljava/util/Map;

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    sget-object v2, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {v1, v2}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 543
    return-void
.end method

.method public set(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 483
    if-nez p1, :cond_1

    if-eqz p2, :cond_1

    const-string v0, "DONE"

    invoke-virtual {p2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 490
    sget-boolean v0, Ljavax/mail/internet/ParameterList;->decodeParameters:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Ljavax/mail/internet/ParameterList;->multisegmentNames:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->size()I

    move-result v0

    if-lez v0, :cond_0

    .line 492
    const/4 v0, 0x1

    :try_start_0
    invoke-direct {p0, v0}, Ljavax/mail/internet/ParameterList;->combineMultisegmentNames(Z)V
    :try_end_0
    .catch Ljavax/mail/internet/ParseException; {:try_start_0 .. :try_end_0} :catch_1

    .line 509
    :cond_0
    :goto_0
    return-void

    .line 499
    :cond_1
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    .line 500
    sget-boolean v1, Ljavax/mail/internet/ParameterList;->decodeParameters:Z

    if-eqz v1, :cond_2

    .line 502
    :try_start_1
    invoke-direct {p0, v0, p2}, Ljavax/mail/internet/ParameterList;->putEncodedName(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catch Ljavax/mail/internet/ParseException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .line 503
    :catch_0
    move-exception v1

    .line 505
    iget-object v1, p0, Ljavax/mail/internet/ParameterList;->list:Ljava/util/Map;

    invoke-interface {v1, v0, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    .line 508
    :cond_2
    iget-object v1, p0, Ljavax/mail/internet/ParameterList;->list:Ljava/util/Map;

    invoke-interface {v1, v0, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    .line 493
    :catch_1
    move-exception v0

    goto :goto_0
.end method

.method public set(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 4

    .prologue
    .line 524
    sget-boolean v0, Ljavax/mail/internet/ParameterList;->encodeParameters:Z

    if-eqz v0, :cond_1

    .line 525
    invoke-static {p2, p3}, Ljavax/mail/internet/ParameterList;->encodeValue(Ljava/lang/String;Ljava/lang/String;)Ljavax/mail/internet/ParameterList$Value;

    move-result-object v0

    .line 527
    if-eqz v0, :cond_0

    .line 528
    iget-object v1, p0, Ljavax/mail/internet/ParameterList;->list:Ljava/util/Map;

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    sget-object v3, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {v2, v3}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 533
    :goto_0
    return-void

    .line 530
    :cond_0
    invoke-virtual {p0, p1, p2}, Ljavax/mail/internet/ParameterList;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 532
    :cond_1
    invoke-virtual {p0, p1, p2}, Ljavax/mail/internet/ParameterList;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public size()I
    .locals 1

    .prologue
    .line 449
    iget-object v0, p0, Ljavax/mail/internet/ParameterList;->list:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->size()I

    move-result v0

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    .prologue
    .line 562
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Ljavax/mail/internet/ParameterList;->toString(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public toString(I)Ljava/lang/String;
    .locals 8

    .prologue
    .line 580
    new-instance v3, Ljavax/mail/internet/ParameterList$ToStringBuffer;

    invoke-direct {v3, p1}, Ljavax/mail/internet/ParameterList$ToStringBuffer;-><init>(I)V

    .line 581
    iget-object v0, p0, Ljavax/mail/internet/ParameterList;->list:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v4

    .line 583
    :cond_0
    :goto_0
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_1

    .line 601
    invoke-virtual {v3}, Ljavax/mail/internet/ParameterList$ToStringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 584
    :cond_1
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 585
    iget-object v1, p0, Ljavax/mail/internet/ParameterList;->list:Ljava/util/Map;

    invoke-interface {v1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 586
    instance-of v2, v1, Ljavax/mail/internet/ParameterList$MultiValue;

    if-eqz v2, :cond_3

    .line 587
    check-cast v1, Ljavax/mail/internet/ParameterList$MultiValue;

    .line 588
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v0, "*"

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 589
    const/4 v0, 0x0

    move v2, v0

    :goto_1
    invoke-virtual {v1}, Ljavax/mail/internet/ParameterList$MultiValue;->size()I

    move-result v0

    if-ge v2, v0, :cond_0

    .line 590
    invoke-virtual {v1, v2}, Ljavax/mail/internet/ParameterList$MultiValue;->get(I)Ljava/lang/Object;

    move-result-object v0

    .line 591
    instance-of v6, v0, Ljavax/mail/internet/ParameterList$Value;

    if-eqz v6, :cond_2

    .line 592
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-static {v5}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "*"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    check-cast v0, Ljavax/mail/internet/ParameterList$Value;

    iget-object v0, v0, Ljavax/mail/internet/ParameterList$Value;->encodedValue:Ljava/lang/String;

    invoke-virtual {v3, v6, v0}, Ljavax/mail/internet/ParameterList$ToStringBuffer;->addNV(Ljava/lang/String;Ljava/lang/String;)V

    .line 589
    :goto_2
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_1

    .line 594
    :cond_2
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-static {v5}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v3, v6, v0}, Ljavax/mail/internet/ParameterList$ToStringBuffer;->addNV(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_2

    .line 596
    :cond_3
    instance-of v2, v1, Ljavax/mail/internet/ParameterList$Value;

    if-eqz v2, :cond_4

    .line 597
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v0, "*"

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    check-cast v1, Ljavax/mail/internet/ParameterList$Value;

    iget-object v1, v1, Ljavax/mail/internet/ParameterList$Value;->encodedValue:Ljava/lang/String;

    invoke-virtual {v3, v0, v1}, Ljavax/mail/internet/ParameterList$ToStringBuffer;->addNV(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_0

    .line 599
    :cond_4
    check-cast v1, Ljava/lang/String;

    invoke-virtual {v3, v0, v1}, Ljavax/mail/internet/ParameterList$ToStringBuffer;->addNV(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_0
.end method
