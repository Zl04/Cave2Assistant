.class public interface abstract Lcom/b/a/b;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static final a:Lcom/b/a/b;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 63
    new-instance v0, Lcom/b/a/c;

    invoke-direct {v0}, Lcom/b/a/c;-><init>()V

    sput-object v0, Lcom/b/a/b;->a:Lcom/b/a/b;

    return-void
.end method


# virtual methods
.method public abstract a()Lcom/b/a/ao;
.end method
