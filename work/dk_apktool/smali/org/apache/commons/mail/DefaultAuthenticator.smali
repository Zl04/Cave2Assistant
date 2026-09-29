.class public Lorg/apache/commons/mail/DefaultAuthenticator;
.super Ljavax/mail/Authenticator;
.source "SourceFile"


# instance fields
.field private final authentication:Ljavax/mail/PasswordAuthentication;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 42
    invoke-direct {p0}, Ljavax/mail/Authenticator;-><init>()V

    .line 43
    new-instance v0, Ljavax/mail/PasswordAuthentication;

    invoke-direct {v0, p1, p2}, Ljavax/mail/PasswordAuthentication;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iput-object v0, p0, Lorg/apache/commons/mail/DefaultAuthenticator;->authentication:Ljavax/mail/PasswordAuthentication;

    .line 44
    return-void
.end method


# virtual methods
.method protected getPasswordAuthentication()Ljavax/mail/PasswordAuthentication;
    .locals 1

    .prologue
    .line 57
    iget-object v0, p0, Lorg/apache/commons/mail/DefaultAuthenticator;->authentication:Ljavax/mail/PasswordAuthentication;

    return-object v0
.end method
