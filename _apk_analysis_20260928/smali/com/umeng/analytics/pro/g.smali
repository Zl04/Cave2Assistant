.class public Lcom/umeng/analytics/pro/g;
.super Ljava/lang/Object;
.source "UMStoreManager.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/umeng/analytics/pro/g$a;,
        Lcom/umeng/analytics/pro/g$b;
    }
.end annotation


# static fields
.field public static final a:I = 0x801

.field public static final b:I = 0x802

.field private static c:Landroid/content/Context; = null

.field private static d:Ljava/lang/String; = null

.field private static final e:Ljava/lang/String; = "umeng+"

.field private static final f:Ljava/lang/String; = "ek__id"

.field private static final g:Ljava/lang/String; = "ek_key"


# instance fields
.field private h:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private i:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private j:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 35
    sput-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    .line 36
    sput-object v0, Lcom/umeng/analytics/pro/g;->d:Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    .prologue
    .line 87
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 41
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/umeng/analytics/pro/g;->h:Ljava/util/List;

    .line 42
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/umeng/analytics/pro/g;->i:Ljava/util/List;

    .line 43
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/umeng/analytics/pro/g;->j:Ljava/lang/String;

    .line 87
    return-void
.end method

.method synthetic constructor <init>(Lcom/umeng/analytics/pro/g$1;)V
    .locals 0

    .prologue
    .line 34
    invoke-direct {p0}, Lcom/umeng/analytics/pro/g;-><init>()V

    return-void
.end method

.method public static a(Landroid/content/Context;)Lcom/umeng/analytics/pro/g;
    .locals 2

    .prologue
    .line 96
    invoke-static {}, Lcom/umeng/analytics/pro/g$b;->a()Lcom/umeng/analytics/pro/g;

    move-result-object v0

    .line 97
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    if-nez v1, :cond_0

    .line 98
    if-eqz p0, :cond_0

    .line 99
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    sput-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    .line 100
    invoke-direct {v0}, Lcom/umeng/analytics/pro/g;->h()V

    .line 103
    :cond_0
    return-object v0
.end method

