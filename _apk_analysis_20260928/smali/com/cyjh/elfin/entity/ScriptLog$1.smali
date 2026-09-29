.class final Lcom/cyjh/elfin/entity/ScriptLog$1;
.super Ljava/lang/Object;
.source "ScriptLog.java"

# interfaces
.implements Landroid/os/Parcelable$Creator;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/entity/ScriptLog;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Landroid/os/Parcelable$Creator",
        "<",
        "Lcom/cyjh/elfin/entity/ScriptLog;",
        ">;"
    }
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 70
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public createFromParcel(Landroid/os/Parcel;)Lcom/cyjh/elfin/entity/ScriptLog;
    .locals 2
    .param p1, "source"    # Landroid/os/Parcel;

    .prologue
    .line 74
    new-instance v0, Lcom/cyjh/elfin/entity/ScriptLog;

    const/4 v1, 0x0

    invoke-direct {v0, p1, v1}, Lcom/cyjh/elfin/entity/ScriptLog;-><init>(Landroid/os/Parcel;Lcom/cyjh/elfin/entity/ScriptLog$1;)V

    return-object v0
.end method

.method public bridge synthetic createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 70
    invoke-virtual {p0, p1}, Lcom/cyjh/elfin/entity/ScriptLog$1;->createFromParcel(Landroid/os/Parcel;)Lcom/cyjh/elfin/entity/ScriptLog;

    move-result-object v0

    return-object v0
.end method

.method public newArray(I)[Lcom/cyjh/elfin/entity/ScriptLog;
    .locals 1
    .param p1, "size"    # I

    .prologue
    .line 79
    new-array v0, p1, [Lcom/cyjh/elfin/entity/ScriptLog;

    return-object v0
.end method

.method public bridge synthetic newArray(I)[Ljava/lang/Object;
    .locals 1

    .prologue
    .line 70
    invoke-virtual {p0, p1}, Lcom/cyjh/elfin/entity/ScriptLog$1;->newArray(I)[Lcom/cyjh/elfin/entity/ScriptLog;

    move-result-object v0

    return-object v0
.end method
