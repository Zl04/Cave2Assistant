.class public Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;
.super Ljava/io/BufferedOutputStream;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/github/kevinsawicki/http/HttpRequest;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "RequestOutputStream"
.end annotation


# instance fields
.field private final encoder:Ljava/nio/charset/CharsetEncoder;


# direct methods
.method public constructor <init>(Ljava/io/OutputStream;Ljava/lang/String;I)V
    .locals 1

    .prologue
    .line 809
    invoke-direct {p0, p1, p3}, Ljava/io/BufferedOutputStream;-><init>(Ljava/io/OutputStream;I)V

    .line 811
    invoke-static {p2}, Lcom/github/kevinsawicki/http/HttpRequest;->access$000(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/nio/charset/Charset;->forName(Ljava/lang/String;)Ljava/nio/charset/Charset;

    move-result-object v0

    invoke-virtual {v0}, Ljava/nio/charset/Charset;->newEncoder()Ljava/nio/charset/CharsetEncoder;

    move-result-object v0

    iput-object v0, p0, Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;->encoder:Ljava/nio/charset/CharsetEncoder;

    .line 812
    return-void
.end method

.method static synthetic access$500(Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;)Ljava/nio/charset/CharsetEncoder;
    .locals 1

    .prologue
    .line 796
    iget-object v0, p0, Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;->encoder:Ljava/nio/charset/CharsetEncoder;

    return-object v0
.end method


# virtual methods
.method public write(Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 822
    iget-object v0, p0, Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;->encoder:Ljava/nio/charset/CharsetEncoder;

    invoke-static {p1}, Ljava/nio/CharBuffer;->wrap(Ljava/lang/CharSequence;)Ljava/nio/CharBuffer;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/nio/charset/CharsetEncoder;->encode(Ljava/nio/CharBuffer;)Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 824
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->limit()I

    move-result v0

    invoke-super {p0, v1, v2, v0}, Ljava/io/BufferedOutputStream;->write([BII)V

    .line 826
    return-object p0
.end method
