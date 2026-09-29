.class public Lcom/lidroid/xutils/db/sqlite/SqlInfoBuilder;
.super Ljava/lang/Object;
.source "SourceFile"


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 30
    return-void
.end method

.method public static buildCreateTableSqlInfo(Lcom/lidroid/xutils/DbUtils;Ljava/lang/Class;)Lcom/lidroid/xutils/db/sqlite/SqlInfo;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/lidroid/xutils/DbUtils;",
            "Ljava/lang/Class",
            "<*>;)",
            "Lcom/lidroid/xutils/db/sqlite/SqlInfo;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/lidroid/xutils/exception/DbException;
        }
    .end annotation

    .prologue
    .line 224
    invoke-static {p0, p1}, Lcom/lidroid/xutils/db/table/Table;->get(Lcom/lidroid/xutils/DbUtils;Ljava/lang/Class;)Lcom/lidroid/xutils/db/table/Table;

    move-result-object v0

    .line 225
    iget-object v1, v0, Lcom/lidroid/xutils/db/table/Table;->id:Lcom/lidroid/xutils/db/table/Id;

    .line 227
    new-instance v2, Ljava/lang/StringBuffer;

    invoke-direct {v2}, Ljava/lang/StringBuffer;-><init>()V

    .line 228
    const-string v3, "CREATE TABLE IF NOT EXISTS "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 229
    iget-object v3, v0, Lcom/lidroid/xutils/db/table/Table;->tableName:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 230
    const-string v3, " ( "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 232
    invoke-virtual {v1}, Lcom/lidroid/xutils/db/table/Id;->isAutoIncrement()Z

    move-result v3

    if-eqz v3, :cond_1

    .line 233
    const-string v3, "\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v3

    invoke-virtual {v1}, Lcom/lidroid/xutils/db/table/Id;->getColumnName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v1

    const-string v3, "\"  "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v1

    const-string v3, "INTEGER PRIMARY KEY AUTOINCREMENT,"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 238
    :goto_0
    iget-object v0, v0, Lcom/lidroid/xutils/db/table/Table;->columnMap:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->values()Ljava/util/Collection;

    move-result-object v0

    .line 239
    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_0
    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_2

    .line 258
    invoke-virtual {v2}, Ljava/lang/StringBuffer;->length()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    invoke-virtual {v2, v0}, Ljava/lang/StringBuffer;->deleteCharAt(I)Ljava/lang/StringBuffer;

    .line 259
    const-string v0, " )"

    invoke-virtual {v2, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 260
    new-instance v0, Lcom/lidroid/xutils/db/sqlite/SqlInfo;

    invoke-virtual {v2}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/lidroid/xutils/db/sqlite/SqlInfo;-><init>(Ljava/lang/String;)V

    return-object v0

    .line 235
    :cond_1
    const-string v3, "\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v3

    invoke-virtual {v1}, Lcom/lidroid/xutils/db/table/Id;->getColumnName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v3

    const-string v4, "\"  "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v3

    invoke-virtual {v1}, Lcom/lidroid/xutils/db/table/Id;->getColumnDbType()Lcom/lidroid/xutils/db/sqlite/ColumnDbType;

    move-result-object v1

    invoke-virtual {v3, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/Object;)Ljava/lang/StringBuffer;

    move-result-object v1

    const-string v3, " PRIMARY KEY,"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    goto :goto_0

    .line 239
    :cond_2
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lidroid/xutils/db/table/Column;

    .line 240
    instance-of v3, v0, Lcom/lidroid/xutils/db/table/Finder;

    if-nez v3, :cond_0

    .line 243
    const-string v3, "\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v3

    invoke-virtual {v0}, Lcom/lidroid/xutils/db/table/Column;->getColumnName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v3

    const-string v4, "\"  "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 244
    invoke-virtual {v0}, Lcom/lidroid/xutils/db/table/Column;->getColumnDbType()Lcom/lidroid/xutils/db/sqlite/ColumnDbType;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/Object;)Ljava/lang/StringBuffer;

    .line 245
    invoke-virtual {v0}, Lcom/lidroid/xutils/db/table/Column;->getColumnField()Ljava/lang/reflect/Field;

    move-result-object v3

    invoke-static {v3}, Lcom/lidroid/xutils/db/table/ColumnUtils;->isUnique(Ljava/lang/reflect/Field;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 246
    const-string v3, " UNIQUE"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 248
    :cond_3
    invoke-virtual {v0}, Lcom/lidroid/xutils/db/table/Column;->getColumnField()Ljava/lang/reflect/Field;

    move-result-object v3

    invoke-static {v3}, Lcom/lidroid/xutils/db/table/ColumnUtils;->isNotNull(Ljava/lang/reflect/Field;)Z

    move-result v3

    if-eqz v3, :cond_4

    .line 249
    const-string v3, " NOT NULL"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 251
    :cond_4
    invoke-virtual {v0}, Lcom/lidroid/xutils/db/table/Column;->getColumnField()Ljava/lang/reflect/Field;

    move-result-object v0

    invoke-static {v0}, Lcom/lidroid/xutils/db/table/ColumnUtils;->getCheck(Ljava/lang/reflect/Field;)Ljava/lang/String;

    move-result-object v0

    .line 252
    if-eqz v0, :cond_5

    .line 253
    const-string v3, " CHECK("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v0

    const-string v3, ")"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 255
    :cond_5
    const-string v0, ","

    invoke-virtual {v2, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    goto/16 :goto_1
.end method

.method private static buildDeleteSqlByTableName(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 99
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "DELETE FROM "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static buildDeleteSqlInfo(Lcom/lidroid/xutils/DbUtils;Ljava/lang/Class;Lcom/lidroid/xutils/db/sqlite/WhereBuilder;)Lcom/lidroid/xutils/db/sqlite/SqlInfo;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/lidroid/xutils/DbUtils;",
            "Ljava/lang/Class",
            "<*>;",
            "Lcom/lidroid/xutils/db/sqlite/WhereBuilder;",
            ")",
            "Lcom/lidroid/xutils/db/sqlite/SqlInfo;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/lidroid/xutils/exception/DbException;
        }
    .end annotation

    .prologue
    .line 139
    invoke-static {p0, p1}, Lcom/lidroid/xutils/db/table/Table;->get(Lcom/lidroid/xutils/DbUtils;Ljava/lang/Class;)Lcom/lidroid/xutils/db/table/Table;

    move-result-object v0

    .line 140
    new-instance v1, Ljava/lang/StringBuilder;

    iget-object v0, v0, Lcom/lidroid/xutils/db/table/Table;->tableName:Ljava/lang/String;

    invoke-static {v0}, Lcom/lidroid/xutils/db/sqlite/SqlInfoBuilder;->buildDeleteSqlByTableName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 142
    if-eqz p2, :cond_0

    invoke-virtual {p2}, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->getWhereItemSize()I

    move-result v0

    if-lez v0, :cond_0

    .line 143
    const-string v0, " WHERE "

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p2}, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 146
    :cond_0
    new-instance v0, Lcom/lidroid/xutils/db/sqlite/SqlInfo;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/lidroid/xutils/db/sqlite/SqlInfo;-><init>(Ljava/lang/String;)V

    return-object v0
.end method

.method public static buildDeleteSqlInfo(Lcom/lidroid/xutils/DbUtils;Ljava/lang/Class;Ljava/lang/Object;)Lcom/lidroid/xutils/db/sqlite/SqlInfo;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/lidroid/xutils/DbUtils;",
            "Ljava/lang/Class",
            "<*>;",
            "Ljava/lang/Object;",
            ")",
            "Lcom/lidroid/xutils/db/sqlite/SqlInfo;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/lidroid/xutils/exception/DbException;
        }
    .end annotation

    .prologue
    .line 122
    new-instance v0, Lcom/lidroid/xutils/db/sqlite/SqlInfo;

    invoke-direct {v0}, Lcom/lidroid/xutils/db/sqlite/SqlInfo;-><init>()V

    .line 124
    invoke-static {p0, p1}, Lcom/lidroid/xutils/db/table/Table;->get(Lcom/lidroid/xutils/DbUtils;Ljava/lang/Class;)Lcom/lidroid/xutils/db/table/Table;

    move-result-object v1

    .line 125
    iget-object v2, v1, Lcom/lidroid/xutils/db/table/Table;->id:Lcom/lidroid/xutils/db/table/Id;

    .line 127
    if-nez p2, :cond_0

    .line 128
    new-instance v0, Lcom/lidroid/xutils/exception/DbException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "this entity["

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "]\'s id value is null"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/lidroid/xutils/exception/DbException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 130
    :cond_0
    new-instance v3, Ljava/lang/StringBuilder;

    iget-object v1, v1, Lcom/lidroid/xutils/db/table/Table;->tableName:Ljava/lang/String;

    invoke-static {v1}, Lcom/lidroid/xutils/db/sqlite/SqlInfoBuilder;->buildDeleteSqlByTableName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v3, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 131
    const-string v1, " WHERE "

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v2}, Lcom/lidroid/xutils/db/table/Id;->getColumnName()Ljava/lang/String;

    move-result-object v2

    const-string v4, "="

    invoke-static {v2, v4, p2}, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)Lcom/lidroid/xutils/db/sqlite/WhereBuilder;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    .line 133
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/lidroid/xutils/db/sqlite/SqlInfo;->setSql(Ljava/lang/String;)V

    .line 135
    return-object v0
