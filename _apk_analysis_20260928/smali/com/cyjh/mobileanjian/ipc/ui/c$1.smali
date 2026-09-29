.class Lcom/cyjh/mobileanjian/ipc/ui/c$1;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/mobileanjian/ipc/ui/c;-><init>(Landroid/content/Context;Ljava/lang/String;IILcom/cyjh/mobileanjian/ipc/ui/c$a;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/cyjh/mobileanjian/ipc/ui/c;


# direct methods
.method constructor <init>(Lcom/cyjh/mobileanjian/ipc/ui/c;)V
    .locals 0

    .prologue
    .line 41
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/ui/c$1;->a:Lcom/cyjh/mobileanjian/ipc/ui/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .prologue
    .line 45
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/c$1;->a:Lcom/cyjh/mobileanjian/ipc/ui/c;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/ui/c;->a(Lcom/cyjh/mobileanjian/ipc/ui/c;)Lcom/cyjh/mobileanjian/ipc/ui/c$a;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 46
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/c$1;->a:Lcom/cyjh/mobileanjian/ipc/ui/c;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/ui/c;->a(Lcom/cyjh/mobileanjian/ipc/ui/c;)Lcom/cyjh/mobileanjian/ipc/ui/c$a;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/c$1;->a:Lcom/cyjh/mobileanjian/ipc/ui/c;

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/ui/c;->b(Lcom/cyjh/mobileanjian/ipc/ui/c;)Landroid/widget/EditText;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/c$a;->a(Ljava/lang/String;)V

    .line 47
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/c$1;->a:Lcom/cyjh/mobileanjian/ipc/ui/c;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/ui/c;->c(Lcom/cyjh/mobileanjian/ipc/ui/c;)V

    .line 48
    return-void
.end method
