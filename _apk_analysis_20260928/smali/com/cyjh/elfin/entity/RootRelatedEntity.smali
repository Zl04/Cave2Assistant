.class public Lcom/cyjh/elfin/entity/RootRelatedEntity;
.super Ljava/lang/Object;
.source "RootRelatedEntity.java"

# interfaces
.implements Landroid/os/Parcelable;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;
    }
.end annotation


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Lcom/cyjh/elfin/entity/RootRelatedEntity;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field public Code:Ljava/lang/String;

.field public Data:Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;

.field public Msg:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 90
    new-instance v0, Lcom/cyjh/elfin/entity/RootRelatedEntity$1;

    invoke-direct {v0}, Lcom/cyjh/elfin/entity/RootRelatedEntity$1;-><init>()V

    sput-object v0, Lcom/cyjh/elfin/entity/RootRelatedEntity;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method protected constructor <init>(Landroid/os/Parcel;)V
    .locals 1
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    .line 72
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 73
    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/entity/RootRelatedEntity;->Code:Ljava/lang/String;

    .line 74
    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/entity/RootRelatedEntity;->Msg:Ljava/lang/String;

    .line 75
    const-class v0, Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->readParcelable(Ljava/lang/ClassLoader;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;

    iput-object v0, p0, Lcom/cyjh/elfin/entity/RootRelatedEntity;->Data:Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;

    .line 76
    return-void
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    .prologue
    .line 87
    const/4 v0, 0x0

    return v0
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 1
    .param p1, "dest"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    .line 80
    iget-object v0, p0, Lcom/cyjh/elfin/entity/RootRelatedEntity;->Code:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 81
    iget-object v0, p0, Lcom/cyjh/elfin/entity/RootRelatedEntity;->Msg:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 82
    iget-object v0, p0, Lcom/cyjh/elfin/entity/RootRelatedEntity;->Data:Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;

    invoke-virtual {p1, v0, p2}, Landroid/os/Parcel;->writeParcelable(Landroid/os/Parcelable;I)V

    .line 83
    return-void
.end method
