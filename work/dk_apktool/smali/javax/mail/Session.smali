.class public final Ljavax/mail/Session;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static defaultSession:Ljavax/mail/Session;


# instance fields
.field private final addressMap:Ljava/util/Properties;

.field private final authTable:Ljava/util/Hashtable;

.field private final authenticator:Ljavax/mail/Authenticator;

.field private debug:Z

.field private out:Ljava/io/PrintStream;

.field private final props:Ljava/util/Properties;

.field private final providers:Ljava/util/Vector;

.field private final providersByClassName:Ljava/util/Hashtable;

.field private final providersByProtocol:Ljava/util/Hashtable;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 200
    const/4 v0, 0x0

    sput-object v0, Ljavax/mail/Session;->defaultSession:Ljavax/mail/Session;

    .line 187
    return-void
.end method

.method private constructor <init>(Ljava/util/Properties;Ljavax/mail/Authenticator;)V
    .locals 1

    .prologue
    .line 203
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 191
    new-instance v0, Ljava/util/Hashtable;

    invoke-direct {v0}, Ljava/util/Hashtable;-><init>()V

    iput-object v0, p0, Ljavax/mail/Session;->authTable:Ljava/util/Hashtable;

    .line 192
    const/4 v0, 0x0

    iput-boolean v0, p0, Ljavax/mail/Session;->debug:Z

    .line 194
    new-instance v0, Ljava/util/Vector;

    invoke-direct {v0}, Ljava/util/Vector;-><init>()V

    iput-object v0, p0, Ljavax/mail/Session;->providers:Ljava/util/Vector;

    .line 195
    new-instance v0, Ljava/util/Hashtable;

    invoke-direct {v0}, Ljava/util/Hashtable;-><init>()V

    iput-object v0, p0, Ljavax/mail/Session;->providersByProtocol:Ljava/util/Hashtable;

    .line 196
    new-instance v0, Ljava/util/Hashtable;

    invoke-direct {v0}, Ljava/util/Hashtable;-><init>()V

    iput-object v0, p0, Ljavax/mail/Session;->providersByClassName:Ljava/util/Hashtable;

    .line 197
    new-instance v0, Ljava/util/Properties;

    invoke-direct {v0}, Ljava/util/Properties;-><init>()V

    iput-object v0, p0, Ljavax/mail/Session;->addressMap:Ljava/util/Properties;

    .line 204
    iput-object p1, p0, Ljavax/mail/Session;->props:Ljava/util/Properties;

    .line 205
    iput-object p2, p0, Ljavax/mail/Session;->authenticator:Ljavax/mail/Authenticator;

    .line 207
    const-string v0, "mail.debug"

    invoke-virtual {p1, v0}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 208
    const/4 v0, 0x1

    iput-boolean v0, p0, Ljavax/mail/Session;->debug:Z

    .line 210
    :cond_0
    iget-boolean v0, p0, Ljavax/mail/Session;->debug:Z

    if-eqz v0, :cond_1

    .line 211
    const-string v0, "DEBUG: JavaMail version 1.4.1"

    invoke-direct {p0, v0}, Ljavax/mail/Session;->pr(Ljava/lang/String;)V

    .line 215
    :cond_1
    if-eqz p2, :cond_2

    .line 216
    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    .line 220
    :goto_0
    invoke-direct {p0, v0}, Ljavax/mail/Session;->loadProviders(Ljava/lang/Class;)V

    .line 221
    invoke-direct {p0, v0}, Ljavax/mail/Session;->loadAddressMap(Ljava/lang/Class;)V

    .line 222
    return-void

    .line 218
    :cond_2
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    goto :goto_0
.end method

.method static synthetic access$0(Ljavax/mail/Session;Ljava/io/InputStream;)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 937
    invoke-direct {p0, p1}, Ljavax/mail/Session;->loadProvidersFromStream(Ljava/io/InputStream;)V

    return-void
.end method

.method static synthetic access$1(Ljavax/mail/Session;)Ljava/util/Properties;
    .locals 1

    .prologue
    .line 197
    iget-object v0, p0, Ljavax/mail/Session;->addressMap:Ljava/util/Properties;

    return-object v0
.end method

