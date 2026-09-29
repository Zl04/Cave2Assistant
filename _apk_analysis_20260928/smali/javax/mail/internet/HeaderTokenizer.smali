.class public Ljavax/mail/internet/HeaderTokenizer;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ljavax/mail/internet/HeaderTokenizer$Token;
    }
.end annotation


# static fields
.field private static final EOFToken:Ljavax/mail/internet/HeaderTokenizer$Token;

.field public static final MIME:Ljava/lang/String; = "()<>@,;:\\\"\t []/?="

.field public static final RFC822:Ljava/lang/String; = "()<>@,;:\\\"\t .[]"


# instance fields
.field private currentPos:I

.field private delimiters:Ljava/lang/String;

.field private maxPos:I

.field private nextPos:I

.field private peekPos:I

.field private skipComments:Z

.field private string:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    .line 153
    new-instance v0, Ljavax/mail/internet/HeaderTokenizer$Token;

    const/4 v1, -0x4

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Ljavax/mail/internet/HeaderTokenizer$Token;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljavax/mail/internet/HeaderTokenizer;->EOFToken:Ljavax/mail/internet/HeaderTokenizer$Token;

    .line 57
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 191
    const-string v0, "()<>@,;:\\\"\t .[]"

    invoke-direct {p0, p1, v0}, Ljavax/mail/internet/HeaderTokenizer;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 192
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 182
    const/4 v0, 0x1

    invoke-direct {p0, p1, p2, v0}, Ljavax/mail/internet/HeaderTokenizer;-><init>(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 183
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Z)V
    .locals 1

    .prologue
    .line 166
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 168
    if-nez p1, :cond_0

    const-string p1, ""

    :cond_0
    iput-object p1, p0, Ljavax/mail/internet/HeaderTokenizer;->string:Ljava/lang/String;

    .line 169
    iput-boolean p3, p0, Ljavax/mail/internet/HeaderTokenizer;->skipComments:Z

    .line 170
    iput-object p2, p0, Ljavax/mail/internet/HeaderTokenizer;->delimiters:Ljava/lang/String;

    .line 171
    const/4 v0, 0x0

    iput v0, p0, Ljavax/mail/internet/HeaderTokenizer;->peekPos:I

    iput v0, p0, Ljavax/mail/internet/HeaderTokenizer;->nextPos:I

    iput v0, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    .line 172
    iget-object v0, p0, Ljavax/mail/internet/HeaderTokenizer;->string:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    iput v0, p0, Ljavax/mail/internet/HeaderTokenizer;->maxPos:I

    .line 173
    return-void
.end method

.method private static filterToken(Ljava/lang/String;II)Ljava/lang/String;
    .locals 8

    .prologue
    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 359
    new-instance v4, Ljava/lang/StringBuffer;

    invoke-direct {v4}, Ljava/lang/StringBuffer;-><init>()V

    move v3, v1

    move v0, v1

    .line 364
    :goto_0
    if-lt p1, p2, :cond_0

    .line 390
    invoke-virtual {v4}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 365
    :cond_0
    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v5

    .line 366
    const/16 v6, 0xa

    if-ne v5, v6, :cond_1

    if-eqz v3, :cond_1

    move v3, v0

    move v0, v1

    .line 364
    :goto_1
    add-int/lit8 p1, p1, 0x1

    move v7, v0

    move v0, v3

    move v3, v7

    goto :goto_0

    .line 374
    :cond_1
    if-nez v0, :cond_4

    .line 376
    const/16 v3, 0x5c

    if-ne v5, v3, :cond_2

    move v0, v1

    move v3, v2

    .line 377
    goto :goto_1

    .line 378
    :cond_2
    const/16 v3, 0xd

    if-ne v5, v3, :cond_3

    move v3, v0

    move v0, v2

    .line 379
    goto :goto_1

    .line 381
    :cond_3
    invoke-virtual {v4, v5}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    move v3, v0

    move v0, v1

    goto :goto_1

    .line 386
    :cond_4
    invoke-virtual {v4, v5}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    move v0, v1

    move v3, v1

    .line 387
    goto :goto_1
.end method

