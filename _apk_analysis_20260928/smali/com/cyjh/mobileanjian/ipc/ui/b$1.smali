.class Lcom/cyjh/mobileanjian/ipc/ui/b$1;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/mobileanjian/ipc/ui/b;-><init>(Landroid/content/Context;Ljava/lang/String;IIILcom/cyjh/mobileanjian/ipc/ui/b$a;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:I

.field final synthetic b:Lcom/cyjh/mobileanjian/ipc/ui/b;


# direct methods
.method constructor <init>(Lcom/cyjh/mobileanjian/ipc/ui/b;I)V
    .locals 0

    .prologue
    .line 108
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/ui/b$1;->b:Lcom/cyjh/mobileanjian/ipc/ui/b;

    iput p2, p0, Lcom/cyjh/mobileanjian/ipc/ui/b$1;->a:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3

    .prologue
    .line 112
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b$1;->b:Lcom/cyjh/mobileanjian/ipc/ui/b;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/ui/b;->a(Lcom/cyjh/mobileanjian/ipc/ui/b;)Lcom/cyjh/mobileanjian/ipc/ui/b$a;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 113
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b$1;->b:Lcom/cyjh/mobileanjian/ipc/ui/b;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/ui/b;->a(Lcom/cyjh/mobileanjian/ipc/ui/b;)Lcom/cyjh/mobileanjian/ipc/ui/b$a;

    move-result-object v1

    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b$1;->a:I

    if-eqz v0, :cond_0

    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b$1;->a:I

    const/4 v2, 0x1

    if-ne v0, v2, :cond_2

    :cond_0
    const/4 v0, 0x0

    :goto_0
    invoke-interface {v1, v0}, Lcom/cyjh/mobileanjian/ipc/ui/b$a;->a(I)V

    .line 114
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b$1;->b:Lcom/cyjh/mobileanjian/ipc/ui/b;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/ui/b;->b(Lcom/cyjh/mobileanjian/ipc/ui/b;)V

    .line 115
    return-void

    .line 113
    :cond_2
    const/4 v0, 0x2

    goto :goto_0
.end method
