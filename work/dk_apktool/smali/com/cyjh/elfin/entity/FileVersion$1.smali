.class final Lcom/cyjh/elfin/entity/FileVersion$1;
.super Ljava/lang/Object;
.source "FileVersion.java"

# interfaces
.implements Landroid/os/Parcelable$Creator;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/entity/FileVersion;
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
        "Lcom/cyjh/elfin/entity/FileVersion;",
        ">;"
    }
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 129
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public createFromParcel(Landroid/os/Parcel;)Lcom/cyjh/elfin/entity/FileVersion;
    .locals 6
    .param p1, "source"    # Landroid/os/Parcel;

    .prologue
    .line 138
    new-instance v0, Lcom/cyjh/elfin/entity/FileVersion;

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v2

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v3

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .line 139
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v5

    invoke-direct/range {v0 .. v5}, Lcom/cyjh/elfin/entity/FileVersion;-><init>(IIIII)V

    .line 138
    return-object v0
.end method

.method public bridge synthetic createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 129
    invoke-virtual {p0, p1}, Lcom/cyjh/elfin/entity/FileVersion$1;->createFromParcel(Landroid/os/Parcel;)Lcom/cyjh/elfin/entity/FileVersion;

    move-result-object v0

    return-object v0
.end method

.method public newArray(I)[Lcom/cyjh/elfin/entity/FileVersion;
    .locals 1
    .param p1, "size"    # I

    .prologue
    .line 133
    new-array v0, p1, [Lcom/cyjh/elfin/entity/FileVersion;

    return-object v0
.end method

.method public bridge synthetic newArray(I)[Ljava/lang/Object;
    .locals 1

    .prologue
    .line 129
    invoke-virtual {p0, p1}, Lcom/cyjh/elfin/entity/FileVersion$1;->newArray(I)[Lcom/cyjh/elfin/entity/FileVersion;

    move-result-object v0

    return-object v0
.end method
