.class public Lcom/cyjh/elfin/entity/AbNormalGameEvent$InstallAppSuccessEvent;
.super Ljava/lang/Object;
.source "AbNormalGameEvent.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/entity/AbNormalGameEvent;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "InstallAppSuccessEvent"
.end annotation


# instance fields
.field private packageName:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 0
    .param p1, "packageName"    # Ljava/lang/String;

    .prologue
    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 33
    iput-object p1, p0, Lcom/cyjh/elfin/entity/AbNormalGameEvent$InstallAppSuccessEvent;->packageName:Ljava/lang/String;

    .line 34
    return-void
.end method


# virtual methods
.method public getPackageName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 37
    iget-object v0, p0, Lcom/cyjh/elfin/entity/AbNormalGameEvent$InstallAppSuccessEvent;->packageName:Ljava/lang/String;

    return-object v0
.end method
