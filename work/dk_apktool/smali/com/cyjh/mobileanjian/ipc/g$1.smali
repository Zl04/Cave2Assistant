.class Lcom/cyjh/mobileanjian/ipc/g$1;
.super Landroid/os/Handler;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/g;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/cyjh/mobileanjian/ipc/g;

.field private b:Lcom/cyjh/mobileanjian/ipc/view/ExToast;


# direct methods
.method constructor <init>(Lcom/cyjh/mobileanjian/ipc/g;Landroid/os/Looper;)V
    .locals 1

    .prologue
    .line 63
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->a:Lcom/cyjh/mobileanjian/ipc/g;

    invoke-direct {p0, p2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 64
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->b:Lcom/cyjh/mobileanjian/ipc/view/ExToast;

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 7

    .prologue
    const/4 v5, 0x0

    .line 69
    invoke-super {p0, p1}, Landroid/os/Handler;->handleMessage(Landroid/os/Message;)V

    .line 70
    iget v0, p1, Landroid/os/Message;->what:I

    packed-switch v0, :pswitch_data_0

    .line 185
    :cond_0
    :goto_0
    :pswitch_0
    return-void

    .line 73
    :pswitch_1
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    if-nez v0, :cond_1

    .line 74
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->a:Lcom/cyjh/mobileanjian/ipc/g;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/g;->a(Lcom/cyjh/mobileanjian/ipc/g;)Landroid/content/Context;

    move-result-object v0

    iget v1, p1, Landroid/os/Message;->arg1:I

    invoke-static {v0, v1, v5}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    goto :goto_0

    .line 76
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->a:Lcom/cyjh/mobileanjian/ipc/g;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/g;->a(Lcom/cyjh/mobileanjian/ipc/g;)Landroid/content/Context;

    move-result-object v1

    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Ljava/lang/CharSequence;

    invoke-static {v1, v0, v5}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    goto :goto_0

    .line 79
    :pswitch_2
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->b:Lcom/cyjh/mobileanjian/ipc/view/ExToast;

    if-nez v0, :cond_2

    .line 81
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/view/ExToast;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->a:Lcom/cyjh/mobileanjian/ipc/g;

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/g;->a(Lcom/cyjh/mobileanjian/ipc/g;)Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/cyjh/mobileanjian/ipc/view/ExToast;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->b:Lcom/cyjh/mobileanjian/ipc/view/ExToast;

    .line 83
    :cond_2
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    .line 84
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->b:Lcom/cyjh/mobileanjian/ipc/view/ExToast;

    invoke-virtual {v0, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg2(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v3

    const/4 v4, 0x1

    invoke-virtual {v0, v4}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v4

    const/4 v5, 0x2

    invoke-virtual {v0, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v0

    invoke-virtual {v1, v2, v3, v4, v0}, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->show(Ljava/lang/CharSequence;III)V

    goto :goto_0

    .line 87
    :pswitch_3
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->a:Lcom/cyjh/mobileanjian/ipc/g;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/g;->b(Lcom/cyjh/mobileanjian/ipc/g;)Lcom/cyjh/mobileanjian/ipc/d;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/d;->h()Lcom/cyjh/mobileanjian/ipc/interfaces/BasicScriptListener;

    move-result-object v0

    if-eqz v0, :cond_3

    .line 88
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->a:Lcom/cyjh/mobileanjian/ipc/g;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/g;->b(Lcom/cyjh/mobileanjian/ipc/g;)Lcom/cyjh/mobileanjian/ipc/d;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/d;->h()Lcom/cyjh/mobileanjian/ipc/interfaces/BasicScriptListener;

    move-result-object v0

    invoke-interface {v0}, Lcom/cyjh/mobileanjian/ipc/interfaces/BasicScriptListener;->onStartScript()V

    .line 89
    :cond_3
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->a:Lcom/cyjh/mobileanjian/ipc/g;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/g;->b(Lcom/cyjh/mobileanjian/ipc/g;)Lcom/cyjh/mobileanjian/ipc/d;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/d;->i()Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 90
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->a:Lcom/cyjh/mobileanjian/ipc/g;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/g;->b(Lcom/cyjh/mobileanjian/ipc/g;)Lcom/cyjh/mobileanjian/ipc/d;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/d;->i()Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;

    move-result-object v0

    invoke-interface {v0}, Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;->onStartScript()V

    goto/16 :goto_0

    .line 93
    :pswitch_4
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->a:Lcom/cyjh/mobileanjian/ipc/g;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/g;->b(Lcom/cyjh/mobileanjian/ipc/g;)Lcom/cyjh/mobileanjian/ipc/d;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/d;->h()Lcom/cyjh/mobileanjian/ipc/interfaces/BasicScriptListener;

    move-result-object v0

    if-eqz v0, :cond_4

    .line 94
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->a:Lcom/cyjh/mobileanjian/ipc/g;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/g;->b(Lcom/cyjh/mobileanjian/ipc/g;)Lcom/cyjh/mobileanjian/ipc/d;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/d;->h()Lcom/cyjh/mobileanjian/ipc/interfaces/BasicScriptListener;

    move-result-object v0

    invoke-interface {v0}, Lcom/cyjh/mobileanjian/ipc/interfaces/BasicScriptListener;->onScriptIsRunning()V

    .line 95
    :cond_4
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->a:Lcom/cyjh/mobileanjian/ipc/g;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/g;->b(Lcom/cyjh/mobileanjian/ipc/g;)Lcom/cyjh/mobileanjian/ipc/d;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/d;->i()Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 96
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->a:Lcom/cyjh/mobileanjian/ipc/g;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/g;->b(Lcom/cyjh/mobileanjian/ipc/g;)Lcom/cyjh/mobileanjian/ipc/d;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/d;->i()Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;

    move-result-object v0

    invoke-interface {v0}, Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;->onScriptIsRunning()V

    goto/16 :goto_0

    .line 99
    :pswitch_5
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->a:Lcom/cyjh/mobileanjian/ipc/g;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/g;->b(Lcom/cyjh/mobileanjian/ipc/g;)Lcom/cyjh/mobileanjian/ipc/d;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/d;->h()Lcom/cyjh/mobileanjian/ipc/interfaces/BasicScriptListener;

    move-result-object v0

    if-eqz v0, :cond_5

    .line 100
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->a:Lcom/cyjh/mobileanjian/ipc/g;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/g;->b(Lcom/cyjh/mobileanjian/ipc/g;)Lcom/cyjh/mobileanjian/ipc/d;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/d;->h()Lcom/cyjh/mobileanjian/ipc/interfaces/BasicScriptListener;

    move-result-object v0

    invoke-interface {v0}, Lcom/cyjh/mobileanjian/ipc/interfaces/BasicScriptListener;->onPause()V

    .line 101
    :cond_5
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->a:Lcom/cyjh/mobileanjian/ipc/g;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/g;->b(Lcom/cyjh/mobileanjian/ipc/g;)Lcom/cyjh/mobileanjian/ipc/d;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/d;->i()Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 102
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->a:Lcom/cyjh/mobileanjian/ipc/g;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/g;->b(Lcom/cyjh/mobileanjian/ipc/g;)Lcom/cyjh/mobileanjian/ipc/d;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/d;->i()Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;

    move-result-object v0

    invoke-interface {v0}, Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;->onPause()V

    goto/16 :goto_0

    .line 105
    :pswitch_6
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->a:Lcom/cyjh/mobileanjian/ipc/g;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/g;->b(Lcom/cyjh/mobileanjian/ipc/g;)Lcom/cyjh/mobileanjian/ipc/d;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/d;->h()Lcom/cyjh/mobileanjian/ipc/interfaces/BasicScriptListener;

    move-result-object v0

    if-eqz v0, :cond_6

    .line 106
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->a:Lcom/cyjh/mobileanjian/ipc/g;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/g;->b(Lcom/cyjh/mobileanjian/ipc/g;)Lcom/cyjh/mobileanjian/ipc/d;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/d;->h()Lcom/cyjh/mobileanjian/ipc/interfaces/BasicScriptListener;

    move-result-object v0

    invoke-interface {v0}, Lcom/cyjh/mobileanjian/ipc/interfaces/BasicScriptListener;->onResume()V

    .line 107
    :cond_6
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->a:Lcom/cyjh/mobileanjian/ipc/g;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/g;->b(Lcom/cyjh/mobileanjian/ipc/g;)Lcom/cyjh/mobileanjian/ipc/d;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/d;->i()Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 108
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->a:Lcom/cyjh/mobileanjian/ipc/g;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/g;->b(Lcom/cyjh/mobileanjian/ipc/g;)Lcom/cyjh/mobileanjian/ipc/d;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/d;->i()Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;

    move-result-object v0

    invoke-interface {v0}, Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;->onResume()V

    goto/16 :goto_0

    .line 111
    :pswitch_7
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->a:Lcom/cyjh/mobileanjian/ipc/g;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/g;->c(Lcom/cyjh/mobileanjian/ipc/g;)Lcom/cyjh/mobileanjian/ipc/ui/h;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a()V

    .line 112
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->b:Lcom/cyjh/mobileanjian/ipc/view/ExToast;

    if-eqz v0, :cond_7

    .line 114
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->b:Lcom/cyjh/mobileanjian/ipc/view/ExToast;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->hide()V

    .line 116
    :cond_7
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->a:Lcom/cyjh/mobileanjian/ipc/g;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/g;->b(Lcom/cyjh/mobileanjian/ipc/g;)Lcom/cyjh/mobileanjian/ipc/d;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/d;->h()Lcom/cyjh/mobileanjian/ipc/interfaces/BasicScriptListener;

    move-result-object v0

    if-eqz v0, :cond_8

    .line 117
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->a:Lcom/cyjh/mobileanjian/ipc/g;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/g;->b(Lcom/cyjh/mobileanjian/ipc/g;)Lcom/cyjh/mobileanjian/ipc/d;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/d;->h()Lcom/cyjh/mobileanjian/ipc/interfaces/BasicScriptListener;

    move-result-object v1

    iget v2, p1, Landroid/os/Message;->arg1:I

    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Ljava/lang/String;

    invoke-interface {v1, v2, v0}, Lcom/cyjh/mobileanjian/ipc/interfaces/BasicScriptListener;->onStopScript(ILjava/lang/String;)V

    .line 118
    :cond_8
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->a:Lcom/cyjh/mobileanjian/ipc/g;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/g;->b(Lcom/cyjh/mobileanjian/ipc/g;)Lcom/cyjh/mobileanjian/ipc/d;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/d;->i()Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 119
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->a:Lcom/cyjh/mobileanjian/ipc/g;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/g;->b(Lcom/cyjh/mobileanjian/ipc/g;)Lcom/cyjh/mobileanjian/ipc/d;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/d;->i()Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;

    move-result-object v1

    iget v2, p1, Landroid/os/Message;->arg1:I

    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Ljava/lang/String;

    invoke-interface {v1, v2, v0}, Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;->onStopScript(ILjava/lang/String;)V

    goto/16 :goto_0

    .line 123
    :pswitch_8
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->a:Lcom/cyjh/mobileanjian/ipc/g;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/g;->b(Lcom/cyjh/mobileanjian/ipc/g;)Lcom/cyjh/mobileanjian/ipc/d;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/d;->i()Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 124
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->a:Lcom/cyjh/mobileanjian/ipc/g;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/g;->b(Lcom/cyjh/mobileanjian/ipc/g;)Lcom/cyjh/mobileanjian/ipc/d;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/d;->i()Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;

    move-result-object v0

    iget v1, p1, Landroid/os/Message;->arg1:I

    int-to-float v1, v1

    const/high16 v2, 0x42c80000    # 100.0f

    div-float/2addr v1, v2

    iget v2, p1, Landroid/os/Message;->arg2:I

    invoke-interface {v0, v1, v2}, Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;->onUpdateControlBarPos(FI)V

    goto/16 :goto_0

    .line 128
    :pswitch_9
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/h;->e()Lcom/cyjh/mobileanjian/ipc/interfaces/OnKeyEventListener;

    move-result-object v0

    .line 129
    if-eqz v0, :cond_0

    .line 131
    iget v1, p1, Landroid/os/Message;->arg1:I

    invoke-interface {v0, v1}, Lcom/cyjh/mobileanjian/ipc/interfaces/OnKeyEventListener;->onKeyEvent(I)V

    goto/16 :goto_0

    .line 137
    :pswitch_a
    :try_start_0
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Lcom/google/protobuf/ByteString;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->parseFrom(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    move-result-object v0

    .line 138
    if-eqz v0, :cond_0

    .line 140
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->a:Lcom/cyjh/mobileanjian/ipc/g;

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/g;->c(Lcom/cyjh/mobileanjian/ipc/g;)Lcom/cyjh/mobileanjian/ipc/ui/h;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)V
    :try_end_0
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_0

    .line 142
    :catch_0
    move-exception v0

    .line 144
    invoke-virtual {v0}, Lcom/google/protobuf/InvalidProtocolBufferException;->printStackTrace()V

    goto/16 :goto_0

    .line 148
    :pswitch_b
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    .line 149
    invoke-virtual {v0, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg2(I)Ljava/lang/String;

    move-result-object v2

    .line 150
    invoke-virtual {v0, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v3

    .line 151
    invoke-virtual {v0, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v4

    .line 152
    invoke-virtual {v0, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v5

    .line 153
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/ui/b;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->a:Lcom/cyjh/mobileanjian/ipc/g;

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/g;->a(Lcom/cyjh/mobileanjian/ipc/g;)Landroid/content/Context;

    move-result-object v1

    new-instance v6, Lcom/cyjh/mobileanjian/ipc/g$1$1;

    invoke-direct {v6, p0}, Lcom/cyjh/mobileanjian/ipc/g$1$1;-><init>(Lcom/cyjh/mobileanjian/ipc/g$1;)V

    invoke-direct/range {v0 .. v6}, Lcom/cyjh/mobileanjian/ipc/ui/b;-><init>(Landroid/content/Context;Ljava/lang/String;IIILcom/cyjh/mobileanjian/ipc/ui/b$a;)V

    .line 164
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/ui/b;->a()V

    goto/16 :goto_0

    .line 167
    :pswitch_c
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    .line 168
    invoke-virtual {v0, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg2(I)Ljava/lang/String;

    move-result-object v2

    .line 169
    invoke-virtual {v0, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v3

    .line 170
    invoke-virtual {v0, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1(I)I

    move-result v4

    .line 171
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/ui/c;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/g$1;->a:Lcom/cyjh/mobileanjian/ipc/g;

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/g;->a(Lcom/cyjh/mobileanjian/ipc/g;)Landroid/content/Context;

    move-result-object v1

    new-instance v5, Lcom/cyjh/mobileanjian/ipc/g$1$2;

    invoke-direct {v5, p0}, Lcom/cyjh/mobileanjian/ipc/g$1$2;-><init>(Lcom/cyjh/mobileanjian/ipc/g$1;)V

    invoke-direct/range {v0 .. v5}, Lcom/cyjh/mobileanjian/ipc/ui/c;-><init>(Landroid/content/Context;Ljava/lang/String;IILcom/cyjh/mobileanjian/ipc/ui/c$a;)V

    .line 182
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/ui/c;->a()V

    goto/16 :goto_0

    .line 70
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_3
        :pswitch_7
        :pswitch_4
        :pswitch_1
        :pswitch_b
        :pswitch_c
        :pswitch_5
        :pswitch_6
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_8
        :pswitch_9
        :pswitch_a
    .end packed-switch
.end method
