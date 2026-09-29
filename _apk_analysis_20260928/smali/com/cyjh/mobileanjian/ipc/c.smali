.class public Lcom/cyjh/mobileanjian/ipc/c;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field private a:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 8
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/c;->a:Z

    return-void
.end method


# virtual methods
.method public a(Z)Lcom/cyjh/mobileanjian/ipc/c;
    .locals 0

    .prologue
    .line 12
    iput-boolean p1, p0, Lcom/cyjh/mobileanjian/ipc/c;->a:Z

    .line 13
    return-object p0
.end method

.method public a()Z
    .locals 1

    .prologue
    .line 17
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/c;->a:Z

    return v0
.end method
