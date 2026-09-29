.class final Lcom/cyjh/elfin/entity/BestResolution$1;
.super Ljava/lang/Object;
.source "BestResolution.java"

# interfaces
.implements Landroid/os/Parcelable$Creator;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/entity/BestResolution;
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
        "Lcom/cyjh/elfin/entity/BestResolution;",
        ">;"
    }
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 85
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public createFromParcel(Landroid/os/Parcel;)Lcom/cyjh/elfin/entity/BestResolution;
    .locals 3
    .param p1, "source"    # Landroid/os/Parcel;

    .prologue
    .line 94
    new-instance v0, Lcom/cyjh/elfin/entity/BestResolution;

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v2

    invoke-direct {v0, v1, v2}, Lcom/cyjh/elfin/entity/BestResolution;-><init>(II)V

    return-object v0
.end method

.method public bridge synthetic createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 85
    invoke-virtual {p0, p1}, Lcom/cyjh/elfin/entity/BestResolution$1;->createFromParcel(Landroid/os/Parcel;)Lcom/cyjh/elfin/entity/BestResolution;

    move-result-object v0

    return-object v0
.end method

.method public newArray(I)[Lcom/cyjh/elfin/entity/BestResolution;
    .locals 1
    .param p1, "size"    # I

    .prologue
    .line 89
    new-array v0, p1, [Lcom/cyjh/elfin/entity/BestResolution;

    return-object v0
.end method

.method public bridge synthetic newArray(I)[Ljava/lang/Object;
    .locals 1

    .prologue
    .line 85
    invoke-virtual {p0, p1}, Lcom/cyjh/elfin/entity/BestResolution$1;->newArray(I)[Lcom/cyjh/elfin/entity/BestResolution;

    move-result-object v0

    return-object v0
.end method
