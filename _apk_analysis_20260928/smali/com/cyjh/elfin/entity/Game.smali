.class public Lcom/cyjh/elfin/entity/Game;
.super Lcom/cyjh/elfin/entity/ResultResponse;
.source "Game.java"


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Lcom/cyjh/elfin/entity/Game;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field public Data:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/cyjh/elfin/entity/GameInfo;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 42
    new-instance v0, Lcom/cyjh/elfin/entity/Game$1;

    invoke-direct {v0}, Lcom/cyjh/elfin/entity/Game$1;-><init>()V

    sput-object v0, Lcom/cyjh/elfin/entity/Game;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 32
    invoke-direct {p0}, Lcom/cyjh/elfin/entity/ResultResponse;-><init>()V

    .line 33
    return-void
.end method

.method protected constructor <init>(Landroid/os/Parcel;)V
    .locals 1
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    .line 36
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/entity/ResultResponse;-><init>(Landroid/os/Parcel;)V

    .line 37
    sget-object v0, Lcom/cyjh/elfin/entity/GameInfo;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->createTypedArrayList(Landroid/os/Parcelable$Creator;)Ljava/util/ArrayList;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/entity/Game;->Data:Ljava/util/List;

    .line 38
    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/entity/Game;->Code:Ljava/lang/String;

    .line 39
    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/entity/Game;->Msg:Ljava/lang/String;

    .line 40
    return-void
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    .prologue
    .line 21
    const/4 v0, 0x0

    return v0
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 1
    .param p1, "dest"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    .line 26
    invoke-super {p0, p1, p2}, Lcom/cyjh/elfin/entity/ResultResponse;->writeToParcel(Landroid/os/Parcel;I)V

    .line 27
    iget-object v0, p0, Lcom/cyjh/elfin/entity/Game;->Data:Ljava/util/List;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeTypedList(Ljava/util/List;)V

    .line 28
    iget-object v0, p0, Lcom/cyjh/elfin/entity/Game;->Code:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 29
    iget-object v0, p0, Lcom/cyjh/elfin/entity/Game;->Msg:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 30
    return-void
.end method
