.class Lcom/cyjh/mobileanjian/ipc/ui/b$2;
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
    .line 121
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/ui/b$2;->b:Lcom/cyjh/mobileanjian/ipc/ui/b;

    iput p2, p0, Lcom/cyjh/mobileanjian/ipc/ui/b$2;->a:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3

    .prologue
    const/4 v0, 0x1

    .line 125
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/b$2;->b:Lcom/cyjh/mobileanjian/ipc/ui/b;

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/ui/b;->a(Lcom/cyjh/mobileanjian/ipc/ui/b;)Lcom/cyjh/mobileanjian/ipc/ui/b$a;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 126
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/b$2;->b:Lcom/cyjh/mobileanjian/ipc/ui/b;

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/ui/b;->a(Lcom/cyjh/mobileanjian/ipc/ui/b;)Lcom/cyjh/mobileanjian/ipc/ui/b$a;

    move-result-object v1

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/b$2;->a:I

    if-ne v2, v0, :cond_1

    :goto_0
    invoke-interface {v1, v0}, Lcom/cyjh/mobileanjian/ipc/ui/b$a;->a(I)V

    .line 127
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b$2;->b:Lcom/cyjh/mobileanjian/ipc/ui/b;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/ui/b;->b(Lcom/cyjh/mobileanjian/ipc/ui/b;)V

    .line 128
    return-void

    .line 126
    :cond_1
    const/4 v0, 0x3

    goto :goto_0
.end method
