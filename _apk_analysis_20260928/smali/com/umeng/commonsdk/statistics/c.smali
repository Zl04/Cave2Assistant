.class public Lcom/umeng/commonsdk/statistics/c;
.super Ljava/lang/Object;
.source "EnvelopeManager.java"


# static fields
.field public static a:Ljava/lang/String; = null

.field private static final b:Ljava/lang/String; = "EnvelopeManager"

.field private static c:Lcom/umeng/commonsdk/statistics/internal/StatTracer;

.field private static d:Lcom/umeng/commonsdk/statistics/noise/ImLatent;

.field private static e:Ljava/lang/String;

.field private static g:Z


# instance fields
.field private f:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 51
    sput-object v0, Lcom/umeng/commonsdk/statistics/c;->c:Lcom/umeng/commonsdk/statistics/internal/StatTracer;

    .line 52
    sput-object v0, Lcom/umeng/commonsdk/statistics/c;->d:Lcom/umeng/commonsdk/statistics/noise/ImLatent;

    .line 54
    sput-object v0, Lcom/umeng/commonsdk/statistics/c;->e:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .prologue
    .line 38
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 625
    const/4 v0, 0x0

    iput v0, p0, Lcom/umeng/commonsdk/statistics/c;->f:I

    return-void
.end method

