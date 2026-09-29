.class Lcom/cyjh/elfin/AppContext$1;
.super Ljava/lang/Object;
.source "AppContext.java"

# interfaces
.implements Lcom/cyjh/elfin/AppContext$ShakeListener$OnShakeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/AppContext;->initShake()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/AppContext;

.field final synthetic val$mShakeListener:Lcom/cyjh/elfin/AppContext$ShakeListener;

.field final synthetic val$vibrator:Landroid/os/Vibrator;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/AppContext;Lcom/cyjh/elfin/AppContext$ShakeListener;Landroid/os/Vibrator;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/AppContext;

    .prologue
    .line 302
    iput-object p1, p0, Lcom/cyjh/elfin/AppContext$1;->this$0:Lcom/cyjh/elfin/AppContext;

    iput-object p2, p0, Lcom/cyjh/elfin/AppContext$1;->val$mShakeListener:Lcom/cyjh/elfin/AppContext$ShakeListener;

    iput-object p3, p0, Lcom/cyjh/elfin/AppContext$1;->val$vibrator:Landroid/os/Vibrator;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onShake()V
    .locals 4

    .prologue
    .line 304
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext$1;->this$0:Lcom/cyjh/elfin/AppContext;

    iget-object v0, v0, Lcom/cyjh/elfin/AppContext;->sharedPreferences:Landroid/content/SharedPreferences;

    const-string v1, "com.cyjh.elfin.activity.SettingActivity.swtWaggleStop"

    const/4 v2, 0x1

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 305
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext$1;->this$0:Lcom/cyjh/elfin/AppContext;

    invoke-static {v0}, Lcom/cyjh/elfin/AppContext;->access$000(Lcom/cyjh/elfin/AppContext;)Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->stop()V

    .line 306
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext$1;->val$mShakeListener:Lcom/cyjh/elfin/AppContext$ShakeListener;

    invoke-virtual {v0}, Lcom/cyjh/elfin/AppContext$ShakeListener;->stop()V

    .line 307
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext$1;->this$0:Lcom/cyjh/elfin/AppContext;

    invoke-static {v0}, Lcom/cyjh/elfin/AppContext;->access$000(Lcom/cyjh/elfin/AppContext;)Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->isScriptStarted()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 309
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext$1;->val$vibrator:Landroid/os/Vibrator;

    const/4 v1, 0x4

    new-array v1, v1, [J

    fill-array-data v1, :array_0

    const/4 v2, -0x1

    invoke-virtual {v0, v1, v2}, Landroid/os/Vibrator;->vibrate([JI)V

    .line 310
    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    new-instance v1, Lcom/cyjh/elfin/AppContext$1$1;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/AppContext$1$1;-><init>(Lcom/cyjh/elfin/AppContext$1;)V

    const-wide/16 v2, 0x5dc

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 319
    :cond_0
    return-void

    .line 309
    nop

    :array_0
    .array-data 8
        0x1f4
        0xc8
        0x1f4
        0xc8
    .end array-data
.end method
