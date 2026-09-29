.class Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static synthetic $SWITCH_TABLE$com$lidroid$xutils$http$client$multipart$HttpMultipartMode:[I

.field private static final CR_LF:Lorg/apache/http/util/ByteArrayBuffer;

.field private static final FIELD_SEP:Lorg/apache/http/util/ByteArrayBuffer;

.field private static final TWO_DASHES:Lorg/apache/http/util/ByteArrayBuffer;


# instance fields
.field private final boundary:Ljava/lang/String;

.field private final charset:Ljava/nio/charset/Charset;

.field private final mode:Lcom/lidroid/xutils/http/client/multipart/HttpMultipartMode;

.field private final parts:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/lidroid/xutils/http/client/multipart/FormBodyPart;",
            ">;"
        }
    .end annotation
.end field

.field private subType:Ljava/lang/String;


# direct methods
.method static synthetic $SWITCH_TABLE$com$lidroid$xutils$http$client$multipart$HttpMultipartMode()[I
    .locals 3

    .prologue
    .line 38
    sget-object v0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->$SWITCH_TABLE$com$lidroid$xutils$http$client$multipart$HttpMultipartMode:[I

    if-eqz v0, :cond_0

    :goto_0
    return-object v0

    :cond_0
    invoke-static {}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipartMode;->values()[Lcom/lidroid/xutils/http/client/multipart/HttpMultipartMode;

    move-result-object v0

    array-length v0, v0

    new-array v0, v0, [I

    :try_start_0
    sget-object v1, Lcom/lidroid/xutils/http/client/multipart/HttpMultipartMode;->BROWSER_COMPATIBLE:Lcom/lidroid/xutils/http/client/multipart/HttpMultipartMode;

    invoke-virtual {v1}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipartMode;->ordinal()I

    move-result v1

    const/4 v2, 0x2

    aput v2, v0, v1
    :try_end_0
    .catch Ljava/lang/NoSuchFieldError; {:try_start_0 .. :try_end_0} :catch_1

    :goto_1
    :try_start_1
    sget-object v1, Lcom/lidroid/xutils/http/client/multipart/HttpMultipartMode;->STRICT:Lcom/lidroid/xutils/http/client/multipart/HttpMultipartMode;

    invoke-virtual {v1}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipartMode;->ordinal()I

    move-result v1

    const/4 v2, 0x1

    aput v2, v0, v1
    :try_end_1
    .catch Ljava/lang/NoSuchFieldError; {:try_start_1 .. :try_end_1} :catch_0

    :goto_2
    sput-object v0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->$SWITCH_TABLE$com$lidroid$xutils$http$client$multipart$HttpMultipartMode:[I

    goto :goto_0

    :catch_0
    move-exception v1

    goto :goto_2

    :catch_1
    move-exception v1

    goto :goto_1
.end method

.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 82
    sget-object v0, Lcom/lidroid/xutils/http/client/multipart/MIME;->DEFAULT_CHARSET:Ljava/nio/charset/Charset;

    const-string v1, ": "

    invoke-static {v0, v1}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->encode(Ljava/nio/charset/Charset;Ljava/lang/String;)Lorg/apache/http/util/ByteArrayBuffer;

    move-result-object v0

    sput-object v0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->FIELD_SEP:Lorg/apache/http/util/ByteArrayBuffer;

    .line 83
    sget-object v0, Lcom/lidroid/xutils/http/client/multipart/MIME;->DEFAULT_CHARSET:Ljava/nio/charset/Charset;

    const-string v1, "\r\n"

    invoke-static {v0, v1}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->encode(Ljava/nio/charset/Charset;Ljava/lang/String;)Lorg/apache/http/util/ByteArrayBuffer;

    move-result-object v0

    sput-object v0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->CR_LF:Lorg/apache/http/util/ByteArrayBuffer;

    .line 84
    sget-object v0, Lcom/lidroid/xutils/http/client/multipart/MIME;->DEFAULT_CHARSET:Ljava/nio/charset/Charset;

    const-string v1, "--"

    invoke-static {v0, v1}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->encode(Ljava/nio/charset/Charset;Ljava/lang/String;)Lorg/apache/http/util/ByteArrayBuffer;

    move-result-object v0

    sput-object v0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->TWO_DASHES:Lorg/apache/http/util/ByteArrayBuffer;

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 132
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0, p2}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;-><init>(Ljava/lang/String;Ljava/nio/charset/Charset;Ljava/lang/String;)V

    .line 133
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/nio/charset/Charset;Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 128
    sget-object v0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipartMode;->STRICT:Lcom/lidroid/xutils/http/client/multipart/HttpMultipartMode;

    invoke-direct {p0, p1, p2, p3, v0}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;-><init>(Ljava/lang/String;Ljava/nio/charset/Charset;Ljava/lang/String;Lcom/lidroid/xutils/http/client/multipart/HttpMultipartMode;)V

    .line 129
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/nio/charset/Charset;Ljava/lang/String;Lcom/lidroid/xutils/http/client/multipart/HttpMultipartMode;)V
    .locals 2

    .prologue
    .line 104
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 105
    if-nez p1, :cond_0

    .line 106
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Multipart subtype may not be null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 108
    :cond_0
    if-nez p3, :cond_1

    .line 109
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Multipart boundary may not be null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 111
    :cond_1
    iput-object p1, p0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->subType:Ljava/lang/String;

    .line 112
    if-eqz p2, :cond_2

    :goto_0
    iput-object p2, p0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->charset:Ljava/nio/charset/Charset;

    .line 113
    iput-object p3, p0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->boundary:Ljava/lang/String;

    .line 114
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->parts:Ljava/util/List;

    .line 115
    iput-object p4, p0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->mode:Lcom/lidroid/xutils/http/client/multipart/HttpMultipartMode;

    .line 116
    return-void

    .line 112
    :cond_2
    sget-object p2, Lcom/lidroid/xutils/http/client/multipart/MIME;->DEFAULT_CHARSET:Ljava/nio/charset/Charset;

    goto :goto_0
.end method

.method private doWriteTo(Lcom/lidroid/xutils/http/client/multipart/HttpMultipartMode;Ljava/io/OutputStream;Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;Z)V
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v10, 0x1

    .line 179
    const-wide/16 v0, 0x0

    iput-wide v0, p3, Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;->pos:J

    .line 181
    iget-object v0, p0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->charset:Ljava/nio/charset/Charset;

    invoke-virtual {p0}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->getBoundary()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->encode(Ljava/nio/charset/Charset;Ljava/lang/String;)Lorg/apache/http/util/ByteArrayBuffer;

    move-result-object v2

    .line 182
    iget-object v0, p0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->parts:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_0

    .line 232
    sget-object v0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->TWO_DASHES:Lorg/apache/http/util/ByteArrayBuffer;

    invoke-static {v0, p2}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->writeBytes(Lorg/apache/http/util/ByteArrayBuffer;Ljava/io/OutputStream;)V

    .line 233
    iget-wide v0, p3, Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;->pos:J

    sget-object v3, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->TWO_DASHES:Lorg/apache/http/util/ByteArrayBuffer;

    invoke-virtual {v3}, Lorg/apache/http/util/ByteArrayBuffer;->length()I

    move-result v3

    int-to-long v4, v3

    add-long/2addr v0, v4

    iput-wide v0, p3, Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;->pos:J

    .line 234
    invoke-static {v2, p2}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->writeBytes(Lorg/apache/http/util/ByteArrayBuffer;Ljava/io/OutputStream;)V

    .line 235
    iget-wide v0, p3, Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;->pos:J

    invoke-virtual {v2}, Lorg/apache/http/util/ByteArrayBuffer;->length()I

    move-result v2

    int-to-long v2, v2

    add-long/2addr v0, v2

    iput-wide v0, p3, Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;->pos:J

    .line 236
    sget-object v0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->TWO_DASHES:Lorg/apache/http/util/ByteArrayBuffer;

    invoke-static {v0, p2}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->writeBytes(Lorg/apache/http/util/ByteArrayBuffer;Ljava/io/OutputStream;)V

    .line 237
    iget-wide v0, p3, Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;->pos:J

    sget-object v2, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->TWO_DASHES:Lorg/apache/http/util/ByteArrayBuffer;

    invoke-virtual {v2}, Lorg/apache/http/util/ByteArrayBuffer;->length()I

    move-result v2

    int-to-long v2, v2

    add-long/2addr v0, v2

    iput-wide v0, p3, Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;->pos:J

    .line 238
    sget-object v0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->CR_LF:Lorg/apache/http/util/ByteArrayBuffer;

    invoke-static {v0, p2}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->writeBytes(Lorg/apache/http/util/ByteArrayBuffer;Ljava/io/OutputStream;)V

    .line 239
    iget-wide v0, p3, Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;->pos:J

    sget-object v2, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->CR_LF:Lorg/apache/http/util/ByteArrayBuffer;

    invoke-virtual {v2}, Lorg/apache/http/util/ByteArrayBuffer;->length()I

    move-result v2

    int-to-long v2, v2

    add-long/2addr v0, v2

    iput-wide v0, p3, Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;->pos:J

    .line 240
    invoke-virtual {p3, v10}, Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;->doCallBack(Z)Z

    .line 241
    return-void

    .line 182
    :cond_0
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lidroid/xutils/http/client/multipart/FormBodyPart;

    .line 183
    invoke-virtual {p3, v10}, Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;->doCallBack(Z)Z

    move-result v1

    if-nez v1, :cond_1

    .line 184
    new-instance v0, Ljava/io/InterruptedIOException;

    const-string v1, "cancel"

    invoke-direct {v0, v1}, Ljava/io/InterruptedIOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 186
    :cond_1
    sget-object v1, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->TWO_DASHES:Lorg/apache/http/util/ByteArrayBuffer;

    invoke-static {v1, p2}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->writeBytes(Lorg/apache/http/util/ByteArrayBuffer;Ljava/io/OutputStream;)V

    .line 187
    iget-wide v4, p3, Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;->pos:J

    sget-object v1, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->TWO_DASHES:Lorg/apache/http/util/ByteArrayBuffer;

    invoke-virtual {v1}, Lorg/apache/http/util/ByteArrayBuffer;->length()I

    move-result v1

    int-to-long v6, v1

    add-long/2addr v4, v6

    iput-wide v4, p3, Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;->pos:J

    .line 188
    invoke-static {v2, p2}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->writeBytes(Lorg/apache/http/util/ByteArrayBuffer;Ljava/io/OutputStream;)V

    .line 189
    iget-wide v4, p3, Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;->pos:J

    invoke-virtual {v2}, Lorg/apache/http/util/ByteArrayBuffer;->length()I

    move-result v1

    int-to-long v6, v1

    add-long/2addr v4, v6

    iput-wide v4, p3, Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;->pos:J

    .line 190
    sget-object v1, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->CR_LF:Lorg/apache/http/util/ByteArrayBuffer;

    invoke-static {v1, p2}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->writeBytes(Lorg/apache/http/util/ByteArrayBuffer;Ljava/io/OutputStream;)V

    .line 191
    iget-wide v4, p3, Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;->pos:J

    sget-object v1, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->CR_LF:Lorg/apache/http/util/ByteArrayBuffer;

    invoke-virtual {v1}, Lorg/apache/http/util/ByteArrayBuffer;->length()I

    move-result v1

    int-to-long v6, v1

    add-long/2addr v4, v6

    iput-wide v4, p3, Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;->pos:J

    .line 193
    invoke-virtual {v0}, Lcom/lidroid/xutils/http/client/multipart/FormBodyPart;->getHeader()Lcom/lidroid/xutils/http/client/multipart/MinimalFieldHeader;

    move-result-object v1

    .line 195
    invoke-static {}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->$SWITCH_TABLE$com$lidroid$xutils$http$client$multipart$HttpMultipartMode()[I

    move-result-object v4

    invoke-virtual {p1}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipartMode;->ordinal()I

    move-result v5

    aget v4, v4, v5

    packed-switch v4, :pswitch_data_0

    .line 221
    :cond_2
    :goto_1
    sget-object v1, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->CR_LF:Lorg/apache/http/util/ByteArrayBuffer;

    invoke-static {v1, p2}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->writeBytes(Lorg/apache/http/util/ByteArrayBuffer;Ljava/io/OutputStream;)V

    .line 222
    iget-wide v4, p3, Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;->pos:J

    sget-object v1, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->CR_LF:Lorg/apache/http/util/ByteArrayBuffer;

    invoke-virtual {v1}, Lorg/apache/http/util/ByteArrayBuffer;->length()I

    move-result v1

    int-to-long v6, v1

    add-long/2addr v4, v6

    iput-wide v4, p3, Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;->pos:J

    .line 224
    if-eqz p4, :cond_3

    .line 225
    invoke-virtual {v0}, Lcom/lidroid/xutils/http/client/multipart/FormBodyPart;->getBody()Lcom/lidroid/xutils/http/client/multipart/content/ContentBody;

    move-result-object v0

    .line 226
    invoke-interface {v0, p3}, Lcom/lidroid/xutils/http/client/multipart/content/ContentBody;->setCallBackInfo(Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;)V

    .line 227
    invoke-interface {v0, p2}, Lcom/lidroid/xutils/http/client/multipart/content/ContentBody;->writeTo(Ljava/io/OutputStream;)V

    .line 229
    :cond_3
    sget-object v0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->CR_LF:Lorg/apache/http/util/ByteArrayBuffer;

    invoke-static {v0, p2}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->writeBytes(Lorg/apache/http/util/ByteArrayBuffer;Ljava/io/OutputStream;)V

    .line 230
    iget-wide v0, p3, Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;->pos:J

    sget-object v4, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->CR_LF:Lorg/apache/http/util/ByteArrayBuffer;

    invoke-virtual {v4}, Lorg/apache/http/util/ByteArrayBuffer;->length()I

    move-result v4

    int-to-long v4, v4

    add-long/2addr v0, v4

    iput-wide v0, p3, Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;->pos:J

    goto/16 :goto_0

    .line 197
    :pswitch_0
    invoke-virtual {v1}, Lcom/lidroid/xutils/http/client/multipart/MinimalFieldHeader;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_2
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/lidroid/xutils/http/client/multipart/MinimalField;

    .line 198
    invoke-static {v1, p2}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->writeField(Lcom/lidroid/xutils/http/client/multipart/MinimalField;Ljava/io/OutputStream;)V

    .line 199
    iget-wide v6, p3, Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;->pos:J

    sget-object v5, Lcom/lidroid/xutils/http/client/multipart/MIME;->DEFAULT_CHARSET:Ljava/nio/charset/Charset;

    .line 200
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Lcom/lidroid/xutils/http/client/multipart/MinimalField;->getName()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    invoke-direct {v8, v9}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Lcom/lidroid/xutils/http/client/multipart/MinimalField;->getBody()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v8, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 199
    invoke-static {v5, v1}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->encode(Ljava/nio/charset/Charset;Ljava/lang/String;)Lorg/apache/http/util/ByteArrayBuffer;

    move-result-object v1

    .line 200
    invoke-virtual {v1}, Lorg/apache/http/util/ByteArrayBuffer;->length()I

    move-result v1

    sget-object v5, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->FIELD_SEP:Lorg/apache/http/util/ByteArrayBuffer;

    invoke-virtual {v5}, Lorg/apache/http/util/ByteArrayBuffer;->length()I

    move-result v5

    .line 199
    add-int/2addr v1, v5

    .line 200
    sget-object v5, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->CR_LF:Lorg/apache/http/util/ByteArrayBuffer;

    invoke-virtual {v5}, Lorg/apache/http/util/ByteArrayBuffer;->length()I

    move-result v5

    add-int/2addr v1, v5

    int-to-long v8, v1

    add-long/2addr v6, v8

    iput-wide v6, p3, Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;->pos:J

    goto :goto_2

    .line 206
    :pswitch_1
    const-string v4, "Content-Disposition"

    invoke-virtual {v1, v4}, Lcom/lidroid/xutils/http/client/multipart/MinimalFieldHeader;->getField(Ljava/lang/String;)Lcom/lidroid/xutils/http/client/multipart/MinimalField;

    move-result-object v4

    .line 207
    iget-object v5, p0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->charset:Ljava/nio/charset/Charset;

    invoke-static {v4, v5, p2}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->writeField(Lcom/lidroid/xutils/http/client/multipart/MinimalField;Ljava/nio/charset/Charset;Ljava/io/OutputStream;)V

    .line 208
    iget-wide v6, p3, Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;->pos:J

    iget-object v5, p0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->charset:Ljava/nio/charset/Charset;

    .line 209
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Lcom/lidroid/xutils/http/client/multipart/MinimalField;->getName()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    invoke-direct {v8, v9}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4}, Lcom/lidroid/xutils/http/client/multipart/MinimalField;->getBody()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 208
    invoke-static {v5, v4}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->encode(Ljava/nio/charset/Charset;Ljava/lang/String;)Lorg/apache/http/util/ByteArrayBuffer;

    move-result-object v4

    .line 209
    invoke-virtual {v4}, Lorg/apache/http/util/ByteArrayBuffer;->length()I

    move-result v4

    sget-object v5, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->FIELD_SEP:Lorg/apache/http/util/ByteArrayBuffer;

    invoke-virtual {v5}, Lorg/apache/http/util/ByteArrayBuffer;->length()I

    move-result v5

    .line 208
    add-int/2addr v4, v5

    .line 209
    sget-object v5, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->CR_LF:Lorg/apache/http/util/ByteArrayBuffer;

    invoke-virtual {v5}, Lorg/apache/http/util/ByteArrayBuffer;->length()I

    move-result v5

    add-int/2addr v4, v5

    int-to-long v4, v4

    add-long/2addr v4, v6

    iput-wide v4, p3, Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;->pos:J

    .line 210
    invoke-virtual {v0}, Lcom/lidroid/xutils/http/client/multipart/FormBodyPart;->getBody()Lcom/lidroid/xutils/http/client/multipart/content/ContentBody;

    move-result-object v4

    invoke-interface {v4}, Lcom/lidroid/xutils/http/client/multipart/content/ContentBody;->getFilename()Ljava/lang/String;

    move-result-object v4

    .line 211
    if-eqz v4, :cond_2

    .line 212
    const-string v4, "Content-Type"

    invoke-virtual {v1, v4}, Lcom/lidroid/xutils/http/client/multipart/MinimalFieldHeader;->getField(Ljava/lang/String;)Lcom/lidroid/xutils/http/client/multipart/MinimalField;

    move-result-object v1

    .line 213
    iget-object v4, p0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->charset:Ljava/nio/charset/Charset;

    invoke-static {v1, v4, p2}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->writeField(Lcom/lidroid/xutils/http/client/multipart/MinimalField;Ljava/nio/charset/Charset;Ljava/io/OutputStream;)V

    .line 214
    iget-wide v4, p3, Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;->pos:J

    iget-object v6, p0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->charset:Ljava/nio/charset/Charset;

    .line 215
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Lcom/lidroid/xutils/http/client/multipart/MinimalField;->getName()Ljava/lang/String;

    move-result-object v8

    invoke-static {v8}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    invoke-direct {v7, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Lcom/lidroid/xutils/http/client/multipart/MinimalField;->getBody()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 214
    invoke-static {v6, v1}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->encode(Ljava/nio/charset/Charset;Ljava/lang/String;)Lorg/apache/http/util/ByteArrayBuffer;

    move-result-object v1

    .line 215
    invoke-virtual {v1}, Lorg/apache/http/util/ByteArrayBuffer;->length()I

    move-result v1

    sget-object v6, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->FIELD_SEP:Lorg/apache/http/util/ByteArrayBuffer;

    invoke-virtual {v6}, Lorg/apache/http/util/ByteArrayBuffer;->length()I

    move-result v6

    .line 214
    add-int/2addr v1, v6

    .line 215
    sget-object v6, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->CR_LF:Lorg/apache/http/util/ByteArrayBuffer;

    invoke-virtual {v6}, Lorg/apache/http/util/ByteArrayBuffer;->length()I

    move-result v6

    add-int/2addr v1, v6

    int-to-long v6, v1

    add-long/2addr v4, v6

    iput-wide v4, p3, Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;->pos:J

    goto/16 :goto_1

    .line 195
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method private doWriteTo(Lcom/lidroid/xutils/http/client/multipart/HttpMultipartMode;Ljava/io/OutputStream;Z)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 170
    sget-object v0, Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;->DEFAULT:Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;

    invoke-direct {p0, p1, p2, v0, p3}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->doWriteTo(Lcom/lidroid/xutils/http/client/multipart/HttpMultipartMode;Ljava/io/OutputStream;Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;Z)V

    .line 171
    return-void
.end method

.method private static encode(Ljava/nio/charset/Charset;Ljava/lang/String;)Lorg/apache/http/util/ByteArrayBuffer;
    .locals 4

    .prologue
    .line 42
    invoke-static {p1}, Ljava/nio/CharBuffer;->wrap(Ljava/lang/CharSequence;)Ljava/nio/CharBuffer;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljava/nio/charset/Charset;->encode(Ljava/nio/CharBuffer;)Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 43
    new-instance v1, Lorg/apache/http/util/ByteArrayBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v2

    invoke-direct {v1, v2}, Lorg/apache/http/util/ByteArrayBuffer;-><init>(I)V

    .line 44
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v2

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->position()I

    move-result v3

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    invoke-virtual {v1, v2, v3, v0}, Lorg/apache/http/util/ByteArrayBuffer;->append([BII)V

    .line 45
    return-object v1
.end method

.method private static writeBytes(Ljava/lang/String;Ljava/io/OutputStream;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 62
    sget-object v0, Lcom/lidroid/xutils/http/client/multipart/MIME;->DEFAULT_CHARSET:Ljava/nio/charset/Charset;

    invoke-static {v0, p0}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->encode(Ljava/nio/charset/Charset;Ljava/lang/String;)Lorg/apache/http/util/ByteArrayBuffer;

    move-result-object v0

    .line 63
    invoke-static {v0, p1}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->writeBytes(Lorg/apache/http/util/ByteArrayBuffer;Ljava/io/OutputStream;)V

    .line 64
    return-void
.end method

.method private static writeBytes(Ljava/lang/String;Ljava/nio/charset/Charset;Ljava/io/OutputStream;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 56
    invoke-static {p1, p0}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->encode(Ljava/nio/charset/Charset;Ljava/lang/String;)Lorg/apache/http/util/ByteArrayBuffer;

    move-result-object v0

    .line 57
    invoke-static {v0, p2}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->writeBytes(Lorg/apache/http/util/ByteArrayBuffer;Ljava/io/OutputStream;)V

    .line 58
    return-void
.end method

.method private static writeBytes(Lorg/apache/http/util/ByteArrayBuffer;Ljava/io/OutputStream;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 50
    invoke-virtual {p0}, Lorg/apache/http/util/ByteArrayBuffer;->buffer()[B

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {p0}, Lorg/apache/http/util/ByteArrayBuffer;->length()I

    move-result v2

    invoke-virtual {p1, v0, v1, v2}, Ljava/io/OutputStream;->write([BII)V

    .line 51
    invoke-virtual {p1}, Ljava/io/OutputStream;->flush()V

    .line 52
    return-void
.end method

.method private static writeField(Lcom/lidroid/xutils/http/client/multipart/MinimalField;Ljava/io/OutputStream;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 68
    invoke-virtual {p0}, Lcom/lidroid/xutils/http/client/multipart/MinimalField;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p1}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->writeBytes(Ljava/lang/String;Ljava/io/OutputStream;)V

    .line 69
    sget-object v0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->FIELD_SEP:Lorg/apache/http/util/ByteArrayBuffer;

    invoke-static {v0, p1}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->writeBytes(Lorg/apache/http/util/ByteArrayBuffer;Ljava/io/OutputStream;)V

    .line 70
    invoke-virtual {p0}, Lcom/lidroid/xutils/http/client/multipart/MinimalField;->getBody()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p1}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->writeBytes(Ljava/lang/String;Ljava/io/OutputStream;)V

    .line 71
    sget-object v0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->CR_LF:Lorg/apache/http/util/ByteArrayBuffer;

    invoke-static {v0, p1}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->writeBytes(Lorg/apache/http/util/ByteArrayBuffer;Ljava/io/OutputStream;)V

    .line 72
    return-void
.end method

.method private static writeField(Lcom/lidroid/xutils/http/client/multipart/MinimalField;Ljava/nio/charset/Charset;Ljava/io/OutputStream;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 76
    invoke-virtual {p0}, Lcom/lidroid/xutils/http/client/multipart/MinimalField;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p1, p2}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->writeBytes(Ljava/lang/String;Ljava/nio/charset/Charset;Ljava/io/OutputStream;)V

    .line 77
    sget-object v0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->FIELD_SEP:Lorg/apache/http/util/ByteArrayBuffer;

    invoke-static {v0, p2}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->writeBytes(Lorg/apache/http/util/ByteArrayBuffer;Ljava/io/OutputStream;)V

    .line 78
    invoke-virtual {p0}, Lcom/lidroid/xutils/http/client/multipart/MinimalField;->getBody()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p1, p2}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->writeBytes(Ljava/lang/String;Ljava/nio/charset/Charset;Ljava/io/OutputStream;)V

    .line 79
    sget-object v0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->CR_LF:Lorg/apache/http/util/ByteArrayBuffer;

    invoke-static {v0, p2}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->writeBytes(Lorg/apache/http/util/ByteArrayBuffer;Ljava/io/OutputStream;)V

    .line 80
    return-void
.end method


# virtual methods
.method public addBodyPart(Lcom/lidroid/xutils/http/client/multipart/FormBodyPart;)V
    .locals 1

    .prologue
    .line 156
    if-nez p1, :cond_0

    .line 160
    :goto_0
    return-void

    .line 159
    :cond_0
    iget-object v0, p0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->parts:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0
.end method

.method public getBodyParts()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/lidroid/xutils/http/client/multipart/FormBodyPart;",
            ">;"
        }
    .end annotation

    .prologue
    .line 152
    iget-object v0, p0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->parts:Ljava/util/List;

    return-object v0
.end method

.method public getBoundary()Ljava/lang/String;
    .locals 1

    .prologue
    .line 163
    iget-object v0, p0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->boundary:Ljava/lang/String;

    return-object v0
.end method

.method public getCharset()Ljava/nio/charset/Charset;
    .locals 1

    .prologue
    .line 144
    iget-object v0, p0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->charset:Ljava/nio/charset/Charset;

    return-object v0
.end method

.method public getMode()Lcom/lidroid/xutils/http/client/multipart/HttpMultipartMode;
    .locals 1

    .prologue
    .line 148
    iget-object v0, p0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->mode:Lcom/lidroid/xutils/http/client/multipart/HttpMultipartMode;

    return-object v0
.end method

.method public getSubType()Ljava/lang/String;
    .locals 1

    .prologue
    .line 140
    iget-object v0, p0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->subType:Ljava/lang/String;

    return-object v0
.end method

.method public getTotalLength()J
    .locals 10

    .prologue
    const-wide/16 v4, 0x0

    const-wide/16 v6, -0x1

    .line 268
    .line 269
    iget-object v0, p0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->parts:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v8

    move-wide v2, v4

    :goto_0
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_0

    .line 278
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 280
    :try_start_0
    iget-object v1, p0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->mode:Lcom/lidroid/xutils/http/client/multipart/HttpMultipartMode;

    const/4 v4, 0x0

    invoke-direct {p0, v1, v0, v4}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->doWriteTo(Lcom/lidroid/xutils/http/client/multipart/HttpMultipartMode;Ljava/io/OutputStream;Z)V

    .line 281
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    .line 282
    array-length v0, v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    int-to-long v0, v0

    add-long/2addr v0, v2

    .line 285
    :goto_1
    return-wide v0

    .line 269
    :cond_0
    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lidroid/xutils/http/client/multipart/FormBodyPart;

    .line 270
    invoke-virtual {v0}, Lcom/lidroid/xutils/http/client/multipart/FormBodyPart;->getBody()Lcom/lidroid/xutils/http/client/multipart/content/ContentBody;

    move-result-object v0

    .line 271
    invoke-interface {v0}, Lcom/lidroid/xutils/http/client/multipart/content/ContentBody;->getContentLength()J

    move-result-wide v0

    .line 272
    cmp-long v9, v0, v4

    if-ltz v9, :cond_1

    .line 273
    add-long/2addr v0, v2

    move-wide v2, v0

    .line 274
    goto :goto_0

    :cond_1
    move-wide v0, v6

    .line 275
    goto :goto_1

    .line 283
    :catch_0
    move-exception v0

    move-wide v0, v6

    .line 285
    goto :goto_1
.end method

.method public setSubType(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 136
    iput-object p1, p0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->subType:Ljava/lang/String;

    .line 137
    return-void
.end method

.method public writeTo(Ljava/io/OutputStream;Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 251
    iget-object v0, p0, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->mode:Lcom/lidroid/xutils/http/client/multipart/HttpMultipartMode;

    const/4 v1, 0x1

    invoke-direct {p0, v0, p1, p2, v1}, Lcom/lidroid/xutils/http/client/multipart/HttpMultipart;->doWriteTo(Lcom/lidroid/xutils/http/client/multipart/HttpMultipartMode;Ljava/io/OutputStream;Lcom/lidroid/xutils/http/client/multipart/MultipartEntity$CallBackInfo;Z)V

    .line 252
    return-void
.end method
