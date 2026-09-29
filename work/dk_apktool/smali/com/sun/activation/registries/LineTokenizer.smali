.class Lcom/sun/activation/registries/LineTokenizer;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static final singles:Ljava/lang/String; = "="


# instance fields
.field private currentPosition:I

.field private maxPosition:I

.field private stack:Ljava/util/Vector;

.field private str:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 242
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 233
    new-instance v0, Ljava/util/Vector;

    invoke-direct {v0}, Ljava/util/Vector;-><init>()V

    iput-object v0, p0, Lcom/sun/activation/registries/LineTokenizer;->stack:Ljava/util/Vector;

    .line 243
    const/4 v0, 0x0

    iput v0, p0, Lcom/sun/activation/registries/LineTokenizer;->currentPosition:I

    .line 244
    iput-object p1, p0, Lcom/sun/activation/registries/LineTokenizer;->str:Ljava/lang/String;

    .line 245
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    iput v0, p0, Lcom/sun/activation/registries/LineTokenizer;->maxPosition:I

    .line 246
    return-void
.end method

.method private skipWhiteSpace()V
    .locals 2

    .prologue
    .line 252
    :goto_0
    iget v0, p0, Lcom/sun/activation/registries/LineTokenizer;->currentPosition:I

    iget v1, p0, Lcom/sun/activation/registries/LineTokenizer;->maxPosition:I

    if-ge v0, v1, :cond_0

    .line 253
    iget-object v0, p0, Lcom/sun/activation/registries/LineTokenizer;->str:Ljava/lang/String;

    iget v1, p0, Lcom/sun/activation/registries/LineTokenizer;->currentPosition:I

    invoke-virtual {v0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v0}, Ljava/lang/Character;->isWhitespace(C)Z

    move-result v0

    .line 252
    if-nez v0, :cond_1

    .line 256
    :cond_0
    return-void

    .line 254
    :cond_1
    iget v0, p0, Lcom/sun/activation/registries/LineTokenizer;->currentPosition:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/sun/activation/registries/LineTokenizer;->currentPosition:I

    goto :goto_0
.end method


# virtual methods
.method public hasMoreTokens()Z
    .locals 3

    .prologue
    const/4 v0, 0x1

    .line 265
    iget-object v1, p0, Lcom/sun/activation/registries/LineTokenizer;->stack:Ljava/util/Vector;

    invoke-virtual {v1}, Ljava/util/Vector;->size()I

    move-result v1

    if-lez v1, :cond_1

    .line 268
    :cond_0
    :goto_0
    return v0

    .line 267
    :cond_1
    invoke-direct {p0}, Lcom/sun/activation/registries/LineTokenizer;->skipWhiteSpace()V

    .line 268
    iget v1, p0, Lcom/sun/activation/registries/LineTokenizer;->currentPosition:I

    iget v2, p0, Lcom/sun/activation/registries/LineTokenizer;->maxPosition:I

    if-lt v1, v2, :cond_0

    const/4 v0, 0x0

    goto :goto_0
.end method

