.class final Lcom/goldcoast/sdk/domain/d;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Lcom/goldcoast/sdk/domain/EntryPoint;


# direct methods
.method constructor <init>(Lcom/goldcoast/sdk/domain/EntryPoint;)V
    .locals 0

    .prologue
    .line 445
    iput-object p1, p0, Lcom/goldcoast/sdk/domain/d;->a:Lcom/goldcoast/sdk/domain/EntryPoint;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 1

    .prologue
    .line 448
    iget-object v0, p0, Lcom/goldcoast/sdk/domain/d;->a:Lcom/goldcoast/sdk/domain/EntryPoint;

    invoke-static {v0}, Lcom/goldcoast/sdk/domain/EntryPoint;->c(Lcom/goldcoast/sdk/domain/EntryPoint;)V

    .line 449
    return-void
.end method
