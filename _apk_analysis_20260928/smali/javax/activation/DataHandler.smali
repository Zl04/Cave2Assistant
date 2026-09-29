.class public Ljavax/activation/DataHandler;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lmyjava/awt/datatransfer/Transferable;


# static fields
.field private static final emptyFlavors:[Lmyjava/awt/datatransfer/DataFlavor;

.field private static factory:Ljavax/activation/DataContentHandlerFactory;


# instance fields
.field private currentCommandMap:Ljavax/activation/CommandMap;

.field private dataContentHandler:Ljavax/activation/DataContentHandler;

.field private dataSource:Ljavax/activation/DataSource;

.field private factoryDCH:Ljavax/activation/DataContentHandler;

.field private objDataSource:Ljavax/activation/DataSource;

.field private object:Ljava/lang/Object;

.field private objectMimeType:Ljava/lang/String;

.field private oldFactory:Ljavax/activation/DataContentHandlerFactory;

.field private shortType:Ljava/lang/String;

.field private transferFlavors:[Lmyjava/awt/datatransfer/DataFlavor;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 107
    const/4 v0, 0x0

    new-array v0, v0, [Lmyjava/awt/datatransfer/DataFlavor;

    sput-object v0, Ljavax/activation/DataHandler;->emptyFlavors:[Lmyjava/awt/datatransfer/DataFlavor;

    .line 115
    const/4 v0, 0x0

    sput-object v0, Ljavax/activation/DataHandler;->factory:Ljavax/activation/DataContentHandlerFactory;

    .line 90
    return-void
.end method

.method public constructor <init>(Ljava/lang/Object;Ljava/lang/String;)V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 142
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 94
    iput-object v1, p0, Ljavax/activation/DataHandler;->dataSource:Ljavax/activation/DataSource;

    .line 95
    iput-object v1, p0, Ljavax/activation/DataHandler;->objDataSource:Ljavax/activation/DataSource;

    .line 100
    iput-object v1, p0, Ljavax/activation/DataHandler;->object:Ljava/lang/Object;

    .line 101
    iput-object v1, p0, Ljavax/activation/DataHandler;->objectMimeType:Ljava/lang/String;

    .line 104
    iput-object v1, p0, Ljavax/activation/DataHandler;->currentCommandMap:Ljavax/activation/CommandMap;

    .line 108
    sget-object v0, Ljavax/activation/DataHandler;->emptyFlavors:[Lmyjava/awt/datatransfer/DataFlavor;

    iput-object v0, p0, Ljavax/activation/DataHandler;->transferFlavors:[Lmyjava/awt/datatransfer/DataFlavor;

    .line 111
    iput-object v1, p0, Ljavax/activation/DataHandler;->dataContentHandler:Ljavax/activation/DataContentHandler;

    .line 112
    iput-object v1, p0, Ljavax/activation/DataHandler;->factoryDCH:Ljavax/activation/DataContentHandler;

    .line 116
    iput-object v1, p0, Ljavax/activation/DataHandler;->oldFactory:Ljavax/activation/DataContentHandlerFactory;

    .line 118
    iput-object v1, p0, Ljavax/activation/DataHandler;->shortType:Ljava/lang/String;

    .line 143
    iput-object p1, p0, Ljavax/activation/DataHandler;->object:Ljava/lang/Object;

    .line 144
    iput-object p2, p0, Ljavax/activation/DataHandler;->objectMimeType:Ljava/lang/String;

    .line 145
    sget-object v0, Ljavax/activation/DataHandler;->factory:Ljavax/activation/DataContentHandlerFactory;

    iput-object v0, p0, Ljavax/activation/DataHandler;->oldFactory:Ljavax/activation/DataContentHandlerFactory;

    .line 146
    return-void
.end method

.method public constructor <init>(Ljava/net/URL;)V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 155
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 94
    iput-object v1, p0, Ljavax/activation/DataHandler;->dataSource:Ljavax/activation/DataSource;

    .line 95
    iput-object v1, p0, Ljavax/activation/DataHandler;->objDataSource:Ljavax/activation/DataSource;

    .line 100
    iput-object v1, p0, Ljavax/activation/DataHandler;->object:Ljava/lang/Object;

    .line 101
    iput-object v1, p0, Ljavax/activation/DataHandler;->objectMimeType:Ljava/lang/String;

    .line 104
    iput-object v1, p0, Ljavax/activation/DataHandler;->currentCommandMap:Ljavax/activation/CommandMap;

    .line 108
    sget-object v0, Ljavax/activation/DataHandler;->emptyFlavors:[Lmyjava/awt/datatransfer/DataFlavor;

    iput-object v0, p0, Ljavax/activation/DataHandler;->transferFlavors:[Lmyjava/awt/datatransfer/DataFlavor;

    .line 111
    iput-object v1, p0, Ljavax/activation/DataHandler;->dataContentHandler:Ljavax/activation/DataContentHandler;

    .line 112
    iput-object v1, p0, Ljavax/activation/DataHandler;->factoryDCH:Ljavax/activation/DataContentHandler;

    .line 116
    iput-object v1, p0, Ljavax/activation/DataHandler;->oldFactory:Ljavax/activation/DataContentHandlerFactory;

    .line 118
    iput-object v1, p0, Ljavax/activation/DataHandler;->shortType:Ljava/lang/String;

    .line 156
    new-instance v0, Ljavax/activation/URLDataSource;

    invoke-direct {v0, p1}, Ljavax/activation/URLDataSource;-><init>(Ljava/net/URL;)V

    iput-object v0, p0, Ljavax/activation/DataHandler;->dataSource:Ljavax/activation/DataSource;

    .line 157
    sget-object v0, Ljavax/activation/DataHandler;->factory:Ljavax/activation/DataContentHandlerFactory;

    iput-object v0, p0, Ljavax/activation/DataHandler;->oldFactory:Ljavax/activation/DataContentHandlerFactory;

    .line 158
    return-void
.end method

.method public constructor <init>(Ljavax/activation/DataSource;)V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 127
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 94
    iput-object v1, p0, Ljavax/activation/DataHandler;->dataSource:Ljavax/activation/DataSource;

    .line 95
    iput-object v1, p0, Ljavax/activation/DataHandler;->objDataSource:Ljavax/activation/DataSource;

    .line 100
    iput-object v1, p0, Ljavax/activation/DataHandler;->object:Ljava/lang/Object;

    .line 101
    iput-object v1, p0, Ljavax/activation/DataHandler;->objectMimeType:Ljava/lang/String;

    .line 104
    iput-object v1, p0, Ljavax/activation/DataHandler;->currentCommandMap:Ljavax/activation/CommandMap;

    .line 108
    sget-object v0, Ljavax/activation/DataHandler;->emptyFlavors:[Lmyjava/awt/datatransfer/DataFlavor;

    iput-object v0, p0, Ljavax/activation/DataHandler;->transferFlavors:[Lmyjava/awt/datatransfer/DataFlavor;

    .line 111
    iput-object v1, p0, Ljavax/activation/DataHandler;->dataContentHandler:Ljavax/activation/DataContentHandler;

    .line 112
    iput-object v1, p0, Ljavax/activation/DataHandler;->factoryDCH:Ljavax/activation/DataContentHandler;

    .line 116
    iput-object v1, p0, Ljavax/activation/DataHandler;->oldFactory:Ljavax/activation/DataContentHandlerFactory;

    .line 118
    iput-object v1, p0, Ljavax/activation/DataHandler;->shortType:Ljava/lang/String;

    .line 129
    iput-object p1, p0, Ljavax/activation/DataHandler;->dataSource:Ljavax/activation/DataSource;

    .line 130
    sget-object v0, Ljavax/activation/DataHandler;->factory:Ljavax/activation/DataContentHandlerFactory;

    iput-object v0, p0, Ljavax/activation/DataHandler;->oldFactory:Ljavax/activation/DataContentHandlerFactory;

    .line 131
    return-void
.end method

.method static synthetic access$0(Ljavax/activation/DataHandler;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 100
    iget-object v0, p0, Ljavax/activation/DataHandler;->object:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$1(Ljavax/activation/DataHandler;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 101
    iget-object v0, p0, Ljavax/activation/DataHandler;->objectMimeType:Ljava/lang/String;

    return-object v0
.end method

.method private declared-synchronized getBaseType()Ljava/lang/String;
    .locals 2

    .prologue
    .line 648
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Ljavax/activation/DataHandler;->shortType:Ljava/lang/String;

    if-nez v0, :cond_0

    .line 649
    invoke-virtual {p0}, Ljavax/activation/DataHandler;->getContentType()Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 651
    :try_start_1
    new-instance v1, Ljavax/activation/MimeType;

    invoke-direct {v1, v0}, Ljavax/activation/MimeType;-><init>(Ljava/lang/String;)V

    .line 652
    invoke-virtual {v1}, Ljavax/activation/MimeType;->getBaseType()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Ljavax/activation/DataHandler;->shortType:Ljava/lang/String;
    :try_end_1
    .catch Ljavax/activation/MimeTypeParseException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 657
    :cond_0
    :goto_0
    :try_start_2
    iget-object v0, p0, Ljavax/activation/DataHandler;->shortType:Ljava/lang/String;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    monitor-exit p0

    return-object v0

    .line 653
    :catch_0
    move-exception v1

    .line 654
    :try_start_3
    iput-object v0, p0, Ljavax/activation/DataHandler;->shortType:Ljava/lang/String;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_0

    .line 648
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method private declared-synchronized getCommandMap()Ljavax/activation/CommandMap;
    .locals 1

    .prologue
    .line 164
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Ljavax/activation/DataHandler;->currentCommandMap:Ljavax/activation/CommandMap;

    if-eqz v0, :cond_0

    .line 165
    iget-object v0, p0, Ljavax/activation/DataHandler;->currentCommandMap:Ljavax/activation/CommandMap;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 167
    :goto_0
    monitor-exit p0

    return-object v0

    :cond_0
    :try_start_1
    invoke-static {}, Ljavax/activation/CommandMap;->getDefaultCommandMap()Ljavax/activation/CommandMap;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v0

    goto :goto_0

    .line 164
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method private declared-synchronized getDataContentHandler()Ljavax/activation/DataContentHandler;
    .locals 4

    .prologue
    .line 602
    monitor-enter p0

    :try_start_0
    sget-object v0, Ljavax/activation/DataHandler;->factory:Ljavax/activation/DataContentHandlerFactory;

    iget-object v1, p0, Ljavax/activation/DataHandler;->oldFactory:Ljavax/activation/DataContentHandlerFactory;

    if-eq v0, v1, :cond_0

    .line 603
    sget-object v0, Ljavax/activation/DataHandler;->factory:Ljavax/activation/DataContentHandlerFactory;

    iput-object v0, p0, Ljavax/activation/DataHandler;->oldFactory:Ljavax/activation/DataContentHandlerFactory;

    .line 604
    const/4 v0, 0x0

    iput-object v0, p0, Ljavax/activation/DataHandler;->factoryDCH:Ljavax/activation/DataContentHandler;

    .line 605
    const/4 v0, 0x0

    iput-object v0, p0, Ljavax/activation/DataHandler;->dataContentHandler:Ljavax/activation/DataContentHandler;

    .line 606
    sget-object v0, Ljavax/activation/DataHandler;->emptyFlavors:[Lmyjava/awt/datatransfer/DataFlavor;

    iput-object v0, p0, Ljavax/activation/DataHandler;->transferFlavors:[Lmyjava/awt/datatransfer/DataFlavor;

    .line 609
    :cond_0
    iget-object v0, p0, Ljavax/activation/DataHandler;->dataContentHandler:Ljavax/activation/DataContentHandler;

    if-eqz v0, :cond_1

    .line 610
    iget-object v0, p0, Ljavax/activation/DataHandler;->dataContentHandler:Ljavax/activation/DataContentHandler;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 640
    :goto_0
    monitor-exit p0

    return-object v0

    .line 612
    :cond_1
    :try_start_1
    invoke-direct {p0}, Ljavax/activation/DataHandler;->getBaseType()Ljava/lang/String;

    move-result-object v0

    .line 614
    iget-object v1, p0, Ljavax/activation/DataHandler;->factoryDCH:Ljavax/activation/DataContentHandler;

    if-nez v1, :cond_2

    sget-object v1, Ljavax/activation/DataHandler;->factory:Ljavax/activation/DataContentHandlerFactory;

    if-eqz v1, :cond_2

    .line 615
    sget-object v1, Ljavax/activation/DataHandler;->factory:Ljavax/activation/DataContentHandlerFactory;

    invoke-interface {v1, v0}, Ljavax/activation/DataContentHandlerFactory;->createDataContentHandler(Ljava/lang/String;)Ljavax/activation/DataContentHandler;

    move-result-object v1

    iput-object v1, p0, Ljavax/activation/DataHandler;->factoryDCH:Ljavax/activation/DataContentHandler;

    .line 617
    :cond_2
    iget-object v1, p0, Ljavax/activation/DataHandler;->factoryDCH:Ljavax/activation/DataContentHandler;

    if-eqz v1, :cond_3

    .line 618
    iget-object v1, p0, Ljavax/activation/DataHandler;->factoryDCH:Ljavax/activation/DataContentHandler;

    iput-object v1, p0, Ljavax/activation/DataHandler;->dataContentHandler:Ljavax/activation/DataContentHandler;

    .line 620
    :cond_3
    iget-object v1, p0, Ljavax/activation/DataHandler;->dataContentHandler:Ljavax/activation/DataContentHandler;

    if-nez v1, :cond_4

    .line 621
    iget-object v1, p0, Ljavax/activation/DataHandler;->dataSource:Ljavax/activation/DataSource;

    if-eqz v1, :cond_5

    .line 622
    invoke-direct {p0}, Ljavax/activation/DataHandler;->getCommandMap()Ljavax/activation/CommandMap;

    move-result-object v1

    .line 623
    iget-object v2, p0, Ljavax/activation/DataHandler;->dataSource:Ljavax/activation/DataSource;

    invoke-virtual {v1, v0, v2}, Ljavax/activation/CommandMap;->createDataContentHandler(Ljava/lang/String;Ljavax/activation/DataSource;)Ljavax/activation/DataContentHandler;

    move-result-object v0

    .line 622
    iput-object v0, p0, Ljavax/activation/DataHandler;->dataContentHandler:Ljavax/activation/DataContentHandler;

    .line 631
    :cond_4
    :goto_1
    iget-object v0, p0, Ljavax/activation/DataHandler;->dataSource:Ljavax/activation/DataSource;

    if-eqz v0, :cond_6

    .line 632
    new-instance v0, Ljavax/activation/DataSourceDataContentHandler;

    .line 633
    iget-object v1, p0, Ljavax/activation/DataHandler;->dataContentHandler:Ljavax/activation/DataContentHandler;

    .line 634
    iget-object v2, p0, Ljavax/activation/DataHandler;->dataSource:Ljavax/activation/DataSource;

    invoke-direct {v0, v1, v2}, Ljavax/activation/DataSourceDataContentHandler;-><init>(Ljavax/activation/DataContentHandler;Ljavax/activation/DataSource;)V

    .line 632
    iput-object v0, p0, Ljavax/activation/DataHandler;->dataContentHandler:Ljavax/activation/DataContentHandler;

    .line 640
    :goto_2
    iget-object v0, p0, Ljavax/activation/DataHandler;->dataContentHandler:Ljavax/activation/DataContentHandler;

    goto :goto_0

    .line 625
    :cond_5
    invoke-direct {p0}, Ljavax/activation/DataHandler;->getCommandMap()Ljavax/activation/CommandMap;

    move-result-object v1

    .line 626
    invoke-virtual {v1, v0}, Ljavax/activation/CommandMap;->createDataContentHandler(Ljava/lang/String;)Ljavax/activation/DataContentHandler;

    move-result-object v0

    .line 625
    iput-object v0, p0, Ljavax/activation/DataHandler;->dataContentHandler:Ljavax/activation/DataContentHandler;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    .line 602
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    .line 636
    :cond_6
    :try_start_2
    new-instance v0, Ljavax/activation/ObjectDataContentHandler;

    .line 637
    iget-object v1, p0, Ljavax/activation/DataHandler;->dataContentHandler:Ljavax/activation/DataContentHandler;

    .line 638
    iget-object v2, p0, Ljavax/activation/DataHandler;->object:Ljava/lang/Object;

    .line 639
    iget-object v3, p0, Ljavax/activation/DataHandler;->objectMimeType:Ljava/lang/String;

    invoke-direct {v0, v1, v2, v3}, Ljavax/activation/ObjectDataContentHandler;-><init>(Ljavax/activation/DataContentHandler;Ljava/lang/Object;Ljava/lang/String;)V

    .line 636
    iput-object v0, p0, Ljavax/activation/DataHandler;->dataContentHandler:Ljavax/activation/DataContentHandler;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_2
.end method

.method public static declared-synchronized setDataContentHandlerFactory(Ljavax/activation/DataContentHandlerFactory;)V
    .locals 4

    .prologue
    .line 675
    const-class v1, Ljavax/activation/DataHandler;

    monitor-enter v1

    :try_start_0
    sget-object v0, Ljavax/activation/DataHandler;->factory:Ljavax/activation/DataContentHandlerFactory;

    if-eqz v0, :cond_0

    .line 676
    new-instance v0, Ljava/lang/Error;

    const-string v2, "DataContentHandlerFactory already defined"

    invoke-direct {v0, v2}, Ljava/lang/Error;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 675
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0

    .line 678
    :cond_0
    :try_start_1
    invoke-static {}, Ljava/lang/System;->getSecurityManager()Ljava/lang/SecurityManager;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v0

    .line 679
    if-eqz v0, :cond_1

    .line 682
    :try_start_2
    invoke-virtual {v0}, Ljava/lang/SecurityManager;->checkSetFactory()V
    :try_end_2
    .catch Ljava/lang/SecurityException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 692
    :cond_1
    :try_start_3
    sput-object p0, Ljavax/activation/DataHandler;->factory:Ljavax/activation/DataContentHandlerFactory;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 693
    monitor-exit v1

    return-void

    .line 683
    :catch_0
    move-exception v0

    .line 687
    :try_start_4
    const-class v2, Ljavax/activation/DataHandler;

    invoke-virtual {v2}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v2

    .line 688
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v3

    .line 687
    if-eq v2, v3, :cond_1

    .line 689
    throw v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0
.end method


# virtual methods
.method public getAllCommands()[Ljavax/activation/CommandInfo;
    .locals 3

    .prologue
    .line 503
    iget-object v0, p0, Ljavax/activation/DataHandler;->dataSource:Ljavax/activation/DataSource;

    if-eqz v0, :cond_0

    .line 504
    invoke-direct {p0}, Ljavax/activation/DataHandler;->getCommandMap()Ljavax/activation/CommandMap;

    move-result-object v0

    invoke-direct {p0}, Ljavax/activation/DataHandler;->getBaseType()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Ljavax/activation/DataHandler;->dataSource:Ljavax/activation/DataSource;

    invoke-virtual {v0, v1, v2}, Ljavax/activation/CommandMap;->getAllCommands(Ljava/lang/String;Ljavax/activation/DataSource;)[Ljavax/activation/CommandInfo;

    move-result-object v0

    .line 506
    :goto_0
    return-object v0

    :cond_0
    invoke-direct {p0}, Ljavax/activation/DataHandler;->getCommandMap()Ljavax/activation/CommandMap;

    move-result-object v0

    invoke-direct {p0}, Ljavax/activation/DataHandler;->getBaseType()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljavax/activation/CommandMap;->getAllCommands(Ljava/lang/String;)[Ljavax/activation/CommandInfo;

    move-result-object v0

    goto :goto_0
.end method

.method public getBean(Ljavax/activation/CommandInfo;)Ljava/lang/Object;
    .locals 2

    .prologue
    .line 566
    const/4 v0, 0x0

    .line 572
    :try_start_0
    invoke-static {}, Ljavax/activation/SecuritySupport;->getContextClassLoader()Ljava/lang/ClassLoader;

    move-result-object v1

    .line 573
    if-nez v1, :cond_0

    .line 574
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v1

    .line 575
    :cond_0
    invoke-virtual {p1, p0, v1}, Ljavax/activation/CommandInfo;->getCommandObject(Ljavax/activation/DataHandler;Ljava/lang/ClassLoader;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 579
    :goto_0
    return-object v0

    .line 577
    :catch_0
    move-exception v1

    goto :goto_0

    .line 576
    :catch_1
    move-exception v1

    goto :goto_0
.end method

.method public getCommand(Ljava/lang/String;)Ljavax/activation/CommandInfo;
    .locals 3

    .prologue
    .line 522
    iget-object v0, p0, Ljavax/activation/DataHandler;->dataSource:Ljavax/activation/DataSource;

    if-eqz v0, :cond_0

    .line 523
    invoke-direct {p0}, Ljavax/activation/DataHandler;->getCommandMap()Ljavax/activation/CommandMap;

    move-result-object v0

    invoke-direct {p0}, Ljavax/activation/DataHandler;->getBaseType()Ljava/lang/String;

    move-result-object v1

    .line 524
    iget-object v2, p0, Ljavax/activation/DataHandler;->dataSource:Ljavax/activation/DataSource;

    .line 523
    invoke-virtual {v0, v1, p1, v2}, Ljavax/activation/CommandMap;->getCommand(Ljava/lang/String;Ljava/lang/String;Ljavax/activation/DataSource;)Ljavax/activation/CommandInfo;

    move-result-object v0

    .line 526
    :goto_0
    return-object v0

    :cond_0
    invoke-direct {p0}, Ljavax/activation/DataHandler;->getCommandMap()Ljavax/activation/CommandMap;

    move-result-object v0

    invoke-direct {p0}, Ljavax/activation/DataHandler;->getBaseType()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, p1}, Ljavax/activation/CommandMap;->getCommand(Ljava/lang/String;Ljava/lang/String;)Ljavax/activation/CommandInfo;

    move-result-object v0

    goto :goto_0
.end method

.method public getContent()Ljava/lang/Object;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 547
    iget-object v0, p0, Ljavax/activation/DataHandler;->object:Ljava/lang/Object;

    if-eqz v0, :cond_0

    .line 548
    iget-object v0, p0, Ljavax/activation/DataHandler;->object:Ljava/lang/Object;

    .line 550
    :goto_0
    return-object v0

    :cond_0
    invoke-direct {p0}, Ljavax/activation/DataHandler;->getDataContentHandler()Ljavax/activation/DataContentHandler;

    move-result-object v0

    invoke-virtual {p0}, Ljavax/activation/DataHandler;->getDataSource()Ljavax/activation/DataSource;

    move-result-object v1

    invoke-interface {v0, v1}, Ljavax/activation/DataContentHandler;->getContent(Ljavax/activation/DataSource;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0
.end method

.method public getContentType()Ljava/lang/String;
    .locals 1

    .prologue
    .line 217
    iget-object v0, p0, Ljavax/activation/DataHandler;->dataSource:Ljavax/activation/DataSource;

    if-eqz v0, :cond_0

    .line 218
    iget-object v0, p0, Ljavax/activation/DataHandler;->dataSource:Ljavax/activation/DataSource;

    invoke-interface {v0}, Ljavax/activation/DataSource;->getContentType()Ljava/lang/String;

    move-result-object v0

    .line 220
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Ljavax/activation/DataHandler;->objectMimeType:Ljava/lang/String;

    goto :goto_0
.end method

.method public getDataSource()Ljavax/activation/DataSource;
    .locals 1

    .prologue
    .line 185
    iget-object v0, p0, Ljavax/activation/DataHandler;->dataSource:Ljavax/activation/DataSource;

    if-nez v0, :cond_1

    .line 187
    iget-object v0, p0, Ljavax/activation/DataHandler;->objDataSource:Ljavax/activation/DataSource;

    if-nez v0, :cond_0

    .line 188
    new-instance v0, Ljavax/activation/DataHandlerDataSource;

    invoke-direct {v0, p0}, Ljavax/activation/DataHandlerDataSource;-><init>(Ljavax/activation/DataHandler;)V

    iput-object v0, p0, Ljavax/activation/DataHandler;->objDataSource:Ljavax/activation/DataSource;

    .line 189
    :cond_0
    iget-object v0, p0, Ljavax/activation/DataHandler;->objDataSource:Ljavax/activation/DataSource;

    .line 191
    :goto_0
    return-object v0

    :cond_1
    iget-object v0, p0, Ljavax/activation/DataHandler;->dataSource:Ljavax/activation/DataSource;

    goto :goto_0
.end method

.method public getInputStream()Ljava/io/InputStream;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 248
    .line 250
    iget-object v0, p0, Ljavax/activation/DataHandler;->dataSource:Ljavax/activation/DataSource;

    if-eqz v0, :cond_0

    .line 251
    iget-object v0, p0, Ljavax/activation/DataHandler;->dataSource:Ljavax/activation/DataSource;

    invoke-interface {v0}, Ljavax/activation/DataSource;->getInputStream()Ljava/io/InputStream;

    move-result-object v0

    .line 293
    :goto_0
    return-object v0

    .line 253
    :cond_0
    invoke-direct {p0}, Ljavax/activation/DataHandler;->getDataContentHandler()Ljavax/activation/DataContentHandler;

    move-result-object v1

    .line 255
    if-nez v1, :cond_1

    .line 256
    new-instance v0, Ljavax/activation/UnsupportedDataTypeException;

    .line 257
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "no DCH for MIME type "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-direct {p0}, Ljavax/activation/DataHandler;->getBaseType()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 256
    invoke-direct {v0, v1}, Ljavax/activation/UnsupportedDataTypeException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 259
    :cond_1
    instance-of v0, v1, Ljavax/activation/ObjectDataContentHandler;

    if-eqz v0, :cond_2

    move-object v0, v1

    .line 260
    check-cast v0, Ljavax/activation/ObjectDataContentHandler;

    invoke-virtual {v0}, Ljavax/activation/ObjectDataContentHandler;->getDCH()Ljavax/activation/DataContentHandler;

    move-result-object v0

    if-nez v0, :cond_2

    .line 261
    new-instance v0, Ljavax/activation/UnsupportedDataTypeException;

    .line 262
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "no object DCH for MIME type "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-direct {p0}, Ljavax/activation/DataHandler;->getBaseType()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 261
    invoke-direct {v0, v1}, Ljavax/activation/UnsupportedDataTypeException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 273
    :cond_2
    new-instance v2, Ljava/io/PipedOutputStream;

    invoke-direct {v2}, Ljava/io/PipedOutputStream;-><init>()V

    .line 274
    new-instance v0, Ljava/io/PipedInputStream;

    invoke-direct {v0, v2}, Ljava/io/PipedInputStream;-><init>(Ljava/io/PipedOutputStream;)V

    .line 275
    new-instance v3, Ljava/lang/Thread;

    .line 276
    new-instance v4, Ljavax/activation/DataHandler$1;

    invoke-direct {v4, p0, v2, v1}, Ljavax/activation/DataHandler$1;-><init>(Ljavax/activation/DataHandler;Ljava/io/PipedOutputStream;Ljavax/activation/DataContentHandler;)V

    .line 289
    const-string v1, "DataHandler.getInputStream"

    .line 275
    invoke-direct {v3, v4, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 289
    invoke-virtual {v3}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method public getName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 203
    iget-object v0, p0, Ljavax/activation/DataHandler;->dataSource:Ljavax/activation/DataSource;

    if-eqz v0, :cond_0

    .line 204
    iget-object v0, p0, Ljavax/activation/DataHandler;->dataSource:Ljavax/activation/DataSource;

    invoke-interface {v0}, Ljavax/activation/DataSource;->getName()Ljava/lang/String;

    move-result-object v0

    .line 206
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public getOutputStream()Ljava/io/OutputStream;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 347
    iget-object v0, p0, Ljavax/activation/DataHandler;->dataSource:Ljavax/activation/DataSource;

    if-eqz v0, :cond_0

    .line 348
    iget-object v0, p0, Ljavax/activation/DataHandler;->dataSource:Ljavax/activation/DataSource;

    invoke-interface {v0}, Ljavax/activation/DataSource;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v0

    .line 350
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public getPreferredCommands()[Ljavax/activation/CommandInfo;
    .locals 3

    .prologue
    .line 483
    iget-object v0, p0, Ljavax/activation/DataHandler;->dataSource:Ljavax/activation/DataSource;

    if-eqz v0, :cond_0

    .line 484
    invoke-direct {p0}, Ljavax/activation/DataHandler;->getCommandMap()Ljavax/activation/CommandMap;

    move-result-object v0

    invoke-direct {p0}, Ljavax/activation/DataHandler;->getBaseType()Ljava/lang/String;

    move-result-object v1

    .line 485
    iget-object v2, p0, Ljavax/activation/DataHandler;->dataSource:Ljavax/activation/DataSource;

    .line 484
    invoke-virtual {v0, v1, v2}, Ljavax/activation/CommandMap;->getPreferredCommands(Ljava/lang/String;Ljavax/activation/DataSource;)[Ljavax/activation/CommandInfo;

    move-result-object v0

    .line 487
    :goto_0
    return-object v0

    :cond_0
    invoke-direct {p0}, Ljavax/activation/DataHandler;->getCommandMap()Ljavax/activation/CommandMap;

    move-result-object v0

    invoke-direct {p0}, Ljavax/activation/DataHandler;->getBaseType()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljavax/activation/CommandMap;->getPreferredCommands(Ljava/lang/String;)[Ljavax/activation/CommandInfo;

    move-result-object v0

    goto :goto_0
.end method

.method public getTransferData(Lmyjava/awt/datatransfer/DataFlavor;)Ljava/lang/Object;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lmyjava/awt/datatransfer/UnsupportedFlavorException;,
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 444
    invoke-direct {p0}, Ljavax/activation/DataHandler;->getDataContentHandler()Ljavax/activation/DataContentHandler;

    move-result-object v0

    iget-object v1, p0, Ljavax/activation/DataHandler;->dataSource:Ljavax/activation/DataSource;

    invoke-interface {v0, p1, v1}, Ljavax/activation/DataContentHandler;->getTransferData(Lmyjava/awt/datatransfer/DataFlavor;Ljavax/activation/DataSource;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public declared-synchronized getTransferDataFlavors()[Lmyjava/awt/datatransfer/DataFlavor;
    .locals 2

    .prologue
    .line 378
    monitor-enter p0

    :try_start_0
    sget-object v0, Ljavax/activation/DataHandler;->factory:Ljavax/activation/DataContentHandlerFactory;

    iget-object v1, p0, Ljavax/activation/DataHandler;->oldFactory:Ljavax/activation/DataContentHandlerFactory;

    if-eq v0, v1, :cond_0

    .line 379
    sget-object v0, Ljavax/activation/DataHandler;->emptyFlavors:[Lmyjava/awt/datatransfer/DataFlavor;

    iput-object v0, p0, Ljavax/activation/DataHandler;->transferFlavors:[Lmyjava/awt/datatransfer/DataFlavor;

    .line 382
    :cond_0
    iget-object v0, p0, Ljavax/activation/DataHandler;->transferFlavors:[Lmyjava/awt/datatransfer/DataFlavor;

    sget-object v1, Ljavax/activation/DataHandler;->emptyFlavors:[Lmyjava/awt/datatransfer/DataFlavor;

    if-ne v0, v1, :cond_1

    .line 383
    invoke-direct {p0}, Ljavax/activation/DataHandler;->getDataContentHandler()Ljavax/activation/DataContentHandler;

    move-result-object v0

    invoke-interface {v0}, Ljavax/activation/DataContentHandler;->getTransferDataFlavors()[Lmyjava/awt/datatransfer/DataFlavor;

    move-result-object v0

    iput-object v0, p0, Ljavax/activation/DataHandler;->transferFlavors:[Lmyjava/awt/datatransfer/DataFlavor;

    .line 384
    :cond_1
    iget-object v0, p0, Ljavax/activation/DataHandler;->transferFlavors:[Lmyjava/awt/datatransfer/DataFlavor;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 378
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public isDataFlavorSupported(Lmyjava/awt/datatransfer/DataFlavor;)Z
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 400
    invoke-virtual {p0}, Ljavax/activation/DataHandler;->getTransferDataFlavors()[Lmyjava/awt/datatransfer/DataFlavor;

    move-result-object v2

    move v0, v1

    .line 402
    :goto_0
    array-length v3, v2

    if-lt v0, v3, :cond_0

    .line 406
    :goto_1
    return v1

    .line 403
    :cond_0
    aget-object v3, v2, v0

    invoke-virtual {v3, p1}, Lmyjava/awt/datatransfer/DataFlavor;->equals(Lmyjava/awt/datatransfer/DataFlavor;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 404
    const/4 v1, 0x1

    goto :goto_1

    .line 402
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method

.method public declared-synchronized setCommandMap(Ljavax/activation/CommandMap;)V
    .locals 1

    .prologue
    .line 460
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Ljavax/activation/DataHandler;->currentCommandMap:Ljavax/activation/CommandMap;

    if-ne p1, v0, :cond_0

    if-nez p1, :cond_1

    .line 462
    :cond_0
    sget-object v0, Ljavax/activation/DataHandler;->emptyFlavors:[Lmyjava/awt/datatransfer/DataFlavor;

    iput-object v0, p0, Ljavax/activation/DataHandler;->transferFlavors:[Lmyjava/awt/datatransfer/DataFlavor;

    .line 463
    const/4 v0, 0x0

    iput-object v0, p0, Ljavax/activation/DataHandler;->dataContentHandler:Ljavax/activation/DataContentHandler;

    .line 465
    iput-object p1, p0, Ljavax/activation/DataHandler;->currentCommandMap:Ljavax/activation/CommandMap;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 467
    :cond_1
    monitor-exit p0

    return-void

    .line 460
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public writeTo(Ljava/io/OutputStream;)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 313
    iget-object v0, p0, Ljavax/activation/DataHandler;->dataSource:Ljavax/activation/DataSource;

    if-eqz v0, :cond_1

    .line 315
    const/16 v0, 0x2000

    new-array v0, v0, [B

    .line 318
    iget-object v1, p0, Ljavax/activation/DataHandler;->dataSource:Ljavax/activation/DataSource;

    invoke-interface {v1}, Ljavax/activation/DataSource;->getInputStream()Ljava/io/InputStream;

    move-result-object v1

    .line 321
    :goto_0
    :try_start_0
    invoke-virtual {v1, v0}, Ljava/io/InputStream;->read([B)I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v2

    if-gtz v2, :cond_0

    .line 325
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V

    .line 332
    :goto_1
    return-void

    .line 322
    :cond_0
    const/4 v3, 0x0

    :try_start_1
    invoke-virtual {p1, v0, v3, v2}, Ljava/io/OutputStream;->write([BII)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 324
    :catchall_0
    move-exception v0

    .line 325
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V

    .line 327
    throw v0

    .line 329
    :cond_1
    invoke-direct {p0}, Ljavax/activation/DataHandler;->getDataContentHandler()Ljavax/activation/DataContentHandler;

    move-result-object v0

    .line 330
    iget-object v1, p0, Ljavax/activation/DataHandler;->object:Ljava/lang/Object;

    iget-object v2, p0, Ljavax/activation/DataHandler;->objectMimeType:Ljava/lang/String;

    invoke-interface {v0, v1, v2, p1}, Ljavax/activation/DataContentHandler;->writeTo(Ljava/lang/Object;Ljava/lang/String;Ljava/io/OutputStream;)V

    goto :goto_1
.end method
