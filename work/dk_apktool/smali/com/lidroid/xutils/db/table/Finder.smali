.class public Lcom/lidroid/xutils/db/table/Finder;
.super Lcom/lidroid/xutils/db/table/Column;
.source "SourceFile"


# instance fields
.field private final targetColumnName:Ljava/lang/String;

.field private final valueColumnName:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/Class;Ljava/lang/reflect/Field;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class",
            "<*>;",
            "Ljava/lang/reflect/Field;",
            ")V"
        }
    .end annotation

    .prologue
    .line 23
    invoke-direct {p0, p1, p2}, Lcom/lidroid/xutils/db/table/Column;-><init>(Ljava/lang/Class;Ljava/lang/reflect/Field;)V

    .line 26
    const-class v0, Lcom/lidroid/xutils/db/annotation/Finder;

    invoke-virtual {p2, v0}, Ljava/lang/reflect/Field;->getAnnotation(Ljava/lang/Class;)Ljava/lang/annotation/Annotation;

    move-result-object v0

    check-cast v0, Lcom/lidroid/xutils/db/annotation/Finder;

    .line 27
    invoke-interface {v0}, Lcom/lidroid/xutils/db/annotation/Finder;->valueColumn()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/lidroid/xutils/db/table/Finder;->valueColumnName:Ljava/lang/String;

    .line 28
    invoke-interface {v0}, Lcom/lidroid/xutils/db/annotation/Finder;->targetColumn()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/lidroid/xutils/db/table/Finder;->targetColumnName:Ljava/lang/String;

    .line 29
    return-void
.end method


# virtual methods
.method public getColumnDbType()Lcom/lidroid/xutils/db/sqlite/ColumnDbType;
    .locals 1

    .prologue
    .line 88
    sget-object v0, Lcom/lidroid/xutils/db/sqlite/ColumnDbType;->TEXT:Lcom/lidroid/xutils/db/sqlite/ColumnDbType;

    return-object v0
.end method

.method public getColumnValue(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 78
    const/4 v0, 0x0

    return-object v0
.end method

.method public getDefaultValue()Ljava/lang/Object;
    .locals 1

    .prologue
    .line 83
    const/4 v0, 0x0

    return-object v0
.end method

.method public getTargetColumnName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 36
    iget-object v0, p0, Lcom/lidroid/xutils/db/table/Finder;->targetColumnName:Ljava/lang/String;

    return-object v0
.end method

.method public getTargetEntityType()Ljava/lang/Class;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/lang/Class",
            "<*>;"
        }
    .end annotation

    .prologue
    .line 32
    invoke-static {p0}, Lcom/lidroid/xutils/db/table/ColumnUtils;->getFinderTargetEntityType(Lcom/lidroid/xutils/db/table/Finder;)Ljava/lang/Class;

    move-result-object v0

    return-object v0
.end method

.method public setValue2Entity(Ljava/lang/Object;Landroid/database/Cursor;I)V
    .locals 4

    .prologue
    .line 41
    const/4 v0, 0x0

    .line 42
    iget-object v1, p0, Lcom/lidroid/xutils/db/table/Finder;->columnField:Ljava/lang/reflect/Field;

    invoke-virtual {v1}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v1

    .line 43
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    iget-object v3, p0, Lcom/lidroid/xutils/db/table/Finder;->valueColumnName:Ljava/lang/String;

    invoke-static {v2, v3}, Lcom/lidroid/xutils/db/table/TableUtils;->getColumnOrId(Ljava/lang/Class;Ljava/lang/String;)Lcom/lidroid/xutils/db/table/Column;

    move-result-object v2

    invoke-virtual {v2, p1}, Lcom/lidroid/xutils/db/table/Column;->getColumnValue(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .line 44
    const-class v3, Lcom/lidroid/xutils/db/sqlite/FinderLazyLoader;

    invoke-virtual {v1, v3}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 45
    new-instance v0, Lcom/lidroid/xutils/db/sqlite/FinderLazyLoader;

    invoke-direct {v0, p0, v2}, Lcom/lidroid/xutils/db/sqlite/FinderLazyLoader;-><init>(Lcom/lidroid/xutils/db/table/Finder;Ljava/lang/Object;)V

    .line 60
    :goto_0
    iget-object v1, p0, Lcom/lidroid/xutils/db/table/Finder;->setMethod:Ljava/lang/reflect/Method;

    if-eqz v1, :cond_2

    .line 62
    :try_start_0
    iget-object v1, p0, Lcom/lidroid/xutils/db/table/Finder;->setMethod:Ljava/lang/reflect/Method;

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object v0, v2, v3

    invoke-virtual {v1, p1, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    .line 74
    :goto_1
    return-void

    .line 46
    :cond_0
    const-class v3, Ljava/util/List;

    invoke-virtual {v1, v3}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 48
    :try_start_1
    new-instance v1, Lcom/lidroid/xutils/db/sqlite/FinderLazyLoader;

    invoke-direct {v1, p0, v2}, Lcom/lidroid/xutils/db/sqlite/FinderLazyLoader;-><init>(Lcom/lidroid/xutils/db/table/Finder;Ljava/lang/Object;)V

    invoke-virtual {v1}, Lcom/lidroid/xutils/db/sqlite/FinderLazyLoader;->getAllFromDb()Ljava/util/List;
    :try_end_1
    .catch Lcom/lidroid/xutils/exception/DbException; {:try_start_1 .. :try_end_1} :catch_0

    move-result-object v0

    goto :goto_0

    .line 49
    :catch_0
    move-exception v1

    .line 50
    invoke-virtual {v1}, Lcom/lidroid/xutils/exception/DbException;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v1}, Lcom/lidroid/xutils/util/LogUtils;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0

    .line 54
    :cond_1
    :try_start_2
    new-instance v1, Lcom/lidroid/xutils/db/sqlite/FinderLazyLoader;

    invoke-direct {v1, p0, v2}, Lcom/lidroid/xutils/db/sqlite/FinderLazyLoader;-><init>(Lcom/lidroid/xutils/db/table/Finder;Ljava/lang/Object;)V

    invoke-virtual {v1}, Lcom/lidroid/xutils/db/sqlite/FinderLazyLoader;->getFirstFromDb()Ljava/lang/Object;
    :try_end_2
    .catch Lcom/lidroid/xutils/exception/DbException; {:try_start_2 .. :try_end_2} :catch_1

    move-result-object v0

    goto :goto_0

    .line 55
    :catch_1
    move-exception v1

    .line 56
    invoke-virtual {v1}, Lcom/lidroid/xutils/exception/DbException;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v1}, Lcom/lidroid/xutils/util/LogUtils;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0

    .line 63
    :catch_2
    move-exception v0

    .line 64
    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Lcom/lidroid/xutils/util/LogUtils;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_1

    .line 68
    :cond_2
    :try_start_3
    iget-object v1, p0, Lcom/lidroid/xutils/db/table/Finder;->columnField:Ljava/lang/reflect/Field;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 69
    iget-object v1, p0, Lcom/lidroid/xutils/db/table/Finder;->columnField:Ljava/lang/reflect/Field;

    invoke-virtual {v1, p1, v0}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_3

    goto :goto_1

    .line 70
    :catch_3
    move-exception v0

    .line 71
    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Lcom/lidroid/xutils/util/LogUtils;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_1
.end method
