.class public Lcom/cyjh/elfin/entity/MsgItem$PrincessAdEvent;
.super Ljava/lang/Object;
.source "MsgItem.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/entity/MsgItem;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "PrincessAdEvent"
.end annotation


# instance fields
.field public isSuccess:I

.field public princessAdData:Lcom/cyjh/elfin/entity/PrincessAdData;


# direct methods
.method public constructor <init>(Lcom/cyjh/elfin/entity/PrincessAdData;I)V
    .locals 0
    .param p1, "princessAdData"    # Lcom/cyjh/elfin/entity/PrincessAdData;
    .param p2, "isSuccess"    # I

    .prologue
    .line 87
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 88
    iput-object p1, p0, Lcom/cyjh/elfin/entity/MsgItem$PrincessAdEvent;->princessAdData:Lcom/cyjh/elfin/entity/PrincessAdData;

    .line 89
    iput p2, p0, Lcom/cyjh/elfin/entity/MsgItem$PrincessAdEvent;->isSuccess:I

    .line 90
    return-void
.end method
