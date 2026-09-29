.class public final enum Lcom/b/a/ax;
.super Ljava/lang/Enum;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/b/a/ax;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum a:Lcom/b/a/ax;

.field public static final enum b:Lcom/b/a/ax;

.field public static final enum c:Lcom/b/a/ax;

.field public static final enum d:Lcom/b/a/ax;

.field public static final enum e:Lcom/b/a/ax;

.field private static final synthetic g:[Lcom/b/a/ax;


# instance fields
.field final f:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 8

    .prologue
    const/4 v7, 0x4

    const/4 v6, 0x3

    const/4 v5, 0x2

    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 23
    new-instance v0, Lcom/b/a/ax;

    const-string v1, "TLS_1_3"

    const-string v2, "TLSv1.3"

    invoke-direct {v0, v1, v3, v2}, Lcom/b/a/ax;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/b/a/ax;->a:Lcom/b/a/ax;

    .line 24
    new-instance v0, Lcom/b/a/ax;

    const-string v1, "TLS_1_2"

    const-string v2, "TLSv1.2"

    invoke-direct {v0, v1, v4, v2}, Lcom/b/a/ax;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/b/a/ax;->b:Lcom/b/a/ax;

    .line 25
    new-instance v0, Lcom/b/a/ax;

    const-string v1, "TLS_1_1"

    const-string v2, "TLSv1.1"

    invoke-direct {v0, v1, v5, v2}, Lcom/b/a/ax;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/b/a/ax;->c:Lcom/b/a/ax;

    .line 26
    new-instance v0, Lcom/b/a/ax;

    const-string v1, "TLS_1_0"

    const-string v2, "TLSv1"

    invoke-direct {v0, v1, v6, v2}, Lcom/b/a/ax;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/b/a/ax;->d:Lcom/b/a/ax;

    .line 27
    new-instance v0, Lcom/b/a/ax;

    const-string v1, "SSL_3_0"

    const-string v2, "SSLv3"

    invoke-direct {v0, v1, v7, v2}, Lcom/b/a/ax;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/b/a/ax;->e:Lcom/b/a/ax;

    .line 22
    const/4 v0, 0x5

    new-array v0, v0, [Lcom/b/a/ax;

    sget-object v1, Lcom/b/a/ax;->a:Lcom/b/a/ax;

    aput-object v1, v0, v3

    sget-object v1, Lcom/b/a/ax;->b:Lcom/b/a/ax;

    aput-object v1, v0, v4

    sget-object v1, Lcom/b/a/ax;->c:Lcom/b/a/ax;

    aput-object v1, v0, v5

    sget-object v1, Lcom/b/a/ax;->d:Lcom/b/a/ax;

    aput-object v1, v0, v6

    sget-object v1, Lcom/b/a/ax;->e:Lcom/b/a/ax;

    aput-object v1, v0, v7

    sput-object v0, Lcom/b/a/ax;->g:[Lcom/b/a/ax;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;ILjava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .prologue
    .line 32
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 33
    iput-object p3, p0, Lcom/b/a/ax;->f:Ljava/lang/String;

    .line 34
    return-void
.end method

.method public static a(Ljava/lang/String;)Lcom/b/a/ax;
    .locals 3

    .prologue
    .line 37
    const/4 v0, -0x1

    invoke-virtual {p0}, Ljava/lang/String;->hashCode()I

    move-result v1

    sparse-switch v1, :sswitch_data_0

    :cond_0
    :goto_0
    packed-switch v0, :pswitch_data_0

    .line 49
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Unexpected TLS version: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 37
    :sswitch_0
    const-string v1, "TLSv1.3"

    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    :sswitch_1
    const-string v1, "TLSv1.2"

    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :sswitch_2
    const-string v1, "TLSv1.1"

    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v0, 0x2

    goto :goto_0

    :sswitch_3
    const-string v1, "TLSv1"

    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v0, 0x3

    goto :goto_0

    :sswitch_4
    const-string v1, "SSLv3"

    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v0, 0x4

    goto :goto_0

    .line 39
    :pswitch_0
    sget-object v0, Lcom/b/a/ax;->a:Lcom/b/a/ax;

    .line 47
    :goto_1
    return-object v0

    .line 41
    :pswitch_1
    sget-object v0, Lcom/b/a/ax;->b:Lcom/b/a/ax;

    goto :goto_1

    .line 43
    :pswitch_2
    sget-object v0, Lcom/b/a/ax;->c:Lcom/b/a/ax;

    goto :goto_1

    .line 45
    :pswitch_3
    sget-object v0, Lcom/b/a/ax;->d:Lcom/b/a/ax;

    goto :goto_1

    .line 47
    :pswitch_4
    sget-object v0, Lcom/b/a/ax;->e:Lcom/b/a/ax;

    goto :goto_1

    .line 37
    nop

    :sswitch_data_0
    .sparse-switch
        -0x1dfc3f27 -> :sswitch_2
        -0x1dfc3f26 -> :sswitch_1
        -0x1dfc3f25 -> :sswitch_0
        0x4b88569 -> :sswitch_4
        0x4c38896 -> :sswitch_3
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
    .end packed-switch
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/b/a/ax;
    .locals 1

    .prologue
    .line 22
    const-class v0, Lcom/b/a/ax;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/b/a/ax;

    return-object v0
.end method

.method public static values()[Lcom/b/a/ax;
    .locals 1

    .prologue
    .line 22
    sget-object v0, Lcom/b/a/ax;->g:[Lcom/b/a/ax;

    invoke-virtual {v0}, [Lcom/b/a/ax;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/b/a/ax;

    return-object v0
.end method