.end method

.method public static buildDeleteSqlInfo(Lcom/lidroid/xutils/DbUtils;Ljava/lang/Object;)Lcom/lidroid/xutils/db/sqlite/SqlInfo;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/lidroid/xutils/exception/DbException;
        }
    .end annotation

    .prologue
    .line 103
    new-instance v0, Lcom/lidroid/xutils/db/sqlite/SqlInfo;

    invoke-direct {v0}, Lcom/lidroid/xutils/db/sqlite/SqlInfo;-><init>()V

    .line 105
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    .line 106
    invoke-static {p0, v1}, Lcom/lidroid/xutils/db/table/Table;->get(Lcom/lidroid/xutils/DbUtils;Ljava/lang/Class;)Lcom/lidroid/xutils/db/table/Table;

    move-result-object v1

    .line 107
    iget-object v2, v1, Lcom/lidroid/xutils/db/table/Table;->id:Lcom/lidroid/xutils/db/table/Id;

    .line 108
    invoke-virtual {v2, p1}, Lcom/lidroid/xutils/db/table/Id;->getColumnValue(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    .line 110
    if-nez v3, :cond_0

    .line 111
    new-instance v0, Lcom/lidroid/xutils/exception/DbException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "this entity["

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "]\'s id value is null"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/lidroid/xutils/exception/DbException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 113
    :cond_0
    new-instance v4, Ljava/lang/StringBuilder;

    iget-object v1, v1, Lcom/lidroid/xutils/db/table/Table;->tableName:Ljava/lang/String;

    invoke-static {v1}, Lcom/lidroid/xutils/db/sqlite/SqlInfoBuilder;->buildDeleteSqlByTableName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v4, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 114
    const-string v1, " WHERE "

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v2}, Lcom/lidroid/xutils/db/table/Id;->getColumnName()Ljava/lang/String;

    move-result-object v2

    const-string v5, "="

    invoke-static {v2, v5, v3}, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)Lcom/lidroid/xutils/db/sqlite/WhereBuilder;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    .line 116
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/lidroid/xutils/db/sqlite/SqlInfo;->setSql(Ljava/lang/String;)V

    .line 118
    return-object v0
