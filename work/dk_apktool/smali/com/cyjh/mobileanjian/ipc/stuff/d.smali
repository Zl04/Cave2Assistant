.class public Lcom/cyjh/mobileanjian/ipc/stuff/d;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/mobileanjian/ipc/stuff/d$a;
    }
.end annotation


# instance fields
.field public a:Lcom/cyjh/mobileanjian/ipc/stuff/d$a;

.field public b:Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;

.field public c:I

.field public d:I


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 16
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/stuff/d$a;->a:Lcom/cyjh/mobileanjian/ipc/stuff/d$a;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/stuff/d;->a:Lcom/cyjh/mobileanjian/ipc/stuff/d$a;

    .line 19
    const/4 v0, 0x0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/stuff/d;->c:I

    .line 20
    const/4 v0, 0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/stuff/d;->d:I

    return-void
.end method
