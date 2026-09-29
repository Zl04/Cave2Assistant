.class Lcom/umeng/commonsdk/framework/d$a;
.super Landroid/os/FileObserver;
.source "UMNetWorkSender.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/umeng/commonsdk/framework/d;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "a"
.end annotation


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 286
    invoke-direct {p0, p1}, Landroid/os/FileObserver;-><init>(Ljava/lang/String;)V

    .line 287
    return-void
.end method


# virtual methods
.method public onEvent(ILjava/lang/String;)V
    .locals 2

    .prologue
    .line 291
    and-int/lit8 v0, p1, 0x8

    .line 292
    packed-switch v0, :pswitch_data_0

    .line 301
    :goto_0
    return-void

    .line 294
    :pswitch_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "--->>> envelope file created >>> "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/e;->b(Ljava/lang/String;)V

    .line 295
    const/16 v0, 0x111

    invoke-static {v0}, Lcom/umeng/commonsdk/framework/d;->a(I)V

    goto :goto_0

    .line 292
    :pswitch_data_0
    .packed-switch 0x8
        :pswitch_0
    .end packed-switch
.end method
