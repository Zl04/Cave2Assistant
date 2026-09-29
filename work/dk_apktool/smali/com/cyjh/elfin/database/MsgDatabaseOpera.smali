.class public Lcom/cyjh/elfin/database/MsgDatabaseOpera;
.super Ljava/lang/Object;
.source "MsgDatabaseOpera.java"


# static fields
.field private static final DB_DEFAULT_VERSION:I = 0x1

.field private static instance:Lcom/cyjh/elfin/database/MsgDatabaseOpera;


# instance fields
.field private dbHelper:Lcom/cyjh/elfin/database/MsgDatabaseHelper;


# direct methods
.method private constructor <init>()V
    .locals 5

    .prologue
    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 33
    new-instance v0, Lcom/cyjh/elfin/database/MsgDatabaseHelper;

    invoke-static {}, Lcom/cyjh/elfin/AppContext;->getInstance()Lcom/cyjh/elfin/AppContext;

    move-result-object v1

    const-string v2, "MESSAGE.db"

    const/4 v3, 0x0

    const/4 v4, 0x1

    invoke-direct {v0, v1, v2, v3, v4}, Lcom/cyjh/elfin/database/MsgDatabaseHelper;-><init>(Landroid/content/Context;Ljava/lang/String;Landroid/database/sqlite/SQLiteDatabase$CursorFactory;I)V

    iput-object v0, p0, Lcom/cyjh/elfin/database/MsgDatabaseOpera;->dbHelper:Lcom/cyjh/elfin/database/MsgDatabaseHelper;

    .line 34
    return-void
.end method

.method static synthetic access$000(Lcom/cyjh/elfin/database/MsgDatabaseOpera;)Lcom/cyjh/elfin/database/MsgDatabaseHelper;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/database/MsgDatabaseOpera;

    .prologue
    .line 25
    iget-object v0, p0, Lcom/cyjh/elfin/database/MsgDatabaseOpera;->dbHelper:Lcom/cyjh/elfin/database/MsgDatabaseHelper;

    return-object v0
.end method

.method public static getInstance()Lcom/cyjh/elfin/database/MsgDatabaseOpera;
    .locals 2

    .prologue
    .line 37
    sget-object v0, Lcom/cyjh/elfin/database/MsgDatabaseOpera;->instance:Lcom/cyjh/elfin/database/MsgDatabaseOpera;

    if-nez v0, :cond_1

    .line 38
    const-class v1, Lcom/cyjh/elfin/database/MsgDatabaseOpera;

    monitor-enter v1

    .line 39
    :try_start_0
    sget-object v0, Lcom/cyjh/elfin/database/MsgDatabaseOpera;->instance:Lcom/cyjh/elfin/database/MsgDatabaseOpera;

    if-nez v0, :cond_0

    .line 40
    new-instance v0, Lcom/cyjh/elfin/database/MsgDatabaseOpera;

    invoke-direct {v0}, Lcom/cyjh/elfin/database/MsgDatabaseOpera;-><init>()V

    sput-object v0, Lcom/cyjh/elfin/database/MsgDatabaseOpera;->instance:Lcom/cyjh/elfin/database/MsgDatabaseOpera;

    .line 42
    :cond_0
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 44
    :cond_1
    sget-object v0, Lcom/cyjh/elfin/database/MsgDatabaseOpera;->instance:Lcom/cyjh/elfin/database/MsgDatabaseOpera;

    return-object v0

    .line 42
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method


# virtual methods
.method public closeDatabaseHelper()V
    .locals 1

    .prologue
    .line 107
    iget-object v0, p0, Lcom/cyjh/elfin/database/MsgDatabaseOpera;->dbHelper:Lcom/cyjh/elfin/database/MsgDatabaseHelper;

    invoke-virtual {v0}, Lcom/cyjh/elfin/database/MsgDatabaseHelper;->close()V

    .line 108
    return-void
.end method

.method public deleteAll()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 82
    iget-object v1, p0, Lcom/cyjh/elfin/database/MsgDatabaseOpera;->dbHelper:Lcom/cyjh/elfin/database/MsgDatabaseHelper;

    invoke-virtual {v1}, Lcom/cyjh/elfin/database/MsgDatabaseHelper;->getWritableDatabase()Landroid/database/sqlite/SQLiteDatabase;

    move-result-object v0

    .line 83
    .local v0, "dbDelete":Landroid/database/sqlite/SQLiteDatabase;
    const-string v1, "Message"

    invoke-virtual {v0, v1, v2, v2}, Landroid/database/sqlite/SQLiteDatabase;->delete(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;)I

    .line 84
    return-void
