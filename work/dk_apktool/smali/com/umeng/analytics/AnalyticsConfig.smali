.class public Lcom/umeng/analytics/AnalyticsConfig;
.super Ljava/lang/Object;
.source "AnalyticsConfig.java"


# static fields
.field public static ACTIVITY_DURATION_OPEN:Z

.field public static CATCH_EXCEPTION:Z

.field public static FLAG_DPLUS:Z

.field public static GPU_RENDERER:Ljava/lang/String;

.field public static GPU_VENDER:Ljava/lang/String;

.field static a:[D

.field private static b:Ljava/lang/String;

.field private static c:Ljava/lang/String;

.field private static d:Ljava/lang/String;

.field private static e:I

.field public static kContinueSessionMillis:J

.field public static mWrapperType:Ljava/lang/String;

.field public static mWrapperVersion:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .prologue
    const/4 v1, 0x1

    const/4 v3, 0x0

    const/4 v2, 0x0

    .line 16
    sput-object v2, Lcom/umeng/analytics/AnalyticsConfig;->b:Ljava/lang/String;

    .line 17
    sput-object v2, Lcom/umeng/analytics/AnalyticsConfig;->c:Ljava/lang/String;

    .line 18
    sput-object v2, Lcom/umeng/analytics/AnalyticsConfig;->d:Ljava/lang/String;

    .line 20
    sput-object v2, Lcom/umeng/analytics/AnalyticsConfig;->mWrapperType:Ljava/lang/String;

    .line 21
    sput-object v2, Lcom/umeng/analytics/AnalyticsConfig;->mWrapperVersion:Ljava/lang/String;

    .line 23
    sput v3, Lcom/umeng/analytics/AnalyticsConfig;->e:I

    .line 24
    const-string v0, ""

    sput-object v0, Lcom/umeng/analytics/AnalyticsConfig;->GPU_VENDER:Ljava/lang/String;

    .line 25
    const-string v0, ""

    sput-object v0, Lcom/umeng/analytics/AnalyticsConfig;->GPU_RENDERER:Ljava/lang/String;

    .line 27
    sput-boolean v1, Lcom/umeng/analytics/AnalyticsConfig;->ACTIVITY_DURATION_OPEN:Z

    .line 28
    sput-boolean v1, Lcom/umeng/analytics/AnalyticsConfig;->CATCH_EXCEPTION:Z

    .line 29
    const-wide/16 v0, 0x7530

    sput-wide v0, Lcom/umeng/analytics/AnalyticsConfig;->kContinueSessionMillis:J

    .line 33
    sput-boolean v3, Lcom/umeng/analytics/AnalyticsConfig;->FLAG_DPLUS:Z

    .line 40
    sput-object v2, Lcom/umeng/analytics/AnalyticsConfig;->a:[D

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static a(Landroid/content/Context;I)V
    .locals 2

    .prologue
    .line 84
    sput p1, Lcom/umeng/analytics/AnalyticsConfig;->e:I

    .line 85
    invoke-static {p0}, Lcom/umeng/analytics/pro/t;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/t;

    move-result-object v0

    sget v1, Lcom/umeng/analytics/AnalyticsConfig;->e:I

    invoke-virtual {v0, v1}, Lcom/umeng/analytics/pro/t;->a(I)V

    .line 86
    return-void
.end method

.method static a(Landroid/content/Context;Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 65
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 66
    sput-object p1, Lcom/umeng/analytics/AnalyticsConfig;->d:Ljava/lang/String;

    .line 67
    invoke-static {p0}, Lcom/umeng/analytics/pro/t;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/t;

    move-result-object v0

    sget-object v1, Lcom/umeng/analytics/AnalyticsConfig;->d:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/umeng/analytics/pro/t;->a(Ljava/lang/String;)V

    .line 69
    :cond_0
    return-void
.end method

.method static a(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 43
    sput-object p0, Lcom/umeng/analytics/AnalyticsConfig;->c:Ljava/lang/String;

    .line 44
    return-void
.end method

.method public static getAppkey(Landroid/content/Context;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 47
    invoke-static {p0}, Lcom/umeng/commonsdk/utils/UMUtils;->getAppkey(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getChannel(Landroid/content/Context;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 51
    invoke-static {p0}, Lcom/umeng/commonsdk/utils/UMUtils;->getChannel(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getLocation()[D
    .locals 1

    .prologue
    .line 55
    sget-object v0, Lcom/umeng/analytics/AnalyticsConfig;->a:[D

    return-object v0
.end method

.method public static getSecretKey(Landroid/content/Context;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 77
    sget-object v0, Lcom/umeng/analytics/AnalyticsConfig;->d:Ljava/lang/String;

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 78
    invoke-static {p0}, Lcom/umeng/analytics/pro/t;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/t;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/t;->c()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/umeng/analytics/AnalyticsConfig;->d:Ljava/lang/String;

    .line 80
    :cond_0
    sget-object v0, Lcom/umeng/analytics/AnalyticsConfig;->d:Ljava/lang/String;

    return-object v0
.end method

.method public static getVerticalType(Landroid/content/Context;)I
    .locals 1

    .prologue
    .line 89
    sget v0, Lcom/umeng/analytics/AnalyticsConfig;->e:I

    if-nez v0, :cond_0

    .line 90
    invoke-static {p0}, Lcom/umeng/analytics/pro/t;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/t;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/t;->d()I

    move-result v0

    sput v0, Lcom/umeng/analytics/AnalyticsConfig;->e:I

    .line 92
    :cond_0
    sget v0, Lcom/umeng/analytics/AnalyticsConfig;->e:I

    return v0
.end method
