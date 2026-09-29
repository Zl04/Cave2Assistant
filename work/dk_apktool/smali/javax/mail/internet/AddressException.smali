.class public Ljavax/mail/internet/AddressException;
.super Ljavax/mail/internet/ParseException;
.source "SourceFile"


# static fields
.field private static final serialVersionUID:J = 0x7ec48f3eab5368f0L


# instance fields
.field protected pos:I

.field protected ref:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 71
    invoke-direct {p0}, Ljavax/mail/internet/ParseException;-><init>()V

    .line 56
    const/4 v0, 0x0

    iput-object v0, p0, Ljavax/mail/internet/AddressException;->ref:Ljava/lang/String;

    .line 63
    const/4 v0, -0x1

    iput v0, p0, Ljavax/mail/internet/AddressException;->pos:I

    .line 72
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 79
    invoke-direct {p0, p1}, Ljavax/mail/internet/ParseException;-><init>(Ljava/lang/String;)V

    .line 56
    const/4 v0, 0x0

    iput-object v0, p0, Ljavax/mail/internet/AddressException;->ref:Ljava/lang/String;

    .line 63
    const/4 v0, -0x1

    iput v0, p0, Ljavax/mail/internet/AddressException;->pos:I

    .line 80
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 90
    invoke-direct {p0, p1}, Ljavax/mail/internet/ParseException;-><init>(Ljava/lang/String;)V

    .line 56
    const/4 v0, 0x0

    iput-object v0, p0, Ljavax/mail/internet/AddressException;->ref:Ljava/lang/String;

    .line 63
    const/4 v0, -0x1

    iput v0, p0, Ljavax/mail/internet/AddressException;->pos:I

    .line 91
    iput-object p2, p0, Ljavax/mail/internet/AddressException;->ref:Ljava/lang/String;

    .line 92
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;I)V
    .locals 1

    .prologue
    .line 100
    invoke-direct {p0, p1}, Ljavax/mail/internet/ParseException;-><init>(Ljava/lang/String;)V

    .line 56
    const/4 v0, 0x0

    iput-object v0, p0, Ljavax/mail/internet/AddressException;->ref:Ljava/lang/String;

    .line 63
    const/4 v0, -0x1

    iput v0, p0, Ljavax/mail/internet/AddressException;->pos:I

    .line 101
    iput-object p2, p0, Ljavax/mail/internet/AddressException;->ref:Ljava/lang/String;

    .line 102
    iput p3, p0, Ljavax/mail/internet/AddressException;->pos:I

    .line 103
    return-void
.end method


# virtual methods
.method public getPos()I
    .locals 1

    .prologue
    .line 118
    iget v0, p0, Ljavax/mail/internet/AddressException;->pos:I

    return v0
.end method

.method public getRef()Ljava/lang/String;
    .locals 1

    .prologue
    .line 110
    iget-object v0, p0, Ljavax/mail/internet/AddressException;->ref:Ljava/lang/String;

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .prologue
    .line 122
    invoke-super {p0}, Ljavax/mail/internet/ParseException;->toString()Ljava/lang/String;

    move-result-object v0

    .line 123
    iget-object v1, p0, Ljavax/mail/internet/AddressException;->ref:Ljava/lang/String;

    if-nez v1, :cond_1

    .line 128
    :cond_0
    :goto_0
    return-object v0

    .line 125
    :cond_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v0, " in string ``"

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Ljavax/mail/internet/AddressException;->ref:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\'\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 126
    iget v1, p0, Ljavax/mail/internet/AddressException;->pos:I

    if-ltz v1, :cond_0

    .line 128
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v0, " at position "

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Ljavax/mail/internet/AddressException;->pos:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method