.method private a(Lorg/json/JSONObject;Z)Ljava/lang/String;
    .locals 18

    .prologue
    .line 748
    const/4 v4, 0x0

    .line 749
    const/4 v3, 0x0

    .line 750
    const/4 v2, 0x0

    .line 752
    :try_start_0
    sget-object v5, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v5}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v5

    invoke-virtual {v5}, Lcom/umeng/analytics/pro/e;->a()Landroid/database/sqlite/SQLiteDatabase;

    move-result-object v4

    .line 753
    invoke-virtual {v4}, Landroid/database/sqlite/SQLiteDatabase;->beginTransaction()V

    .line 754
    const-string v5, "select *  from __sd"

    .line 756
    const/4 v6, 0x0

    invoke-virtual {v4, v5, v6}, Landroid/database/sqlite/SQLiteDatabase;->rawQuery(Ljava/lang/String;[Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v3

    .line 757
    if-eqz v3, :cond_a

    .line 759
    new-instance v5, Lorg/json/JSONArray;

    invoke-direct {v5}, Lorg/json/JSONArray;-><init>()V

    .line 762
    :cond_0
    invoke-interface {v3}, Landroid/database/Cursor;->moveToNext()Z

    move-result v6

    if-eqz v6, :cond_6

    .line 763
    new-instance v6, Lorg/json/JSONObject;

    invoke-direct {v6}, Lorg/json/JSONObject;-><init>()V

    .line 764
    const-string v7, "__f"

    invoke-interface {v3, v7}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v7

    invoke-interface {v3, v7}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v7

    .line 765
    const-string v8, "__e"

    invoke-interface {v3, v8}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v8

    invoke-interface {v3, v8}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v8

    .line 766
    const-string v9, "__ii"

    .line 767
    invoke-interface {v3, v9}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v9

    invoke-interface {v3, v9}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v2

    .line 770
    invoke-static {v7}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v9

    if-nez v9, :cond_0

    invoke-static {v8}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v9

    if-nez v9, :cond_0

    .line 771
    invoke-static {v7}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v10

    invoke-static {v8}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v12

    sub-long/2addr v10, v12

    .line 772
    const-wide/16 v12, 0x0

    cmp-long v9, v10, v12

    if-lez v9, :cond_5

    .line 773
    const-string v9, "__a"

    invoke-interface {v3, v9}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v9

    invoke-interface {v3, v9}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v9

    .line 774
    const-string v10, "__b"

    .line 775
    invoke-interface {v3, v10}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v10

    invoke-interface {v3, v10}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v10

    .line 776
    const-string v11, "__c"

    .line 777
    invoke-interface {v3, v11}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v11

    invoke-interface {v3, v11}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v11

    .line 778
    const-string v12, "__d"

    .line 779
    invoke-interface {v3, v12}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v12

    invoke-interface {v3, v12}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v12

    .line 780
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/umeng/analytics/pro/g;->h:Ljava/util/List;

    invoke-interface {v13, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 781
    const-string v13, "id"

    invoke-virtual {v6, v13, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 782
    const-string v13, "start_time"

    invoke-virtual {v6, v13, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 783
    const-string v13, "end_time"

    invoke-virtual {v6, v13, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 784
    const-string v13, "duration"

    .line 785
    invoke-static {v7}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v14

    invoke-static {v8}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v16

    sub-long v14, v14, v16

    .line 784
    invoke-virtual {v6, v13, v14, v15}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 786
    invoke-static {v9}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v7

    if-nez v7, :cond_1

    .line 787
    const-string v7, "pages"

    new-instance v8, Lorg/json/JSONArray;

    move-object/from16 v0, p0

    invoke-virtual {v0, v9}, Lcom/umeng/analytics/pro/g;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-direct {v8, v9}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6, v7, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 789
    :cond_1
    invoke-static {v10}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v7

    if-nez v7, :cond_2

    .line 790
    const-string v7, "autopages"

    new-instance v8, Lorg/json/JSONArray;

    .line 791
    move-object/from16 v0, p0

    invoke-virtual {v0, v10}, Lcom/umeng/analytics/pro/g;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-direct {v8, v9}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    .line 790
    invoke-virtual {v6, v7, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 793
    :cond_2
    invoke-static {v11}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v7

    if-nez v7, :cond_3

    .line 794
    const-string v7, "traffic"

    new-instance v8, Lorg/json/JSONObject;

    .line 795
    move-object/from16 v0, p0

    invoke-virtual {v0, v11}, Lcom/umeng/analytics/pro/g;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-direct {v8, v9}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 794
    invoke-virtual {v6, v7, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 797
    :cond_3
    invoke-static {v12}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v7

    if-nez v7, :cond_4

    .line 798
    const-string v7, "locations"

    new-instance v8, Lorg/json/JSONArray;

    .line 799
    move-object/from16 v0, p0

    invoke-virtual {v0, v12}, Lcom/umeng/analytics/pro/g;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-direct {v8, v9}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    .line 798
    invoke-virtual {v6, v7, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 801
    :cond_4
    invoke-virtual {v6}, Lorg/json/JSONObject;->length()I

    move-result v7

    if-lez v7, :cond_5

    .line 802
    invoke-virtual {v5, v6}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 806
    :cond_5
    if-eqz p2, :cond_0

    .line 812
    :cond_6
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/umeng/analytics/pro/g;->h:Ljava/util/List;

    invoke-interface {v6}, Ljava/util/List;->size()I
    :try_end_0
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v6

    const/4 v7, 0x1

    if-ge v6, v7, :cond_9

    .line 828
    if-eqz v3, :cond_7

    .line 829
    invoke-interface {v3}, Landroid/database/Cursor;->close()V

    .line 832
    :cond_7
    if-eqz v4, :cond_8

    .line 833
    :try_start_1
    invoke-virtual {v4}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_2

    .line 836
    :cond_8
    :goto_0
    sget-object v3, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v3}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v3

    invoke-virtual {v3}, Lcom/umeng/analytics/pro/e;->b()V

    .line 838
    :goto_1
    return-object v2

    .line 815
    :cond_9
    :try_start_2
    invoke-virtual {v5}, Lorg/json/JSONArray;->length()I

    move-result v6

    if-lez v6, :cond_a

    .line 816
    const-string v6, "sessions"

    move-object/from16 v0, p1

    invoke-virtual {v0, v6, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 821
    :cond_a
    invoke-virtual {v4}, Landroid/database/sqlite/SQLiteDatabase;->setTransactionSuccessful()V
    :try_end_2
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 828
    if-eqz v3, :cond_b

    .line 829
    invoke-interface {v3}, Landroid/database/Cursor;->close()V

    .line 832
    :cond_b
    if-eqz v4, :cond_c

    .line 833
    :try_start_3
    invoke-virtual {v4}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_3

    .line 836
    :cond_c
    :goto_2
    sget-object v3, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v3}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v3

    invoke-virtual {v3}, Lcom/umeng/analytics/pro/e;->b()V

    goto :goto_1

    .line 823
    :catch_0
    move-exception v5

    .line 825
    :try_start_4
    sget-object v5, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v5}, Lcom/umeng/analytics/pro/f;->a(Landroid/content/Context;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 828
    if-eqz v3, :cond_d

    .line 829
    invoke-interface {v3}, Landroid/database/Cursor;->close()V

    .line 832
    :cond_d
    if-eqz v4, :cond_e

    .line 833
    :try_start_5
    invoke-virtual {v4}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_4

    .line 836
    :cond_e
    :goto_3
    sget-object v3, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v3}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v3

    invoke-virtual {v3}, Lcom/umeng/analytics/pro/e;->b()V

    goto :goto_1

    .line 826
    :catch_1
    move-exception v5

    .line 828
    if-eqz v3, :cond_f

    .line 829
    invoke-interface {v3}, Landroid/database/Cursor;->close()V

    .line 832
    :cond_f
    if-eqz v4, :cond_10

    .line 833
    :try_start_6
    invoke-virtual {v4}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_5

    .line 836
    :cond_10
    :goto_4
    sget-object v3, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v3}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v3

    invoke-virtual {v3}, Lcom/umeng/analytics/pro/e;->b()V

    goto :goto_1

    .line 828
    :catchall_0
    move-exception v2

    if-eqz v3, :cond_11

    .line 829
    invoke-interface {v3}, Landroid/database/Cursor;->close()V

    .line 832
    :cond_11
    if-eqz v4, :cond_12

    .line 833
    :try_start_7
    invoke-virtual {v4}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_6

    .line 836
    :cond_12
    :goto_5
    sget-object v3, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v3}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v3

    invoke-virtual {v3}, Lcom/umeng/analytics/pro/e;->b()V

    throw v2

    .line 835
    :catch_2
    move-exception v3

    goto :goto_0

    :catch_3
    move-exception v3

    goto :goto_2

    :catch_4
    move-exception v3

    goto :goto_3

    :catch_5
    move-exception v3

    goto :goto_4

    :catch_6
    move-exception v3

    goto :goto_5
.end method

.method private a(Ljava/lang/String;Lorg/json/JSONObject;Landroid/database/sqlite/SQLiteDatabase;)V
    .locals 6

    .prologue
    const/4 v1, 0x0

    .line 338
    .line 341
    :try_start_0
    const-string v0, "__d"

    invoke-virtual {p2, v0}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v3

    .line 345
    if-eqz v3, :cond_7

    .line 346
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "select __d from __sd where __ii=\""

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "\""

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 349
    const/4 v2, 0x0

    invoke-virtual {p3, v0, v2}, Landroid/database/sqlite/SQLiteDatabase;->rawQuery(Ljava/lang/String;[Ljava/lang/String;)Landroid/database/Cursor;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 350
    if-eqz v0, :cond_6

    .line 351
    :goto_0
    :try_start_1
    invoke-interface {v0}, Landroid/database/Cursor;->moveToNext()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 352
    const-string v1, "__d"

    invoke-interface {v0, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    invoke-interface {v0, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    .line 353
    invoke-virtual {p0, v1}, Lcom/umeng/analytics/pro/g;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_0
    move-object v2, v1

    .line 358
    :goto_1
    if-eqz v3, :cond_2

    .line 359
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    .line 360
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_1

    .line 361
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1, v2}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    .line 363
    :cond_1
    invoke-virtual {v1, v3}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 365
    invoke-virtual {v1}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/umeng/analytics/pro/g;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 366
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_2

    .line 367
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "update  __sd set __d=\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\" where "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "__ii"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "=\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 370
    invoke-virtual {p3, v1}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V

    .line 374
    :cond_2
    const-string v1, "__c"

    invoke-virtual {p2, v1}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1

    .line 375
    if-eqz v1, :cond_3

    .line 376
    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/umeng/analytics/pro/g;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 377
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_3

    .line 378
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "update  __sd set __c=\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\" where "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "__ii"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "=\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 381
    invoke-virtual {p3, v1}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V

    .line 384
    :cond_3
    const-string v1, "__f"

    invoke-virtual {p2, v1}, Lorg/json/JSONObject;->getLong(Ljava/lang/String;)J

    move-result-wide v2

    .line 385
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "update  __sd set __f=\""

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 386
    invoke-static {v2, v3}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\" where "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "__ii"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "=\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 388
    invoke-virtual {p3, v1}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 392
    if-eqz v0, :cond_4

    .line 393
    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    .line 397
    :cond_4
    :goto_2
    return-void

    .line 389
    :catch_0
    move-exception v0

    move-object v0, v1

    .line 392
    :goto_3
    if-eqz v0, :cond_4

    .line 393
    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    goto :goto_2

    .line 392
    :catchall_0
    move-exception v0

    :goto_4
    if-eqz v1, :cond_5

    .line 393
    invoke-interface {v1}, Landroid/database/Cursor;->close()V

    :cond_5
    throw v0

    .line 392
    :catchall_1
    move-exception v1

    move-object v5, v1

    move-object v1, v0

    move-object v0, v5

    goto :goto_4

    .line 389
    :catch_1
    move-exception v1

    goto :goto_3

    :cond_6
    move-object v2, v1

    goto/16 :goto_1

    :cond_7
    move-object v2, v1

    move-object v0, v1

    goto/16 :goto_1
.end method

.method private a(Ljava/lang/String;Lorg/json/JSONObject;Landroid/database/sqlite/SQLiteDatabase;Ljava/lang/String;)V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 410
    .line 412
    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "select "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, " from "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "__sd"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, " where "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "__ii"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "=\""

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "\""

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 414
    const/4 v2, 0x0

    invoke-virtual {p3, v0, v2}, Landroid/database/sqlite/SQLiteDatabase;->rawQuery(Ljava/lang/String;[Ljava/lang/String;)Landroid/database/Cursor;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 416
    if-eqz v0, :cond_5

    .line 417
    :goto_0
    :try_start_1
    invoke-interface {v0}, Landroid/database/Cursor;->moveToNext()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 418
    invoke-interface {v0, p4}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    invoke-interface {v0, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    .line 419
    invoke-virtual {p0, v1}, Lcom/umeng/analytics/pro/g;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_0
    move-object v2, v1

    .line 424
    :goto_1
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    .line 425
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_1

    .line 426
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1, v2}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    .line 428
    :cond_1
    invoke-virtual {v1, p2}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 430
    invoke-virtual {v1}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/umeng/analytics/pro/g;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 431
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_2

    .line 432
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "update __sd set "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "=\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\" where "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "__ii"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "=\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 434
    invoke-virtual {p3, v1}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 439
    :cond_2
    if-eqz v0, :cond_3

    .line 440
    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    .line 443
    :cond_3
    :goto_2
    return-void

    .line 437
    :catch_0
    move-exception v0

    move-object v0, v1

    .line 439
    :goto_3
    if-eqz v0, :cond_3

    .line 440
    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    goto :goto_2

    .line 439
    :catchall_0
    move-exception v0

    :goto_4
    if-eqz v1, :cond_4

    .line 440
    invoke-interface {v1}, Landroid/database/Cursor;->close()V

    :cond_4
    throw v0

    .line 439
    :catchall_1
    move-exception v1

    move-object v4, v1

    move-object v1, v0

    move-object v0, v4

    goto :goto_4

    .line 437
    :catch_1
    move-exception v1

    goto :goto_3

    :cond_5
    move-object v2, v1

    goto :goto_1
.end method

.method private a(Lorg/json/JSONObject;Ljava/lang/String;)V
    .locals 11

    .prologue
    const/4 v0, 0x0

    .line 557
    .line 560
    :try_start_0
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/analytics/pro/e;->a()Landroid/database/sqlite/SQLiteDatabase;
    :try_end_0
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_0 .. :try_end_0} :catch_8
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_6
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    move-result-object v2

    .line 561
    :try_start_1
    invoke-virtual {v2}, Landroid/database/sqlite/SQLiteDatabase;->beginTransaction()V

    .line 562
    const-string v1, "select *  from __et"

    .line 563
    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_0

    .line 564
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "select *  from __et where __i=\""

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "\""

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 568
    :cond_0
    const/4 v3, 0x0

    invoke-virtual {v2, v1, v3}, Landroid/database/sqlite/SQLiteDatabase;->rawQuery(Ljava/lang/String;[Ljava/lang/String;)Landroid/database/Cursor;
    :try_end_1
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_1 .. :try_end_1} :catch_9
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_7
    .catchall {:try_start_1 .. :try_end_1} :catchall_2

    move-result-object v1

    .line 569
    if-eqz v1, :cond_12

    .line 575
    :try_start_2
    new-instance v5, Lorg/json/JSONObject;

    invoke-direct {v5}, Lorg/json/JSONObject;-><init>()V

    .line 576
    new-instance v6, Lorg/json/JSONObject;

    invoke-direct {v6}, Lorg/json/JSONObject;-><init>()V

    .line 577
    invoke-static {}, Lcom/umeng/analytics/pro/o;->a()Lcom/umeng/analytics/pro/o;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/o;->c()Ljava/lang/String;

    move-result-object v3

    .line 579
    :cond_1
    :goto_0
    invoke-interface {v1}, Landroid/database/Cursor;->moveToNext()Z

    move-result v0

    if-eqz v0, :cond_c

    .line 580
    const-string v0, "__t"

    invoke-interface {v1, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    invoke-interface {v1, v0}, Landroid/database/Cursor;->getInt(I)I

    move-result v4

    .line 581
    const-string v0, "__i"

    invoke-interface {v1, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    invoke-interface {v1, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    .line 582
    const-string v7, "__s"

    invoke-interface {v1, v7}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v7

    invoke-interface {v1, v7}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v7

    .line 588
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v8

    if-nez v8, :cond_2

    const-string v8, "-1"

    invoke-virtual {v8, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_3

    .line 589
    :cond_2
    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_1

    move-object v0, v3

    .line 596
    :cond_3
    const/4 v8, 0x0

    invoke-interface {v1, v8}, Landroid/database/Cursor;->getInt(I)I

    move-result v8

    .line 598
    iget-object v9, p0, Lcom/umeng/analytics/pro/g;->i:Ljava/util/List;

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-interface {v9, v8}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 600
    packed-switch v4, :pswitch_data_0

    goto :goto_0

    .line 602
    :pswitch_0
    invoke-static {v7}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_1

    .line 603
    new-instance v8, Lorg/json/JSONObject;

    invoke-virtual {p0, v7}, Lcom/umeng/analytics/pro/g;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v8, v4}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 604
    invoke-virtual {v5, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_6

    .line 605
    invoke-virtual {v5, v0}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v4

    .line 609
    :goto_1
    invoke-virtual {v4, v8}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 610
    invoke-virtual {v5, v0, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_2
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    .line 671
    :catch_0
    move-exception v0

    move-object v0, v1

    move-object v1, v2

    .line 673
    :goto_2
    :try_start_3
    sget-object v2, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v2}, Lcom/umeng/analytics/pro/f;->a(Landroid/content/Context;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_3

    .line 676
    if-eqz v0, :cond_4

    .line 677
    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    .line 680
    :cond_4
    if-eqz v1, :cond_5

    .line 681
    :try_start_4
    invoke-virtual {v1}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3

    .line 684
    :cond_5
    :goto_3
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    .line 687
    :goto_4
    return-void

    .line 607
    :cond_6
    :try_start_5
    new-instance v4, Lorg/json/JSONArray;

    invoke-direct {v4}, Lorg/json/JSONArray;-><init>()V
    :try_end_5
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_5 .. :try_end_5} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_1
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    goto :goto_1

    .line 674
    :catch_1
    move-exception v0

    .line 676
    :goto_5
    if-eqz v1, :cond_7

    .line 677
    invoke-interface {v1}, Landroid/database/Cursor;->close()V

    .line 680
    :cond_7
    if-eqz v2, :cond_8

    .line 681
    :try_start_6
    invoke-virtual {v2}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_4

    .line 684
    :cond_8
    :goto_6
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    goto :goto_4

    .line 614
    :pswitch_1
    :try_start_7
    invoke-static {v7}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_1

    .line 615
    new-instance v8, Lorg/json/JSONObject;

    invoke-virtual {p0, v7}, Lcom/umeng/analytics/pro/g;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v8, v4}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 616
    invoke-virtual {v6, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_b

    .line 617
    invoke-virtual {v6, v0}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v4

    .line 621
    :goto_7
    invoke-virtual {v4, v8}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 622
    invoke-virtual {v6, v0, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_7
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_7 .. :try_end_7} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_1
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    goto/16 :goto_0

    .line 676
    :catchall_0
    move-exception v0

    :goto_8
    if-eqz v1, :cond_9

    .line 677
    invoke-interface {v1}, Landroid/database/Cursor;->close()V

    .line 680
    :cond_9
    if-eqz v2, :cond_a

    .line 681
    :try_start_8
    invoke-virtual {v2}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_5

    .line 684
    :cond_a
    :goto_9
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/analytics/pro/e;->b()V

    throw v0

    .line 619
    :cond_b
    :try_start_9
    new-instance v4, Lorg/json/JSONArray;

    invoke-direct {v4}, Lorg/json/JSONArray;-><init>()V

    goto :goto_7

    .line 630
    :cond_c
    invoke-virtual {v5}, Lorg/json/JSONObject;->length()I

    move-result v0

    if-lez v0, :cond_f

    .line 631
    new-instance v3, Lorg/json/JSONArray;

    invoke-direct {v3}, Lorg/json/JSONArray;-><init>()V

    .line 632
    invoke-virtual {v5}, Lorg/json/JSONObject;->keys()Ljava/util/Iterator;

    move-result-object v4

    .line 634
    :cond_d
    :goto_a
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_e

    .line 635
    new-instance v7, Lorg/json/JSONObject;

    invoke-direct {v7}, Lorg/json/JSONObject;-><init>()V

    .line 636
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 637
    invoke-virtual {v5, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 638
    new-instance v9, Lorg/json/JSONArray;

    invoke-direct {v9, v8}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    invoke-virtual {v7, v0, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 639
    invoke-virtual {v7}, Lorg/json/JSONObject;->length()I

    move-result v0

    if-lez v0, :cond_d

    .line 640
    invoke-virtual {v3, v7}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    goto :goto_a

    .line 643
    :cond_e
    invoke-virtual {v3}, Lorg/json/JSONArray;->length()I

    move-result v0

    if-lez v0, :cond_f

    .line 644
    const-string v0, "ekv"

    invoke-virtual {p1, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 647
    :cond_f
    invoke-virtual {v6}, Lorg/json/JSONObject;->length()I

    move-result v0

    if-lez v0, :cond_12

    .line 648
    new-instance v3, Lorg/json/JSONArray;

    invoke-direct {v3}, Lorg/json/JSONArray;-><init>()V

    .line 649
    invoke-virtual {v6}, Lorg/json/JSONObject;->keys()Ljava/util/Iterator;

    move-result-object v4

    .line 651
    :cond_10
    :goto_b
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_11

    .line 652
    new-instance v5, Lorg/json/JSONObject;

    invoke-direct {v5}, Lorg/json/JSONObject;-><init>()V

    .line 653
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 654
    invoke-virtual {v6, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 655
    new-instance v8, Lorg/json/JSONArray;

    invoke-direct {v8, v7}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, v0, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 656
    invoke-virtual {v5}, Lorg/json/JSONObject;->length()I

    move-result v0

    if-lez v0, :cond_10

    .line 657
    invoke-virtual {v3, v5}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    goto :goto_b

    .line 660
    :cond_11
    invoke-virtual {v3}, Lorg/json/JSONArray;->length()I

    move-result v0

    if-lez v0, :cond_12

    .line 661
    const-string v0, "gkv"

    invoke-virtual {p1, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 670
    :cond_12
    invoke-virtual {v2}, Landroid/database/sqlite/SQLiteDatabase;->setTransactionSuccessful()V
    :try_end_9
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_9 .. :try_end_9} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_9 .. :try_end_9} :catch_1
    .catchall {:try_start_9 .. :try_end_9} :catchall_0

    .line 676
    if-eqz v1, :cond_13

    .line 677
    invoke-interface {v1}, Landroid/database/Cursor;->close()V

    .line 680
    :cond_13
    if-eqz v2, :cond_14

    .line 681
    :try_start_a
    invoke-virtual {v2}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_a
    .catch Ljava/lang/Throwable; {:try_start_a .. :try_end_a} :catch_2

    .line 684
    :cond_14
    :goto_c
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    goto/16 :goto_4

    .line 683
    :catch_2
    move-exception v0

    goto :goto_c

    :catch_3
    move-exception v0

    goto/16 :goto_3

    :catch_4
    move-exception v0

    goto/16 :goto_6

    :catch_5
    move-exception v1

    goto/16 :goto_9

    .line 676
    :catchall_1
    move-exception v1

    move-object v2, v0

    move-object v10, v0

    move-object v0, v1

    move-object v1, v10

    goto/16 :goto_8

    :catchall_2
    move-exception v1

    move-object v10, v1

    move-object v1, v0

    move-object v0, v10

    goto/16 :goto_8

    :catchall_3
    move-exception v2

    move-object v10, v2

    move-object v2, v1

    move-object v1, v0

    move-object v0, v10

    goto/16 :goto_8

    .line 674
    :catch_6
    move-exception v1

    move-object v1, v0

    move-object v2, v0

    goto/16 :goto_5

    :catch_7
    move-exception v1

    move-object v1, v0

    goto/16 :goto_5

    .line 671
    :catch_8
    move-exception v1

    move-object v1, v0

    goto/16 :goto_2

    :catch_9
    move-exception v1

    move-object v1, v2

    goto/16 :goto_2

    .line 600
    :pswitch_data_0
    .packed-switch 0x801
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method private b(Lorg/json/JSONObject;Ljava/lang/String;)V
    .locals 6

    .prologue
    const/4 v0, 0x0

    .line 696
    .line 699
    :try_start_0
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/analytics/pro/e;->a()Landroid/database/sqlite/SQLiteDatabase;
    :try_end_0
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_0 .. :try_end_0} :catch_7
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v1

    .line 700
    :try_start_1
    invoke-virtual {v1}, Landroid/database/sqlite/SQLiteDatabase;->beginTransaction()V

    .line 701
    const-string v2, "select *  from __er"

    .line 702
    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_0

    .line 703
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "select *  from __er where __i=\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 707
    :cond_0
    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Landroid/database/sqlite/SQLiteDatabase;->rawQuery(Ljava/lang/String;[Ljava/lang/String;)Landroid/database/Cursor;
    :try_end_1
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_6
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result-object v0

    .line 708
    if-eqz v0, :cond_5

    .line 709
    :try_start_2
    new-instance v2, Lorg/json/JSONArray;

    invoke-direct {v2}, Lorg/json/JSONArray;-><init>()V

    .line 710
    :cond_1
    :goto_0
    invoke-interface {v0}, Landroid/database/Cursor;->moveToNext()Z

    move-result v3

    if-eqz v3, :cond_4

    .line 711
    const-string v3, "__a"

    invoke-interface {v0, v3}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v3

    invoke-interface {v0, v3}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v3

    .line 712
    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_1

    .line 713
    new-instance v4, Lorg/json/JSONObject;

    invoke-virtual {p0, v3}, Lcom/umeng/analytics/pro/g;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v4, v3}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v4}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_2
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_6
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    goto :goto_0

    .line 723
    :catch_0
    move-exception v2

    .line 725
    :goto_1
    :try_start_3
    sget-object v2, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v2}, Lcom/umeng/analytics/pro/f;->a(Landroid/content/Context;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    .line 728
    if-eqz v0, :cond_2

    .line 729
    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    .line 732
    :cond_2
    if-eqz v1, :cond_3

    .line 733
    :try_start_4
    invoke-virtual {v1}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3

    .line 736
    :cond_3
    :goto_2
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    .line 738
    :goto_3
    return-void

    .line 716
    :cond_4
    :try_start_5
    invoke-virtual {v2}, Lorg/json/JSONArray;->length()I

    move-result v3

    if-lez v3, :cond_5

    .line 717
    const-string v3, "error"

    invoke-virtual {p1, v3, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 722
    :cond_5
    invoke-virtual {v1}, Landroid/database/sqlite/SQLiteDatabase;->setTransactionSuccessful()V
    :try_end_5
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_5 .. :try_end_5} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_6
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    .line 728
    if-eqz v0, :cond_6

    .line 729
    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    .line 732
    :cond_6
    if-eqz v1, :cond_7

    .line 733
    :try_start_6
    invoke-virtual {v1}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_2

    .line 736
    :cond_7
    :goto_4
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    goto :goto_3

    .line 726
    :catch_1
    move-exception v1

    move-object v1, v0

    .line 728
    :goto_5
    if-eqz v0, :cond_8

    .line 729
    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    .line 732
    :cond_8
    if-eqz v1, :cond_9

    .line 733
    :try_start_7
    invoke-virtual {v1}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_4

    .line 736
    :cond_9
    :goto_6
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    goto :goto_3

    .line 728
    :catchall_0
    move-exception v1

    move-object v2, v0

    move-object v5, v0

    move-object v0, v1

    move-object v1, v5

    :goto_7
    if-eqz v1, :cond_a

    .line 729
    invoke-interface {v1}, Landroid/database/Cursor;->close()V

    .line 732
    :cond_a
    if-eqz v2, :cond_b

    .line 733
    :try_start_8
    invoke-virtual {v2}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_5

    .line 736
    :cond_b
    :goto_8
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/analytics/pro/e;->b()V

    throw v0

    .line 735
    :catch_2
    move-exception v0

    goto :goto_4

    :catch_3
    move-exception v0

    goto :goto_2

    :catch_4
    move-exception v0

    goto :goto_6

    :catch_5
    move-exception v1

    goto :goto_8

    .line 728
    :catchall_1
    move-exception v2

    move-object v5, v2

    move-object v2, v1

    move-object v1, v0

    move-object v0, v5

    goto :goto_7

    :catchall_2
    move-exception v2

    move-object v5, v2

    move-object v2, v1

    move-object v1, v0

    move-object v0, v5

    goto :goto_7

    .line 726
    :catch_6
    move-exception v2

    goto :goto_5

    .line 723
    :catch_7
    move-exception v1

    move-object v1, v0

    goto/16 :goto_1
.end method

.method private h()V
    .locals 1

    .prologue
    .line 107
    monitor-enter p0

    .line 108
    :try_start_0
    invoke-direct {p0}, Lcom/umeng/analytics/pro/g;->i()V

    .line 109
    iget-object v0, p0, Lcom/umeng/analytics/pro/g;->h:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    .line 110
    monitor-exit p0

    .line 111
    return-void

    .line 110
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method private i()V
    .locals 6

    .prologue
    const/4 v0, 0x0

    .line 1088
    :try_start_0
    sget-object v1, Lcom/umeng/analytics/pro/g;->d:Ljava/lang/String;

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 1089
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v2

    .line 1090
    const-string v1, "ek__id"

    const/4 v3, 0x0

    invoke-interface {v2, v1, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 1091
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 1092
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getDBencryptID(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    .line 1093
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_0

    .line 1094
    invoke-interface {v2}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    const-string v4, "ek__id"

    invoke-interface {v3, v4, v1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 1097
    :cond_0
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_5

    .line 1098
    const/4 v3, 0x1

    const/16 v4, 0x9

    invoke-virtual {v1, v3, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    .line 1099
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    .line 1101
    :goto_0
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v4

    if-ge v0, v4, :cond_4

    .line 1102
    invoke-virtual {v1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v4

    .line 1103
    invoke-static {v4}, Ljava/lang/Character;->isDigit(C)Z

    move-result v5

    if-eqz v5, :cond_3

    .line 1104
    invoke-static {v4}, Ljava/lang/Character;->toString(C)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v5

    if-nez v5, :cond_1

    .line 1105
    const/4 v4, 0x0

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 1101
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1107
    :cond_1
    invoke-static {v4}, Ljava/lang/Character;->toString(C)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v4

    rsub-int/lit8 v4, v4, 0xa

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    goto :goto_1

    .line 1130
    :catch_0
    move-exception v0

    .line 1132
    :cond_2
    :goto_2
    return-void

    .line 1110
    :cond_3
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_1

    .line 1113
    :cond_4
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/umeng/analytics/pro/g;->d:Ljava/lang/String;

    .line 1115
    :cond_5
    sget-object v0, Lcom/umeng/analytics/pro/g;->d:Ljava/lang/String;

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 1116
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/umeng/analytics/pro/g;->d:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    sget-object v3, Lcom/umeng/analytics/pro/g;->d:Ljava/lang/String;

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->reverse()Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/umeng/analytics/pro/g;->d:Ljava/lang/String;

    .line 1120
    const-string v0, "ek_key"

    const/4 v1, 0x0

    invoke-interface {v2, v0, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1121
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_6

    .line 1122
    invoke-interface {v2}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "ek_key"

    const-string v2, "umeng+"

    invoke-virtual {p0, v2}, Lcom/umeng/analytics/pro/g;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    goto :goto_2

    .line 1124
    :cond_6
    const-string v1, "umeng+"

    invoke-virtual {p0, v0}, Lcom/umeng/analytics/pro/g;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 1125
    const/4 v0, 0x1

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/umeng/analytics/pro/g;->a(ZZ)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2
.end method


# virtual methods
.method public a(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 1141
    const/4 v0, 0x0

    .line 1143
    :try_start_0
    sget-object v1, Lcom/umeng/analytics/pro/g;->d:Ljava/lang/String;

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1151
    :goto_0
    return-object p1

    .line 1146
    :cond_0
    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    sget-object v2, Lcom/umeng/analytics/pro/g;->d:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->getBytes()[B

    move-result-object v2

    invoke-static {v1, v2}, Lcom/umeng/commonsdk/statistics/common/DataHelper;->encrypt([B[B)[B

    move-result-object v1

    .line 1147
    const/4 v2, 0x0

    invoke-static {v1, v2}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object p1

    goto :goto_0

    .line 1149
    :catch_0
    move-exception v1

    move-object p1, v0

    goto :goto_0
.end method

.method public a(Z)Lorg/json/JSONObject;
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 453
    invoke-virtual {p0}, Lcom/umeng/analytics/pro/g;->a()V

    .line 454
    iget-object v0, p0, Lcom/umeng/analytics/pro/g;->i:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    .line 456
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 458
    if-nez p1, :cond_1

    .line 459
    invoke-direct {p0, v0, p1}, Lcom/umeng/analytics/pro/g;->a(Lorg/json/JSONObject;Z)Ljava/lang/String;

    .line 460
    invoke-direct {p0, v0, v1}, Lcom/umeng/analytics/pro/g;->b(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 461
    invoke-direct {p0, v0, v1}, Lcom/umeng/analytics/pro/g;->a(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 480
    :cond_0
    :goto_0
    return-object v0

    .line 472
    :cond_1
    invoke-direct {p0, v0, p1}, Lcom/umeng/analytics/pro/g;->a(Lorg/json/JSONObject;Z)Ljava/lang/String;

    move-result-object v1

    .line 473
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 474
    invoke-direct {p0, v0, v1}, Lcom/umeng/analytics/pro/g;->b(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 475
    invoke-direct {p0, v0, v1}, Lcom/umeng/analytics/pro/g;->a(Lorg/json/JSONObject;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public a()V
    .locals 1

    .prologue
    .line 120
    iget-object v0, p0, Lcom/umeng/analytics/pro/g;->h:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    .line 121
    return-void
.end method

.method public a(I)V
    .locals 3

    .prologue
    .line 46
    const/4 v0, 0x0

    .line 48
    :try_start_0
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/analytics/pro/e;->a()Landroid/database/sqlite/SQLiteDatabase;
    :try_end_0
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 49
    :try_start_1
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->beginTransaction()V

    .line 51
    if-nez p1, :cond_2

    .line 52
    const-string v1, "delete from __dp where __ty=0"

    .line 54
    invoke-virtual {v0, v1}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V

    .line 68
    :cond_0
    :goto_0
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->setTransactionSuccessful()V
    :try_end_1
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 75
    if-eqz v0, :cond_1

    .line 76
    :try_start_2
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    .line 79
    :cond_1
    :goto_1
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    .line 81
    :goto_2
    return-void

    .line 55
    :cond_2
    const/4 v1, 0x4

    if-ne p1, v1, :cond_4

    .line 56
    :try_start_3
    const-string v1, "delete from __dp where __ty=3"

    .line 58
    invoke-virtual {v0, v1}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V

    .line 59
    const-string v1, "delete from __dp where __ty=2"

    .line 61
    invoke-virtual {v0, v1}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V
    :try_end_3
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_3 .. :try_end_3} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    goto :goto_0

    .line 69
    :catch_0
    move-exception v1

    .line 71
    :try_start_4
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/f;->a(Landroid/content/Context;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    .line 75
    if-eqz v0, :cond_3

    .line 76
    :try_start_5
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_3

    .line 79
    :cond_3
    :goto_3
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    goto :goto_2

    .line 62
    :cond_4
    const/4 v1, 0x1

    if-ne p1, v1, :cond_0

    .line 63
    :try_start_6
    const-string v1, "delete from __dp where __ty=1"

    .line 65
    invoke-virtual {v0, v1}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V
    :try_end_6
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_6 .. :try_end_6} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_1
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    goto :goto_0

    .line 72
    :catch_1
    move-exception v1

    .line 75
    if-eqz v0, :cond_5

    .line 76
    :try_start_7
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_4

    .line 79
    :cond_5
    :goto_4
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    goto :goto_2

    .line 74
    :catchall_0
    move-exception v1

    move-object v2, v1

    move-object v1, v0

    move-object v0, v2

    .line 75
    :goto_5
    if-eqz v1, :cond_6

    .line 76
    :try_start_8
    invoke-virtual {v1}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_5

    .line 79
    :cond_6
    :goto_6
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/analytics/pro/e;->b()V

    throw v0

    .line 78
    :catch_2
    move-exception v0

    goto :goto_1

    :catch_3
    move-exception v0

    goto :goto_3

    :catch_4
    move-exception v0

    goto :goto_4

    :catch_5
    move-exception v1

    goto :goto_6

    .line 74
    :catchall_1
    move-exception v1

    move-object v2, v1

    move-object v1, v0

    move-object v0, v2

    goto :goto_5
.end method

.method public a(Lorg/json/JSONArray;)V
    .locals 7

    .prologue
    const/4 v0, 0x0

    .line 156
    .line 160
    :try_start_0
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/analytics/pro/e;->a()Landroid/database/sqlite/SQLiteDatabase;
    :try_end_0
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 161
    :try_start_1
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->beginTransaction()V

    .line 162
    const/4 v1, 0x0

    :goto_0
    invoke-virtual {p1}, Lorg/json/JSONArray;->length()I
    :try_end_1
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result v2

    if-ge v1, v2, :cond_2

    .line 164
    :try_start_2
    invoke-virtual {p1, v1}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v3

    .line 165
    new-instance v4, Landroid/content/ContentValues;

    invoke-direct {v4}, Landroid/content/ContentValues;-><init>()V

    .line 166
    const-string v2, "__i"

    invoke-virtual {v3, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 170
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-nez v5, :cond_0

    const-string v5, "-1"

    invoke-virtual {v5, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 171
    :cond_0
    invoke-static {}, Lcom/umeng/analytics/pro/o;->a()Lcom/umeng/analytics/pro/o;

    move-result-object v2

    invoke-virtual {v2}, Lcom/umeng/analytics/pro/o;->c()Ljava/lang/String;

    move-result-object v2

    .line 172
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 173
    const-string v2, "-1"

    .line 176
    :cond_1
    const-string v5, "__i"

    invoke-virtual {v4, v5, v2}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 177
    const-string v2, "__e"

    const-string v5, "id"

    invoke-virtual {v3, v5}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v2, v5}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 178
    const-string v2, "__t"

    const-string v5, "__t"

    .line 179
    invoke-virtual {v3, v5}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;)I

    move-result v5

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    .line 178
    invoke-virtual {v4, v2, v5}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 180
    const-string v2, "__i"

    invoke-virtual {v3, v2}, Lorg/json/JSONObject;->remove(Ljava/lang/String;)Ljava/lang/Object;

    .line 181
    const-string v2, "__t"

    invoke-virtual {v3, v2}, Lorg/json/JSONObject;->remove(Ljava/lang/String;)Ljava/lang/Object;

    .line 182
    const-string v2, "__s"

    invoke-virtual {v3}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3}, Lcom/umeng/analytics/pro/g;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v4, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 183
    const-string v2, "__et"

    const/4 v3, 0x0

    invoke-virtual {v0, v2, v3, v4}, Landroid/database/sqlite/SQLiteDatabase;->insert(Ljava/lang/String;Ljava/lang/String;Landroid/content/ContentValues;)J
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_6
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 162
    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 187
    :cond_2
    :try_start_3
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->setTransactionSuccessful()V
    :try_end_3
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_3 .. :try_end_3} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 194
    if-eqz v0, :cond_3

    .line 195
    :try_start_4
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    .line 198
    :cond_3
    :goto_2
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    .line 200
    :goto_3
    return-void

    .line 188
    :catch_0
    move-exception v1

    .line 190
    :try_start_5
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/f;->a(Landroid/content/Context;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    .line 194
    if-eqz v0, :cond_4

    .line 195
    :try_start_6
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_3

    .line 198
    :cond_4
    :goto_4
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    goto :goto_3

    .line 191
    :catch_1
    move-exception v1

    .line 194
    if-eqz v0, :cond_5

    .line 195
    :try_start_7
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_4

    .line 198
    :cond_5
    :goto_5
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    goto :goto_3

    .line 193
    :catchall_0
    move-exception v1

    move-object v6, v1

    move-object v1, v0

    move-object v0, v6

    .line 194
    :goto_6
    if-eqz v1, :cond_6

    .line 195
    :try_start_8
    invoke-virtual {v1}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_5

    .line 198
    :cond_6
    :goto_7
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/analytics/pro/e;->b()V

    throw v0

    .line 197
    :catch_2
    move-exception v0

    goto :goto_2

    :catch_3
    move-exception v0

    goto :goto_4

    :catch_4
    move-exception v0

    goto :goto_5

    :catch_5
    move-exception v1

    goto :goto_7

    .line 193
    :catchall_1
    move-exception v1

    move-object v6, v1

    move-object v1, v0

    move-object v0, v6

    goto :goto_6

    .line 184
    :catch_6
    move-exception v2

    goto :goto_1
.end method

.method public a(Lorg/json/JSONObject;I)V
    .locals 9

    .prologue
    const/4 v0, 0x0

    .line 124
    .line 127
    :try_start_0
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/analytics/pro/e;->a()Landroid/database/sqlite/SQLiteDatabase;
    :try_end_0
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 128
    :try_start_1
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->beginTransaction()V

    .line 129
    new-instance v2, Landroid/content/ContentValues;

    invoke-direct {v2}, Landroid/content/ContentValues;-><init>()V

    .line 130
    const-string v1, "__ii"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 131
    const-string v3, "__id"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    const-wide/16 v6, 0x2710

    sub-long/2addr v4, v6

    invoke-static {v4, v5}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Long;)V

    .line 133
    const-string v3, "__ii"

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_0

    const-string v1, "-1"

    :cond_0
    invoke-virtual {v2, v3, v1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 134
    const-string v1, "__ii"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->remove(Ljava/lang/String;)Ljava/lang/Object;

    .line 136
    const-string v1, "__io"

    invoke-virtual {p1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3}, Lcom/umeng/analytics/pro/g;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v1, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 137
    const-string v1, "__ty"

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v2, v1, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 138
    const-string v1, "__ve"

    sget-object v3, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v3}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getAppVersionCode(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v1, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 139
    const-string v1, "__dp"

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v3, v2}, Landroid/database/sqlite/SQLiteDatabase;->insert(Ljava/lang/String;Ljava/lang/String;Landroid/content/ContentValues;)J

    .line 140
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->setTransactionSuccessful()V
    :try_end_1
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 147
    if-eqz v0, :cond_1

    .line 148
    :try_start_2
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    .line 151
    :cond_1
    :goto_0
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    .line 153
    :goto_1
    return-void

    .line 141
    :catch_0
    move-exception v1

    .line 143
    :try_start_3
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/f;->a(Landroid/content/Context;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 147
    if-eqz v0, :cond_2

    .line 148
    :try_start_4
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3

    .line 151
    :cond_2
    :goto_2
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    goto :goto_1

    .line 144
    :catch_1
    move-exception v1

    .line 147
    if-eqz v0, :cond_3

    .line 148
    :try_start_5
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_4

    .line 151
    :cond_3
    :goto_3
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    goto :goto_1

    .line 146
    :catchall_0
    move-exception v1

    move-object v8, v1

    move-object v1, v0

    move-object v0, v8

    .line 147
    :goto_4
    if-eqz v1, :cond_4

    .line 148
    :try_start_6
    invoke-virtual {v1}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_5

    .line 151
    :cond_4
    :goto_5
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/analytics/pro/e;->b()V

    throw v0

    .line 150
    :catch_2
    move-exception v0

    goto :goto_0

    :catch_3
    move-exception v0

    goto :goto_2

    :catch_4
    move-exception v0

    goto :goto_3

    :catch_5
    move-exception v1

    goto :goto_5

    .line 146
    :catchall_1
    move-exception v1

    move-object v8, v1

    move-object v1, v0

    move-object v0, v8

    goto :goto_4
.end method

.method public a(ZLjava/lang/String;)V
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 1038
    .line 1040
    :try_start_0
    iput-object p2, p0, Lcom/umeng/analytics/pro/g;->j:Ljava/lang/String;

    .line 1041
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/analytics/pro/e;->a()Landroid/database/sqlite/SQLiteDatabase;
    :try_end_0
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 1042
    :try_start_1
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->beginTransaction()V

    .line 1043
    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 1044
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "delete from __er where __i=\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 1046
    invoke-virtual {v0, v1}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V

    .line 1047
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "delete from __et where __i=\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 1049
    invoke-virtual {v0, v1}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V

    .line 1054
    if-eqz p1, :cond_0

    .line 1055
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "update __sd set __b=\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\" where "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "__ii"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "=\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 1058
    invoke-virtual {v0, v1}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V

    .line 1059
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "update __sd set __a=\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\" where "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "__ii"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "=\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 1062
    invoke-virtual {v0, v1}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V

    .line 1066
    :cond_0
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->setTransactionSuccessful()V
    :try_end_1
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 1073
    if-eqz v0, :cond_1

    .line 1074
    :try_start_2
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    .line 1077
    :cond_1
    :goto_0
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    .line 1079
    :goto_1
    return-void

    .line 1067
    :catch_0
    move-exception v1

    .line 1069
    :try_start_3
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/f;->a(Landroid/content/Context;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1073
    if-eqz v0, :cond_2

    .line 1074
    :try_start_4
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3

    .line 1077
    :cond_2
    :goto_2
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    goto :goto_1

    .line 1070
    :catch_1
    move-exception v1

    .line 1073
    if-eqz v0, :cond_3

    .line 1074
    :try_start_5
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_4

    .line 1077
    :cond_3
    :goto_3
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    goto :goto_1

    .line 1072
    :catchall_0
    move-exception v1

    move-object v3, v1

    move-object v1, v0

    move-object v0, v3

    .line 1073
    :goto_4
    if-eqz v1, :cond_4

    .line 1074
    :try_start_6
    invoke-virtual {v1}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_5

    .line 1077
    :cond_4
    :goto_5
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/analytics/pro/e;->b()V

    throw v0

    .line 1076
    :catch_2
    move-exception v0

    goto :goto_0

    :catch_3
    move-exception v0

    goto :goto_2

    :catch_4
    move-exception v0

    goto :goto_3

    :catch_5
    move-exception v1

    goto :goto_5

    .line 1072
    :catchall_1
    move-exception v1

    move-object v3, v1

    move-object v1, v0

    move-object v0, v3

    goto :goto_4
.end method

.method public a(ZZ)V
    .locals 5

    .prologue
    .line 848
    const/4 v0, 0x0

    .line 850
    :try_start_0
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/analytics/pro/e;->a()Landroid/database/sqlite/SQLiteDatabase;
    :try_end_0
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v1

    .line 851
    :try_start_1
    invoke-virtual {v1}, Landroid/database/sqlite/SQLiteDatabase;->beginTransaction()V

    .line 852
    const-string v0, ""

    .line 854
    if-eqz p2, :cond_2

    .line 855
    if-eqz p1, :cond_0

    .line 856
    const-string v0, "delete from __sd"

    .line 857
    invoke-virtual {v1, v0}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V

    .line 870
    :cond_0
    invoke-virtual {v1}, Landroid/database/sqlite/SQLiteDatabase;->setTransactionSuccessful()V
    :try_end_1
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_1 .. :try_end_1} :catch_7
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_6
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 877
    if-eqz v1, :cond_1

    .line 878
    :try_start_2
    invoke-virtual {v1}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    .line 881
    :cond_1
    :goto_0
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    .line 883
    :goto_1
    return-void

    .line 861
    :cond_2
    :try_start_3
    iget-object v0, p0, Lcom/umeng/analytics/pro/g;->h:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_0

    .line 862
    const/4 v0, 0x0

    move v2, v0

    :goto_2
    iget-object v0, p0, Lcom/umeng/analytics/pro/g;->h:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v2, v0, :cond_0

    .line 863
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "delete from __sd where __ii=\""

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v0, p0, Lcom/umeng/analytics/pro/g;->h:Ljava/util/List;

    .line 864
    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "\""

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 865
    invoke-virtual {v1, v0}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V
    :try_end_3
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_3 .. :try_end_3} :catch_7
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_6
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 862
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_2

    .line 871
    :catch_0
    move-exception v1

    .line 873
    :goto_3
    :try_start_4
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/f;->a(Landroid/content/Context;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    .line 877
    if-eqz v0, :cond_3

    .line 878
    :try_start_5
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_3

    .line 881
    :cond_3
    :goto_4
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    goto :goto_1

    .line 874
    :catch_1
    move-exception v1

    move-object v1, v0

    .line 877
    :goto_5
    if-eqz v1, :cond_4

    .line 878
    :try_start_6
    invoke-virtual {v1}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_4

    .line 881
    :cond_4
    :goto_6
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    goto :goto_1

    .line 876
    :catchall_0
    move-exception v1

    move-object v4, v1

    move-object v1, v0

    move-object v0, v4

    .line 877
    :goto_7
    if-eqz v1, :cond_5

    .line 878
    :try_start_7
    invoke-virtual {v1}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_5

    .line 881
    :cond_5
    :goto_8
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/analytics/pro/e;->b()V

    throw v0

    .line 880
    :catch_2
    move-exception v0

    goto :goto_0

    :catch_3
    move-exception v0

    goto :goto_4

    :catch_4
    move-exception v0

    goto :goto_6

    :catch_5
    move-exception v1

    goto :goto_8

    .line 876
    :catchall_1
    move-exception v0

    goto :goto_7

    :catchall_2
    move-exception v1

    move-object v4, v1

    move-object v1, v0

    move-object v0, v4

    goto :goto_7

    .line 874
    :catch_6
    move-exception v0

    goto :goto_5

    .line 871
    :catch_7
    move-exception v0

    move-object v0, v1

    goto :goto_3
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;I)Z
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 211
    .line 213
    :try_start_0
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/analytics/pro/e;->a()Landroid/database/sqlite/SQLiteDatabase;
    :try_end_0
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 214
    :try_start_1
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->beginTransaction()V

    .line 215
    new-instance v1, Landroid/content/ContentValues;

    invoke-direct {v1}, Landroid/content/ContentValues;-><init>()V

    .line 216
    const-string v2, "__i"

    invoke-virtual {v1, v2, p1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 217
    invoke-virtual {p0, p2}, Lcom/umeng/analytics/pro/g;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 218
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_0

    .line 219
    const-string v3, "__a"

    invoke-virtual {v1, v3, v2}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 220
    const-string v2, "__t"

    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 221
    const-string v2, "__er"

    const/4 v3, 0x0

    invoke-virtual {v0, v2, v3, v1}, Landroid/database/sqlite/SQLiteDatabase;->insert(Ljava/lang/String;Ljava/lang/String;Landroid/content/ContentValues;)J

    .line 223
    :cond_0
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->setTransactionSuccessful()V
    :try_end_1
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 230
    if-eqz v0, :cond_1

    .line 231
    :try_start_2
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    .line 234
    :cond_1
    :goto_0
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    .line 236
    :goto_1
    const/4 v0, 0x0

    return v0

    .line 224
    :catch_0
    move-exception v1

    .line 226
    :try_start_3
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/f;->a(Landroid/content/Context;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 230
    if-eqz v0, :cond_2

    .line 231
    :try_start_4
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3

    .line 234
    :cond_2
    :goto_2
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    goto :goto_1

    .line 227
    :catch_1
    move-exception v1

    .line 230
    if-eqz v0, :cond_3

    .line 231
    :try_start_5
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_4

    .line 234
    :cond_3
    :goto_3
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    goto :goto_1

    .line 229
    :catchall_0
    move-exception v1

    move-object v4, v1

    move-object v1, v0

    move-object v0, v4

    .line 230
    :goto_4
    if-eqz v1, :cond_4

    .line 231
    :try_start_6
    invoke-virtual {v1}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_5

    .line 234
    :cond_4
    :goto_5
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/analytics/pro/e;->b()V

    throw v0

    .line 233
    :catch_2
    move-exception v0

    goto :goto_0

    :catch_3
    move-exception v0

    goto :goto_2

    :catch_4
    move-exception v0

    goto :goto_3

    :catch_5
    move-exception v1

    goto :goto_5

    .line 229
    :catchall_1
    move-exception v1

    move-object v4, v1

    move-object v1, v0

    move-object v0, v4

    goto :goto_4
.end method

.method public a(Ljava/lang/String;Lorg/json/JSONObject;Lcom/umeng/analytics/pro/g$a;)Z
    .locals 7

    .prologue
    const/4 v0, 0x0

    const/4 v5, 0x0

    .line 288
    if-nez p2, :cond_0

    .line 333
    :goto_0
    return v5

    .line 293
    :cond_0
    :try_start_0
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/analytics/pro/e;->a()Landroid/database/sqlite/SQLiteDatabase;
    :try_end_0
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_0 .. :try_end_0} :catch_7
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_6
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    move-result-object v1

    .line 294
    :try_start_1
    invoke-virtual {v1}, Landroid/database/sqlite/SQLiteDatabase;->beginTransaction()V

    .line 295
    sget-object v0, Lcom/umeng/analytics/pro/g$a;->c:Lcom/umeng/analytics/pro/g$a;

    if-ne p3, v0, :cond_3

    .line 297
    const-string v0, "__e"

    invoke-virtual {p2, v0}, Lorg/json/JSONObject;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v2

    .line 298
    new-instance v0, Landroid/content/ContentValues;

    invoke-direct {v0}, Landroid/content/ContentValues;-><init>()V

    .line 299
    const-string v4, "__ii"

    invoke-virtual {v0, v4, p1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 300
    const-string v4, "__e"

    invoke-static {v2, v3}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v4, v2}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 301
    const-string v2, "__sd"

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3, v0}, Landroid/database/sqlite/SQLiteDatabase;->insert(Ljava/lang/String;Ljava/lang/String;Landroid/content/ContentValues;)J

    .line 320
    :cond_1
    :goto_1
    invoke-virtual {v1}, Landroid/database/sqlite/SQLiteDatabase;->setTransactionSuccessful()V
    :try_end_1
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 327
    if-eqz v1, :cond_2

    .line 328
    :try_start_2
    invoke-virtual {v1}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    .line 331
    :cond_2
    :goto_2
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    goto :goto_0

    .line 302
    :cond_3
    :try_start_3
    sget-object v0, Lcom/umeng/analytics/pro/g$a;->d:Lcom/umeng/analytics/pro/g$a;

    if-ne p3, v0, :cond_5

    .line 304
    const-string v0, "__f"

    invoke-virtual {p2, v0}, Lorg/json/JSONObject;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v2

    .line 305
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "update __sd set __f=\""

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "\" where "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "__ii"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "=\""

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "\""

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 309
    invoke-virtual {v1, v0}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V
    :try_end_3
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_3 .. :try_end_3} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_1

    .line 321
    :catch_0
    move-exception v0

    move-object v0, v1

    .line 323
    :goto_3
    :try_start_4
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/f;->a(Landroid/content/Context;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    .line 327
    if-eqz v0, :cond_4

    .line 328
    :try_start_5
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_3

    .line 331
    :cond_4
    :goto_4
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    goto/16 :goto_0

    .line 311
    :cond_5
    :try_start_6
    sget-object v0, Lcom/umeng/analytics/pro/g$a;->b:Lcom/umeng/analytics/pro/g$a;

    if-ne p3, v0, :cond_7

    .line 312
    const-string v0, "__a"

    invoke-direct {p0, p1, p2, v1, v0}, Lcom/umeng/analytics/pro/g;->a(Ljava/lang/String;Lorg/json/JSONObject;Landroid/database/sqlite/SQLiteDatabase;Ljava/lang/String;)V
    :try_end_6
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_6 .. :try_end_6} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_1
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    goto :goto_1

    .line 324
    :catch_1
    move-exception v0

    .line 327
    :goto_5
    if-eqz v1, :cond_6

    .line 328
    :try_start_7
    invoke-virtual {v1}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_4

    .line 331
    :cond_6
    :goto_6
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    goto/16 :goto_0

    .line 314
    :cond_7
    :try_start_8
    sget-object v0, Lcom/umeng/analytics/pro/g$a;->a:Lcom/umeng/analytics/pro/g$a;

    if-ne p3, v0, :cond_9

    .line 315
    const-string v0, "__b"

    invoke-direct {p0, p1, p2, v1, v0}, Lcom/umeng/analytics/pro/g;->a(Ljava/lang/String;Lorg/json/JSONObject;Landroid/database/sqlite/SQLiteDatabase;Ljava/lang/String;)V
    :try_end_8
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_8 .. :try_end_8} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_1
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    goto/16 :goto_1

    .line 326
    :catchall_0
    move-exception v0

    .line 327
    :goto_7
    if-eqz v1, :cond_8

    .line 328
    :try_start_9
    invoke-virtual {v1}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_9
    .catch Ljava/lang/Throwable; {:try_start_9 .. :try_end_9} :catch_5

    .line 331
    :cond_8
    :goto_8
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/analytics/pro/e;->b()V

    throw v0

    .line 317
    :cond_9
    :try_start_a
    sget-object v0, Lcom/umeng/analytics/pro/g$a;->e:Lcom/umeng/analytics/pro/g$a;

    if-ne p3, v0, :cond_1

    .line 318
    invoke-direct {p0, p1, p2, v1}, Lcom/umeng/analytics/pro/g;->a(Ljava/lang/String;Lorg/json/JSONObject;Landroid/database/sqlite/SQLiteDatabase;)V
    :try_end_a
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_a .. :try_end_a} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_a .. :try_end_a} :catch_1
    .catchall {:try_start_a .. :try_end_a} :catchall_0

    goto/16 :goto_1

    .line 330
    :catch_2
    move-exception v0

    goto/16 :goto_2

    :catch_3
    move-exception v0

    goto :goto_4

    :catch_4
    move-exception v0

    goto :goto_6

    :catch_5
    move-exception v1

    goto :goto_8

    .line 326
    :catchall_1
    move-exception v1

    move-object v6, v1

    move-object v1, v0

    move-object v0, v6

    goto :goto_7

    :catchall_2
    move-exception v1

    move-object v6, v1

    move-object v1, v0

    move-object v0, v6

    goto :goto_7

    .line 324
    :catch_6
    move-exception v1

    move-object v1, v0

    goto :goto_5

    .line 321
    :catch_7
    move-exception v1

    goto :goto_3
.end method

.method public b(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 1161
    const/4 v0, 0x0

    .line 1163
    :try_start_0
    sget-object v1, Lcom/umeng/analytics/pro/g;->d:Ljava/lang/String;

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1171
    :goto_0
    return-object p1

    .line 1166
    :cond_0
    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    const/4 v2, 0x0

    invoke-static {v1, v2}, Landroid/util/Base64;->decode([BI)[B

    move-result-object v1

    .line 1167
    new-instance p1, Ljava/lang/String;

    sget-object v2, Lcom/umeng/analytics/pro/g;->d:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->getBytes()[B

    move-result-object v2

    invoke-static {v1, v2}, Lcom/umeng/commonsdk/statistics/common/DataHelper;->decrypt([B[B)[B

    move-result-object v1

    invoke-direct {p1, v1}, Ljava/lang/String;-><init>([B)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 1169
    :catch_0
    move-exception v1

    move-object p1, v0

    goto :goto_0
.end method

.method public b()V
    .locals 7

    .prologue
    const/4 v1, 0x0

    .line 244
    const/4 v0, 0x0

    .line 247
    :try_start_0
    sget-object v2, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v2}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v2

    invoke-virtual {v2}, Lcom/umeng/analytics/pro/e;->a()Landroid/database/sqlite/SQLiteDatabase;
    :try_end_0
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 248
    :try_start_1
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->beginTransaction()V

    .line 250
    invoke-static {}, Lcom/umeng/analytics/pro/o;->a()Lcom/umeng/analytics/pro/o;

    move-result-object v2

    invoke-virtual {v2}, Lcom/umeng/analytics/pro/o;->d()Ljava/lang/String;

    move-result-object v2

    .line 252
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z
    :try_end_1
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result v3

    if-eqz v3, :cond_1

    .line 271
    if-eqz v0, :cond_0

    .line 272
    :try_start_2
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    .line 275
    :cond_0
    :goto_0
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    .line 277
    :goto_1
    return-void

    .line 256
    :cond_1
    const/4 v3, 0x2

    :try_start_3
    new-array v3, v3, [Ljava/lang/String;

    const/4 v4, 0x0

    const-string v5, ""

    aput-object v5, v3, v4

    const/4 v4, 0x1

    const-string v5, "-1"

    aput-object v5, v3, v4

    .line 258
    :goto_2
    array-length v4, v3

    if-ge v1, v4, :cond_2

    .line 259
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "update __et set __i=\""

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "\" where "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "__i"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "=\""

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    aget-object v5, v3, v1

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "\""

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 262
    invoke-virtual {v0, v4}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V

    .line 258
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 264
    :cond_2
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->setTransactionSuccessful()V
    :try_end_3
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_3 .. :try_end_3} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 271
    if-eqz v0, :cond_3

    .line 272
    :try_start_4
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3

    .line 275
    :cond_3
    :goto_3
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    goto :goto_1

    .line 265
    :catch_0
    move-exception v1

    .line 267
    :try_start_5
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/f;->a(Landroid/content/Context;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    .line 271
    if-eqz v0, :cond_4

    .line 272
    :try_start_6
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_4

    .line 275
    :cond_4
    :goto_4
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    goto :goto_1

    .line 268
    :catch_1
    move-exception v1

    .line 271
    if-eqz v0, :cond_5

    .line 272
    :try_start_7
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_5

    .line 275
    :cond_5
    :goto_5
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    goto :goto_1

    .line 270
    :catchall_0
    move-exception v1

    move-object v6, v1

    move-object v1, v0

    move-object v0, v6

    .line 271
    :goto_6
    if-eqz v1, :cond_6

    .line 272
    :try_start_8
    invoke-virtual {v1}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_6

    .line 275
    :cond_6
    :goto_7
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/analytics/pro/e;->b()V

    throw v0

    .line 274
    :catch_2
    move-exception v0

    goto/16 :goto_0

    :catch_3
    move-exception v0

    goto :goto_3

    :catch_4
    move-exception v0

    goto :goto_4

    :catch_5
    move-exception v0

    goto :goto_5

    :catch_6
    move-exception v1

    goto :goto_7

    .line 270
    :catchall_1
    move-exception v1

    move-object v6, v1

    move-object v1, v0

    move-object v0, v6

    goto :goto_6
.end method

.method public b(I)V
    .locals 4

    .prologue
    .line 951
    const/4 v0, 0x0

    .line 953
    :try_start_0
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/analytics/pro/e;->a()Landroid/database/sqlite/SQLiteDatabase;
    :try_end_0
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    move-result-object v0

    .line 954
    :try_start_1
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->beginTransaction()V

    .line 955
    const-string v1, "delete from __dp"

    .line 956
    const/4 v2, -0x1

    if-ne p1, v2, :cond_2

    .line 957
    invoke-virtual {v0, v1}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V

    .line 983
    :cond_0
    :goto_0
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->setTransactionSuccessful()V
    :try_end_1
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 990
    if-eqz v0, :cond_1

    .line 991
    :try_start_2
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    .line 994
    :cond_1
    :goto_1
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    .line 996
    :goto_2
    return-void

    .line 958
    :cond_2
    const/4 v1, 0x1

    if-ne p1, v1, :cond_4

    .line 959
    :try_start_3
    const-string v1, "delete from __dp where __ty=1"

    .line 961
    invoke-virtual {v0, v1}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V
    :try_end_3
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_3 .. :try_end_3} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_0

    .line 984
    :catch_0
    move-exception v1

    .line 986
    :try_start_4
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/f;->a(Landroid/content/Context;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 990
    if-eqz v0, :cond_3

    .line 991
    :try_start_5
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_3

    .line 994
    :cond_3
    :goto_3
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    goto :goto_2

    .line 962
    :cond_4
    const/4 v1, 0x4

    if-ne p1, v1, :cond_6

    .line 963
    :try_start_6
    const-string v1, "delete from __dp where __ty=3"

    .line 965
    invoke-virtual {v0, v1}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V

    .line 966
    const-string v1, "delete from __dp where __ty=2"

    .line 968
    invoke-virtual {v0, v1}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V
    :try_end_6
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_6 .. :try_end_6} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_1
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    goto :goto_0

    .line 987
    :catch_1
    move-exception v1

    .line 990
    if-eqz v0, :cond_5

    .line 991
    :try_start_7
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_4

    .line 994
    :cond_5
    :goto_4
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    goto :goto_2

    .line 969
    :cond_6
    const/4 v1, 0x3

    if-ne p1, v1, :cond_8

    .line 970
    :try_start_8
    const-string v1, "delete from __dp where __ty=3"

    .line 972
    invoke-virtual {v0, v1}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V
    :try_end_8
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_8 .. :try_end_8} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_1
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    goto :goto_0

    .line 989
    :catchall_0
    move-exception v1

    move-object v3, v1

    move-object v1, v0

    move-object v0, v3

    .line 990
    :goto_5
    if-eqz v1, :cond_7

    .line 991
    :try_start_9
    invoke-virtual {v1}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_9
    .catch Ljava/lang/Throwable; {:try_start_9 .. :try_end_9} :catch_5

    .line 994
    :cond_7
    :goto_6
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/analytics/pro/e;->b()V

    throw v0

    .line 973
    :cond_8
    if-nez p1, :cond_9

    .line 974
    :try_start_a
    const-string v1, "delete from __dp where __ty=0"

    .line 976
    invoke-virtual {v0, v1}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V

    goto :goto_0

    .line 977
    :cond_9
    const/4 v1, 0x2

    if-ne p1, v1, :cond_0

    .line 978
    const-string v1, "delete from __dp where __ty=2"

    .line 980
    invoke-virtual {v0, v1}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V
    :try_end_a
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_a .. :try_end_a} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_a .. :try_end_a} :catch_1
    .catchall {:try_start_a .. :try_end_a} :catchall_0

    goto :goto_0

    .line 993
    :catch_2
    move-exception v0

    goto :goto_1

    :catch_3
    move-exception v0

    goto :goto_3

    :catch_4
    move-exception v0

    goto :goto_4

    :catch_5
    move-exception v1

    goto :goto_6

    .line 989
    :catchall_1
    move-exception v1

    move-object v3, v1

    move-object v1, v0

    move-object v0, v3

    goto :goto_5
.end method

.method public c()Lorg/json/JSONObject;
    .locals 10

    .prologue
    const/4 v0, 0x0

    .line 487
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 492
    :try_start_0
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/analytics/pro/e;->a()Landroid/database/sqlite/SQLiteDatabase;
    :try_end_0
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_0 .. :try_end_0} :catch_7
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_6
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    move-result-object v1

    .line 493
    :try_start_1
    invoke-virtual {v1}, Landroid/database/sqlite/SQLiteDatabase;->beginTransaction()V

    .line 494
    const-string v3, "select *  from __dp"

    .line 495
    const/4 v4, 0x0

    invoke-virtual {v1, v3, v4}, Landroid/database/sqlite/SQLiteDatabase;->rawQuery(Ljava/lang/String;[Ljava/lang/String;)Landroid/database/Cursor;
    :try_end_1
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_2

    move-result-object v0

    .line 496
    if-eqz v0, :cond_d

    .line 497
    :try_start_2
    new-instance v3, Lorg/json/JSONArray;

    invoke-direct {v3}, Lorg/json/JSONArray;-><init>()V

    .line 498
    new-instance v4, Lorg/json/JSONArray;

    invoke-direct {v4}, Lorg/json/JSONArray;-><init>()V

    .line 499
    new-instance v5, Lorg/json/JSONArray;

    invoke-direct {v5}, Lorg/json/JSONArray;-><init>()V

    .line 501
    :cond_0
    :goto_0
    invoke-interface {v0}, Landroid/database/Cursor;->moveToNext()Z

    move-result v6

    if-eqz v6, :cond_d

    .line 502
    const-string v6, "__io"

    invoke-interface {v0, v6}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v6

    invoke-interface {v0, v6}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v6

    .line 503
    const-string v7, "__ty"

    invoke-interface {v0, v7}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v7

    invoke-interface {v0, v7}, Landroid/database/Cursor;->getInt(I)I

    move-result v7

    .line 504
    invoke-static {v6}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v8

    if-nez v8, :cond_1

    .line 505
    new-instance v8, Lorg/json/JSONObject;

    invoke-virtual {p0, v6}, Lcom/umeng/analytics/pro/g;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v8, v6}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 506
    if-eqz v8, :cond_1

    invoke-virtual {v8}, Lorg/json/JSONObject;->length()I

    move-result v6

    if-lez v6, :cond_1

    .line 507
    const/4 v6, 0x2

    if-ne v7, v6, :cond_6

    .line 508
    invoke-virtual {v4, v8}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 519
    :cond_1
    :goto_1
    invoke-virtual {v3}, Lorg/json/JSONArray;->length()I

    move-result v6

    if-lez v6, :cond_2

    .line 520
    const-string v6, "events"

    invoke-virtual {v2, v6, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 522
    :cond_2
    invoke-virtual {v4}, Lorg/json/JSONArray;->length()I

    move-result v6

    if-lez v6, :cond_3

    .line 523
    const-string v6, "session"

    invoke-virtual {v2, v6, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 525
    :cond_3
    invoke-virtual {v5}, Lorg/json/JSONArray;->length()I

    move-result v6

    if-lez v6, :cond_0

    .line 526
    const-string v6, "pageview"

    invoke-virtual {v2, v6, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_2
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    .line 532
    :catch_0
    move-exception v3

    .line 534
    :goto_2
    :try_start_3
    sget-object v3, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v3}, Lcom/umeng/analytics/pro/f;->a(Landroid/content/Context;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 537
    if-eqz v0, :cond_4

    .line 538
    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    .line 541
    :cond_4
    if-eqz v1, :cond_5

    .line 542
    :try_start_4
    invoke-virtual {v1}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3

    .line 545
    :cond_5
    :goto_3
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    .line 547
    :goto_4
    return-object v2

    .line 509
    :cond_6
    const/4 v6, 0x3

    if-ne v7, v6, :cond_9

    .line 510
    :try_start_5
    invoke-virtual {v4, v8}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_5
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_5 .. :try_end_5} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_1
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    goto :goto_1

    .line 535
    :catch_1
    move-exception v3

    .line 537
    :goto_5
    if-eqz v0, :cond_7

    .line 538
    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    .line 541
    :cond_7
    if-eqz v1, :cond_8

    .line 542
    :try_start_6
    invoke-virtual {v1}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_4

    .line 545
    :cond_8
    :goto_6
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    goto :goto_4

    .line 511
    :cond_9
    if-nez v7, :cond_c

    .line 512
    :try_start_7
    invoke-virtual {v3, v8}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_7
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_7 .. :try_end_7} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_1
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    goto :goto_1

    .line 537
    :catchall_0
    move-exception v2

    move-object v9, v2

    move-object v2, v1

    move-object v1, v0

    move-object v0, v9

    :goto_7
    if-eqz v1, :cond_a

    .line 538
    invoke-interface {v1}, Landroid/database/Cursor;->close()V

    .line 541
    :cond_a
    if-eqz v2, :cond_b

    .line 542
    :try_start_8
    invoke-virtual {v2}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_5

    .line 545
    :cond_b
    :goto_8
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/analytics/pro/e;->b()V

    throw v0

    .line 513
    :cond_c
    const/4 v6, 0x1

    if-ne v7, v6, :cond_1

    .line 514
    :try_start_9
    invoke-virtual {v5, v8}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    goto :goto_1

    .line 531
    :cond_d
    invoke-virtual {v1}, Landroid/database/sqlite/SQLiteDatabase;->setTransactionSuccessful()V
    :try_end_9
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_9 .. :try_end_9} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_9 .. :try_end_9} :catch_1
    .catchall {:try_start_9 .. :try_end_9} :catchall_0

    .line 537
    if-eqz v0, :cond_e

    .line 538
    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    .line 541
    :cond_e
    if-eqz v1, :cond_f

    .line 542
    :try_start_a
    invoke-virtual {v1}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_a
    .catch Ljava/lang/Throwable; {:try_start_a .. :try_end_a} :catch_2

    .line 545
    :cond_f
    :goto_9
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    goto :goto_4

    .line 544
    :catch_2
    move-exception v0

    goto :goto_9

    :catch_3
    move-exception v0

    goto :goto_3

    :catch_4
    move-exception v0

    goto :goto_6

    :catch_5
    move-exception v1

    goto :goto_8

    .line 537
    :catchall_1
    move-exception v1

    move-object v2, v0

    move-object v9, v0

    move-object v0, v1

    move-object v1, v9

    goto :goto_7

    :catchall_2
    move-exception v2

    move-object v9, v2

    move-object v2, v1

    move-object v1, v0

    move-object v0, v9

    goto :goto_7

    .line 535
    :catch_6
    move-exception v1

    move-object v1, v0

    goto :goto_5

    .line 532
    :catch_7
    move-exception v1

    move-object v1, v0

    goto/16 :goto_2
.end method

.method public d()V
    .locals 5

    .prologue
    .line 889
    const/4 v0, 0x0

    .line 891
    :try_start_0
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/analytics/pro/e;->a()Landroid/database/sqlite/SQLiteDatabase;
    :try_end_0
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 892
    :try_start_1
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->beginTransaction()V

    .line 894
    iget-object v1, p0, Lcom/umeng/analytics/pro/g;->i:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_0

    .line 895
    const/4 v1, 0x0

    :goto_0
    iget-object v2, p0, Lcom/umeng/analytics/pro/g;->i:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    if-ge v1, v2, :cond_0

    .line 896
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "delete from __et where rowid="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/umeng/analytics/pro/g;->i:Ljava/util/List;

    .line 897
    invoke-interface {v3, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 898
    invoke-virtual {v0, v2}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V

    .line 895
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 901
    :cond_0
    iget-object v1, p0, Lcom/umeng/analytics/pro/g;->i:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->clear()V

    .line 902
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->setTransactionSuccessful()V
    :try_end_1
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 909
    if-eqz v0, :cond_1

    .line 910
    :try_start_2
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    .line 913
    :cond_1
    :goto_1
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    .line 915
    :goto_2
    return-void

    .line 903
    :catch_0
    move-exception v1

    .line 905
    :try_start_3
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/f;->a(Landroid/content/Context;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 909
    if-eqz v0, :cond_2

    .line 910
    :try_start_4
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3

    .line 913
    :cond_2
    :goto_3
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    goto :goto_2

    .line 906
    :catch_1
    move-exception v1

    .line 909
    if-eqz v0, :cond_3

    .line 910
    :try_start_5
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_4

    .line 913
    :cond_3
    :goto_4
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    goto :goto_2

    .line 908
    :catchall_0
    move-exception v1

    move-object v4, v1

    move-object v1, v0

    move-object v0, v4

    .line 909
    :goto_5
    if-eqz v1, :cond_4

    .line 910
    :try_start_6
    invoke-virtual {v1}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_5

    .line 913
    :cond_4
    :goto_6
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/analytics/pro/e;->b()V

    throw v0

    .line 912
    :catch_2
    move-exception v0

    goto :goto_1

    :catch_3
    move-exception v0

    goto :goto_3

    :catch_4
    move-exception v0

    goto :goto_4

    :catch_5
    move-exception v1

    goto :goto_6

    .line 908
    :catchall_1
    move-exception v1

    move-object v4, v1

    move-object v1, v0

    move-object v0, v4

    goto :goto_5
.end method

.method public e()V
    .locals 3

    .prologue
    .line 918
    const/4 v0, 0x0

    .line 920
    :try_start_0
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/analytics/pro/e;->a()Landroid/database/sqlite/SQLiteDatabase;
    :try_end_0
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 921
    :try_start_1
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->beginTransaction()V

    .line 922
    const-string v1, "delete from __er"

    .line 923
    invoke-virtual {v0, v1}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V

    .line 925
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->setTransactionSuccessful()V
    :try_end_1
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 932
    if-eqz v0, :cond_0

    .line 933
    :try_start_2
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    .line 936
    :cond_0
    :goto_0
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    .line 938
    :goto_1
    return-void

    .line 926
    :catch_0
    move-exception v1

    .line 928
    :try_start_3
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/f;->a(Landroid/content/Context;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 932
    if-eqz v0, :cond_1

    .line 933
    :try_start_4
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3

    .line 936
    :cond_1
    :goto_2
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    goto :goto_1

    .line 929
    :catch_1
    move-exception v1

    .line 932
    if-eqz v0, :cond_2

    .line 933
    :try_start_5
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_4

    .line 936
    :cond_2
    :goto_3
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    goto :goto_1

    .line 931
    :catchall_0
    move-exception v1

    move-object v2, v1

    move-object v1, v0

    move-object v0, v2

    .line 932
    :goto_4
    if-eqz v1, :cond_3

    .line 933
    :try_start_6
    invoke-virtual {v1}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_5

    .line 936
    :cond_3
    :goto_5
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/analytics/pro/e;->b()V

    throw v0

    .line 935
    :catch_2
    move-exception v0

    goto :goto_0

    :catch_3
    move-exception v0

    goto :goto_2

    :catch_4
    move-exception v0

    goto :goto_3

    :catch_5
    move-exception v1

    goto :goto_5

    .line 931
    :catchall_1
    move-exception v1

    move-object v2, v1

    move-object v1, v0

    move-object v0, v2

    goto :goto_4
.end method

.method public f()V
    .locals 1

    .prologue
    .line 944
    const/4 v0, -0x1

    invoke-virtual {p0, v0}, Lcom/umeng/analytics/pro/g;->b(I)V

    .line 945
    return-void
.end method

.method public g()V
    .locals 5

    .prologue
    const/4 v1, 0x0

    .line 1002
    iget-object v0, p0, Lcom/umeng/analytics/pro/g;->j:Ljava/lang/String;

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 1005
    :try_start_0
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->a()Landroid/database/sqlite/SQLiteDatabase;
    :try_end_0
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 1006
    :try_start_1
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->beginTransaction()V

    .line 1007
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "delete from __er where __i=\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/umeng/analytics/pro/g;->j:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 1009
    invoke-virtual {v0, v2}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V

    .line 1010
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "delete from __et where __i=\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/umeng/analytics/pro/g;->j:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 1012
    invoke-virtual {v0, v2}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V

    .line 1014
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->setTransactionSuccessful()V
    :try_end_1
    .catch Landroid/database/sqlite/SQLiteDatabaseCorruptException; {:try_start_1 .. :try_end_1} :catch_7
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_6
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 1021
    if-eqz v0, :cond_0

    .line 1022
    :try_start_2
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    .line 1025
    :cond_0
    :goto_0
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    .line 1028
    :cond_1
    :goto_1
    iput-object v1, p0, Lcom/umeng/analytics/pro/g;->j:Ljava/lang/String;

    .line 1029
    return-void

    .line 1015
    :catch_0
    move-exception v0

    move-object v0, v1

    .line 1017
    :goto_2
    :try_start_3
    sget-object v2, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v2}, Lcom/umeng/analytics/pro/f;->a(Landroid/content/Context;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1021
    if-eqz v0, :cond_2

    .line 1022
    :try_start_4
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3

    .line 1025
    :cond_2
    :goto_3
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    goto :goto_1

    .line 1018
    :catch_1
    move-exception v0

    move-object v0, v1

    .line 1021
    :goto_4
    if-eqz v0, :cond_3

    .line 1022
    :try_start_5
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_4

    .line 1025
    :cond_3
    :goto_5
    sget-object v0, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/e;->b()V

    goto :goto_1

    .line 1020
    :catchall_0
    move-exception v0

    .line 1021
    :goto_6
    if-eqz v1, :cond_4

    .line 1022
    :try_start_6
    invoke-virtual {v1}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_5

    .line 1025
    :cond_4
    :goto_7
    sget-object v1, Lcom/umeng/analytics/pro/g;->c:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/e;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/analytics/pro/e;->b()V

    throw v0

    .line 1024
    :catch_2
    move-exception v0

    goto :goto_0

    :catch_3
    move-exception v0

    goto :goto_3

    :catch_4
    move-exception v0

    goto :goto_5

    :catch_5
    move-exception v1

    goto :goto_7

    .line 1020
    :catchall_1
    move-exception v1

    move-object v4, v1

    move-object v1, v0

    move-object v0, v4

    goto :goto_6

    .line 1018
    :catch_6
    move-exception v2

    goto :goto_4

    .line 1015
    :catch_7
    move-exception v2

    goto :goto_2
.end method
