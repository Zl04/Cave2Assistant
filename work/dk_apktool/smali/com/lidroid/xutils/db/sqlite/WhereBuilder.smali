.class public Lcom/lidroid/xutils/db/sqlite/WhereBuilder;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field private final whereItems:Ljava/util/List;
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
.method private constructor <init>()V
    .locals 1

    .prologue
    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 37
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->whereItems:Ljava/util/List;

    .line 38
    return-void
.end method

.method private appendCondition(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)V
    .locals 8

    .prologue
    const/4 v0, 0x0

    const/4 v1, 0x0

    const/16 v7, 0x27

    const/4 v6, -0x1

    .line 116
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    .line 118
    iget-object v3, p0, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->whereItems:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    if-lez v3, :cond_0

    .line 119
    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 123
    :cond_0
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_1

    .line 124
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v4, " "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 128
    :cond_1
    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 131
    const-string v3, "!="

    invoke-virtual {v3, p3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 132
    const-string p3, "<>"

    .line 138
    :cond_2
    :goto_0
    if-nez p4, :cond_6

    .line 139
    const-string v0, "="

    invoke-virtual {v0, p3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 140
    const-string v0, " IS NULL"

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 237
    :goto_1
    iget-object v0, p0, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->whereItems:Ljava/util/List;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 238
    return-void

    .line 133
    :cond_3
    const-string v3, "=="

    invoke-virtual {v3, p3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 134
    const-string p3, "="

    goto :goto_0

    .line 141
    :cond_4
    const-string v0, "<>"

    invoke-virtual {v0, p3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 142
    const-string v0, " IS NOT NULL"

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_1

    .line 144
    :cond_5
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, " "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " NULL"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_1

    .line 147
    :cond_6
    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, " "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 149
    const-string v3, "IN"

    invoke-virtual {v3, p3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_d

    .line 151
    instance-of v3, p4, Ljava/lang/Iterable;

    if-eqz v3, :cond_7

    .line 152
    check-cast p4, Ljava/lang/Iterable;

    .line 161
    :goto_2
    if-eqz p4, :cond_c

    .line 162
    new-instance v1, Ljava/lang/StringBuffer;

    const-string v0, "("

    invoke-direct {v1, v0}, Ljava/lang/StringBuffer;-><init>(Ljava/lang/String;)V

    .line 163
    invoke-interface {p4}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_3
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_9

    .line 176
    invoke-virtual {v1}, Ljava/lang/StringBuffer;->length()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuffer;->deleteCharAt(I)Ljava/lang/StringBuffer;

    .line 177
    const-string v0, ")"

    invoke-virtual {v1, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 178
    invoke-virtual {v1}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto/16 :goto_1

    .line 153
    :cond_7
    invoke-virtual {p4}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Class;->isArray()Z

    move-result v3

    if-eqz v3, :cond_1a

    .line 154
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 155
    invoke-static {p4}, Ljava/lang/reflect/Array;->getLength(Ljava/lang/Object;)I

    move-result v3

    .line 156
    :goto_4
    if-lt v1, v3, :cond_8

    move-object p4, v0

    .line 159
    goto :goto_2

    .line 157
    :cond_8
    invoke-static {p4, v1}, Ljava/lang/reflect/Array;->get(Ljava/lang/Object;I)Ljava/lang/Object;

    move-result-object v4

    invoke-virtual {v0, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 156
    add-int/lit8 v1, v1, 0x1

    goto :goto_4

    .line 163
    :cond_9
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    .line 164
    invoke-static {v0}, Lcom/lidroid/xutils/db/table/ColumnUtils;->convert2DbColumnValueIfNeeded(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 165
    sget-object v4, Lcom/lidroid/xutils/db/sqlite/ColumnDbType;->TEXT:Lcom/lidroid/xutils/db/sqlite/ColumnDbType;

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v5

    invoke-static {v5}, Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;->getDbColumnType(Ljava/lang/Class;)Lcom/lidroid/xutils/db/sqlite/ColumnDbType;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/lidroid/xutils/db/sqlite/ColumnDbType;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_b

    .line 166
    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    .line 167
    invoke-virtual {v0, v7}, Ljava/lang/String;->indexOf(I)I

    move-result v4

    if-eq v4, v6, :cond_a

    .line 168
    const-string v4, "\'"

    const-string v5, "\'\'"

    invoke-virtual {v0, v4, v5}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    .line 170
    :cond_a
    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "\'"

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v4, "\'"

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 174
    :goto_5
    const-string v0, ","

    invoke-virtual {v1, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    goto/16 :goto_3

    .line 172
    :cond_b
    invoke-virtual {v1, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/Object;)Ljava/lang/StringBuffer;

    goto :goto_5

    .line 180
    :cond_c
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "value must be an Array or an Iterable."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 182
    :cond_d
    const-string v3, "BETWEEN"

    invoke-virtual {v3, p3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_16

    .line 184
    instance-of v3, p4, Ljava/lang/Iterable;

    if-eqz v3, :cond_e

    .line 185
    check-cast p4, Ljava/lang/Iterable;

    .line 194
    :goto_6
    if-eqz p4, :cond_15

    .line 195
    invoke-interface {p4}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .line 196
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-nez v1, :cond_10

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "value must have tow items."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 186
    :cond_e
    invoke-virtual {p4}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Class;->isArray()Z

    move-result v3

    if-eqz v3, :cond_19

    .line 187
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 188
    invoke-static {p4}, Ljava/lang/reflect/Array;->getLength(Ljava/lang/Object;)I

    move-result v3

    .line 189
    :goto_7
    if-lt v1, v3, :cond_f

    move-object p4, v0

    .line 192
    goto :goto_6

    .line 190
    :cond_f
    invoke-static {p4, v1}, Ljava/lang/reflect/Array;->get(Ljava/lang/Object;I)Ljava/lang/Object;

    move-result-object v4

    invoke-virtual {v0, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 189
    add-int/lit8 v1, v1, 0x1

    goto :goto_7

    .line 197
    :cond_10
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    .line 198
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-nez v3, :cond_11

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "value must have tow items."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 199
    :cond_11
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    .line 201
    invoke-static {v1}, Lcom/lidroid/xutils/db/table/ColumnUtils;->convert2DbColumnValueIfNeeded(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 202
    invoke-static {v0}, Lcom/lidroid/xutils/db/table/ColumnUtils;->convert2DbColumnValueIfNeeded(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    .line 204
    sget-object v0, Lcom/lidroid/xutils/db/sqlite/ColumnDbType;->TEXT:Lcom/lidroid/xutils/db/sqlite/ColumnDbType;

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    invoke-static {v4}, Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;->getDbColumnType(Ljava/lang/Class;)Lcom/lidroid/xutils/db/sqlite/ColumnDbType;

    move-result-object v4

    invoke-virtual {v0, v4}, Lcom/lidroid/xutils/db/sqlite/ColumnDbType;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_14

    .line 205
    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    .line 206
    invoke-virtual {v0, v7}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    if-eq v1, v6, :cond_12

    .line 207
    const-string v1, "\'"

    const-string v4, "\'\'"

    invoke-virtual {v0, v1, v4}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    .line 209
    :cond_12
    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    .line 210
    invoke-virtual {v1, v7}, Ljava/lang/String;->indexOf(I)I

    move-result v3

    if-eq v3, v6, :cond_13

    .line 211
    const-string v3, "\'"

    const-string v4, "\'\'"

    invoke-virtual {v1, v3, v4}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v1

    .line 213
    :cond_13
    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "\'"

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "\'"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 214
    const-string v0, " AND "

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 215
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v3, "\'"

    invoke-direct {v0, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto/16 :goto_1

    .line 217
    :cond_14
    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    .line 218
    const-string v0, " AND "

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 219
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    goto/16 :goto_1

    .line 222
    :cond_15
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "value must be an Array or an Iterable."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 225
    :cond_16
    invoke-static {p4}, Lcom/lidroid/xutils/db/table/ColumnUtils;->convert2DbColumnValueIfNeeded(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 226
    sget-object v1, Lcom/lidroid/xutils/db/sqlite/ColumnDbType;->TEXT:Lcom/lidroid/xutils/db/sqlite/ColumnDbType;

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-static {v3}, Lcom/lidroid/xutils/db/converter/ColumnConverterFactory;->getDbColumnType(Ljava/lang/Class;)Lcom/lidroid/xutils/db/sqlite/ColumnDbType;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/lidroid/xutils/db/sqlite/ColumnDbType;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_18

    .line 227
    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    .line 228
    invoke-virtual {v0, v7}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    if-eq v1, v6, :cond_17

    .line 229
    const-string v1, "\'"

    const-string v3, "\'\'"

    invoke-virtual {v0, v1, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    .line 231
    :cond_17
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v3, "\'"

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto/16 :goto_1

    .line 233
    :cond_18
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    goto/16 :goto_1

    :cond_19
    move-object p4, v0

    goto/16 :goto_6

    :cond_1a
    move-object p4, v0

    goto/16 :goto_2
.end method

.method public static b()Lcom/lidroid/xutils/db/sqlite/WhereBuilder;
    .locals 1

    .prologue
    .line 46
    new-instance v0, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;

    invoke-direct {v0}, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;-><init>()V

    return-object v0
.end method

.method public static b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)Lcom/lidroid/xutils/db/sqlite/WhereBuilder;
    .locals 2

    .prologue
    .line 58
    new-instance v0, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;

    invoke-direct {v0}, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;-><init>()V

    .line 59
    const/4 v1, 0x0

    invoke-direct {v0, v1, p0, p1, p2}, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->appendCondition(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)V

    .line 60
    return-object v0
.end method


# virtual methods
.method public and(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)Lcom/lidroid/xutils/db/sqlite/WhereBuilder;
    .locals 1

    .prologue
    .line 72
    iget-object v0, p0, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->whereItems:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    invoke-direct {p0, v0, p1, p2, p3}, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->appendCondition(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)V

    .line 73
    return-object p0

    .line 72
    :cond_0
    const-string v0, "AND"

    goto :goto_0
.end method

.method public expr(Ljava/lang/String;)Lcom/lidroid/xutils/db/sqlite/WhereBuilder;
    .locals 3

    .prologue
    .line 90
    iget-object v0, p0, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->whereItems:Ljava/util/List;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, " "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 91
    return-object p0
.end method

.method public expr(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)Lcom/lidroid/xutils/db/sqlite/WhereBuilder;
    .locals 1

    .prologue
    .line 95
    const/4 v0, 0x0

    invoke-direct {p0, v0, p1, p2, p3}, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->appendCondition(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)V

    .line 96
    return-object p0
.end method

.method public getWhereItemSize()I
    .locals 1

    .prologue
    .line 100
    iget-object v0, p0, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->whereItems:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public or(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)Lcom/lidroid/xutils/db/sqlite/WhereBuilder;
    .locals 1

    .prologue
    .line 85
    iget-object v0, p0, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->whereItems:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    invoke-direct {p0, v0, p1, p2, p3}, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->appendCondition(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)V

    .line 86
    return-object p0

    .line 85
    :cond_0
    const-string v0, "OR"

    goto :goto_0
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .prologue
    .line 105
    iget-object v0, p0, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->whereItems:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_0

    .line 106
    const-string v0, ""

    .line 112
    :goto_0
    return-object v0

    .line 108
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 109
    iget-object v0, p0, Lcom/lidroid/xutils/db/sqlite/WhereBuilder;->whereItems:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_1

    .line 112
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 109
    :cond_1
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 110
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_1
.end method
