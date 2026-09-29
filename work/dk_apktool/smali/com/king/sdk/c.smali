.class public abstract Lcom/king/sdk/c;
.super Landroid/os/Binder;
.source "SourceFile"

# interfaces
.implements Lcom/king/sdk/b;


# direct methods
.method public static a(Landroid/os/IBinder;)Lcom/king/sdk/b;
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
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-interface {p0, v0}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object v0

    .line 27
    if-eqz v0, :cond_1

    instance-of v1, v0, Lcom/king/sdk/b;

    if-eqz v1, :cond_1

    .line 28
    check-cast v0, Lcom/king/sdk/b;

    goto :goto_0

    .line 30
    :cond_1
    new-instance v0, Lcom/king/sdk/d;

    invoke-direct {v0, p0}, Lcom/king/sdk/d;-><init>(Landroid/os/IBinder;)V

    goto :goto_0
.end method


# virtual methods
.method public onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .locals 9

    .prologue
    const/4 v8, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x1

    .line 38
    sparse-switch p1, :sswitch_data_0

    .line 426
    invoke-super {p0, p1, p2, p3, p4}, Landroid/os/Binder;->onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    move-result v7

    :goto_0
    return v7

    .line 42
    :sswitch_0
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto :goto_0

    .line 47
    :sswitch_1
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 49
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    if-eqz v0, :cond_0

    .line 50
    sget-object v0, Landroid/accounts/Account;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v0, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/accounts/Account;

    .line 55
    :goto_1
    invoke-virtual {p0, v0}, Lcom/king/sdk/c;->a(Landroid/accounts/Account;)Ljava/lang/String;

    move-result-object v0

    .line 56
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 57
    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    move-object v0, v6

    .line 53
    goto :goto_1

    .line 62
    :sswitch_2
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 64
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    if-eqz v0, :cond_1

    .line 65
    sget-object v0, Landroid/accounts/Account;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v0, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/accounts/Account;

    .line 71
    :goto_2
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v1

    .line 73
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v2

    .line 75
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 76
    invoke-virtual {p0, v0, v1, v2, v3}, Lcom/king/sdk/c;->a(Landroid/accounts/Account;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 77
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 78
    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_0

    :cond_1
    move-object v0, v6

    .line 68
    goto :goto_2

    .line 83
    :sswitch_3
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 85
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    if-eqz v0, :cond_2

    .line 86
    sget-object v0, Landroid/accounts/Account;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v0, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/accounts/Account;

    .line 92
    :goto_3
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v1

    .line 94
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v2

    .line 96
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 97
    invoke-virtual {p0, v0, v1, v2, v3}, Lcom/king/sdk/c;->b(Landroid/accounts/Account;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 98
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 99
    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_0

    :cond_2
    move-object v0, v6

    .line 89
    goto :goto_3

    .line 104
    :sswitch_4
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 105
    invoke-virtual {p0}, Lcom/king/sdk/c;->a()I

    move-result v0

    .line 106
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 107
    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 112
    :sswitch_5
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 114
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    .line 116
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v1

    .line 118
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 119
    invoke-virtual {p0, v0, v1, v2}, Lcom/king/sdk/c;->a(Ljava/lang/String;Ljava/lang/String;I)V

    .line 120
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 125
    :sswitch_6
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 127
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    .line 129
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object v1

    .line 131
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 132
    invoke-virtual {p0, v0, v1, v2}, Lcom/king/sdk/c;->a(Ljava/lang/String;Landroid/os/IBinder;I)V

    .line 133
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 138
    :sswitch_7
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 140
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    .line 142
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .line 144
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 145
    invoke-virtual {p0, v0, v1, v2}, Lcom/king/sdk/c;->a(Ljava/lang/String;II)V

    .line 146
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 151
    :sswitch_8
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 153
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    if-eqz v0, :cond_3

    .line 154
    sget-object v0, Landroid/content/ComponentName;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v0, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/ComponentName;

    .line 160
    :goto_4
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .line 162
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 163
    invoke-virtual {p0, v0, v1, v2}, Lcom/king/sdk/c;->a(Landroid/content/ComponentName;II)V

    .line 164
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    :cond_3
    move-object v0, v6

    .line 157
    goto :goto_4

    .line 169
    :sswitch_9
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 171
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v1

    .line 173
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    if-eqz v0, :cond_4

    move v0, v7

    .line 174
    :goto_5
    invoke-virtual {p0, v1, v0}, Lcom/king/sdk/c;->a(Ljava/lang/String;Z)V

    .line 175
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    :cond_4
    move v0, v8

    .line 173
    goto :goto_5

    .line 180
    :sswitch_a
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 181
    invoke-virtual {p0}, Lcom/king/sdk/c;->b()[B

    move-result-object v0

    .line 182
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 183
    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeByteArray([B)V

    goto/16 :goto_0

    .line 188
    :sswitch_b
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 190
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .line 191
    invoke-virtual {p0, v0}, Lcom/king/sdk/c;->a(I)V

    .line 192
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 197
    :sswitch_c
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 199
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    .line 200
    invoke-virtual {p0, v0}, Lcom/king/sdk/c;->a(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    .line 201
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 202
    if-eqz v0, :cond_5

    .line 203
    invoke-virtual {p3, v7}, Landroid/os/Parcel;->writeInt(I)V

    .line 204
    invoke-virtual {v0, p3, v7}, Landroid/content/Intent;->writeToParcel(Landroid/os/Parcel;I)V

    goto/16 :goto_0

    .line 207
    :cond_5
    invoke-virtual {p3, v8}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 213
    :sswitch_d
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 215
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .line 217
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .line 219
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v2

    .line 220
    invoke-virtual {p0, v0, v1, v2}, Lcom/king/sdk/c;->a(IILjava/lang/String;)V

    .line 221
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 226
    :sswitch_e
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 228
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    .line 229
    invoke-virtual {p0, v0}, Lcom/king/sdk/c;->b(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    .line 230
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 231
    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeStrongBinder(Landroid/os/IBinder;)V

    goto/16 :goto_0

    .line 236
    :sswitch_f
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 238
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    .line 239
    invoke-virtual {p0, v0}, Lcom/king/sdk/c;->c(Ljava/lang/String;)V

    .line 240
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 245
    :sswitch_10
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 246
    invoke-virtual {p0}, Lcom/king/sdk/c;->c()Ljava/lang/String;

    move-result-object v0

    .line 247
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 248
    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 253
    :sswitch_11
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 254
    invoke-virtual {p0}, Lcom/king/sdk/c;->d()Ljava/lang/String;

    move-result-object v0

    .line 255
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 256
    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 261
    :sswitch_12
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 263
    invoke-virtual {p2}, Landroid/os/Parcel;->createStringArray()[Ljava/lang/String;

    move-result-object v0

    .line 265
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .line 267
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v2

    .line 269
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 270
    invoke-virtual {p0, v0, v1, v2, v3}, Lcom/king/sdk/c;->a([Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;)V

    .line 271
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 276
    :sswitch_13
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 277
    invoke-virtual {p0}, Lcom/king/sdk/c;->e()I

    move-result v0

    .line 278
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 279
    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 284
    :sswitch_14
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 285
    invoke-virtual {p0}, Lcom/king/sdk/c;->f()Ljava/lang/String;

    move-result-object v0

    .line 286
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 287
    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 292
    :sswitch_15
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 294
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    .line 295
    invoke-virtual {p0, v0}, Lcom/king/sdk/c;->d(Ljava/lang/String;)Z

    move-result v0

    .line 296
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 297
    if-eqz v0, :cond_6

    move v8, v7

    :cond_6
    invoke-virtual {p3, v8}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 302
    :sswitch_16
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 304
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object v0

    invoke-static {v0}, Lcom/king/sdk/g;->asInterface(Landroid/os/IBinder;)Lcom/king/sdk/IDFEE16B42C8B2890D8FF2860AF5562B1;

    move-result-object v0

    .line 305
    invoke-virtual {p0, v0}, Lcom/king/sdk/c;->a(Lcom/king/sdk/IDFEE16B42C8B2890D8FF2860AF5562B1;)V

    .line 306
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 311
    :sswitch_17
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 313
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object v0

    invoke-static {v0}, Lcom/king/sdk/g;->asInterface(Landroid/os/IBinder;)Lcom/king/sdk/IDFEE16B42C8B2890D8FF2860AF5562B1;

    move-result-object v0

    .line 314
    invoke-virtual {p0, v0}, Lcom/king/sdk/c;->b(Lcom/king/sdk/IDFEE16B42C8B2890D8FF2860AF5562B1;)V

    .line 315
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 320
    :sswitch_18
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 322
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v1

    .line 324
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 326
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 328
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    if-eqz v0, :cond_7

    .line 329
    sget-object v0, Landroid/app/Notification;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v0, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/Notification;

    .line 334
    :goto_6
    invoke-virtual {p0, v1, v2, v3, v0}, Lcom/king/sdk/c;->a(Ljava/lang/String;ILjava/lang/String;Landroid/app/Notification;)V

    .line 335
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    :cond_7
    move-object v0, v6

    .line 332
    goto :goto_6

    .line 340
    :sswitch_19
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 341
    invoke-virtual {p0}, Lcom/king/sdk/c;->g()Ljava/lang/String;

    move-result-object v0

    .line 342
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 343
    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 348
    :sswitch_1a
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 350
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    .line 351
    invoke-virtual {p0, v0}, Lcom/king/sdk/c;->e(Ljava/lang/String;)V

    .line 352
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 357
    :sswitch_1b
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 359
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v1

    .line 361
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v2

    .line 363
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 365
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    if-eqz v0, :cond_9

    .line 366
    sget-object v0, Landroid/app/PendingIntent;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v0, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/PendingIntent;

    move-object v4, v0

    .line 372
    :goto_7
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    if-eqz v0, :cond_a

    .line 373
    sget-object v0, Landroid/app/PendingIntent;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v0, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/PendingIntent;

    move-object v5, v0

    :goto_8
    move-object v0, p0

    .line 378
    invoke-virtual/range {v0 .. v5}, Lcom/king/sdk/c;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;)Z

    move-result v0

    .line 379
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 380
    if-eqz v0, :cond_8

    move v8, v7

    :cond_8
    invoke-virtual {p3, v8}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    :cond_9
    move-object v4, v6

    .line 369
    goto :goto_7

    :cond_a
    move-object v5, v6

    .line 376
    goto :goto_8

    .line 385
    :sswitch_1c
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 387
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    .line 389
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v1

    .line 390
    invoke-virtual {p0, v0, v1}, Lcom/king/sdk/c;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    .line 391
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 392
    if-eqz v0, :cond_b

    move v8, v7

    :cond_b
    invoke-virtual {p3, v8}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 397
    :sswitch_1d
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 399
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v1

    .line 401
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v2

    .line 403
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 405
    invoke-virtual {p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v4

    .line 407
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    if-eqz v0, :cond_e

    .line 408
    sget-object v0, Landroid/app/PendingIntent;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v0, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/PendingIntent;

    move-object v5, v0

    .line 414
    :goto_9
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    if-eqz v0, :cond_c

    .line 415
    sget-object v0, Landroid/app/PendingIntent;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v0, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/PendingIntent;

    move-object v6, v0

    :cond_c
    move-object v0, p0

    .line 420
    invoke-virtual/range {v0 .. v6}, Lcom/king/sdk/c;->a(Ljava/lang/String;Ljava/lang/String;I[BLandroid/app/PendingIntent;Landroid/app/PendingIntent;)Z

    move-result v0

    .line 421
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 422
    if-eqz v0, :cond_d

    move v8, v7

    :cond_d
    invoke-virtual {p3, v8}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    :cond_e
    move-object v5, v6

    .line 411
    goto :goto_9

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
        0xa -> :sswitch_a
        0xb -> :sswitch_b
        0xc -> :sswitch_c
        0xd -> :sswitch_d
        0xe -> :sswitch_e
        0xf -> :sswitch_f
        0x10 -> :sswitch_10
        0x11 -> :sswitch_11
        0x12 -> :sswitch_12
        0x13 -> :sswitch_13
        0x14 -> :sswitch_14
        0x15 -> :sswitch_15
        0x16 -> :sswitch_16
        0x17 -> :sswitch_17
        0x18 -> :sswitch_18
        0x19 -> :sswitch_19
        0x1a -> :sswitch_1a
        0x1b -> :sswitch_1b
        0x1c -> :sswitch_1c
        0x1d -> :sswitch_1d
        0x5f4e5446 -> :sswitch_0
    .end sparse-switch
.end method
