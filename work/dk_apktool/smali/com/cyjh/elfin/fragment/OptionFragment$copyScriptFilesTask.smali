.class Lcom/cyjh/elfin/fragment/OptionFragment$copyScriptFilesTask;
.super Landroid/os/AsyncTask;
.source "OptionFragment.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/fragment/OptionFragment;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "copyScriptFilesTask"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask",
        "<",
        "Ljava/io/InputStream;",
        "Ljava/lang/Void;",
        "Ljava/lang/Boolean;",
        ">;"
    }
.end annotation


# instance fields
.field private destFiles:[Ljava/io/File;

.field final synthetic this$0:Lcom/cyjh/elfin/fragment/OptionFragment;


# direct methods
.method public varargs constructor <init>(Lcom/cyjh/elfin/fragment/OptionFragment;[Ljava/io/File;)V
    .locals 0
    .param p2, "destFiles"    # [Ljava/io/File;

    .prologue
    .line 338
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$copyScriptFilesTask;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    .line 339
    iput-object p2, p0, Lcom/cyjh/elfin/fragment/OptionFragment$copyScriptFilesTask;->destFiles:[Ljava/io/File;

    .line 340
    return-void
.end method


# virtual methods
.method protected varargs doInBackground([Ljava/io/InputStream;)Ljava/lang/Boolean;
    .locals 6
    .param p1, "inputStreams"    # [Ljava/io/InputStream;

    .prologue
    .line 344
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    array-length v1, p1

    if-ge v0, v1, :cond_1

    .line 345
    aget-object v1, p1, v0

    if-eqz v1, :cond_0

    .line 346
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$copyScriptFilesTask;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    iget-object v1, v1, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "file:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/cyjh/elfin/fragment/OptionFragment$copyScriptFilesTask;->destFiles:[Ljava/io/File;

    aget-object v3, v3, v0

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 347
    aget-object v1, p1, v0

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment$copyScriptFilesTask;->destFiles:[Ljava/io/File;

    aget-object v2, v2, v0

    invoke-static {v1, v2}, Lcom/cyjh/elfin/util/FileUtils;->copyToFile(Ljava/io/InputStream;Ljava/io/File;)Z

    .line 344
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 351
    :cond_1
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$copyScriptFilesTask;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    iget-object v1, v1, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v1, v1, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v1}, Lcom/cyjh/elfin/entity/Script;->getUipFile()Ljava/io/File;

    move-result-object v1

    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$copyScriptFilesTask;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    iget-object v1, v1, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v1, v1, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v1}, Lcom/cyjh/elfin/entity/Script;->getUipFile()Ljava/io/File;

    move-result-object v1

    invoke-virtual {v1}, Ljava/io/File;->length()J

    move-result-wide v2

    const-wide/16 v4, 0x0

    cmp-long v1, v2, v4

    if-lez v1, :cond_2

    .line 352
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;->getInstance()Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment$copyScriptFilesTask;->destFiles:[Ljava/io/File;

    const/4 v3, 0x0

    aget-object v2, v2, v3

    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;->startLoop(Ljava/lang/String;)V

    .line 354
    :cond_2
    const/4 v1, 0x1

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    return-object v1
.end method

.method protected bridge synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 334
    check-cast p1, [Ljava/io/InputStream;

    invoke-virtual {p0, p1}, Lcom/cyjh/elfin/fragment/OptionFragment$copyScriptFilesTask;->doInBackground([Ljava/io/InputStream;)Ljava/lang/Boolean;

    move-result-object v0

    return-object v0
.end method

.method protected onPostExecute(Ljava/lang/Boolean;)V
    .locals 1
    .param p1, "isDone"    # Ljava/lang/Boolean;

    .prologue
    .line 359
    invoke-super {p0, p1}, Landroid/os/AsyncTask;->onPostExecute(Ljava/lang/Object;)V

    .line 360
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$copyScriptFilesTask;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$000(Lcom/cyjh/elfin/fragment/OptionFragment;)V

    .line 361
    return-void
.end method

.method protected bridge synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    .prologue
    .line 334
    check-cast p1, Ljava/lang/Boolean;

    invoke-virtual {p0, p1}, Lcom/cyjh/elfin/fragment/OptionFragment$copyScriptFilesTask;->onPostExecute(Ljava/lang/Boolean;)V

    return-void
.end method
