.class public Lcom/lidroid/xutils/db/table/Foreign;
.super Lcom/lidroid/xutils/db/table/Column;
.source "SourceFile"


# instance fields
.field private final foreignColumnConverter:Lcom/lidroid/xutils/db/converter/ColumnConverter;

.field private final foreignColumnName:Ljava/lang/String;


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
    .line 35
    invoke-direct {p0, p1, p2}, Lcom/lidroid/xutils/db/table/Column;-><init>(Ljava/lang/Class;Ljava/lang/reflect/Field;)V

    .line 37
    invoke-static {p2}, Lcom/lidroid/xutils/db/table/ColumnUtils;->getForeignColumnNameByField(Ljava/lang/reflect/Field;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/lidroid/xutils/db/table/Foreign;->foreignColumnName:Ljava/lang/String;

    .line 39
    invoke-virtual {p0}, Lcom/lidroid/xutils/db/table/Foreign;->getForeignEntityType()Ljava/lang/Class;

    move-result-object v0

    iget-object v1, p0, Lcom/lidroid/xutils/db/table/Foreign;->foreignColumnName:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/lidroid/xutils/db/table/TableUtils;->getColumnOrId(Ljava/lang/Class;Ljava/lang/String;)Lcom/lidroid/xutils/db/table/Column;

    move-result-object v0

    iget-object v0, v0, Lcom/lidroid/xutils/db/table/Column;->columnField:Ljava/lang/reflect/Field;

    invoke-virtual {v0}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v0

    .line 40
    invoke-static {v0}, Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;->getColumnConverter(Ljava/lang/Class;)Lcom/lidroid/xutils/db/converter/ColumnConverter;

    move-result-object v0

    iput-object v0, p0, Lcom/lidroid/xutils/db/table/Foreign;->foreignColumnConverter:Lcom/lidroid/xutils/db/converter/ColumnConverter;

    .line 41
    return-void
.end method


# virtual methods
.method public getColumnDbType()Lcom/lidroid/xutils/db/sqlite/ColumnDbType;
    .locals 1

    .prologue
    .line 148
    iget-object v0, p0, Lcom/lidroid/xutils/db/table/Foreign;->foreignColumnConverter:Lcom/lidroid/xutils/db/converter/ColumnConverter;

    invoke-interface {v0}, Lcom/lidroid/xutils/db/converter/ColumnConverter;->getColumnDbType()Lcom/lidroid/xutils/db/sqlite/ColumnDbType;

    move-result-object v0

    return-object v0
.end method

.method public getColumnValue(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 8

    .prologue
    .line 94
    invoke-virtual {p0, p1}, Lcom/lidroid/xutils/db/table/Foreign;->getFieldValue(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 95
    const/4 v1, 0x0

    .line 97
    if-eqz v0, :cond_6

    .line 98
    iget-object v2, p0, Lcom/lidroid/xutils/db/table/Foreign;->columnField:Ljava/lang/reflect/Field;

    invoke-virtual {v2}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v2

    .line 99
    const-class v3, Lcom/lidroid/xutils/db/sqlite/ForeignLazyLoader;

    invoke-virtual {v2, v3}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 100
    check-cast v0, Lcom/lidroid/xutils/db/sqlite/ForeignLazyLoader;

    invoke-virtual {v0}, Lcom/lidroid/xutils/db/sqlite/ForeignLazyLoader;->getColumnValue()Ljava/lang/Object;

    move-result-object v0

    .line 143
    :goto_0
    return-object v0

    .line 101
    :cond_0
    const-class v3, Ljava/util/List;

    invoke-virtual {v2, v3}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4

    .line 103
    :try_start_0
    check-cast v0, Ljava/util/List;

    .line 104
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    if-lez v2, :cond_6

    .line 106
    invoke-static {p0}, Lcom/lidroid/xutils/db/table/ColumnUtils;->getForeignEntityType(Lcom/lidroid/xutils/db/table/Foreign;)Ljava/lang/Class;

    move-result-object v2

    .line 107
    iget-object v3, p0, Lcom/lidroid/xutils/db/table/Foreign;->foreignColumnName:Ljava/lang/String;

    invoke-static {v2, v3}, Lcom/lidroid/xutils/db/table/TableUtils;->getColumnOrId(Ljava/lang/Class;Ljava/lang/String;)Lcom/lidroid/xutils/db/table/Column;

    move-result-object v2

    .line 108
    const/4 v3, 0x0

    invoke-interface {v0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/lidroid/xutils/db/table/Column;->getColumnValue(Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_3

    move-result-object v1

    .line 111
    :try_start_1
    invoke-virtual {p0}, Lcom/lidroid/xutils/db/table/Foreign;->getTable()Lcom/lidroid/xutils/db/table/Table;

    move-result-object v3

    .line 112
    if-eqz v3, :cond_2

    instance-of v4, v2, Lcom/lidroid/xutils/db/table/Id;

    if-eqz v4, :cond_2

    .line 113
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :cond_1
    :goto_1
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-nez v5, :cond_3

    .line 121
    :cond_2
    const/4 v3, 0x0

    invoke-interface {v0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {v2, v0}, Lcom/lidroid/xutils/db/table/Column;->getColumnValue(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    .line 113
    :cond_3
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    .line 114
    invoke-virtual {v2, v5}, Lcom/lidroid/xutils/db/table/Column;->getColumnValue(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    .line 115
    if-nez v6, :cond_1

    .line 116
    iget-object v6, v3, Lcom/lidroid/xutils/db/table/Table;->db:Lcom/lidroid/xutils/DbUtils;

    invoke-virtual {v6, v5}, Lcom/lidroid/xutils/DbUtils;->saveOrUpdate(Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1

    .line 123
    :catch_0
    move-exception v0

    move-object v7, v0

    move-object v0, v1

    move-object v1, v7

    .line 124
    :goto_2
    invoke-virtual {v1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v1}, Lcom/lidroid/xutils/util/LogUtils;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0

    .line 128
    :cond_4
    :try_start_2
    iget-object v3, p0, Lcom/lidroid/xutils/db/table/Foreign;->foreignColumnName:Ljava/lang/String;

    invoke-static {v2, v3}, Lcom/lidroid/xutils/db/table/TableUtils;->getColumnOrId(Ljava/lang/Class;Ljava/lang/String;)Lcom/lidroid/xutils/db/table/Column;

    move-result-object v2

    .line 129
    invoke-virtual {v2, v0}, Lcom/lidroid/xutils/db/table/Column;->getColumnValue(Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    move-result-object v1

    .line 131
    :try_start_3
    invoke-virtual {p0}, Lcom/lidroid/xutils/db/table/Foreign;->getTable()Lcom/lidroid/xutils/db/table/Table;

    move-result-object v3

    .line 132
    if-eqz v3, :cond_5

    if-nez v1, :cond_5

    instance-of v4, v2, Lcom/lidroid/xutils/db/table/Id;

    if-eqz v4, :cond_5

    .line 133
    iget-object v3, v3, Lcom/lidroid/xutils/db/table/Table;->db:Lcom/lidroid/xutils/DbUtils;

    invoke-virtual {v3, v0}, Lcom/lidroid/xutils/DbUtils;->saveOrUpdate(Ljava/lang/Object;)V

    .line 136
    :cond_5
    invoke-virtual {v2, v0}, Lcom/lidroid/xutils/db/table/Column;->getColumnValue(Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    move-result-object v0

    goto :goto_0

    .line 137
    :catch_1
    move-exception v0

    move-object v7, v0

    move-object v0, v1

    move-object v1, v7

    .line 138
    :goto_3
    invoke-virtual {v1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v1}, Lcom/lidroid/xutils/util/LogUtils;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_0

    .line 137
    :catch_2
    move-exception v0

    move-object v7, v0

    move-object v0, v1

    move-object v1, v7

    goto :goto_3

    .line 123
    :catch_3
    move-exception v0

    move-object v7, v0

    move-object v0, v1

    move-object v1, v7

    goto :goto_2

    :cond_6
    move-object v0, v1

    goto/16 :goto_0
.end method

.method public getDefaultValue()Ljava/lang/Object;
    .locals 1

    .prologue
    .line 158
    const/4 v0, 0x0

    return-object v0
.end method

.method public getForeignColumnName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 44
    iget-object v0, p0, Lcom/lidroid/xutils/db/table/Foreign;->foreignColumnName:Ljava/lang/String;

    return-object v0
.end method

.method public getForeignEntityType()Ljava/lang/Class;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/lang/Class",
            "<*>;"
        }
    .end annotation

    .prologue
    .line 48
    invoke-static {p0}, Lcom/lidroid/xutils/db/table/ColumnUtils;->getForeignEntityType(Lcom/lidroid/xutils/db/table/Foreign;)Ljava/lang/Class;

    move-result-object v0

    return-object v0
.end method

.method public setValue2Entity(Ljava/lang/Object;Landroid/database/Cursor;I)V
    .locals 4

    .prologue
    .line 54
    iget-object v0, p0, Lcom/lidroid/xutils/db/table/Foreign;->foreignColumnConverter:Lcom/lidroid/xutils/db/converter/ColumnConverter;

    invoke-interface {v0, p2, p3}, Lcom/lidroid/xutils/db/converter/ColumnConverter;->getFieldValue(Landroid/database/Cursor;I)Ljava/lang/Object;

    move-result-object v1

    .line 55
    if-nez v1, :cond_0

    .line 89
    :goto_0
    return-void

    .line 57
    :cond_0
    const/4 v0, 0x0

    .line 58
    iget-object v2, p0, Lcom/lidroid/xutils/db/table/Foreign;->columnField:Ljava/lang/reflect/Field;

    invoke-virtual {v2}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v2

    .line 59
    const-class v3, Lcom/lidroid/xutils/db/sqlite/ForeignLazyLoader;

    invoke-virtual {v2, v3}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 60
    new-instance v0, Lcom/lidroid/xutils/db/sqlite/ForeignLazyLoader;

    invoke-direct {v0, p0, v1}, Lcom/lidroid/xutils/db/sqlite/ForeignLazyLoader;-><init>(Lcom/lidroid/xutils/db/table/Foreign;Ljava/lang/Object;)V

    .line 75
    :goto_1
    iget-object v1, p0, Lcom/lidroid/xutils/db/table/Foreign;->setMethod:Ljava/lang/reflect/Method;

    if-eqz v1, :cond_3

    .line 77
    :try_start_0
    iget-object v1, p0, Lcom/lidroid/xutils/db/table/Foreign;->setMethod:Ljava/lang/reflect/Method;

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object v0, v2, v3

    invoke-virtual {v1, p1, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 78
    :catch_0
    move-exception v0

    .line 79
    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Lcom/lidroid/xutils/util/LogUtils;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0

    .line 61
    :cond_1
    const-class v3, Ljava/util/List;

    invoke-virtual {v2, v3}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 63
    :try_start_1
    new-instance v2, Lcom/lidroid/xutils/db/sqlite/ForeignLazyLoader;

    invoke-direct {v2, p0, v1}, Lcom/lidroid/xutils/db/sqlite/ForeignLazyLoader;-><init>(Lcom/lidroid/xutils/db/table/Foreign;Ljava/lang/Object;)V

    invoke-virtual {v2}, Lcom/lidroid/xutils/db/sqlite/ForeignLazyLoader;->getAllFromDb()Ljava/util/List;
    :try_end_1
    .catch Lcom/lidroid/xutils/exception/DbException; {:try_start_1 .. :try_end_1} :catch_1

    move-result-object v0

    goto :goto_1

    .line 64
    :catch_1
    move-exception v1

    .line 65
    invoke-virtual {v1}, Lcom/lidroid/xutils/exception/DbException;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v1}, Lcom/lidroid/xutils/util/LogUtils;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_1

    .line 69
    :cond_2
    :try_start_2
    new-instance v2, Lcom/lidroid/xutils/db/sqlite/ForeignLazyLoader;

    invoke-direct {v2, p0, v1}, Lcom/lidroid/xutils/db/sqlite/ForeignLazyLoader;-><init>(Lcom/lidroid/xutils/db/table/Foreign;Ljava/lang/Object;)V

    invoke-virtual {v2}, Lcom/lidroid/xutils/db/sqlite/ForeignLazyLoader;->getFirstFromDb()Ljava/lang/Object;
    :try_end_2
    .catch Lcom/lidroid/xutils/exception/DbException; {:try_start_2 .. :try_end_2} :catch_2

    move-result-object v0

    goto :goto_1

    .line 70
    :catch_2
    move-exception v1

    .line 71
    invoke-virtual {v1}, Lcom/lidroid/xutils/exception/DbException;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v1}, Lcom/lidroid/xutils/util/LogUtils;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_1

    .line 83
    :cond_3
    :try_start_3
    iget-object v1, p0, Lcom/lidroid/xutils/db/table/Foreign;->columnField:Ljava/lang/reflect/Field;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 84
    iget-object v1, p0, Lcom/lidroid/xutils/db/table/Foreign;->columnField:Ljava/lang/reflect/Field;

    invoke-virtual {v1, p1, v0}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_3

    goto :goto_0

    .line 85
    :catch_3
    move-exception v0

    .line 86
    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Lcom/lidroid/xutils/util/LogUtils;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0
.end method
