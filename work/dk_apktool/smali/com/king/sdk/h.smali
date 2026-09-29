.class final Lcom/king/sdk/h;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/king/sdk/IDFEE16B42C8B2890D8FF2860AF5562B1;


# instance fields
.field private a:Landroid/os/IBinder;


# direct methods
.method constructor <init>(Landroid/os/IBinder;)V
    .locals 0

    .prologue
    .line 173
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 174
    iput-object p1, p0, Lcom/king/sdk/h;->a:Landroid/os/IBinder;

    .line 175
    return-void
.end method


# virtual methods
.method public final asBinder()Landroid/os/IBinder;
    .locals 1

    .prologue
    .line 178
    iget-object v0, p0, Lcom/king/sdk/h;->a:Landroid/os/IBinder;

    return-object v0
.end method

.method public final on088201B3F7D8B2CA1DF5D6AD12CB0C1F(Ljava/lang/String;I)V
    .locals 5

    .prologue
    .line 255
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 256
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 258
    :try_start_0
    const-string v0, "com.king.sdk.IDFEE16B42C8B2890D8FF2860AF5562B1"

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 259
    invoke-virtual {v1, p1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 260
    invoke-virtual {v1, p2}, Landroid/os/Parcel;->writeInt(I)V

    .line 261
    iget-object v0, p0, Lcom/king/sdk/h;->a:Landroid/os/IBinder;

    const/4 v3, 0x4

    const/4 v4, 0x0

    invoke-interface {v0, v3, v1, v2, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 262
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 265
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 266
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 267
    return-void

    .line 265
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 266
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method

.method public final on0D923A4B87763BA40F853B570EF75D94(II)V
    .locals 5

    .prologue
    .line 295
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 296
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 298
    :try_start_0
    const-string v0, "com.king.sdk.IDFEE16B42C8B2890D8FF2860AF5562B1"

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 299
    invoke-virtual {v1, p1}, Landroid/os/Parcel;->writeInt(I)V

    .line 300
    invoke-virtual {v1, p2}, Landroid/os/Parcel;->writeInt(I)V

    .line 301
    iget-object v0, p0, Lcom/king/sdk/h;->a:Landroid/os/IBinder;

    const/4 v3, 0x6

    const/4 v4, 0x0

    invoke-interface {v0, v3, v1, v2, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 302
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 305
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 306
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 307
    return-void

    .line 305
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 306
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method

.method public final on19C45B0F9674B131C4BF67981B1CC455(Ljava/lang/String;I)V
    .locals 5

    .prologue
    .line 314
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 315
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 317
    :try_start_0
    const-string v0, "com.king.sdk.IDFEE16B42C8B2890D8FF2860AF5562B1"

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 318
    invoke-virtual {v1, p1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 319
    invoke-virtual {v1, p2}, Landroid/os/Parcel;->writeInt(I)V

    .line 320
    iget-object v0, p0, Lcom/king/sdk/h;->a:Landroid/os/IBinder;

    const/4 v3, 0x7

    const/4 v4, 0x0

    invoke-interface {v0, v3, v1, v2, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 321
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 324
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 325
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 326
    return-void

    .line 324
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 325
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method

.method public final on1DC022CD78BE5580705D060873AAEB16(Landroid/content/Intent;)Z
    .locals 7

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 352
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 353
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v3

    .line 356
    :try_start_0
    const-string v4, "com.king.sdk.IDFEE16B42C8B2890D8FF2860AF5562B1"

    invoke-virtual {v2, v4}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 357
    if-eqz p1, :cond_1

    .line 358
    const/4 v4, 0x1

    invoke-virtual {v2, v4}, Landroid/os/Parcel;->writeInt(I)V

    .line 359
    const/4 v4, 0x0

    invoke-virtual {p1, v2, v4}, Landroid/content/Intent;->writeToParcel(Landroid/os/Parcel;I)V

    .line 364
    :goto_0
    iget-object v4, p0, Lcom/king/sdk/h;->a:Landroid/os/IBinder;

    const/16 v5, 0x9

    const/4 v6, 0x0

    invoke-interface {v4, v5, v2, v3, v6}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 365
    invoke-virtual {v3}, Landroid/os/Parcel;->readException()V

    .line 366
    invoke-virtual {v3}, Landroid/os/Parcel;->readInt()I

    move-result v4

    if-eqz v4, :cond_2

    .line 367
    :goto_1
    invoke-virtual {v3}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_0

    .line 368
    invoke-virtual {p1, v3}, Landroid/content/Intent;->readFromParcel(Landroid/os/Parcel;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 372
    :cond_0
    invoke-virtual {v3}, Landroid/os/Parcel;->recycle()V

    .line 373
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 375
    return v0

    .line 362
    :cond_1
    const/4 v4, 0x0

    :try_start_1
    invoke-virtual {v2, v4}, Landroid/os/Parcel;->writeInt(I)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 372
    :catchall_0
    move-exception v0

    invoke-virtual {v3}, Landroid/os/Parcel;->recycle()V

    .line 373
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    throw v0

    :cond_2
    move v0, v1

    .line 366
    goto :goto_1
.end method

.method public final on369D7B24CF0870337D9962B9BB11E924()V
    .locals 5

    .prologue
    .line 238
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 239
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 241
    :try_start_0
    const-string v0, "com.king.sdk.IDFEE16B42C8B2890D8FF2860AF5562B1"

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 242
    iget-object v0, p0, Lcom/king/sdk/h;->a:Landroid/os/IBinder;

    const/4 v3, 0x3

    const/4 v4, 0x0

    invoke-interface {v0, v3, v1, v2, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 243
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 246
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 247
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 248
    return-void

    .line 246
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 247
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method

.method public final on46FE18C9ADFE18C2BC0D43B003F41A66(Ljava/lang/String;Z)V
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 219
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 220
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 222
    :try_start_0
    const-string v3, "com.king.sdk.IDFEE16B42C8B2890D8FF2860AF5562B1"

    invoke-virtual {v1, v3}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 223
    invoke-virtual {v1, p1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 224
    if-eqz p2, :cond_0

    const/4 v0, 0x1

    :cond_0
    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 225
    iget-object v0, p0, Lcom/king/sdk/h;->a:Landroid/os/IBinder;

    const/4 v3, 0x2

    const/4 v4, 0x0

    invoke-interface {v0, v3, v1, v2, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 226
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 229
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 230
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 231
    return-void

    .line 229
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 230
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method

.method public final on96EC25C9716D6EFFB8DD7648F16E4FA2(Landroid/content/Intent;)Z
    .locals 7

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 189
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 190
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v3

    .line 193
    :try_start_0
    const-string v4, "com.king.sdk.IDFEE16B42C8B2890D8FF2860AF5562B1"

    invoke-virtual {v2, v4}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 194
    if-eqz p1, :cond_1

    .line 195
    const/4 v4, 0x1

    invoke-virtual {v2, v4}, Landroid/os/Parcel;->writeInt(I)V

    .line 196
    const/4 v4, 0x0

    invoke-virtual {p1, v2, v4}, Landroid/content/Intent;->writeToParcel(Landroid/os/Parcel;I)V

    .line 201
    :goto_0
    iget-object v4, p0, Lcom/king/sdk/h;->a:Landroid/os/IBinder;

    const/4 v5, 0x1

    const/4 v6, 0x0

    invoke-interface {v4, v5, v2, v3, v6}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 202
    invoke-virtual {v3}, Landroid/os/Parcel;->readException()V

    .line 203
    invoke-virtual {v3}, Landroid/os/Parcel;->readInt()I

    move-result v4

    if-eqz v4, :cond_2

    .line 204
    :goto_1
    invoke-virtual {v3}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_0

    .line 205
    invoke-virtual {p1, v3}, Landroid/content/Intent;->readFromParcel(Landroid/os/Parcel;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 209
    :cond_0
    invoke-virtual {v3}, Landroid/os/Parcel;->recycle()V

    .line 210
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 212
    return v0

    .line 199
    :cond_1
    const/4 v4, 0x0

    :try_start_1
    invoke-virtual {v2, v4}, Landroid/os/Parcel;->writeInt(I)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 209
    :catchall_0
    move-exception v0

    invoke-virtual {v3}, Landroid/os/Parcel;->recycle()V

    .line 210
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    throw v0

    :cond_2
    move v0, v1

    .line 203
    goto :goto_1
.end method

.method public final onACF4B25418AE4E2D8376A85BD6F0FC17(Ljava/lang/String;Ljava/lang/String;)V
    .locals 5

    .prologue
    .line 333
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 334
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 336
    :try_start_0
    const-string v0, "com.king.sdk.IDFEE16B42C8B2890D8FF2860AF5562B1"

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 337
    invoke-virtual {v1, p1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 338
    invoke-virtual {v1, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 339
    iget-object v0, p0, Lcom/king/sdk/h;->a:Landroid/os/IBinder;

    const/16 v3, 0x8

    const/4 v4, 0x0

    invoke-interface {v0, v3, v1, v2, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 340
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 343
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 344
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 345
    return-void

    .line 343
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 344
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method

.method public final onB9504A9B1263E0D14DFE18C2167427BC(Ljava/lang/String;Ljava/lang/String;II)V
    .locals 5

    .prologue
    .line 274
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 275
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 277
    :try_start_0
    const-string v0, "com.king.sdk.IDFEE16B42C8B2890D8FF2860AF5562B1"

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 278
    invoke-virtual {v1, p1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 279
    invoke-virtual {v1, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 280
    invoke-virtual {v1, p3}, Landroid/os/Parcel;->writeInt(I)V

    .line 281
    invoke-virtual {v1, p4}, Landroid/os/Parcel;->writeInt(I)V

    .line 282
    iget-object v0, p0, Lcom/king/sdk/h;->a:Landroid/os/IBinder;

    const/4 v3, 0x5

    const/4 v4, 0x0

    invoke-interface {v0, v3, v1, v2, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 283
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 286
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 287
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 288
    return-void

    .line 286
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 287
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method
