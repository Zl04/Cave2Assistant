.class public Lcom/umeng/commonsdk/proguard/u;
.super Ljava/lang/Object;
.source "UMUdpSender.java"


# static fields
.field private static a:Ljava/lang/String;

.field private static b:I


# instance fields
.field private c:Landroid/net/wifi/WifiManager$MulticastLock;

.field private d:Landroid/net/wifi/WifiManager;

.field private e:Landroid/content/Context;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 19
    const-string v0, "239.192.152.163"

    sput-object v0, Lcom/umeng/commonsdk/proguard/u;->a:Ljava/lang/String;

    .line 21
    const v0, 0xbea9

    sput v0, Lcom/umeng/commonsdk/proguard/u;->b:I

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 2

    .prologue
    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 28
    if-eqz p1, :cond_0

    .line 29
    iput-object p1, p0, Lcom/umeng/commonsdk/proguard/u;->e:Landroid/content/Context;

    .line 30
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "wifi"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/wifi/WifiManager;

    iput-object v0, p0, Lcom/umeng/commonsdk/proguard/u;->d:Landroid/net/wifi/WifiManager;

    .line 32
    :cond_0
    return-void
.end method

.method private a()V
    .locals 2

    .prologue
    .line 91
    :try_start_0
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/u;->d:Landroid/net/wifi/WifiManager;

    if-eqz v0, :cond_0

    .line 92
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/u;->d:Landroid/net/wifi/WifiManager;

    const-string v1, "multicast.test"

    invoke-virtual {v0, v1}, Landroid/net/wifi/WifiManager;->createMulticastLock(Ljava/lang/String;)Landroid/net/wifi/WifiManager$MulticastLock;

    move-result-object v0

    iput-object v0, p0, Lcom/umeng/commonsdk/proguard/u;->c:Landroid/net/wifi/WifiManager$MulticastLock;

    .line 93
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/u;->c:Landroid/net/wifi/WifiManager$MulticastLock;

    if-eqz v0, :cond_0

    .line 94
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/u;->c:Landroid/net/wifi/WifiManager$MulticastLock;

    invoke-virtual {v0}, Landroid/net/wifi/WifiManager$MulticastLock;->acquire()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 100
    :cond_0
    :goto_0
    return-void

    .line 97
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public static a(Landroid/content/Context;)V
    .locals 2

    .prologue
    .line 119
    invoke-static {p0}, Lcom/umeng/commonsdk/UMConfigure;->getUMIDString(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 120
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 121
    invoke-static {p0, v0}, Lcom/umeng/commonsdk/proguard/u;->a(Landroid/content/Context;Ljava/lang/String;)V

    .line 123
    :cond_0
    return-void
.end method

.method private static a(Landroid/content/Context;Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 115
    sget-object v0, Lcom/umeng/commonsdk/proguard/u;->a:Ljava/lang/String;

    sget v1, Lcom/umeng/commonsdk/proguard/u;->b:I

    invoke-static {p0, v0, v1, p1}, Lcom/umeng/commonsdk/proguard/u;->a(Landroid/content/Context;Ljava/lang/String;ILjava/lang/String;)V

    .line 116
    return-void
.end method

.method private static a(Landroid/content/Context;Ljava/lang/String;ILjava/lang/String;)V
    .locals 1

    .prologue
    .line 109
    new-instance v0, Lcom/umeng/commonsdk/proguard/u;

    invoke-direct {v0, p0}, Lcom/umeng/commonsdk/proguard/u;-><init>(Landroid/content/Context;)V

    .line 110
    invoke-virtual {v0, p1, p2, p3}, Lcom/umeng/commonsdk/proguard/u;->a(Ljava/lang/String;ILjava/lang/String;)V

    .line 112
    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;ILjava/lang/String;)V
    .locals 5

    .prologue
    .line 59
    invoke-direct {p0}, Lcom/umeng/commonsdk/proguard/u;->a()V

    .line 60
    const/4 v2, 0x0

    .line 62
    :try_start_0
    new-instance v1, Ljava/net/MulticastSocket;

    invoke-direct {v1, p2}, Ljava/net/MulticastSocket;-><init>(I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 63
    :try_start_1
    invoke-static {p1}, Ljava/net/InetAddress;->getByName(Ljava/lang/String;)Ljava/net/InetAddress;

    move-result-object v0

    .line 64
    invoke-virtual {v1, v0}, Ljava/net/MulticastSocket;->joinGroup(Ljava/net/InetAddress;)V

    .line 65
    const/4 v0, 0x1

    invoke-virtual {v1, v0}, Ljava/net/MulticastSocket;->setLoopbackMode(Z)V

    .line 66
    new-instance v0, Ljava/net/DatagramPacket;

    invoke-virtual {p3}, Ljava/lang/String;->getBytes()[B

    move-result-object v2

    invoke-virtual {p3}, Ljava/lang/String;->getBytes()[B

    move-result-object v3

    array-length v3, v3

    .line 67
    invoke-static {p1}, Ljava/net/InetAddress;->getByName(Ljava/lang/String;)Ljava/net/InetAddress;

    move-result-object v4

    invoke-direct {v0, v2, v3, v4, p2}, Ljava/net/DatagramPacket;-><init>([BILjava/net/InetAddress;I)V

    .line 68
    invoke-virtual {v1, v0}, Ljava/net/MulticastSocket;->send(Ljava/net/DatagramPacket;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_6
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 73
    if-eqz v1, :cond_0

    .line 74
    :try_start_2
    invoke-virtual {v1}, Ljava/net/MulticastSocket;->close()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    .line 80
    :cond_0
    :goto_0
    :try_start_3
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/u;->c:Landroid/net/wifi/WifiManager$MulticastLock;

    if-eqz v0, :cond_1

    .line 81
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/u;->c:Landroid/net/wifi/WifiManager$MulticastLock;

    invoke-virtual {v0}, Landroid/net/wifi/WifiManager$MulticastLock;->release()V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_7

    .line 87
    :cond_1
    :goto_1
    return-void

    .line 76
    :catch_0
    move-exception v0

    .line 77
    iget-object v1, p0, Lcom/umeng/commonsdk/proguard/u;->e:Landroid/content/Context;

    invoke-static {v1, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_0

    .line 69
    :catch_1
    move-exception v0

    move-object v1, v2

    .line 70
    :goto_2
    :try_start_4
    iget-object v2, p0, Lcom/umeng/commonsdk/proguard/u;->e:Landroid/content/Context;

    invoke-static {v2, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    .line 73
    if-eqz v1, :cond_2

    .line 74
    :try_start_5
    invoke-virtual {v1}, Ljava/net/MulticastSocket;->close()V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_3

    .line 80
    :cond_2
    :goto_3
    :try_start_6
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/u;->c:Landroid/net/wifi/WifiManager$MulticastLock;

    if-eqz v0, :cond_1

    .line 81
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/u;->c:Landroid/net/wifi/WifiManager$MulticastLock;

    invoke-virtual {v0}, Landroid/net/wifi/WifiManager$MulticastLock;->release()V
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_2

    goto :goto_1

    .line 83
    :catch_2
    move-exception v0

    goto :goto_1

    .line 76
    :catch_3
    move-exception v0

    .line 77
    iget-object v1, p0, Lcom/umeng/commonsdk/proguard/u;->e:Landroid/content/Context;

    invoke-static {v1, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_3

    .line 72
    :catchall_0
    move-exception v0

    move-object v1, v2

    .line 73
    :goto_4
    if-eqz v1, :cond_3

    .line 74
    :try_start_7
    invoke-virtual {v1}, Ljava/net/MulticastSocket;->close()V
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_4

    .line 80
    :cond_3
    :goto_5
    :try_start_8
    iget-object v1, p0, Lcom/umeng/commonsdk/proguard/u;->c:Landroid/net/wifi/WifiManager$MulticastLock;

    if-eqz v1, :cond_4

    .line 81
    iget-object v1, p0, Lcom/umeng/commonsdk/proguard/u;->c:Landroid/net/wifi/WifiManager$MulticastLock;

    invoke-virtual {v1}, Landroid/net/wifi/WifiManager$MulticastLock;->release()V
    :try_end_8
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_5

    .line 85
    :cond_4
    :goto_6
    throw v0

    .line 76
    :catch_4
    move-exception v1

    .line 77
    iget-object v2, p0, Lcom/umeng/commonsdk/proguard/u;->e:Landroid/content/Context;

    invoke-static {v2, v1}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_5

    .line 83
    :catch_5
    move-exception v1

    goto :goto_6

    .line 72
    :catchall_1
    move-exception v0

    goto :goto_4

    .line 69
    :catch_6
    move-exception v0

    goto :goto_2

    .line 83
    :catch_7
    move-exception v0

    goto :goto_1
.end method
