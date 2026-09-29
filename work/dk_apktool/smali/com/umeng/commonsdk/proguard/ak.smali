.class public abstract Lcom/umeng/commonsdk/proguard/ak;
.super Ljava/lang/Object;
.source "TUnion.java"

# interfaces
.implements Lcom/umeng/commonsdk/proguard/aa;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/umeng/commonsdk/proguard/ak$c;,
        Lcom/umeng/commonsdk/proguard/ak$d;,
        Lcom/umeng/commonsdk/proguard/ak$a;,
        Lcom/umeng/commonsdk/proguard/ak$b;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Lcom/umeng/commonsdk/proguard/ak",
        "<**>;F::",
        "Lcom/umeng/commonsdk/proguard/ah;",
        ">",
        "Ljava/lang/Object;",
        "Lcom/umeng/commonsdk/proguard/aa",
        "<TT;TF;>;"
    }
.end annotation


# static fields
.field private static final c:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/Class",
            "<+",
            "Lcom/umeng/commonsdk/proguard/bh;",
            ">;",
            "Lcom/umeng/commonsdk/proguard/bi;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field protected a:Ljava/lang/Object;

.field protected b:Lcom/umeng/commonsdk/proguard/ah;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "TF;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 49
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/umeng/commonsdk/proguard/ak;->c:Ljava/util/Map;

    .line 51
    sget-object v0, Lcom/umeng/commonsdk/proguard/ak;->c:Ljava/util/Map;

    const-class v1, Lcom/umeng/commonsdk/proguard/bj;

    new-instance v2, Lcom/umeng/commonsdk/proguard/ak$b;

    invoke-direct {v2, v3}, Lcom/umeng/commonsdk/proguard/ak$b;-><init>(Lcom/umeng/commonsdk/proguard/ak$1;)V

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 52
    sget-object v0, Lcom/umeng/commonsdk/proguard/ak;->c:Ljava/util/Map;

    const-class v1, Lcom/umeng/commonsdk/proguard/bk;

    new-instance v2, Lcom/umeng/commonsdk/proguard/ak$d;

    invoke-direct {v2, v3}, Lcom/umeng/commonsdk/proguard/ak$d;-><init>(Lcom/umeng/commonsdk/proguard/ak$1;)V

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 53
    return-void
.end method

.method protected constructor <init>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 44
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 45
    iput-object v0, p0, Lcom/umeng/commonsdk/proguard/ak;->b:Lcom/umeng/commonsdk/proguard/ah;

    .line 46
    iput-object v0, p0, Lcom/umeng/commonsdk/proguard/ak;->a:Ljava/lang/Object;

    .line 47
    return-void
.end method

.method protected constructor <init>(Lcom/umeng/commonsdk/proguard/ah;Ljava/lang/Object;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TF;",
            "Ljava/lang/Object;",
            ")V"
        }
    .end annotation

    .prologue
    .line 55
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 56
    invoke-virtual {p0, p1, p2}, Lcom/umeng/commonsdk/proguard/ak;->a(Lcom/umeng/commonsdk/proguard/ah;Ljava/lang/Object;)V

    .line 57
    return-void
.end method

