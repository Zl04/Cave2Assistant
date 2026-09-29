.class public Lcom/umeng/commonsdk/amap/b;
.super Ljava/lang/Thread;
.source "UMAmapTimer.java"


# static fields
.field private static final e:Ljava/lang/String; = "info"

.field private static final f:Ljava/lang/String; = "ts"

.field private static final g:Ljava/lang/String; = "amap_lbs"

.field private static final h:Ljava/lang/String; = "tp"


# instance fields
.field private a:Landroid/content/Context;

.field private b:I

.field private c:J

.field private d:Ljava/util/Vector;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Vector",
            "<",
            "Lorg/json/JSONObject;",
            ">;"
        }
    .end annotation
.end field

.field private i:I

.field private j:I


# direct methods
.method public constructor <init>(Landroid/content/Context;IJ)V
    .locals 5

    .prologue
    const/4 v3, 0x0

    const/4 v1, 0x1

    .line 36
    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    .line 26
    iput v3, p0, Lcom/umeng/commonsdk/amap/b;->b:I

    .line 45
    iput v1, p0, Lcom/umeng/commonsdk/amap/b;->i:I

    .line 46
    iput v1, p0, Lcom/umeng/commonsdk/amap/b;->j:I

    .line 37
    const-string v0, "AmapLBS"

    new-array v1, v1, [Ljava/lang/Object;

    const-string v2, "new UMAmapTimer"

    aput-object v2, v1, v3

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/statistics/common/e;->a(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 38
    if-eqz p1, :cond_0

    .line 39
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Lcom/umeng/commonsdk/amap/b;->a:Landroid/content/Context;

    .line 40
    iput p2, p0, Lcom/umeng/commonsdk/amap/b;->b:I

    .line 41
    iput-wide p3, p0, Lcom/umeng/commonsdk/amap/b;->c:J

    .line 43
    :cond_0
    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    .prologue
    const/4 v6, 0x1

    .line 51
    :try_start_0
    iget-object v0, p0, Lcom/umeng/commonsdk/amap/b;->a:Landroid/content/Context;

    if-nez v0, :cond_4

    .line 154
    :cond_0
    :goto_0
    return-void

    .line 93
    :cond_1
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .line 95
    :try_start_1
    const-string v2, "amap_lbs"

    invoke-virtual {v0, v2, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_4

    .line 98
    :goto_1
    :try_start_2
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    .line 100
    :try_start_3
    const-string v2, "tp"

    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_3

    .line 104
    :goto_2
    :try_start_4
    iget-object v0, p0, Lcom/umeng/commonsdk/amap/b;->d:Ljava/util/Vector;

    if-eqz v0, :cond_2

    .line 105
    iget-object v0, p0, Lcom/umeng/commonsdk/amap/b;->d:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->clear()V

    .line 106
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/umeng/commonsdk/amap/b;->d:Ljava/util/Vector;

    .line 110
    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lcom/umeng/commonsdk/amap/b;->a:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "/"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "stateless"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "/"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "umpx_oplus_lbs"

    invoke-virtual {v2}, Ljava/lang/String;->getBytes()[B

    move-result-object v2

    const/4 v3, 0x0

    invoke-static {v2, v3}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 111
    iget-object v2, p0, Lcom/umeng/commonsdk/amap/b;->a:Landroid/content/Context;

    const/16 v3, 0x32

    invoke-static {v2, v0, v3}, Lcom/umeng/commonsdk/stateless/f;->a(Landroid/content/Context;Ljava/lang/String;I)V

    .line 113
    const-string v0, "AmapLBS"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[lbs-build] begin build envelope is "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-static {v0, v2}, Lcom/umeng/commonsdk/statistics/common/e;->a(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 115
    new-instance v0, Lcom/umeng/commonsdk/stateless/UMSLEnvelopeBuild;

    invoke-direct {v0}, Lcom/umeng/commonsdk/stateless/UMSLEnvelopeBuild;-><init>()V

    .line 116
    iget-object v2, p0, Lcom/umeng/commonsdk/amap/b;->a:Landroid/content/Context;

    invoke-virtual {v0, v2}, Lcom/umeng/commonsdk/stateless/UMSLEnvelopeBuild;->buildSLBaseHeader(Landroid/content/Context;)Lorg/json/JSONObject;

    move-result-object v2

    .line 117
    iget-object v3, p0, Lcom/umeng/commonsdk/amap/b;->a:Landroid/content/Context;

    const-string v4, "umpx_oplus_lbs"

    invoke-virtual {v0, v3, v2, v1, v4}, Lcom/umeng/commonsdk/stateless/UMSLEnvelopeBuild;->buildSLEnvelope(Landroid/content/Context;Lorg/json/JSONObject;Lorg/json/JSONObject;Ljava/lang/String;)Lorg/json/JSONObject;
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_1

    .line 134
    :cond_3
    :goto_3
    :try_start_5
    iget-wide v0, p0, Lcom/umeng/commonsdk/amap/b;->c:J

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/amap/b;->sleep(J)V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_2

    .line 56
    :cond_4
    :goto_4
    :try_start_6
    iget v0, p0, Lcom/umeng/commonsdk/amap/b;->b:I

    if-ne v0, v6, :cond_a

    .line 58
    sget-boolean v0, Lcom/umeng/commonsdk/statistics/common/e;->a:Z

    if-eqz v0, :cond_5

    .line 61
    const-string v0, "AmapLBS"

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[lbs-build] timer begin : index is "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Lcom/umeng/commonsdk/amap/b;->i:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/statistics/common/e;->a(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 62
    iget v0, p0, Lcom/umeng/commonsdk/amap/b;->i:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/umeng/commonsdk/amap/b;->i:I

    .line 65
    :cond_5
    new-instance v0, Lcom/umeng/commonsdk/amap/a;

    iget-object v1, p0, Lcom/umeng/commonsdk/amap/b;->a:Landroid/content/Context;

    invoke-direct {v0, v1}, Lcom/umeng/commonsdk/amap/a;-><init>(Landroid/content/Context;)V

    .line 66
    if-eqz v0, :cond_3

    .line 67
    invoke-virtual {v0}, Lcom/umeng/commonsdk/amap/a;->b()[B

    move-result-object v0

    .line 68
    if-eqz v0, :cond_9

    .line 69
    const/4 v1, 0x0

    invoke-static {v0, v1}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    .line 70
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_8

    .line 71
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_1

    .line 73
    :try_start_7
    const-string v2, "info"

    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 74
    const-string v0, "ts"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v1, v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_5

    .line 77
    :goto_5
    :try_start_8
    iget-object v0, p0, Lcom/umeng/commonsdk/amap/b;->d:Ljava/util/Vector;

    if-nez v0, :cond_6

    .line 78
    new-instance v0, Ljava/util/Vector;

    invoke-direct {v0}, Ljava/util/Vector;-><init>()V

    iput-object v0, p0, Lcom/umeng/commonsdk/amap/b;->d:Ljava/util/Vector;

    .line 80
    :cond_6
    iget-object v0, p0, Lcom/umeng/commonsdk/amap/b;->d:Ljava/util/Vector;

    invoke-virtual {v0, v1}, Ljava/util/Vector;->add(Ljava/lang/Object;)Z

    .line 81
    iget-object v0, p0, Lcom/umeng/commonsdk/amap/b;->d:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v0

    const/16 v1, 0x1e

    if-ne v0, v1, :cond_3

    .line 82
    const-string v0, "AmapLBS"

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[lbs-build] begin build envelope , cache size is "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/umeng/commonsdk/amap/b;->d:Ljava/util/Vector;

    invoke-virtual {v4}, Ljava/util/Vector;->size()I

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/statistics/common/e;->a(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 83
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    .line 84
    iget-object v0, p0, Lcom/umeng/commonsdk/amap/b;->d:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_7
    :goto_6
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/json/JSONObject;
    :try_end_8
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_1

    .line 85
    if-eqz v0, :cond_7

    .line 87
    :try_start_9
    invoke-virtual {v1, v0}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_9
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_0

    goto :goto_6

    .line 88
    :catch_0
    move-exception v0

    goto :goto_6

    .line 121
    :cond_8
    :try_start_a
    const-string v0, "AmapLBS"

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    const-string v3, "[lbs-build] amap result is empty"

    aput-object v3, v1, v2

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/statistics/common/e;->a(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_a
    .catch Ljava/lang/Exception; {:try_start_a .. :try_end_a} :catch_1

    goto/16 :goto_3

    .line 151
    :catch_1
    move-exception v0

    .line 152
    iget-object v1, p0, Lcom/umeng/commonsdk/amap/b;->a:Landroid/content/Context;

    invoke-static {v1, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto/16 :goto_0

    .line 124
    :cond_9
    :try_start_b
    const-string v0, "AmapLBS"

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    const-string v3, "[lbs-build] amap result is null"

    aput-object v3, v1, v2

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/statistics/common/e;->a(Ljava/lang/String;[Ljava/lang/Object;)V

    goto/16 :goto_3

    .line 127
    :cond_a
    iget v0, p0, Lcom/umeng/commonsdk/amap/b;->b:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    goto/16 :goto_3

    .line 135
    :catch_2
    move-exception v0

    .line 136
    iget-object v1, p0, Lcom/umeng/commonsdk/amap/b;->a:Landroid/content/Context;

    invoke-static {v1, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V
    :try_end_b
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_b} :catch_1

    goto/16 :goto_4

    .line 101
    :catch_3
    move-exception v0

    goto/16 :goto_2

    .line 96
    :catch_4
    move-exception v1

    goto/16 :goto_1

    .line 75
    :catch_5
    move-exception v0

    goto/16 :goto_5
.end method
