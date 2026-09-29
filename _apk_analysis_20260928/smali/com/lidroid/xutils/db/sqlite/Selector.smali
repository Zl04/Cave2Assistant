.class public Lcom/lidroid/xutils/db/sqlite/Selector;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lidroid/xutils/db/sqlite/Selector$OrderBy;
    }
.end annotation


# instance fields
.field protected entityType:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class",
            "<*>;"
        }
    .end annotation
.end field

.field protected limit:I

.field protected offset:I

.field protected orderByList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/lidroid/xutils/db/sqlite/Selector$OrderBy;",
            ">;"
        }
    .end annotation
.end field

.field protected tableName:Ljava/lang/String;

.field protected whereBuilder:Lcom/lidroid/xutils/db/sqlite/WhereBuilder;


# direct methods
.method private constructor <init>(Ljava/lang/Class;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class",
            "<*>;)V"
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    .line 38
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 35
    iput v0, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->limit:I

    .line 36
    iput v0, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->offset:I

    .line 39
    iput-object p1, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->entityType:Ljava/lang/Class;

    .line 40
    invoke-static {p1}, Lcom/lidroid/xutils/db/table/TableUtils;->getTableName(Ljava/lang/Class;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->tableName:Ljava/lang/String;

    .line 41
    return-void
.end method

.method public static from(Ljava/lang/Class;)Lcom/lidroid/xutils/db/sqlite/Selector;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class",
            "<*>;)",
            "Lcom/lidroid/xutils/db/sqlite/Selector;"
        }
    .end annotation

    .prologue
    .line 44
    new-instance v0, Lcom/lidroid/xutils/db/sqlite/Selector;

    invoke-direct {v0, p0}, Lcom/lidroid/xutils/db/sqlite/Selector;-><init>(Ljava/lang/Class;)V

    return-object v0
.end method


# virtual methods
.method public and(Lcom/lidroid/xutils/db/sqlite/WhereBuilder;)Lcom/lidroid/xutils/db/sqlite/Selector;
    .locals 3

    .prologue
    .line 63
    iget-object v0, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->whereBuilder:Lcom/lidroid/xutils/db/sqlite/WhereBuilder;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "AND ("

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->expr(Ljava/lang/String;)Lcom/lidroid/xutils/db/sqlite/WhereBuilder;

    .line 64
    return-object p0
.end method

.method public and(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)Lcom/lidroid/xutils/db/sqlite/Selector;
    .locals 1

    .prologue
    .line 58
    iget-object v0, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->whereBuilder:Lcom/lidroid/xutils/db/sqlite/WhereBuilder;

    invoke-virtual {v0, p1, p2, p3}, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->and(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)Lcom/lidroid/xutils/db/sqlite/WhereBuilder;

    .line 59
    return-object p0
.end method

.method public expr(Ljava/lang/String;)Lcom/lidroid/xutils/db/sqlite/Selector;
    .locals 1

    .prologue
    .line 78
    iget-object v0, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->whereBuilder:Lcom/lidroid/xutils/db/sqlite/WhereBuilder;

    if-nez v0, :cond_0

    .line 79
    invoke-static {}, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->b()Lcom/lidroid/xutils/db/sqlite/WhereBuilder;

    move-result-object v0

    iput-object v0, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->whereBuilder:Lcom/lidroid/xutils/db/sqlite/WhereBuilder;

    .line 81
    :cond_0
    iget-object v0, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->whereBuilder:Lcom/lidroid/xutils/db/sqlite/WhereBuilder;

    invoke-virtual {v0, p1}, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->expr(Ljava/lang/String;)Lcom/lidroid/xutils/db/sqlite/WhereBuilder;

    .line 82
    return-object p0
.end method

.method public expr(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)Lcom/lidroid/xutils/db/sqlite/Selector;
    .locals 1

    .prologue
    .line 86
    iget-object v0, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->whereBuilder:Lcom/lidroid/xutils/db/sqlite/WhereBuilder;

    if-nez v0, :cond_0

    .line 87
    invoke-static {}, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->b()Lcom/lidroid/xutils/db/sqlite/WhereBuilder;

    move-result-object v0

    iput-object v0, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->whereBuilder:Lcom/lidroid/xutils/db/sqlite/WhereBuilder;

    .line 89
    :cond_0
    iget-object v0, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->whereBuilder:Lcom/lidroid/xutils/db/sqlite/WhereBuilder;

    invoke-virtual {v0, p1, p2, p3}, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->expr(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)Lcom/lidroid/xutils/db/sqlite/WhereBuilder;

    .line 90
    return-object p0
.end method

.method public getEntityType()Ljava/lang/Class;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/lang/Class",
            "<*>;"
        }
    .end annotation

    .prologue
    .line 149
    iget-object v0, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->entityType:Ljava/lang/Class;

    return-object v0
.end method

.method public groupBy(Ljava/lang/String;)Lcom/lidroid/xutils/db/sqlite/DbModelSelector;
    .locals 1

    .prologue
    .line 94
    new-instance v0, Lcom/lidroid/xutils/db/sqlite/DbModelSelector;

    invoke-direct {v0, p0, p1}, Lcom/lidroid/xutils/db/sqlite/DbModelSelector;-><init>(Lcom/lidroid/xutils/db/sqlite/Selector;Ljava/lang/String;)V

    return-object v0
.end method

.method public limit(I)Lcom/lidroid/xutils/db/sqlite/Selector;
    .locals 0

    .prologue
    .line 118
    iput p1, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->limit:I

    .line 119
    return-object p0
.end method