.method private getNext()Ljavax/mail/internet/HeaderTokenizer$Token;
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/internet/ParseException;
        }
    .end annotation

    .prologue
    const/4 v9, -0x4

    const/16 v8, 0x28

    const/16 v7, 0x22

    const/16 v6, 0x20

    const/4 v2, 0x1

    .line 247
    iget v0, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    iget v1, p0, Ljavax/mail/internet/HeaderTokenizer;->maxPos:I

    if-lt v0, v1, :cond_0

    .line 248
    sget-object v0, Ljavax/mail/internet/HeaderTokenizer;->EOFToken:Ljavax/mail/internet/HeaderTokenizer$Token;

    .line 342
    :goto_0
    return-object v0

    .line 251
    :cond_0
    invoke-direct {p0}, Ljavax/mail/internet/HeaderTokenizer;->skipWhiteSpace()I

    move-result v0

    if-ne v0, v9, :cond_1

    .line 252
    sget-object v0, Ljavax/mail/internet/HeaderTokenizer;->EOFToken:Ljavax/mail/internet/HeaderTokenizer$Token;

    goto :goto_0

    .line 256
    :cond_1
    const/4 v0, 0x0

    .line 258
    iget-object v1, p0, Ljavax/mail/internet/HeaderTokenizer;->string:Ljava/lang/String;

    iget v3, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    invoke-virtual {v1, v3}, Ljava/lang/String;->charAt(I)C

    move-result v1

    .line 262
    :goto_1
    if-eq v1, v8, :cond_2

    .line 302
    if-ne v1, v7, :cond_12

    .line 303
    iget v1, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    :goto_2
    iget v3, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    iget v4, p0, Ljavax/mail/internet/HeaderTokenizer;->maxPos:I

    if-lt v3, v4, :cond_d

    .line 322
    new-instance v0, Ljavax/mail/internet/ParseException;

    const-string v1, "Unbalanced quoted string"

    invoke-direct {v0, v1}, Ljavax/mail/internet/ParseException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 265
    :cond_2
    iget v1, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    add-int/lit8 v3, v1, 0x1

    iput v3, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    move v1, v0

    move v0, v2

    .line 266
    :goto_3
    if-lez v0, :cond_3

    iget v4, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    iget v5, p0, Ljavax/mail/internet/HeaderTokenizer;->maxPos:I

    if-lt v4, v5, :cond_4

    .line 279
    :cond_3
    if-eqz v0, :cond_9

    .line 280
    new-instance v0, Ljavax/mail/internet/ParseException;

    const-string v1, "Unbalanced comments"

    invoke-direct {v0, v1}, Ljavax/mail/internet/ParseException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 268
    :cond_4
    iget-object v4, p0, Ljavax/mail/internet/HeaderTokenizer;->string:Ljava/lang/String;

    iget v5, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    invoke-virtual {v4, v5}, Ljava/lang/String;->charAt(I)C

    move-result v4

    .line 269
    const/16 v5, 0x5c

    if-ne v4, v5, :cond_6

    .line 270
    iget v1, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    move v1, v2

    .line 267
    :cond_5
    :goto_4
    iget v4, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    add-int/lit8 v4, v4, 0x1

    iput v4, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    goto :goto_3

    .line 272
    :cond_6
    const/16 v5, 0xd

    if-ne v4, v5, :cond_7

    move v1, v2

    .line 273
    goto :goto_4

    .line 274
    :cond_7
    if-ne v4, v8, :cond_8

    .line 275
    add-int/lit8 v0, v0, 0x1

    goto :goto_4

    .line 276
    :cond_8
    const/16 v5, 0x29

    if-ne v4, v5, :cond_5

    .line 277
    add-int/lit8 v0, v0, -0x1

    goto :goto_4

    .line 282
    :cond_9
    iget-boolean v0, p0, Ljavax/mail/internet/HeaderTokenizer;->skipComments:Z

    if-nez v0, :cond_b

    .line 286
    if-eqz v1, :cond_a

    .line 287
    iget-object v0, p0, Ljavax/mail/internet/HeaderTokenizer;->string:Ljava/lang/String;

    iget v1, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    add-int/lit8 v1, v1, -0x1

    invoke-static {v0, v3, v1}, Ljavax/mail/internet/HeaderTokenizer;->filterToken(Ljava/lang/String;II)Ljava/lang/String;

    move-result-object v0

    .line 291
    :goto_5
    new-instance v1, Ljavax/mail/internet/HeaderTokenizer$Token;

    const/4 v2, -0x3

    invoke-direct {v1, v2, v0}, Ljavax/mail/internet/HeaderTokenizer$Token;-><init>(ILjava/lang/String;)V

    move-object v0, v1

    goto/16 :goto_0

    .line 289
    :cond_a
    iget-object v0, p0, Ljavax/mail/internet/HeaderTokenizer;->string:Ljava/lang/String;

    iget v1, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    add-int/lit8 v1, v1, -0x1

    invoke-virtual {v0, v3, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    goto :goto_5

    .line 295
    :cond_b
    invoke-direct {p0}, Ljavax/mail/internet/HeaderTokenizer;->skipWhiteSpace()I

    move-result v0

    if-ne v0, v9, :cond_c

    .line 296
    sget-object v0, Ljavax/mail/internet/HeaderTokenizer;->EOFToken:Ljavax/mail/internet/HeaderTokenizer$Token;

    goto/16 :goto_0

    .line 297
    :cond_c
    iget-object v0, p0, Ljavax/mail/internet/HeaderTokenizer;->string:Ljava/lang/String;

    iget v3, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    invoke-virtual {v0, v3}, Ljava/lang/String;->charAt(I)C

    move-result v0

    move v10, v1

    move v1, v0

    move v0, v10

    goto/16 :goto_1

    .line 304
    :cond_d
    iget-object v3, p0, Ljavax/mail/internet/HeaderTokenizer;->string:Ljava/lang/String;

    iget v4, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    invoke-virtual {v3, v4}, Ljava/lang/String;->charAt(I)C

    move-result v3

    .line 305
    const/16 v4, 0x5c

    if-ne v3, v4, :cond_f

    .line 306
    iget v0, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    move v0, v2

    .line 303
    :cond_e
    :goto_6
    iget v3, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    add-int/lit8 v3, v3, 0x1

    iput v3, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    goto/16 :goto_2

    .line 308
    :cond_f
    const/16 v4, 0xd

    if-ne v3, v4, :cond_10

    move v0, v2

    .line 309
    goto :goto_6

    .line 310
    :cond_10
    if-ne v3, v7, :cond_e

    .line 311
    iget v2, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    .line 314
    if-eqz v0, :cond_11

    .line 315
    iget-object v0, p0, Ljavax/mail/internet/HeaderTokenizer;->string:Ljava/lang/String;

    iget v2, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    add-int/lit8 v2, v2, -0x1

    invoke-static {v0, v1, v2}, Ljavax/mail/internet/HeaderTokenizer;->filterToken(Ljava/lang/String;II)Ljava/lang/String;

    move-result-object v0

    .line 319
    :goto_7
    new-instance v1, Ljavax/mail/internet/HeaderTokenizer$Token;

    const/4 v2, -0x2

    invoke-direct {v1, v2, v0}, Ljavax/mail/internet/HeaderTokenizer$Token;-><init>(ILjava/lang/String;)V

    move-object v0, v1

    goto/16 :goto_0

    .line 317
    :cond_11
    iget-object v0, p0, Ljavax/mail/internet/HeaderTokenizer;->string:Ljava/lang/String;

    iget v2, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    add-int/lit8 v2, v2, -0x1

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    goto :goto_7

    .line 326
    :cond_12
    if-lt v1, v6, :cond_13

    const/16 v0, 0x7f

    if-ge v1, v0, :cond_13

    iget-object v0, p0, Ljavax/mail/internet/HeaderTokenizer;->delimiters:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    if-ltz v0, :cond_14

    .line 327
    :cond_13
    iget v0, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    .line 328
    new-array v2, v2, [C

    .line 329
    const/4 v0, 0x0

    aput-char v1, v2, v0

    .line 330
    new-instance v0, Ljavax/mail/internet/HeaderTokenizer$Token;

    new-instance v3, Ljava/lang/String;

    invoke-direct {v3, v2}, Ljava/lang/String;-><init>([C)V

    invoke-direct {v0, v1, v3}, Ljavax/mail/internet/HeaderTokenizer$Token;-><init>(ILjava/lang/String;)V

    goto/16 :goto_0

    .line 334
    :cond_14
    iget v1, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    :goto_8
    iget v0, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    iget v2, p0, Ljavax/mail/internet/HeaderTokenizer;->maxPos:I

    if-lt v0, v2, :cond_16

    .line 342
    :cond_15
    new-instance v0, Ljavax/mail/internet/HeaderTokenizer$Token;

    const/4 v2, -0x1

    iget-object v3, p0, Ljavax/mail/internet/HeaderTokenizer;->string:Ljava/lang/String;

    iget v4, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    invoke-virtual {v3, v1, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v2, v1}, Ljavax/mail/internet/HeaderTokenizer$Token;-><init>(ILjava/lang/String;)V

    goto/16 :goto_0

    .line 335
    :cond_16
    iget-object v0, p0, Ljavax/mail/internet/HeaderTokenizer;->string:Ljava/lang/String;

    iget v2, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    invoke-virtual {v0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v0

    .line 338
    if-lt v0, v6, :cond_15

    const/16 v2, 0x7f

    if-ge v0, v2, :cond_15

    if-eq v0, v8, :cond_15

    if-eq v0, v6, :cond_15

    .line 339
    if-eq v0, v7, :cond_15

    iget-object v2, p0, Ljavax/mail/internet/HeaderTokenizer;->delimiters:Ljava/lang/String;

    invoke-virtual {v2, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    if-gez v0, :cond_15

    .line 334
    iget v0, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    goto :goto_8
.end method

.method private skipWhiteSpace()I
    .locals 2

    .prologue
    .line 348
    :goto_0
    iget v0, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    iget v1, p0, Ljavax/mail/internet/HeaderTokenizer;->maxPos:I

    if-lt v0, v1, :cond_0

    .line 352
    const/4 v0, -0x4

    :goto_1
    return v0

    .line 349
    :cond_0
    iget-object v0, p0, Ljavax/mail/internet/HeaderTokenizer;->string:Ljava/lang/String;

    iget v1, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    invoke-virtual {v0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    const/16 v1, 0x20

    if-eq v0, v1, :cond_1

    .line 350
    const/16 v1, 0x9

    if-eq v0, v1, :cond_1

    const/16 v1, 0xd

    if-eq v0, v1, :cond_1

    const/16 v1, 0xa

    if-eq v0, v1, :cond_1

    .line 351
    iget v0, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    goto :goto_1

    .line 348
    :cond_1
    iget v0, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    goto :goto_0
.end method


# virtual methods
.method public getRemainder()Ljava/lang/String;
    .locals 2

    .prologue
    .line 237
    iget-object v0, p0, Ljavax/mail/internet/HeaderTokenizer;->string:Ljava/lang/String;

    iget v1, p0, Ljavax/mail/internet/HeaderTokenizer;->nextPos:I

    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public next()Ljavax/mail/internet/HeaderTokenizer$Token;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/internet/ParseException;
        }
    .end annotation

    .prologue
    .line 206
    iget v0, p0, Ljavax/mail/internet/HeaderTokenizer;->nextPos:I

    iput v0, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    .line 207
    invoke-direct {p0}, Ljavax/mail/internet/HeaderTokenizer;->getNext()Ljavax/mail/internet/HeaderTokenizer$Token;

    move-result-object v0

    .line 208
    iget v1, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    iput v1, p0, Ljavax/mail/internet/HeaderTokenizer;->peekPos:I

    iput v1, p0, Ljavax/mail/internet/HeaderTokenizer;->nextPos:I

    .line 209
    return-object v0
.end method

.method public peek()Ljavax/mail/internet/HeaderTokenizer$Token;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/internet/ParseException;
        }
    .end annotation

    .prologue
    .line 224
    iget v0, p0, Ljavax/mail/internet/HeaderTokenizer;->peekPos:I

    iput v0, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    .line 225
    invoke-direct {p0}, Ljavax/mail/internet/HeaderTokenizer;->getNext()Ljavax/mail/internet/HeaderTokenizer$Token;

    move-result-object v0

    .line 226
    iget v1, p0, Ljavax/mail/internet/HeaderTokenizer;->currentPos:I

    iput v1, p0, Ljavax/mail/internet/HeaderTokenizer;->peekPos:I

    .line 227
    return-object v0
.end method
