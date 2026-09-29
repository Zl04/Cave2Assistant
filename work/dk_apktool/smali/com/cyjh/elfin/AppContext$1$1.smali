.class Lcom/cyjh/elfin/AppContext$1$1;
.super Ljava/lang/Object;
.source "AppContext.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/AppContext$1;->onShake()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/cyjh/elfin/AppContext$1;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/AppContext$1;)V
    .locals 0
    .param p1, "this$1"    # Lcom/cyjh/elfin/AppContext$1;

    .prologue
    .line 310
    iput-object p1, p0, Lcom/cyjh/elfin/AppContext$1$1;->this$1:Lcom/cyjh/elfin/AppContext$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    .prologue
    .line 313
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext$1$1;->this$1:Lcom/cyjh/elfin/AppContext$1;

    iget-object v0, v0, Lcom/cyjh/elfin/AppContext$1;->val$vibrator:Landroid/os/Vibrator;

    invoke-virtual {v0}, Landroid/os/Vibrator;->cancel()V

    .line 314
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext$1$1;->this$1:Lcom/cyjh/elfin/AppContext$1;

    iget-object v0, v0, Lcom/cyjh/elfin/AppContext$1;->val$mShakeListener:Lcom/cyjh/elfin/AppContext$ShakeListener;

    invoke-virtual {v0}, Lcom/cyjh/elfin/AppContext$ShakeListener;->start()V

    .line 315
    return-void
.end method
