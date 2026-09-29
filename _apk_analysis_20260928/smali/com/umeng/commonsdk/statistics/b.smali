.class public Lcom/umeng/commonsdk/statistics/b;
.super Ljava/lang/Object;
.source "AnalyticsConstants.java"


# static fields
.field public static final a:Ljava/lang/String; = "Android"

.field public static final b:Ljava/lang/String; = "Android"

.field public static final c:Ljava/lang/String; = "MobclickAgent"

.field public static d:Z

.field public static e:[Ljava/lang/String;

.field public static final f:Z

.field private static g:I


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .prologue
    const/4 v3, 0x1

    .line 19
    sput-boolean v3, Lcom/umeng/commonsdk/statistics/b;->d:Z

    .line 41
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    sget-object v2, Lcom/umeng/commonsdk/statistics/UMServerURL;->DEFAULT_URL:Ljava/lang/String;

    aput-object v2, v0, v1

    sget-object v1, Lcom/umeng/commonsdk/statistics/UMServerURL;->SECONDARY_URL:Ljava/lang/String;

    aput-object v1, v0, v3

    sput-object v0, Lcom/umeng/commonsdk/statistics/b;->e:[Ljava/lang/String;

    .line 43
    sget-boolean v0, Lcom/umeng/commonsdk/statistics/common/e;->a:Z

    sput-boolean v0, Lcom/umeng/commonsdk/statistics/b;->f:Z

    .line 46
    sput v3, Lcom/umeng/commonsdk/statistics/b;->g:I

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static declared-synchronized a()I
    .locals 2

    .prologue
    .line 61
    const-class v0, Lcom/umeng/commonsdk/statistics/b;

    monitor-enter v0

    :try_start_0
    sget v1, Lcom/umeng/commonsdk/statistics/b;->g:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return v1

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public static a(I)V
    .locals 0

    .prologue
    .line 53
    sput p0, Lcom/umeng/commonsdk/statistics/b;->g:I

    .line 54
    return-void
.end method
