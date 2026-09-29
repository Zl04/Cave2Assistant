.class public Lcom/cyjh/elfin/entity/MsgItem$ExposureAndClickEvent;
.super Ljava/lang/Object;
.source "MsgItem.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/entity/MsgItem;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "ExposureAndClickEvent"
.end annotation


# static fields
.field public static final CLICK_TYPE:Ljava/lang/String; = "CLICK"

.field public static final EXPOSURE_TYPE:Ljava/lang/String; = "EXPOSURE"


# instance fields
.field public index:I

.field public isSuccess:I

.field public type:Ljava/lang/String;


# direct methods
.method public constructor <init>(IILjava/lang/String;)V
    .locals 0
    .param p1, "index"    # I
    .param p2, "isSuccess"    # I
    .param p3, "type"    # Ljava/lang/String;

    .prologue
    .line 116
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 117
    iput p1, p0, Lcom/cyjh/elfin/entity/MsgItem$ExposureAndClickEvent;->index:I

    .line 118
    iput p2, p0, Lcom/cyjh/elfin/entity/MsgItem$ExposureAndClickEvent;->isSuccess:I

    .line 119
    iput-object p3, p0, Lcom/cyjh/elfin/entity/MsgItem$ExposureAndClickEvent;->type:Ljava/lang/String;

    .line 120
    return-void
.end method
