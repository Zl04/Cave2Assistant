.class public final enum Lcom/kaopu/download/BaseDownloadStateFactory$State;
.super Ljava/lang/Enum;
.source "BaseDownloadStateFactory.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/kaopu/download/BaseDownloadStateFactory;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "State"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/kaopu/download/BaseDownloadStateFactory$State;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum DOWNLOADED:Lcom/kaopu/download/BaseDownloadStateFactory$State;

.field public static final enum DOWNLOADING:Lcom/kaopu/download/BaseDownloadStateFactory$State;

.field public static final enum DOWNLOAD_CANCELING:Lcom/kaopu/download/BaseDownloadStateFactory$State;

.field public static final enum DOWNLOAD_CONNECTING:Lcom/kaopu/download/BaseDownloadStateFactory$State;

.field public static final enum DOWNLOAD_FAILED:Lcom/kaopu/download/BaseDownloadStateFactory$State;

.field public static final enum DOWNLOAD_NEW:Lcom/kaopu/download/BaseDownloadStateFactory$State;

.field public static final enum DOWNLOAD_PAUSED:Lcom/kaopu/download/BaseDownloadStateFactory$State;

.field public static final enum DOWNLOAD_PAUSEING:Lcom/kaopu/download/BaseDownloadStateFactory$State;

.field public static final enum DOWNLOAD_UNKNOWN:Lcom/kaopu/download/BaseDownloadStateFactory$State;

.field public static final enum DOWNLOAD_WAIT:Lcom/kaopu/download/BaseDownloadStateFactory$State;

