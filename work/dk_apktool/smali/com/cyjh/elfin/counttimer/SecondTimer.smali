.class public abstract Lcom/cyjh/elfin/counttimer/SecondTimer;
.super Lcom/cyjh/elfin/counttimer/SimpleTimer;
.source "SecondTimer.java"


# direct methods
.method public constructor <init>(I)V
    .locals 1
    .param p1, "secondsInFuture"    # I

    .prologue
    .line 8
    const/4 v0, 0x1

    invoke-direct {p0, p1, v0}, Lcom/cyjh/elfin/counttimer/SimpleTimer;-><init>(II)V

    .line 9
    return-void
.end method
