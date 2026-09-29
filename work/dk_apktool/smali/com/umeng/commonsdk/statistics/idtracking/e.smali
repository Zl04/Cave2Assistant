.class public Lcom/umeng/commonsdk/statistics/idtracking/e;
.super Ljava/lang/Object;
.source "IdTracker.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/umeng/commonsdk/statistics/idtracking/e$a;
    }
.end annotation


# static fields
.field public static final a:J = 0x5265c00L

.field public static b:Lcom/umeng/commonsdk/statistics/idtracking/e;

.field private static j:Ljava/lang/Object;


# instance fields
.field private final c:Ljava/lang/String;

.field private d:Ljava/io/File;

.field private e:Lcom/umeng/commonsdk/statistics/proto/c;

.field private f:J

.field private g:J

.field private h:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set",
            "<",
            "Lcom/umeng/commonsdk/statistics/idtracking/a;",
            ">;"
        }
    .end annotation
.end field

.field private i:Lcom/umeng/commonsdk/statistics/idtracking/e$a;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 217
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/umeng/commonsdk/statistics/idtracking/e;->j:Ljava/lang/Object;

    return-void
.end method

.method constructor <init>(Landroid/content/Context;)V
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 45
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 32
    const-string v0, "umeng_it.cache"

    iput-object v0, p0, Lcom/umeng/commonsdk/statistics/idtracking/e;->c:Ljava/lang/String;

    .line 37
    iput-object v1, p0, Lcom/umeng/commonsdk/statistics/idtracking/e;->e:Lcom/umeng/commonsdk/statistics/proto/c;

    .line 40
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Lcom/umeng/commonsdk/statistics/idtracking/e;->h:Ljava/util/Set;

    .line 41
    iput-object v1, p0, Lcom/umeng/commonsdk/statistics/idtracking/e;->i:Lcom/umeng/commonsdk/statistics/idtracking/e$a;

    .line 46
    new-instance v0, Ljava/io/File;

    invoke-virtual {p1}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v1

    const-string v2, "umeng_it.cache"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/umeng/commonsdk/statistics/idtracking/e;->d:Ljava/io/File;

    .line 47
    const-wide/32 v0, 0x5265c00

    iput-wide v0, p0, Lcom/umeng/commonsdk/statistics/idtracking/e;->g:J

    .line 48
    new-instance v0, Lcom/umeng/commonsdk/statistics/idtracking/e$a;

    invoke-direct {v0, p1}, Lcom/umeng/commonsdk/statistics/idtracking/e$a;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/umeng/commonsdk/statistics/idtracking/e;->i:Lcom/umeng/commonsdk/statistics/idtracking/e$a;

    .line 49
    iget-object v0, p0, Lcom/umeng/commonsdk/statistics/idtracking/e;->i:Lcom/umeng/commonsdk/statistics/idtracking/e$a;

    invoke-virtual {v0}, Lcom/umeng/commonsdk/statistics/idtracking/e$a;->b()V

    .line 50
    return-void
.end method