.field private static final synthetic ENUM$VALUES:[Lcom/kaopu/download/BaseDownloadStateFactory$State;


# instance fields
.field private mIntValue:I


# direct methods
.method static constructor <clinit>()V
    .locals 9

    .prologue
    const/4 v8, 0x5

    const/4 v7, 0x4

    const/4 v6, 0x3

    const/4 v5, 0x2

    const/4 v4, 0x1

    .line 24
    new-instance v0, Lcom/kaopu/download/BaseDownloadStateFactory$State;

    const-string v1, "DOWNLOAD_UNKNOWN"

    const/4 v2, 0x0

    .line 25
    const/4 v3, -0x1

    invoke-direct {v0, v1, v2, v3}, Lcom/kaopu/download/BaseDownloadStateFactory$State;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOAD_UNKNOWN:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    .line 26
    new-instance v0, Lcom/kaopu/download/BaseDownloadStateFactory$State;

    const-string v1, "DOWNLOAD_NEW"

    .line 27
    invoke-direct {v0, v1, v4, v4}, Lcom/kaopu/download/BaseDownloadStateFactory$State;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOAD_NEW:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    .line 28
    new-instance v0, Lcom/kaopu/download/BaseDownloadStateFactory$State;

    const-string v1, "DOWNLOAD_WAIT"

    .line 29
    invoke-direct {v0, v1, v5, v5}, Lcom/kaopu/download/BaseDownloadStateFactory$State;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOAD_WAIT:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    .line 30
    new-instance v0, Lcom/kaopu/download/BaseDownloadStateFactory$State;

    const-string v1, "DOWNLOADING"

    .line 31
    invoke-direct {v0, v1, v6, v6}, Lcom/kaopu/download/BaseDownloadStateFactory$State;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOADING:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    .line 32
    new-instance v0, Lcom/kaopu/download/BaseDownloadStateFactory$State;

    const-string v1, "DOWNLOADED"

    .line 33
    invoke-direct {v0, v1, v7, v7}, Lcom/kaopu/download/BaseDownloadStateFactory$State;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOADED:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    .line 34
    new-instance v0, Lcom/kaopu/download/BaseDownloadStateFactory$State;

    const-string v1, "DOWNLOAD_PAUSED"

    .line 35
    invoke-direct {v0, v1, v8, v8}, Lcom/kaopu/download/BaseDownloadStateFactory$State;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOAD_PAUSED:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    .line 36
    new-instance v0, Lcom/kaopu/download/BaseDownloadStateFactory$State;

    const-string v1, "DOWNLOAD_FAILED"

    const/4 v2, 0x6

    .line 37
    const/4 v3, 0x6

    invoke-direct {v0, v1, v2, v3}, Lcom/kaopu/download/BaseDownloadStateFactory$State;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOAD_FAILED:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    .line 38
    new-instance v0, Lcom/kaopu/download/BaseDownloadStateFactory$State;

    const-string v1, "DOWNLOAD_CANCELING"

    const/4 v2, 0x7

    .line 39
    const/4 v3, 0x7

    invoke-direct {v0, v1, v2, v3}, Lcom/kaopu/download/BaseDownloadStateFactory$State;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOAD_CANCELING:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    .line 40
    new-instance v0, Lcom/kaopu/download/BaseDownloadStateFactory$State;

    const-string v1, "DOWNLOAD_PAUSEING"

    const/16 v2, 0x8

    .line 41
    const/16 v3, 0x8

    invoke-direct {v0, v1, v2, v3}, Lcom/kaopu/download/BaseDownloadStateFactory$State;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOAD_PAUSEING:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    .line 42
    new-instance v0, Lcom/kaopu/download/BaseDownloadStateFactory$State;

    const-string v1, "DOWNLOAD_CONNECTING"

    const/16 v2, 0x9

    .line 43
    const/16 v3, 0x9

    invoke-direct {v0, v1, v2, v3}, Lcom/kaopu/download/BaseDownloadStateFactory$State;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOAD_CONNECTING:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    .line 23
    const/16 v0, 0xa

    new-array v0, v0, [Lcom/kaopu/download/BaseDownloadStateFactory$State;

    const/4 v1, 0x0

    sget-object v2, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOAD_UNKNOWN:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    aput-object v2, v0, v1

    sget-object v1, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOAD_NEW:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    aput-object v1, v0, v4

    sget-object v1, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOAD_WAIT:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    aput-object v1, v0, v5

    sget-object v1, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOADING:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    aput-object v1, v0, v6

    sget-object v1, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOADED:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    aput-object v1, v0, v7

    sget-object v1, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOAD_PAUSED:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    aput-object v1, v0, v8

    const/4 v1, 0x6

    sget-object v2, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOAD_FAILED:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    aput-object v2, v0, v1

    const/4 v1, 0x7

    sget-object v2, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOAD_CANCELING:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    aput-object v2, v0, v1

    const/16 v1, 0x8

    sget-object v2, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOAD_PAUSEING:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    aput-object v2, v0, v1

    const/16 v1, 0x9

    sget-object v2, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOAD_CONNECTING:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    aput-object v2, v0, v1

    sput-object v0, Lcom/kaopu/download/BaseDownloadStateFactory$State;->ENUM$VALUES:[Lcom/kaopu/download/BaseDownloadStateFactory$State;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;II)V
    .locals 0
    .param p3, "intValue"    # I

    .prologue
    .line 65
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 66
    iput p3, p0, Lcom/kaopu/download/BaseDownloadStateFactory$State;->mIntValue:I

    .line 67
    return-void
.end method

.method public static mapIntToValue(I)Lcom/kaopu/download/BaseDownloadStateFactory$State;
    .locals 5
    .param p0, "stateInt"    # I

    .prologue
    .line 53
    invoke-static {}, Lcom/kaopu/download/BaseDownloadStateFactory$State;->values()[Lcom/kaopu/download/BaseDownloadStateFactory$State;

    move-result-object v2

    array-length v3, v2

    const/4 v1, 0x0

    :goto_0
    if-lt v1, v3, :cond_1

    .line 60
    sget-object v0, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOAD_UNKNOWN:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    :cond_0
    return-object v0

    .line 53
    :cond_1
    aget-object v0, v2, v1

    .line 54
    .local v0, "value":Lcom/kaopu/download/BaseDownloadStateFactory$State;
    invoke-virtual {v0}, Lcom/kaopu/download/BaseDownloadStateFactory$State;->getIntValue()I

    move-result v4

    if-eq p0, v4, :cond_0

    .line 53
    add-int/lit8 v1, v1, 0x1

    goto :goto_0
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/kaopu/download/BaseDownloadStateFactory$State;
    .locals 1

    .prologue
    .line 1
    const-class v0, Lcom/kaopu/download/BaseDownloadStateFactory$State;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/kaopu/download/BaseDownloadStateFactory$State;

    return-object v0
.end method

.method public static values()[Lcom/kaopu/download/BaseDownloadStateFactory$State;
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 1
    sget-object v0, Lcom/kaopu/download/BaseDownloadStateFactory$State;->ENUM$VALUES:[Lcom/kaopu/download/BaseDownloadStateFactory$State;

    array-length v1, v0

    new-array v2, v1, [Lcom/kaopu/download/BaseDownloadStateFactory$State;

    invoke-static {v0, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-object v2
.end method


# virtual methods
.method public getIntValue()I
    .locals 1

    .prologue
    .line 70
    iget v0, p0, Lcom/kaopu/download/BaseDownloadStateFactory$State;->mIntValue:I

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    .prologue
    .line 75
    iget v0, p0, Lcom/kaopu/download/BaseDownloadStateFactory$State;->mIntValue:I

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
