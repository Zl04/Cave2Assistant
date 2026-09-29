.class public Lcom/cyjh/elfin/entity/MsgItem;
.super Ljava/lang/Object;
.source "MsgItem.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/entity/MsgItem$ExposureAndClickEvent;,
        Lcom/cyjh/elfin/entity/MsgItem$ExternalIpEvent;,
        Lcom/cyjh/elfin/entity/MsgItem$PrincessAdEvent;,
        Lcom/cyjh/elfin/entity/MsgItem$CheckedSwitchAdEvent;,
        Lcom/cyjh/elfin/entity/MsgItem$GetServerTime;,
        Lcom/cyjh/elfin/entity/MsgItem$RootDataEvent;
    }
.end annotation


# static fields
.field public static final BACK_AD_REQ_FAIL:I = 0x3ee

.field public static final CLEAR_PUSH_ALL_MSG_ITEM:I = 0x3eb

.field public static final CLEAR_PUSH_INTERFACE_ITEM:I = 0x3ea

.field public static final GAMES_APK_DOWNLOAD_SUC:I = 0x3f2

.field public static final IFLYAD_FULLSCREEN_REQ_FAIL:I = 0x3f1

.field public static final IFLYAD_FULLSCREEN_TWO_REQ_FAIL:I = 0x3f5

.field public static final IFLYAD_PARTSCREEN_REQ_FAIL:I = 0x3f3

.field public static final RED_DOT_GONE_ITEM:I = 0x3e9

.field public static final REFRESH_ITEM:I = 0x3ec

.field public static final REPLACE_XUNFEI_REQ_FAIL:I = 0x3f4

.field public static final REQUEST_NETWORK_FAIL:I = 0x3ed

.field public static final REQ_SERVER_TIME_FAIL:I = 0x3ef

.field public static final SCRIPT_UI_DIALOG_DISMISS:I = 0x3f0


# instance fields
.field private msgType:I


# direct methods
.method public constructor <init>(I)V
    .locals 0
    .param p1, "msgType"    # I

    .prologue
    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 23
    iput p1, p0, Lcom/cyjh/elfin/entity/MsgItem;->msgType:I

    .line 24
    return-void
.end method


# virtual methods
.method public getMsgType()I
    .locals 1

    .prologue
    .line 27
    iget v0, p0, Lcom/cyjh/elfin/entity/MsgItem;->msgType:I

    return v0
.end method

.method public setMsgType(I)V
    .locals 0
    .param p1, "msgType"    # I

    .prologue
    .line 31
    iput p1, p0, Lcom/cyjh/elfin/entity/MsgItem;->msgType:I

    .line 32
    return-void
.end method