.method private a(Landroid/content/Context;Lcom/umeng/commonsdk/statistics/idtracking/Envelope;Ljava/lang/String;Ljava/lang/String;)I
    .locals 4

    .prologue
    .line 742
    if-eqz p1, :cond_0

    if-eqz p2, :cond_0

    invoke-static {p3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 743
    :cond_0
    const/16 v0, 0x65

    .line 760
    :goto_0
    return v0

    .line 745
    :cond_1
    invoke-static {p4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 746
    invoke-static {p1}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getAppVersionName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p4

    .line 750
    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 751
    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "&&"

    .line 752
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 753
    invoke-virtual {v1, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "_"

    .line 754
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 755
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "_envelope.log"

    .line 756
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 758
    invoke-virtual {p2}, Lcom/umeng/commonsdk/statistics/idtracking/Envelope;->toBinary()[B

    move-result-object v1

    .line 760
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0, v1}, Lcom/umeng/commonsdk/framework/b;->a(Landroid/content/Context;Ljava/lang/String;[B)I

    move-result v0

    goto :goto_0
.end method

.method public static a(Landroid/content/Context;)J
    .locals 7

    .prologue
    .line 59
    sget-wide v0, Lcom/umeng/commonsdk/statistics/common/DataHelper;->ENVELOPE_ENTITY_RAW_LENGTH_MAX:J

    sget-wide v2, Lcom/umeng/commonsdk/statistics/common/DataHelper;->ENVELOPE_EXTRA_LENGTH:J

    sub-long/2addr v0, v2

    .line 60
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/c;->b(Landroid/content/Context;)Lorg/json/JSONObject;

    move-result-object v2

    .line 61
    if-eqz v2, :cond_1

    invoke-virtual {v2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_1

    .line 62
    invoke-virtual {v2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->getBytes()[B

    move-result-object v3

    if-eqz v3, :cond_1

    .line 64
    invoke-virtual {v2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->getBytes()[B

    move-result-object v2

    array-length v2, v2

    int-to-long v2, v2

    .line 65
    sget-boolean v4, Lcom/umeng/commonsdk/statistics/common/e;->a:Z

    if-eqz v4, :cond_0

    .line 66
    const-string v4, "EnvelopeManager"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "headerLen size is "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 68
    :cond_0
    sub-long/2addr v0, v2

    .line 70
    :cond_1
    sget-boolean v2, Lcom/umeng/commonsdk/statistics/common/e;->a:Z

    if-eqz v2, :cond_2

    .line 71
    const-string v2, "EnvelopeManager"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "free size is "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 73
    :cond_2
    return-wide v0
.end method

.method private a(Landroid/content/Context;[B)Lcom/umeng/commonsdk/statistics/idtracking/Envelope;
    .locals 3

    .prologue
    .line 700
    .line 701
    const/4 v0, -0x1

    .line 702
    const-string v1, "codex"

    const/4 v2, 0x0

    invoke-static {p1, v1, v2}, Lcom/umeng/commonsdk/framework/UMEnvelopeBuild;->imprintProperty(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 705
    :try_start_0
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 706
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 713
    :cond_0
    :goto_0
    if-nez v0, :cond_1

    .line 714
    invoke-static {p1}, Lcom/umeng/commonsdk/utils/UMUtils;->getAppkey(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0, p2}, Lcom/umeng/commonsdk/statistics/idtracking/Envelope;->genEnvelope(Landroid/content/Context;Ljava/lang/String;[B)Lcom/umeng/commonsdk/statistics/idtracking/Envelope;

    move-result-object v0

    .line 725
    :goto_1
    return-object v0

    .line 709
    :catch_0
    move-exception v1

    .line 710
    invoke-static {p1, v1}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_0

    .line 715
    :cond_1
    const/4 v1, 0x1

    if-ne v0, v1, :cond_2

    .line 716
    invoke-static {p1}, Lcom/umeng/commonsdk/utils/UMUtils;->getAppkey(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0, p2}, Lcom/umeng/commonsdk/statistics/idtracking/Envelope;->genEncryptEnvelope(Landroid/content/Context;Ljava/lang/String;[B)Lcom/umeng/commonsdk/statistics/idtracking/Envelope;

    move-result-object v0

    goto :goto_1

    .line 718
    :cond_2
    sget-boolean v0, Lcom/umeng/commonsdk/statistics/c;->g:Z

    if-eqz v0, :cond_3

    .line 719
    invoke-static {p1}, Lcom/umeng/commonsdk/utils/UMUtils;->getAppkey(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0, p2}, Lcom/umeng/commonsdk/statistics/idtracking/Envelope;->genEncryptEnvelope(Landroid/content/Context;Ljava/lang/String;[B)Lcom/umeng/commonsdk/statistics/idtracking/Envelope;

    move-result-object v0

    goto :goto_1

    .line 721
    :cond_3
    invoke-static {p1}, Lcom/umeng/commonsdk/utils/UMUtils;->getAppkey(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0, p2}, Lcom/umeng/commonsdk/statistics/idtracking/Envelope;->genEnvelope(Landroid/content/Context;Ljava/lang/String;[B)Lcom/umeng/commonsdk/statistics/idtracking/Envelope;

    move-result-object v0

    goto :goto_1
.end method

.method private a(ILorg/json/JSONObject;)Lorg/json/JSONObject;
    .locals 1

    .prologue
    .line 77
    if-eqz p2, :cond_0

    .line 79
    :try_start_0
    const-string v0, "exception"

    invoke-virtual {p2, v0, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .line 87
    :goto_0
    return-object p2

    .line 83
    :cond_0
    new-instance p2, Lorg/json/JSONObject;

    invoke-direct {p2}, Lorg/json/JSONObject;-><init>()V

    .line 85
    :try_start_1
    const-string v0, "exception"

    invoke-virtual {p2, v0, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .line 86
    :catch_0
    move-exception v0

    goto :goto_0

    .line 80
    :catch_1
    move-exception v0

    goto :goto_0
.end method

.method private a(Lorg/json/JSONObject;Lorg/json/JSONObject;)Lorg/json/JSONObject;
    .locals 4

    .prologue
    .line 661
    if-eqz p1, :cond_1

    if-eqz p2, :cond_1

    .line 662
    const-string v0, "header"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->opt(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_1

    const-string v0, "header"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->opt(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    instance-of v0, v0, Lorg/json/JSONObject;

    if-eqz v0, :cond_1

    .line 663
    const-string v0, "header"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->opt(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/json/JSONObject;

    .line 664
    invoke-virtual {p2}, Lorg/json/JSONObject;->keys()Ljava/util/Iterator;

    move-result-object v2

    .line 665
    :cond_0
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 666
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    .line 667
    if-eqz v1, :cond_0

    instance-of v3, v1, Ljava/lang/String;

    if-eqz v3, :cond_0

    .line 668
    check-cast v1, Ljava/lang/String;

    .line 669
    if-eqz v1, :cond_0

    invoke-virtual {p2, v1}, Lorg/json/JSONObject;->opt(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    if-eqz v3, :cond_0

    .line 671
    :try_start_0
    invoke-virtual {p2, v1}, Lorg/json/JSONObject;->opt(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v0, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 672
    const-string v3, "vertical_type"

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-virtual {p2, v1}, Lorg/json/JSONObject;->opt(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    instance-of v3, v3, Ljava/lang/Integer;

    if-eqz v3, :cond_0

    .line 673
    invoke-virtual {p2, v1}, Lorg/json/JSONObject;->opt(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    iput v1, p0, Lcom/umeng/commonsdk/statistics/c;->f:I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 675
    :catch_0
    move-exception v1

    goto :goto_0

    .line 684
    :cond_1
    return-object p1
.end method

.method public static a(Z)V
    .locals 0

    .prologue
    .line 778
    sput-boolean p0, Lcom/umeng/commonsdk/statistics/c;->g:Z

    .line 779
    return-void
.end method

.method private static b(Landroid/content/Context;)Lorg/json/JSONObject;
    .locals 7

    .prologue
    const/4 v0, 0x0

    .line 387
    :try_start_0
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v3

    .line 390
    sget-object v1, Lcom/umeng/commonsdk/statistics/c;->e:Ljava/lang/String;

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    move-result v1

    if-nez v1, :cond_1

    .line 392
    :try_start_1
    new-instance v1, Lorg/json/JSONObject;

    sget-object v2, Lcom/umeng/commonsdk/statistics/c;->e:Ljava/lang/String;

    invoke-direct {v1, v2}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    move-object v2, v1

    .line 476
    :goto_0
    if-nez v2, :cond_b

    .line 622
    :cond_0
    :goto_1
    return-object v0

    .line 393
    :catch_0
    move-exception v1

    move-object v2, v0

    goto :goto_0

    .line 395
    :cond_1
    :try_start_2
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 403
    const-string v2, "app_signature"

    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getAppMD5Signature(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 404
    const-string v2, "app_sig_sha1"

    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getAppSHA1Key(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 405
    const-string v2, "app_sig_sha"

    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getAppHashKey(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 406
    const-string v2, "app_version"

    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getAppVersionName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 407
    const-string v2, "version_code"

    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getAppVersionCode(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v4

    invoke-virtual {v1, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 408
    const-string v2, "idmd5"

    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getDeviceIdUmengMD5(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 409
    const-string v2, "cpu"

    invoke-static {}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getCPU()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 410
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getMCCMNC(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    .line 411
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_8

    .line 412
    const-string v4, "mccmnc"

    invoke-virtual {v1, v4, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 416
    :goto_2
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getSubOSName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    .line 417
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_2

    .line 418
    const-string v4, "sub_os_name"

    invoke-virtual {v1, v4, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 420
    :cond_2
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getSubOSVersion(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    .line 421
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_3

    .line 422
    const-string v4, "sub_os_version"

    invoke-virtual {v1, v4, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 424
    :cond_3
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getDeviceType(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    .line 425
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_4

    .line 426
    const-string v4, "device_type"

    invoke-virtual {v1, v4, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 428
    :cond_4
    const-string v2, "package_name"

    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getPackageName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 429
    const-string v2, "sdk_type"

    const-string v4, "Android"

    invoke-virtual {v1, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 430
    const-string v2, "device_id"

    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getDeviceId(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 431
    const-string v2, "device_model"

    sget-object v4, Landroid/os/Build;->MODEL:Ljava/lang/String;

    invoke-virtual {v1, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 432
    const-string v2, "device_board"

    sget-object v4, Landroid/os/Build;->BOARD:Ljava/lang/String;

    invoke-virtual {v1, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 433
    const-string v2, "device_brand"

    sget-object v4, Landroid/os/Build;->BRAND:Ljava/lang/String;

    invoke-virtual {v1, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 434
    const-string v2, "device_manutime"

    sget-wide v4, Landroid/os/Build;->TIME:J

    invoke-virtual {v1, v2, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 435
    const-string v2, "device_manufacturer"

    sget-object v4, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    invoke-virtual {v1, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 436
    const-string v2, "device_manuid"

    sget-object v4, Landroid/os/Build;->ID:Ljava/lang/String;

    invoke-virtual {v1, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 437
    const-string v2, "device_name"

    sget-object v4, Landroid/os/Build;->DEVICE:Ljava/lang/String;

    invoke-virtual {v1, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 438
    const-string v2, "os"

    const-string v4, "Android"

    invoke-virtual {v1, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 439
    const-string v2, "os_version"

    sget-object v4, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    invoke-virtual {v1, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 440
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getResolutionArray(Landroid/content/Context;)[I

    move-result-object v2

    .line 441
    if-eqz v2, :cond_5

    .line 442
    const-string v4, "resolution"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v6, 0x1

    aget v6, v2, v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "*"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const/4 v6, 0x0

    aget v2, v2, v6

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v4, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 444
    :cond_5
    const-string v2, "mc"

    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getMac(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 445
    const-string v2, "timezone"

    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getTimeZone(Landroid/content/Context;)I

    move-result v4

    invoke-virtual {v1, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 446
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getLocaleInfo(Landroid/content/Context;)[Ljava/lang/String;

    move-result-object v2

    .line 447
    const-string v4, "country"

    const/4 v5, 0x0

    aget-object v5, v2, v5

    invoke-virtual {v1, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 448
    const-string v4, "language"

    const/4 v5, 0x1

    aget-object v2, v2, v5

    invoke-virtual {v1, v4, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 449
    const-string v2, "carrier"

    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getNetworkOperatorName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 450
    const-string v2, "display_name"

    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getAppName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 451
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getNetworkAccessMode(Landroid/content/Context;)[Ljava/lang/String;

    move-result-object v2

    .line 452
    const-string v4, "Wi-Fi"

    const/4 v5, 0x0

    aget-object v5, v2, v5

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_9

    .line 453
    const-string v4, "access"

    const-string v5, "wifi"

    invoke-virtual {v1, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 462
    :goto_3
    const-string v4, ""

    const/4 v5, 0x1

    aget-object v5, v2, v5

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_6

    .line 463
    const-string v4, "access_subtype"

    const/4 v5, 0x1

    aget-object v2, v2, v5

    invoke-virtual {v1, v4, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 466
    :cond_6
    const-string v2, "com_ver"

    const-string v4, "1.3.2"

    invoke-virtual {v1, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 468
    sget-object v2, Lcom/umeng/commonsdk/statistics/c;->a:Ljava/lang/String;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_7

    .line 469
    const-string v2, "module"

    sget-object v4, Lcom/umeng/commonsdk/statistics/c;->a:Ljava/lang/String;

    invoke-virtual {v1, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 472
    :cond_7
    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v2

    sput-object v2, Lcom/umeng/commonsdk/statistics/c;->e:Ljava/lang/String;

    move-object v2, v1

    goto/16 :goto_0

    .line 414
    :cond_8
    const-string v2, "mccmnc"

    const-string v4, ""

    invoke-virtual {v1, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    goto/16 :goto_2

    .line 618
    :catch_1
    move-exception v1

    .line 619
    invoke-static {p0, v1}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto/16 :goto_1

    .line 455
    :cond_9
    :try_start_3
    const-string v4, "2G/3G"

    const/4 v5, 0x0

    aget-object v5, v2, v5

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_a

    .line 456
    const-string v4, "access"

    const-string v5, "2G/3G"

    invoke-virtual {v1, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_3

    .line 459
    :cond_a
    const-string v4, "access"

    const-string v5, "unknow"

    invoke-virtual {v1, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_3

    .line 481
    :cond_b
    :try_start_4
    const-string v1, "successful_requests"

    const-string v4, "successful_request"

    const/4 v5, 0x0

    invoke-interface {v3, v4, v5}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v4

    invoke-virtual {v2, v1, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 482
    const-string v1, "failed_requests"

    const-string v4, "failed_requests"

    const/4 v5, 0x0

    invoke-interface {v3, v4, v5}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v4

    invoke-virtual {v2, v1, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 483
    const-string v1, "req_time"

    const-string v4, "last_request_spent_ms"

    const/4 v5, 0x0

    invoke-interface {v3, v4, v5}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v3

    invoke-virtual {v2, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_6
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_1

    .line 488
    :goto_4
    :try_start_5
    const-string v1, "channel"

    invoke-static {p0}, Lcom/umeng/commonsdk/utils/UMUtils;->getChannel(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 490
    const-string v1, "appkey"

    invoke-static {p0}, Lcom/umeng/commonsdk/utils/UMUtils;->getAppkey(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_1

    .line 493
    :try_start_6
    invoke-static {p0}, Lcom/umeng/commonsdk/utils/UMUtils;->getDeviceToken(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    .line 494
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_c

    .line 495
    const-string v3, "devicetoken"

    invoke-virtual {v2, v3, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_2
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_1

    .line 505
    :cond_c
    :goto_5
    :try_start_7
    new-instance v1, Lcom/umeng/commonsdk/proguard/q;

    invoke-direct {v1, p0}, Lcom/umeng/commonsdk/proguard/q;-><init>(Landroid/content/Context;)V

    .line 506
    if-eqz v1, :cond_d

    invoke-virtual {v1}, Lcom/umeng/commonsdk/proguard/q;->a()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_d

    .line 507
    const-string v3, "umtt"

    invoke-virtual {v1}, Lcom/umeng/commonsdk/proguard/q;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v3, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_3
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_1

    .line 513
    :cond_d
    :goto_6
    :try_start_8
    const-string v1, "umid"

    const/4 v3, 0x0

    invoke-static {p0, v1, v3}, Lcom/umeng/commonsdk/framework/UMEnvelopeBuild;->imprintProperty(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 514
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 515
    const-string v3, "umid"

    invoke-virtual {v2, v3, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_8
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_4
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_1

    .line 525
    :cond_e
    :goto_7
    :try_start_9
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/idtracking/g;->a(Landroid/content/Context;)Lcom/umeng/commonsdk/statistics/idtracking/g;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/commonsdk/statistics/idtracking/g;->a()Lcom/umeng/commonsdk/statistics/proto/d;

    move-result-object v1

    .line 526
    if-eqz v1, :cond_f

    .line 527
    new-instance v3, Lcom/umeng/commonsdk/proguard/aj;

    invoke-direct {v3}, Lcom/umeng/commonsdk/proguard/aj;-><init>()V

    invoke-virtual {v3, v1}, Lcom/umeng/commonsdk/proguard/aj;->a(Lcom/umeng/commonsdk/proguard/aa;)[B

    move-result-object v1

    .line 528
    const-string v3, "imprint"

    const/4 v4, 0x0

    invoke-static {v1, v4}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v3, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_9
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_5
    .catch Ljava/lang/Throwable; {:try_start_9 .. :try_end_9} :catch_1

    .line 614
    :cond_f
    :goto_8
    if-eqz v2, :cond_0

    :try_start_a
    invoke-virtual {v2}, Lorg/json/JSONObject;->length()I

    move-result v1

    if-lez v1, :cond_0

    .line 615
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 616
    const-string v3, "header"

    invoke-virtual {v1, v3, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v0

    goto/16 :goto_1

    .line 497
    :catch_2
    move-exception v1

    .line 498
    invoke-static {p0, v1}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_5

    .line 509
    :catch_3
    move-exception v1

    .line 510
    invoke-static {p0, v1}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_6

    .line 517
    :catch_4
    move-exception v1

    .line 518
    invoke-static {p0, v1}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_7

    .line 533
    :catch_5
    move-exception v1

    .line 534
    invoke-static {p0, v1}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V
    :try_end_a
    .catch Ljava/lang/Throwable; {:try_start_a .. :try_end_a} :catch_1

    goto :goto_8

    .line 484
    :catch_6
    move-exception v1

    goto/16 :goto_4
.end method


# virtual methods
.method public a(Landroid/content/Context;Lorg/json/JSONObject;Lorg/json/JSONObject;)Lorg/json/JSONObject;
    .locals 15

    .prologue
    .line 103
    sget-boolean v2, Lcom/umeng/commonsdk/statistics/common/e;->a:Z

    if-eqz v2, :cond_0

    .line 104
    if-eqz p2, :cond_0

    if-eqz p3, :cond_0

    .line 105
    const-string v2, "EnvelopeManager"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "headerJSONObject size is "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual/range {p2 .. p2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/String;->getBytes()[B

    move-result-object v4

    array-length v4, v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 106
    const-string v2, "EnvelopeManager"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "bodyJSONObject size is "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual/range {p3 .. p3}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/String;->getBytes()[B

    move-result-object v4

    array-length v4, v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 110
    :cond_0
    if-eqz p1, :cond_1

    if-nez p3, :cond_2

    .line 111
    :cond_1
    const/16 v2, 0x6e

    const/4 v3, 0x0

    invoke-direct {p0, v2, v3}, Lcom/umeng/commonsdk/statistics/c;->a(ILorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object v2

    .line 382
    :goto_0
    return-object v2

    .line 118
    :cond_2
    :try_start_0
    invoke-static/range {p1 .. p1}, Lcom/umeng/commonsdk/statistics/c;->b(Landroid/content/Context;)Lorg/json/JSONObject;

    move-result-object v3

    .line 123
    if-eqz v3, :cond_3

    if-eqz p2, :cond_3

    .line 124
    move-object/from16 v0, p2

    invoke-direct {p0, v3, v0}, Lcom/umeng/commonsdk/statistics/c;->a(Lorg/json/JSONObject;Lorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object v3

    .line 130
    :cond_3
    if-eqz v3, :cond_5

    if-eqz p3, :cond_5

    .line 131
    invoke-virtual/range {p3 .. p3}, Lorg/json/JSONObject;->keys()Ljava/util/Iterator;

    move-result-object v4

    .line 132
    :cond_4
    :goto_1
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_5

    .line 133
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    .line 134
    if-eqz v2, :cond_4

    instance-of v5, v2, Ljava/lang/String;

    if-eqz v5, :cond_4

    .line 135
    check-cast v2, Ljava/lang/String;

    .line 136
    if-eqz v2, :cond_4

    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->opt(Ljava/lang/String;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v5

    if-eqz v5, :cond_4

    .line 138
    :try_start_1
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->opt(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v3, v2, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_1

    .line 139
    :catch_0
    move-exception v2

    goto :goto_1

    .line 150
    :cond_5
    const/4 v2, 0x0

    .line 151
    if-eqz v3, :cond_20

    .line 153
    :try_start_2
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    .line 154
    invoke-virtual {v3}, Lorg/json/JSONObject;->length()I

    move-result v2

    if-lez v2, :cond_a

    .line 155
    const-string v2, "push"

    invoke-virtual {v3, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_6

    .line 156
    const-string v2, "p"

    .line 157
    const-string v5, "header"

    invoke-virtual {v3, v5}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v5

    const-string v6, "p_sdk_v"

    .line 158
    invoke-virtual {v5, v6}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 159
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_6

    invoke-static {v5}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_6

    .line 160
    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v6, "=="

    .line 161
    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 162
    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v5, "&="

    .line 163
    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 166
    :cond_6
    const-string v2, "share"

    invoke-virtual {v3, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_7

    .line 167
    const-string v2, "s"

    .line 168
    const-string v5, "header"

    invoke-virtual {v3, v5}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v5

    const-string v6, "s_sdk_v"

    .line 169
    invoke-virtual {v5, v6}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 170
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_7

    invoke-static {v5}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_7

    .line 171
    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v6, "=="

    .line 172
    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 173
    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v5, "&="

    .line 174
    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 177
    :cond_7
    const-string v2, "analytics"

    invoke-virtual {v3, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_8

    .line 179
    const-string v2, "dplus"

    invoke-virtual {v3, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_b

    .line 180
    const-string v2, "ad"

    .line 184
    :goto_2
    const-string v5, "header"

    invoke-virtual {v3, v5}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v5

    const-string v6, "sdk_version"

    .line 185
    invoke-virtual {v5, v6}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 186
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_8

    invoke-static {v5}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_8

    .line 187
    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v6, "=="

    .line 188
    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 189
    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v5, "&="

    .line 190
    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 193
    :cond_8
    const-string v2, "dplus"

    invoke-virtual {v3, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_9

    .line 195
    const-string v2, "header"

    invoke-virtual {v3, v2}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v2

    const-string v5, "sdk_version"

    .line 196
    invoke-virtual {v2, v5}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 197
    const-string v5, "analytics"

    invoke-virtual {v3, v5}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_c

    .line 198
    const-string v5, "ad"

    .line 200
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    const-string v7, "ad"

    invoke-virtual {v6, v7}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_9

    .line 201
    invoke-static {v5}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_9

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_9

    .line 202
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "=="

    .line 203
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    .line 204
    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v5, "&="

    .line 205
    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 219
    :cond_9
    :goto_3
    const-string v2, "inner"

    invoke-virtual {v3, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_a

    .line 220
    const-string v2, "i"

    .line 221
    const-string v5, "header"

    invoke-virtual {v3, v5}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v5

    const-string v6, "i_sdk_v"

    .line 222
    invoke-virtual {v5, v6}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 223
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_a

    invoke-static {v5}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_a

    .line 224
    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v6, "=="

    .line 225
    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 226
    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v5, "&="

    .line 227
    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 232
    :cond_a
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 233
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_f

    .line 234
    const/16 v2, 0x65

    invoke-direct {p0, v2, v3}, Lcom/umeng/commonsdk/statistics/c;->a(ILorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object v2

    goto/16 :goto_0

    .line 182
    :cond_b
    const-string v2, "a"

    goto/16 :goto_2

    .line 209
    :cond_c
    const-string v5, "d"

    .line 210
    invoke-static {v5}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_9

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_9

    .line 211
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "=="

    .line 212
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    .line 213
    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v5, "&="

    .line 214
    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_3

    .line 338
    :catch_1
    move-exception v2

    .line 339
    move-object/from16 v0, p1

    invoke-static {v0, v2}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    .line 346
    const/4 v3, 0x0

    .line 348
    if-eqz p2, :cond_1d

    .line 349
    if-nez v3, :cond_d

    .line 350
    :try_start_3
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_4

    move-object v3, v2

    .line 353
    :cond_d
    :try_start_4
    const-string v2, "header"

    move-object/from16 v0, p2

    invoke-virtual {v3, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_4
    .catch Lorg/json/JSONException; {:try_start_4 .. :try_end_4} :catch_3
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_5

    move-object v2, v3

    .line 358
    :goto_4
    if-eqz p3, :cond_1a

    .line 359
    if-nez v2, :cond_1c

    .line 360
    :try_start_5
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_6

    .line 362
    :goto_5
    if-eqz p3, :cond_1b

    .line 363
    :try_start_6
    invoke-virtual/range {p3 .. p3}, Lorg/json/JSONObject;->keys()Ljava/util/Iterator;

    move-result-object v4

    .line 364
    :cond_e
    :goto_6
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1b

    .line 365
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    .line 366
    if-eqz v2, :cond_e

    instance-of v5, v2, Ljava/lang/String;

    if-eqz v5, :cond_e

    .line 367
    check-cast v2, Ljava/lang/String;

    .line 368
    if-eqz v2, :cond_e

    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->opt(Ljava/lang/String;)Ljava/lang/Object;
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_7

    move-result-object v5

    if-eqz v5, :cond_e

    .line 370
    :try_start_7
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->opt(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v3, v2, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_2

    goto :goto_6

    .line 371
    :catch_2
    move-exception v2

    goto :goto_6

    .line 237
    :cond_f
    :try_start_8
    const-string v4, "&="

    invoke-virtual {v2, v4}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_1f

    .line 238
    const/4 v4, 0x0

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v5

    add-int/lit8 v5, v5, -0x2

    invoke-virtual {v2, v4, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_1

    move-result-object v2

    move-object v5, v2

    .line 246
    :goto_7
    if-eqz v3, :cond_10

    .line 247
    :try_start_9
    invoke-static/range {p1 .. p1}, Lcom/umeng/commonsdk/statistics/idtracking/e;->a(Landroid/content/Context;)Lcom/umeng/commonsdk/statistics/idtracking/e;

    move-result-object v2

    .line 248
    if-eqz v2, :cond_10

    .line 249
    invoke-virtual {v2}, Lcom/umeng/commonsdk/statistics/idtracking/e;->a()V

    .line 250
    invoke-virtual {v2}, Lcom/umeng/commonsdk/statistics/idtracking/e;->b()Lcom/umeng/commonsdk/statistics/proto/c;

    move-result-object v2

    .line 251
    new-instance v4, Lcom/umeng/commonsdk/proguard/aj;

    invoke-direct {v4}, Lcom/umeng/commonsdk/proguard/aj;-><init>()V

    invoke-virtual {v4, v2}, Lcom/umeng/commonsdk/proguard/aj;->a(Lcom/umeng/commonsdk/proguard/aa;)[B

    move-result-object v2

    .line 252
    const/4 v4, 0x0

    invoke-static {v2, v4}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object v2

    .line 253
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_10

    .line 254
    const-string v4, "header"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v4

    .line 255
    const-string v6, "id_tracking"

    invoke-virtual {v4, v6, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 256
    const-string v2, "header"

    invoke-virtual {v3, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_9
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_9
    .catch Ljava/lang/Throwable; {:try_start_9 .. :try_end_9} :catch_1

    .line 266
    :cond_10
    :goto_8
    :try_start_a
    sget-object v2, Lcom/umeng/commonsdk/statistics/c;->c:Lcom/umeng/commonsdk/statistics/internal/StatTracer;

    if-nez v2, :cond_11

    .line 267
    invoke-static/range {p1 .. p1}, Lcom/umeng/commonsdk/statistics/internal/StatTracer;->getInstance(Landroid/content/Context;)Lcom/umeng/commonsdk/statistics/internal/StatTracer;

    move-result-object v2

    sput-object v2, Lcom/umeng/commonsdk/statistics/c;->c:Lcom/umeng/commonsdk/statistics/internal/StatTracer;

    .line 268
    sget-object v2, Lcom/umeng/commonsdk/statistics/c;->c:Lcom/umeng/commonsdk/statistics/internal/StatTracer;

    move-object/from16 v0, p1

    invoke-static {v0, v2}, Lcom/umeng/commonsdk/statistics/noise/ImLatent;->getService(Landroid/content/Context;Lcom/umeng/commonsdk/statistics/internal/StatTracer;)Lcom/umeng/commonsdk/statistics/noise/ImLatent;

    move-result-object v2

    sput-object v2, Lcom/umeng/commonsdk/statistics/c;->d:Lcom/umeng/commonsdk/statistics/noise/ImLatent;

    .line 270
    :cond_11
    sget-object v2, Lcom/umeng/commonsdk/statistics/c;->d:Lcom/umeng/commonsdk/statistics/noise/ImLatent;

    if-eqz v2, :cond_12

    sget-object v2, Lcom/umeng/commonsdk/statistics/c;->d:Lcom/umeng/commonsdk/statistics/noise/ImLatent;

    invoke-virtual {v2}, Lcom/umeng/commonsdk/statistics/noise/ImLatent;->shouldStartLatency()Z

    move-result v2

    if-eqz v2, :cond_12

    .line 271
    sget-object v2, Lcom/umeng/commonsdk/statistics/c;->d:Lcom/umeng/commonsdk/statistics/noise/ImLatent;

    invoke-virtual {v2}, Lcom/umeng/commonsdk/statistics/noise/ImLatent;->getDelayTime()J

    move-result-wide v6

    .line 272
    sget-object v2, Lcom/umeng/commonsdk/statistics/c;->d:Lcom/umeng/commonsdk/statistics/noise/ImLatent;

    invoke-virtual {v2}, Lcom/umeng/commonsdk/statistics/noise/ImLatent;->getElapsedTime()J
    :try_end_a
    .catch Ljava/lang/Throwable; {:try_start_a .. :try_end_a} :catch_1

    move-result-wide v8

    .line 274
    if-eqz v3, :cond_12

    .line 275
    :try_start_b
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 276
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4}, Lorg/json/JSONObject;-><init>()V

    .line 277
    const-string v10, "interval"

    const-wide/16 v12, 0x3e8

    div-long/2addr v8, v12

    invoke-virtual {v4, v10, v8, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 278
    const-string v8, "latency"

    invoke-virtual {v4, v8, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 279
    const-string v6, "latent"

    invoke-virtual {v2, v6, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 281
    const-string v4, "header"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v4

    .line 282
    const-string v6, "control_policy"

    invoke-virtual {v4, v6, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 283
    const-string v2, "header"

    invoke-virtual {v3, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_b
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_b} :catch_8
    .catch Ljava/lang/Throwable; {:try_start_b .. :try_end_b} :catch_1

    .line 292
    :cond_12
    :goto_9
    if-eqz v3, :cond_14

    :try_start_c
    invoke-virtual {v3}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->getBytes()[B

    move-result-object v2

    array-length v2, v2

    int-to-long v6, v2

    sget-wide v8, Lcom/umeng/commonsdk/statistics/common/DataHelper;->ENVELOPE_ENTITY_RAW_LENGTH_MAX:J

    invoke-static {v6, v7, v8, v9}, Lcom/umeng/commonsdk/statistics/common/DataHelper;->largeThanMaxSize(JJ)Z

    move-result v2

    if-eqz v2, :cond_14

    .line 294
    invoke-static/range {p1 .. p1}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v2

    .line 295
    if-eqz v2, :cond_13

    .line 296
    const-string v4, "serial"

    const/4 v5, 0x1

    invoke-interface {v2, v4, v5}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v4

    .line 297
    invoke-interface {v2}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    const-string v5, "serial"

    add-int/lit8 v4, v4, 0x1

    invoke-interface {v2, v5, v4}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    invoke-interface {v2}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 299
    :cond_13
    const/16 v2, 0x71

    invoke-direct {p0, v2, v3}, Lcom/umeng/commonsdk/statistics/c;->a(ILorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object v2

    goto/16 :goto_0

    .line 305
    :cond_14
    const/4 v2, 0x0

    .line 306
    if-eqz v3, :cond_1e

    .line 307
    invoke-virtual {v3}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->getBytes()[B

    move-result-object v2

    move-object/from16 v0, p1

    invoke-direct {p0, v0, v2}, Lcom/umeng/commonsdk/statistics/c;->a(Landroid/content/Context;[B)Lcom/umeng/commonsdk/statistics/idtracking/Envelope;

    move-result-object v2

    .line 308
    if-nez v2, :cond_15

    .line 309
    const/16 v2, 0x6f

    invoke-direct {p0, v2, v3}, Lcom/umeng/commonsdk/statistics/c;->a(ILorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object v2

    goto/16 :goto_0

    :cond_15
    move-object v4, v2

    .line 316
    :goto_a
    if-eqz v4, :cond_16

    invoke-virtual {v4}, Lcom/umeng/commonsdk/statistics/idtracking/Envelope;->toBinary()[B

    move-result-object v2

    array-length v2, v2

    int-to-long v6, v2

    sget-wide v8, Lcom/umeng/commonsdk/statistics/common/DataHelper;->ENVELOPE_LENGTH_MAX:J

    invoke-static {v6, v7, v8, v9}, Lcom/umeng/commonsdk/statistics/common/DataHelper;->largeThanMaxSize(JJ)Z

    move-result v2

    if-eqz v2, :cond_16

    .line 318
    const/16 v2, 0x72

    invoke-direct {p0, v2, v3}, Lcom/umeng/commonsdk/statistics/c;->a(ILorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object v2

    goto/16 :goto_0

    .line 321
    :cond_16
    const/4 v2, 0x0

    .line 322
    if-eqz v3, :cond_17

    .line 323
    const-string v2, "header"

    invoke-virtual {v3, v2}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v2

    const-string v6, "app_version"

    .line 324
    invoke-virtual {v2, v6}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 328
    :cond_17
    move-object/from16 v0, p1

    invoke-direct {p0, v0, v4, v5, v2}, Lcom/umeng/commonsdk/statistics/c;->a(Landroid/content/Context;Lcom/umeng/commonsdk/statistics/idtracking/Envelope;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .line 329
    if-eqz v2, :cond_18

    .line 330
    invoke-direct {p0, v2, v3}, Lcom/umeng/commonsdk/statistics/c;->a(ILorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object v2

    goto/16 :goto_0

    .line 332
    :cond_18
    sget-boolean v2, Lcom/umeng/commonsdk/statistics/common/e;->a:Z

    if-eqz v2, :cond_19

    .line 333
    const-string v2, "EnvelopeManager"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "constructHeader size is "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v3}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/String;->getBytes()[B

    move-result-object v5

    array-length v5, v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v2, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_c
    .catch Ljava/lang/Throwable; {:try_start_c .. :try_end_c} :catch_1

    :cond_19
    move-object v2, v3

    .line 336
    goto/16 :goto_0

    .line 354
    :catch_3
    move-exception v2

    move-object v2, v3

    goto/16 :goto_4

    .line 379
    :catch_4
    move-exception v2

    move-object v14, v2

    move-object v2, v3

    move-object v3, v14

    .line 380
    :goto_b
    move-object/from16 v0, p1

    invoke-static {v0, v3}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    .line 382
    :cond_1a
    :goto_c
    const/16 v3, 0x6e

    invoke-direct {p0, v3, v2}, Lcom/umeng/commonsdk/statistics/c;->a(ILorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object v2

    goto/16 :goto_0

    .line 379
    :catch_5
    move-exception v2

    move-object v14, v2

    move-object v2, v3

    move-object v3, v14

    goto :goto_b

    :catch_6
    move-exception v3

    goto :goto_b

    :catch_7
    move-exception v2

    move-object v14, v2

    move-object v2, v3

    move-object v3, v14

    goto :goto_b

    .line 285
    :catch_8
    move-exception v2

    goto/16 :goto_9

    .line 260
    :catch_9
    move-exception v2

    goto/16 :goto_8

    :cond_1b
    move-object v2, v3

    goto :goto_c

    :cond_1c
    move-object v3, v2

    goto/16 :goto_5

    :cond_1d
    move-object v2, v3

    goto/16 :goto_4

    :cond_1e
    move-object v4, v2

    goto/16 :goto_a

    :cond_1f
    move-object v5, v2

    goto/16 :goto_7

    :cond_20
    move-object v5, v2

    goto/16 :goto_7
.end method
