.class Lcom/cyjh/elfin/services/SavePicService$1;
.super Ljava/lang/Object;
.source "SavePicService.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/services/SavePicService;->onStartCommand(Landroid/content/Intent;II)I
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/services/SavePicService;

.field final synthetic val$url:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/services/SavePicService;Ljava/lang/String;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/services/SavePicService;

    .prologue
    .line 42
    iput-object p1, p0, Lcom/cyjh/elfin/services/SavePicService$1;->this$0:Lcom/cyjh/elfin/services/SavePicService;

    iput-object p2, p0, Lcom/cyjh/elfin/services/SavePicService$1;->val$url:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 11

    .prologue
    .line 45
    const/4 v4, 0x0

    .line 46
    .local v4, "in":Ljava/io/InputStream;
    const/4 v6, 0x0

    .line 48
    .local v6, "out":Ljava/io/FileOutputStream;
    :try_start_0
    new-instance v3, Ljava/net/URL;

    iget-object v8, p0, Lcom/cyjh/elfin/services/SavePicService$1;->val$url:Ljava/lang/String;

    invoke-direct {v3, v8}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .line 49
    .local v3, "imgURL":Ljava/net/URL;
    invoke-virtual {v3}, Ljava/net/URL;->openStream()Ljava/io/InputStream;

    move-result-object v4

    .line 50
    invoke-static {v4}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;)Landroid/graphics/Bitmap;

    move-result-object v0

    .line 51
    .local v0, "bitmap":Landroid/graphics/Bitmap;
    iget-object v8, p0, Lcom/cyjh/elfin/services/SavePicService$1;->this$0:Lcom/cyjh/elfin/services/SavePicService;

    invoke-static {v8}, Lcom/cyjh/elfin/constant/Constants;->getCacheImg(Landroid/content/Context;)Ljava/io/File;

    move-result-object v2

    .line 52
    .local v2, "file":Ljava/io/File;
    if-eqz v2, :cond_1

    .line 53
    new-instance v7, Ljava/io/FileOutputStream;

    invoke-direct {v7, v2}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 54
    .end local v6    # "out":Ljava/io/FileOutputStream;
    .local v7, "out":Ljava/io/FileOutputStream;
    :try_start_1
    sget-object v8, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v9, 0x64

    invoke-virtual {v0, v8, v9, v7}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    .line 55
    invoke-virtual {v7}, Ljava/io/FileOutputStream;->flush()V

    .line 56
    iget-object v8, p0, Lcom/cyjh/elfin/services/SavePicService$1;->this$0:Lcom/cyjh/elfin/services/SavePicService;

    iget-object v8, v8, Lcom/cyjh/elfin/services/SavePicService;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v8, v8, Lcom/cyjh/elfin/AppContext;->mSharePre:Landroid/content/SharedPreferences;

    const-string v9, "ad_is_first"

    const/4 v10, 0x1

    invoke-interface {v8, v9, v10}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v5

    .line 57
    .local v5, "isFirst":Z
    if-eqz v5, :cond_0

    .line 58
    iget-object v8, p0, Lcom/cyjh/elfin/services/SavePicService$1;->this$0:Lcom/cyjh/elfin/services/SavePicService;

    iget-object v8, v8, Lcom/cyjh/elfin/services/SavePicService;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v8, v8, Lcom/cyjh/elfin/AppContext;->mSharePre:Landroid/content/SharedPreferences;

    invoke-interface {v8}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v8

    const-string v9, "ad_is_first"

    const/4 v10, 0x0

    invoke-interface {v8, v9, v10}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v8

    invoke-interface {v8}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 59
    const-string v8, "\u52a0\u8f7d\u56fe\u7247\u7f13\u5b58\u5b8c\u6bd5"

    const/4 v9, 0x0

    new-array v9, v9, [Ljava/lang/Object;

    invoke-static {v8, v9}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_7
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    :cond_0
    move-object v6, v7

    .line 65
    .end local v5    # "isFirst":Z
    .end local v7    # "out":Ljava/io/FileOutputStream;
    .restart local v6    # "out":Ljava/io/FileOutputStream;
    :cond_1
    if-eqz v4, :cond_2

    .line 67
    :try_start_2
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    .line 72
    :cond_2
    :goto_0
    if-eqz v6, :cond_3

    .line 74
    :try_start_3
    invoke-virtual {v6}, Ljava/io/FileOutputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1

    .line 80
    .end local v0    # "bitmap":Landroid/graphics/Bitmap;
    .end local v2    # "file":Ljava/io/File;
    .end local v3    # "imgURL":Ljava/net/URL;
    :cond_3
    :goto_1
    iget-object v8, p0, Lcom/cyjh/elfin/services/SavePicService$1;->this$0:Lcom/cyjh/elfin/services/SavePicService;

    invoke-virtual {v8}, Lcom/cyjh/elfin/services/SavePicService;->stopSelf()V

    .line 81
    return-void

    .line 68
    .restart local v0    # "bitmap":Landroid/graphics/Bitmap;
    .restart local v2    # "file":Ljava/io/File;
    .restart local v3    # "imgURL":Ljava/net/URL;
    :catch_0
    move-exception v1

    .line 69
    .local v1, "e":Ljava/io/IOException;
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0

    .line 75
    .end local v1    # "e":Ljava/io/IOException;
    :catch_1
    move-exception v1

    .line 76
    .restart local v1    # "e":Ljava/io/IOException;
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_1

    .line 62
    .end local v0    # "bitmap":Landroid/graphics/Bitmap;
    .end local v1    # "e":Ljava/io/IOException;
    .end local v2    # "file":Ljava/io/File;
    .end local v3    # "imgURL":Ljava/net/URL;
    :catch_2
    move-exception v1

    .line 63
    .local v1, "e":Ljava/lang/Exception;
    :goto_2
    :try_start_4
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 65
    if-eqz v4, :cond_4

    .line 67
    :try_start_5
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_4

    .line 72
    .end local v1    # "e":Ljava/lang/Exception;
    :cond_4
    :goto_3
    if-eqz v6, :cond_3

    .line 74
    :try_start_6
    invoke-virtual {v6}, Ljava/io/FileOutputStream;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_3

    goto :goto_1

    .line 75
    :catch_3
    move-exception v1

    .line 76
    .local v1, "e":Ljava/io/IOException;
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_1

    .line 68
    .local v1, "e":Ljava/lang/Exception;
    :catch_4
    move-exception v1

    .line 69
    .local v1, "e":Ljava/io/IOException;
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_3

    .line 65
    .end local v1    # "e":Ljava/io/IOException;
    :catchall_0
    move-exception v8

    :goto_4
    if-eqz v4, :cond_5

    .line 67
    :try_start_7
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_5

    .line 72
    :cond_5
    :goto_5
    if-eqz v6, :cond_6

    .line 74
    :try_start_8
    invoke-virtual {v6}, Ljava/io/FileOutputStream;->close()V
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_6

    .line 77
    :cond_6
    :goto_6
    throw v8

    .line 68
    :catch_5
    move-exception v1

    .line 69
    .restart local v1    # "e":Ljava/io/IOException;
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_5

    .line 75
    .end local v1    # "e":Ljava/io/IOException;
    :catch_6
    move-exception v1

    .line 76
    .restart local v1    # "e":Ljava/io/IOException;
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_6

    .line 65
    .end local v1    # "e":Ljava/io/IOException;
    .end local v6    # "out":Ljava/io/FileOutputStream;
    .restart local v0    # "bitmap":Landroid/graphics/Bitmap;
    .restart local v2    # "file":Ljava/io/File;
    .restart local v3    # "imgURL":Ljava/net/URL;
    .restart local v7    # "out":Ljava/io/FileOutputStream;
    :catchall_1
    move-exception v8

    move-object v6, v7

    .end local v7    # "out":Ljava/io/FileOutputStream;
    .restart local v6    # "out":Ljava/io/FileOutputStream;
    goto :goto_4

    .line 62
    .end local v6    # "out":Ljava/io/FileOutputStream;
    .restart local v7    # "out":Ljava/io/FileOutputStream;
    :catch_7
    move-exception v1

    move-object v6, v7

    .end local v7    # "out":Ljava/io/FileOutputStream;
    .restart local v6    # "out":Ljava/io/FileOutputStream;
    goto :goto_2
.end method
