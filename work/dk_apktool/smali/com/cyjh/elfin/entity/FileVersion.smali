.class public Lcom/cyjh/elfin/entity/FileVersion;
.super Ljava/lang/Object;
.source "FileVersion.java"

# interfaces
.implements Landroid/os/Parcelable;


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Lcom/cyjh/elfin/entity/FileVersion;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field atc:I

.field mq:I

.field prop:I

.field rtd:I

.field ui:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 129
    new-instance v0, Lcom/cyjh/elfin/entity/FileVersion$1;

    invoke-direct {v0}, Lcom/cyjh/elfin/entity/FileVersion$1;-><init>()V

    sput-object v0, Lcom/cyjh/elfin/entity/FileVersion;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 30
    return-void
.end method

.method public constructor <init>(IIIII)V
    .locals 0
    .param p1, "atc"    # I
    .param p2, "mq"    # I
    .param p3, "prop"    # I
    .param p4, "ui"    # I
    .param p5, "rtd"    # I

    .prologue
    .line 39
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 40
    iput p1, p0, Lcom/cyjh/elfin/entity/FileVersion;->atc:I

    .line 41
    iput p2, p0, Lcom/cyjh/elfin/entity/FileVersion;->mq:I

    .line 42
    iput p3, p0, Lcom/cyjh/elfin/entity/FileVersion;->prop:I

    .line 43
    iput p4, p0, Lcom/cyjh/elfin/entity/FileVersion;->ui:I

    .line 44
    iput p5, p0, Lcom/cyjh/elfin/entity/FileVersion;->rtd:I

    .line 45
    return-void
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    .prologue
    .line 117
    const/4 v0, 0x0

    return v0
.end method

.method public getAtc()I
    .locals 1

    .prologue
    .line 51
    iget v0, p0, Lcom/cyjh/elfin/entity/FileVersion;->atc:I

    return v0
.end method

.method public getMq()I
    .locals 1

    .prologue
    .line 66
    iget v0, p0, Lcom/cyjh/elfin/entity/FileVersion;->mq:I

    return v0
.end method

.method public getProp()I
    .locals 1

    .prologue
    .line 81
    iget v0, p0, Lcom/cyjh/elfin/entity/FileVersion;->prop:I

    return v0
.end method

.method public getRtd()I
    .locals 1

    .prologue
    .line 108
    iget v0, p0, Lcom/cyjh/elfin/entity/FileVersion;->rtd:I

    return v0
.end method

.method public getUi()I
    .locals 1

    .prologue
    .line 96
    iget v0, p0, Lcom/cyjh/elfin/entity/FileVersion;->ui:I

    return v0
.end method

.method public setAtc(I)V
    .locals 0
    .param p1, "atc"    # I

    .prologue
    .line 59
    iput p1, p0, Lcom/cyjh/elfin/entity/FileVersion;->atc:I

    .line 60
    return-void
.end method

.method public setMq(I)V
    .locals 0
    .param p1, "mq"    # I

    .prologue
    .line 74
    iput p1, p0, Lcom/cyjh/elfin/entity/FileVersion;->mq:I

    .line 75
    return-void
.end method

.method public setProp(I)V
    .locals 0
    .param p1, "prop"    # I

    .prologue
    .line 89
    iput p1, p0, Lcom/cyjh/elfin/entity/FileVersion;->prop:I

    .line 90
    return-void
.end method

.method public setRtd(I)V
    .locals 0
    .param p1, "rtd"    # I

    .prologue
    .line 112
    iput p1, p0, Lcom/cyjh/elfin/entity/FileVersion;->rtd:I

    .line 113
    return-void
.end method

.method public setUI(I)V
    .locals 0
    .param p1, "ui"    # I

    .prologue
    .line 104
    iput p1, p0, Lcom/cyjh/elfin/entity/FileVersion;->ui:I

    .line 105
    return-void
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 1
    .param p1, "dest"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    .line 122
    iget v0, p0, Lcom/cyjh/elfin/entity/FileVersion;->atc:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 123
    iget v0, p0, Lcom/cyjh/elfin/entity/FileVersion;->mq:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 124
    iget v0, p0, Lcom/cyjh/elfin/entity/FileVersion;->prop:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 125
    iget v0, p0, Lcom/cyjh/elfin/entity/FileVersion;->ui:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 126
    iget v0, p0, Lcom/cyjh/elfin/entity/FileVersion;->rtd:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 127
    return-void
.end method
