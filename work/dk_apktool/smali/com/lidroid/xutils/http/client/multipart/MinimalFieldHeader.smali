.class Lcom/lidroid/xutils/http/client/multipart/MinimalFieldHeader;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Iterable;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/lang/Iterable",
        "<",
        "Lcom/lidroid/xutils/http/client/multipart/MinimalField;",
        ">;"
    }
.end annotation


# instance fields
.field private final fieldMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/util/List",
            "<",
            "Lcom/lidroid/xutils/http/client/multipart/MinimalField;",
            ">;>;"
        }
    .end annotation
.end field

.field private final fields:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/lidroid/xutils/http/client/multipart/MinimalField;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 30
    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    iput-object v0, p0, Lcom/lidroid/xutils/http/client/multipart/MinimalFieldHeader;->fields:Ljava/util/List;

    .line 31
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/lidroid/xutils/http/client/multipart/MinimalFieldHeader;->fieldMap:Ljava/util/Map;

    .line 32
    return-void
.end method


# virtual methods
.method public addField(Lcom/lidroid/xutils/http/client/multipart/MinimalField;)V
    .locals 3

    .prologue
    .line 35
    if-nez p1, :cond_0

    .line 46
    :goto_0
    return-void

    .line 38
    :cond_0
    invoke-virtual {p1}, Lcom/lidroid/xutils/http/client/multipart/MinimalField;->getName()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    .line 39
    iget-object v0, p0, Lcom/lidroid/xutils/http/client/multipart/MinimalFieldHeader;->fieldMap:Ljava/util/Map;

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/List;

    .line 40
    if-nez v0, :cond_1

    .line 41
    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    .line 42
    iget-object v2, p0, Lcom/lidroid/xutils/http/client/multipart/MinimalFieldHeader;->fieldMap:Ljava/util/Map;

    invoke-interface {v2, v1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 44
    :cond_1
    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 45
    iget-object v0, p0, Lcom/lidroid/xutils/http/client/multipart/MinimalFieldHeader;->fields:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0
.end method

.method public getField(Ljava/lang/String;)Lcom/lidroid/xutils/http/client/multipart/MinimalField;
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 53
    if-nez p1, :cond_0

    move-object v0, v1

    .line 61
    :goto_0
    return-object v0

    .line 56
    :cond_0
    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {p1, v0}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    .line 57
    iget-object v2, p0, Lcom/lidroid/xutils/http/client/multipart/MinimalFieldHeader;->fieldMap:Ljava/util/Map;

    invoke-interface {v2, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/List;

    .line 58
    if-eqz v0, :cond_1

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_1

    .line 59
    const/4 v1, 0x0

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lidroid/xutils/http/client/multipart/MinimalField;

    goto :goto_0

    :cond_1
    move-object v0, v1

    .line 61
    goto :goto_0
.end method

.method public getFields()Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/lidroid/xutils/http/client/multipart/MinimalField;",
            ">;"
        }
    .end annotation

    .prologue
    .line 49
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/lidroid/xutils/http/client/multipart/MinimalFieldHeader;->fields:Ljava/util/List;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    return-object v0
.end method

.method public getFields(Ljava/lang/String;)Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List",
            "<",
            "Lcom/lidroid/xutils/http/client/multipart/MinimalField;",
            ">;"
        }
    .end annotation

    .prologue
    .line 65
    if-nez p1, :cond_0

    .line 66
    const/4 v0, 0x0

    .line 73
    :goto_0
    return-object v0

    .line 68
    :cond_0
    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {p1, v0}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    .line 69
    iget-object v1, p0, Lcom/lidroid/xutils/http/client/multipart/MinimalFieldHeader;->fieldMap:Ljava/util/Map;

    invoke-interface {v1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/List;

    .line 70
    if-eqz v0, :cond_1

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 71
    :cond_1
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    goto :goto_0

    .line 73
    :cond_2
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1, v0}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    move-object v0, v1

    goto :goto_0
.end method

.method public iterator()Ljava/util/Iterator;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Iterator",
            "<",
            "Lcom/lidroid/xutils/http/client/multipart/MinimalField;",
            ">;"
        }
    .end annotation

    .prologue
    .line 117
    iget-object v0, p0, Lcom/lidroid/xutils/http/client/multipart/MinimalFieldHeader;->fields:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    return-object v0
.end method

.method public removeFields(Ljava/lang/String;)I
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 78
    if-nez p1, :cond_0

    move v0, v1

    .line 87
    :goto_0
    return v0

    .line 81
    :cond_0
    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {p1, v0}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    .line 82
    iget-object v2, p0, Lcom/lidroid/xutils/http/client/multipart/MinimalFieldHeader;->fieldMap:Ljava/util/Map;

    invoke-interface {v2, v0}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/List;

    .line 83
    if-eqz v0, :cond_1

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_2

    :cond_1
    move v0, v1

    .line 84
    goto :goto_0

    .line 86
    :cond_2
    iget-object v1, p0, Lcom/lidroid/xutils/http/client/multipart/MinimalFieldHeader;->fields:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->removeAll(Ljava/util/Collection;)Z

    .line 87
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    goto :goto_0
.end method

.method public setField(Lcom/lidroid/xutils/http/client/multipart/MinimalField;)V
    .locals 6

    .prologue
    const/4 v3, -0x1

    .line 91
    if-nez p1, :cond_0

    .line 114
    :goto_0
    return-void

    .line 94
    :cond_0
    invoke-virtual {p1}, Lcom/lidroid/xutils/http/client/multipart/MinimalField;->getName()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    .line 95
    iget-object v1, p0, Lcom/lidroid/xutils/http/client/multipart/MinimalFieldHeader;->fieldMap:Ljava/util/Map;

    invoke-interface {v1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/List;

    .line 96
    if-eqz v0, :cond_1

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 97
    :cond_1
    invoke-virtual {p0, p1}, Lcom/lidroid/xutils/http/client/multipart/MinimalFieldHeader;->addField(Lcom/lidroid/xutils/http/client/multipart/MinimalField;)V

    goto :goto_0

    .line 100
    :cond_2
    invoke-interface {v0}, Ljava/util/List;->clear()V

    .line 101
    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 103
    const/4 v0, 0x0

    .line 104
    iget-object v1, p0, Lcom/lidroid/xutils/http/client/multipart/MinimalFieldHeader;->fields:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    move v1, v0

    move v2, v3

    :goto_1
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_3

    .line 113
    iget-object v0, p0, Lcom/lidroid/xutils/http/client/multipart/MinimalFieldHeader;->fields:Ljava/util/List;

    invoke-interface {v0, v2, p1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    goto :goto_0

    .line 105
    :cond_3
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lidroid/xutils/http/client/multipart/MinimalField;

    .line 106
    invoke-virtual {v0}, Lcom/lidroid/xutils/http/client/multipart/MinimalField;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lcom/lidroid/xutils/http/client/multipart/MinimalField;->getName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v0, v5}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 107
    invoke-interface {v4}, Ljava/util/Iterator;->remove()V

    .line 108
    if-ne v2, v3, :cond_4

    move v2, v1

    .line 104
    :cond_4
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_1
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    .prologue
    .line 122
    iget-object v0, p0, Lcom/lidroid/xutils/http/client/multipart/MinimalFieldHeader;->fields:Ljava/util/List;

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
