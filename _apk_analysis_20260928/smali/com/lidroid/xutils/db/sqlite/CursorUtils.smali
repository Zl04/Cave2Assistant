.class public Lcom/lidroid/xutils/db/sqlite/CursorUtils;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lidroid/xutils/db/sqlite/CursorUtils$EntityTempCache;,
        Lcom/lidroid/xutils/db/sqlite/CursorUtils$FindCacheSequence;
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getDbModel(Landroid/database/Cursor;)Lcom/lidroid/xutils/db/table/DbModel;
    .locals 5

    .prologue
    .line 71
    const/4 v0, 0x0

    .line 72
    if-eqz p0, :cond_0

    .line 73
    new-instance v0, Lcom/lidroid/xutils/db/table/DbModel;

    invoke-direct {v0}, Lcom/lidroid/xutils/db/table/DbModel;-><init>()V

    .line 74
    invoke-interface {p0}, Landroid/database/Cursor;->getColumnCount()I

    move-result v2

    .line 75
    const/4 v1, 0x0

    :goto_0
    if-lt v1, v2, :cond_1

    .line 79
    :cond_0
    return-object v0

    .line 76
    :cond_1
    invoke-interface {p0, v1}, Landroid/database/Cursor;->getColumnName(I)Ljava/lang/String;

    move-result-object v3

    invoke-interface {p0, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v3, v4}, Lcom/lidroid/xutils/db/table/DbModel;->add(Ljava/lang/String;Ljava/lang/String;)V

    .line 75
    add-int/lit8 v1, v1, 0x1

    goto :goto_0
.end method

.method public static getEntity(Lcom/lidroid/xutils/DbUtils;Landroid/database/Cursor;Ljava/lang/Class;J)Ljava/lang/Object;
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lcom/lidroid/xutils/DbUtils;",
            "Landroid/database/Cursor;",
            "Ljava/lang/Class",
            "<TT;>;J)TT;"
        }
    .end annotation

    .prologue
    const/4 v3, 0x0

    const/4 v2, 0x0

    .line 29
    if-eqz p0, :cond_0

    if-nez p1, :cond_2

    :cond_0
    move-object v0, v2

    .line 67
    :cond_1
    :goto_0
    return-object v0

    .line 31
    :cond_2
    invoke-static {p3, p4}, Lcom/lidroid/xutils/db/sqlite/CursorUtils$EntityTempCache;->setSeq(J)V

    .line 33
    :try_start_0
    invoke-static {p0, p2}, Lcom/lidroid/xutils/db/table/Table;->get(Lcom/lidroid/xutils/DbUtils;Ljava/lang/Class;)Lcom/lidroid/xutils/db/table/Table;

    move-result-object v5

    .line 34
    iget-object v6, v5, Lcom/lidroid/xutils/db/table/Table;->id:Lcom/lidroid/xutils/db/table/Id;

    .line 35
    invoke-virtual {v6}, Lcom/lidroid/xutils/db/table/Id;->getColumnName()Ljava/lang/String;

    move-result-object v1

    .line 36
    invoke-virtual {v6}, Lcom/lidroid/xutils/db/table/Id;->getIndex()I

    move-result v0

    .line 37
    if-gez v0, :cond_6

    .line 38
    invoke-interface {p1, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    move v4, v0

    .line 40
    :goto_1
    invoke-virtual {v6}, Lcom/lidroid/xutils/db/table/Id;->getColumnConverter()Lcom/lidroid/xutils/db/converter/ColumnConverter;

    move-result-object v0

    invoke-interface {v0, p1, v4}, Lcom/lidroid/xutils/db/converter/ColumnConverter;->getFieldValue(Landroid/database/Cursor;I)Ljava/lang/Object;

    move-result-object v7

    .line 41
    invoke-static {p2, v7}, Lcom/lidroid/xutils/db/sqlite/CursorUtils$EntityTempCache;->get(Ljava/lang/Class;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 42
    if-nez v0, :cond_1

    .line 43
    invoke-virtual {p2}, Ljava/lang/Class;->newInstance()Ljava/lang/Object;

    move-result-object v1

    .line 44
    invoke-virtual {v6, v1, p1, v4}, Lcom/lidroid/xutils/db/table/Id;->setValue2Entity(Ljava/lang/Object;Landroid/database/Cursor;I)V

    .line 45
    invoke-static {p2, v7, v1}, Lcom/lidroid/xutils/db/sqlite/CursorUtils$EntityTempCache;->put(Ljava/lang/Class;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 49
    invoke-interface {p1}, Landroid/database/Cursor;->getColumnCount()I

    move-result v4

    .line 50
    :goto_2
    if-lt v3, v4, :cond_3

    .line 59
    iget-object v0, v5, Lcom/lidroid/xutils/db/table/Table;->finderMap:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->values()Ljava/util/Collection;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_3
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_5

    move-object v0, v1

    .line 62
    goto :goto_0

    .line 51
    :cond_3
    invoke-interface {p1, v3}, Landroid/database/Cursor;->getColumnName(I)Ljava/lang/String;

    move-result-object v0

    .line 52
    iget-object v6, v5, Lcom/lidroid/xutils/db/table/Table;->columnMap:Ljava/util/HashMap;

    invoke-virtual {v6, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lidroid/xutils/db/table/Column;

    .line 53
    if-eqz v0, :cond_4

    .line 54
    invoke-virtual {v0, v1, p1, v3}, Lcom/lidroid/xutils/db/table/Column;->setValue2Entity(Ljava/lang/Object;Landroid/database/Cursor;I)V

    .line 50
    :cond_4
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    goto :goto_2

    .line 59
    :cond_5
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lidroid/xutils/db/table/Finder;

    .line 60
    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-virtual {v0, v1, v4, v5}, Lcom/lidroid/xutils/db/table/Finder;->setValue2Entity(Ljava/lang/Object;Landroid/database/Cursor;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_3

    .line 63
    :catch_0
    move-exception v0

    .line 64
    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Lcom/lidroid/xutils/util/LogUtils;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    move-object v0, v2

    .line 67
    goto :goto_0

    :cond_6
    move v4, v0

    goto :goto_1
.end method
