.class Lcom/cyjh/mobileanjian/ipc/view/a$a;
.super Ljava/util/TimerTask;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/view/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Lcom/cyjh/mobileanjian/ipc/view/a;


# direct methods
.method private constructor <init>(Lcom/cyjh/mobileanjian/ipc/view/a;)V
    .locals 0

    .prologue
    .line 300
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/view/a$a;->a:Lcom/cyjh/mobileanjian/ipc/view/a;

    invoke-direct {p0}, Ljava/util/TimerTask;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/cyjh/mobileanjian/ipc/view/a;Lcom/cyjh/mobileanjian/ipc/view/a$1;)V
    .locals 0

    .prologue
    .line 300
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/view/a$a;-><init>(Lcom/cyjh/mobileanjian/ipc/view/a;)V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    .prologue
    .line 305
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/a$a;->a:Lcom/cyjh/mobileanjian/ipc/view/a;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/view/a;->d()V

    .line 306
    return-void
.end method
