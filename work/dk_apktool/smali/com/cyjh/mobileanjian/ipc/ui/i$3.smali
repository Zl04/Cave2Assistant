.class Lcom/cyjh/mobileanjian/ipc/ui/i$3;
.super Landroid/os/Handler;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/ui/i;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/cyjh/mobileanjian/ipc/ui/i;


# direct methods
.method constructor <init>(Lcom/cyjh/mobileanjian/ipc/ui/i;)V
    .locals 0

    .prologue
    .line 230
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/ui/i$3;->a:Lcom/cyjh/mobileanjian/ipc/ui/i;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 1

    .prologue
    .line 234
    iget v0, p1, Landroid/os/Message;->what:I

    packed-switch v0, :pswitch_data_0

    .line 240
    :goto_0
    return-void

    .line 237
    :pswitch_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i$3;->a:Lcom/cyjh/mobileanjian/ipc/ui/i;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/ui/i;->c(Lcom/cyjh/mobileanjian/ipc/ui/i;)Landroid/widget/LinearLayout;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->invalidate()V

    goto :goto_0

    .line 234
    :pswitch_data_0
    .packed-switch 0x100
        :pswitch_0
    .end packed-switch
.end method
