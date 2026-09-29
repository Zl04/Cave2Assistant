.class final Lcom/b/a/av;
.super Lcom/b/a/au;
.source "SourceFile"


# instance fields
.field final synthetic a:Lcom/b/a/ah;

.field final synthetic b:J

.field final synthetic c:Lcom/b/b/h;


# direct methods
.method constructor <init>(JLcom/b/b/h;)V
    .locals 1

    .prologue
    .line 216
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/b/a/av;->a:Lcom/b/a/ah;

    iput-wide p1, p0, Lcom/b/a/av;->b:J

    iput-object p3, p0, Lcom/b/a/av;->c:Lcom/b/b/h;

    invoke-direct {p0}, Lcom/b/a/au;-><init>()V

    return-void
.end method


# virtual methods
.method public final a()Lcom/b/a/ah;
    .locals 1

    .prologue
    .line 218
    iget-object v0, p0, Lcom/b/a/av;->a:Lcom/b/a/ah;

    return-object v0
.end method

.method public final b()J
    .locals 2

    .prologue
    .line 222
    iget-wide v0, p0, Lcom/b/a/av;->b:J

    return-wide v0
.end method

.method public final c()Lcom/b/b/h;
    .locals 1

    .prologue
    .line 226
    iget-object v0, p0, Lcom/b/a/av;->c:Lcom/b/b/h;

    return-object v0
.end method
