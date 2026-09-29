.class public Ljavax/activation/MimeTypeParameterList;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static final TSPECIALS:Ljava/lang/String; = "()<>@,;:/[]?=\\\""


# instance fields
.field private parameters:Ljava/util/Hashtable;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 66
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 67
    new-instance v0, Ljava/util/Hashtable;

    invoke-direct {v0}, Ljava/util/Hashtable;-><init>()V

    iput-object v0, p0, Ljavax/activation/MimeTypeParameterList;->parameters:Ljava/util/Hashtable;

    .line 68
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/activation/MimeTypeParseException;
        }
    .end annotation

    .prologue
    .line 75
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 77
    new-instance v0, Ljava/util/Hashtable;

    invoke-direct {v0}, Ljava/util/Hashtable;-><init>()V

    iput-object v0, p0, Ljavax/activation/MimeTypeParameterList;->parameters:Ljava/util/Hashtable;

    .line 80
    invoke-virtual {p0, p1}, Ljavax/activation/MimeTypeParameterList;->parse(Ljava/lang/String;)V

    .line 81
    return-void
.end method

.method private static isTokenChar(C)Z
    .locals 1

    .prologue
    .line 278
    const/16 v0, 0x20

    if-le p0, v0, :cond_0

    const/16 v0, 0x7f

    if-ge p0, v0, :cond_0

    const-string v0, "()<>@,;:/[]?=\\\""

    invoke-virtual {v0, p0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    if-gez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static quote(Ljava/lang/String;)Ljava/lang/String;
    .locals 10

    .prologue
    const/16 v9, 0x5c

    const/16 v8, 0x22

    const/4 v1, 0x0

    .line 296
    .line 299
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v3

    move v2, v1

    move v0, v1

    .line 300
    :goto_0
    if-ge v2, v3, :cond_0

    if-eqz v0, :cond_2

    .line 304
    :cond_0
    if-eqz v0, :cond_1

    .line 305
    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    .line 306
    int-to-double v4, v3

    const-wide/high16 v6, 0x3ff8000000000000L    # 1.5

    mul-double/2addr v4, v6

    double-to-int v2, v4

    invoke-virtual {v0, v2}, Ljava/lang/StringBuffer;->ensureCapacity(I)V

    .line 309
    invoke-virtual {v0, v8}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 312
    :goto_1
    if-lt v1, v3, :cond_4

    .line 320
    invoke-virtual {v0, v8}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 322
    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p0

    .line 324
    :cond_1
    return-object p0

    .line 301
    :cond_2
    invoke-virtual {p0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v0}, Ljavax/activation/MimeTypeParameterList;->isTokenChar(C)Z

    move-result v0

    if-eqz v0, :cond_3

    move v0, v1

    .line 300
    :goto_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 301
    :cond_3
    const/4 v0, 0x1

    goto :goto_2

    .line 313
    :cond_4
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    .line 314
    if-eq v2, v9, :cond_5

    if-ne v2, v8, :cond_6

    .line 315
    :cond_5
    invoke-virtual {v0, v9}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 316
    :cond_6
    invoke-virtual {v0, v2}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 312
    add-int/lit8 v1, v1, 0x1

    goto :goto_1
.end method

.method private static skipWhiteSpace(Ljava/lang/String;I)I
    .locals 2

    .prologue
    .line 286
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    .line 287
    :goto_0
    if-ge p1, v0, :cond_0

    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    invoke-static {v1}, Ljava/lang/Character;->isWhitespace(C)Z

    move-result v1

    if-nez v1, :cond_1

    .line 289
    :cond_0
    return p1

    .line 288
    :cond_1
    add-int/lit8 p1, p1, 0x1

    goto :goto_0
.end method

.method private static unquote(Ljava/lang/String;)Ljava/lang/String;
    .locals 7

    .prologue
    const/4 v1, 0x0

    .line 333
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v3

    .line 334
    new-instance v4, Ljava/lang/StringBuffer;

    invoke-direct {v4}, Ljava/lang/StringBuffer;-><init>()V

    .line 335
    invoke-virtual {v4, v3}, Ljava/lang/StringBuffer;->ensureCapacity(I)V

    move v2, v1

    move v0, v1

    .line 338
    :goto_0
    if-lt v2, v3, :cond_0

    .line 350
    invoke-virtual {v4}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 339
    :cond_0
    invoke-virtual {p0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v5

    .line 340
    if-nez v0, :cond_1

    const/16 v6, 0x5c

    if-eq v5, v6, :cond_1

    .line 341
    invoke-virtual {v4, v5}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 338
    :goto_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 342
    :cond_1
    if-eqz v0, :cond_2

    .line 343
    invoke-virtual {v4, v5}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    move v0, v1

    .line 344
    goto :goto_1

    .line 346
    :cond_2
    const/4 v0, 0x1

    goto :goto_1
.end method


# virtual methods
.method public get(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 220
    iget-object v0, p0, Ljavax/activation/MimeTypeParameterList;->parameters:Ljava/util/Hashtable;

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    sget-object v2, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {v1, v2}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method public getNames()Ljava/util/Enumeration;
    .locals 1

    .prologue
    .line 249
    iget-object v0, p0, Ljavax/activation/MimeTypeParameterList;->parameters:Ljava/util/Hashtable;

    invoke-virtual {v0}, Ljava/util/Hashtable;->keys()Ljava/util/Enumeration;

    move-result-object v0

    return-object v0
.end method

.method public isEmpty()Z
    .locals 1

    .prologue
    .line 209
    iget-object v0, p0, Ljavax/activation/MimeTypeParameterList;->parameters:Ljava/util/Hashtable;

    invoke-virtual {v0}, Ljava/util/Hashtable;->isEmpty()Z

    move-result v0

    return v0
.end method

.method protected parse(Ljava/lang/String;)V
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/activation/MimeTypeParseException;
        }
    .end annotation

    .prologue
    const/16 v6, 0x22

    .line 89
    if-nez p1, :cond_1

    .line 192
    :cond_0
    return-void

    .line 92
    :cond_1
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v3

    .line 93
    if-lez v3, :cond_0

    .line 98
    const/4 v0, 0x0

    invoke-static {p1, v0}, Ljavax/activation/MimeTypeParameterList;->skipWhiteSpace(Ljava/lang/String;I)I

    move-result v0

    .line 99
    :goto_0
    if-ge v0, v3, :cond_2

    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v1

    const/16 v2, 0x3b

    if-eq v1, v2, :cond_3

    .line 188
    :cond_2
    if-ge v0, v3, :cond_0

    .line 189
    new-instance v0, Ljavax/activation/MimeTypeParseException;

    .line 190
    const-string v1, "More characters encountered in input than expected."

    .line 189
    invoke-direct {v0, v1}, Ljavax/activation/MimeTypeParseException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 106
    :cond_3
    add-int/lit8 v0, v0, 0x1

    .line 111
    invoke-static {p1, v0}, Ljavax/activation/MimeTypeParameterList;->skipWhiteSpace(Ljava/lang/String;I)I

    move-result v1

    .line 114
    if-ge v1, v3, :cond_0

    move v0, v1

    .line 119
    :goto_1
    if-ge v0, v3, :cond_4

    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Ljavax/activation/MimeTypeParameterList;->isTokenChar(C)Z

    move-result v2

    if-nez v2, :cond_6

    .line 122
    :cond_4
    invoke-virtual {p1, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    .line 123
    sget-object v2, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {v1, v2}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v4

    .line 126
    invoke-static {p1, v0}, Ljavax/activation/MimeTypeParameterList;->skipWhiteSpace(Ljava/lang/String;I)I

    move-result v0

    .line 128
    if-ge v0, v3, :cond_5

    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v1

    const/16 v2, 0x3d

    if-eq v1, v2, :cond_7

    .line 129
    :cond_5
    new-instance v0, Ljavax/activation/MimeTypeParseException;

    .line 130
    const-string v1, "Couldn\'t find the \'=\' that separates a parameter name from its value."

    .line 129
    invoke-direct {v0, v1}, Ljavax/activation/MimeTypeParseException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 120
    :cond_6
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 134
    :cond_7
    add-int/lit8 v0, v0, 0x1

    .line 135
    invoke-static {p1, v0}, Ljavax/activation/MimeTypeParameterList;->skipWhiteSpace(Ljava/lang/String;I)I

    move-result v0

    .line 137
    if-lt v0, v3, :cond_8

    .line 138
    new-instance v0, Ljavax/activation/MimeTypeParseException;

    .line 139
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Couldn\'t find a value for parameter named "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 138
    invoke-direct {v0, v1}, Ljavax/activation/MimeTypeParseException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 142
    :cond_8
    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v1

    .line 143
    if-ne v1, v6, :cond_e

    .line 145
    add-int/lit8 v2, v0, 0x1

    .line 146
    if-lt v2, v3, :cond_9

    .line 147
    new-instance v0, Ljavax/activation/MimeTypeParseException;

    .line 148
    const-string v1, "Encountered unterminated quoted parameter value."

    .line 147
    invoke-direct {v0, v1}, Ljavax/activation/MimeTypeParseException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_9
    move v0, v2

    .line 153
    :goto_2
    if-lt v0, v3, :cond_b

    .line 165
    :cond_a
    if-eq v1, v6, :cond_d

    .line 166
    new-instance v0, Ljavax/activation/MimeTypeParseException;

    .line 167
    const-string v1, "Encountered unterminated quoted parameter value."

    .line 166
    invoke-direct {v0, v1}, Ljavax/activation/MimeTypeParseException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 154
    :cond_b
    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v1

    .line 155
    if-eq v1, v6, :cond_a

    .line 157
    const/16 v5, 0x5c

    if-ne v1, v5, :cond_c

    .line 161
    add-int/lit8 v0, v0, 0x1

    .line 163
    :cond_c
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 169
    :cond_d
    invoke-virtual {p1, v2, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljavax/activation/MimeTypeParameterList;->unquote(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 171
    add-int/lit8 v0, v0, 0x1

    move-object v7, v1

    move v1, v0

    move-object v0, v7

    .line 186
    :goto_3
    iget-object v2, p0, Ljavax/activation/MimeTypeParameterList;->parameters:Ljava/util/Hashtable;

    invoke-virtual {v2, v4, v0}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 100
    invoke-static {p1, v1}, Ljavax/activation/MimeTypeParameterList;->skipWhiteSpace(Ljava/lang/String;I)I

    move-result v0

    goto/16 :goto_0

    .line 172
    :cond_e
    invoke-static {v1}, Ljavax/activation/MimeTypeParameterList;->isTokenChar(C)Z

    move-result v1

    if-eqz v1, :cond_11

    move v1, v0

    .line 176
    :goto_4
    if-ge v1, v3, :cond_f

    invoke-virtual {p1, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Ljavax/activation/MimeTypeParameterList;->isTokenChar(C)Z

    move-result v2

    if-nez v2, :cond_10

    .line 178
    :cond_f
    invoke-virtual {p1, v0, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    goto :goto_3

    .line 177
    :cond_10
    add-int/lit8 v1, v1, 0x1

    goto :goto_4

    .line 181
    :cond_11
    new-instance v1, Ljavax/activation/MimeTypeParseException;

    .line 182
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Unexpected character encountered at index "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 181
    invoke-direct {v1, v0}, Ljavax/activation/MimeTypeParseException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method public remove(Ljava/lang/String;)V
    .locals 3

    .prologue
    .line 240
    iget-object v0, p0, Ljavax/activation/MimeTypeParameterList;->parameters:Ljava/util/Hashtable;

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    sget-object v2, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {v1, v2}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/Hashtable;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 241
    return-void
.end method

.method public set(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3

    .prologue
    .line 231
    iget-object v0, p0, Ljavax/activation/MimeTypeParameterList;->parameters:Ljava/util/Hashtable;

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    sget-object v2, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {v1, v2}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, p2}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 232
    return-void
.end method

.method public size()I
    .locals 1

    .prologue
    .line 200
    iget-object v0, p0, Ljavax/activation/MimeTypeParameterList;->parameters:Ljava/util/Hashtable;

    invoke-virtual {v0}, Ljava/util/Hashtable;->size()I

    move-result v0

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .prologue
    .line 256
    new-instance v1, Ljava/lang/StringBuffer;

    invoke-direct {v1}, Ljava/lang/StringBuffer;-><init>()V

    .line 257
    iget-object v0, p0, Ljavax/activation/MimeTypeParameterList;->parameters:Ljava/util/Hashtable;

    invoke-virtual {v0}, Ljava/util/Hashtable;->size()I

    move-result v0

    mul-int/lit8 v0, v0, 0x10

    invoke-virtual {v1, v0}, Ljava/lang/StringBuffer;->ensureCapacity(I)V

    .line 260
    iget-object v0, p0, Ljavax/activation/MimeTypeParameterList;->parameters:Ljava/util/Hashtable;

    invoke-virtual {v0}, Ljava/util/Hashtable;->keys()Ljava/util/Enumeration;

    move-result-object v2

    .line 261
    :goto_0
    invoke-interface {v2}, Ljava/util/Enumeration;->hasMoreElements()Z

    move-result v0

    if-nez v0, :cond_0

    .line 269
    invoke-virtual {v1}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 262
    :cond_0
    invoke-interface {v2}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 263
    const-string v3, "; "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 264
    invoke-virtual {v1, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 265
    const/16 v3, 0x3d

    invoke-virtual {v1, v3}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 266
    iget-object v3, p0, Ljavax/activation/MimeTypeParameterList;->parameters:Ljava/util/Hashtable;

    invoke-virtual {v3, v0}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-static {v0}, Ljavax/activation/MimeTypeParameterList;->quote(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    goto :goto_0
.end method
