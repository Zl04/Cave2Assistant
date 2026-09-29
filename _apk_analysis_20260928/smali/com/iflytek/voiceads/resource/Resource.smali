.class public Lcom/iflytek/voiceads/resource/Resource;
.super Ljava/lang/Object;
.source "Resource.java"


# static fields
.field private static LANGUAGE:Ljava/util/Locale; = null

.field public static final TAG_ERROR_CODE:I = 0x0

.field public static final TAG_ERROR_UNKNOWN:I = 0x1


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 16
    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    sput-object v0, Lcom/iflytek/voiceads/resource/Resource;->LANGUAGE:Ljava/util/Locale;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 21
    return-void
.end method

.method public static getErrorDescription(I)Ljava/lang/String;
    .locals 3
    .param p0, "errorType"    # I

    .prologue
    .line 25
    sget-object v0, Lcom/iflytek/voiceads/resource/ResourceCN;->errors:[Ljava/lang/String;

    .line 26
    .local v0, "errors":[Ljava/lang/String;
    sget-object v1, Lcom/iflytek/voiceads/resource/Resource;->LANGUAGE:Ljava/util/Locale;

    sget-object v2, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v1, v2}, Ljava/util/Locale;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 27
    sget-object v0, Lcom/iflytek/voiceads/resource/ResourceEN;->errors:[Ljava/lang/String;

    .line 28
    :cond_0
    if-lez p0, :cond_1

    array-length v1, v0

    if-ge p0, v1, :cond_1

    .line 29
    aget-object v1, v0, p0

    .line 30
    :goto_0
    return-object v1

    :cond_1
    const/4 v1, 0x1

    invoke-static {v1}, Lcom/iflytek/voiceads/resource/Resource;->getErrorTag(I)Ljava/lang/String;

    move-result-object v1

    goto :goto_0
.end method

.method public static getErrorTag(I)Ljava/lang/String;
    .locals 3
    .param p0, "errtag"    # I

    .prologue
    .line 38
    sget-object v0, Lcom/iflytek/voiceads/resource/ResourceCN;->error_tag:[Ljava/lang/String;

    .line 39
    .local v0, "errors":[Ljava/lang/String;
    sget-object v1, Lcom/iflytek/voiceads/resource/Resource;->LANGUAGE:Ljava/util/Locale;

    sget-object v2, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v1, v2}, Ljava/util/Locale;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 40
    sget-object v0, Lcom/iflytek/voiceads/resource/ResourceEN;->error_tag:[Ljava/lang/String;

    .line 41
    :cond_0
    if-ltz p0, :cond_1

    array-length v1, v0

    if-ge p0, v1, :cond_1

    .line 42
    aget-object v1, v0, p0

    .line 43
    :goto_0
    return-object v1

    :cond_1
    const-string v1, ""

    goto :goto_0
.end method