.method private static getContextClassLoader()Ljava/lang/ClassLoader;
    .locals 1

    .prologue
    .line 1187
    new-instance v0, Ljavax/mail/Session$3;

    invoke-direct {v0}, Ljavax/mail/Session$3;-><init>()V

    invoke-static {v0}, Ljava/security/AccessController;->doPrivileged(Ljava/security/PrivilegedAction;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/ClassLoader;

    .line 1186
    return-object v0
.end method

.method public static getDefaultInstance(Ljava/util/Properties;)Ljavax/mail/Session;
    .locals 1

    .prologue
    .line 349
    const/4 v0, 0x0

    invoke-static {p0, v0}, Ljavax/mail/Session;->getDefaultInstance(Ljava/util/Properties;Ljavax/mail/Authenticator;)Ljavax/mail/Session;

    move-result-object v0

    return-object v0
.end method

.method public static declared-synchronized getDefaultInstance(Ljava/util/Properties;Ljavax/mail/Authenticator;)Ljavax/mail/Session;
    .locals 3

    .prologue
    .line 308
    const-class v1, Ljavax/mail/Session;

    monitor-enter v1

    :try_start_0
    sget-object v0, Ljavax/mail/Session;->defaultSession:Ljavax/mail/Session;

    if-nez v0, :cond_1

    .line 309
    new-instance v0, Ljavax/mail/Session;

    invoke-direct {v0, p0, p1}, Ljavax/mail/Session;-><init>(Ljava/util/Properties;Ljavax/mail/Authenticator;)V

    sput-object v0, Ljavax/mail/Session;->defaultSession:Ljavax/mail/Session;

    .line 324
    :cond_0
    sget-object v0, Ljavax/mail/Session;->defaultSession:Ljavax/mail/Session;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v1

    return-object v0

    .line 312
    :cond_1
    :try_start_1
    sget-object v0, Ljavax/mail/Session;->defaultSession:Ljavax/mail/Session;

    iget-object v0, v0, Ljavax/mail/Session;->authenticator:Ljavax/mail/Authenticator;

    if-eq v0, p1, :cond_0

    .line 314
    sget-object v0, Ljavax/mail/Session;->defaultSession:Ljavax/mail/Session;

    iget-object v0, v0, Ljavax/mail/Session;->authenticator:Ljavax/mail/Authenticator;

    if-eqz v0, :cond_2

    .line 315
    if-eqz p1, :cond_2

    .line 316
    sget-object v0, Ljavax/mail/Session;->defaultSession:Ljavax/mail/Session;

    iget-object v0, v0, Ljavax/mail/Session;->authenticator:Ljavax/mail/Authenticator;

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    .line 317
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v2

    .line 316
    if-eq v0, v2, :cond_0

    .line 321
    :cond_2
    new-instance v0, Ljava/lang/SecurityException;

    const-string v2, "Access to default session denied"

    invoke-direct {v0, v2}, Ljava/lang/SecurityException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 308
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method public static getInstance(Ljava/util/Properties;)Ljavax/mail/Session;
    .locals 2

    .prologue
    .line 259
    new-instance v0, Ljavax/mail/Session;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Ljavax/mail/Session;-><init>(Ljava/util/Properties;Ljavax/mail/Authenticator;)V

    return-object v0
.end method

.method public static getInstance(Ljava/util/Properties;Ljavax/mail/Authenticator;)Ljavax/mail/Session;
    .locals 1

    .prologue
    .line 242
    new-instance v0, Ljavax/mail/Session;

    invoke-direct {v0, p0, p1}, Ljavax/mail/Session;-><init>(Ljava/util/Properties;Ljavax/mail/Authenticator;)V

    return-object v0
.end method

.method private static getResourceAsStream(Ljava/lang/Class;Ljava/lang/String;)Ljava/io/InputStream;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 1202
    :try_start_0
    new-instance v0, Ljavax/mail/Session$4;

    invoke-direct {v0, p0, p1}, Ljavax/mail/Session$4;-><init>(Ljava/lang/Class;Ljava/lang/String;)V

    invoke-static {v0}, Ljava/security/AccessController;->doPrivileged(Ljava/security/PrivilegedExceptionAction;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/io/InputStream;
    :try_end_0
    .catch Ljava/security/PrivilegedActionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1201
    return-object v0

    .line 1207
    :catch_0
    move-exception v0

    .line 1208
    invoke-virtual {v0}, Ljava/security/PrivilegedActionException;->getException()Ljava/lang/Exception;

    move-result-object v0

    check-cast v0, Ljava/io/IOException;

    throw v0
.end method

.method private static getResources(Ljava/lang/ClassLoader;Ljava/lang/String;)[Ljava/net/URL;
    .locals 1

    .prologue
    .line 1214
    new-instance v0, Ljavax/mail/Session$5;

    invoke-direct {v0, p0, p1}, Ljavax/mail/Session$5;-><init>(Ljava/lang/ClassLoader;Ljava/lang/String;)V

    invoke-static {v0}, Ljava/security/AccessController;->doPrivileged(Ljava/security/PrivilegedAction;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/net/URL;

    .line 1213
    return-object v0
.end method

.method private getService(Ljavax/mail/Provider;Ljavax/mail/URLName;)Ljava/lang/Object;
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/NoSuchProviderException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 739
    if-nez p1, :cond_0

    .line 740
    new-instance v0, Ljavax/mail/NoSuchProviderException;

    const-string v1, "null"

    invoke-direct {v0, v1}, Ljavax/mail/NoSuchProviderException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 744
    :cond_0
    if-nez p2, :cond_6

    .line 745
    new-instance v0, Ljavax/mail/URLName;

    invoke-virtual {p1}, Ljavax/mail/Provider;->getProtocol()Ljava/lang/String;

    move-result-object v1

    const/4 v3, -0x1

    move-object v4, v2

    move-object v5, v2

    move-object v6, v2

    invoke-direct/range {v0 .. v6}, Ljavax/mail/URLName;-><init>(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 753
    :goto_0
    iget-object v1, p0, Ljavax/mail/Session;->authenticator:Ljavax/mail/Authenticator;

    if-eqz v1, :cond_2

    .line 754
    iget-object v1, p0, Ljavax/mail/Session;->authenticator:Ljavax/mail/Authenticator;

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v1

    .line 762
    :goto_1
    :try_start_0
    invoke-static {}, Ljavax/mail/Session;->getContextClassLoader()Ljava/lang/ClassLoader;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v3

    .line 763
    if-eqz v3, :cond_1

    .line 765
    :try_start_1
    invoke-virtual {p1}, Ljavax/mail/Provider;->getClassName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/ClassLoader;->loadClass(Ljava/lang/String;)Ljava/lang/Class;
    :try_end_1
    .catch Ljava/lang/ClassNotFoundException; {:try_start_1 .. :try_end_1} :catch_3
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    move-result-object v2

    .line 769
    :cond_1
    :goto_2
    if-nez v2, :cond_5

    .line 770
    :try_start_2
    invoke-virtual {p1}, Ljavax/mail/Provider;->getClassName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/ClassLoader;->loadClass(Ljava/lang/String;)Ljava/lang/Class;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    move-result-object v1

    .line 786
    :goto_3
    const/4 v2, 0x2

    :try_start_3
    new-array v2, v2, [Ljava/lang/Class;

    const/4 v3, 0x0

    const-class v4, Ljavax/mail/Session;

    aput-object v4, v2, v3

    const/4 v3, 0x1

    const-class v4, Ljavax/mail/URLName;

    aput-object v4, v2, v3

    .line 787
    invoke-virtual {v1, v2}, Ljava/lang/Class;->getConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v1

    .line 789
    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object p0, v2, v3

    const/4 v3, 0x1

    aput-object v0, v2, v3

    .line 790
    invoke-virtual {v1, v2}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_2

    move-result-object v0

    .line 797
    return-object v0

    .line 756
    :cond_2
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v1

    goto :goto_1

    .line 771
    :catch_0
    move-exception v1

    .line 776
    :try_start_4
    invoke-virtual {p1}, Ljavax/mail/Provider;->getClassName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_1

    move-result-object v1

    goto :goto_3

    .line 777
    :catch_1
    move-exception v0

    .line 779
    iget-boolean v1, p0, Ljavax/mail/Session;->debug:Z

    if-eqz v1, :cond_3

    invoke-virtual {p0}, Ljavax/mail/Session;->getDebugOut()Ljava/io/PrintStream;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/Exception;->printStackTrace(Ljava/io/PrintStream;)V

    .line 780
    :cond_3
    new-instance v0, Ljavax/mail/NoSuchProviderException;

    invoke-virtual {p1}, Ljavax/mail/Provider;->getProtocol()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljavax/mail/NoSuchProviderException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 792
    :catch_2
    move-exception v0

    .line 793
    iget-boolean v1, p0, Ljavax/mail/Session;->debug:Z

    if-eqz v1, :cond_4

    invoke-virtual {p0}, Ljavax/mail/Session;->getDebugOut()Ljava/io/PrintStream;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/Exception;->printStackTrace(Ljava/io/PrintStream;)V

    .line 794
    :cond_4
    new-instance v0, Ljavax/mail/NoSuchProviderException;

    invoke-virtual {p1}, Ljavax/mail/Provider;->getProtocol()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljavax/mail/NoSuchProviderException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 766
    :catch_3
    move-exception v3

    goto :goto_2

    :cond_5
    move-object v1, v2

    goto :goto_3

    :cond_6
    move-object v0, p2

    goto/16 :goto_0
.end method

.method private getStore(Ljavax/mail/Provider;Ljavax/mail/URLName;)Ljavax/mail/Store;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/NoSuchProviderException;
        }
    .end annotation

    .prologue
    .line 574
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljavax/mail/Provider;->getType()Ljavax/mail/Provider$Type;

    move-result-object v0

    sget-object v1, Ljavax/mail/Provider$Type;->STORE:Ljavax/mail/Provider$Type;

    if-eq v0, v1, :cond_1

    .line 575
    :cond_0
    new-instance v0, Ljavax/mail/NoSuchProviderException;

    const-string v1, "invalid provider"

    invoke-direct {v0, v1}, Ljavax/mail/NoSuchProviderException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 579
    :cond_1
    :try_start_0
    invoke-direct {p0, p1, p2}, Ljavax/mail/Session;->getService(Ljavax/mail/Provider;Ljavax/mail/URLName;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljavax/mail/Store;
    :try_end_0
    .catch Ljava/lang/ClassCastException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 580
    :catch_0
    move-exception v0

    .line 581
    new-instance v0, Ljavax/mail/NoSuchProviderException;

    const-string v1, "incorrect class"

    invoke-direct {v0, v1}, Ljavax/mail/NoSuchProviderException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static getSystemResources(Ljava/lang/String;)[Ljava/net/URL;
    .locals 1

    .prologue
    .line 1238
    new-instance v0, Ljavax/mail/Session$6;

    invoke-direct {v0, p0}, Ljavax/mail/Session$6;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Ljava/security/AccessController;->doPrivileged(Ljava/security/PrivilegedAction;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/net/URL;

    .line 1237
    return-object v0
.end method

.method private getTransport(Ljavax/mail/Provider;Ljavax/mail/URLName;)Ljavax/mail/Transport;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/NoSuchProviderException;
        }
    .end annotation

    .prologue
    .line 713
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljavax/mail/Provider;->getType()Ljavax/mail/Provider$Type;

    move-result-object v0

    sget-object v1, Ljavax/mail/Provider$Type;->TRANSPORT:Ljavax/mail/Provider$Type;

    if-eq v0, v1, :cond_1

    .line 714
    :cond_0
    new-instance v0, Ljavax/mail/NoSuchProviderException;

    const-string v1, "invalid provider"

    invoke-direct {v0, v1}, Ljavax/mail/NoSuchProviderException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 718
    :cond_1
    :try_start_0
    invoke-direct {p0, p1, p2}, Ljavax/mail/Session;->getService(Ljavax/mail/Provider;Ljavax/mail/URLName;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljavax/mail/Transport;
    :try_end_0
    .catch Ljava/lang/ClassCastException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 719
    :catch_0
    move-exception v0

    .line 720
    new-instance v0, Ljavax/mail/NoSuchProviderException;

    const-string v1, "incorrect class"

    invoke-direct {v0, v1}, Ljavax/mail/NoSuchProviderException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private loadAddressMap(Ljava/lang/Class;)V
    .locals 3

    .prologue
    .line 1010
    new-instance v0, Ljavax/mail/Session$2;

    invoke-direct {v0, p0}, Ljavax/mail/Session$2;-><init>(Ljavax/mail/Session;)V

    .line 1017
    const-string v1, "/META-INF/javamail.default.address.map"

    invoke-direct {p0, v1, p1, v0}, Ljavax/mail/Session;->loadResource(Ljava/lang/String;Ljava/lang/Class;Ljavax/mail/StreamLoader;)V

    .line 1020
    const-string v1, "META-INF/javamail.address.map"

    invoke-direct {p0, v1, p1, v0}, Ljavax/mail/Session;->loadAllResources(Ljava/lang/String;Ljava/lang/Class;Ljavax/mail/StreamLoader;)V

    .line 1024
    :try_start_0
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "java.home"

    invoke-static {v2}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 1025
    sget-object v2, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "lib"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 1026
    sget-object v2, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "javamail.address.map"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 1024
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 1027
    invoke-direct {p0, v1, v0}, Ljavax/mail/Session;->loadFile(Ljava/lang/String;Ljavax/mail/StreamLoader;)V
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1033
    :cond_0
    :goto_0
    iget-object v0, p0, Ljavax/mail/Session;->addressMap:Ljava/util/Properties;

    invoke-virtual {v0}, Ljava/util/Properties;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 1034
    iget-boolean v0, p0, Ljavax/mail/Session;->debug:Z

    if-eqz v0, :cond_1

    .line 1035
    const-string v0, "DEBUG: failed to load address map, using defaults"

    invoke-direct {p0, v0}, Ljavax/mail/Session;->pr(Ljava/lang/String;)V

    .line 1036
    :cond_1
    iget-object v0, p0, Ljavax/mail/Session;->addressMap:Ljava/util/Properties;

    const-string v1, "rfc822"

    const-string v2, "smtp"

    invoke-virtual {v0, v1, v2}, Ljava/util/Properties;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1038
    :cond_2
    return-void

    .line 1028
    :catch_0
    move-exception v0

    .line 1029
    iget-boolean v1, p0, Ljavax/mail/Session;->debug:Z

    if-eqz v1, :cond_0

    .line 1030
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "DEBUG: can\'t get java.home: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Ljavax/mail/Session;->pr(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private loadAllResources(Ljava/lang/String;Ljava/lang/Class;Ljavax/mail/StreamLoader;)V
    .locals 8

    .prologue
    const/4 v2, 0x0

    .line 1120
    .line 1125
    :try_start_0
    invoke-static {}, Ljavax/mail/Session;->getContextClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    .line 1126
    if-nez v0, :cond_0

    .line 1127
    invoke-virtual {p2}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    .line 1128
    :cond_0
    if-eqz v0, :cond_4

    .line 1129
    invoke-static {v0, p1}, Ljavax/mail/Session;->getResources(Ljava/lang/ClassLoader;Ljava/lang/String;)[Ljava/net/URL;

    move-result-object v0

    move-object v4, v0

    .line 1132
    :goto_0
    if-eqz v4, :cond_1

    move v3, v2

    .line 1133
    :goto_1
    array-length v0, v4
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_4

    if-lt v3, v0, :cond_5

    .line 1170
    :cond_1
    :goto_2
    if-nez v2, :cond_3

    .line 1171
    iget-boolean v0, p0, Ljavax/mail/Session;->debug:Z

    if-eqz v0, :cond_2

    .line 1172
    const-string v0, "DEBUG: !anyLoaded"

    invoke-direct {p0, v0}, Ljavax/mail/Session;->pr(Ljava/lang/String;)V

    .line 1173
    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "/"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, p2, p3}, Ljavax/mail/Session;->loadResource(Ljava/lang/String;Ljava/lang/Class;Ljavax/mail/StreamLoader;)V

    .line 1175
    :cond_3
    return-void

    .line 1131
    :cond_4
    :try_start_1
    invoke-static {p1}, Ljavax/mail/Session;->getSystemResources(Ljava/lang/String;)[Ljava/net/URL;

    move-result-object v0

    move-object v4, v0

    goto :goto_0

    .line 1134
    :cond_5
    aget-object v0, v4, v3

    .line 1135
    const/4 v1, 0x0

    .line 1136
    iget-boolean v5, p0, Ljavax/mail/Session;->debug:Z

    if-eqz v5, :cond_6

    .line 1137
    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "DEBUG: URL "

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {p0, v5}, Ljavax/mail/Session;->pr(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_4

    .line 1139
    :cond_6
    :try_start_2
    invoke-static {v0}, Ljavax/mail/Session;->openStream(Ljava/net/URL;)Ljava/io/InputStream;
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/SecurityException; {:try_start_2 .. :try_end_2} :catch_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-result-object v1

    .line 1140
    if-eqz v1, :cond_8

    .line 1141
    :try_start_3
    invoke-interface {p3, v1}, Ljavax/mail/StreamLoader;->load(Ljava/io/InputStream;)V

    .line 1142
    const/4 v2, 0x1

    .line 1143
    iget-boolean v5, p0, Ljavax/mail/Session;->debug:Z

    if-eqz v5, :cond_c

    .line 1144
    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "DEBUG: successfully loaded resource: "

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 1145
    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1144
    invoke-direct {p0, v0}, Ljavax/mail/Session;->pr(Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_9
    .catch Ljava/lang/SecurityException; {:try_start_3 .. :try_end_3} :catch_8
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move v0, v2

    .line 1158
    :goto_3
    if-eqz v1, :cond_7

    .line 1159
    :try_start_4
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_6
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_7

    .line 1133
    :cond_7
    :goto_4
    add-int/lit8 v2, v3, 0x1

    move v3, v2

    move v2, v0

    goto :goto_1

    .line 1147
    :cond_8
    :try_start_5
    iget-boolean v5, p0, Ljavax/mail/Session;->debug:Z

    if-eqz v5, :cond_c

    .line 1148
    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "DEBUG: not loading resource: "

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Ljavax/mail/Session;->pr(Ljava/lang/String;)V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_9
    .catch Ljava/lang/SecurityException; {:try_start_5 .. :try_end_5} :catch_8
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    move v0, v2

    goto :goto_3

    .line 1150
    :catch_0
    move-exception v0

    move-object v7, v0

    move v0, v2

    move-object v2, v1

    move-object v1, v7

    .line 1151
    :goto_5
    :try_start_6
    iget-boolean v5, p0, Ljavax/mail/Session;->debug:Z

    if-eqz v5, :cond_9

    .line 1152
    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "DEBUG: "

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Ljavax/mail/Session;->pr(Ljava/lang/String;)V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    .line 1158
    :cond_9
    if-eqz v2, :cond_7

    .line 1159
    :try_start_7
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_1
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_7

    goto :goto_4

    .line 1160
    :catch_1
    move-exception v1

    goto :goto_4

    .line 1153
    :catch_2
    move-exception v0

    move-object v7, v0

    move v0, v2

    move-object v2, v1

    move-object v1, v7

    .line 1154
    :goto_6
    :try_start_8
    iget-boolean v5, p0, Ljavax/mail/Session;->debug:Z

    if-eqz v5, :cond_a

    .line 1155
    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "DEBUG: "

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Ljavax/mail/Session;->pr(Ljava/lang/String;)V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_1

    .line 1158
    :cond_a
    if-eqz v2, :cond_7

    .line 1159
    :try_start_9
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_9
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_3
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_7

    goto :goto_4

    .line 1160
    :catch_3
    move-exception v1

    goto :goto_4

    .line 1156
    :catchall_0
    move-exception v0

    .line 1158
    :goto_7
    if-eqz v1, :cond_b

    .line 1159
    :try_start_a
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_a
    .catch Ljava/io/IOException; {:try_start_a .. :try_end_a} :catch_5
    .catch Ljava/lang/Exception; {:try_start_a .. :try_end_a} :catch_4

    .line 1161
    :cond_b
    :goto_8
    :try_start_b
    throw v0
    :try_end_b
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_b} :catch_4

    .line 1164
    :catch_4
    move-exception v0

    .line 1165
    :goto_9
    iget-boolean v1, p0, Ljavax/mail/Session;->debug:Z

    if-eqz v1, :cond_1

    .line 1166
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v3, "DEBUG: "

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Ljavax/mail/Session;->pr(Ljava/lang/String;)V

    goto/16 :goto_2

    .line 1160
    :catch_5
    move-exception v1

    goto :goto_8

    :catch_6
    move-exception v1

    goto/16 :goto_4

    .line 1164
    :catch_7
    move-exception v1

    move v2, v0

    move-object v0, v1

    goto :goto_9

    .line 1156
    :catchall_1
    move-exception v1

    move-object v7, v1

    move-object v1, v2

    move v2, v0

    move-object v0, v7

    goto :goto_7

    .line 1153
    :catch_8
    move-exception v0

    move-object v7, v0

    move v0, v2

    move-object v2, v1

    move-object v1, v7

    goto :goto_6

    .line 1150
    :catch_9
    move-exception v0

    move-object v7, v0

    move v0, v2

    move-object v2, v1

    move-object v1, v7

    goto :goto_5

    :cond_c
    move v0, v2

    goto/16 :goto_3
.end method

.method private loadFile(Ljava/lang/String;Ljavax/mail/StreamLoader;)V
    .locals 4

    .prologue
    .line 1063
    const/4 v2, 0x0

    .line 1065
    :try_start_0
    new-instance v1, Ljava/io/BufferedInputStream;

    new-instance v0, Ljava/io/FileInputStream;

    invoke-direct {v0, p1}, Ljava/io/FileInputStream;-><init>(Ljava/lang/String;)V

    invoke-direct {v1, v0}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1066
    :try_start_1
    invoke-interface {p2, v1}, Ljavax/mail/StreamLoader;->load(Ljava/io/InputStream;)V

    .line 1067
    iget-boolean v0, p0, Ljavax/mail/Session;->debug:Z

    if-eqz v0, :cond_0

    .line 1068
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v2, "DEBUG: successfully loaded file: "

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Ljavax/mail/Session;->pr(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_7
    .catch Ljava/lang/SecurityException; {:try_start_1 .. :try_end_1} :catch_6
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 1081
    :cond_0
    if-eqz v1, :cond_1

    .line 1082
    :try_start_2
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_5

    .line 1085
    :cond_1
    :goto_0
    return-void

    .line 1069
    :catch_0
    move-exception v0

    move-object v1, v2

    .line 1070
    :goto_1
    :try_start_3
    iget-boolean v2, p0, Ljavax/mail/Session;->debug:Z

    if-eqz v2, :cond_2

    .line 1071
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "DEBUG: not loading file: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Ljavax/mail/Session;->pr(Ljava/lang/String;)V

    .line 1072
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "DEBUG: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Ljavax/mail/Session;->pr(Ljava/lang/String;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1081
    :cond_2
    if-eqz v1, :cond_1

    .line 1082
    :try_start_4
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_1

    goto :goto_0

    .line 1083
    :catch_1
    move-exception v0

    goto :goto_0

    .line 1074
    :catch_2
    move-exception v0

    move-object v1, v2

    .line 1075
    :goto_2
    :try_start_5
    iget-boolean v2, p0, Ljavax/mail/Session;->debug:Z

    if-eqz v2, :cond_3

    .line 1076
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "DEBUG: not loading file: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Ljavax/mail/Session;->pr(Ljava/lang/String;)V

    .line 1077
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "DEBUG: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Ljavax/mail/Session;->pr(Ljava/lang/String;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    .line 1081
    :cond_3
    if-eqz v1, :cond_1

    .line 1082
    :try_start_6
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_3

    goto :goto_0

    .line 1083
    :catch_3
    move-exception v0

    goto :goto_0

    .line 1079
    :catchall_0
    move-exception v0

    move-object v1, v2

    .line 1081
    :goto_3
    if-eqz v1, :cond_4

    .line 1082
    :try_start_7
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_4

    .line 1084
    :cond_4
    :goto_4
    throw v0

    .line 1083
    :catch_4
    move-exception v1

    goto :goto_4

    :catch_5
    move-exception v0

    goto :goto_0

    .line 1079
    :catchall_1
    move-exception v0

    goto :goto_3

    .line 1074
    :catch_6
    move-exception v0

    goto :goto_2

    .line 1069
    :catch_7
    move-exception v0

    goto :goto_1
.end method

.method private loadProviders(Ljava/lang/Class;)V
    .locals 6

    .prologue
    .line 880
    new-instance v1, Ljavax/mail/Session$1;

    invoke-direct {v1, p0}, Ljavax/mail/Session$1;-><init>(Ljavax/mail/Session;)V

    .line 888
    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v2, "java.home"

    invoke-static {v2}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 889
    sget-object v2, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "lib"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 890
    sget-object v2, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "javamail.providers"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 888
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 891
    invoke-direct {p0, v0, v1}, Ljavax/mail/Session;->loadFile(Ljava/lang/String;Ljavax/mail/StreamLoader;)V
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    .line 898
    :cond_0
    :goto_0
    const-string v0, "META-INF/javamail.providers"

    invoke-direct {p0, v0, p1, v1}, Ljavax/mail/Session;->loadAllResources(Ljava/lang/String;Ljava/lang/Class;Ljavax/mail/StreamLoader;)V

    .line 901
    const-string v0, "/META-INF/javamail.default.providers"

    invoke-direct {p0, v0, p1, v1}, Ljavax/mail/Session;->loadResource(Ljava/lang/String;Ljava/lang/Class;Ljavax/mail/StreamLoader;)V

    .line 903
    iget-object v0, p0, Ljavax/mail/Session;->providers:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v0

    if-nez v0, :cond_2

    .line 904
    iget-boolean v0, p0, Ljavax/mail/Session;->debug:Z

    if-eqz v0, :cond_1

    .line 905
    const-string v0, "DEBUG: failed to load any providers, using defaults"

    invoke-direct {p0, v0}, Ljavax/mail/Session;->pr(Ljava/lang/String;)V

    .line 907
    :cond_1
    new-instance v0, Ljavax/mail/Provider;

    sget-object v1, Ljavax/mail/Provider$Type;->STORE:Ljavax/mail/Provider$Type;

    .line 908
    const-string v2, "imap"

    const-string v3, "com.sun.mail.imap.IMAPStore"

    .line 909
    const-string v4, "Sun Microsystems, Inc."

    const-string v5, "1.4.1"

    invoke-direct/range {v0 .. v5}, Ljavax/mail/Provider;-><init>(Ljavax/mail/Provider$Type;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 907
    invoke-virtual {p0, v0}, Ljavax/mail/Session;->addProvider(Ljavax/mail/Provider;)V

    .line 910
    new-instance v0, Ljavax/mail/Provider;

    sget-object v1, Ljavax/mail/Provider$Type;->STORE:Ljavax/mail/Provider$Type;

    .line 911
    const-string v2, "imaps"

    const-string v3, "com.sun.mail.imap.IMAPSSLStore"

    .line 912
    const-string v4, "Sun Microsystems, Inc."

    const-string v5, "1.4.1"

    invoke-direct/range {v0 .. v5}, Ljavax/mail/Provider;-><init>(Ljavax/mail/Provider$Type;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 910
    invoke-virtual {p0, v0}, Ljavax/mail/Session;->addProvider(Ljavax/mail/Provider;)V

    .line 913
    new-instance v0, Ljavax/mail/Provider;

    sget-object v1, Ljavax/mail/Provider$Type;->STORE:Ljavax/mail/Provider$Type;

    .line 914
    const-string v2, "pop3"

    const-string v3, "com.sun.mail.pop3.POP3Store"

    .line 915
    const-string v4, "Sun Microsystems, Inc."

    const-string v5, "1.4.1"

    invoke-direct/range {v0 .. v5}, Ljavax/mail/Provider;-><init>(Ljavax/mail/Provider$Type;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 913
    invoke-virtual {p0, v0}, Ljavax/mail/Session;->addProvider(Ljavax/mail/Provider;)V

    .line 916
    new-instance v0, Ljavax/mail/Provider;

    sget-object v1, Ljavax/mail/Provider$Type;->STORE:Ljavax/mail/Provider$Type;

    .line 917
    const-string v2, "pop3s"

    const-string v3, "com.sun.mail.pop3.POP3SSLStore"

    .line 918
    const-string v4, "Sun Microsystems, Inc."

    const-string v5, "1.4.1"

    invoke-direct/range {v0 .. v5}, Ljavax/mail/Provider;-><init>(Ljavax/mail/Provider$Type;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 916
    invoke-virtual {p0, v0}, Ljavax/mail/Session;->addProvider(Ljavax/mail/Provider;)V

    .line 919
    new-instance v0, Ljavax/mail/Provider;

    sget-object v1, Ljavax/mail/Provider$Type;->TRANSPORT:Ljavax/mail/Provider$Type;

    .line 920
    const-string v2, "smtp"

    const-string v3, "com.sun.mail.smtp.SMTPTransport"

    .line 921
    const-string v4, "Sun Microsystems, Inc."

    const-string v5, "1.4.1"

    invoke-direct/range {v0 .. v5}, Ljavax/mail/Provider;-><init>(Ljavax/mail/Provider$Type;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 919
    invoke-virtual {p0, v0}, Ljavax/mail/Session;->addProvider(Ljavax/mail/Provider;)V

    .line 922
    new-instance v0, Ljavax/mail/Provider;

    sget-object v1, Ljavax/mail/Provider$Type;->TRANSPORT:Ljavax/mail/Provider$Type;

    .line 923
    const-string v2, "smtps"

    const-string v3, "com.sun.mail.smtp.SMTPSSLTransport"

    .line 924
    const-string v4, "Sun Microsystems, Inc."

    const-string v5, "1.4.1"

    invoke-direct/range {v0 .. v5}, Ljavax/mail/Provider;-><init>(Ljavax/mail/Provider$Type;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 922
    invoke-virtual {p0, v0}, Ljavax/mail/Session;->addProvider(Ljavax/mail/Provider;)V

    .line 927
    :cond_2
    iget-boolean v0, p0, Ljavax/mail/Session;->debug:Z

    if-eqz v0, :cond_3

    .line 929
    const-string v0, "DEBUG: Tables of loaded providers"

    invoke-direct {p0, v0}, Ljavax/mail/Session;->pr(Ljava/lang/String;)V

    .line 930
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "DEBUG: Providers Listed By Class Name: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 931
    iget-object v1, p0, Ljavax/mail/Session;->providersByClassName:Ljava/util/Hashtable;

    invoke-virtual {v1}, Ljava/util/Hashtable;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 930
    invoke-direct {p0, v0}, Ljavax/mail/Session;->pr(Ljava/lang/String;)V

    .line 932
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "DEBUG: Providers Listed By Protocol: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 933
    iget-object v1, p0, Ljavax/mail/Session;->providersByProtocol:Ljava/util/Hashtable;

    invoke-virtual {v1}, Ljava/util/Hashtable;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 932
    invoke-direct {p0, v0}, Ljavax/mail/Session;->pr(Ljava/lang/String;)V

    .line 935
    :cond_3
    return-void

    .line 892
    :catch_0
    move-exception v0

    .line 893
    iget-boolean v2, p0, Ljavax/mail/Session;->debug:Z

    if-eqz v2, :cond_0

    .line 894
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "DEBUG: can\'t get java.home: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Ljavax/mail/Session;->pr(Ljava/lang/String;)V

    goto/16 :goto_0
.end method

.method private loadProvidersFromStream(Ljava/io/InputStream;)V
    .locals 12
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v6, 0x0

    .line 939
    if-eqz p1, :cond_1

    .line 940
    new-instance v7, Lcom/sun/mail/util/LineInputStream;

    invoke-direct {v7, p1}, Lcom/sun/mail/util/LineInputStream;-><init>(Ljava/io/InputStream;)V

    .line 944
    :cond_0
    :goto_0
    invoke-virtual {v7}, Lcom/sun/mail/util/LineInputStream;->readLine()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_2

    .line 992
    :cond_1
    return-void

    .line 946
    :cond_2
    const-string v1, "#"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 953
    new-instance v8, Ljava/util/StringTokenizer;

    const-string v1, ";"

    invoke-direct {v8, v0, v1}, Ljava/util/StringTokenizer;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    move-object v5, v6

    move-object v4, v6

    move-object v3, v6

    move-object v2, v6

    move-object v1, v6

    .line 954
    :cond_3
    :goto_1
    invoke-virtual {v8}, Ljava/util/StringTokenizer;->hasMoreTokens()Z

    move-result v9

    if-nez v9, :cond_5

    .line 978
    if-eqz v1, :cond_4

    if-eqz v2, :cond_4

    if-eqz v3, :cond_4

    .line 979
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v8

    if-lez v8, :cond_4

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v8

    if-gtz v8, :cond_b

    .line 981
    :cond_4
    iget-boolean v1, p0, Ljavax/mail/Session;->debug:Z

    if-eqz v1, :cond_0

    .line 982
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "DEBUG: Bad provider entry: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Ljavax/mail/Session;->pr(Ljava/lang/String;)V

    goto :goto_0

    .line 955
    :cond_5
    invoke-virtual {v8}, Ljava/util/StringTokenizer;->nextToken()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v9

    .line 958
    const-string v10, "="

    invoke-virtual {v9, v10}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v10

    .line 959
    const-string v11, "protocol="

    invoke-virtual {v9, v11}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v11

    if-eqz v11, :cond_6

    .line 960
    add-int/lit8 v2, v10, 0x1

    invoke-virtual {v9, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    goto :goto_1

    .line 961
    :cond_6
    const-string v11, "type="

    invoke-virtual {v9, v11}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v11

    if-eqz v11, :cond_8

    .line 962
    add-int/lit8 v10, v10, 0x1

    invoke-virtual {v9, v10}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v9

    .line 963
    const-string v10, "store"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_7

    .line 964
    sget-object v1, Ljavax/mail/Provider$Type;->STORE:Ljavax/mail/Provider$Type;

    goto :goto_1

    .line 965
    :cond_7
    const-string v10, "transport"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_3

    .line 966
    sget-object v1, Ljavax/mail/Provider$Type;->TRANSPORT:Ljavax/mail/Provider$Type;

    goto :goto_1

    .line 968
    :cond_8
    const-string v11, "class="

    invoke-virtual {v9, v11}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v11

    if-eqz v11, :cond_9

    .line 969
    add-int/lit8 v3, v10, 0x1

    invoke-virtual {v9, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v3

    goto :goto_1

    .line 970
    :cond_9
    const-string v11, "vendor="

    invoke-virtual {v9, v11}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v11

    if-eqz v11, :cond_a

    .line 971
    add-int/lit8 v4, v10, 0x1

    invoke-virtual {v9, v4}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v4

    goto/16 :goto_1

    .line 972
    :cond_a
    const-string v11, "version="

    invoke-virtual {v9, v11}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v11

    if-eqz v11, :cond_3

    .line 973
    add-int/lit8 v5, v10, 0x1

    invoke-virtual {v9, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v5

    goto/16 :goto_1

    .line 985
    :cond_b
    new-instance v0, Ljavax/mail/Provider;

    invoke-direct/range {v0 .. v5}, Ljavax/mail/Provider;-><init>(Ljavax/mail/Provider$Type;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 989
    invoke-virtual {p0, v0}, Ljavax/mail/Session;->addProvider(Ljavax/mail/Provider;)V

    goto/16 :goto_0
.end method

.method private loadResource(Ljava/lang/String;Ljava/lang/Class;Ljavax/mail/StreamLoader;)V
    .locals 4

    .prologue
    .line 1091
    const/4 v1, 0x0

    .line 1093
    :try_start_0
    invoke-static {p2, p1}, Ljavax/mail/Session;->getResourceAsStream(Ljava/lang/Class;Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v1

    .line 1094
    if-eqz v1, :cond_2

    .line 1095
    invoke-interface {p3, v1}, Ljavax/mail/StreamLoader;->load(Ljava/io/InputStream;)V

    .line 1096
    iget-boolean v0, p0, Ljavax/mail/Session;->debug:Z

    if-eqz v0, :cond_0

    .line 1097
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v2, "DEBUG: successfully loaded resource: "

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Ljavax/mail/Session;->pr(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1110
    :cond_0
    :goto_0
    if-eqz v1, :cond_1

    .line 1111
    :try_start_1
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_5

    .line 1114
    :cond_1
    :goto_1
    return-void

    .line 1099
    :cond_2
    :try_start_2
    iget-boolean v0, p0, Ljavax/mail/Session;->debug:Z

    if-eqz v0, :cond_0

    .line 1100
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v2, "DEBUG: not loading resource: "

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Ljavax/mail/Session;->pr(Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/SecurityException; {:try_start_2 .. :try_end_2} :catch_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    .line 1102
    :catch_0
    move-exception v0

    .line 1103
    :try_start_3
    iget-boolean v2, p0, Ljavax/mail/Session;->debug:Z

    if-eqz v2, :cond_3

    .line 1104
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "DEBUG: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Ljavax/mail/Session;->pr(Ljava/lang/String;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 1110
    :cond_3
    if-eqz v1, :cond_1

    .line 1111
    :try_start_4
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_1

    goto :goto_1

    .line 1112
    :catch_1
    move-exception v0

    goto :goto_1

    .line 1105
    :catch_2
    move-exception v0

    .line 1106
    :try_start_5
    iget-boolean v2, p0, Ljavax/mail/Session;->debug:Z

    if-eqz v2, :cond_4

    .line 1107
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "DEBUG: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Ljavax/mail/Session;->pr(Ljava/lang/String;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 1110
    :cond_4
    if-eqz v1, :cond_1

    .line 1111
    :try_start_6
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_3

    goto :goto_1

    .line 1112
    :catch_3
    move-exception v0

    goto :goto_1

    .line 1108
    :catchall_0
    move-exception v0

    .line 1110
    if-eqz v1, :cond_5

    .line 1111
    :try_start_7
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_4

    .line 1113
    :cond_5
    :goto_2
    throw v0

    .line 1112
    :catch_4
    move-exception v1

    goto :goto_2

    :catch_5
    move-exception v0

    goto :goto_1
.end method

.method private static openStream(Ljava/net/URL;)Ljava/io/InputStream;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 1263
    :try_start_0
    new-instance v0, Ljavax/mail/Session$7;

    invoke-direct {v0, p0}, Ljavax/mail/Session$7;-><init>(Ljava/net/URL;)V

    invoke-static {v0}, Ljava/security/AccessController;->doPrivileged(Ljava/security/PrivilegedExceptionAction;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/io/InputStream;
    :try_end_0
    .catch Ljava/security/PrivilegedActionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1262
    return-object v0

    .line 1268
    :catch_0
    move-exception v0

    .line 1269
    invoke-virtual {v0}, Ljava/security/PrivilegedActionException;->getException()Ljava/lang/Exception;

    move-result-object v0

    check-cast v0, Ljava/io/IOException;

    throw v0
.end method

.method private pr(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 1178
    invoke-virtual {p0}, Ljavax/mail/Session;->getDebugOut()Ljava/io/PrintStream;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1179
    return-void
.end method


# virtual methods
.method public declared-synchronized addProvider(Ljavax/mail/Provider;)V
    .locals 2

    .prologue
    .line 1001
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Ljavax/mail/Session;->providers:Ljava/util/Vector;

    invoke-virtual {v0, p1}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    .line 1002
    iget-object v0, p0, Ljavax/mail/Session;->providersByClassName:Ljava/util/Hashtable;

    invoke-virtual {p1}, Ljavax/mail/Provider;->getClassName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, p1}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1003
    iget-object v0, p0, Ljavax/mail/Session;->providersByProtocol:Ljava/util/Hashtable;

    invoke-virtual {p1}, Ljavax/mail/Provider;->getProtocol()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/Hashtable;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 1004
    iget-object v0, p0, Ljavax/mail/Session;->providersByProtocol:Ljava/util/Hashtable;

    invoke-virtual {p1}, Ljavax/mail/Provider;->getProtocol()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, p1}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1005
    :cond_0
    monitor-exit p0

    return-void

    .line 1001
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized getDebug()Z
    .locals 1

    .prologue
    .line 379
    monitor-enter p0

    :try_start_0
    iget-boolean v0, p0, Ljavax/mail/Session;->debug:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized getDebugOut()Ljava/io/PrintStream;
    .locals 1

    .prologue
    .line 404
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Ljavax/mail/Session;->out:Ljava/io/PrintStream;

    if-nez v0, :cond_0

    .line 405
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 407
    :goto_0
    monitor-exit p0

    return-object v0

    :cond_0
    :try_start_1
    iget-object v0, p0, Ljavax/mail/Session;->out:Ljava/io/PrintStream;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 404
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public getFolder(Ljavax/mail/URLName;)Ljavax/mail/Folder;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 612
    invoke-virtual {p0, p1}, Ljavax/mail/Session;->getStore(Ljavax/mail/URLName;)Ljavax/mail/Store;

    move-result-object v0

    .line 613
    invoke-virtual {v0}, Ljavax/mail/Store;->connect()V

    .line 614
    invoke-virtual {v0, p1}, Ljavax/mail/Store;->getFolder(Ljavax/mail/URLName;)Ljavax/mail/Folder;

    move-result-object v0

    return-object v0
.end method

.method public getPasswordAuthentication(Ljavax/mail/URLName;)Ljavax/mail/PasswordAuthentication;
    .locals 1

    .prologue
    .line 823
    iget-object v0, p0, Ljavax/mail/Session;->authTable:Ljava/util/Hashtable;

    invoke-virtual {v0, p1}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljavax/mail/PasswordAuthentication;

    return-object v0
.end method

.method public getProperties()Ljava/util/Properties;
    .locals 1

    .prologue
    .line 863
    iget-object v0, p0, Ljavax/mail/Session;->props:Ljava/util/Properties;

    return-object v0
.end method

.method public getProperty(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 873
    iget-object v0, p0, Ljavax/mail/Session;->props:Ljava/util/Properties;

    invoke-virtual {v0, p1}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public declared-synchronized getProvider(Ljava/lang/String;)Ljavax/mail/Provider;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/NoSuchProviderException;
        }
    .end annotation

    .prologue
    .line 440
    monitor-enter p0

    if-eqz p1, :cond_0

    :try_start_0
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-gtz v0, :cond_1

    .line 441
    :cond_0
    new-instance v0, Ljavax/mail/NoSuchProviderException;

    const-string v1, "Invalid protocol: null"

    invoke-direct {v0, v1}, Ljavax/mail/NoSuchProviderException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 440
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    .line 444
    :cond_1
    const/4 v0, 0x0

    .line 447
    :try_start_1
    iget-object v1, p0, Ljavax/mail/Session;->props:Ljava/util/Properties;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "mail."

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ".class"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 448
    if-eqz v1, :cond_3

    .line 449
    iget-boolean v0, p0, Ljavax/mail/Session;->debug:Z

    if-eqz v0, :cond_2

    .line 450
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v2, "DEBUG: mail."

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 451
    const-string v2, ".class property exists and points to "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 452
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 450
    invoke-direct {p0, v0}, Ljavax/mail/Session;->pr(Ljava/lang/String;)V

    .line 454
    :cond_2
    iget-object v0, p0, Ljavax/mail/Session;->providersByClassName:Ljava/util/Hashtable;

    invoke-virtual {v0, v1}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljavax/mail/Provider;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 457
    :cond_3
    if-eqz v0, :cond_5

    .line 471
    :cond_4
    :goto_0
    monitor-exit p0

    return-object v0

    .line 461
    :cond_5
    :try_start_2
    iget-object v0, p0, Ljavax/mail/Session;->providersByProtocol:Ljava/util/Hashtable;

    invoke-virtual {v0, p1}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljavax/mail/Provider;

    .line 464
    if-nez v0, :cond_6

    .line 465
    new-instance v0, Ljavax/mail/NoSuchProviderException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "No provider for "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljavax/mail/NoSuchProviderException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 467
    :cond_6
    iget-boolean v1, p0, Ljavax/mail/Session;->debug:Z

    if-eqz v1, :cond_4

    .line 468
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "DEBUG: getProvider() returning "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 469
    invoke-virtual {v0}, Ljavax/mail/Provider;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 468
    invoke-direct {p0, v1}, Ljavax/mail/Session;->pr(Ljava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0
.end method

.method public declared-synchronized getProviders()[Ljavax/mail/Provider;
    .locals 2

    .prologue
    .line 418
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Ljavax/mail/Session;->providers:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v0

    new-array v0, v0, [Ljavax/mail/Provider;

    .line 419
    iget-object v1, p0, Ljavax/mail/Session;->providers:Ljava/util/Vector;

    invoke-virtual {v1, v0}, Ljava/util/Vector;->copyInto([Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 420
    monitor-exit p0

    return-object v0

    .line 418
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public getStore()Ljavax/mail/Store;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/NoSuchProviderException;
        }
    .end annotation

    .prologue
    .line 506
    const-string v0, "mail.store.protocol"

    invoke-virtual {p0, v0}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljavax/mail/Session;->getStore(Ljava/lang/String;)Ljavax/mail/Store;

    move-result-object v0

    return-object v0
.end method

.method public getStore(Ljava/lang/String;)Ljavax/mail/Store;
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/NoSuchProviderException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 520
    new-instance v0, Ljavax/mail/URLName;

    const/4 v3, -0x1

    move-object v1, p1

    move-object v4, v2

    move-object v5, v2

    move-object v6, v2

    invoke-direct/range {v0 .. v6}, Ljavax/mail/URLName;-><init>(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p0, v0}, Ljavax/mail/Session;->getStore(Ljavax/mail/URLName;)Ljavax/mail/Store;

    move-result-object v0

    return-object v0
.end method

.method public getStore(Ljavax/mail/Provider;)Ljavax/mail/Store;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/NoSuchProviderException;
        }
    .end annotation

    .prologue
    .line 554
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Ljavax/mail/Session;->getStore(Ljavax/mail/Provider;Ljavax/mail/URLName;)Ljavax/mail/Store;

    move-result-object v0

    return-object v0
.end method

.method public getStore(Ljavax/mail/URLName;)Ljavax/mail/Store;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/NoSuchProviderException;
        }
    .end annotation

    .prologue
    .line 539
    invoke-virtual {p1}, Ljavax/mail/URLName;->getProtocol()Ljava/lang/String;

    move-result-object v0

    .line 540
    invoke-virtual {p0, v0}, Ljavax/mail/Session;->getProvider(Ljava/lang/String;)Ljavax/mail/Provider;

    move-result-object v0

    .line 541
    invoke-direct {p0, v0, p1}, Ljavax/mail/Session;->getStore(Ljavax/mail/Provider;Ljavax/mail/URLName;)Ljavax/mail/Store;

    move-result-object v0

    return-object v0
.end method

.method public getTransport()Ljavax/mail/Transport;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/NoSuchProviderException;
        }
    .end annotation

    .prologue
    .line 627
    const-string v0, "mail.transport.protocol"

    invoke-virtual {p0, v0}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljavax/mail/Session;->getTransport(Ljava/lang/String;)Ljavax/mail/Transport;

    move-result-object v0

    return-object v0
.end method

.method public getTransport(Ljava/lang/String;)Ljavax/mail/Transport;
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/NoSuchProviderException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 641
    new-instance v0, Ljavax/mail/URLName;

    const/4 v3, -0x1

    move-object v1, p1

    move-object v4, v2

    move-object v5, v2

    move-object v6, v2

    invoke-direct/range {v0 .. v6}, Ljavax/mail/URLName;-><init>(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p0, v0}, Ljavax/mail/Session;->getTransport(Ljavax/mail/URLName;)Ljavax/mail/Transport;

    move-result-object v0

    return-object v0
.end method

.method public getTransport(Ljavax/mail/Address;)Ljavax/mail/Transport;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/NoSuchProviderException;
        }
    .end annotation

    .prologue
    .line 691
    iget-object v0, p0, Ljavax/mail/Session;->addressMap:Ljava/util/Properties;

    invoke-virtual {p1}, Ljavax/mail/Address;->getType()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/Properties;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 692
    if-nez v0, :cond_0

    .line 693
    new-instance v0, Ljavax/mail/NoSuchProviderException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "No provider for Address type: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 694
    invoke-virtual {p1}, Ljavax/mail/Address;->getType()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 693
    invoke-direct {v0, v1}, Ljavax/mail/NoSuchProviderException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 696
    :cond_0
    invoke-virtual {p0, v0}, Ljavax/mail/Session;->getTransport(Ljava/lang/String;)Ljavax/mail/Transport;

    move-result-object v0

    return-object v0
.end method

.method public getTransport(Ljavax/mail/Provider;)Ljavax/mail/Transport;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/NoSuchProviderException;
        }
    .end annotation

    .prologue
    .line 675
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Ljavax/mail/Session;->getTransport(Ljavax/mail/Provider;Ljavax/mail/URLName;)Ljavax/mail/Transport;

    move-result-object v0

    return-object v0
.end method

.method public getTransport(Ljavax/mail/URLName;)Ljavax/mail/Transport;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/NoSuchProviderException;
        }
    .end annotation

    .prologue
    .line 659
    invoke-virtual {p1}, Ljavax/mail/URLName;->getProtocol()Ljava/lang/String;

    move-result-object v0

    .line 660
    invoke-virtual {p0, v0}, Ljavax/mail/Session;->getProvider(Ljava/lang/String;)Ljavax/mail/Provider;

    move-result-object v0

    .line 661
    invoke-direct {p0, v0, p1}, Ljavax/mail/Session;->getTransport(Ljavax/mail/Provider;Ljavax/mail/URLName;)Ljavax/mail/Transport;

    move-result-object v0

    return-object v0
.end method

.method public requestPasswordAuthentication(Ljava/net/InetAddress;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljavax/mail/PasswordAuthentication;
    .locals 6

    .prologue
    .line 849
    iget-object v0, p0, Ljavax/mail/Session;->authenticator:Ljavax/mail/Authenticator;

    if-eqz v0, :cond_0

    .line 850
    iget-object v0, p0, Ljavax/mail/Session;->authenticator:Ljavax/mail/Authenticator;

    move-object v1, p1

    move v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object v5, p5

    invoke-virtual/range {v0 .. v5}, Ljavax/mail/Authenticator;->requestPasswordAuthentication(Ljava/net/InetAddress;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljavax/mail/PasswordAuthentication;

    move-result-object v0

    .line 853
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public declared-synchronized setDebug(Z)V
    .locals 1

    .prologue
    .line 368
    monitor-enter p0

    :try_start_0
    iput-boolean p1, p0, Ljavax/mail/Session;->debug:Z

    .line 369
    if-eqz p1, :cond_0

    .line 370
    const-string v0, "DEBUG: setDebug: JavaMail version 1.4.1"

    invoke-direct {p0, v0}, Ljavax/mail/Session;->pr(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 371
    :cond_0
    monitor-exit p0

    return-void

    .line 368
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized setDebugOut(Ljava/io/PrintStream;)V
    .locals 1

    .prologue
    .line 393
    monitor-enter p0

    :try_start_0
    iput-object p1, p0, Ljavax/mail/Session;->out:Ljava/io/PrintStream;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 394
    monitor-exit p0

    return-void

    .line 393
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public setPasswordAuthentication(Ljavax/mail/URLName;Ljavax/mail/PasswordAuthentication;)V
    .locals 1

    .prologue
    .line 810
    if-nez p2, :cond_0

    .line 811
    iget-object v0, p0, Ljavax/mail/Session;->authTable:Ljava/util/Hashtable;

    invoke-virtual {v0, p1}, Ljava/util/Hashtable;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 814
    :goto_0
    return-void

    .line 813
    :cond_0
    iget-object v0, p0, Ljavax/mail/Session;->authTable:Ljava/util/Hashtable;

    invoke-virtual {v0, p1, p2}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0
.end method

.method public declared-synchronized setProtocolForAddress(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 1053
    monitor-enter p0

    if-nez p2, :cond_0

    .line 1054
    :try_start_0
    iget-object v0, p0, Ljavax/mail/Session;->addressMap:Ljava/util/Properties;

    invoke-virtual {v0, p1}, Ljava/util/Properties;->remove(Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1057
    :goto_0
    monitor-exit p0

    return-void

    .line 1056
    :cond_0
    :try_start_1
    iget-object v0, p0, Ljavax/mail/Session;->addressMap:Ljava/util/Properties;

    invoke-virtual {v0, p1, p2}, Ljava/util/Properties;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 1053
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized setProvider(Ljavax/mail/Provider;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/NoSuchProviderException;
        }
    .end annotation

    .prologue
    .line 486
    monitor-enter p0

    if-nez p1, :cond_0

    .line 487
    :try_start_0
    new-instance v0, Ljavax/mail/NoSuchProviderException;

    const-string v1, "Can\'t set null provider"

    invoke-direct {v0, v1}, Ljavax/mail/NoSuchProviderException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 486
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    .line 489
    :cond_0
    :try_start_1
    iget-object v0, p0, Ljavax/mail/Session;->providersByProtocol:Ljava/util/Hashtable;

    invoke-virtual {p1}, Ljavax/mail/Provider;->getProtocol()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, p1}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 490
    iget-object v0, p0, Ljavax/mail/Session;->props:Ljava/util/Properties;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "mail."

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljavax/mail/Provider;->getProtocol()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ".class"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 491
    invoke-virtual {p1}, Ljavax/mail/Provider;->getClassName()Ljava/lang/String;

    move-result-object v2

    .line 490
    invoke-virtual {v0, v1, v2}, Ljava/util/Properties;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 492
    monitor-exit p0

    return-void
.end method
