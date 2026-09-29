.class public Lcom/iflytek/voiceads/IFLYAdSize;
.super Ljava/lang/Object;
.source "IFLYAdSize.java"


# static fields
.field public static final BANNER:Lcom/iflytek/voiceads/IFLYAdSize;

.field public static final FULLSCREEN:Lcom/iflytek/voiceads/IFLYAdSize;

.field public static final INTERSTITIAL:Lcom/iflytek/voiceads/IFLYAdSize;

.field public static final NATIVE:Lcom/iflytek/voiceads/IFLYAdSize;

.field public static final SPLASH:Lcom/iflytek/voiceads/IFLYAdSize;


# instance fields
.field private height:I

.field private width:I


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 6
    new-instance v0, Lcom/iflytek/voiceads/IFLYAdSize;

    const/16 v1, 0x280

    const/16 v2, 0x64

    invoke-direct {v0, v1, v2}, Lcom/iflytek/voiceads/IFLYAdSize;-><init>(II)V

    sput-object v0, Lcom/iflytek/voiceads/IFLYAdSize;->BANNER:Lcom/iflytek/voiceads/IFLYAdSize;

    .line 7
    new-instance v0, Lcom/iflytek/voiceads/IFLYAdSize;

    const/16 v1, 0x258

    const/16 v2, 0x1f4

    invoke-direct {v0, v1, v2}, Lcom/iflytek/voiceads/IFLYAdSize;-><init>(II)V

    sput-object v0, Lcom/iflytek/voiceads/IFLYAdSize;->INTERSTITIAL:Lcom/iflytek/voiceads/IFLYAdSize;

    .line 8
    new-instance v0, Lcom/iflytek/voiceads/IFLYAdSize;

    const/16 v1, 0x1e0

    const/16 v2, 0x320

    invoke-direct {v0, v1, v2}, Lcom/iflytek/voiceads/IFLYAdSize;-><init>(II)V

    sput-object v0, Lcom/iflytek/voiceads/IFLYAdSize;->FULLSCREEN:Lcom/iflytek/voiceads/IFLYAdSize;

    .line 9
    new-instance v0, Lcom/iflytek/voiceads/IFLYAdSize;

    invoke-direct {v0, v3, v3}, Lcom/iflytek/voiceads/IFLYAdSize;-><init>(II)V

    sput-object v0, Lcom/iflytek/voiceads/IFLYAdSize;->SPLASH:Lcom/iflytek/voiceads/IFLYAdSize;

    .line 10
    new-instance v0, Lcom/iflytek/voiceads/IFLYAdSize;

    invoke-direct {v0, v3, v3}, Lcom/iflytek/voiceads/IFLYAdSize;-><init>(II)V

    sput-object v0, Lcom/iflytek/voiceads/IFLYAdSize;->NATIVE:Lcom/iflytek/voiceads/IFLYAdSize;

    return-void
.end method

.method public constructor <init>(II)V
    .locals 0
    .param p1, "width"    # I
    .param p2, "height"    # I

    .prologue
    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 16
    iput p1, p0, Lcom/iflytek/voiceads/IFLYAdSize;->width:I

    .line 17
    iput p2, p0, Lcom/iflytek/voiceads/IFLYAdSize;->height:I

    .line 18
    return-void
.end method


# virtual methods
.method public getHeight()I
    .locals 1

    .prologue
    .line 29
    iget v0, p0, Lcom/iflytek/voiceads/IFLYAdSize;->height:I

    return v0
.end method

.method public getWidth()I
    .locals 1

    .prologue
    .line 21
    iget v0, p0, Lcom/iflytek/voiceads/IFLYAdSize;->width:I

    return v0
.end method

.method public isSizeValid(Lcom/iflytek/voiceads/IFLYAdSize;)Z
    .locals 3
    .param p1, "size"    # Lcom/iflytek/voiceads/IFLYAdSize;

    .prologue
    .line 41
    const/4 v0, 0x0

    .line 42
    .local v0, "equality":Z
    iget v1, p1, Lcom/iflytek/voiceads/IFLYAdSize;->width:I

    iget v2, p0, Lcom/iflytek/voiceads/IFLYAdSize;->width:I

    if-ne v1, v2, :cond_0

    iget v1, p1, Lcom/iflytek/voiceads/IFLYAdSize;->height:I

    iget v2, p0, Lcom/iflytek/voiceads/IFLYAdSize;->height:I

    if-ne v1, v2, :cond_0

    .line 43
    const/4 v0, 0x1

    .line 45
    :cond_0
    return v0
.end method

.method public setHeight(I)V
    .locals 0
    .param p1, "height"    # I

    .prologue
    .line 33
    iput p1, p0, Lcom/iflytek/voiceads/IFLYAdSize;->height:I

    .line 34
    return-void
.end method

.method public setWidth(I)V
    .locals 0
    .param p1, "width"    # I

    .prologue
    .line 25
    iput p1, p0, Lcom/iflytek/voiceads/IFLYAdSize;->width:I

    .line 26
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    .prologue
    .line 37
    const-string v0, ""

    return-object v0
.end method
