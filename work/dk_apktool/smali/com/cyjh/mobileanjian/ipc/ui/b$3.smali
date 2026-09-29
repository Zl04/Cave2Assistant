.class Lcom/cyjh/mobileanjian/ipc/ui/b$3;
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
.field final synthetic a:Lcom/cyjh/mobileanjian/ipc/ui/b;


# direct methods
.method constructor <init>(Lcom/cyjh/mobileanjian/ipc/ui/b;)V
    .locals 0

    .prologue
    .line 134
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/ui/b$3;->a:Lcom/cyjh/mobileanjian/ipc/ui/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .prologue
    .line 138
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b$3;->a:Lcom/cyjh/mobileanjian/ipc/ui/b;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/ui/b;->a(Lcom/cyjh/mobileanjian/ipc/ui/b;)Lcom/cyjh/mobileanjian/ipc/ui/b$a;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 139
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b$3;->a:Lcom/cyjh/mobileanjian/ipc/ui/b;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/ui/b;->a(Lcom/cyjh/mobileanjian/ipc/ui/b;)Lcom/cyjh/mobileanjian/ipc/ui/b$a;

    move-result-object v0

    const/4 v1, 0x1

    invoke-interface {v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/b$a;->a(I)V

    .line 140
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/b$3;->a:Lcom/cyjh/mobileanjian/ipc/ui/b;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/ui/b;->b(Lcom/cyjh/mobileanjian/ipc/ui/b;)V

    .line 141
    return-void
.end method
