.class public abstract Lcom/king/sdk/g;
.super Landroid/os/Binder;
.source "SourceFile"

# interfaces
.implements Lcom/king/sdk/IDFEE16B42C8B2890D8FF2860AF5562B1;


# static fields
.field private static final DESCRIPTOR:Ljava/lang/String; = "com.king.sdk.IDFEE16B42C8B2890D8FF2860AF5562B1"

.field static final TRANSACTION_on088201B3F7D8B2CA1DF5D6AD12CB0C1F:I = 0x4

.field static final TRANSACTION_on0D923A4B87763BA40F853B570EF75D94:I = 0x6

.field static final TRANSACTION_on19C45B0F9674B131C4BF67981B1CC455:I = 0x7

.field static final TRANSACTION_on1DC022CD78BE5580705D060873AAEB16:I = 0x9

.field static final TRANSACTION_on369D7B24CF0870337D9962B9BB11E924:I = 0x3

.field static final TRANSACTION_on46FE18C9ADFE18C2BC0D43B003F41A66:I = 0x2

.field static final TRANSACTION_on96EC25C9716D6EFFB8DD7648F16E4FA2:I = 0x1

.field static final TRANSACTION_onACF4B25418AE4E2D8376A85BD6F0FC17:I = 0x8

.field static final TRANSACTION_onB9504A9B1263E0D14DFE18C2167427BC:I = 0x5


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 14
    invoke-direct {p0}, Landroid/os/Binder;-><init>()V

    .line 15
    const-string v0, "com.king.sdk.IDFEE16B42C8B2890D8FF2860AF5562B1"

    invoke-virtual {p0, p0, v0}, Lcom/king/sdk/g;->attachInterface(Landroid/os/IInterface;Ljava/lang/String;)V

    .line 16
    return-void
.end method

.method public static asInterface(Landroid/os/IBinder;)Lcom/king/sdk/IDFEE16B42C8B2890D8FF2860AF5562B1;
    .locals 2

    .prologue
    .line 23
    if-nez p0, :cond_0

    .line 24
    const/4 v0, 0x0

    .line 30
    :goto_0
    return-object v0

    .line 26
    :cond_0
    const-string v0, "com.king.sdk.IDFEE16B42C8B2890D8FF2860AF5562B1"

    invoke-interface {p0, v0}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object v0

    .line 27
    if-eqz v0, :cond_1

    instance-of v1, v0, Lcom/king/sdk/IDFEE16B42C8B2890D8FF2860AF5562B1;

    if-eqz v1, :cond_1

    .line 28
    check-cast v0, Lcom/king/sdk/IDFEE16B42C8B2890D8FF2860AF5562B1;

    goto :goto_0

    .line 30
    :cond_1
    new-instance v0, Lcom/king/sdk/h;

    invoke-direct {v0, p0}, Lcom/king/sdk/h;-><init>(Landroid/os/IBinder;)V

    goto :goto_0
.end method


# virtual methods
.method public asBinder()Landroid/os/IBinder;
    .locals 0

    .prologue
    .line 34
    return-object p0
.end method

