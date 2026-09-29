.class public Lcom/umeng/commonsdk/stateless/a;
.super Ljava/lang/Object;
.source "UMSLConfig.java"


# static fields
.field public static a:J = 0x0L

.field public static b:J = 0x0L

.field public static final c:Ljava/lang/String; = "stateless"

.field public static d:[Ljava/lang/String; = null

.field public static final e:Ljava/lang/String; = "https://plbslog.umeng.com"

.field public static final f:Ljava/lang/String; = "http://11.239.113.99"

.field public static final g:Ljava/lang/String; = "https://preplbslog.umeng.com"

.field public static final h:Ljava/lang/String; = "https://plbslog.umeng.com"

.field public static final i:Ljava/lang/String; = "http://11.239.113.99"

.field public static final j:Ljava/lang/String; = "https://preplbslog.umeng.com"

.field public static final k:Ljava/lang/String; = "https://plbslog.umeng.com"


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    .line 11
    const-wide/32 v0, 0x200000

    sput-wide v0, Lcom/umeng/commonsdk/stateless/a;->a:J

    .line 12
    const-wide/32 v0, 0x32000

    sput-wide v0, Lcom/umeng/commonsdk/stateless/a;->b:J

    .line 21
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "https://preplbslog.umeng.com"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "https://preplbslog.umeng.com"

    aput-object v2, v0, v1

    sput-object v0, Lcom/umeng/commonsdk/stateless/a;->d:[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
