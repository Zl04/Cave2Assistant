.class public abstract Lcom/kaopu/download/kernel/IDownloadService$Stub;
.super Landroid/os/Binder;
.source "IDownloadService.java"

# interfaces
.implements Lcom/kaopu/download/kernel/IDownloadService;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/kaopu/download/kernel/IDownloadService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Stub"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/kaopu/download/kernel/IDownloadService$Stub$Proxy;
    }
.end annotation


# static fields
.field private static final DESCRIPTOR:Ljava/lang/String; = "com.kaopu.download.kernel.IDownloadService"

.field static final TRANSACTION_addNewDownloadTask:I = 0x1

.field static final TRANSACTION_cancelDownloadTask:I = 0x3

.field static final TRANSACTION_clearAllDownloadTask:I = 0x5

.field static final TRANSACTION_continueDownload:I = 0x9

.field static final TRANSACTION_getDownloadInfo:I = 0x8

.field static final TRANSACTION_getDownloadInfos:I = 0x6

.field static final TRANSACTION_getTaskCount:I = 0x7

.field static final TRANSACTION_isServiceAlive:I = 0x4

.field static final TRANSACTION_pauseDownloadTask:I = 0x2


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 13
    invoke-direct {p0}, Landroid/os/Binder;-><init>()V

    .line 15
    const-string v0, "com.kaopu.download.kernel.IDownloadService"

    invoke-virtual {p0, p0, v0}, Lcom/kaopu/download/kernel/IDownloadService$Stub;->attachInterface(Landroid/os/IInterface;Ljava/lang/String;)V

    .line 16
    return-void
.end method

