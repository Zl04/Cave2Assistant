.class public Ljavax/activation/MailcapCommandMap;
.super Ljavax/activation/CommandMap;
.source "SourceFile"


# static fields
.field private static final PROG:I

.field private static defDB:Lcom/sun/activation/registries/MailcapFile;


# instance fields
.field private DB:[Lcom/sun/activation/registries/MailcapFile;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 140
    const/4 v0, 0x0

    sput-object v0, Ljavax/activation/MailcapCommandMap;->defDB:Lcom/sun/activation/registries/MailcapFile;

    .line 133
    return-void
.end method

.method public constructor <init>()V
    .locals 3

    .prologue
    .line 148
    invoke-direct {p0}, Ljavax/activation/CommandMap;-><init>()V

    .line 149
    new-instance v0, Ljava/util/ArrayList;

    const/4 v1, 0x5

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    .line 151
    const/4 v1, 0x0

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 153
    const-string v1, "MailcapCommandMap: load HOME"

    invoke-static {v1}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V

    .line 155
    :try_start_0
    const-string v1, "user.home"

    invoke-static {v1}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 157
    if-eqz v1, :cond_0

    .line 158
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v2, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-object v1, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ".mailcap"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 159
    invoke-direct {p0, v1}, Ljavax/activation/MailcapCommandMap;->loadFile(Ljava/lang/String;)Lcom/sun/activation/registries/MailcapFile;

    move-result-object v1

    .line 160
    if-eqz v1, :cond_0

    .line 161
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_1

    .line 165
    :cond_0
    :goto_0
    const-string v1, "MailcapCommandMap: load SYS"

    invoke-static {v1}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V

    .line 168
    :try_start_1
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "java.home"

    invoke-static {v2}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 169
    sget-object v2, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "lib"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "mailcap"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 168
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 170
    invoke-direct {p0, v1}, Ljavax/activation/MailcapCommandMap;->loadFile(Ljava/lang/String;)Lcom/sun/activation/registries/MailcapFile;

    move-result-object v1

    .line 171
    if-eqz v1, :cond_1

    .line 172
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Ljava/lang/SecurityException; {:try_start_1 .. :try_end_1} :catch_0

    .line 175
    :cond_1
    :goto_1
    const-string v1, "MailcapCommandMap: load JAR"

    invoke-static {v1}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V

    .line 177
    const-string v1, "mailcap"

    invoke-direct {p0, v0, v1}, Ljavax/activation/MailcapCommandMap;->loadAllResources(Ljava/util/List;Ljava/lang/String;)V

    .line 179
    const-string v1, "MailcapCommandMap: load DEF"

    invoke-static {v1}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V

    .line 180
    const-class v1, Ljavax/activation/MailcapCommandMap;

    monitor-enter v1

    .line 182
    :try_start_2
    sget-object v2, Ljavax/activation/MailcapCommandMap;->defDB:Lcom/sun/activation/registries/MailcapFile;

    if-nez v2, :cond_2

    .line 183
    const-string v2, "mailcap.default"

    invoke-direct {p0, v2}, Ljavax/activation/MailcapCommandMap;->loadResource(Ljava/lang/String;)Lcom/sun/activation/registries/MailcapFile;

    move-result-object v2

    sput-object v2, Ljavax/activation/MailcapCommandMap;->defDB:Lcom/sun/activation/registries/MailcapFile;

    .line 180
    :cond_2
    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 186
    sget-object v1, Ljavax/activation/MailcapCommandMap;->defDB:Lcom/sun/activation/registries/MailcapFile;

    if-eqz v1, :cond_3

    .line 187
    sget-object v1, Ljavax/activation/MailcapCommandMap;->defDB:Lcom/sun/activation/registries/MailcapFile;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 189
    :cond_3
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    new-array v1, v1, [Lcom/sun/activation/registries/MailcapFile;

    iput-object v1, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    .line 190
    iget-object v1, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    invoke-interface {v0, v1}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/sun/activation/registries/MailcapFile;

    iput-object v0, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    .line 191
    return-void

    .line 180
    :catchall_0
    move-exception v0

    :try_start_3
    monitor-exit v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw v0

    .line 173
    :catch_0
    move-exception v1

    goto :goto_1

    .line 163
    :catch_1
    move-exception v1

    goto :goto_0
.end method

.method public constructor <init>(Ljava/io/InputStream;)V
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 336
    invoke-direct {p0}, Ljavax/activation/MailcapCommandMap;-><init>()V

    .line 338
    const-string v0, "MailcapCommandMap: load PROG"

    invoke-static {v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V

    .line 339
    iget-object v0, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    aget-object v0, v0, v1

    if-nez v0, :cond_0

    .line 341
    :try_start_0
    iget-object v0, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    const/4 v1, 0x0

    new-instance v2, Lcom/sun/activation/registries/MailcapFile;

    invoke-direct {v2, p1}, Lcom/sun/activation/registries/MailcapFile;-><init>(Ljava/io/InputStream;)V

    aput-object v2, v0, v1
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 346
    :cond_0
    :goto_0
    return-void

    .line 342
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 319
    invoke-direct {p0}, Ljavax/activation/MailcapCommandMap;-><init>()V

    .line 321
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 322
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "MailcapCommandMap: load PROG from "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V

    .line 323
    :cond_0
    iget-object v0, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    aget-object v0, v0, v2

    if-nez v0, :cond_1

    .line 324
    iget-object v0, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    new-instance v1, Lcom/sun/activation/registries/MailcapFile;

    invoke-direct {v1, p1}, Lcom/sun/activation/registries/MailcapFile;-><init>(Ljava/lang/String;)V

    aput-object v1, v0, v2

    .line 326
    :cond_1
    return-void
.end method

.method private appendCmdsToList(Ljava/util/Map;Ljava/util/List;)V
    .locals 5

    .prologue
    .line 459
    invoke-interface {p1}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    .line 461
    :cond_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_1

    .line 472
    return-void

    .line 462
    :cond_1
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 463
    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/List;

    .line 464
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    .line 466
    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 467
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 468
    new-instance v4, Ljavax/activation/CommandInfo;

    invoke-direct {v4, v0, v1}, Ljavax/activation/CommandInfo;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-interface {p2, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0
.end method

.method private appendPrefCmdsToList(Ljava/util/Map;Ljava/util/List;)V
    .locals 4

    .prologue
    .line 393
    invoke-interface {p1}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    .line 395
    :cond_0
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_1

    .line 403
    return-void

    .line 396
    :cond_1
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 397
    invoke-direct {p0, p2, v0}, Ljavax/activation/MailcapCommandMap;->checkForVerb(Ljava/util/List;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 398
    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/List;

    .line 399
    const/4 v3, 0x0

    invoke-interface {v1, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 400
    new-instance v3, Ljavax/activation/CommandInfo;

    invoke-direct {v3, v0, v1}, Ljavax/activation/CommandInfo;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-interface {p2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0
.end method

.method private checkForVerb(Ljava/util/List;Ljava/lang/String;)Z
    .locals 2

    .prologue
    .line 410
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .line 411
    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_1

    .line 417
    const/4 v0, 0x0

    :goto_0
    return v0

    .line 413
    :cond_1
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljavax/activation/CommandInfo;

    invoke-virtual {v0}, Ljavax/activation/CommandInfo;->getCommandName()Ljava/lang/String;

    move-result-object v0

    .line 414
    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 415
    const/4 v0, 0x1

    goto :goto_0
.end method

.method private getDataContentHandler(Ljava/lang/String;)Ljavax/activation/DataContentHandler;
    .locals 3

    .prologue
    .line 591
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 592
    const-string v0, "    got content-handler"

    invoke-static {v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V

    .line 593
    :cond_0
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 594
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "      class "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V

    .line 598
    :cond_1
    :try_start_0
    invoke-static {}, Ljavax/activation/SecuritySupport;->getContextClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    .line 599
    if-nez v0, :cond_2

    .line 600
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;
    :try_end_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/InstantiationException; {:try_start_0 .. :try_end_0} :catch_3

    move-result-object v0

    .line 603
    :cond_2
    :try_start_1
    invoke-virtual {v0, p1}, Ljava/lang/ClassLoader;->loadClass(Ljava/lang/String;)Ljava/lang/Class;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/ClassNotFoundException; {:try_start_1 .. :try_end_1} :catch_2
    .catch Ljava/lang/InstantiationException; {:try_start_1 .. :try_end_1} :catch_3

    move-result-object v0

    .line 608
    :goto_0
    if-eqz v0, :cond_3

    .line 609
    :try_start_2
    invoke-virtual {v0}, Ljava/lang/Class;->newInstance()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljavax/activation/DataContentHandler;

    .line 620
    :goto_1
    return-object v0

    .line 604
    :catch_0
    move-exception v0

    .line 606
    invoke-static {p1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;
    :try_end_2
    .catch Ljava/lang/IllegalAccessException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/lang/ClassNotFoundException; {:try_start_2 .. :try_end_2} :catch_2
    .catch Ljava/lang/InstantiationException; {:try_start_2 .. :try_end_2} :catch_3

    move-result-object v0

    goto :goto_0

    .line 610
    :catch_1
    move-exception v0

    .line 611
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v1

    if-eqz v1, :cond_3

    .line 612
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Can\'t load DCH "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 620
    :cond_3
    :goto_2
    const/4 v0, 0x0

    goto :goto_1

    .line 613
    :catch_2
    move-exception v0

    .line 614
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v1

    if-eqz v1, :cond_3

    .line 615
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Can\'t load DCH "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_2

    .line 616
    :catch_3
    move-exception v0

    .line 617
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v1

    if-eqz v1, :cond_3

    .line 618
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Can\'t load DCH "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_2
.end method

.method private loadAllResources(Ljava/util/List;Ljava/lang/String;)V
    .locals 9

    .prologue
    const/4 v2, 0x0

    .line 230
    .line 235
    :try_start_0
    invoke-static {}, Ljavax/activation/SecuritySupport;->getContextClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    .line 236
    if-nez v0, :cond_0

    .line 237
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    .line 238
    :cond_0
    if-eqz v0, :cond_5

    .line 239
    invoke-static {v0, p2}, Ljavax/activation/SecuritySupport;->getResources(Ljava/lang/ClassLoader;Ljava/lang/String;)[Ljava/net/URL;

    move-result-object v0

    move-object v4, v0

    .line 242
    :goto_0
    if-eqz v4, :cond_2

    .line 243
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 244
    const-string v0, "MailcapCommandMap: getResources"

    invoke-static {v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V

    :cond_1
    move v3, v2

    .line 245
    :goto_1
    array-length v0, v4
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_4

    if-lt v3, v0, :cond_6

    .line 288
    :cond_2
    :goto_2
    if-nez v2, :cond_4

    .line 289
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 290
    const-string v0, "MailcapCommandMap: !anyLoaded"

    invoke-static {v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V

    .line 291
    :cond_3
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "/"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Ljavax/activation/MailcapCommandMap;->loadResource(Ljava/lang/String;)Lcom/sun/activation/registries/MailcapFile;

    move-result-object v0

    .line 292
    if-eqz v0, :cond_4

    .line 293
    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 295
    :cond_4
    return-void

    .line 241
    :cond_5
    :try_start_1
    invoke-static {p2}, Ljavax/activation/SecuritySupport;->getSystemResources(Ljava/lang/String;)[Ljava/net/URL;

    move-result-object v0

    move-object v4, v0

    goto :goto_0

    .line 246
    :cond_6
    aget-object v5, v4, v3

    .line 247
    const/4 v1, 0x0

    .line 248
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v0

    if-eqz v0, :cond_7

    .line 249
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v6, "MailcapCommandMap: URL "

    invoke-direct {v0, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_4

    .line 251
    :cond_7
    :try_start_2
    invoke-static {v5}, Ljavax/activation/SecuritySupport;->openStream(Ljava/net/URL;)Ljava/io/InputStream;
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/SecurityException; {:try_start_2 .. :try_end_2} :catch_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-result-object v1

    .line 252
    if-eqz v1, :cond_9

    .line 253
    :try_start_3
    new-instance v0, Lcom/sun/activation/registries/MailcapFile;

    invoke-direct {v0, v1}, Lcom/sun/activation/registries/MailcapFile;-><init>(Ljava/io/InputStream;)V

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 254
    const/4 v2, 0x1

    .line 255
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v0

    if-eqz v0, :cond_d

    .line 256
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v6, "MailcapCommandMap: successfully loaded mailcap file from URL: "

    invoke-direct {v0, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 259
    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 256
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_9
    .catch Ljava/lang/SecurityException; {:try_start_3 .. :try_end_3} :catch_8
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move v0, v2

    .line 276
    :goto_3
    if-eqz v1, :cond_8

    .line 277
    :try_start_4
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_6
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_7

    .line 245
    :cond_8
    :goto_4
    add-int/lit8 v2, v3, 0x1

    move v3, v2

    move v2, v0

    goto :goto_1

    .line 261
    :cond_9
    :try_start_5
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v0

    if-eqz v0, :cond_d

    .line 262
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v6, "MailcapCommandMap: not loading mailcap file from URL: "

    invoke-direct {v0, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 264
    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 262
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_9
    .catch Ljava/lang/SecurityException; {:try_start_5 .. :try_end_5} :catch_8
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    move v0, v2

    goto :goto_3

    .line 266
    :catch_0
    move-exception v0

    move-object v8, v0

    move v0, v2

    move-object v2, v1

    move-object v1, v8

    .line 267
    :goto_5
    :try_start_6
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v6

    if-eqz v6, :cond_a

    .line 268
    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "MailcapCommandMap: can\'t load "

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 269
    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    .line 268
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v1}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    .line 276
    :cond_a
    if-eqz v2, :cond_8

    .line 277
    :try_start_7
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_1
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_7

    goto :goto_4

    .line 278
    :catch_1
    move-exception v1

    goto :goto_4

    .line 270
    :catch_2
    move-exception v0

    move-object v8, v0

    move v0, v2

    move-object v2, v1

    move-object v1, v8

    .line 271
    :goto_6
    :try_start_8
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v6

    if-eqz v6, :cond_b

    .line 272
    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "MailcapCommandMap: can\'t load "

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 273
    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    .line 272
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v1}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_1

    .line 276
    :cond_b
    if-eqz v2, :cond_8

    .line 277
    :try_start_9
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_9
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_3
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_7

    goto :goto_4

    .line 278
    :catch_3
    move-exception v1

    goto :goto_4

    .line 274
    :catchall_0
    move-exception v0

    .line 276
    :goto_7
    if-eqz v1, :cond_c

    .line 277
    :try_start_a
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_a
    .catch Ljava/io/IOException; {:try_start_a .. :try_end_a} :catch_5
    .catch Ljava/lang/Exception; {:try_start_a .. :try_end_a} :catch_4

    .line 279
    :cond_c
    :goto_8
    :try_start_b
    throw v0
    :try_end_b
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_b} :catch_4

    .line 282
    :catch_4
    move-exception v0

    .line 283
    :goto_9
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 284
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v3, "MailcapCommandMap: can\'t load "

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_2

    .line 278
    :catch_5
    move-exception v1

    goto :goto_8

    :catch_6
    move-exception v1

    goto/16 :goto_4

    .line 282
    :catch_7
    move-exception v1

    move v2, v0

    move-object v0, v1

    goto :goto_9

    .line 274
    :catchall_1
    move-exception v1

    move-object v8, v1

    move-object v1, v2

    move v2, v0

    move-object v0, v8

    goto :goto_7

    .line 270
    :catch_8
    move-exception v0

    move-object v8, v0

    move v0, v2

    move-object v2, v1

    move-object v1, v8

    goto :goto_6

    .line 266
    :catch_9
    move-exception v0

    move-object v8, v0

    move v0, v2

    move-object v2, v1

    move-object v1, v8

    goto/16 :goto_5

    :cond_d
    move v0, v2

    goto/16 :goto_3
.end method

.method private loadFile(Ljava/lang/String;)Lcom/sun/activation/registries/MailcapFile;
    .locals 2

    .prologue
    .line 301
    const/4 v1, 0x0

    .line 304
    :try_start_0
    new-instance v0, Lcom/sun/activation/registries/MailcapFile;

    invoke-direct {v0, p1}, Lcom/sun/activation/registries/MailcapFile;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 308
    :goto_0
    return-object v0

    .line 305
    :catch_0
    move-exception v0

    move-object v0, v1

    goto :goto_0
.end method

.method private loadResource(Ljava/lang/String;)Lcom/sun/activation/registries/MailcapFile;
    .locals 5

    .prologue
    const/4 v1, 0x0

    .line 197
    .line 199
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-static {v0, p1}, Ljavax/activation/SecuritySupport;->getResourceAsStream(Ljava/lang/Class;Ljava/lang/String;)Ljava/io/InputStream;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v2

    .line 200
    if-eqz v2, :cond_2

    .line 201
    :try_start_1
    new-instance v0, Lcom/sun/activation/registries/MailcapFile;

    invoke-direct {v0, v2}, Lcom/sun/activation/registries/MailcapFile;-><init>(Ljava/io/InputStream;)V

    .line 202
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v3

    if-eqz v3, :cond_0

    .line 203
    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "MailcapCommandMap: successfully loaded mailcap file: "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 204
    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    .line 203
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_8
    .catch Ljava/lang/SecurityException; {:try_start_1 .. :try_end_1} :catch_7
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 219
    :cond_0
    if-eqz v2, :cond_1

    .line 220
    :try_start_2
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_4

    .line 223
    :cond_1
    :goto_0
    return-object v0

    .line 207
    :cond_2
    :try_start_3
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 208
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v3, "MailcapCommandMap: not loading mailcap file: "

    invoke-direct {v0, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 209
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 208
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_8
    .catch Ljava/lang/SecurityException; {:try_start_3 .. :try_end_3} :catch_7
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 219
    :cond_3
    if-eqz v2, :cond_4

    .line 220
    :try_start_4
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_6

    :cond_4
    :goto_1
    move-object v0, v1

    .line 223
    goto :goto_0

    .line 211
    :catch_0
    move-exception v0

    move-object v2, v1

    .line 212
    :goto_2
    :try_start_5
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v3

    if-eqz v3, :cond_5

    .line 213
    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "MailcapCommandMap: can\'t load "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    .line 219
    :cond_5
    if-eqz v2, :cond_4

    .line 220
    :try_start_6
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_1

    goto :goto_1

    .line 221
    :catch_1
    move-exception v0

    goto :goto_1

    .line 214
    :catch_2
    move-exception v0

    move-object v2, v1

    .line 215
    :goto_3
    :try_start_7
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v3

    if-eqz v3, :cond_6

    .line 216
    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "MailcapCommandMap: can\'t load "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    .line 219
    :cond_6
    if-eqz v2, :cond_4

    .line 220
    :try_start_8
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_3

    goto :goto_1

    .line 221
    :catch_3
    move-exception v0

    goto :goto_1

    .line 217
    :catchall_0
    move-exception v0

    move-object v2, v1

    .line 219
    :goto_4
    if-eqz v2, :cond_7

    .line 220
    :try_start_9
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_9
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_5

    .line 222
    :cond_7
    :goto_5
    throw v0

    .line 221
    :catch_4
    move-exception v1

    goto :goto_0

    :catch_5
    move-exception v1

    goto :goto_5

    :catch_6
    move-exception v0

    goto :goto_1

    .line 217
    :catchall_1
    move-exception v0

    goto :goto_4

    .line 214
    :catch_7
    move-exception v0

    goto :goto_3

    .line 211
    :catch_8
    move-exception v0

    goto :goto_2
.end method


# virtual methods
.method public declared-synchronized addMailcap(Ljava/lang/String;)V
    .locals 3

    .prologue
    .line 532
    monitor-enter p0

    :try_start_0
    const-string v0, "MailcapCommandMap: add to PROG"

    invoke-static {v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V

    .line 533
    iget-object v0, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    if-nez v0, :cond_0

    .line 534
    iget-object v0, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    const/4 v1, 0x0

    new-instance v2, Lcom/sun/activation/registries/MailcapFile;

    invoke-direct {v2}, Lcom/sun/activation/registries/MailcapFile;-><init>()V

    aput-object v2, v0, v1

    .line 536
    :cond_0
    iget-object v0, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    invoke-virtual {v0, p1}, Lcom/sun/activation/registries/MailcapFile;->appendToMailcap(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 537
    monitor-exit p0

    return-void

    .line 532
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized createDataContentHandler(Ljava/lang/String;)Ljavax/activation/DataContentHandler;
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 547
    monitor-enter p0

    :try_start_0
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 549
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v2, "MailcapCommandMap: createDataContentHandler for "

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 548
    invoke-static {v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V

    .line 550
    :cond_0
    if-eqz p1, :cond_1

    .line 551
    sget-object v0, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {p1, v0}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object p1

    :cond_1
    move v2, v1

    .line 553
    :goto_0
    iget-object v0, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    array-length v0, v0

    if-lt v2, v0, :cond_2

    .line 571
    :goto_1
    iget-object v0, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    array-length v0, v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-lt v1, v0, :cond_6

    .line 587
    const/4 v0, 0x0

    :goto_2
    monitor-exit p0

    return-object v0

    .line 554
    :cond_2
    :try_start_1
    iget-object v0, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    aget-object v0, v0, v2

    if-nez v0, :cond_4

    .line 553
    :cond_3
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_0

    .line 556
    :cond_4
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v0

    if-eqz v0, :cond_5

    .line 557
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v3, "  search DB #"

    invoke-direct {v0, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V

    .line 558
    :cond_5
    iget-object v0, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    aget-object v0, v0, v2

    invoke-virtual {v0, p1}, Lcom/sun/activation/registries/MailcapFile;->getMailcapList(Ljava/lang/String;)Ljava/util/Map;

    move-result-object v0

    .line 559
    if-eqz v0, :cond_3

    .line 560
    const-string v3, "content-handler"

    invoke-interface {v0, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/List;

    .line 561
    if-eqz v0, :cond_3

    .line 562
    const/4 v3, 0x0

    invoke-interface {v0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 563
    invoke-direct {p0, v0}, Ljavax/activation/MailcapCommandMap;->getDataContentHandler(Ljava/lang/String;)Ljavax/activation/DataContentHandler;

    move-result-object v0

    .line 564
    if-eqz v0, :cond_3

    goto :goto_2

    .line 572
    :cond_6
    iget-object v0, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    aget-object v0, v0, v1

    if-nez v0, :cond_8

    .line 571
    :cond_7
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_1

    .line 574
    :cond_8
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v0

    if-eqz v0, :cond_9

    .line 575
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v2, "  search fallback DB #"

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V

    .line 576
    :cond_9
    iget-object v0, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    aget-object v0, v0, v1

    invoke-virtual {v0, p1}, Lcom/sun/activation/registries/MailcapFile;->getMailcapFallbackList(Ljava/lang/String;)Ljava/util/Map;

    move-result-object v0

    .line 577
    if-eqz v0, :cond_7

    .line 578
    const-string v2, "content-handler"

    invoke-interface {v0, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/List;

    .line 579
    if-eqz v0, :cond_7

    .line 580
    const/4 v2, 0x0

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 581
    invoke-direct {p0, v0}, Ljavax/activation/MailcapCommandMap;->getDataContentHandler(Ljava/lang/String;)Ljavax/activation/DataContentHandler;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v0

    .line 582
    if-eqz v0, :cond_7

    goto/16 :goto_2

    .line 547
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized getAllCommands(Ljava/lang/String;)[Ljavax/activation/CommandInfo;
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 428
    monitor-enter p0

    :try_start_0
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 429
    if-eqz p1, :cond_0

    .line 430
    sget-object v1, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {p1, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object p1

    :cond_0
    move v1, v0

    .line 432
    :goto_0
    iget-object v3, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    array-length v3, v3

    if-lt v1, v3, :cond_1

    .line 441
    :goto_1
    iget-object v1, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    array-length v1, v1

    if-lt v0, v1, :cond_4

    .line 449
    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v0

    new-array v0, v0, [Ljavax/activation/CommandInfo;

    .line 450
    invoke-interface {v2, v0}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljavax/activation/CommandInfo;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 452
    monitor-exit p0

    return-object v0

    .line 433
    :cond_1
    :try_start_1
    iget-object v3, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    aget-object v3, v3, v1

    if-nez v3, :cond_3

    .line 432
    :cond_2
    :goto_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 435
    :cond_3
    iget-object v3, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    aget-object v3, v3, v1

    invoke-virtual {v3, p1}, Lcom/sun/activation/registries/MailcapFile;->getMailcapList(Ljava/lang/String;)Ljava/util/Map;

    move-result-object v3

    .line 436
    if-eqz v3, :cond_2

    .line 437
    invoke-direct {p0, v3, v2}, Ljavax/activation/MailcapCommandMap;->appendCmdsToList(Ljava/util/Map;Ljava/util/List;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_2

    .line 428
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    .line 442
    :cond_4
    :try_start_2
    iget-object v1, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    aget-object v1, v1, v0

    if-nez v1, :cond_6

    .line 441
    :cond_5
    :goto_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 444
    :cond_6
    iget-object v1, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    aget-object v1, v1, v0

    invoke-virtual {v1, p1}, Lcom/sun/activation/registries/MailcapFile;->getMailcapFallbackList(Ljava/lang/String;)Ljava/util/Map;

    move-result-object v1

    .line 445
    if-eqz v1, :cond_5

    .line 446
    invoke-direct {p0, v1, v2}, Ljavax/activation/MailcapCommandMap;->appendCmdsToList(Ljava/util/Map;Ljava/util/List;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_3
.end method

.method public declared-synchronized getCommand(Ljava/lang/String;Ljava/lang/String;)Ljavax/activation/CommandInfo;
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 483
    monitor-enter p0

    if-eqz p1, :cond_0

    .line 484
    :try_start_0
    sget-object v0, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {p1, v0}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object p1

    :cond_0
    move v2, v1

    .line 486
    :goto_0
    iget-object v0, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    array-length v0, v0

    if-lt v2, v0, :cond_1

    .line 503
    :goto_1
    iget-object v0, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    array-length v0, v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-lt v1, v0, :cond_4

    .line 518
    const/4 v0, 0x0

    :goto_2
    monitor-exit p0

    return-object v0

    .line 487
    :cond_1
    :try_start_1
    iget-object v0, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    aget-object v0, v0, v2

    if-nez v0, :cond_3

    .line 486
    :cond_2
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_0

    .line 489
    :cond_3
    iget-object v0, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    aget-object v0, v0, v2

    invoke-virtual {v0, p1}, Lcom/sun/activation/registries/MailcapFile;->getMailcapList(Ljava/lang/String;)Ljava/util/Map;

    move-result-object v0

    .line 490
    if-eqz v0, :cond_2

    .line 492
    invoke-interface {v0, p2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/List;

    .line 493
    if-eqz v0, :cond_2

    .line 494
    const/4 v3, 0x0

    invoke-interface {v0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 496
    if-eqz v0, :cond_2

    .line 497
    new-instance v1, Ljavax/activation/CommandInfo;

    invoke-direct {v1, p2, v0}, Ljavax/activation/CommandInfo;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    move-object v0, v1

    goto :goto_2

    .line 504
    :cond_4
    iget-object v0, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    aget-object v0, v0, v1

    if-nez v0, :cond_6

    .line 503
    :cond_5
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_1

    .line 506
    :cond_6
    iget-object v0, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    aget-object v0, v0, v1

    invoke-virtual {v0, p1}, Lcom/sun/activation/registries/MailcapFile;->getMailcapFallbackList(Ljava/lang/String;)Ljava/util/Map;

    move-result-object v0

    .line 507
    if-eqz v0, :cond_5

    .line 509
    invoke-interface {v0, p2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/List;

    .line 510
    if-eqz v0, :cond_5

    .line 511
    const/4 v2, 0x0

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 513
    if-eqz v0, :cond_5

    .line 514
    new-instance v1, Ljavax/activation/CommandInfo;

    invoke-direct {v1, p2, v0}, Ljavax/activation/CommandInfo;-><init>(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-object v0, v1

    goto :goto_2

    .line 483
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized getMimeTypes()[Ljava/lang/String;
    .locals 6

    .prologue
    const/4 v1, 0x0

    .line 630
    monitor-enter p0

    :try_start_0
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    move v2, v1

    .line 632
    :goto_0
    iget-object v0, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    array-length v0, v0

    if-lt v2, v0, :cond_0

    .line 645
    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v0

    new-array v0, v0, [Ljava/lang/String;

    .line 646
    invoke-interface {v3, v0}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 648
    monitor-exit p0

    return-object v0

    .line 633
    :cond_0
    :try_start_1
    iget-object v0, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    aget-object v0, v0, v2

    if-nez v0, :cond_2

    .line 632
    :cond_1
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_0

    .line 635
    :cond_2
    iget-object v0, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    aget-object v0, v0, v2

    invoke-virtual {v0}, Lcom/sun/activation/registries/MailcapFile;->getMimeTypes()[Ljava/lang/String;

    move-result-object v4

    .line 636
    if-eqz v4, :cond_1

    move v0, v1

    .line 637
    :goto_1
    array-length v5, v4

    if-ge v0, v5, :cond_1

    .line 639
    aget-object v5, v4, v0

    invoke-interface {v3, v5}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_3

    .line 640
    aget-object v5, v4, v0

    invoke-interface {v3, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 637
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 630
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized getNativeCommands(Ljava/lang/String;)[Ljava/lang/String;
    .locals 6

    .prologue
    const/4 v1, 0x0

    .line 666
    monitor-enter p0

    :try_start_0
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 667
    if-eqz p1, :cond_0

    .line 668
    sget-object v0, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {p1, v0}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object p1

    :cond_0
    move v2, v1

    .line 670
    :goto_0
    iget-object v0, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    array-length v0, v0

    if-lt v2, v0, :cond_1

    .line 683
    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v0

    new-array v0, v0, [Ljava/lang/String;

    .line 684
    invoke-interface {v3, v0}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 686
    monitor-exit p0

    return-object v0

    .line 671
    :cond_1
    :try_start_1
    iget-object v0, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    aget-object v0, v0, v2

    if-nez v0, :cond_3

    .line 670
    :cond_2
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_0

    .line 673
    :cond_3
    iget-object v0, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    aget-object v0, v0, v2

    invoke-virtual {v0, p1}, Lcom/sun/activation/registries/MailcapFile;->getNativeCommands(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v4

    .line 674
    if-eqz v4, :cond_2

    move v0, v1

    .line 675
    :goto_1
    array-length v5, v4

    if-ge v0, v5, :cond_2

    .line 677
    aget-object v5, v4, v0

    invoke-interface {v3, v5}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_4

    .line 678
    aget-object v5, v4, v0

    invoke-interface {v3, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 675
    :cond_4
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 666
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized getPreferredCommands(Ljava/lang/String;)[Ljavax/activation/CommandInfo;
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 362
    monitor-enter p0

    :try_start_0
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 363
    if-eqz p1, :cond_0

    .line 364
    sget-object v1, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {p1, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object p1

    :cond_0
    move v1, v0

    .line 366
    :goto_0
    iget-object v3, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    array-length v3, v3

    if-lt v1, v3, :cond_1

    .line 375
    :goto_1
    iget-object v1, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    array-length v1, v1

    if-lt v0, v1, :cond_4

    .line 383
    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v0

    new-array v0, v0, [Ljavax/activation/CommandInfo;

    .line 384
    invoke-interface {v2, v0}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljavax/activation/CommandInfo;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 386
    monitor-exit p0

    return-object v0

    .line 367
    :cond_1
    :try_start_1
    iget-object v3, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    aget-object v3, v3, v1

    if-nez v3, :cond_3

    .line 366
    :cond_2
    :goto_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 369
    :cond_3
    iget-object v3, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    aget-object v3, v3, v1

    invoke-virtual {v3, p1}, Lcom/sun/activation/registries/MailcapFile;->getMailcapList(Ljava/lang/String;)Ljava/util/Map;

    move-result-object v3

    .line 370
    if-eqz v3, :cond_2

    .line 371
    invoke-direct {p0, v3, v2}, Ljavax/activation/MailcapCommandMap;->appendPrefCmdsToList(Ljava/util/Map;Ljava/util/List;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_2

    .line 362
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    .line 376
    :cond_4
    :try_start_2
    iget-object v1, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    aget-object v1, v1, v0

    if-nez v1, :cond_6

    .line 375
    :cond_5
    :goto_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 378
    :cond_6
    iget-object v1, p0, Ljavax/activation/MailcapCommandMap;->DB:[Lcom/sun/activation/registries/MailcapFile;

    aget-object v1, v1, v0

    invoke-virtual {v1, p1}, Lcom/sun/activation/registries/MailcapFile;->getMailcapFallbackList(Ljava/lang/String;)Ljava/util/Map;

    move-result-object v1

    .line 379
    if-eqz v1, :cond_5

    .line 380
    invoke-direct {p0, v1, v2}, Ljavax/activation/MailcapCommandMap;->appendPrefCmdsToList(Ljava/util/Map;Ljava/util/List;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_3
.end method