.method protected constructor <init>(Lcom/umeng/commonsdk/proguard/ak;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/umeng/commonsdk/proguard/ak",
            "<TT;TF;>;)V"
        }
    .end annotation

    .prologue
    .line 59
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 60
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 61
    new-instance v0, Ljava/lang/ClassCastException;

    invoke-direct {v0}, Ljava/lang/ClassCastException;-><init>()V

    throw v0

    .line 63
    :cond_0
    iget-object v0, p1, Lcom/umeng/commonsdk/proguard/ak;->b:Lcom/umeng/commonsdk/proguard/ah;

    iput-object v0, p0, Lcom/umeng/commonsdk/proguard/ak;->b:Lcom/umeng/commonsdk/proguard/ah;

    .line 64
    iget-object v0, p1, Lcom/umeng/commonsdk/proguard/ak;->a:Ljava/lang/Object;

    invoke-static {v0}, Lcom/umeng/commonsdk/proguard/ak;->a(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/umeng/commonsdk/proguard/ak;->a:Ljava/lang/Object;

    .line 65
    return-void
.end method

.method private static a(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 68
    instance-of v0, p0, Lcom/umeng/commonsdk/proguard/aa;

    if-eqz v0, :cond_1

    .line 69
    check-cast p0, Lcom/umeng/commonsdk/proguard/aa;

    invoke-interface {p0}, Lcom/umeng/commonsdk/proguard/aa;->deepCopy()Lcom/umeng/commonsdk/proguard/aa;

    move-result-object p0

    .line 79
    :cond_0
    :goto_0
    return-object p0

    .line 70
    :cond_1
    instance-of v0, p0, Ljava/nio/ByteBuffer;

    if-eqz v0, :cond_2

    .line 71
    check-cast p0, Ljava/nio/ByteBuffer;

    invoke-static {p0}, Lcom/umeng/commonsdk/proguard/ab;->d(Ljava/nio/ByteBuffer;)Ljava/nio/ByteBuffer;

    move-result-object p0

    goto :goto_0

    .line 72
    :cond_2
    instance-of v0, p0, Ljava/util/List;

    if-eqz v0, :cond_3

    .line 73
    check-cast p0, Ljava/util/List;

    invoke-static {p0}, Lcom/umeng/commonsdk/proguard/ak;->a(Ljava/util/List;)Ljava/util/List;

    move-result-object p0

    goto :goto_0

    .line 74
    :cond_3
    instance-of v0, p0, Ljava/util/Set;

    if-eqz v0, :cond_4

    .line 75
    check-cast p0, Ljava/util/Set;

    invoke-static {p0}, Lcom/umeng/commonsdk/proguard/ak;->a(Ljava/util/Set;)Ljava/util/Set;

    move-result-object p0

    goto :goto_0

    .line 76
    :cond_4
    instance-of v0, p0, Ljava/util/Map;

    if-eqz v0, :cond_0

    .line 77
    check-cast p0, Ljava/util/Map;

    invoke-static {p0}, Lcom/umeng/commonsdk/proguard/ak;->a(Ljava/util/Map;)Ljava/util/Map;

    move-result-object p0

    goto :goto_0
.end method

.method private static a(Ljava/util/List;)Ljava/util/List;
    .locals 3

    .prologue
    .line 100
    new-instance v0, Ljava/util/ArrayList;

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    .line 101
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    .line 102
    invoke-static {v2}, Lcom/umeng/commonsdk/proguard/ak;->a(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 104
    :cond_0
    return-object v0
.end method

.method private static a(Ljava/util/Map;)Ljava/util/Map;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/Object;",
            "Ljava/lang/Object;",
            ">;)",
            "Ljava/util/Map;"
        }
    .end annotation

    .prologue
    .line 84
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    .line 85
    invoke-interface {p0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 86
    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v3

    invoke-static {v3}, Lcom/umeng/commonsdk/proguard/ak;->a(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/commonsdk/proguard/ak;->a(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    invoke-interface {v1, v3, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    .line 88
    :cond_0
    return-object v1
.end method

.method private static a(Ljava/util/Set;)Ljava/util/Set;
    .locals 3

    .prologue
    .line 92
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    .line 93
    invoke-interface {p0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    .line 94
    invoke-static {v2}, Lcom/umeng/commonsdk/proguard/ak;->a(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 96
    :cond_0
    return-object v0
.end method


# virtual methods
.method public a()Lcom/umeng/commonsdk/proguard/ah;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TF;"
        }
    .end annotation

    .prologue
    .line 108
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/ak;->b:Lcom/umeng/commonsdk/proguard/ah;

    return-object v0
.end method

.method protected abstract a(S)Lcom/umeng/commonsdk/proguard/ah;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(S)TF;"
        }
    .end annotation
.end method

.method public a(I)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 124
    int-to-short v0, p1

    invoke-virtual {p0, v0}, Lcom/umeng/commonsdk/proguard/ak;->a(S)Lcom/umeng/commonsdk/proguard/ah;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/umeng/commonsdk/proguard/ak;->a(Lcom/umeng/commonsdk/proguard/ah;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public a(Lcom/umeng/commonsdk/proguard/ah;)Ljava/lang/Object;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TF;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .prologue
    .line 116
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/ak;->b:Lcom/umeng/commonsdk/proguard/ah;

    if-eq p1, v0, :cond_0

    .line 117
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Cannot get the value of field "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " because union\'s set field is "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/umeng/commonsdk/proguard/ak;->b:Lcom/umeng/commonsdk/proguard/ah;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 120
    :cond_0
    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/ak;->b()Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method protected abstract a(Lcom/umeng/commonsdk/proguard/az;Lcom/umeng/commonsdk/proguard/au;)Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation
.end method

.method protected abstract a(Lcom/umeng/commonsdk/proguard/az;S)Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation
.end method

.method public a(ILjava/lang/Object;)V
    .locals 1

    .prologue
    .line 150
    int-to-short v0, p1

    invoke-virtual {p0, v0}, Lcom/umeng/commonsdk/proguard/ak;->a(S)Lcom/umeng/commonsdk/proguard/ah;

    move-result-object v0

    invoke-virtual {p0, v0, p2}, Lcom/umeng/commonsdk/proguard/ak;->a(Lcom/umeng/commonsdk/proguard/ah;Ljava/lang/Object;)V

    .line 151
    return-void
.end method

.method public a(Lcom/umeng/commonsdk/proguard/ah;Ljava/lang/Object;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TF;",
            "Ljava/lang/Object;",
            ")V"
        }
    .end annotation

    .prologue
    .line 144
    invoke-virtual {p0, p1, p2}, Lcom/umeng/commonsdk/proguard/ak;->b(Lcom/umeng/commonsdk/proguard/ah;Ljava/lang/Object;)V

    .line 145
    iput-object p1, p0, Lcom/umeng/commonsdk/proguard/ak;->b:Lcom/umeng/commonsdk/proguard/ah;

    .line 146
    iput-object p2, p0, Lcom/umeng/commonsdk/proguard/ak;->a:Ljava/lang/Object;

    .line 147
    return-void
.end method

.method protected abstract a(Lcom/umeng/commonsdk/proguard/az;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation
.end method

.method public b()Ljava/lang/Object;
    .locals 1

    .prologue
    .line 112
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/ak;->a:Ljava/lang/Object;

    return-object v0
.end method

.method protected abstract b(Lcom/umeng/commonsdk/proguard/ah;Ljava/lang/Object;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TF;",
            "Ljava/lang/Object;",
            ")V"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/ClassCastException;
        }
    .end annotation
.end method

.method protected abstract b(Lcom/umeng/commonsdk/proguard/az;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation
.end method

.method public b(I)Z
    .locals 1

    .prologue
    .line 136
    int-to-short v0, p1

    invoke-virtual {p0, v0}, Lcom/umeng/commonsdk/proguard/ak;->a(S)Lcom/umeng/commonsdk/proguard/ah;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/umeng/commonsdk/proguard/ak;->b(Lcom/umeng/commonsdk/proguard/ah;)Z

    move-result v0

    return v0
.end method

.method public b(Lcom/umeng/commonsdk/proguard/ah;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TF;)Z"
        }
    .end annotation

    .prologue
    .line 132
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/ak;->b:Lcom/umeng/commonsdk/proguard/ah;

    if-ne v0, p1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method protected abstract c(Lcom/umeng/commonsdk/proguard/ah;)Lcom/umeng/commonsdk/proguard/au;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TF;)",
            "Lcom/umeng/commonsdk/proguard/au;"
        }
    .end annotation
.end method

.method public c()Z
    .locals 1

    .prologue
    .line 128
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/ak;->b:Lcom/umeng/commonsdk/proguard/ah;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public final clear()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 205
    iput-object v0, p0, Lcom/umeng/commonsdk/proguard/ak;->b:Lcom/umeng/commonsdk/proguard/ah;

    .line 206
    iput-object v0, p0, Lcom/umeng/commonsdk/proguard/ak;->a:Ljava/lang/Object;

    .line 207
    return-void
.end method

.method protected abstract d()Lcom/umeng/commonsdk/proguard/be;
.end method

.method public read(Lcom/umeng/commonsdk/proguard/az;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    .line 140
    sget-object v0, Lcom/umeng/commonsdk/proguard/ak;->c:Ljava/util/Map;

    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->D()Ljava/lang/Class;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/umeng/commonsdk/proguard/bi;

    invoke-interface {v0}, Lcom/umeng/commonsdk/proguard/bi;->b()Lcom/umeng/commonsdk/proguard/bh;

    move-result-object v0

    invoke-interface {v0, p1, p0}, Lcom/umeng/commonsdk/proguard/bh;->b(Lcom/umeng/commonsdk/proguard/az;Lcom/umeng/commonsdk/proguard/aa;)V

    .line 141
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .prologue
    .line 185
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 186
    const-string v0, "<"

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 187
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 188
    const-string v0, " "

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 190
    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/ak;->a()Lcom/umeng/commonsdk/proguard/ah;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 191
    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/ak;->b()Ljava/lang/Object;

    move-result-object v0

    .line 192
    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/ak;->a()Lcom/umeng/commonsdk/proguard/ah;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/umeng/commonsdk/proguard/ak;->c(Lcom/umeng/commonsdk/proguard/ah;)Lcom/umeng/commonsdk/proguard/au;

    move-result-object v2

    iget-object v2, v2, Lcom/umeng/commonsdk/proguard/au;->a:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 193
    const-string v2, ":"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 194
    instance-of v2, v0, Ljava/nio/ByteBuffer;

    if-eqz v2, :cond_1

    .line 195
    check-cast v0, Ljava/nio/ByteBuffer;

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/proguard/ab;->a(Ljava/nio/ByteBuffer;Ljava/lang/StringBuilder;)V

    .line 200
    :cond_0
    :goto_0
    const-string v0, ">"

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 201
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 197
    :cond_1
    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0
.end method

.method public write(Lcom/umeng/commonsdk/proguard/az;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    .line 154
    sget-object v0, Lcom/umeng/commonsdk/proguard/ak;->c:Ljava/util/Map;

    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->D()Ljava/lang/Class;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/umeng/commonsdk/proguard/bi;

    invoke-interface {v0}, Lcom/umeng/commonsdk/proguard/bi;->b()Lcom/umeng/commonsdk/proguard/bh;

    move-result-object v0

    invoke-interface {v0, p1, p0}, Lcom/umeng/commonsdk/proguard/bh;->a(Lcom/umeng/commonsdk/proguard/az;Lcom/umeng/commonsdk/proguard/aa;)V

    .line 155
    return-void
.end method
