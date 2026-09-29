.class Lcom/umeng/commonsdk/stateless/e$1;
.super Ljava/lang/Object;
.source "UMSLNetWorkSenderHelper.java"

# interfaces
.implements Lorg/apache/http/conn/ssl/X509HostnameVerifier;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/umeng/commonsdk/stateless/e;->a([BLjava/lang/String;)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/umeng/commonsdk/stateless/e;


# direct methods
.method constructor <init>(Lcom/umeng/commonsdk/stateless/e;)V
    .locals 0

    .prologue
    .line 95
    iput-object p1, p0, Lcom/umeng/commonsdk/stateless/e$1;->a:Lcom/umeng/commonsdk/stateless/e;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public verify(Ljava/lang/String;Ljava/security/cert/X509Certificate;)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/net/ssl/SSLException;
        }
    .end annotation

    .prologue
    .line 107
    return-void
.end method

.method public verify(Ljava/lang/String;Ljavax/net/ssl/SSLSocket;)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 103
    return-void
.end method

.method public verify(Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/net/ssl/SSLException;
        }
    .end annotation

    .prologue
    .line 111
    return-void
.end method

.method public verify(Ljava/lang/String;Ljavax/net/ssl/SSLSession;)Z
    .locals 1

    .prologue
    .line 98
    const/4 v0, 0x1

    return v0
.end method
