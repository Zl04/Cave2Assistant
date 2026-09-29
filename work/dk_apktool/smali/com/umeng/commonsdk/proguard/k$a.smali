.class Lcom/umeng/commonsdk/proguard/k$a;
.super Ljava/lang/Object;
.source "BaseStationUtils.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/umeng/commonsdk/proguard/k;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "a"
.end annotation


# static fields
.field private static final a:Lcom/umeng/commonsdk/proguard/k;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    .line 46
    new-instance v0, Lcom/umeng/commonsdk/proguard/k;

    invoke-static {}, Lcom/umeng/commonsdk/proguard/k;->d()Landroid/content/Context;

    move-result-object v1

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/umeng/commonsdk/proguard/k;-><init>(Landroid/content/Context;Lcom/umeng/commonsdk/proguard/k$1;)V

    sput-object v0, Lcom/umeng/commonsdk/proguard/k$a;->a:Lcom/umeng/commonsdk/proguard/k;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 45
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic a()Lcom/umeng/commonsdk/proguard/k;
    .locals 1

    .prologue
    .line 45
    sget-object v0, Lcom/umeng/commonsdk/proguard/k$a;->a:Lcom/umeng/commonsdk/proguard/k;

    return-object v0
.end method