.method public nextToken()Ljava/lang/String;
    .locals 7

    .prologue
    const/16 v6, 0x5c

    const/16 v5, 0x22

    .line 279
    iget-object v0, p0, Lcom/sun/activation/registries/LineTokenizer;->stack:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v1

    .line 280
    if-lez v1, :cond_0

    .line 281
    iget-object v0, p0, Lcom/sun/activation/registries/LineTokenizer;->stack:Ljava/util/Vector;

    add-int/lit8 v2, v1, -0x1

    invoke-virtual {v0, v2}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 282
    iget-object v2, p0, Lcom/sun/activation/registries/LineTokenizer;->stack:Ljava/util/Vector;

    add-int/lit8 v1, v1, -0x1

    invoke-virtual {v2, v1}, Ljava/util/Vector;->removeElementAt(I)V

    .line 326
    :goto_0
    return-object v0

    .line 285
    :cond_0
    invoke-direct {p0}, Lcom/sun/activation/registries/LineTokenizer;->skipWhiteSpace()V

    .line 287
    iget v0, p0, Lcom/sun/activation/registries/LineTokenizer;->currentPosition:I

    iget v1, p0, Lcom/sun/activation/registries/LineTokenizer;->maxPosition:I

    if-lt v0, v1, :cond_1

    .line 288
    new-instance v0, Ljava/util/NoSuchElementException;

    invoke-direct {v0}, Ljava/util/NoSuchElementException;-><init>()V

    throw v0

    .line 291
    :cond_1
    iget v1, p0, Lcom/sun/activation/registries/LineTokenizer;->currentPosition:I

    .line 292
    iget-object v0, p0, Lcom/sun/activation/registries/LineTokenizer;->str:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    .line 293
    if-ne v0, v5, :cond_9

    .line 294
    iget v0, p0, Lcom/sun/activation/registries/LineTokenizer;->currentPosition:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/sun/activation/registries/LineTokenizer;->currentPosition:I

    .line 295
    const/4 v0, 0x0

    .line 296
    :cond_2
    :goto_1
    iget v2, p0, Lcom/sun/activation/registries/LineTokenizer;->currentPosition:I

    iget v3, p0, Lcom/sun/activation/registries/LineTokenizer;->maxPosition:I

    if-lt v2, v3, :cond_4

    .line 326
    :cond_3
    :goto_2
    iget-object v0, p0, Lcom/sun/activation/registries/LineTokenizer;->str:Ljava/lang/String;

    iget v2, p0, Lcom/sun/activation/registries/LineTokenizer;->currentPosition:I

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 297
    :cond_4
    iget-object v2, p0, Lcom/sun/activation/registries/LineTokenizer;->str:Ljava/lang/String;

    iget v3, p0, Lcom/sun/activation/registries/LineTokenizer;->currentPosition:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/sun/activation/registries/LineTokenizer;->currentPosition:I

    invoke-virtual {v2, v3}, Ljava/lang/String;->charAt(I)C

    move-result v2

    .line 298
    if-ne v2, v6, :cond_5

    .line 299
    iget v0, p0, Lcom/sun/activation/registries/LineTokenizer;->currentPosition:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/sun/activation/registries/LineTokenizer;->currentPosition:I

    .line 300
    const/4 v0, 0x1

    goto :goto_1

    .line 301
    :cond_5
    if-ne v2, v5, :cond_2

    .line 304
    if-eqz v0, :cond_8

    .line 305
    new-instance v2, Ljava/lang/StringBuffer;

    invoke-direct {v2}, Ljava/lang/StringBuffer;-><init>()V

    .line 306
    add-int/lit8 v0, v1, 0x1

    :goto_3
    iget v1, p0, Lcom/sun/activation/registries/LineTokenizer;->currentPosition:I

    add-int/lit8 v1, v1, -0x1

    if-lt v0, v1, :cond_6

    .line 311
    invoke-virtual {v2}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 307
    :cond_6
    iget-object v1, p0, Lcom/sun/activation/registries/LineTokenizer;->str:Ljava/lang/String;

    invoke-virtual {v1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v1

    .line 308
    if-eq v1, v6, :cond_7

    .line 309
    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 306
    :cond_7
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 313
    :cond_8
    iget-object v0, p0, Lcom/sun/activation/registries/LineTokenizer;->str:Ljava/lang/String;

    add-int/lit8 v1, v1, 0x1

    iget v2, p0, Lcom/sun/activation/registries/LineTokenizer;->currentPosition:I

    add-int/lit8 v2, v2, -0x1

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 317
    :cond_9
    const-string v2, "="

    invoke-virtual {v2, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    if-ltz v0, :cond_b

    .line 318
    iget v0, p0, Lcom/sun/activation/registries/LineTokenizer;->currentPosition:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/sun/activation/registries/LineTokenizer;->currentPosition:I

    goto :goto_2

    .line 323
    :cond_a
    iget v0, p0, Lcom/sun/activation/registries/LineTokenizer;->currentPosition:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/sun/activation/registries/LineTokenizer;->currentPosition:I

    .line 320
    :cond_b
    iget v0, p0, Lcom/sun/activation/registries/LineTokenizer;->currentPosition:I

    iget v2, p0, Lcom/sun/activation/registries/LineTokenizer;->maxPosition:I

    if-ge v0, v2, :cond_3

    .line 321
    const-string v0, "="

    iget-object v2, p0, Lcom/sun/activation/registries/LineTokenizer;->str:Ljava/lang/String;

    iget v3, p0, Lcom/sun/activation/registries/LineTokenizer;->currentPosition:I

    invoke-virtual {v2, v3}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-virtual {v0, v2}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    if-gez v0, :cond_3

    .line 322
    iget-object v0, p0, Lcom/sun/activation/registries/LineTokenizer;->str:Ljava/lang/String;

    iget v2, p0, Lcom/sun/activation/registries/LineTokenizer;->currentPosition:I

    invoke-virtual {v0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v0}, Ljava/lang/Character;->isWhitespace(C)Z

    move-result v0

    .line 320
    if-eqz v0, :cond_a

    goto/16 :goto_2
.end method

.method public pushToken(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 330
    iget-object v0, p0, Lcom/sun/activation/registries/LineTokenizer;->stack:Ljava/util/Vector;

    invoke-virtual {v0, p1}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    .line 331
    return-void
.end method
