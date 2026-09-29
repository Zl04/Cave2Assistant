.class public Lcom/cyjh/elfin/entity/MsgItem$ExternalIpEvent;
.super Ljava/lang/Object;
.source "MsgItem.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/entity/MsgItem;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "ExternalIpEvent"
.end annotation


# instance fields
.field public externalIp:Ljava/lang/String;

.field public isSucess:I


# direct methods
.method public constructor <init>(ILjava/lang/String;)V
    .locals 0
    .param p1, "isSucess"    # I
    .param p2, "externalIp"    # Ljava/lang/String;

    .prologue
    .line 100
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 101
    iput p1, p0, Lcom/cyjh/elfin/entity/MsgItem$ExternalIpEvent;->isSucess:I

    .line 102
    iput-object p2, p0, Lcom/cyjh/elfin/entity/MsgItem$ExternalIpEvent;->externalIp:Ljava/lang/String;

    .line 103
    return-void
.end method
