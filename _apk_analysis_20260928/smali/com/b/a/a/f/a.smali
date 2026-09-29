.class public interface abstract Lcom/b/a/a/f/a;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static final a:Lcom/b/a/a/f/a;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 42
    new-instance v0, Lcom/b/a/a/f/b;

    invoke-direct {v0}, Lcom/b/a/a/f/b;-><init>()V

    sput-object v0, Lcom/b/a/a/f/a;->a:Lcom/b/a/a/f/a;

    return-void
.end method


# virtual methods
.method public abstract a(Ljava/io/File;)V
.end method
