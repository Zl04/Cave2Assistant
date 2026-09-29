.class Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment$3;
.super Ljava/lang/Thread;
.source "ImageSelectFragment.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->initData()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;


# direct methods
.method constructor <init>(Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;

    .prologue
    .line 145
    iput-object p1, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment$3;->this$0:Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 19

    .prologue
    .line 148
    sget-object v2, Landroid/provider/MediaStore$Images$Media;->EXTERNAL_CONTENT_URI:Landroid/net/Uri;

    .line 149
    .local v2, "imgUri":Landroid/net/Uri;
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment$3;->this$0:Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;

    invoke-virtual {v3}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v3

    invoke-virtual {v3}, Landroid/support/v4/app/FragmentActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    .line 151
    .local v1, "cp":Landroid/content/ContentResolver;
    const-string v4, "mime_type= ? or mime_type=?"

    .line 153
    .local v4, "selection":Ljava/lang/String;
    const/4 v3, 0x2

    new-array v5, v3, [Ljava/lang/String;

    const/4 v3, 0x0

    const-string v6, "image/jpeg"

    aput-object v6, v5, v3

    const/4 v3, 0x1

    const-string v6, "image/png"

    aput-object v6, v5, v3

    .line 154
    .local v5, "selectionAgs":[Ljava/lang/String;
    const/4 v3, 0x0

    const-string v6, "date_modified"

    invoke-virtual/range {v1 .. v6}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v7

    .line 156
    .local v7, "cursor":Landroid/database/Cursor;
    new-instance v10, Ljava/util/HashSet;

    invoke-direct {v10}, Ljava/util/HashSet;-><init>()V

    .line 157
    .local v10, "mDirPath":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    const/4 v9, 0x0

    .line 158
    .local v9, "folderBean":Lcom/cyjh/feedback/lib/entities/FolderBean;
    :cond_0
    :goto_0
    invoke-interface {v7}, Landroid/database/Cursor;->moveToNext()Z

    move-result v3

    if-eqz v3, :cond_2

    .line 160
    const-string v3, "_data"

    invoke-interface {v7, v3}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v3

    invoke-interface {v7, v3}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v16

    .line 161
    .local v16, "path":Ljava/lang/String;
    new-instance v3, Ljava/io/File;

    move-object/from16 v0, v16

    invoke-direct {v3, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v15

    .line 164
    .local v15, "parentFile":Ljava/io/File;
    if-eqz v15, :cond_0

    .line 167
    invoke-virtual {v15}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v8

    .line 171
    .local v8, "dirPath":Ljava/lang/String;
    invoke-interface {v10, v8}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_0

    .line 174
    invoke-interface {v10, v8}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 175
    new-instance v9, Lcom/cyjh/feedback/lib/entities/FolderBean;

    .end local v9    # "folderBean":Lcom/cyjh/feedback/lib/entities/FolderBean;
    invoke-direct {v9}, Lcom/cyjh/feedback/lib/entities/FolderBean;-><init>()V

    .line 176
    .restart local v9    # "folderBean":Lcom/cyjh/feedback/lib/entities/FolderBean;
    invoke-virtual {v9, v8}, Lcom/cyjh/feedback/lib/entities/FolderBean;->setDirPath(Ljava/lang/String;)V

    .line 178
    move-object/from16 v0, v16

    invoke-virtual {v9, v0}, Lcom/cyjh/feedback/lib/entities/FolderBean;->setFirstImgPath(Ljava/lang/String;)V

    .line 181
    invoke-virtual {v15}, Ljava/io/File;->list()[Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_0

    .line 185
    new-instance v3, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment$3$1;

    move-object/from16 v0, p0

    invoke-direct {v3, v0}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment$3$1;-><init>(Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment$3;)V

    invoke-virtual {v15, v3}, Ljava/io/File;->list(Ljava/io/FilenameFilter;)[Ljava/lang/String;

    move-result-object v3

    array-length v0, v3

    move/from16 v17, v0

    .line 192
    .local v17, "picSize":I
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment$3;->this$0:Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;

    invoke-static {v3}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->access$400(Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;)I

    move-result v3

    move/from16 v0, v17

    if-le v0, v3, :cond_1

    .line 193
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment$3;->this$0:Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;

    move/from16 v0, v17

    invoke-static {v3, v0}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->access$402(Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;I)I

    .line 194
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment$3;->this$0:Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;

    invoke-static {v3, v15}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->access$502(Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;Ljava/io/File;)Ljava/io/File;

    .line 196
    :cond_1
    move/from16 v0, v17

    invoke-virtual {v9, v0}, Lcom/cyjh/feedback/lib/entities/FolderBean;->setDirCount(I)V

    .line 197
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment$3;->this$0:Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;

    invoke-static {v3}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->access$600(Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;)Ljava/util/List;

    move-result-object v3

    invoke-interface {v3, v9}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 200
    .end local v8    # "dirPath":Ljava/lang/String;
    .end local v15    # "parentFile":Ljava/io/File;
    .end local v16    # "path":Ljava/lang/String;
    .end local v17    # "picSize":I
    :cond_2
    invoke-interface {v7}, Landroid/database/Cursor;->close()V

    .line 201
    const/4 v10, 0x0

    .line 203
    new-instance v9, Lcom/cyjh/feedback/lib/entities/FolderBean;

    .end local v9    # "folderBean":Lcom/cyjh/feedback/lib/entities/FolderBean;
    invoke-direct {v9}, Lcom/cyjh/feedback/lib/entities/FolderBean;-><init>()V

    .line 206
    .restart local v9    # "folderBean":Lcom/cyjh/feedback/lib/entities/FolderBean;
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment$3;->this$0:Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;

    invoke-static {v3}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->access$600(Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;)Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_3

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment$3;->this$0:Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;

    invoke-static {v3}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->access$600(Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;)Ljava/util/List;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    if-lez v3, :cond_3

    .line 207
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment$3;->this$0:Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;

    sget v6, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->all_photo_mobile:I

    invoke-virtual {v3, v6}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v9, v3}, Lcom/cyjh/feedback/lib/entities/FolderBean;->setDirName(Ljava/lang/String;)V

    .line 208
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment$3;->this$0:Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;

    invoke-static {v3}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->access$600(Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;)Ljava/util/List;

    move-result-object v3

    const/4 v6, 0x0

    invoke-interface {v3, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/cyjh/feedback/lib/entities/FolderBean;

    invoke-virtual {v3}, Lcom/cyjh/feedback/lib/entities/FolderBean;->getFirstImgPath()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v9, v3}, Lcom/cyjh/feedback/lib/entities/FolderBean;->setFirstImgPath(Ljava/lang/String;)V

    .line 210
    :cond_3
    const-string v13, ""

    .line 211
    .local v13, "mImgPath":Ljava/lang/String;
    const/4 v12, 0x0

    .line 212
    .local v12, "mImgCount":I
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment$3;->this$0:Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;

    invoke-static {v3}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->access$600(Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;)Ljava/util/List;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_4

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Lcom/cyjh/feedback/lib/entities/FolderBean;

    .line 213
    .local v11, "mFolderBean":Lcom/cyjh/feedback/lib/entities/FolderBean;
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v11}, Lcom/cyjh/feedback/lib/entities/FolderBean;->getDirPath()Ljava/lang/String;

    move-result-object v18

    move-object/from16 v0, v18

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v18, ","

    move-object/from16 v0, v18

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    .line 214
    invoke-virtual {v11}, Lcom/cyjh/feedback/lib/entities/FolderBean;->getDirCount()I

    move-result v6

    add-int/2addr v12, v6

    .line 215
    goto :goto_1

    .line 216
    .end local v11    # "mFolderBean":Lcom/cyjh/feedback/lib/entities/FolderBean;
    :cond_4
    invoke-virtual {v9, v12}, Lcom/cyjh/feedback/lib/entities/FolderBean;->setDirCount(I)V

    .line 217
    invoke-virtual {v9, v13}, Lcom/cyjh/feedback/lib/entities/FolderBean;->setDirPath(Ljava/lang/String;)V

    .line 218
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment$3;->this$0:Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;

    invoke-static {v3}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->access$600(Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;)Ljava/util/List;

    move-result-object v3

    const/4 v6, 0x0

    invoke-interface {v3, v6, v9}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 219
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment$3;->this$0:Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;

    invoke-static {v3, v9}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->access$700(Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;Lcom/cyjh/feedback/lib/entities/FolderBean;)V

    .line 220
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment$3;->this$0:Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;

    invoke-static {v3}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->access$800(Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;)Landroid/os/Handler;

    move-result-object v3

    invoke-virtual {v3}, Landroid/os/Handler;->obtainMessage()Landroid/os/Message;

    move-result-object v14

    .line 221
    .local v14, "msg":Landroid/os/Message;
    const/16 v3, 0x110

    iput v3, v14, Landroid/os/Message;->what:I

    .line 222
    iput-object v9, v14, Landroid/os/Message;->obj:Ljava/lang/Object;

    .line 223
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment$3;->this$0:Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;

    invoke-static {v3}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->access$800(Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;)Landroid/os/Handler;

    move-result-object v3

    invoke-virtual {v3, v14}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    .line 224
    return-void
.end method
