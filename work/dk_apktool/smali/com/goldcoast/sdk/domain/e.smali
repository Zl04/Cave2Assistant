.class final Lcom/goldcoast/sdk/domain/e;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/b/a/h;


# instance fields
.field final synthetic a:Landroid/os/ConditionVariable;

.field final synthetic b:[Z

.field final synthetic c:Lcom/goldcoast/sdk/domain/EntryPoint;


# direct methods
.method constructor <init>(Lcom/goldcoast/sdk/domain/EntryPoint;Landroid/os/ConditionVariable;[Z)V
    .locals 0

    .prologue
    .line 477
    iput-object p1, p0, Lcom/goldcoast/sdk/domain/e;->c:Lcom/goldcoast/sdk/domain/EntryPoint;

    iput-object p2, p0, Lcom/goldcoast/sdk/domain/e;->a:Landroid/os/ConditionVariable;

    iput-object p3, p0, Lcom/goldcoast/sdk/domain/e;->b:[Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final a(Lcom/b/a/as;)V
    .locals 7

    .prologue
    const/4 v6, 0x0

    const/4 v1, 0x1

    .line 480
    invoke-virtual {p1}, Lcom/b/a/as;->e()Lcom/b/a/au;

    move-result-object v0

    invoke-virtual {v0}, Lcom/b/a/au;->d()Ljava/lang/String;

    move-result-object v0

    .line 481
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 486
    :try_start_0
    iget-object v2, p0, Lcom/goldcoast/sdk/domain/e;->c:Lcom/goldcoast/sdk/domain/EntryPoint;

    invoke-static {v2, v0}, Lcom/goldcoast/sdk/domain/EntryPoint;->a(Lcom/goldcoast/sdk/domain/EntryPoint;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 499
    :cond_0
    :goto_0
    iget-object v0, p0, Lcom/goldcoast/sdk/domain/e;->a:Landroid/os/ConditionVariable;

    invoke-virtual {v0}, Landroid/os/ConditionVariable;->open()V

    .line 500
    return-void

    .line 487
    :catch_0
    move-exception v0

    move-object v3, v0

    .line 488
    const/4 v2, 0x3

    .line 489
    const-string v0, "Exception:\n %s\n"

    new-array v4, v1, [Ljava/lang/Object;

    .line 490
    invoke-virtual {v3}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v6

    .line 489
    invoke-static {v0, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 491
    iget-object v4, p0, Lcom/goldcoast/sdk/domain/e;->c:Lcom/goldcoast/sdk/domain/EntryPoint;

    invoke-static {v4}, Lcom/goldcoast/sdk/domain/EntryPoint;->d(Lcom/goldcoast/sdk/domain/EntryPoint;)I

    move-result v4

    const/4 v5, 0x4

    if-ne v4, v5, :cond_1

    .line 493
    const-string v0, "Exception:\n %s\n$$$ failed"

    new-array v2, v1, [Ljava/lang/Object;

    .line 494
    invoke-virtual {v3}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v6

    .line 493
    invoke-static {v0, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 496
    :goto_1
    iget-object v2, p0, Lcom/goldcoast/sdk/domain/e;->c:Lcom/goldcoast/sdk/domain/EntryPoint;

    invoke-static {v2, v0, v1}, Lcom/goldcoast/sdk/domain/EntryPoint;->a(Lcom/goldcoast/sdk/domain/EntryPoint;Ljava/lang/String;I)V

    goto :goto_0

    :cond_1
    move v1, v2

    goto :goto_1
.end method

.method public final a(Ljava/io/IOException;)V
    .locals 4

    .prologue
    const/4 v3, 0x1

    .line 504
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 505
    const-string v1, "stack"

    iget-object v2, p0, Lcom/goldcoast/sdk/domain/e;->c:Lcom/goldcoast/sdk/domain/EntryPoint;

    invoke-virtual {v2, p1}, Lcom/goldcoast/sdk/domain/EntryPoint;->getStackString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 506
    iget-object v0, p0, Lcom/goldcoast/sdk/domain/e;->b:[Z

    const/4 v1, 0x0

    aput-boolean v3, v0, v1

    .line 507
    iget-object v0, p0, Lcom/goldcoast/sdk/domain/e;->c:Lcom/goldcoast/sdk/domain/EntryPoint;

    invoke-static {v0}, Lcom/goldcoast/sdk/domain/EntryPoint;->d(Lcom/goldcoast/sdk/domain/EntryPoint;)I

    move-result v0

    const/4 v1, 0x4

    if-ne v0, v1, :cond_0

    .line 508
    iget-object v0, p0, Lcom/goldcoast/sdk/domain/e;->c:Lcom/goldcoast/sdk/domain/EntryPoint;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lcom/goldcoast/sdk/domain/e;->c:Lcom/goldcoast/sdk/domain/EntryPoint;

    invoke-virtual {v2, p1}, Lcom/goldcoast/sdk/domain/EntryPoint;->getStackString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\n$$$ failed\n"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1, v3}, Lcom/goldcoast/sdk/domain/EntryPoint;->a(Lcom/goldcoast/sdk/domain/EntryPoint;Ljava/lang/String;I)V

    .line 512
    :goto_0
    iget-object v0, p0, Lcom/goldcoast/sdk/domain/e;->a:Landroid/os/ConditionVariable;

    invoke-virtual {v0}, Landroid/os/ConditionVariable;->open()V

    .line 513
    return-void

    .line 510
    :cond_0
    iget-object v0, p0, Lcom/goldcoast/sdk/domain/e;->c:Lcom/goldcoast/sdk/domain/EntryPoint;

    iget-object v1, p0, Lcom/goldcoast/sdk/domain/e;->c:Lcom/goldcoast/sdk/domain/EntryPoint;

    invoke-virtual {v1, p1}, Lcom/goldcoast/sdk/domain/EntryPoint;->getStackString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x3

    invoke-static {v0, v1, v2}, Lcom/goldcoast/sdk/domain/EntryPoint;->a(Lcom/goldcoast/sdk/domain/EntryPoint;Ljava/lang/String;I)V

    goto :goto_0
.end method