.method public static asInterface(Landroid/os/IBinder;)Lcom/kaopu/download/kernel/IDownloadService;
    .locals 2
    .param p0, "obj"    # Landroid/os/IBinder;

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
    const-string v1, "com.kaopu.download.kernel.IDownloadService"

    invoke-interface {p0, v1}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object v0

    .line 27
    .local v0, "iin":Landroid/os/IInterface;
    if-eqz v0, :cond_1

    instance-of v1, v0, Lcom/kaopu/download/kernel/IDownloadService;

    if-eqz v1, :cond_1

    .line 28
    check-cast v0, Lcom/kaopu/download/kernel/IDownloadService;

    goto :goto_0

    .line 30
    :cond_1
    new-instance v0, Lcom/kaopu/download/kernel/IDownloadService$Stub$Proxy;

    .end local v0    # "iin":Landroid/os/IInterface;
    invoke-direct {v0, p0}, Lcom/kaopu/download/kernel/IDownloadService$Stub$Proxy;-><init>(Landroid/os/IBinder;)V

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
    .locals 6
    .param p1, "code"    # I
    .param p2, "data"    # Landroid/os/Parcel;
    .param p3, "reply"    # Landroid/os/Parcel;
    .param p4, "flags"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v3, 0x0

    const/4 v4, 0x1

    .line 38
    sparse-switch p1, :sswitch_data_0

    .line 131
    invoke-super {p0, p1, p2, p3, p4}, Landroid/os/Binder;->onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    move-result v4

    :goto_0
    return v4

    .line 42
    :sswitch_0
    const-string v3, "com.kaopu.download.kernel.IDownloadService"

    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto :goto_0

    .line 47
    :sswitch_1
    const-string v5, "com.kaopu.download.kernel.IDownloadService"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 49
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v2

    .line 50
    .local v2, "cl":Ljava/lang/ClassLoader;
    invoke-virtual {p2, v2}, Landroid/os/Parcel;->readHashMap(Ljava/lang/ClassLoader;)Ljava/util/HashMap;

    move-result-object v0

    .line 51
    .local v0, "_arg0":Ljava/util/Map;
    invoke-virtual {p0, v0}, Lcom/kaopu/download/kernel/IDownloadService$Stub;->addNewDownloadTask(Ljava/util/Map;)Z

    move-result v1

    .line 52
    .local v1, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 53
    if-eqz v1, :cond_0

    move v3, v4

    :cond_0
    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_0

    .line 58
    .end local v0    # "_arg0":Ljava/util/Map;
    .end local v1    # "_result":Z
    .end local v2    # "cl":Ljava/lang/ClassLoader;
    :sswitch_2
    const-string v5, "com.kaopu.download.kernel.IDownloadService"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 60
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v2

    .line 61
    .restart local v2    # "cl":Ljava/lang/ClassLoader;
    invoke-virtual {p2, v2}, Landroid/os/Parcel;->readHashMap(Ljava/lang/ClassLoader;)Ljava/util/HashMap;

    move-result-object v0

    .line 62
    .restart local v0    # "_arg0":Ljava/util/Map;
    invoke-virtual {p0, v0}, Lcom/kaopu/download/kernel/IDownloadService$Stub;->pauseDownloadTask(Ljava/util/Map;)Z

    move-result v1

    .line 63
    .restart local v1    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 64
    if-eqz v1, :cond_1

    move v3, v4

    :cond_1
    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_0

    .line 69
    .end local v0    # "_arg0":Ljava/util/Map;
    .end local v1    # "_result":Z
    .end local v2    # "cl":Ljava/lang/ClassLoader;
    :sswitch_3
    const-string v5, "com.kaopu.download.kernel.IDownloadService"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 71
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v2

    .line 72
    .restart local v2    # "cl":Ljava/lang/ClassLoader;
    invoke-virtual {p2, v2}, Landroid/os/Parcel;->readHashMap(Ljava/lang/ClassLoader;)Ljava/util/HashMap;

    move-result-object v0

    .line 73
    .restart local v0    # "_arg0":Ljava/util/Map;
    invoke-virtual {p0, v0}, Lcom/kaopu/download/kernel/IDownloadService$Stub;->cancelDownloadTask(Ljava/util/Map;)Z

    move-result v1

    .line 74
    .restart local v1    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 75
    if-eqz v1, :cond_2

    move v3, v4

    :cond_2
    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_0

    .line 80
    .end local v0    # "_arg0":Ljava/util/Map;
    .end local v1    # "_result":Z
    .end local v2    # "cl":Ljava/lang/ClassLoader;
    :sswitch_4
    const-string v5, "com.kaopu.download.kernel.IDownloadService"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 81
    invoke-virtual {p0}, Lcom/kaopu/download/kernel/IDownloadService$Stub;->isServiceAlive()Z

    move-result v1

    .line 82
    .restart local v1    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 83
    if-eqz v1, :cond_3

    move v3, v4

    :cond_3
    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_0

    .line 88
    .end local v1    # "_result":Z
    :sswitch_5
    const-string v3, "com.kaopu.download.kernel.IDownloadService"

    invoke-virtual {p2, v3}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 89
    invoke-virtual {p0}, Lcom/kaopu/download/kernel/IDownloadService$Stub;->clearAllDownloadTask()V

    .line 90
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 95
    :sswitch_6
    const-string v3, "com.kaopu.download.kernel.IDownloadService"

    invoke-virtual {p2, v3}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 96
    invoke-virtual {p0}, Lcom/kaopu/download/kernel/IDownloadService$Stub;->getDownloadInfos()Ljava/util/Map;

    move-result-object v1

    .line 97
    .local v1, "_result":Ljava/util/Map;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 98
    invoke-virtual {p3, v1}, Landroid/os/Parcel;->writeMap(Ljava/util/Map;)V

    goto/16 :goto_0

    .line 103
    .end local v1    # "_result":Ljava/util/Map;
    :sswitch_7
    const-string v3, "com.kaopu.download.kernel.IDownloadService"

    invoke-virtual {p2, v3}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 104
    invoke-virtual {p0}, Lcom/kaopu/download/kernel/IDownloadService$Stub;->getTaskCount()I

    move-result v1

    .line 105
    .local v1, "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 106
    invoke-virtual {p3, v1}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 111
    .end local v1    # "_result":I
    :sswitch_8
    const-string v3, "com.kaopu.download.kernel.IDownloadService"

    invoke-virtual {p2, v3}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 113
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    .line 114
    .local v0, "_arg0":Ljava/lang/String;
    invoke-virtual {p0, v0}, Lcom/kaopu/download/kernel/IDownloadService$Stub;->getDownloadInfo(Ljava/lang/String;)Ljava/util/Map;

    move-result-object v1

    .line 115
    .local v1, "_result":Ljava/util/Map;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 116
    invoke-virtual {p3, v1}, Landroid/os/Parcel;->writeMap(Ljava/util/Map;)V

    goto/16 :goto_0

    .line 121
    .end local v0    # "_arg0":Ljava/lang/String;
    .end local v1    # "_result":Ljava/util/Map;
    :sswitch_9
    const-string v5, "com.kaopu.download.kernel.IDownloadService"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 123
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v2

    .line 124
    .restart local v2    # "cl":Ljava/lang/ClassLoader;
    invoke-virtual {p2, v2}, Landroid/os/Parcel;->readHashMap(Ljava/lang/ClassLoader;)Ljava/util/HashMap;

    move-result-object v0

    .line 125
    .local v0, "_arg0":Ljava/util/Map;
    invoke-virtual {p0, v0}, Lcom/kaopu/download/kernel/IDownloadService$Stub;->continueDownload(Ljava/util/Map;)Z

    move-result v1

    .line 126
    .local v1, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 127
    if-eqz v1, :cond_4

    move v3, v4

    :cond_4
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
