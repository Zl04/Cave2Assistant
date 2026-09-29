.class public Lcom/umeng/commonsdk/framework/UMWorkDispatch;
.super Ljava/lang/Object;
.source "UMWorkDispatch.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static Quit()V
    .locals 0

    .prologue
    .line 16
    invoke-static {}, Lcom/umeng/commonsdk/framework/e;->a()V

    .line 17
    return-void
.end method

.method public static sendEvent(Landroid/content/Context;ILcom/umeng/commonsdk/framework/UMLogDataProtocol;Ljava/lang/Object;)V
    .locals 0

    .prologue
    .line 12
    invoke-static {p0, p1, p2, p3}, Lcom/umeng/commonsdk/framework/e;->a(Landroid/content/Context;ILcom/umeng/commonsdk/framework/UMLogDataProtocol;Ljava/lang/Object;)V

    .line 13
    return-void
.end method
