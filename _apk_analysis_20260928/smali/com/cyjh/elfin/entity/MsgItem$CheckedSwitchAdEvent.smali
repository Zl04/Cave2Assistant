.class public Lcom/cyjh/elfin/entity/MsgItem$CheckedSwitchAdEvent;
.super Ljava/lang/Object;
.source "MsgItem.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/entity/MsgItem;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "CheckedSwitchAdEvent"
.end annotation


# instance fields
.field public isShow:Z

.field public status:Ljava/lang/String;

.field public type:I


# direct methods
.method public constructor <init>(Ljava/lang/String;Z)V
    .locals 0
    .param p1, "status"    # Ljava/lang/String;
    .param p2, "isShow"    # Z

    .prologue
    .line 68
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 69
    iput-object p1, p0, Lcom/cyjh/elfin/entity/MsgItem$CheckedSwitchAdEvent;->status:Ljava/lang/String;

    .line 70
    iput-boolean p2, p0, Lcom/cyjh/elfin/entity/MsgItem$CheckedSwitchAdEvent;->isShow:Z

    .line 71
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;ZI)V
    .locals 0
    .param p1, "status"    # Ljava/lang/String;
    .param p2, "isShow"    # Z
    .param p3, "type"    # I

    .prologue
    .line 73
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 74
    iput-object p1, p0, Lcom/cyjh/elfin/entity/MsgItem$CheckedSwitchAdEvent;->status:Ljava/lang/String;

    .line 75
    iput-boolean p2, p0, Lcom/cyjh/elfin/entity/MsgItem$CheckedSwitchAdEvent;->isShow:Z

    .line 76
    iput p3, p0, Lcom/cyjh/elfin/entity/MsgItem$CheckedSwitchAdEvent;->type:I

    .line 77
    return-void
.end method
