.class final Lcom/umeng/commonsdk/proguard/e$1;
.super Ljava/lang/Object;
.source "UMCrashManager.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/content/Context;

.field final synthetic b:Ljava/lang/Throwable;


# direct methods
.method constructor <init>(Landroid/content/Context;Ljava/lang/Throwable;)V
    .locals 0

    .prologue
    .line 22
    iput-object p1, p0, Lcom/umeng/commonsdk/proguard/e$1;->a:Landroid/content/Context;

    iput-object p2, p0, Lcom/umeng/commonsdk/proguard/e$1;->b:Ljava/lang/Throwable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    .prologue
    .line 26
    :try_start_0
    monitor-enter p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 27
    :try_start_1
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/e$1;->a:Landroid/content/Context;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/e$1;->b:Ljava/lang/Throwable;

    if-eqz v0, :cond_0

    .line 28
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/e$1;->b:Ljava/lang/Throwable;

    invoke-static {v0}, Lcom/umeng/commonsdk/proguard/f;->a(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v0

    .line 29
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 30
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lcom/umeng/commonsdk/proguard/e$1;->a:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "/"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "stateless"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "/"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "umpx_crash"

    invoke-virtual {v2}, Ljava/lang/String;->getBytes()[B

    move-result-object v2

    const/4 v3, 0x0

    invoke-static {v2, v3}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 31
    iget-object v2, p0, Lcom/umeng/commonsdk/proguard/e$1;->a:Landroid/content/Context;

    const/16 v3, 0x32

    invoke-static {v2, v1, v3}, Lcom/umeng/commonsdk/stateless/f;->a(Landroid/content/Context;Ljava/lang/String;I)V

    .line 33
    new-instance v1, Lcom/umeng/commonsdk/stateless/UMSLEnvelopeBuild;

    invoke-direct {v1}, Lcom/umeng/commonsdk/stateless/UMSLEnvelopeBuild;-><init>()V

    .line 34
    iget-object v2, p0, Lcom/umeng/commonsdk/proguard/e$1;->a:Landroid/content/Context;

    invoke-virtual {v1, v2}, Lcom/umeng/commonsdk/stateless/UMSLEnvelopeBuild;->buildSLBaseHeader(Landroid/content/Context;)Lorg/json/JSONObject;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v2

    .line 36
    :try_start_2
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    .line 37
    const-string v4, "content"

    invoke-virtual {v3, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 38
    const-string v0, "ts"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-virtual {v3, v0, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 39
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 40
    const-string v4, "crash"

    invoke-virtual {v0, v4, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 41
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    .line 42
    const-string v4, "tp"

    invoke-virtual {v3, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 43
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/e$1;->a:Landroid/content/Context;

    const-string v4, "umpx_internal"

    invoke-virtual {v1, v0, v2, v3, v4}, Lcom/umeng/commonsdk/stateless/UMSLEnvelopeBuild;->buildSLEnvelope(Landroid/content/Context;Lorg/json/JSONObject;Lorg/json/JSONObject;Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    .line 44
    if-eqz v0, :cond_0

    const-string v1, "exception"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z
    :try_end_2
    .catch Lorg/json/JSONException; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-result v0

    if-nez v0, :cond_0

    .line 51
    :cond_0
    :goto_0
    :try_start_3
    monitor-exit p0

    .line 55
    :goto_1
    return-void

    .line 51
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :try_start_4
    throw v0
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_0

    .line 52
    :catch_0
    move-exception v0

    goto :goto_1

    .line 47
    :catch_1
    move-exception v0

    goto :goto_0
.end method