.method public offset(I)Lcom/lidroid/xutils/db/sqlite/Selector;
    .locals 0

    .prologue
    .line 123
    iput p1, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->offset:I

    .line 124
    return-object p0
.end method

.method public or(Lcom/lidroid/xutils/db/sqlite/WhereBuilder;)Lcom/lidroid/xutils/db/sqlite/Selector;
    .locals 3

    .prologue
    .line 73
    iget-object v0, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->whereBuilder:Lcom/lidroid/xutils/db/sqlite/WhereBuilder;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "OR ("

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->expr(Ljava/lang/String;)Lcom/lidroid/xutils/db/sqlite/WhereBuilder;

    .line 74
    return-object p0
.end method

.method public or(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)Lcom/lidroid/xutils/db/sqlite/Selector;
    .locals 1

    .prologue
    .line 68
    iget-object v0, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->whereBuilder:Lcom/lidroid/xutils/db/sqlite/WhereBuilder;

    invoke-virtual {v0, p1, p2, p3}, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->or(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)Lcom/lidroid/xutils/db/sqlite/WhereBuilder;

    .line 69
    return-object p0
.end method

.method public orderBy(Ljava/lang/String;)Lcom/lidroid/xutils/db/sqlite/Selector;
    .locals 2

    .prologue
    .line 102
    iget-object v0, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->orderByList:Ljava/util/List;

    if-nez v0, :cond_0

    .line 103
    new-instance v0, Ljava/util/ArrayList;

    const/4 v1, 0x2

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->orderByList:Ljava/util/List;

    .line 105
    :cond_0
    iget-object v0, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->orderByList:Ljava/util/List;

    new-instance v1, Lcom/lidroid/xutils/db/sqlite/Selector$OrderBy;

    invoke-direct {v1, p0, p1}, Lcom/lidroid/xutils/db/sqlite/Selector$OrderBy;-><init>(Lcom/lidroid/xutils/db/sqlite/Selector;Ljava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 106
    return-object p0
.end method

.method public orderBy(Ljava/lang/String;Z)Lcom/lidroid/xutils/db/sqlite/Selector;
    .locals 2

    .prologue
    .line 110
    iget-object v0, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->orderByList:Ljava/util/List;

    if-nez v0, :cond_0

    .line 111
    new-instance v0, Ljava/util/ArrayList;

    const/4 v1, 0x2

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->orderByList:Ljava/util/List;

    .line 113
    :cond_0
    iget-object v0, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->orderByList:Ljava/util/List;

    new-instance v1, Lcom/lidroid/xutils/db/sqlite/Selector$OrderBy;

    invoke-direct {v1, p0, p1, p2}, Lcom/lidroid/xutils/db/sqlite/Selector$OrderBy;-><init>(Lcom/lidroid/xutils/db/sqlite/Selector;Ljava/lang/String;Z)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 114
    return-object p0
.end method

.method public varargs select([Ljava/lang/String;)Lcom/lidroid/xutils/db/sqlite/DbModelSelector;
    .locals 1

    .prologue
    .line 98
    new-instance v0, Lcom/lidroid/xutils/db/sqlite/DbModelSelector;

    invoke-direct {v0, p0, p1}, Lcom/lidroid/xutils/db/sqlite/DbModelSelector;-><init>(Lcom/lidroid/xutils/db/sqlite/Selector;[Ljava/lang/String;)V

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .prologue
    .line 129
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    .line 130
    const-string v0, "SELECT "

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 131
    const-string v0, "*"

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 132
    const-string v0, " FROM "

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->tableName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 133
    iget-object v0, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->whereBuilder:Lcom/lidroid/xutils/db/sqlite/WhereBuilder;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->whereBuilder:Lcom/lidroid/xutils/db/sqlite/WhereBuilder;

    invoke-virtual {v0}, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->getWhereItemSize()I

    move-result v0

    if-lez v0, :cond_0

    .line 134
    const-string v0, " WHERE "

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->whereBuilder:Lcom/lidroid/xutils/db/sqlite/WhereBuilder;

    invoke-virtual {v1}, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 136
    :cond_0
    iget-object v0, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->orderByList:Ljava/util/List;

    if-eqz v0, :cond_1

    .line 137
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    iget-object v0, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->orderByList:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lt v1, v0, :cond_3

    .line 141
    :cond_1
    iget v0, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->limit:I

    if-lez v0, :cond_2

    .line 142
    const-string v0, " LIMIT "

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->limit:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 143
    const-string v0, " OFFSET "

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->offset:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 145
    :cond_2
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 138
    :cond_3
    const-string v0, " ORDER BY "

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v0, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->orderByList:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lidroid/xutils/db/sqlite/Selector$OrderBy;

    invoke-virtual {v0}, Lcom/lidroid/xutils/db/sqlite/Selector$OrderBy;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 137
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0
.end method

.method public where(Lcom/lidroid/xutils/db/sqlite/WhereBuilder;)Lcom/lidroid/xutils/db/sqlite/Selector;
    .locals 0

    .prologue
    .line 48
    iput-object p1, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->whereBuilder:Lcom/lidroid/xutils/db/sqlite/WhereBuilder;

    .line 49
    return-object p0
.end method

.method public where(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)Lcom/lidroid/xutils/db/sqlite/Selector;
    .locals 1

    .prologue
    .line 53
    invoke-static {p1, p2, p3}, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)Lcom/lidroid/xutils/db/sqlite/WhereBuilder;

    move-result-object v0

    iput-object v0, p0, Lcom/lidroid/xutils/db/sqlite/Selector;->whereBuilder:Lcom/lidroid/xutils/db/sqlite/WhereBuilder;

    .line 54
    return-object p0
.end method
