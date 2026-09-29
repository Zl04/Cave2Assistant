.class public Lcom/umeng/commonsdk/proguard/b;
.super Ljava/lang/Object;
.source "UMInternalData.java"


# static fields
.field private static b:Lcom/umeng/commonsdk/proguard/b;


# instance fields
.field private a:Landroid/content/Context;

.field private c:Lcom/umeng/commonsdk/proguard/c;


# direct methods
.method private constructor <init>(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 18
    iput-object p1, p0, Lcom/umeng/commonsdk/proguard/b;->a:Landroid/content/Context;

    .line 19
    new-instance v0, Lcom/umeng/commonsdk/proguard/c;

    invoke-direct {v0, p1}, Lcom/umeng/commonsdk/proguard/c;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/umeng/commonsdk/proguard/b;->c:Lcom/umeng/commonsdk/proguard/c;

    .line 20
    return-void
.end method

.method public static declared-synchronized a(Landroid/content/Context;)Lcom/umeng/commonsdk/proguard/b;
    .locals 3

    .prologue
    .line 23
    const-class v1, Lcom/umeng/commonsdk/proguard/b;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/umeng/commonsdk/proguard/b;->b:Lcom/umeng/commonsdk/proguard/b;

    if-nez v0, :cond_0

    .line 24
    new-instance v0, Lcom/umeng/commonsdk/proguard/b;

    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    invoke-direct {v0, v2}, Lcom/umeng/commonsdk/proguard/b;-><init>(Landroid/content/Context;)V

    sput-object v0, Lcom/umeng/commonsdk/proguard/b;->b:Lcom/umeng/commonsdk/proguard/b;

    .line 26
    :cond_0
    sget-object v0, Lcom/umeng/commonsdk/proguard/b;->b:Lcom/umeng/commonsdk/proguard/b;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v1

    return-object v0

    .line 23
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method


# virtual methods
.method public a()Lcom/umeng/commonsdk/proguard/c;
    .locals 1

    .prologue
    .line 30
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/b;->c:Lcom/umeng/commonsdk/proguard/c;

    return-object v0
.end method