.method public static declared-synchronized a(Landroid/content/Context;)Lcom/umeng/commonsdk/statistics/idtracking/e;
    .locals 4

    .prologue
    .line 53
    const-class v1, Lcom/umeng/commonsdk/statistics/idtracking/e;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/umeng/commonsdk/statistics/idtracking/e;->b:Lcom/umeng/commonsdk/statistics/idtracking/e;

    if-nez v0, :cond_2

    .line 54
    new-instance v0, Lcom/umeng/commonsdk/statistics/idtracking/e;

    invoke-direct {v0, p0}, Lcom/umeng/commonsdk/statistics/idtracking/e;-><init>(Landroid/content/Context;)V

    sput-object v0, Lcom/umeng/commonsdk/statistics/idtracking/e;->b:Lcom/umeng/commonsdk/statistics/idtracking/e;

    .line 56
    sget-object v0, Lcom/umeng/commonsdk/statistics/idtracking/e;->b:Lcom/umeng/commonsdk/statistics/idtracking/e;

    new-instance v2, Lcom/umeng/commonsdk/statistics/idtracking/f;

    invoke-direct {v2, p0}, Lcom/umeng/commonsdk/statistics/idtracking/f;-><init>(Landroid/content/Context;)V

    invoke-direct {v0, v2}, Lcom/umeng/commonsdk/statistics/idtracking/e;->a(Lcom/umeng/commonsdk/statistics/idtracking/a;)Z

    .line 57
    sget-object v0, Lcom/umeng/commonsdk/statistics/idtracking/e;->b:Lcom/umeng/commonsdk/statistics/idtracking/e;

    new-instance v2, Lcom/umeng/commonsdk/statistics/idtracking/b;

    invoke-direct {v2, p0}, Lcom/umeng/commonsdk/statistics/idtracking/b;-><init>(Landroid/content/Context;)V

    invoke-direct {v0, v2}, Lcom/umeng/commonsdk/statistics/idtracking/e;->a(Lcom/umeng/commonsdk/statistics/idtracking/a;)Z

    .line 58
    sget-object v0, Lcom/umeng/commonsdk/statistics/idtracking/e;->b:Lcom/umeng/commonsdk/statistics/idtracking/e;

    new-instance v2, Lcom/umeng/commonsdk/statistics/idtracking/s;

    invoke-direct {v2, p0}, Lcom/umeng/commonsdk/statistics/idtracking/s;-><init>(Landroid/content/Context;)V

    invoke-direct {v0, v2}, Lcom/umeng/commonsdk/statistics/idtracking/e;->a(Lcom/umeng/commonsdk/statistics/idtracking/a;)Z

    .line 59
    sget-object v0, Lcom/umeng/commonsdk/statistics/idtracking/e;->b:Lcom/umeng/commonsdk/statistics/idtracking/e;

    new-instance v2, Lcom/umeng/commonsdk/statistics/idtracking/d;

    invoke-direct {v2, p0}, Lcom/umeng/commonsdk/statistics/idtracking/d;-><init>(Landroid/content/Context;)V

    invoke-direct {v0, v2}, Lcom/umeng/commonsdk/statistics/idtracking/e;->a(Lcom/umeng/commonsdk/statistics/idtracking/a;)Z

    .line 60
    sget-object v0, Lcom/umeng/commonsdk/statistics/idtracking/e;->b:Lcom/umeng/commonsdk/statistics/idtracking/e;

    new-instance v2, Lcom/umeng/commonsdk/statistics/idtracking/c;

    invoke-direct {v2, p0}, Lcom/umeng/commonsdk/statistics/idtracking/c;-><init>(Landroid/content/Context;)V

    invoke-direct {v0, v2}, Lcom/umeng/commonsdk/statistics/idtracking/e;->a(Lcom/umeng/commonsdk/statistics/idtracking/a;)Z

    .line 61
    sget-object v0, Lcom/umeng/commonsdk/statistics/idtracking/e;->b:Lcom/umeng/commonsdk/statistics/idtracking/e;

    new-instance v2, Lcom/umeng/commonsdk/statistics/idtracking/h;

    invoke-direct {v2, p0}, Lcom/umeng/commonsdk/statistics/idtracking/h;-><init>(Landroid/content/Context;)V

    invoke-direct {v0, v2}, Lcom/umeng/commonsdk/statistics/idtracking/e;->a(Lcom/umeng/commonsdk/statistics/idtracking/a;)Z

    .line 62
    sget-object v0, Lcom/umeng/commonsdk/statistics/idtracking/e;->b:Lcom/umeng/commonsdk/statistics/idtracking/e;

    new-instance v2, Lcom/umeng/commonsdk/statistics/idtracking/k;

    invoke-direct {v2}, Lcom/umeng/commonsdk/statistics/idtracking/k;-><init>()V

    invoke-direct {v0, v2}, Lcom/umeng/commonsdk/statistics/idtracking/e;->a(Lcom/umeng/commonsdk/statistics/idtracking/a;)Z

    .line 63
    sget-object v0, Lcom/umeng/commonsdk/statistics/idtracking/e;->b:Lcom/umeng/commonsdk/statistics/idtracking/e;

    new-instance v2, Lcom/umeng/commonsdk/statistics/idtracking/t;

    invoke-direct {v2, p0}, Lcom/umeng/commonsdk/statistics/idtracking/t;-><init>(Landroid/content/Context;)V

    invoke-direct {v0, v2}, Lcom/umeng/commonsdk/statistics/idtracking/e;->a(Lcom/umeng/commonsdk/statistics/idtracking/a;)Z

    .line 64
    new-instance v0, Lcom/umeng/commonsdk/statistics/idtracking/r;

    invoke-direct {v0, p0}, Lcom/umeng/commonsdk/statistics/idtracking/r;-><init>(Landroid/content/Context;)V

    .line 65
    invoke-virtual {v0}, Lcom/umeng/commonsdk/statistics/idtracking/r;->f()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 66
    sget-object v2, Lcom/umeng/commonsdk/statistics/idtracking/e;->b:Lcom/umeng/commonsdk/statistics/idtracking/e;

    invoke-direct {v2, v0}, Lcom/umeng/commonsdk/statistics/idtracking/e;->a(Lcom/umeng/commonsdk/statistics/idtracking/a;)Z

    .line 69
    :cond_0
    new-instance v0, Lcom/umeng/commonsdk/statistics/idtracking/j;

    invoke-direct {v0, p0}, Lcom/umeng/commonsdk/statistics/idtracking/j;-><init>(Landroid/content/Context;)V

    .line 70
    invoke-virtual {v0}, Lcom/umeng/commonsdk/statistics/idtracking/j;->g()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 71
    sget-object v2, Lcom/umeng/commonsdk/statistics/idtracking/e;->b:Lcom/umeng/commonsdk/statistics/idtracking/e;

    invoke-direct {v2, v0}, Lcom/umeng/commonsdk/statistics/idtracking/e;->a(Lcom/umeng/commonsdk/statistics/idtracking/a;)Z

    .line 72
    sget-object v2, Lcom/umeng/commonsdk/statistics/idtracking/e;->b:Lcom/umeng/commonsdk/statistics/idtracking/e;

    new-instance v3, Lcom/umeng/commonsdk/statistics/idtracking/i;

    invoke-direct {v3, p0}, Lcom/umeng/commonsdk/statistics/idtracking/i;-><init>(Landroid/content/Context;)V

    invoke-direct {v2, v3}, Lcom/umeng/commonsdk/statistics/idtracking/e;->a(Lcom/umeng/commonsdk/statistics/idtracking/a;)Z

    .line 73
    invoke-virtual {v0}, Lcom/umeng/commonsdk/statistics/idtracking/j;->i()V

    .line 76
    :cond_1
    sget-object v0, Lcom/umeng/commonsdk/statistics/idtracking/e;->b:Lcom/umeng/commonsdk/statistics/idtracking/e;

    new-instance v2, Lcom/umeng/commonsdk/statistics/idtracking/q;

    invoke-direct {v2, p0}, Lcom/umeng/commonsdk/statistics/idtracking/q;-><init>(Landroid/content/Context;)V

    invoke-direct {v0, v2}, Lcom/umeng/commonsdk/statistics/idtracking/e;->a(Lcom/umeng/commonsdk/statistics/idtracking/a;)Z

    .line 77
    sget-object v0, Lcom/umeng/commonsdk/statistics/idtracking/e;->b:Lcom/umeng/commonsdk/statistics/idtracking/e;

    new-instance v2, Lcom/umeng/commonsdk/statistics/idtracking/n;

    invoke-direct {v2, p0}, Lcom/umeng/commonsdk/statistics/idtracking/n;-><init>(Landroid/content/Context;)V

    invoke-direct {v0, v2}, Lcom/umeng/commonsdk/statistics/idtracking/e;->a(Lcom/umeng/commonsdk/statistics/idtracking/a;)Z

    .line 78
    sget-object v0, Lcom/umeng/commonsdk/statistics/idtracking/e;->b:Lcom/umeng/commonsdk/statistics/idtracking/e;

    new-instance v2, Lcom/umeng/commonsdk/statistics/idtracking/p;

    invoke-direct {v2, p0}, Lcom/umeng/commonsdk/statistics/idtracking/p;-><init>(Landroid/content/Context;)V

    invoke-direct {v0, v2}, Lcom/umeng/commonsdk/statistics/idtracking/e;->a(Lcom/umeng/commonsdk/statistics/idtracking/a;)Z

    .line 79
    sget-object v0, Lcom/umeng/commonsdk/statistics/idtracking/e;->b:Lcom/umeng/commonsdk/statistics/idtracking/e;

    new-instance v2, Lcom/umeng/commonsdk/statistics/idtracking/o;

    invoke-direct {v2, p0}, Lcom/umeng/commonsdk/statistics/idtracking/o;-><init>(Landroid/content/Context;)V

    invoke-direct {v0, v2}, Lcom/umeng/commonsdk/statistics/idtracking/e;->a(Lcom/umeng/commonsdk/statistics/idtracking/a;)Z

    .line 80
    sget-object v0, Lcom/umeng/commonsdk/statistics/idtracking/e;->b:Lcom/umeng/commonsdk/statistics/idtracking/e;

    new-instance v2, Lcom/umeng/commonsdk/statistics/idtracking/m;

    invoke-direct {v2, p0}, Lcom/umeng/commonsdk/statistics/idtracking/m;-><init>(Landroid/content/Context;)V

    invoke-direct {v0, v2}, Lcom/umeng/commonsdk/statistics/idtracking/e;->a(Lcom/umeng/commonsdk/statistics/idtracking/a;)Z

    .line 81
    sget-object v0, Lcom/umeng/commonsdk/statistics/idtracking/e;->b:Lcom/umeng/commonsdk/statistics/idtracking/e;

    new-instance v2, Lcom/umeng/commonsdk/statistics/idtracking/l;

    invoke-direct {v2, p0}, Lcom/umeng/commonsdk/statistics/idtracking/l;-><init>(Landroid/content/Context;)V

    invoke-direct {v0, v2}, Lcom/umeng/commonsdk/statistics/idtracking/e;->a(Lcom/umeng/commonsdk/statistics/idtracking/a;)Z

    .line 83
    sget-object v0, Lcom/umeng/commonsdk/statistics/idtracking/e;->b:Lcom/umeng/commonsdk/statistics/idtracking/e;

    invoke-virtual {v0}, Lcom/umeng/commonsdk/statistics/idtracking/e;->e()V

    .line 86
    :cond_2
    sget-object v0, Lcom/umeng/commonsdk/statistics/idtracking/e;->b:Lcom/umeng/commonsdk/statistics/idtracking/e;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v1

    return-object v0

    .line 53
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method private a(Lcom/umeng/commonsdk/statistics/proto/c;)V
    .locals 3

    .prologue
    .line 245
    sget-object v1, Lcom/umeng/commonsdk/statistics/idtracking/e;->j:Ljava/lang/Object;

    monitor-enter v1

    .line 246
    if-eqz p1, :cond_0

    .line 249
    :try_start_0
    monitor-enter p0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 250
    :try_start_1
    new-instance v0, Lcom/umeng/commonsdk/proguard/aj;

    invoke-direct {v0}, Lcom/umeng/commonsdk/proguard/aj;-><init>()V

    invoke-virtual {v0, p1}, Lcom/umeng/commonsdk/proguard/aj;->a(Lcom/umeng/commonsdk/proguard/aa;)[B

    move-result-object v0

    .line 251
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 253
    if-eqz v0, :cond_0

    .line 254
    :try_start_2
    iget-object v2, p0, Lcom/umeng/commonsdk/statistics/idtracking/e;->d:Ljava/io/File;

    invoke-static {v2, v0}, Lcom/umeng/commonsdk/statistics/common/HelperUtils;->writeFile(Ljava/io/File;[B)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 260
    :cond_0
    :goto_0
    :try_start_3
    monitor-exit v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 261
    return-void

    .line 251
    :catchall_0
    move-exception v0

    :try_start_4
    monitor-exit p0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    :try_start_5
    throw v0
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_0
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    .line 256
    :catch_0
    move-exception v0

    .line 257
    :try_start_6
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0

    .line 260
    :catchall_1
    move-exception v0

    monitor-exit v1
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    throw v0
.end method

.method private a(Lcom/umeng/commonsdk/statistics/idtracking/a;)Z
    .locals 2

    .prologue
    .line 90
    iget-object v0, p0, Lcom/umeng/commonsdk/statistics/idtracking/e;->i:Lcom/umeng/commonsdk/statistics/idtracking/e$a;

    invoke-virtual {p1}, Lcom/umeng/commonsdk/statistics/idtracking/a;->b()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/umeng/commonsdk/statistics/idtracking/e$a;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 91
    iget-object v0, p0, Lcom/umeng/commonsdk/statistics/idtracking/e;->h:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    move-result v0

    .line 96
    :goto_0
    return v0

    .line 92
    :cond_0
    sget-boolean v0, Lcom/umeng/commonsdk/statistics/b;->f:Z

    if-eqz v0, :cond_1

    .line 93
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "invalid domain: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Lcom/umeng/commonsdk/statistics/idtracking/a;->b()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->w(Ljava/lang/String;)V

    .line 96
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private declared-synchronized g()V
    .locals 7

    .prologue
    .line 137
    monitor-enter p0

    :try_start_0
    new-instance v1, Lcom/umeng/commonsdk/statistics/proto/c;

    invoke-direct {v1}, Lcom/umeng/commonsdk/statistics/proto/c;-><init>()V

    .line 138
    new-instance v2, Ljava/util/HashMap;

    invoke-direct {v2}, Ljava/util/HashMap;-><init>()V

    .line 139
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 141
    iget-object v0, p0, Lcom/umeng/commonsdk/statistics/idtracking/e;->h:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :cond_0
    :goto_0
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/umeng/commonsdk/statistics/idtracking/a;

    .line 142
    invoke-virtual {v0}, Lcom/umeng/commonsdk/statistics/idtracking/a;->c()Z

    move-result v5

    if-eqz v5, :cond_0

    .line 145
    invoke-virtual {v0}, Lcom/umeng/commonsdk/statistics/idtracking/a;->d()Lcom/umeng/commonsdk/statistics/proto/b;

    move-result-object v5

    if-eqz v5, :cond_1

    .line 146
    invoke-virtual {v0}, Lcom/umeng/commonsdk/statistics/idtracking/a;->b()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v0}, Lcom/umeng/commonsdk/statistics/idtracking/a;->d()Lcom/umeng/commonsdk/statistics/proto/b;

    move-result-object v6

    invoke-interface {v2, v5, v6}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 149
    :cond_1
    invoke-virtual {v0}, Lcom/umeng/commonsdk/statistics/idtracking/a;->e()Ljava/util/List;

    move-result-object v5

    if-eqz v5, :cond_0

    invoke-virtual {v0}, Lcom/umeng/commonsdk/statistics/idtracking/a;->e()Ljava/util/List;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/List;->isEmpty()Z

    move-result v5

    if-nez v5, :cond_0

    .line 150
    invoke-virtual {v0}, Lcom/umeng/commonsdk/statistics/idtracking/a;->e()Ljava/util/List;

    move-result-object v0

    invoke-interface {v3, v0}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 137
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    .line 154
    :cond_2
    :try_start_1
    invoke-virtual {v1, v3}, Lcom/umeng/commonsdk/statistics/proto/c;->a(Ljava/util/List;)Lcom/umeng/commonsdk/statistics/proto/c;

    .line 155
    invoke-virtual {v1, v2}, Lcom/umeng/commonsdk/statistics/proto/c;->a(Ljava/util/Map;)Lcom/umeng/commonsdk/statistics/proto/c;

    .line 157
    monitor-enter p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 159
    :try_start_2
    iput-object v1, p0, Lcom/umeng/commonsdk/statistics/idtracking/e;->e:Lcom/umeng/commonsdk/statistics/proto/c;

    .line 160
    monitor-exit p0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 161
    monitor-exit p0

    return-void

    .line 160
    :catchall_1
    move-exception v0

    :try_start_3
    monitor-exit p0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    :try_start_4
    throw v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0
.end method

.method private h()Lcom/umeng/commonsdk/statistics/proto/c;
    .locals 6

    .prologue
    const/4 v0, 0x0

    .line 221
    sget-object v3, Lcom/umeng/commonsdk/statistics/idtracking/e;->j:Ljava/lang/Object;

    monitor-enter v3

    .line 222
    :try_start_0
    iget-object v1, p0, Lcom/umeng/commonsdk/statistics/idtracking/e;->d:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_0

    .line 223
    monitor-exit v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 240
    :goto_0
    return-object v0

    .line 226
    :cond_0
    :try_start_1
    new-instance v2, Ljava/io/FileInputStream;

    iget-object v1, p0, Lcom/umeng/commonsdk/statistics/idtracking/e;->d:Ljava/io/File;

    invoke-direct {v2, v1}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 227
    :try_start_2
    invoke-static {v2}, Lcom/umeng/commonsdk/statistics/common/HelperUtils;->readStreamToByteArray(Ljava/io/InputStream;)[B

    move-result-object v4

    .line 229
    new-instance v1, Lcom/umeng/commonsdk/statistics/proto/c;

    invoke-direct {v1}, Lcom/umeng/commonsdk/statistics/proto/c;-><init>()V

    .line 230
    new-instance v5, Lcom/umeng/commonsdk/proguard/ad;

    invoke-direct {v5}, Lcom/umeng/commonsdk/proguard/ad;-><init>()V

    invoke-virtual {v5, v1, v4}, Lcom/umeng/commonsdk/proguard/ad;->a(Lcom/umeng/commonsdk/proguard/aa;[B)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    .line 236
    :try_start_3
    invoke-static {v2}, Lcom/umeng/commonsdk/statistics/common/HelperUtils;->safeClose(Ljava/io/InputStream;)V

    monitor-exit v3
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move-object v0, v1

    goto :goto_0

    .line 233
    :catch_0
    move-exception v1

    move-object v2, v0

    .line 234
    :goto_1
    :try_start_4
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    .line 236
    :try_start_5
    invoke-static {v2}, Lcom/umeng/commonsdk/statistics/common/HelperUtils;->safeClose(Ljava/io/InputStream;)V

    .line 238
    monitor-exit v3

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v3
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    throw v0

    .line 236
    :catchall_1
    move-exception v1

    move-object v2, v0

    move-object v0, v1

    :goto_2
    :try_start_6
    invoke-static {v2}, Lcom/umeng/commonsdk/statistics/common/HelperUtils;->safeClose(Ljava/io/InputStream;)V

    throw v0
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    :catchall_2
    move-exception v0

    goto :goto_2

    .line 233
    :catch_1
    move-exception v1

    goto :goto_1
.end method


# virtual methods
.method public declared-synchronized a()V
    .locals 6

    .prologue
    .line 104
    monitor-enter p0

    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    .line 105
    iget-wide v0, p0, Lcom/umeng/commonsdk/statistics/idtracking/e;->f:J

    sub-long v0, v2, v0

    iget-wide v4, p0, Lcom/umeng/commonsdk/statistics/idtracking/e;->g:J

    cmp-long v0, v0, v4

    if-ltz v0, :cond_4

    .line 106
    const/4 v1, 0x0

    .line 108
    iget-object v0, p0, Lcom/umeng/commonsdk/statistics/idtracking/e;->h:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :cond_0
    :goto_0
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/umeng/commonsdk/statistics/idtracking/a;

    .line 109
    invoke-virtual {v0}, Lcom/umeng/commonsdk/statistics/idtracking/a;->c()Z

    move-result v5

    if-eqz v5, :cond_0

    .line 113
    invoke-virtual {v0}, Lcom/umeng/commonsdk/statistics/idtracking/a;->a()Z

    move-result v5

    if-eqz v5, :cond_1

    .line 114
    const/4 v1, 0x1

    .line 116
    invoke-virtual {v0}, Lcom/umeng/commonsdk/statistics/idtracking/a;->c()Z

    move-result v5

    if-nez v5, :cond_1

    .line 117
    iget-object v5, p0, Lcom/umeng/commonsdk/statistics/idtracking/e;->i:Lcom/umeng/commonsdk/statistics/idtracking/e$a;

    invoke-virtual {v0}, Lcom/umeng/commonsdk/statistics/idtracking/a;->b()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v5, v0}, Lcom/umeng/commonsdk/statistics/idtracking/e$a;->b(Ljava/lang/String;)V

    :cond_1
    move v0, v1

    move v1, v0

    .line 120
    goto :goto_0

    .line 122
    :cond_2
    if-eqz v1, :cond_3

    .line 123
    invoke-direct {p0}, Lcom/umeng/commonsdk/statistics/idtracking/e;->g()V

    .line 124
    iget-object v0, p0, Lcom/umeng/commonsdk/statistics/idtracking/e;->i:Lcom/umeng/commonsdk/statistics/idtracking/e$a;

    invoke-virtual {v0}, Lcom/umeng/commonsdk/statistics/idtracking/e$a;->a()V

    .line 125
    invoke-virtual {p0}, Lcom/umeng/commonsdk/statistics/idtracking/e;->f()V

    .line 128
    :cond_3
    iput-wide v2, p0, Lcom/umeng/commonsdk/statistics/idtracking/e;->f:J
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 130
    :cond_4
    monitor-exit p0

    return-void

    .line 104
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public a(J)V
    .locals 1

    .prologue
    .line 100
    iput-wide p1, p0, Lcom/umeng/commonsdk/statistics/idtracking/e;->g:J

    .line 101
    return-void
.end method

.method public declared-synchronized b()Lcom/umeng/commonsdk/statistics/proto/c;
    .locals 1

    .prologue
    .line 133
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/umeng/commonsdk/statistics/idtracking/e;->e:Lcom/umeng/commonsdk/statistics/proto/c;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public c()Ljava/lang/String;
    .locals 1

    .prologue
    .line 164
    const/4 v0, 0x0

    return-object v0
.end method

.method public declared-synchronized d()V
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 168
    monitor-enter p0

    .line 169
    :try_start_0
    iget-object v0, p0, Lcom/umeng/commonsdk/statistics/idtracking/e;->h:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_0
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/umeng/commonsdk/statistics/idtracking/a;

    .line 170
    invoke-virtual {v0}, Lcom/umeng/commonsdk/statistics/idtracking/a;->c()Z

    move-result v3

    if-eqz v3, :cond_0

    .line 173
    invoke-virtual {v0}, Lcom/umeng/commonsdk/statistics/idtracking/a;->e()Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_3

    invoke-virtual {v0}, Lcom/umeng/commonsdk/statistics/idtracking/a;->e()Ljava/util/List;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/List;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_3

    .line 174
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/umeng/commonsdk/statistics/idtracking/a;->a(Ljava/util/List;)V

    .line 175
    const/4 v0, 0x1

    :goto_1
    move v1, v0

    .line 177
    goto :goto_0

    .line 179
    :cond_1
    if-eqz v1, :cond_2

    .line 180
    iget-object v0, p0, Lcom/umeng/commonsdk/statistics/idtracking/e;->e:Lcom/umeng/commonsdk/statistics/proto/c;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/umeng/commonsdk/statistics/proto/c;->b(Z)V

    .line 181
    invoke-virtual {p0}, Lcom/umeng/commonsdk/statistics/idtracking/e;->f()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 183
    :cond_2
    monitor-exit p0

    return-void

    .line 168
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    :cond_3
    move v0, v1

    goto :goto_1
.end method

.method public declared-synchronized e()V
    .locals 4

    .prologue
    .line 186
    monitor-enter p0

    :try_start_0
    invoke-direct {p0}, Lcom/umeng/commonsdk/statistics/idtracking/e;->h()Lcom/umeng/commonsdk/statistics/proto/c;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    move-result-object v0

    .line 188
    if-nez v0, :cond_0

    .line 210
    :goto_0
    monitor-exit p0

    return-void

    .line 191
    :cond_0
    :try_start_1
    new-instance v1, Ljava/util/ArrayList;

    iget-object v2, p0, Lcom/umeng/commonsdk/statistics/idtracking/e;->h:Ljava/util/Set;

    invoke-interface {v2}, Ljava/util/Set;->size()I

    move-result v2

    invoke-direct {v1, v2}, Ljava/util/ArrayList;-><init>(I)V

    .line 193
    monitor-enter p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 194
    :try_start_2
    iput-object v0, p0, Lcom/umeng/commonsdk/statistics/idtracking/e;->e:Lcom/umeng/commonsdk/statistics/proto/c;

    .line 196
    iget-object v0, p0, Lcom/umeng/commonsdk/statistics/idtracking/e;->h:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_1
    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/umeng/commonsdk/statistics/idtracking/a;

    .line 197
    iget-object v3, p0, Lcom/umeng/commonsdk/statistics/idtracking/e;->e:Lcom/umeng/commonsdk/statistics/proto/c;

    invoke-virtual {v0, v3}, Lcom/umeng/commonsdk/statistics/idtracking/a;->a(Lcom/umeng/commonsdk/statistics/proto/c;)V

    .line 199
    invoke-virtual {v0}, Lcom/umeng/commonsdk/statistics/idtracking/a;->c()Z

    move-result v3

    if-nez v3, :cond_1

    .line 200
    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .line 207
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :try_start_3
    throw v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 186
    :catchall_1
    move-exception v0

    monitor-exit p0

    throw v0

    .line 204
    :cond_2
    :try_start_4
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_2
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/umeng/commonsdk/statistics/idtracking/a;

    .line 205
    iget-object v2, p0, Lcom/umeng/commonsdk/statistics/idtracking/e;->h:Ljava/util/Set;

    invoke-interface {v2, v0}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    goto :goto_2

    .line 207
    :cond_3
    monitor-exit p0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 209
    :try_start_5
    invoke-direct {p0}, Lcom/umeng/commonsdk/statistics/idtracking/e;->g()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    goto :goto_0
.end method

.method public declared-synchronized f()V
    .locals 1

    .prologue
    .line 213
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/umeng/commonsdk/statistics/idtracking/e;->e:Lcom/umeng/commonsdk/statistics/proto/c;

    if-eqz v0, :cond_0

    .line 214
    iget-object v0, p0, Lcom/umeng/commonsdk/statistics/idtracking/e;->e:Lcom/umeng/commonsdk/statistics/proto/c;

    invoke-direct {p0, v0}, Lcom/umeng/commonsdk/statistics/idtracking/e;->a(Lcom/umeng/commonsdk/statistics/proto/c;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 215
    :cond_0
    monitor-exit p0

    return-void

    .line 213
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method
