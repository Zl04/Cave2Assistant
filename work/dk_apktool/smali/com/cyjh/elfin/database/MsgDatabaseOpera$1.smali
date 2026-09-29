.class Lcom/cyjh/elfin/database/MsgDatabaseOpera$1;
.super Ljava/lang/Object;
.source "MsgDatabaseOpera.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/database/MsgDatabaseOpera;->queryAll(Landroid/os/Handler;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/database/MsgDatabaseOpera;

.field final synthetic val$handler:Landroid/os/Handler;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/database/MsgDatabaseOpera;Landroid/os/Handler;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/database/MsgDatabaseOpera;

    .prologue
    .line 50
    iput-object p1, p0, Lcom/cyjh/elfin/database/MsgDatabaseOpera$1;->this$0:Lcom/cyjh/elfin/database/MsgDatabaseOpera;

    iput-object p2, p0, Lcom/cyjh/elfin/database/MsgDatabaseOpera$1;->val$handler:Landroid/os/Handler;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 12

    .prologue
    const/4 v2, 0x0

    .line 53
    new-instance v10, Ljava/util/ArrayList;

    invoke-direct {v10}, Ljava/util/ArrayList;-><init>()V

    .line 54
    .local v10, "msgDataList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/cyjh/elfin/entity/NotifyMsgBean;>;"
    iget-object v1, p0, Lcom/cyjh/elfin/database/MsgDatabaseOpera$1;->this$0:Lcom/cyjh/elfin/database/MsgDatabaseOpera;

    invoke-static {v1}, Lcom/cyjh/elfin/database/MsgDatabaseOpera;->access$000(Lcom/cyjh/elfin/database/MsgDatabaseOpera;)Lcom/cyjh/elfin/database/MsgDatabaseHelper;

    move-result-object v1

    invoke-virtual {v1}, Lcom/cyjh/elfin/database/MsgDatabaseHelper;->getWritableDatabase()Landroid/database/sqlite/SQLiteDatabase;

    move-result-object v0

    .line 55
    .local v0, "dbQuery":Landroid/database/sqlite/SQLiteDatabase;
    const-string v1, "Message"

    const-string v7, "id desc"

    move-object v3, v2

    move-object v4, v2

    move-object v5, v2

    move-object v6, v2

    invoke-virtual/range {v0 .. v7}, Landroid/database/sqlite/SQLiteDatabase;->query(Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v8

    .line 56
    .local v8, "cursor":Landroid/database/Cursor;
    invoke-interface {v8}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 58
    :cond_0
    new-instance v11, Lcom/cyjh/elfin/entity/NotifyMsgBean;

    invoke-direct {v11}, Lcom/cyjh/elfin/entity/NotifyMsgBean;-><init>()V

    .line 59
    .local v11, "notifyMsgBean":Lcom/cyjh/elfin/entity/NotifyMsgBean;
    const-string v1, "content"

    invoke-interface {v8, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    invoke-interface {v8, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v11, Lcom/cyjh/elfin/entity/NotifyMsgBean;->NoticeContent:Ljava/lang/String;

    .line 60
    const-string v1, "type"

    invoke-interface {v8, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    invoke-interface {v8, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v11, Lcom/cyjh/elfin/entity/NotifyMsgBean;->DescriptionType:Ljava/lang/String;

    .line 61
    const-string v1, "description"

    invoke-interface {v8, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    invoke-interface {v8, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v11, Lcom/cyjh/elfin/entity/NotifyMsgBean;->NoticeDescription:Ljava/lang/String;

    .line 62
    const-string v1, "number"

    invoke-interface {v8, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    invoke-interface {v8, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v11, Lcom/cyjh/elfin/entity/NotifyMsgBean;->ID:Ljava/lang/String;

    .line 63
    const-string v1, "title"

    invoke-interface {v8, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    invoke-interface {v8, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v11, Lcom/cyjh/elfin/entity/NotifyMsgBean;->NoticeTitle:Ljava/lang/String;

    .line 64
    const-string v1, "time"

    invoke-interface {v8, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    invoke-interface {v8, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v11, Lcom/cyjh/elfin/entity/NotifyMsgBean;->NoticeTime:Ljava/lang/String;

    .line 65
    invoke-virtual {v10, v11}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 66
    invoke-interface {v8}, Landroid/database/Cursor;->moveToNext()Z

    move-result v1

    if-nez v1, :cond_0

    .line 68
    .end local v11    # "notifyMsgBean":Lcom/cyjh/elfin/entity/NotifyMsgBean;
    :cond_1
    invoke-interface {v8}, Landroid/database/Cursor;->close()V

    .line 69
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->close()V

    .line 70
    iget-object v1, p0, Lcom/cyjh/elfin/database/MsgDatabaseOpera$1;->val$handler:Landroid/os/Handler;

    invoke-virtual {v1}, Landroid/os/Handler;->obtainMessage()Landroid/os/Message;

    move-result-object v9

    .line 71
    .local v9, "message":Landroid/os/Message;
    iput-object v10, v9, Landroid/os/Message;->obj:Ljava/lang/Object;

    .line 72
    const/16 v1, 0x3ed

    iput v1, v9, Landroid/os/Message;->what:I

    .line 73
    invoke-virtual {v9}, Landroid/os/Message;->sendToTarget()V

    .line 74
    return-void
.end method
