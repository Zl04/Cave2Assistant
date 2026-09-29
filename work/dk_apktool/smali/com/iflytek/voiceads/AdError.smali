.class public Lcom/iflytek/voiceads/AdError;
.super Ljava/lang/Exception;
.source "AdError.java"


# static fields
.field protected static final TIP_INVALID_AD_UNIT_ID:I = 0x5

.field protected static final TIP_INVALID_APPID:I = 0x9

.field protected static final TIP_INVALID_BROWSER:I = 0xc

.field protected static final TIP_INVALID_REQUEST:I = 0x3

.field protected static final TIP_NETWORK_ERROR:I = 0x1

.field protected static final TIP_NO_FILL:I = 0x4

.field protected static final TIP_OVER_REQUEST_NUM:I = 0x8

.field protected static final TIP_PAGE_LOAD_ERROR:I = 0xb

.field protected static final TIP_PAGE_LOAD_TIMEOUT:I = 0xa

.field protected static final TIP_PERMISSION_ERROR:I = 0x6

.field protected static final TIP_SERVER_ERROR:I = 0x2

.field protected static final TIP_SUCCESS:I = 0x0

.field protected static final TIP_UNKNOWN_ERROR:I = 0x7

.field private static final serialVersionUID:J = 0x1L


# instance fields
.field private mDescription:Ljava/lang/String;

.field private mErrorCode:I


# direct methods
.method public constructor <init>(I)V
    .locals 3
    .param p1, "errorCode"    # I

    .prologue
    .line 71
    invoke-direct {p0}, Ljava/lang/Exception;-><init>()V

    .line 66
    const/4 v1, 0x0

    iput v1, p0, Lcom/iflytek/voiceads/AdError;->mErrorCode:I

    .line 68
    const-string v1, ""

    iput-object v1, p0, Lcom/iflytek/voiceads/AdError;->mDescription:Ljava/lang/String;

    .line 72
    iput p1, p0, Lcom/iflytek/voiceads/AdError;->mErrorCode:I

    .line 73
    const/4 v0, 0x1

    .line 76
    .local v0, "errorType":I
    iget v1, p0, Lcom/iflytek/voiceads/AdError;->mErrorCode:I

    const/16 v2, 0x3e8

    if-ge v1, v2, :cond_0

    .line 77
    iget v1, p0, Lcom/iflytek/voiceads/AdError;->mErrorCode:I

    const v2, 0x11170

    add-int/2addr v1, v2

    iput v1, p0, Lcom/iflytek/voiceads/AdError;->mErrorCode:I

    .line 80
    :cond_0
    iget v1, p0, Lcom/iflytek/voiceads/AdError;->mErrorCode:I

    sparse-switch v1, :sswitch_data_0

    .line 146
    const/4 v0, 0x7

    .line 150
    :goto_0
    invoke-static {v0}, Lcom/iflytek/voiceads/resource/Resource;->getErrorDescription(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/iflytek/voiceads/AdError;->mDescription:Ljava/lang/String;

    .line 151
    return-void

    .line 84
    :sswitch_0
    const/4 v0, 0x0

    .line 85
    goto :goto_0

    .line 90
    :sswitch_1
    const/4 v0, 0x5

    .line 91
    goto :goto_0

    .line 96
    :sswitch_2
    const/16 v0, 0x9

    .line 97
    goto :goto_0

    .line 101
    :sswitch_3
    const/4 v0, 0x4

    .line 102
    goto :goto_0

    .line 106
    :sswitch_4
    const/4 v0, 0x3

    .line 107
    goto :goto_0

    .line 111
    :sswitch_5
    const/16 v0, 0x8

    .line 112
    goto :goto_0

    .line 116
    :sswitch_6
    const/4 v0, 0x2

    .line 117
    goto :goto_0

    .line 121
    :sswitch_7
    const/4 v0, 0x1

    .line 122
    goto :goto_0

    .line 126
    :sswitch_8
    const/4 v0, 0x6

    .line 127
    goto :goto_0

    .line 131
    :sswitch_9
    const/16 v0, 0xa

    .line 132
    goto :goto_0

    .line 136
    :sswitch_a
    const/16 v0, 0xb

    .line 137
    goto :goto_0

    .line 141
    :sswitch_b
    const/16 v0, 0xc

    .line 142
    goto :goto_0

    .line 80
    nop

    :sswitch_data_0
    .sparse-switch
        0x11238 -> :sswitch_0
        0x1123c -> :sswitch_3
        0x11300 -> :sswitch_1
        0x11303 -> :sswitch_5
        0x11364 -> :sswitch_6
        0x1155a -> :sswitch_4
        0x1155b -> :sswitch_7
        0x1155c -> :sswitch_8
        0x1155d -> :sswitch_2
        0x1155e -> :sswitch_2
        0x1155f -> :sswitch_1
        0x11560 -> :sswitch_9
        0x11561 -> :sswitch_a
        0x11562 -> :sswitch_b
    .end sparse-switch
.end method

.method public static convertErrorCode(I)I
    .locals 1
    .param p0, "code"    # I

    .prologue
    .line 176
    const/16 v0, 0x3e8

    if-ge p0, v0, :cond_0

    .line 177
    const v0, 0x11170

    add-int/2addr p0, v0

    .line 179
    :cond_0
    return p0
.end method


# virtual methods
.method public getErrorCode()I
    .locals 1

    .prologue
    .line 158
    iget v0, p0, Lcom/iflytek/voiceads/AdError;->mErrorCode:I

    return v0
.end method

.method public getErrorDescription()Ljava/lang/String;
    .locals 1

    .prologue
    .line 166
    iget-object v0, p0, Lcom/iflytek/voiceads/AdError;->mDescription:Ljava/lang/String;

    return-object v0
.end method
