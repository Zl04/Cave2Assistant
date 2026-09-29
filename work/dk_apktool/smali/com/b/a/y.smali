.class public final Lcom/b/a/y;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field private final a:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private final b:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 104
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 105
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/b/a/y;->a:Ljava/util/List;

    .line 106
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/b/a/y;->b:Ljava/util/List;

    return-void
.end method


# virtual methods
.method public final a()Lcom/b/a/x;
    .locals 3

    .prologue
    .line 121
    new-instance v0, Lcom/b/a/x;

    iget-object v1, p0, Lcom/b/a/y;->a:Ljava/util/List;

    iget-object v2, p0, Lcom/b/a/y;->b:Ljava/util/List;

    invoke-direct {v0, v1, v2}, Lcom/b/a/x;-><init>(Ljava/util/List;Ljava/util/List;)V

    return-object v0
.end method

.method public final a(Ljava/lang/String;Ljava/lang/String;)Lcom/b/a/y;
    .locals 7

    .prologue
    const/4 v4, 0x1

    const/4 v2, 0x0

    .line 109
    iget-object v6, p0, Lcom/b/a/y;->a:Ljava/util/List;

    const-string v1, " \"\':;<=>@[]^`{}|/\\?#&!$(),~"

    move-object v0, p1

    move v3, v2

    move v5, v4

    invoke-static/range {v0 .. v5}, Lcom/b/a/ac;->a(Ljava/lang/String;Ljava/lang/String;ZZZZ)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v6, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 110
    iget-object v6, p0, Lcom/b/a/y;->b:Ljava/util/List;

    const-string v1, " \"\':;<=>@[]^`{}|/\\?#&!$(),~"

    move-object v0, p2

    move v3, v2

    move v5, v4

    invoke-static/range {v0 .. v5}, Lcom/b/a/ac;->a(Ljava/lang/String;Ljava/lang/String;ZZZZ)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v6, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 111
    return-object p0
.end method
