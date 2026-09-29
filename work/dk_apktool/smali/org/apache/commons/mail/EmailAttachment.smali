.class public Lorg/apache/commons/mail/EmailAttachment;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static final ATTACHMENT:Ljava/lang/String; = "attachment"

.field public static final INLINE:Ljava/lang/String; = "inline"


# instance fields
.field private description:Ljava/lang/String;

.field private disposition:Ljava/lang/String;

.field private name:Ljava/lang/String;

.field private path:Ljava/lang/String;

.field private url:Ljava/net/URL;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 36
    const-string v0, ""

    iput-object v0, p0, Lorg/apache/commons/mail/EmailAttachment;->name:Ljava/lang/String;

    .line 39
    const-string v0, ""

    iput-object v0, p0, Lorg/apache/commons/mail/EmailAttachment;->description:Ljava/lang/String;

    .line 42
    const-string v0, ""

    iput-object v0, p0, Lorg/apache/commons/mail/EmailAttachment;->path:Ljava/lang/String;

    .line 48
    const-string v0, "attachment"

    iput-object v0, p0, Lorg/apache/commons/mail/EmailAttachment;->disposition:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public getDescription()Ljava/lang/String;
    .locals 1

    .prologue
    .line 58
    iget-object v0, p0, Lorg/apache/commons/mail/EmailAttachment;->description:Ljava/lang/String;

    return-object v0
.end method

.method public getDisposition()Ljava/lang/String;
    .locals 1

    .prologue
    .line 102
    iget-object v0, p0, Lorg/apache/commons/mail/EmailAttachment;->disposition:Ljava/lang/String;

    return-object v0
.end method

.method public getName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 69
    iget-object v0, p0, Lorg/apache/commons/mail/EmailAttachment;->name:Ljava/lang/String;

    return-object v0
.end method

.method public getPath()Ljava/lang/String;
    .locals 1

    .prologue
    .line 80
    iget-object v0, p0, Lorg/apache/commons/mail/EmailAttachment;->path:Ljava/lang/String;

    return-object v0
.end method

.method public getURL()Ljava/net/URL;
    .locals 1

    .prologue
    .line 91
    iget-object v0, p0, Lorg/apache/commons/mail/EmailAttachment;->url:Ljava/net/URL;

    return-object v0
.end method

.method public setDescription(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 113
    iput-object p1, p0, Lorg/apache/commons/mail/EmailAttachment;->description:Ljava/lang/String;

    .line 114
    return-void
.end method

.method public setDisposition(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 161
    iput-object p1, p0, Lorg/apache/commons/mail/EmailAttachment;->disposition:Ljava/lang/String;

    .line 162
    return-void
.end method

.method public setName(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 124
    iput-object p1, p0, Lorg/apache/commons/mail/EmailAttachment;->name:Ljava/lang/String;

    .line 125
    return-void
.end method

.method public setPath(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 139
    iput-object p1, p0, Lorg/apache/commons/mail/EmailAttachment;->path:Ljava/lang/String;

    .line 140
    return-void
.end method

.method public setURL(Ljava/net/URL;)V
    .locals 0

    .prologue
    .line 150
    iput-object p1, p0, Lorg/apache/commons/mail/EmailAttachment;->url:Ljava/net/URL;

    .line 151
    return-void
.end method
