.class public Lcom/umeng/commonsdk/statistics/a;
.super Ljava/lang/Object;
.source "AnalyticsConfig.java"


# static fields
.field public static a:I

.field private static b:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 19
    const/4 v0, 0x0

    sput-object v0, Lcom/umeng/commonsdk/statistics/a;->b:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a(Landroid/content/Context;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 29
    sget-object v0, Lcom/umeng/commonsdk/statistics/a;->b:Ljava/lang/String;

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 30
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/d;->a(Landroid/content/Context;)Lcom/umeng/commonsdk/statistics/common/d;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/commonsdk/statistics/common/d;->b()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/umeng/commonsdk/statistics/a;->b:Ljava/lang/String;

    .line 32
    :cond_0
    sget-object v0, Lcom/umeng/commonsdk/statistics/a;->b:Ljava/lang/String;

    return-object v0
.end method
