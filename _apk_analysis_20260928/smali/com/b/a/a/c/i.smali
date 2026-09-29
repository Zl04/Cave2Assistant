.class public final Lcom/b/a/a/c/i;
.super Lcom/b/a/au;
.source "SourceFile"


# instance fields
.field private final a:Lcom/b/a/aa;

.field private final b:Lcom/b/b/h;


# direct methods
.method public constructor <init>(Lcom/b/a/aa;Lcom/b/b/h;)V
    .locals 0

    .prologue
    .line 27
    invoke-direct {p0}, Lcom/b/a/au;-><init>()V

    .line 28
    iput-object p1, p0, Lcom/b/a/a/c/i;->a:Lcom/b/a/aa;

    .line 29
    iput-object p2, p0, Lcom/b/a/a/c/i;->b:Lcom/b/b/h;

    .line 30
    return-void
.end method


# virtual methods
.method public final a()Lcom/b/a/ah;
    .locals 2

    .prologue
    .line 33
    iget-object v0, p0, Lcom/b/a/a/c/i;->a:Lcom/b/a/aa;

    const-string v1, "Content-Type"

    invoke-virtual {v0, v1}, Lcom/b/a/aa;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 34
    if-eqz v0, :cond_0

    invoke-static {v0}, Lcom/b/a/ah;->a(Ljava/lang/String;)Lcom/b/a/ah;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public final b()J
    .locals 2

    .prologue
    .line 38
    iget-object v0, p0, Lcom/b/a/a/c/i;->a:Lcom/b/a/aa;

    invoke-static {v0}, Lcom/b/a/a/c/f;->a(Lcom/b/a/aa;)J

    move-result-wide v0

    return-wide v0
.end method

.method public final c()Lcom/b/b/h;
    .locals 1

    .prologue
    .line 42
    iget-object v0, p0, Lcom/b/a/a/c/i;->b:Lcom/b/b/h;

    return-object v0
.end method
