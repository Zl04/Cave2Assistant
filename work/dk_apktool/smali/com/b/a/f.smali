.class public final Lcom/b/a/f;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field a:Z

.field b:Z

.field c:I

.field d:I

.field e:I

.field f:Z

.field g:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    const/4 v0, -0x1

    .line 265
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 268
    iput v0, p0, Lcom/b/a/f;->c:I

    .line 269
    iput v0, p0, Lcom/b/a/f;->d:I

    .line 270
    iput v0, p0, Lcom/b/a/f;->e:I

    return-void
.end method


# virtual methods
.method public final a()Lcom/b/a/e;
    .locals 1

    .prologue
    .line 351
    new-instance v0, Lcom/b/a/e;

    invoke-direct {v0, p0}, Lcom/b/a/e;-><init>(Lcom/b/a/f;)V

    return-object v0
.end method
