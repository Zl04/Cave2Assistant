.class public final Lcom/b/a/a/e/c;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static final a:Lcom/b/b/i;

.field public static final b:Lcom/b/b/i;

.field public static final c:Lcom/b/b/i;

.field public static final d:Lcom/b/b/i;

.field public static final e:Lcom/b/b/i;

.field public static final f:Lcom/b/b/i;


# instance fields
.field public final g:Lcom/b/b/i;

.field public final h:Lcom/b/b/i;

.field final i:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 24
    const-string v0, ":"

    invoke-static {v0}, Lcom/b/b/i;->a(Ljava/lang/String;)Lcom/b/b/i;

    move-result-object v0

    sput-object v0, Lcom/b/a/a/e/c;->a:Lcom/b/b/i;

    .line 25
    const-string v0, ":status"

    invoke-static {v0}, Lcom/b/b/i;->a(Ljava/lang/String;)Lcom/b/b/i;

    move-result-object v0

    sput-object v0, Lcom/b/a/a/e/c;->b:Lcom/b/b/i;

    .line 26
    const-string v0, ":method"

    invoke-static {v0}, Lcom/b/b/i;->a(Ljava/lang/String;)Lcom/b/b/i;

    move-result-object v0

    sput-object v0, Lcom/b/a/a/e/c;->c:Lcom/b/b/i;

    .line 27
    const-string v0, ":path"

    invoke-static {v0}, Lcom/b/b/i;->a(Ljava/lang/String;)Lcom/b/b/i;

    move-result-object v0

    sput-object v0, Lcom/b/a/a/e/c;->d:Lcom/b/b/i;

    .line 28
    const-string v0, ":scheme"

    invoke-static {v0}, Lcom/b/b/i;->a(Ljava/lang/String;)Lcom/b/b/i;

    move-result-object v0

    sput-object v0, Lcom/b/a/a/e/c;->e:Lcom/b/b/i;

    .line 29
    const-string v0, ":authority"

    invoke-static {v0}, Lcom/b/b/i;->a(Ljava/lang/String;)Lcom/b/b/i;

    move-result-object v0

    sput-object v0, Lcom/b/a/a/e/c;->f:Lcom/b/b/i;

    return-void
.end method

.method public constructor <init>(Lcom/b/b/i;Lcom/b/b/i;)V
    .locals 2

    .prologue
    .line 46
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 47
    iput-object p1, p0, Lcom/b/a/a/e/c;->g:Lcom/b/b/i;

    .line 48
    iput-object p2, p0, Lcom/b/a/a/e/c;->h:Lcom/b/b/i;

    .line 49
    invoke-virtual {p1}, Lcom/b/b/i;->g()I

    move-result v0

    add-int/lit8 v0, v0, 0x20

    invoke-virtual {p2}, Lcom/b/b/i;->g()I

    move-result v1

    add-int/2addr v0, v1

    iput v0, p0, Lcom/b/a/a/e/c;->i:I

    .line 50
    return-void
.end method

.method public constructor <init>(Lcom/b/b/i;Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 43
    invoke-static {p2}, Lcom/b/b/i;->a(Ljava/lang/String;)Lcom/b/b/i;

    move-result-object v0

    invoke-direct {p0, p1, v0}, Lcom/b/a/a/e/c;-><init>(Lcom/b/b/i;Lcom/b/b/i;)V

    .line 44
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 39
    invoke-static {p1}, Lcom/b/b/i;->a(Ljava/lang/String;)Lcom/b/b/i;

    move-result-object v0

    invoke-static {p2}, Lcom/b/b/i;->a(Ljava/lang/String;)Lcom/b/b/i;

    move-result-object v1

    invoke-direct {p0, v0, v1}, Lcom/b/a/a/e/c;-><init>(Lcom/b/b/i;Lcom/b/b/i;)V

    .line 40
    return-void
.end method


# virtual methods
.method public final equals(Ljava/lang/Object;)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 53
    instance-of v1, p1, Lcom/b/a/a/e/c;

    if-eqz v1, :cond_0

    .line 54
    check-cast p1, Lcom/b/a/a/e/c;

    .line 55
    iget-object v1, p0, Lcom/b/a/a/e/c;->g:Lcom/b/b/i;

    iget-object v2, p1, Lcom/b/a/a/e/c;->g:Lcom/b/b/i;

    invoke-virtual {v1, v2}, Lcom/b/b/i;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/b/a/a/e/c;->h:Lcom/b/b/i;

    iget-object v2, p1, Lcom/b/a/a/e/c;->h:Lcom/b/b/i;

    .line 56
    invoke-virtual {v1, v2}, Lcom/b/b/i;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    .line 58
    :cond_0
    return v0
.end method

.method public final hashCode()I
    .locals 2

    .prologue
    .line 63
    iget-object v0, p0, Lcom/b/a/a/e/c;->g:Lcom/b/b/i;

    invoke-virtual {v0}, Lcom/b/b/i;->hashCode()I

    move-result v0

    add-int/lit16 v0, v0, 0x20f

    .line 64
    mul-int/lit8 v0, v0, 0x1f

    iget-object v1, p0, Lcom/b/a/a/e/c;->h:Lcom/b/b/i;

    invoke-virtual {v1}, Lcom/b/b/i;->hashCode()I

    move-result v1

    add-int/2addr v0, v1

    .line 65
    return v0
.end method

.method public final toString()Ljava/lang/String;
    .locals 4

    .prologue
    .line 69
    const-string v0, "%s: %s"

    const/4 v1, 0x2

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    iget-object v3, p0, Lcom/b/a/a/e/c;->g:Lcom/b/b/i;

    invoke-virtual {v3}, Lcom/b/b/i;->a()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v2

    const/4 v2, 0x1

    iget-object v3, p0, Lcom/b/a/a/e/c;->h:Lcom/b/b/i;

    invoke-virtual {v3}, Lcom/b/b/i;->a()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-static {v0, v1}, Lcom/b/a/a/c;->a(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
