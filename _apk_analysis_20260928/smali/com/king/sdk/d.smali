.class final Lcom/king/sdk/d;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/king/sdk/b;


# instance fields
.field private a:Landroid/os/IBinder;


# direct methods
.method constructor <init>(Landroid/os/IBinder;)V
    .locals 0

    .prologue
    .line 432
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 433
    iput-object p1, p0, Lcom/king/sdk/d;->a:Landroid/os/IBinder;

    .line 434
    return-void
.end method


# virtual methods
.method public final a()I
    .locals 5

    .prologue
    .line 535
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 536
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 539
    :try_start_0
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 540
    iget-object v0, p0, Lcom/king/sdk/d;->a:Landroid/os/IBinder;

    const/4 v3, 0x4

    const/4 v4, 0x0

    invoke-interface {v0, v3, v1, v2, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 541
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V

    .line 542
    invoke-virtual {v2}, Landroid/os/Parcel;->readInt()I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    .line 545
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 546
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 548
    return v0

    .line 545
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 546
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method

.method public final a(Landroid/accounts/Account;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I
    .locals 5

    .prologue
    .line 475
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 476
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 479
    :try_start_0
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 480
    if-eqz p1, :cond_0

    .line 481
    const/4 v0, 0x1

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 482
    const/4 v0, 0x0

    invoke-virtual {p1, v1, v0}, Landroid/accounts/Account;->writeToParcel(Landroid/os/Parcel;I)V

    .line 487
    :goto_0
    invoke-virtual {v1, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 488
    invoke-virtual {v1, p3}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 489
    invoke-virtual {v1, p4}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 490
    iget-object v0, p0, Lcom/king/sdk/d;->a:Landroid/os/IBinder;

    const/4 v3, 0x2

    const/4 v4, 0x0

    invoke-interface {v0, v3, v1, v2, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 491
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V

    .line 492
    invoke-virtual {v2}, Landroid/os/Parcel;->readInt()I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    .line 495
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 496
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 498
    return v0

    .line 485
    :cond_0
    const/4 v0, 0x0

    :try_start_1
    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInt(I)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 495
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 496
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method

.method public final a(Ljava/lang/String;)Landroid/content/Intent;
    .locals 5

    .prologue
    .line 698
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 699
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 702
    :try_start_0
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 703
    invoke-virtual {v1, p1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 704
    iget-object v0, p0, Lcom/king/sdk/d;->a:Landroid/os/IBinder;

    const/16 v3, 0xc

    const/4 v4, 0x0

    invoke-interface {v0, v3, v1, v2, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 705
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V

    .line 706
    invoke-virtual {v2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    if-eqz v0, :cond_0

    .line 707
    sget-object v0, Landroid/content/Intent;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v0, v2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/Intent;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 714
    :goto_0
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 715
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 717
    return-object v0

    .line 710
    :cond_0
    const/4 v0, 0x0

    goto :goto_0

    .line 714
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 715
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method

.method public final a(Landroid/accounts/Account;)Ljava/lang/String;
    .locals 5

    .prologue
    .line 448
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 449
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 452
    :try_start_0
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 453
    if-eqz p1, :cond_0

    .line 454
    const/4 v0, 0x1

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 455
    const/4 v0, 0x0

    invoke-virtual {p1, v1, v0}, Landroid/accounts/Account;->writeToParcel(Landroid/os/Parcel;I)V

    .line 460
    :goto_0
    iget-object v0, p0, Lcom/king/sdk/d;->a:Landroid/os/IBinder;

    const/4 v3, 0x1

    const/4 v4, 0x0

    invoke-interface {v0, v3, v1, v2, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 461
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V

    .line 462
    invoke-virtual {v2}, Landroid/os/Parcel;->readString()Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 465
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 466
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 468
    return-object v0

    .line 458
    :cond_0
    const/4 v0, 0x0

    :try_start_1
    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInt(I)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 465
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 466
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method

.method public final a(I)V
    .locals 5

    .prologue
    .line 680
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 681
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 683
    :try_start_0
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 684
    invoke-virtual {v1, p1}, Landroid/os/Parcel;->writeInt(I)V

    .line 685
    iget-object v0, p0, Lcom/king/sdk/d;->a:Landroid/os/IBinder;

    const/16 v3, 0xb

    const/4 v4, 0x0

    invoke-interface {v0, v3, v1, v2, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 686
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 689
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 690
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 691
    return-void

    .line 689
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 690
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method

.method public final a(IILjava/lang/String;)V
    .locals 5

    .prologue
    .line 724
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 725
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 727
    :try_start_0
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 728
    invoke-virtual {v1, p1}, Landroid/os/Parcel;->writeInt(I)V

    .line 729
    invoke-virtual {v1, p2}, Landroid/os/Parcel;->writeInt(I)V

    .line 730
    invoke-virtual {v1, p3}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 731
    iget-object v0, p0, Lcom/king/sdk/d;->a:Landroid/os/IBinder;

    const/16 v3, 0xd

    const/4 v4, 0x0

    invoke-interface {v0, v3, v1, v2, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 732
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 735
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 736
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 737
    return-void

    .line 735
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 736
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method

.method public final a(Landroid/content/ComponentName;II)V
    .locals 5

    .prologue
    .line 615
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 616
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 618
    :try_start_0
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 619
    if-eqz p1, :cond_0

    .line 620
    const/4 v0, 0x1

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 621
    const/4 v0, 0x0

    invoke-virtual {p1, v1, v0}, Landroid/content/ComponentName;->writeToParcel(Landroid/os/Parcel;I)V

    .line 626
    :goto_0
    invoke-virtual {v1, p2}, Landroid/os/Parcel;->writeInt(I)V

    .line 627
    invoke-virtual {v1, p3}, Landroid/os/Parcel;->writeInt(I)V

    .line 628
    iget-object v0, p0, Lcom/king/sdk/d;->a:Landroid/os/IBinder;

    const/16 v3, 0x8

    const/4 v4, 0x0

    invoke-interface {v0, v3, v1, v2, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 629
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 632
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 633
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 634
    return-void

    .line 624
    :cond_0
    const/4 v0, 0x0

    :try_start_1
    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInt(I)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 632
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 633
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method

.method public final a(Lcom/king/sdk/IDFEE16B42C8B2890D8FF2860AF5562B1;)V
    .locals 5

    .prologue
    .line 905
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 906
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 908
    :try_start_0
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 909
    if-eqz p1, :cond_0

    invoke-interface {p1}, Lcom/king/sdk/IDFEE16B42C8B2890D8FF2860AF5562B1;->asBinder()Landroid/os/IBinder;

    move-result-object v0

    :goto_0
    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeStrongBinder(Landroid/os/IBinder;)V

    .line 910
    iget-object v0, p0, Lcom/king/sdk/d;->a:Landroid/os/IBinder;

    const/16 v3, 0x16

    const/4 v4, 0x0

    invoke-interface {v0, v3, v1, v2, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 911
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 914
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 915
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 916
    return-void

    .line 909
    :cond_0
    const/4 v0, 0x0

    goto :goto_0

    .line 914
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 915
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method

.method public final a(Ljava/lang/String;II)V
    .locals 5

    .prologue
    .line 595
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 596
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 598
    :try_start_0
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 599
    invoke-virtual {v1, p1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 600
    invoke-virtual {v1, p2}, Landroid/os/Parcel;->writeInt(I)V

    .line 601
    invoke-virtual {v1, p3}, Landroid/os/Parcel;->writeInt(I)V

    .line 602
    iget-object v0, p0, Lcom/king/sdk/d;->a:Landroid/os/IBinder;

    const/4 v3, 0x7

    const/4 v4, 0x0

    invoke-interface {v0, v3, v1, v2, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 603
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 606
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 607
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 608
    return-void

    .line 606
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 607
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method

.method public final a(Ljava/lang/String;ILjava/lang/String;Landroid/app/Notification;)V
    .locals 5

    .prologue
    .line 941
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 942
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 944
    :try_start_0
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 945
    invoke-virtual {v1, p1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 946
    invoke-virtual {v1, p2}, Landroid/os/Parcel;->writeInt(I)V

    .line 947
    invoke-virtual {v1, p3}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 948
    if-eqz p4, :cond_0

    .line 949
    const/4 v0, 0x1

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 950
    const/4 v0, 0x0

    invoke-virtual {p4, v1, v0}, Landroid/app/Notification;->writeToParcel(Landroid/os/Parcel;I)V

    .line 955
    :goto_0
    iget-object v0, p0, Lcom/king/sdk/d;->a:Landroid/os/IBinder;

    const/16 v3, 0x18

    const/4 v4, 0x0

    invoke-interface {v0, v3, v1, v2, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 956
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 959
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 960
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 961
    return-void

    .line 953
    :cond_0
    const/4 v0, 0x0

    :try_start_1
    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInt(I)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 959
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 960
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method

.method public final a(Ljava/lang/String;Landroid/os/IBinder;I)V
    .locals 5

    .prologue
    .line 575
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 576
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 578
    :try_start_0
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 579
    invoke-virtual {v1, p1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 580
    invoke-virtual {v1, p2}, Landroid/os/Parcel;->writeStrongBinder(Landroid/os/IBinder;)V

    .line 581
    invoke-virtual {v1, p3}, Landroid/os/Parcel;->writeInt(I)V

    .line 582
    iget-object v0, p0, Lcom/king/sdk/d;->a:Landroid/os/IBinder;

    const/4 v3, 0x6

    const/4 v4, 0x0

    invoke-interface {v0, v3, v1, v2, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 583
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 586
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 587
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 588
    return-void

    .line 586
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 587
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method

.method public final a(Ljava/lang/String;Ljava/lang/String;I)V
    .locals 5

    .prologue
    .line 555
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 556
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 558
    :try_start_0
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 559
    invoke-virtual {v1, p1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 560
    invoke-virtual {v1, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 561
    invoke-virtual {v1, p3}, Landroid/os/Parcel;->writeInt(I)V

    .line 562
    iget-object v0, p0, Lcom/king/sdk/d;->a:Landroid/os/IBinder;

    const/4 v3, 0x5

    const/4 v4, 0x0

    invoke-interface {v0, v3, v1, v2, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 563
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 566
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 567
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 568
    return-void

    .line 566
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 567
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method

.method public final a(Ljava/lang/String;Z)V
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 641
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 642
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 644
    :try_start_0
    const-string v3, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {v1, v3}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 645
    invoke-virtual {v1, p1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 646
    if-eqz p2, :cond_0

    const/4 v0, 0x1

    :cond_0
    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 647
    iget-object v0, p0, Lcom/king/sdk/d;->a:Landroid/os/IBinder;

    const/16 v3, 0x9

    const/4 v4, 0x0

    invoke-interface {v0, v3, v1, v2, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 648
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 651
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 652
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 653
    return-void

    .line 651
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 652
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method

.method public final a([Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;)V
    .locals 5

    .prologue
    .line 823
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 824
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 826
    :try_start_0
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 827
    invoke-virtual {v1, p1}, Landroid/os/Parcel;->writeStringArray([Ljava/lang/String;)V

    .line 828
    invoke-virtual {v1, p2}, Landroid/os/Parcel;->writeInt(I)V

    .line 829
    invoke-virtual {v1, p3}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 830
    invoke-virtual {v1, p4}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 831
    iget-object v0, p0, Lcom/king/sdk/d;->a:Landroid/os/IBinder;

    const/16 v3, 0x12

    const/4 v4, 0x0

    invoke-interface {v0, v3, v1, v2, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 832
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 835
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 836
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 837
    return-void

    .line 835
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 836
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method

.method public final a(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 6

    .prologue
    const/4 v0, 0x0

    .line 1043
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 1044
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 1047
    :try_start_0
    const-string v3, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {v1, v3}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 1048
    invoke-virtual {v1, p1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 1049
    invoke-virtual {v1, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 1050
    iget-object v3, p0, Lcom/king/sdk/d;->a:Landroid/os/IBinder;

    const/16 v4, 0x1c

    const/4 v5, 0x0

    invoke-interface {v3, v4, v1, v2, v5}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 1051
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V

    .line 1052
    invoke-virtual {v2}, Landroid/os/Parcel;->readInt()I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v3

    if-eqz v3, :cond_0

    const/4 v0, 0x1

    .line 1055
    :cond_0
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 1056
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 1058
    return v0

    .line 1055
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 1056
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method

.method public final a(Ljava/lang/String;Ljava/lang/String;I[BLandroid/app/PendingIntent;Landroid/app/PendingIntent;)Z
    .locals 7

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 1065
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 1066
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v3

    .line 1069
    :try_start_0
    const-string v4, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {v2, v4}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 1070
    invoke-virtual {v2, p1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 1071
    invoke-virtual {v2, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 1072
    invoke-virtual {v2, p3}, Landroid/os/Parcel;->writeInt(I)V

    .line 1073
    invoke-virtual {v2, p4}, Landroid/os/Parcel;->writeByteArray([B)V

    .line 1074
    if-eqz p5, :cond_0

    .line 1075
    const/4 v4, 0x1

    invoke-virtual {v2, v4}, Landroid/os/Parcel;->writeInt(I)V

    .line 1076
    const/4 v4, 0x0

    invoke-virtual {p5, v2, v4}, Landroid/app/PendingIntent;->writeToParcel(Landroid/os/Parcel;I)V

    .line 1081
    :goto_0
    if-eqz p6, :cond_1

    .line 1082
    const/4 v4, 0x1

    invoke-virtual {v2, v4}, Landroid/os/Parcel;->writeInt(I)V

    .line 1083
    const/4 v4, 0x0

    invoke-virtual {p6, v2, v4}, Landroid/app/PendingIntent;->writeToParcel(Landroid/os/Parcel;I)V

    .line 1088
    :goto_1
    iget-object v4, p0, Lcom/king/sdk/d;->a:Landroid/os/IBinder;

    const/16 v5, 0x1d

    const/4 v6, 0x0

    invoke-interface {v4, v5, v2, v3, v6}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 1089
    invoke-virtual {v3}, Landroid/os/Parcel;->readException()V

    .line 1090
    invoke-virtual {v3}, Landroid/os/Parcel;->readInt()I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v4

    if-eqz v4, :cond_2

    .line 1093
    :goto_2
    invoke-virtual {v3}, Landroid/os/Parcel;->recycle()V

    .line 1094
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 1096
    return v0

    .line 1079
    :cond_0
    const/4 v4, 0x0

    :try_start_1
    invoke-virtual {v2, v4}, Landroid/os/Parcel;->writeInt(I)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 1093
    :catchall_0
    move-exception v0

    invoke-virtual {v3}, Landroid/os/Parcel;->recycle()V

    .line 1094
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    throw v0

    .line 1086
    :cond_1
    const/4 v4, 0x0

    :try_start_2
    invoke-virtual {v2, v4}, Landroid/os/Parcel;->writeInt(I)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_1

    :cond_2
    move v0, v1

    .line 1090
    goto :goto_2
.end method

.method public final a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;)Z
    .locals 7

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 1006
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 1007
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v3

    .line 1010
    :try_start_0
    const-string v4, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {v2, v4}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 1011
    invoke-virtual {v2, p1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 1012
    invoke-virtual {v2, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 1013
    invoke-virtual {v2, p3}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 1014
    if-eqz p4, :cond_0

    .line 1015
    const/4 v4, 0x1

    invoke-virtual {v2, v4}, Landroid/os/Parcel;->writeInt(I)V

    .line 1016
    const/4 v4, 0x0

    invoke-virtual {p4, v2, v4}, Landroid/app/PendingIntent;->writeToParcel(Landroid/os/Parcel;I)V

    .line 1021
    :goto_0
    if-eqz p5, :cond_1

    .line 1022
    const/4 v4, 0x1

    invoke-virtual {v2, v4}, Landroid/os/Parcel;->writeInt(I)V

    .line 1023
    const/4 v4, 0x0

    invoke-virtual {p5, v2, v4}, Landroid/app/PendingIntent;->writeToParcel(Landroid/os/Parcel;I)V

    .line 1028
    :goto_1
    iget-object v4, p0, Lcom/king/sdk/d;->a:Landroid/os/IBinder;

    const/16 v5, 0x1b

    const/4 v6, 0x0

    invoke-interface {v4, v5, v2, v3, v6}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 1029
    invoke-virtual {v3}, Landroid/os/Parcel;->readException()V

    .line 1030
    invoke-virtual {v3}, Landroid/os/Parcel;->readInt()I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v4

    if-eqz v4, :cond_2

    .line 1033
    :goto_2
    invoke-virtual {v3}, Landroid/os/Parcel;->recycle()V

    .line 1034
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 1036
    return v0

    .line 1019
    :cond_0
    const/4 v4, 0x0

    :try_start_1
    invoke-virtual {v2, v4}, Landroid/os/Parcel;->writeInt(I)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 1033
    :catchall_0
    move-exception v0

    invoke-virtual {v3}, Landroid/os/Parcel;->recycle()V

    .line 1034
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    throw v0

    .line 1026
    :cond_1
    const/4 v4, 0x0

    :try_start_2
    invoke-virtual {v2, v4}, Landroid/os/Parcel;->writeInt(I)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_1

    :cond_2
    move v0, v1

    .line 1030
    goto :goto_2
.end method

.method public final asBinder()Landroid/os/IBinder;
    .locals 1

    .prologue
    .line 437
    iget-object v0, p0, Lcom/king/sdk/d;->a:Landroid/os/IBinder;

    return-object v0
.end method

.method public final b(Landroid/accounts/Account;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I
    .locals 5

    .prologue
    .line 505
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 506
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 509
    :try_start_0
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 510
    if-eqz p1, :cond_0

    .line 511
    const/4 v0, 0x1

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 512
    const/4 v0, 0x0

    invoke-virtual {p1, v1, v0}, Landroid/accounts/Account;->writeToParcel(Landroid/os/Parcel;I)V

    .line 517
    :goto_0
    invoke-virtual {v1, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 518
    invoke-virtual {v1, p3}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 519
    invoke-virtual {v1, p4}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 520
    iget-object v0, p0, Lcom/king/sdk/d;->a:Landroid/os/IBinder;

    const/4 v3, 0x3

    const/4 v4, 0x0

    invoke-interface {v0, v3, v1, v2, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 521
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V

    .line 522
    invoke-virtual {v2}, Landroid/os/Parcel;->readInt()I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    .line 525
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 526
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 528
    return v0

    .line 515
    :cond_0
    const/4 v0, 0x0

    :try_start_1
    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInt(I)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 525
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 526
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method

.method public final b(Ljava/lang/String;)Landroid/os/IBinder;
    .locals 5

    .prologue
    .line 744
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 745
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 748
    :try_start_0
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 749
    invoke-virtual {v1, p1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 750
    iget-object v0, p0, Lcom/king/sdk/d;->a:Landroid/os/IBinder;

    const/16 v3, 0xe

    const/4 v4, 0x0

    invoke-interface {v0, v3, v1, v2, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 751
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V

    .line 752
    invoke-virtual {v2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 755
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 756
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 758
    return-object v0

    .line 755
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 756
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method

.method public final b(Lcom/king/sdk/IDFEE16B42C8B2890D8FF2860AF5562B1;)V
    .locals 5

    .prologue
    .line 923
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 924
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 926
    :try_start_0
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 927
    if-eqz p1, :cond_0

    invoke-interface {p1}, Lcom/king/sdk/IDFEE16B42C8B2890D8FF2860AF5562B1;->asBinder()Landroid/os/IBinder;

    move-result-object v0

    :goto_0
    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeStrongBinder(Landroid/os/IBinder;)V

    .line 928
    iget-object v0, p0, Lcom/king/sdk/d;->a:Landroid/os/IBinder;

    const/16 v3, 0x17

    const/4 v4, 0x0

    invoke-interface {v0, v3, v1, v2, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 929
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 932
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 933
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 934
    return-void

    .line 927
    :cond_0
    const/4 v0, 0x0

    goto :goto_0

    .line 932
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 933
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method

.method public final b()[B
    .locals 5

    .prologue
    .line 660
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 661
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 664
    :try_start_0
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 665
    iget-object v0, p0, Lcom/king/sdk/d;->a:Landroid/os/IBinder;

    const/16 v3, 0xa

    const/4 v4, 0x0

    invoke-interface {v0, v3, v1, v2, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 666
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V

    .line 667
    invoke-virtual {v2}, Landroid/os/Parcel;->createByteArray()[B
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 670
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 671
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 673
    return-object v0

    .line 670
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 671
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method

.method public final c()Ljava/lang/String;
    .locals 5

    .prologue
    .line 783
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 784
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 787
    :try_start_0
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 788
    iget-object v0, p0, Lcom/king/sdk/d;->a:Landroid/os/IBinder;

    const/16 v3, 0x10

    const/4 v4, 0x0

    invoke-interface {v0, v3, v1, v2, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 789
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V

    .line 790
    invoke-virtual {v2}, Landroid/os/Parcel;->readString()Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 793
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 794
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 796
    return-object v0

    .line 793
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 794
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method

.method public final c(Ljava/lang/String;)V
    .locals 5

    .prologue
    .line 765
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 766
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 768
    :try_start_0
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 769
    invoke-virtual {v1, p1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 770
    iget-object v0, p0, Lcom/king/sdk/d;->a:Landroid/os/IBinder;

    const/16 v3, 0xf

    const/4 v4, 0x0

    invoke-interface {v0, v3, v1, v2, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 771
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 774
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 775
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 776
    return-void

    .line 774
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 775
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method

.method public final d()Ljava/lang/String;
    .locals 5

    .prologue
    .line 803
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 804
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 807
    :try_start_0
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 808
    iget-object v0, p0, Lcom/king/sdk/d;->a:Landroid/os/IBinder;

    const/16 v3, 0x11

    const/4 v4, 0x0

    invoke-interface {v0, v3, v1, v2, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 809
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V

    .line 810
    invoke-virtual {v2}, Landroid/os/Parcel;->readString()Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 813
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 814
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 816
    return-object v0

    .line 813
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 814
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method

.method public final d(Ljava/lang/String;)Z
    .locals 6

    .prologue
    const/4 v0, 0x0

    .line 884
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 885
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 888
    :try_start_0
    const-string v3, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {v1, v3}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 889
    invoke-virtual {v1, p1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 890
    iget-object v3, p0, Lcom/king/sdk/d;->a:Landroid/os/IBinder;

    const/16 v4, 0x15

    const/4 v5, 0x0

    invoke-interface {v3, v4, v1, v2, v5}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 891
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V

    .line 892
    invoke-virtual {v2}, Landroid/os/Parcel;->readInt()I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v3

    if-eqz v3, :cond_0

    const/4 v0, 0x1

    .line 895
    :cond_0
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 896
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 898
    return v0

    .line 895
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 896
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method

.method public final e()I
    .locals 5

    .prologue
    .line 844
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 845
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 848
    :try_start_0
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 849
    iget-object v0, p0, Lcom/king/sdk/d;->a:Landroid/os/IBinder;

    const/16 v3, 0x13

    const/4 v4, 0x0

    invoke-interface {v0, v3, v1, v2, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 850
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V

    .line 851
    invoke-virtual {v2}, Landroid/os/Parcel;->readInt()I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    .line 854
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 855
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 857
    return v0

    .line 854
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 855
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method

.method public final e(Ljava/lang/String;)V
    .locals 5

    .prologue
    .line 988
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 989
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 991
    :try_start_0
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 992
    invoke-virtual {v1, p1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 993
    iget-object v0, p0, Lcom/king/sdk/d;->a:Landroid/os/IBinder;

    const/16 v3, 0x1a

    const/4 v4, 0x0

    invoke-interface {v0, v3, v1, v2, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 994
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 997
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 998
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 999
    return-void

    .line 997
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 998
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method

.method public final f()Ljava/lang/String;
    .locals 5

    .prologue
    .line 864
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 865
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 868
    :try_start_0
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 869
    iget-object v0, p0, Lcom/king/sdk/d;->a:Landroid/os/IBinder;

    const/16 v3, 0x14

    const/4 v4, 0x0

    invoke-interface {v0, v3, v1, v2, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 870
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V

    .line 871
    invoke-virtual {v2}, Landroid/os/Parcel;->readString()Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 874
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 875
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 877
    return-object v0

    .line 874
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 875
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method

.method public final g()Ljava/lang/String;
    .locals 5

    .prologue
    .line 968
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 969
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 972
    :try_start_0
    const-string v0, "com.king.sdk.I2FABB9840C76199A1E170A7C19698595"

    invoke-virtual {v1, v0}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 973
    iget-object v0, p0, Lcom/king/sdk/d;->a:Landroid/os/IBinder;

    const/16 v3, 0x19

    const/4 v4, 0x0

    invoke-interface {v0, v3, v1, v2, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 974
    invoke-virtual {v2}, Landroid/os/Parcel;->readException()V

    .line 975
    invoke-virtual {v2}, Landroid/os/Parcel;->readString()Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 978
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 979
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 981
    return-object v0

    .line 978
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 979
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v0
.end method