.end method

.method public insertData(Ljava/util/List;)V
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/cyjh/elfin/entity/NotifyMsgBean;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 90
    .local p1, "insertData":Ljava/util/List;, "Ljava/util/List<Lcom/cyjh/elfin/entity/NotifyMsgBean;>;"
    iget-object v4, p0, Lcom/cyjh/elfin/database/MsgDatabaseOpera;->dbHelper:Lcom/cyjh/elfin/database/MsgDatabaseHelper;

    invoke-virtual {v4}, Lcom/cyjh/elfin/database/MsgDatabaseHelper;->getWritableDatabase()Landroid/database/sqlite/SQLiteDatabase;

    move-result-object v0

    .line 91
    .local v0, "dbInsert":Landroid/database/sqlite/SQLiteDatabase;
    new-instance v3, Landroid/content/ContentValues;

    invoke-direct {v3}, Landroid/content/ContentValues;-><init>()V

    .line 92
    .local v3, "values":Landroid/content/ContentValues;
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v4

    add-int/lit8 v1, v4, -0x1

    .local v1, "i":I
    :goto_0
    if-ltz v1, :cond_0

    .line 93
    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/cyjh/elfin/entity/NotifyMsgBean;

    .line 94
    .local v2, "notifyMsgBean":Lcom/cyjh/elfin/entity/NotifyMsgBean;
    invoke-virtual {v3}, Landroid/content/ContentValues;->clear()V

    .line 95
    const-string v4, "number"

    iget-object v5, v2, Lcom/cyjh/elfin/entity/NotifyMsgBean;->ID:Ljava/lang/String;

    invoke-virtual {v3, v4, v5}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 96
    const-string v4, "title"

    iget-object v5, v2, Lcom/cyjh/elfin/entity/NotifyMsgBean;->NoticeTitle:Ljava/lang/String;

    invoke-virtual {v3, v4, v5}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 97
    const-string v4, "time"

    iget-object v5, v2, Lcom/cyjh/elfin/entity/NotifyMsgBean;->NoticeTime:Ljava/lang/String;

    invoke-virtual {v3, v4, v5}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 98
    const-string v4, "content"

    iget-object v5, v2, Lcom/cyjh/elfin/entity/NotifyMsgBean;->NoticeContent:Ljava/lang/String;

    invoke-virtual {v3, v4, v5}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 99
    const-string v4, "description"

    iget-object v5, v2, Lcom/cyjh/elfin/entity/NotifyMsgBean;->NoticeDescription:Ljava/lang/String;

    invoke-virtual {v3, v4, v5}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 100
    const-string v4, "type"

    iget-object v5, v2, Lcom/cyjh/elfin/entity/NotifyMsgBean;->DescriptionType:Ljava/lang/String;

    invoke-virtual {v3, v4, v5}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 101
    const-string v4, "Message"

    const/4 v5, 0x0

    invoke-virtual {v0, v4, v5, v3}, Landroid/database/sqlite/SQLiteDatabase;->insert(Ljava/lang/String;Ljava/lang/String;Landroid/content/ContentValues;)J

    .line 92
    add-int/lit8 v1, v1, -0x1

    goto :goto_0

    .line 103
    .end local v2    # "notifyMsgBean":Lcom/cyjh/elfin/entity/NotifyMsgBean;
    :cond_0
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->close()V

    .line 104
    return-void
.end method

.method public queryAll(Landroid/os/Handler;)V
    .locals 2
    .param p1, "handler"    # Landroid/os/Handler;

    .prologue
    .line 50
    invoke-static {}, Lcom/cyjh/feedback/lib/executor/ThreadPoolProxyFactory;->getNormalThreadPool()Lcom/cyjh/feedback/lib/executor/ThreadPoolProxy;

    move-result-object v0

    new-instance v1, Lcom/cyjh/elfin/database/MsgDatabaseOpera$1;

    invoke-direct {v1, p0, p1}, Lcom/cyjh/elfin/database/MsgDatabaseOpera$1;-><init>(Lcom/cyjh/elfin/database/MsgDatabaseOpera;Landroid/os/Handler;)V

    invoke-virtual {v0, v1}, Lcom/cyjh/feedback/lib/executor/ThreadPoolProxy;->executeRunnable(Ljava/lang/Runnable;)V

    .line 76
    return-void
.end method
