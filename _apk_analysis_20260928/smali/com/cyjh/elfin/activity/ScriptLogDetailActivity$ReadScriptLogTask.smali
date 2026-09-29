.class Lcom/cyjh/elfin/activity/ScriptLogDetailActivity$ReadScriptLogTask;
.super Landroid/os/AsyncTask;
.source "ScriptLogDetailActivity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "ReadScriptLogTask"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask",
        "<",
        "Ljava/io/File;",
        "Ljava/lang/Integer;",
        "Ljava/lang/String;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;


# direct methods
.method private constructor <init>(Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;)V
    .locals 0

    .prologue
    .line 92
    iput-object p1, p0, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity$ReadScriptLogTask;->this$0:Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;Lcom/cyjh/elfin/activity/ScriptLogDetailActivity$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;
    .param p2, "x1"    # Lcom/cyjh/elfin/activity/ScriptLogDetailActivity$1;

    .prologue
    .line 92
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity$ReadScriptLogTask;-><init>(Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;)V

    return-void
.end method


# virtual methods
.method protected bridge synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 92
    check-cast p1, [Ljava/io/File;

    invoke-virtual {p0, p1}, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity$ReadScriptLogTask;->doInBackground([Ljava/io/File;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method protected varargs doInBackground([Ljava/io/File;)Ljava/lang/String;
    .locals 5
    .param p1, "params"    # [Ljava/io/File;

    .prologue
    .line 103
    const/4 v1, 0x0

    .line 105
    .local v1, "readTextFile":Ljava/lang/String;
    :try_start_0
    iget-object v2, p0, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity$ReadScriptLogTask;->this$0:Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;

    invoke-static {v2}, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->access$200(Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;)Lcom/cyjh/elfin/entity/ScriptLog;

    move-result-object v2

    invoke-virtual {v2}, Lcom/cyjh/elfin/entity/ScriptLog;->getFile()Ljava/io/File;

    move-result-object v2

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-static {v2, v3, v4}, Lcom/cyjh/elfin/util/FileUtils;->readTextFile(Ljava/io/File;ILjava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 106
    iget-object v2, p0, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity$ReadScriptLogTask;->this$0:Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;

    iget-object v2, v2, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "readTextFile>>>"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 110
    :goto_0
    return-object v1

    .line 107
    :catch_0
    move-exception v0

    .line 108
    .local v0, "e":Ljava/io/IOException;
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0
.end method

.method protected bridge synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    .prologue
    .line 92
    check-cast p1, Ljava/lang/String;

    invoke-virtual {p0, p1}, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity$ReadScriptLogTask;->onPostExecute(Ljava/lang/String;)V

    return-void
.end method

.method protected onPostExecute(Ljava/lang/String;)V
    .locals 1
    .param p1, "result"    # Ljava/lang/String;

    .prologue
    .line 120
    invoke-super {p0, p1}, Landroid/os/AsyncTask;->onPostExecute(Ljava/lang/Object;)V

    .line 121
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity$ReadScriptLogTask;->this$0:Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;

    invoke-static {v0}, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->access$300(Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;)Landroid/widget/TextView;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 122
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity$ReadScriptLogTask;->this$0:Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;

    invoke-virtual {v0}, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->dismissProgressDialog()V

    .line 123
    return-void
.end method

.method protected onPreExecute()V
    .locals 4

    .prologue
    .line 96
    invoke-super {p0}, Landroid/os/AsyncTask;->onPreExecute()V

    .line 97
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity$ReadScriptLogTask;->this$0:Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;

    iget-object v1, p0, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity$ReadScriptLogTask;->this$0:Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;

    const v2, 0x7f0800e2

    const v3, 0x7f0800e1

    invoke-virtual {v0, v1, v2, v3}, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->showProgressDialog(Landroid/content/Context;II)V

    .line 99
    return-void
.end method

.method protected varargs onProgressUpdate([Ljava/lang/Integer;)V
    .locals 0
    .param p1, "values"    # [Ljava/lang/Integer;

    .prologue
    .line 115
    invoke-super {p0, p1}, Landroid/os/AsyncTask;->onProgressUpdate([Ljava/lang/Object;)V

    .line 116
    return-void
.end method

.method protected bridge synthetic onProgressUpdate([Ljava/lang/Object;)V
    .locals 0

    .prologue
    .line 92
    check-cast p1, [Ljava/lang/Integer;

    invoke-virtual {p0, p1}, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity$ReadScriptLogTask;->onProgressUpdate([Ljava/lang/Integer;)V

    return-void
.end method
