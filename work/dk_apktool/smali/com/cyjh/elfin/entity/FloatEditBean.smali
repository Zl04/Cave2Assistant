.class public Lcom/cyjh/elfin/entity/FloatEditBean;
.super Ljava/lang/Object;
.source "FloatEditBean.java"

# interfaces
.implements Landroid/os/Parcelable;


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Lcom/cyjh/elfin/entity/FloatEditBean;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field public intentContent:Ljava/lang/String;

.field public intentTtile:Ljava/lang/String;

.field public isCancle:Z

.field public leftContent:Ljava/lang/String;

.field public rightContent:Ljava/lang/String;

.field public type:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 115
    new-instance v0, Lcom/cyjh/elfin/entity/FloatEditBean$1;

    invoke-direct {v0}, Lcom/cyjh/elfin/entity/FloatEditBean$1;-><init>()V

    sput-object v0, Lcom/cyjh/elfin/entity/FloatEditBean;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 102
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 103
    return-void
.end method

.method protected constructor <init>(Landroid/os/Parcel;)V
    .locals 2
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    .line 105
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 106
    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/elfin/entity/FloatEditBean;->intentTtile:Ljava/lang/String;

    .line 107
    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/elfin/entity/FloatEditBean;->intentContent:Ljava/lang/String;

    .line 108
    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/elfin/entity/FloatEditBean;->leftContent:Ljava/lang/String;

    .line 109
    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/elfin/entity/FloatEditBean;->rightContent:Ljava/lang/String;

    .line 110
    invoke-virtual {p1}, Landroid/os/Parcel;->readByte()B

    move-result v1

    if-eqz v1, :cond_0

    const/4 v1, 0x1

    :goto_0
    iput-boolean v1, p0, Lcom/cyjh/elfin/entity/FloatEditBean;->isCancle:Z

    .line 111
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .line 112
    .local v0, "tmpType":I
    const/4 v1, -0x1

    if-ne v0, v1, :cond_1

    const/4 v1, 0x0

    :goto_1
    iput-object v1, p0, Lcom/cyjh/elfin/entity/FloatEditBean;->type:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    .line 113
    return-void

    .line 110
    .end local v0    # "tmpType":I
    :cond_0
    const/4 v1, 0x0

    goto :goto_0

    .line 112
    .restart local v0    # "tmpType":I
    :cond_1
    invoke-static {}, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->values()[Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    move-result-object v1

    aget-object v1, v1, v0

    goto :goto_1
.end method

.method public static getDeleteFloatBean(Landroid/content/Context;Ljava/lang/String;)Lcom/cyjh/elfin/entity/FloatEditBean;
    .locals 2
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "content"    # Ljava/lang/String;

    .prologue
    .line 23
    new-instance v0, Lcom/cyjh/elfin/entity/FloatEditBean;

    invoke-direct {v0}, Lcom/cyjh/elfin/entity/FloatEditBean;-><init>()V

    .line 24
    .local v0, "floatEditBean":Lcom/cyjh/elfin/entity/FloatEditBean;
    const v1, 0x7f080096

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/cyjh/elfin/entity/FloatEditBean;->intentTtile:Ljava/lang/String;

    .line 25
    iput-object p1, v0, Lcom/cyjh/elfin/entity/FloatEditBean;->intentContent:Ljava/lang/String;

    .line 26
    const v1, 0x7f080040

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/cyjh/elfin/entity/FloatEditBean;->leftContent:Ljava/lang/String;

    .line 27
    const v1, 0x7f080042

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/cyjh/elfin/entity/FloatEditBean;->rightContent:Ljava/lang/String;

    .line 28
    const/4 v1, 0x1

    iput-boolean v1, v0, Lcom/cyjh/elfin/entity/FloatEditBean;->isCancle:Z

    .line 29
    sget-object v1, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->DELETE:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    iput-object v1, v0, Lcom/cyjh/elfin/entity/FloatEditBean;->type:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    .line 30
    return-object v0
.end method

.method public static getEditFlloatBean(Landroid/content/Context;Ljava/lang/String;)Lcom/cyjh/elfin/entity/FloatEditBean;
    .locals 2
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "content"    # Ljava/lang/String;

    .prologue
    .line 34
    new-instance v0, Lcom/cyjh/elfin/entity/FloatEditBean;

    invoke-direct {v0}, Lcom/cyjh/elfin/entity/FloatEditBean;-><init>()V

    .line 35
    .local v0, "floatEditBean":Lcom/cyjh/elfin/entity/FloatEditBean;
    const v1, 0x7f080097

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/cyjh/elfin/entity/FloatEditBean;->intentTtile:Ljava/lang/String;

    .line 36
    iput-object p1, v0, Lcom/cyjh/elfin/entity/FloatEditBean;->intentContent:Ljava/lang/String;

    .line 37
    const v1, 0x7f080040

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/cyjh/elfin/entity/FloatEditBean;->leftContent:Ljava/lang/String;

    .line 38
    const v1, 0x7f080042

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/cyjh/elfin/entity/FloatEditBean;->rightContent:Ljava/lang/String;

    .line 39
    const/4 v1, 0x1

    iput-boolean v1, v0, Lcom/cyjh/elfin/entity/FloatEditBean;->isCancle:Z

    .line 40
    sget-object v1, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->RENAME:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    iput-object v1, v0, Lcom/cyjh/elfin/entity/FloatEditBean;->type:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    .line 41
    return-object v0
.end method

.method public static getNewCreateFlloatBean(Landroid/content/Context;Ljava/lang/String;)Lcom/cyjh/elfin/entity/FloatEditBean;
    .locals 2
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "content"    # Ljava/lang/String;

    .prologue
    .line 60
    new-instance v0, Lcom/cyjh/elfin/entity/FloatEditBean;

    invoke-direct {v0}, Lcom/cyjh/elfin/entity/FloatEditBean;-><init>()V

    .line 61
    .local v0, "floatEditBean":Lcom/cyjh/elfin/entity/FloatEditBean;
    const v1, 0x7f080051

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/cyjh/elfin/entity/FloatEditBean;->intentTtile:Ljava/lang/String;

    .line 62
    iput-object p1, v0, Lcom/cyjh/elfin/entity/FloatEditBean;->intentContent:Ljava/lang/String;

    .line 63
    const v1, 0x7f080040

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/cyjh/elfin/entity/FloatEditBean;->leftContent:Ljava/lang/String;

    .line 64
    const v1, 0x7f080042

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/cyjh/elfin/entity/FloatEditBean;->rightContent:Ljava/lang/String;

    .line 65
    const/4 v1, 0x1

    iput-boolean v1, v0, Lcom/cyjh/elfin/entity/FloatEditBean;->isCancle:Z

    .line 66
    sget-object v1, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->CREATE_NEW_FILE:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    iput-object v1, v0, Lcom/cyjh/elfin/entity/FloatEditBean;->type:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    .line 67
    return-object v0
.end method

.method public static getSaveFloatBean(Landroid/content/Context;)Lcom/cyjh/elfin/entity/FloatEditBean;
    .locals 2
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 45
    new-instance v0, Lcom/cyjh/elfin/entity/FloatEditBean;

    invoke-direct {v0}, Lcom/cyjh/elfin/entity/FloatEditBean;-><init>()V

    .line 46
    .local v0, "floatEditBean":Lcom/cyjh/elfin/entity/FloatEditBean;
    const v1, 0x7f0800dc

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/cyjh/elfin/entity/FloatEditBean;->intentTtile:Ljava/lang/String;

    .line 47
    const v1, 0x7f0800fe

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/cyjh/elfin/entity/FloatEditBean;->intentContent:Ljava/lang/String;

    .line 48
    const v1, 0x7f0800db

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/cyjh/elfin/entity/FloatEditBean;->rightContent:Ljava/lang/String;

    .line 49
    const v1, 0x7f080045

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/cyjh/elfin/entity/FloatEditBean;->leftContent:Ljava/lang/String;

    .line 50
    sget-object v1, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->SAVE:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    iput-object v1, v0, Lcom/cyjh/elfin/entity/FloatEditBean;->type:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    .line 51
    return-object v0
.end method

.method public static getStartDownloadFlloatBean(Landroid/content/Context;Ljava/lang/String;)Lcom/cyjh/elfin/entity/FloatEditBean;
    .locals 2
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "content"    # Ljava/lang/String;

    .prologue
    .line 77
    new-instance v0, Lcom/cyjh/elfin/entity/FloatEditBean;

    invoke-direct {v0}, Lcom/cyjh/elfin/entity/FloatEditBean;-><init>()V

    .line 78
    .local v0, "floatEditBean":Lcom/cyjh/elfin/entity/FloatEditBean;
    const v1, 0x7f080131

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/cyjh/elfin/entity/FloatEditBean;->intentTtile:Ljava/lang/String;

    .line 79
    iput-object p1, v0, Lcom/cyjh/elfin/entity/FloatEditBean;->intentContent:Ljava/lang/String;

    .line 80
    const v1, 0x7f080040

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/cyjh/elfin/entity/FloatEditBean;->leftContent:Ljava/lang/String;

    .line 81
    const v1, 0x7f080041

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/cyjh/elfin/entity/FloatEditBean;->rightContent:Ljava/lang/String;

    .line 82
    const/4 v1, 0x1

    iput-boolean v1, v0, Lcom/cyjh/elfin/entity/FloatEditBean;->isCancle:Z

    .line 83
    sget-object v1, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->START_DOWNLOAD:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    iput-object v1, v0, Lcom/cyjh/elfin/entity/FloatEditBean;->type:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    .line 84
    return-object v0
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    .prologue
    .line 89
    const/4 v0, 0x0

    return v0
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 1
    .param p1, "dest"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    .line 94
    iget-object v0, p0, Lcom/cyjh/elfin/entity/FloatEditBean;->intentTtile:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 95
    iget-object v0, p0, Lcom/cyjh/elfin/entity/FloatEditBean;->intentContent:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 96
    iget-object v0, p0, Lcom/cyjh/elfin/entity/FloatEditBean;->leftContent:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 97
    iget-object v0, p0, Lcom/cyjh/elfin/entity/FloatEditBean;->rightContent:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 98
    iget-boolean v0, p0, Lcom/cyjh/elfin/entity/FloatEditBean;->isCancle:Z

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeByte(B)V

    .line 99
    iget-object v0, p0, Lcom/cyjh/elfin/entity/FloatEditBean;->type:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    if-nez v0, :cond_1

    const/4 v0, -0x1

    :goto_1
    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 100
    return-void

    .line 98
    :cond_0
    const/4 v0, 0x0

    goto :goto_0

    .line 99
    :cond_1
    iget-object v0, p0, Lcom/cyjh/elfin/entity/FloatEditBean;->type:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    invoke-virtual {v0}, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->ordinal()I

    move-result v0

    goto :goto_1
.end method