.end method

.method public static buildInsertSqlInfo(Lcom/lidroid/xutils/DbUtils;Ljava/lang/Object;)Lcom/lidroid/xutils/db/sqlite/SqlInfo;
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/lidroid/xutils/exception/DbException;
        }
    .end annotation

    .prologue
    .line 36
    invoke-static {p0, p1}, Lcom/lidroid/xutils/db/sqlite/SqlInfoBuilder;->entity2KeyValueList(Lcom/lidroid/xutils/DbUtils;Ljava/lang/Object;)Ljava/util/List;

    move-result-object v2

    .line 37
    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    .line 61
    :goto_0
    return-object v0

    .line 39
    :cond_0
    new-instance v1, Lcom/lidroid/xutils/db/sqlite/SqlInfo;

    invoke-direct {v1}, Lcom/lidroid/xutils/db/sqlite/SqlInfo;-><init>()V

    .line 40
    new-instance v3, Ljava/lang/StringBuffer;

    invoke-direct {v3}, Ljava/lang/StringBuffer;-><init>()V

    .line 42
    const-string v0, "INSERT INTO "

    invoke-virtual {v3, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 43
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-static {v0}, Lcom/lidroid/xutils/db/table/TableUtils;->getTableName(Ljava/lang/Class;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 44
    const-string v0, " ("

    invoke-virtual {v3, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 45
    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_1
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_1

    .line 49
    invoke-virtual {v3}, Ljava/lang/StringBuffer;->length()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    invoke-virtual {v3, v0}, Ljava/lang/StringBuffer;->deleteCharAt(I)Ljava/lang/StringBuffer;

    .line 50
    const-string v0, ") VALUES ("

    invoke-virtual {v3, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 52
    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    .line 53
    const/4 v0, 0x0

    :goto_2
    if-lt v0, v2, :cond_2

    .line 56
    invoke-virtual {v3}, Ljava/lang/StringBuffer;->length()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    invoke-virtual {v3, v0}, Ljava/lang/StringBuffer;->deleteCharAt(I)Ljava/lang/StringBuffer;

    .line 57
    const-string v0, ")"

    invoke-virtual {v3, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 59
    invoke-virtual {v3}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/lidroid/xutils/db/sqlite/SqlInfo;->setSql(Ljava/lang/String;)V

    move-object v0, v1

    .line 61
    goto :goto_0

    .line 45
    :cond_1
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lidroid/xutils/db/table/KeyValue;

    .line 46
    iget-object v5, v0, Lcom/lidroid/xutils/db/table/KeyValue;->key:Ljava/lang/String;

    invoke-virtual {v3, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v5

    const-string v6, ","

    invoke-virtual {v5, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 47
    iget-object v0, v0, Lcom/lidroid/xutils/db/table/KeyValue;->value:Ljava/lang/Object;

    invoke-virtual {v1, v0}, Lcom/lidroid/xutils/db/sqlite/SqlInfo;->addBindArgWithoutConverter(Ljava/lang/Object;)V

    goto :goto_1

    .line 54
    :cond_2
    const-string v4, "?,"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 53
    add-int/lit8 v0, v0, 0x1

    goto :goto_2
.end method

.method public static buildReplaceSqlInfo(Lcom/lidroid/xutils/DbUtils;Ljava/lang/Object;)Lcom/lidroid/xutils/db/sqlite/SqlInfo;
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/lidroid/xutils/exception/DbException;
        }
    .end annotation

    .prologue
    .line 68
    invoke-static {p0, p1}, Lcom/lidroid/xutils/db/sqlite/SqlInfoBuilder;->entity2KeyValueList(Lcom/lidroid/xutils/DbUtils;Ljava/lang/Object;)Ljava/util/List;

    move-result-object v2

    .line 69
    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    .line 93
    :goto_0
    return-object v0

    .line 71
    :cond_0
    new-instance v1, Lcom/lidroid/xutils/db/sqlite/SqlInfo;

    invoke-direct {v1}, Lcom/lidroid/xutils/db/sqlite/SqlInfo;-><init>()V

    .line 72
    new-instance v3, Ljava/lang/StringBuffer;

    invoke-direct {v3}, Ljava/lang/StringBuffer;-><init>()V

    .line 74
    const-string v0, "REPLACE INTO "

    invoke-virtual {v3, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 75
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-static {v0}, Lcom/lidroid/xutils/db/table/TableUtils;->getTableName(Ljava/lang/Class;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 76
    const-string v0, " ("

    invoke-virtual {v3, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 77
    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_1
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_1

    .line 81
    invoke-virtual {v3}, Ljava/lang/StringBuffer;->length()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    invoke-virtual {v3, v0}, Ljava/lang/StringBuffer;->deleteCharAt(I)Ljava/lang/StringBuffer;

    .line 82
    const-string v0, ") VALUES ("

    invoke-virtual {v3, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 84
    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    .line 85
    const/4 v0, 0x0

    :goto_2
    if-lt v0, v2, :cond_2

    .line 88
    invoke-virtual {v3}, Ljava/lang/StringBuffer;->length()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    invoke-virtual {v3, v0}, Ljava/lang/StringBuffer;->deleteCharAt(I)Ljava/lang/StringBuffer;

    .line 89
    const-string v0, ")"

    invoke-virtual {v3, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 91
    invoke-virtual {v3}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/lidroid/xutils/db/sqlite/SqlInfo;->setSql(Ljava/lang/String;)V

    move-object v0, v1

    .line 93
    goto :goto_0

    .line 77
    :cond_1
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lidroid/xutils/db/table/KeyValue;

    .line 78
    iget-object v5, v0, Lcom/lidroid/xutils/db/table/KeyValue;->key:Ljava/lang/String;

    invoke-virtual {v3, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v5

    const-string v6, ","

    invoke-virtual {v5, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 79
    iget-object v0, v0, Lcom/lidroid/xutils/db/table/KeyValue;->value:Ljava/lang/Object;

    invoke-virtual {v1, v0}, Lcom/lidroid/xutils/db/sqlite/SqlInfo;->addBindArgWithoutConverter(Ljava/lang/Object;)V

    goto :goto_1

    .line 86
    :cond_2
    const-string v4, "?,"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 85
    add-int/lit8 v0, v0, 0x1

    goto :goto_2
.end method

.method public static varargs buildUpdateSqlInfo(Lcom/lidroid/xutils/DbUtils;Ljava/lang/Object;Lcom/lidroid/xutils/db/sqlite/WhereBuilder;[Ljava/lang/String;)Lcom/lidroid/xutils/db/sqlite/SqlInfo;
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/lidroid/xutils/exception/DbException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    .line 190
    invoke-static {p0, p1}, Lcom/lidroid/xutils/db/sqlite/SqlInfoBuilder;->entity2KeyValueList(Lcom/lidroid/xutils/DbUtils;Ljava/lang/Object;)Ljava/util/List;

    move-result-object v3

    .line 191
    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v1

    if-nez v1, :cond_0

    .line 218
    :goto_0
    return-object v0

    .line 194
    :cond_0
    if-eqz p3, :cond_5

    array-length v1, p3

    if-lez v1, :cond_5

    .line 195
    new-instance v0, Ljava/util/HashSet;

    array-length v1, p3

    invoke-direct {v0, v1}, Ljava/util/HashSet;-><init>(I)V

    .line 196
    invoke-static {v0, p3}, Ljava/util/Collections;->addAll(Ljava/util/Collection;[Ljava/lang/Object;)Z

    move-object v1, v0

    .line 199
    :goto_1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    .line 200
    invoke-static {v0}, Lcom/lidroid/xutils/db/table/TableUtils;->getTableName(Ljava/lang/Class;)Ljava/lang/String;

    move-result-object v0

    .line 202
    new-instance v2, Lcom/lidroid/xutils/db/sqlite/SqlInfo;

    invoke-direct {v2}, Lcom/lidroid/xutils/db/sqlite/SqlInfo;-><init>()V

    .line 203
    new-instance v4, Ljava/lang/StringBuffer;

    const-string v5, "UPDATE "

    invoke-direct {v4, v5}, Ljava/lang/StringBuffer;-><init>(Ljava/lang/String;)V

    .line 204
    invoke-virtual {v4, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 205
    const-string v0, " SET "

    invoke-virtual {v4, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 206
    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_1
    :goto_2
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_3

    .line 212
    invoke-virtual {v4}, Ljava/lang/StringBuffer;->length()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    invoke-virtual {v4, v0}, Ljava/lang/StringBuffer;->deleteCharAt(I)Ljava/lang/StringBuffer;

    .line 213
    if-eqz p2, :cond_2

    invoke-virtual {p2}, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->getWhereItemSize()I

    move-result v0

    if-lez v0, :cond_2

    .line 214
    const-string v0, " WHERE "

    invoke-virtual {v4, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v0

    invoke-virtual {p2}, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 217
    :cond_2
    invoke-virtual {v4}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Lcom/lidroid/xutils/db/sqlite/SqlInfo;->setSql(Ljava/lang/String;)V

    move-object v0, v2

    .line 218
    goto :goto_0

    .line 206
    :cond_3
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lidroid/xutils/db/table/KeyValue;

    .line 207
    if-eqz v1, :cond_4

    iget-object v5, v0, Lcom/lidroid/xutils/db/table/KeyValue;->key:Ljava/lang/String;

    invoke-virtual {v1, v5}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 208
    :cond_4
    iget-object v5, v0, Lcom/lidroid/xutils/db/table/KeyValue;->key:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v5

    const-string v6, "=?,"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 209
    iget-object v0, v0, Lcom/lidroid/xutils/db/table/KeyValue;->value:Ljava/lang/Object;

    invoke-virtual {v2, v0}, Lcom/lidroid/xutils/db/sqlite/SqlInfo;->addBindArgWithoutConverter(Ljava/lang/Object;)V

    goto :goto_2

    :cond_5
    move-object v1, v0

    goto :goto_1
.end method

.method public static varargs buildUpdateSqlInfo(Lcom/lidroid/xutils/DbUtils;Ljava/lang/Object;[Ljava/lang/String;)Lcom/lidroid/xutils/db/sqlite/SqlInfo;
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/lidroid/xutils/exception/DbException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    .line 153
    invoke-static {p0, p1}, Lcom/lidroid/xutils/db/sqlite/SqlInfoBuilder;->entity2KeyValueList(Lcom/lidroid/xutils/DbUtils;Ljava/lang/Object;)Ljava/util/List;

    move-result-object v3

    .line 154
    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v1

    if-nez v1, :cond_0

    .line 185
    :goto_0
    return-object v0

    .line 157
    :cond_0
    if-eqz p2, :cond_5

    array-length v1, p2

    if-lez v1, :cond_5

    .line 158
    new-instance v0, Ljava/util/HashSet;

    array-length v1, p2

    invoke-direct {v0, v1}, Ljava/util/HashSet;-><init>(I)V

    .line 159
    invoke-static {v0, p2}, Ljava/util/Collections;->addAll(Ljava/util/Collection;[Ljava/lang/Object;)Z

    move-object v1, v0

    .line 162
    :goto_1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    .line 163
    invoke-static {p0, v0}, Lcom/lidroid/xutils/db/table/Table;->get(Lcom/lidroid/xutils/DbUtils;Ljava/lang/Class;)Lcom/lidroid/xutils/db/table/Table;

    move-result-object v0

    .line 164
    iget-object v4, v0, Lcom/lidroid/xutils/db/table/Table;->id:Lcom/lidroid/xutils/db/table/Id;

    .line 165
    invoke-virtual {v4, p1}, Lcom/lidroid/xutils/db/table/Id;->getColumnValue(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    .line 167
    if-nez v5, :cond_1

    .line 168
    new-instance v0, Lcom/lidroid/xutils/exception/DbException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "this entity["

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "]\'s id value is null"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/lidroid/xutils/exception/DbException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 171
    :cond_1
    new-instance v2, Lcom/lidroid/xutils/db/sqlite/SqlInfo;

    invoke-direct {v2}, Lcom/lidroid/xutils/db/sqlite/SqlInfo;-><init>()V

    .line 172
    new-instance v6, Ljava/lang/StringBuffer;

    const-string v7, "UPDATE "

    invoke-direct {v6, v7}, Ljava/lang/StringBuffer;-><init>(Ljava/lang/String;)V

    .line 173
    iget-object v0, v0, Lcom/lidroid/xutils/db/table/Table;->tableName:Ljava/lang/String;

    invoke-virtual {v6, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 174
    const-string v0, " SET "

    invoke-virtual {v6, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 175
    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_2
    :goto_2
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_3

    .line 181
    invoke-virtual {v6}, Ljava/lang/StringBuffer;->length()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    invoke-virtual {v6, v0}, Ljava/lang/StringBuffer;->deleteCharAt(I)Ljava/lang/StringBuffer;

    .line 182
    const-string v0, " WHERE "

    invoke-virtual {v6, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v0

    invoke-virtual {v4}, Lcom/lidroid/xutils/db/table/Id;->getColumnName()Ljava/lang/String;

    move-result-object v1

    const-string v3, "="

    invoke-static {v1, v3, v5}, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)Lcom/lidroid/xutils/db/sqlite/WhereBuilder;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/Object;)Ljava/lang/StringBuffer;

    .line 184
    invoke-virtual {v6}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Lcom/lidroid/xutils/db/sqlite/SqlInfo;->setSql(Ljava/lang/String;)V

    move-object v0, v2

    .line 185
    goto/16 :goto_0

    .line 175
    :cond_3
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lidroid/xutils/db/table/KeyValue;

    .line 176
    if-eqz v1, :cond_4

    iget-object v7, v0, Lcom/lidroid/xutils/db/table/KeyValue;->key:Ljava/lang/String;

    invoke-virtual {v1, v7}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_2

    .line 177
    :cond_4
    iget-object v7, v0, Lcom/lidroid/xutils/db/table/KeyValue;->key:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v7

    const-string v8, "=?,"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 178
    iget-object v0, v0, Lcom/lidroid/xutils/db/table/KeyValue;->value:Ljava/lang/Object;

    invoke-virtual {v2, v0}, Lcom/lidroid/xutils/db/sqlite/SqlInfo;->addBindArgWithoutConverter(Ljava/lang/Object;)V

    goto :goto_2

    :cond_5
    move-object v1, v0

    goto/16 :goto_1
.end method

.method private static column2KeyValue(Ljava/lang/Object;Lcom/lidroid/xutils/db/table/Column;)Lcom/lidroid/xutils/db/table/KeyValue;
    .locals 3

    .prologue
    .line 264
    const/4 v0, 0x0

    .line 265
    invoke-virtual {p1}, Lcom/lidroid/xutils/db/table/Column;->getColumnName()Ljava/lang/String;

    move-result-object v2

    .line 266
    if-eqz v2, :cond_1

    .line 267
    invoke-virtual {p1, p0}, Lcom/lidroid/xutils/db/table/Column;->getColumnValue(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 268
    if-nez v0, :cond_0

    invoke-virtual {p1}, Lcom/lidroid/xutils/db/table/Column;->getDefaultValue()Ljava/lang/Object;

    move-result-object v0

    .line 269
    :cond_0
    new-instance v1, Lcom/lidroid/xutils/db/table/KeyValue;

    invoke-direct {v1, v2, v0}, Lcom/lidroid/xutils/db/table/KeyValue;-><init>(Ljava/lang/String;Ljava/lang/Object;)V

    move-object v0, v1

    .line 271
    :cond_1
    return-object v0
.end method

.method public static entity2KeyValueList(Lcom/lidroid/xutils/DbUtils;Ljava/lang/Object;)Ljava/util/List;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/lidroid/xutils/DbUtils;",
            "Ljava/lang/Object;",
            ")",
            "Ljava/util/List",
            "<",
            "Lcom/lidroid/xutils/db/table/KeyValue;",
            ">;"
        }
    .end annotation

    .prologue
    .line 276
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 278
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    .line 279
    invoke-static {p0, v0}, Lcom/lidroid/xutils/db/table/Table;->get(Lcom/lidroid/xutils/DbUtils;Ljava/lang/Class;)Lcom/lidroid/xutils/db/table/Table;

    move-result-object v0

    .line 280
    iget-object v2, v0, Lcom/lidroid/xutils/db/table/Table;->id:Lcom/lidroid/xutils/db/table/Id;

    .line 282
    invoke-virtual {v2}, Lcom/lidroid/xutils/db/table/Id;->isAutoIncrement()Z

    move-result v3

    if-nez v3, :cond_0

    .line 283
    invoke-virtual {v2, p1}, Lcom/lidroid/xutils/db/table/Id;->getColumnValue(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    .line 284
    new-instance v4, Lcom/lidroid/xutils/db/table/KeyValue;

    invoke-virtual {v2}, Lcom/lidroid/xutils/db/table/Id;->getColumnName()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v4, v2, v3}, Lcom/lidroid/xutils/db/table/KeyValue;-><init>(Ljava/lang/String;Ljava/lang/Object;)V

    .line 285
    invoke-interface {v1, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 288
    :cond_0
    iget-object v0, v0, Lcom/lidroid/xutils/db/table/Table;->columnMap:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->values()Ljava/util/Collection;

    move-result-object v0

    .line 289
    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_1
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_2

    .line 299
    return-object v1

    .line 289
    :cond_2
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lidroid/xutils/db/table/Column;

    .line 290
    instance-of v3, v0, Lcom/lidroid/xutils/db/table/Finder;

    if-nez v3, :cond_1

    .line 293
    invoke-static {p1, v0}, Lcom/lidroid/xutils/db/sqlite/SqlInfoBuilder;->column2KeyValue(Ljava/lang/Object;Lcom/lidroid/xutils/db/table/Column;)Lcom/lidroid/xutils/db/table/KeyValue;

    move-result-object v0

    .line 294
    if-eqz v0, :cond_1

    .line 295
    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0
.end method
