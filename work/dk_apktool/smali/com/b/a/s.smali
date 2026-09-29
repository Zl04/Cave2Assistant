.class public interface abstract Lcom/b/a/s;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static final a:Lcom/b/a/s;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 36
    new-instance v0, Lcom/b/a/t;

    invoke-direct {v0}, Lcom/b/a/t;-><init>()V

    sput-object v0, Lcom/b/a/s;->a:Lcom/b/a/s;

    return-void
.end method


# virtual methods
.method public abstract a()V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation
.end method

.method public abstract b()Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/b/a/r;",
            ">;"
        }
    .end annotation
.end method
