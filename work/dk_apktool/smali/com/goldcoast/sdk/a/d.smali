.class public final Lcom/goldcoast/sdk/a/d;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field private a:Ljava/lang/String;

.field private b:I

.field private c:Ljava/lang/String;

.field private d:I

.field private e:Ljava/lang/String;

.field private f:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 15
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;ILjava/lang/String;ILjava/lang/String;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 18
    iput-object p1, p0, Lcom/goldcoast/sdk/a/d;->a:Ljava/lang/String;

    .line 19
    iput p2, p0, Lcom/goldcoast/sdk/a/d;->b:I

    .line 20
    iput-object p3, p0, Lcom/goldcoast/sdk/a/d;->c:Ljava/lang/String;

    .line 21
    iput p4, p0, Lcom/goldcoast/sdk/a/d;->d:I

    .line 22
    iput-object p5, p0, Lcom/goldcoast/sdk/a/d;->e:Ljava/lang/String;

    .line 23
    iput-object p6, p0, Lcom/goldcoast/sdk/a/d;->f:Ljava/lang/String;

    .line 24
    return-void
.end method


# virtual methods
.method public final a()Ljava/lang/String;
    .locals 1

    .prologue
    .line 27
    iget-object v0, p0, Lcom/goldcoast/sdk/a/d;->a:Ljava/lang/String;

    return-object v0
.end method

.method public final a(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 31
    iput-object p1, p0, Lcom/goldcoast/sdk/a/d;->a:Ljava/lang/String;

    .line 32
    return-void
.end method

.method public final b()Ljava/lang/String;
    .locals 1

    .prologue
    .line 35
    iget-object v0, p0, Lcom/goldcoast/sdk/a/d;->c:Ljava/lang/String;

    return-object v0
.end method

.method public final b(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 39
    iput-object p1, p0, Lcom/goldcoast/sdk/a/d;->c:Ljava/lang/String;

    .line 40
    return-void
.end method

.method public final c()I
    .locals 1

    .prologue
    .line 43
    iget v0, p0, Lcom/goldcoast/sdk/a/d;->b:I

    return v0
.end method

.method public final d()I
    .locals 1

    .prologue
    .line 53
    iget v0, p0, Lcom/goldcoast/sdk/a/d;->d:I

    return v0
.end method

.method public final e()Ljava/lang/String;
    .locals 1

    .prologue
    .line 61
    iget-object v0, p0, Lcom/goldcoast/sdk/a/d;->e:Ljava/lang/String;

    return-object v0
.end method

.method public final f()Ljava/lang/String;
    .locals 1

    .prologue
    .line 69
    iget-object v0, p0, Lcom/goldcoast/sdk/a/d;->f:Ljava/lang/String;

    return-object v0
.end method
