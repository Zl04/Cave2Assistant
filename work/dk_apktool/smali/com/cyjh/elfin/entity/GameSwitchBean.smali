.class public Lcom/cyjh/elfin/entity/GameSwitchBean;
.super Lcom/cyjh/elfin/entity/ResultResponse;
.source "GameSwitchBean.java"


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Lcom/cyjh/elfin/entity/GameSwitchBean;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field public Data:Lcom/cyjh/elfin/entity/GameSwitchInfo;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 39
    new-instance v0, Lcom/cyjh/elfin/entity/GameSwitchBean$1;

    invoke-direct {v0}, Lcom/cyjh/elfin/entity/GameSwitchBean$1;-><init>()V

    sput-object v0, Lcom/cyjh/elfin/entity/GameSwitchBean;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 29
    invoke-direct {p0}, Lcom/cyjh/elfin/entity/ResultResponse;-><init>()V

    .line 30
    return-void
.end method

.method protected constructor <init>(Landroid/os/Parcel;)V
    .locals 1
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    .line 33
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/entity/ResultResponse;-><init>(Landroid/os/Parcel;)V

    .line 34
    const-class v0, Lcom/cyjh/elfin/entity/GameSwitchInfo;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->readParcelable(Ljava/lang/ClassLoader;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/entity/GameSwitchInfo;

    iput-object v0, p0, Lcom/cyjh/elfin/entity/GameSwitchBean;->Data:Lcom/cyjh/elfin/entity/GameSwitchInfo;

    .line 35
    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/entity/GameSwitchBean;->Code:Ljava/lang/String;

    .line 36
    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/entity/GameSwitchBean;->Msg:Ljava/lang/String;

    .line 37
    return-void
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    .prologue
    .line 18
    const/4 v0, 0x0

    return v0
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 1
    .param p1, "dest"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    .line 23
    invoke-super {p0, p1, p2}, Lcom/cyjh/elfin/entity/ResultResponse;->writeToParcel(Landroid/os/Parcel;I)V

    .line 24
    iget-object v0, p0, Lcom/cyjh/elfin/entity/GameSwitchBean;->Data:Lcom/cyjh/elfin/entity/GameSwitchInfo;

    invoke-virtual {p1, v0, p2}, Landroid/os/Parcel;->writeParcelable(Landroid/os/Parcelable;I)V

    .line 25
    iget-object v0, p0, Lcom/cyjh/elfin/entity/GameSwitchBean;->Code:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 26
    iget-object v0, p0, Lcom/cyjh/elfin/entity/GameSwitchBean;->Msg:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 27
    return-void
.end method
