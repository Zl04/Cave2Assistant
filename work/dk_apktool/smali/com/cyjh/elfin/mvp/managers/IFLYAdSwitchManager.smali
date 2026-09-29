.class public Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;
.super Ljava/lang/Object;
.source "IFLYAdSwitchManager.java"

# interfaces
.implements Lcom/cyjh/elfin/mvp/managers/BaseManager;


# static fields
.field public static final BOTTOM_SCREEN_AD_ONE:I = 0x2

.field public static final BOTTOM_SCREEN_AD_TWO:I = 0x4

.field public static final FULLSCREEN_AD_ONE:I = 0x1

.field public static final FULLSCREEN_AD_TWO:I = 0x3

.field public static final IFLYAD_REQ_ELF:Ljava/lang/String; = "Elf"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 33
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;I)V
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;
    .param p1, "x1"    # I

    .prologue
    .line 33
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;->reqFailSendMsg(I)V

    return-void
.end method

.method private reqFailSendMsg(I)V
    .locals 3
    .param p1, "site"    # I

    .prologue
    .line 106
    const-string v0, "zzz"

    const-string v1, "IFLYAdSwitchManager--reqFailSendMsg---1"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 108
    const/4 v0, 0x2

    if-ne p1, v0, :cond_0

    .line 109
    const-string v0, "zzz"

    const-string v1, "IFLYAdSwitchManager--reqFailSendMsg---2"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 110
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v0

    new-instance v1, Lcom/cyjh/elfin/entity/MsgItem;

    const/16 v2, 0x3f3

    invoke-direct {v1, v2}, Lcom/cyjh/elfin/entity/MsgItem;-><init>(I)V

    invoke-virtual {v0, v1}, Lorg/greenrobot/eventbus/EventBus;->post(Ljava/lang/Object;)V

    .line 119
    :goto_0
    return-void

    .line 111
    :cond_0
    const/4 v0, 0x3

    if-ne p1, v0, :cond_1

    .line 112
    const-string v0, "zzz"

    const-string v1, "IFLYAdSwitchManager--reqFailSendMsg---3"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 114
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v0

    new-instance v1, Lcom/cyjh/elfin/entity/MsgItem;

    const/16 v2, 0x3f5

    invoke-direct {v1, v2}, Lcom/cyjh/elfin/entity/MsgItem;-><init>(I)V

    invoke-virtual {v0, v1}, Lorg/greenrobot/eventbus/EventBus;->post(Ljava/lang/Object;)V

    goto :goto_0

    .line 116
    :cond_1
    const-string v0, "zzz"

    const-string v1, "IFLYAdSwitchManager--reqFailSendMsg---4"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 117
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v0

    new-instance v1, Lcom/cyjh/elfin/entity/MsgItem;

    const/16 v2, 0x3f1

    invoke-direct {v1, v2}, Lcom/cyjh/elfin/entity/MsgItem;-><init>(I)V

    invoke-virtual {v0, v1}, Lorg/greenrobot/eventbus/EventBus;->post(Ljava/lang/Object;)V

    goto :goto_0
.end method


# virtual methods
.method public checkedSwitchAd(Landroid/content/Context;I)V
    .locals 4
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "site"    # I

    .prologue
    .line 53
    const-string v1, "api.51moba.com"

    const-string v2, "GetAdvertisementSwitch"

    invoke-static {v1, v2}, Lcom/cyjh/elfin/constant/MyBuildConfig;->getBuilder(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    const-string v2, "key"

    const-string v3, "Elf"

    .line 54
    invoke-virtual {v1, v2, v3}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    const-string v2, "site"

    .line 55
    invoke-static {p2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    .line 56
    invoke-virtual {v1}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v0

    .line 57
    .local v0, "url":Ljava/lang/String;
    const-string v1, "zzz"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "IFLYAdSwitchManager--checkedSwitchAd--"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 58
    const-class v1, Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;

    invoke-virtual {v1}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager$1;

    invoke-direct {v2, p0, p1, p2}, Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager$1;-><init>(Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;Landroid/content/Context;I)V

    invoke-static {v0, v1, v2}, Lcom/cyjh/elfin/net/volley/VolleyManager;->requestStringGet(Ljava/lang/String;Ljava/lang/String;Lcom/cyjh/elfin/net/volley/VolleyRequestManager;)V

    .line 99
    return-void
.end method
