.class public Lcom/kaopu/download/BaseDownloadStateFactory;
.super Ljava/lang/Object;
.source "BaseDownloadStateFactory.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/kaopu/download/BaseDownloadStateFactory$State;
    }
.end annotation


# static fields
.field private static synthetic $SWITCH_TABLE$com$kaopu$download$BaseDownloadStateFactory$State:[I

.field private static downloadCancelingState:Lcom/kaopu/download/state/DownloadCancelingState;

.field private static downloadConnectingState:Lcom/kaopu/download/state/DownloadConnectingState;

.field private static downloadFailedState:Lcom/kaopu/download/state/DownloadFailedState;

.field private static downloadNewState:Lcom/kaopu/download/state/DownloadNewState;

.field private static downloadPausedState:Lcom/kaopu/download/state/DownloadPausedState;

.field private static downloadPausingState:Lcom/kaopu/download/state/DownloadPausingState;

.field private static downloadUnKnownState:Lcom/kaopu/download/state/DownloadUnKnownState;

.field private static downloadWaitState:Lcom/kaopu/download/state/DownloadWaitState;

.field private static downloadedState:Lcom/kaopu/download/state/DownloadedState;

.field private static downloadingState:Lcom/kaopu/download/state/DownloadingState;


# direct methods
.method static synthetic $SWITCH_TABLE$com$kaopu$download$BaseDownloadStateFactory$State()[I
    .locals 3

    .prologue
    .line 21
    sget-object v0, Lcom/kaopu/download/BaseDownloadStateFactory;->$SWITCH_TABLE$com$kaopu$download$BaseDownloadStateFactory$State:[I

    if-eqz v0, :cond_0

    :goto_0
    return-object v0

    :cond_0
    invoke-static {}, Lcom/kaopu/download/BaseDownloadStateFactory$State;->values()[Lcom/kaopu/download/BaseDownloadStateFactory$State;

    move-result-object v0

    array-length v0, v0

    new-array v0, v0, [I

    :try_start_0
    sget-object v1, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOADED:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    invoke-virtual {v1}, Lcom/kaopu/download/BaseDownloadStateFactory$State;->ordinal()I

    move-result v1

    const/4 v2, 0x5

    aput v2, v0, v1
    :try_end_0
    .catch Ljava/lang/NoSuchFieldError; {:try_start_0 .. :try_end_0} :catch_9

    :goto_1
    :try_start_1
    sget-object v1, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOADING:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    invoke-virtual {v1}, Lcom/kaopu/download/BaseDownloadStateFactory$State;->ordinal()I

    move-result v1

    const/4 v2, 0x4

    aput v2, v0, v1
    :try_end_1
    .catch Ljava/lang/NoSuchFieldError; {:try_start_1 .. :try_end_1} :catch_8

    :goto_2
    :try_start_2
    sget-object v1, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOAD_CANCELING:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    invoke-virtual {v1}, Lcom/kaopu/download/BaseDownloadStateFactory$State;->ordinal()I

    move-result v1

    const/16 v2, 0x8

    aput v2, v0, v1
    :try_end_2
    .catch Ljava/lang/NoSuchFieldError; {:try_start_2 .. :try_end_2} :catch_7

    :goto_3
    :try_start_3
    sget-object v1, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOAD_CONNECTING:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    invoke-virtual {v1}, Lcom/kaopu/download/BaseDownloadStateFactory$State;->ordinal()I

    move-result v1

    const/16 v2, 0xa

    aput v2, v0, v1
    :try_end_3
    .catch Ljava/lang/NoSuchFieldError; {:try_start_3 .. :try_end_3} :catch_6

    :goto_4
    :try_start_4
    sget-object v1, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOAD_FAILED:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    invoke-virtual {v1}, Lcom/kaopu/download/BaseDownloadStateFactory$State;->ordinal()I

    move-result v1

    const/4 v2, 0x7

    aput v2, v0, v1
    :try_end_4
    .catch Ljava/lang/NoSuchFieldError; {:try_start_4 .. :try_end_4} :catch_5

    :goto_5
    :try_start_5
    sget-object v1, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOAD_NEW:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    invoke-virtual {v1}, Lcom/kaopu/download/BaseDownloadStateFactory$State;->ordinal()I

    move-result v1

    const/4 v2, 0x2

    aput v2, v0, v1
    :try_end_5
    .catch Ljava/lang/NoSuchFieldError; {:try_start_5 .. :try_end_5} :catch_4

    :goto_6
    :try_start_6
    sget-object v1, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOAD_PAUSED:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    invoke-virtual {v1}, Lcom/kaopu/download/BaseDownloadStateFactory$State;->ordinal()I

    move-result v1

    const/4 v2, 0x6

    aput v2, v0, v1
    :try_end_6
    .catch Ljava/lang/NoSuchFieldError; {:try_start_6 .. :try_end_6} :catch_3

    :goto_7
    :try_start_7
    sget-object v1, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOAD_PAUSEING:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    invoke-virtual {v1}, Lcom/kaopu/download/BaseDownloadStateFactory$State;->ordinal()I

    move-result v1

    const/16 v2, 0x9

    aput v2, v0, v1
    :try_end_7
    .catch Ljava/lang/NoSuchFieldError; {:try_start_7 .. :try_end_7} :catch_2

    :goto_8
    :try_start_8
    sget-object v1, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOAD_UNKNOWN:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    invoke-virtual {v1}, Lcom/kaopu/download/BaseDownloadStateFactory$State;->ordinal()I

    move-result v1

    const/4 v2, 0x1

    aput v2, v0, v1
    :try_end_8
    .catch Ljava/lang/NoSuchFieldError; {:try_start_8 .. :try_end_8} :catch_1

    :goto_9
    :try_start_9
    sget-object v1, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOAD_WAIT:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    invoke-virtual {v1}, Lcom/kaopu/download/BaseDownloadStateFactory$State;->ordinal()I

    move-result v1

    const/4 v2, 0x3

    aput v2, v0, v1
    :try_end_9
    .catch Ljava/lang/NoSuchFieldError; {:try_start_9 .. :try_end_9} :catch_0

    :goto_a
    sput-object v0, Lcom/kaopu/download/BaseDownloadStateFactory;->$SWITCH_TABLE$com$kaopu$download$BaseDownloadStateFactory$State:[I

    goto :goto_0

    :catch_0
    move-exception v1

    goto :goto_a

    :catch_1
    move-exception v1

    goto :goto_9

    :catch_2
    move-exception v1

    goto :goto_8

    :catch_3
    move-exception v1

    goto :goto_7

    :catch_4
    move-exception v1

    goto :goto_6

    :catch_5
    move-exception v1

    goto :goto_5

    :catch_6
    move-exception v1

    goto :goto_4

    :catch_7
    move-exception v1

    goto :goto_3

    :catch_8
    move-exception v1

    goto :goto_2

    :catch_9
    move-exception v1

    goto :goto_1
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 21
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getDownloadCancelingState()Lcom/kaopu/download/state/DownloadCancelingState;
    .locals 1

    .prologue
    .line 204
    sget-object v0, Lcom/kaopu/download/BaseDownloadStateFactory;->downloadCancelingState:Lcom/kaopu/download/state/DownloadCancelingState;

    if-nez v0, :cond_0

    .line 205
    new-instance v0, Lcom/kaopu/download/state/DownloadCancelingState;

    invoke-direct {v0}, Lcom/kaopu/download/state/DownloadCancelingState;-><init>()V

    sput-object v0, Lcom/kaopu/download/BaseDownloadStateFactory;->downloadCancelingState:Lcom/kaopu/download/state/DownloadCancelingState;

    .line 206
    :cond_0
    sget-object v0, Lcom/kaopu/download/BaseDownloadStateFactory;->downloadCancelingState:Lcom/kaopu/download/state/DownloadCancelingState;

    return-object v0
.end method

.method public static getDownloadConnectingState()Lcom/kaopu/download/state/DownloadConnectingState;
    .locals 1

    .prologue
    .line 215
    sget-object v0, Lcom/kaopu/download/BaseDownloadStateFactory;->downloadConnectingState:Lcom/kaopu/download/state/DownloadConnectingState;

    if-nez v0, :cond_0

    .line 216
    new-instance v0, Lcom/kaopu/download/state/DownloadConnectingState;

    invoke-direct {v0}, Lcom/kaopu/download/state/DownloadConnectingState;-><init>()V

    sput-object v0, Lcom/kaopu/download/BaseDownloadStateFactory;->downloadConnectingState:Lcom/kaopu/download/state/DownloadConnectingState;

    .line 217
    :cond_0
    sget-object v0, Lcom/kaopu/download/BaseDownloadStateFactory;->downloadConnectingState:Lcom/kaopu/download/state/DownloadConnectingState;

    return-object v0
.end method

.method public static getDownloadFailedState()Lcom/kaopu/download/state/DownloadFailedState;
    .locals 1

    .prologue
    .line 237
    sget-object v0, Lcom/kaopu/download/BaseDownloadStateFactory;->downloadFailedState:Lcom/kaopu/download/state/DownloadFailedState;

    if-nez v0, :cond_0

    .line 238
    new-instance v0, Lcom/kaopu/download/state/DownloadFailedState;

    invoke-direct {v0}, Lcom/kaopu/download/state/DownloadFailedState;-><init>()V

    sput-object v0, Lcom/kaopu/download/BaseDownloadStateFactory;->downloadFailedState:Lcom/kaopu/download/state/DownloadFailedState;

    .line 239
    :cond_0
    sget-object v0, Lcom/kaopu/download/BaseDownloadStateFactory;->downloadFailedState:Lcom/kaopu/download/state/DownloadFailedState;

    return-object v0
.end method

.method public static getDownloadNewState()Lcom/kaopu/download/state/DownloadNewState;
    .locals 1

    .prologue
    .line 149
    sget-object v0, Lcom/kaopu/download/BaseDownloadStateFactory;->downloadNewState:Lcom/kaopu/download/state/DownloadNewState;

    if-nez v0, :cond_0

    .line 150
    new-instance v0, Lcom/kaopu/download/state/DownloadNewState;

    invoke-direct {v0}, Lcom/kaopu/download/state/DownloadNewState;-><init>()V

    sput-object v0, Lcom/kaopu/download/BaseDownloadStateFactory;->downloadNewState:Lcom/kaopu/download/state/DownloadNewState;

    .line 151
    :cond_0
    sget-object v0, Lcom/kaopu/download/BaseDownloadStateFactory;->downloadNewState:Lcom/kaopu/download/state/DownloadNewState;

    return-object v0
.end method

.method public static getDownloadPausedState()Lcom/kaopu/download/state/DownloadPausedState;
    .locals 1

    .prologue
    .line 160
    sget-object v0, Lcom/kaopu/download/BaseDownloadStateFactory;->downloadPausedState:Lcom/kaopu/download/state/DownloadPausedState;

    if-nez v0, :cond_0

    .line 161
    new-instance v0, Lcom/kaopu/download/state/DownloadPausedState;

    invoke-direct {v0}, Lcom/kaopu/download/state/DownloadPausedState;-><init>()V

    sput-object v0, Lcom/kaopu/download/BaseDownloadStateFactory;->downloadPausedState:Lcom/kaopu/download/state/DownloadPausedState;

    .line 162
    :cond_0
    sget-object v0, Lcom/kaopu/download/BaseDownloadStateFactory;->downloadPausedState:Lcom/kaopu/download/state/DownloadPausedState;

    return-object v0
.end method

.method public static getDownloadPausingState()Lcom/kaopu/download/state/DownloadPausingState;
    .locals 1

    .prologue
    .line 171
    sget-object v0, Lcom/kaopu/download/BaseDownloadStateFactory;->downloadPausingState:Lcom/kaopu/download/state/DownloadPausingState;

    if-nez v0, :cond_0

    .line 172
    new-instance v0, Lcom/kaopu/download/state/DownloadPausingState;

    invoke-direct {v0}, Lcom/kaopu/download/state/DownloadPausingState;-><init>()V

    sput-object v0, Lcom/kaopu/download/BaseDownloadStateFactory;->downloadPausingState:Lcom/kaopu/download/state/DownloadPausingState;

    .line 173
    :cond_0
    sget-object v0, Lcom/kaopu/download/BaseDownloadStateFactory;->downloadPausingState:Lcom/kaopu/download/state/DownloadPausingState;

    return-object v0
.end method

.method public static getDownloadState(Lcom/kaopu/download/BaseDownloadStateFactory$State;)Lcom/kaopu/download/intf/IDownloadState;
    .locals 2
    .param p0, "state"    # Lcom/kaopu/download/BaseDownloadStateFactory$State;

    .prologue
    .line 106
    invoke-static {}, Lcom/kaopu/download/BaseDownloadStateFactory;->$SWITCH_TABLE$com$kaopu$download$BaseDownloadStateFactory$State()[I

    move-result-object v0

    invoke-virtual {p0}, Lcom/kaopu/download/BaseDownloadStateFactory$State;->ordinal()I

    move-result v1

    aget v0, v0, v1

    packed-switch v0, :pswitch_data_0

    .line 128
    invoke-static {}, Lcom/kaopu/download/BaseDownloadStateFactory;->getDownloadNewState()Lcom/kaopu/download/state/DownloadNewState;

    move-result-object v0

    :goto_0
    return-object v0

    .line 108
    :pswitch_0
    invoke-static {}, Lcom/kaopu/download/BaseDownloadStateFactory;->getDownloadedState()Lcom/kaopu/download/state/DownloadedState;

    move-result-object v0

    goto :goto_0

    .line 110
    :pswitch_1
    invoke-static {}, Lcom/kaopu/download/BaseDownloadStateFactory;->getDownloadingState()Lcom/kaopu/download/state/DownloadingState;

    move-result-object v0

    goto :goto_0

    .line 112
    :pswitch_2
    invoke-static {}, Lcom/kaopu/download/BaseDownloadStateFactory;->getDownloadCancelingState()Lcom/kaopu/download/state/DownloadCancelingState;

    move-result-object v0

    goto :goto_0

    .line 114
    :pswitch_3
    invoke-static {}, Lcom/kaopu/download/BaseDownloadStateFactory;->getDownloadConnectingState()Lcom/kaopu/download/state/DownloadConnectingState;

    move-result-object v0

    goto :goto_0

    .line 116
    :pswitch_4
    invoke-static {}, Lcom/kaopu/download/BaseDownloadStateFactory;->getDownloadFailedState()Lcom/kaopu/download/state/DownloadFailedState;

    move-result-object v0

    goto :goto_0

    .line 118
    :pswitch_5
    invoke-static {}, Lcom/kaopu/download/BaseDownloadStateFactory;->getDownloadNewState()Lcom/kaopu/download/state/DownloadNewState;

    move-result-object v0

    goto :goto_0

    .line 120
    :pswitch_6
    invoke-static {}, Lcom/kaopu/download/BaseDownloadStateFactory;->getDownloadUnKnownState()Lcom/kaopu/download/state/DownloadUnKnownState;

    move-result-object v0

    goto :goto_0

    .line 122
    :pswitch_7
    invoke-static {}, Lcom/kaopu/download/BaseDownloadStateFactory;->getDownloadPausedState()Lcom/kaopu/download/state/DownloadPausedState;

    move-result-object v0

    goto :goto_0

    .line 124
    :pswitch_8
    invoke-static {}, Lcom/kaopu/download/BaseDownloadStateFactory;->getDownloadPausingState()Lcom/kaopu/download/state/DownloadPausingState;

    move-result-object v0

    goto :goto_0

    .line 126
    :pswitch_9
    invoke-static {}, Lcom/kaopu/download/BaseDownloadStateFactory;->getDownloadWaitState()Lcom/kaopu/download/state/DownloadWaitState;

    move-result-object v0

    goto :goto_0

    .line 106
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_6
        :pswitch_5
        :pswitch_9
        :pswitch_1
        :pswitch_0
        :pswitch_7
        :pswitch_4
        :pswitch_2
        :pswitch_8
        :pswitch_3
    .end packed-switch
.end method

.method public static getDownloadUnKnownState()Lcom/kaopu/download/state/DownloadUnKnownState;
    .locals 1

    .prologue
    .line 182
    sget-object v0, Lcom/kaopu/download/BaseDownloadStateFactory;->downloadUnKnownState:Lcom/kaopu/download/state/DownloadUnKnownState;

    if-nez v0, :cond_0

    .line 183
    new-instance v0, Lcom/kaopu/download/state/DownloadUnKnownState;

    invoke-direct {v0}, Lcom/kaopu/download/state/DownloadUnKnownState;-><init>()V

    sput-object v0, Lcom/kaopu/download/BaseDownloadStateFactory;->downloadUnKnownState:Lcom/kaopu/download/state/DownloadUnKnownState;

    .line 184
    :cond_0
    sget-object v0, Lcom/kaopu/download/BaseDownloadStateFactory;->downloadUnKnownState:Lcom/kaopu/download/state/DownloadUnKnownState;

    return-object v0
.end method

.method public static getDownloadWaitState()Lcom/kaopu/download/state/DownloadWaitState;
    .locals 1

    .prologue
    .line 193
    sget-object v0, Lcom/kaopu/download/BaseDownloadStateFactory;->downloadWaitState:Lcom/kaopu/download/state/DownloadWaitState;

    if-nez v0, :cond_0

    .line 194
    new-instance v0, Lcom/kaopu/download/state/DownloadWaitState;

    invoke-direct {v0}, Lcom/kaopu/download/state/DownloadWaitState;-><init>()V

    sput-object v0, Lcom/kaopu/download/BaseDownloadStateFactory;->downloadWaitState:Lcom/kaopu/download/state/DownloadWaitState;

    .line 195
    :cond_0
    sget-object v0, Lcom/kaopu/download/BaseDownloadStateFactory;->downloadWaitState:Lcom/kaopu/download/state/DownloadWaitState;

    return-object v0
.end method

.method public static getDownloadedState()Lcom/kaopu/download/state/DownloadedState;
    .locals 1

    .prologue
    .line 226
    sget-object v0, Lcom/kaopu/download/BaseDownloadStateFactory;->downloadedState:Lcom/kaopu/download/state/DownloadedState;

    if-nez v0, :cond_0

    .line 227
    new-instance v0, Lcom/kaopu/download/state/DownloadedState;

    invoke-direct {v0}, Lcom/kaopu/download/state/DownloadedState;-><init>()V

    sput-object v0, Lcom/kaopu/download/BaseDownloadStateFactory;->downloadedState:Lcom/kaopu/download/state/DownloadedState;

    .line 228
    :cond_0
    sget-object v0, Lcom/kaopu/download/BaseDownloadStateFactory;->downloadedState:Lcom/kaopu/download/state/DownloadedState;

    return-object v0
.end method

.method public static getDownloadingState()Lcom/kaopu/download/state/DownloadingState;
    .locals 1

    .prologue
    .line 138
    sget-object v0, Lcom/kaopu/download/BaseDownloadStateFactory;->downloadingState:Lcom/kaopu/download/state/DownloadingState;

    if-nez v0, :cond_0

    .line 139
    new-instance v0, Lcom/kaopu/download/state/DownloadingState;

    invoke-direct {v0}, Lcom/kaopu/download/state/DownloadingState;-><init>()V

    sput-object v0, Lcom/kaopu/download/BaseDownloadStateFactory;->downloadingState:Lcom/kaopu/download/state/DownloadingState;

    .line 140
    :cond_0
    sget-object v0, Lcom/kaopu/download/BaseDownloadStateFactory;->downloadingState:Lcom/kaopu/download/state/DownloadingState;

    return-object v0
.end method
