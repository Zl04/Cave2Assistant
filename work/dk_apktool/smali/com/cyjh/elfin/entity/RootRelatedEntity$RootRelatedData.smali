.class public Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;
.super Ljava/lang/Object;
.source "RootRelatedEntity.java"

# interfaces
.implements Landroid/os/Parcelable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/entity/RootRelatedEntity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "RootRelatedData"
.end annotation


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field public Id:Ljava/lang/String;

.field public Image:Ljava/lang/String;

.field public PackageName:Ljava/lang/String;

.field public Path:Ljava/lang/String;

.field public ScriptName:Ljava/lang/String;

.field public Type:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 44
    new-instance v0, Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData$1;

    invoke-direct {v0}, Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData$1;-><init>()V

    sput-object v0, Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method protected constructor <init>(Landroid/os/Parcel;)V
    .locals 1
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 36
    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;->Id:Ljava/lang/String;

    .line 37
    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;->Type:Ljava/lang/String;

    .line 38
    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;->Image:Ljava/lang/String;

    .line 39
    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;->Path:Ljava/lang/String;

    .line 40
    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;->PackageName:Ljava/lang/String;

    .line 41
    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;->ScriptName:Ljava/lang/String;

    .line 42
    return-void
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    .prologue
    .line 58
    const/4 v0, 0x0

    return v0
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 1
    .param p1, "dest"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    .line 63
    iget-object v0, p0, Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;->Id:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 64
    iget-object v0, p0, Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;->Type:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 65
    iget-object v0, p0, Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;->Image:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 66
    iget-object v0, p0, Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;->Path:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 67
    iget-object v0, p0, Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;->PackageName:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 68
    iget-object v0, p0, Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;->ScriptName:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 69
    return-void
.end method
