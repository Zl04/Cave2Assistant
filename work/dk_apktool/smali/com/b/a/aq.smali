.class public abstract Lcom/b/a/aq;
.super Ljava/lang/Object;
.source "SourceFile"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a([B)Lcom/b/a/aq;
    .locals 6

    .prologue
    .line 78
    array-length v0, p0

    .line 1084
    if-nez p0, :cond_0

    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "content == null"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1085
    :cond_0
    array-length v1, p0

    int-to-long v2, v1

    int-to-long v4, v0

    invoke-static {v2, v3, v4, v5}, Lcom/b/a/a/c;->a(JJ)V

    .line 1086
    new-instance v1, Lcom/b/a/ar;

    invoke-direct {v1, v0, p0}, Lcom/b/a/ar;-><init>(I[B)V

    .line 78
    return-object v1
.end method


# virtual methods
.method public abstract a()Lcom/b/a/ah;
.end method

.method public abstract a(Lcom/b/b/g;)V
.end method

.method public b()J
    .locals 2

    .prologue
    .line 36
    const-wide/16 v0, -0x1

    return-wide v0
.end method