.method public onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .locals 5

    .prologue
    const/4 v0, 0x0

    const/4 v3, 0x0

    const/4 v2, 0x1

    .line 38
    sparse-switch p1, :sswitch_data_0

    .line 167
    invoke-super {p0, p1, p2, p3, p4}, Landroid/os/Binder;->onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    move-result v2

    :goto_0
    return v2

    .line 42
    :sswitch_0
    const-string v0, "com.king.sdk.IDFEE16B42C8B2890D8FF2860AF5562B1"

    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto :goto_0

    .line 47
    :sswitch_1
    const-string v1, "com.king.sdk.IDFEE16B42C8B2890D8FF2860AF5562B1"

    invoke-virtual {p2, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 49
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_0

    .line 50
    sget-object v0, Landroid/content/Intent;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v0, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/Intent;

    .line 55
    :cond_0
    invoke-virtual {p0, v0}, Lcom/king/sdk/g;->on96EC25C9716D6EFFB8DD7648F16E4FA2(Landroid/content/Intent;)Z

    move-result v1

    .line 56
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 57
    if-eqz v1, :cond_1

    move v1, v2

    :goto_1
    invoke-virtual {p3, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 58
    if-eqz v0, :cond_2

    .line 59
    invoke-virtual {p3, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 60
    invoke-virtual {v0, p3, v2}, Landroid/content/Intent;->writeToParcel(Landroid/os/Parcel;I)V

    goto :goto_0

    :cond_1
    move v1, v3

    .line 57
    goto :goto_1

    .line 63
    :cond_2
    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_0

    .line 69
    :sswitch_2
    const-string v0, "com.king.sdk.IDFEE16B42C8B2890D8FF2860AF5562B1"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 71
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    .line 73
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_3

    move v3, v2

    .line 74
    :cond_3
    invoke-virtual {p0, v0, v3}, Lcom/king/sdk/g;->on46FE18C9ADFE18C2BC0D43B003F41A66(Ljava/lang/String;Z)V

    .line 75
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_0

    .line 80
    :sswitch_3
    const-string v0, "com.king.sdk.IDFEE16B42C8B2890D8FF2860AF5562B1"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 81
    invoke-virtual {p0}, Lcom/king/sdk/g;->on369D7B24CF0870337D9962B9BB11E924()V

    .line 82
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_0

    .line 87
    :sswitch_4
    const-string v0, "com.king.sdk.IDFEE16B42C8B2890D8FF2860AF5562B1"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 89
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    .line 91
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .line 92
    invoke-virtual {p0, v0, v1}, Lcom/king/sdk/g;->on088201B3F7D8B2CA1DF5D6AD12CB0C1F(Ljava/lang/String;I)V

    .line 93
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_0

    .line 98
    :sswitch_5
    const-string v0, "com.king.sdk.IDFEE16B42C8B2890D8FF2860AF5562B1"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 100
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    .line 102
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v1

    .line 104
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 106
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .line 107
    invoke-virtual {p0, v0, v1, v3, v4}, Lcom/king/sdk/g;->onB9504A9B1263E0D14DFE18C2167427BC(Ljava/lang/String;Ljava/lang/String;II)V

    .line 108
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 113
    :sswitch_6
    const-string v0, "com.king.sdk.IDFEE16B42C8B2890D8FF2860AF5562B1"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 115
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .line 117
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .line 118
    invoke-virtual {p0, v0, v1}, Lcom/king/sdk/g;->on0D923A4B87763BA40F853B570EF75D94(II)V

    .line 119
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 124
    :sswitch_7
    const-string v0, "com.king.sdk.IDFEE16B42C8B2890D8FF2860AF5562B1"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 126
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    .line 128
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .line 129
    invoke-virtual {p0, v0, v1}, Lcom/king/sdk/g;->on19C45B0F9674B131C4BF67981B1CC455(Ljava/lang/String;I)V

    .line 130
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 135
    :sswitch_8
    const-string v0, "com.king.sdk.IDFEE16B42C8B2890D8FF2860AF5562B1"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 137
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    .line 139
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v1

    .line 140
    invoke-virtual {p0, v0, v1}, Lcom/king/sdk/g;->onACF4B25418AE4E2D8376A85BD6F0FC17(Ljava/lang/String;Ljava/lang/String;)V

    .line 141
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 146
    :sswitch_9
    const-string v1, "com.king.sdk.IDFEE16B42C8B2890D8FF2860AF5562B1"

    invoke-virtual {p2, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 148
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_4

    .line 149
    sget-object v0, Landroid/content/Intent;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v0, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/Intent;

    .line 154
    :cond_4
    invoke-virtual {p0, v0}, Lcom/king/sdk/g;->on1DC022CD78BE5580705D060873AAEB16(Landroid/content/Intent;)Z

    move-result v1

    .line 155
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 156
    if-eqz v1, :cond_5

    move v1, v2

    :goto_2
    invoke-virtual {p3, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 157
    if-eqz v0, :cond_6

    .line 158
    invoke-virtual {p3, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 159
    invoke-virtual {v0, p3, v2}, Landroid/content/Intent;->writeToParcel(Landroid/os/Parcel;I)V

    goto/16 :goto_0

    :cond_5
    move v1, v3

    .line 156
    goto :goto_2

    .line 162
    :cond_6
    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 38
    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_1
        0x2 -> :sswitch_2
        0x3 -> :sswitch_3
        0x4 -> :sswitch_4
        0x5 -> :sswitch_5
        0x6 -> :sswitch_6
        0x7 -> :sswitch_7
        0x8 -> :sswitch_8
        0x9 -> :sswitch_9
        0x5f4e5446 -> :sswitch_0
    .end sparse-switch
.end method
