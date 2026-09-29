.class public Lcom/cyjh/elfin/entity/MsgItem$RootDataEvent;
.super Ljava/lang/Object;
.source "MsgItem.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/entity/MsgItem;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "RootDataEvent"
.end annotation


# instance fields
.field public data:Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;


# direct methods
.method public constructor <init>(Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;)V
    .locals 0
    .param p1, "data"    # Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;

    .prologue
    .line 38
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 39
    iput-object p1, p0, Lcom/cyjh/elfin/entity/MsgItem$RootDataEvent;->data:Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;

    .line 40
    return-void
.end method
