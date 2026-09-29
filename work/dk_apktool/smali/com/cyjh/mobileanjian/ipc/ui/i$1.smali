.class Lcom/cyjh/mobileanjian/ipc/ui/i$1;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/mobileanjian/ipc/ui/i;->a(II)V
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
    .line 184
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/ui/i$1;->a:Lcom/cyjh/mobileanjian/ipc/ui/i;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    .prologue
    .line 188
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i$1;->a:Lcom/cyjh/mobileanjian/ipc/ui/i;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/ui/i;->a(Lcom/cyjh/mobileanjian/ipc/ui/i;)Landroid/view/View$OnClickListener;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 189
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i$1;->a:Lcom/cyjh/mobileanjian/ipc/ui/i;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/ui/i;->a(Lcom/cyjh/mobileanjian/ipc/ui/i;)Landroid/view/View$OnClickListener;

    move-result-object v0

    invoke-interface {v0, p1}, Landroid/view/View$OnClickListener;->onClick(Landroid/view/View;)V

    .line 190
    :cond_0
    return-void
.end method
