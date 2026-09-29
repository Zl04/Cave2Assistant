.class public Lcom/cyjh/elfin/util/FileUtils$copyFilesTask;
.super Landroid/os/AsyncTask;
.source "FileUtils.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/util/FileUtils;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "copyFilesTask"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/util/FileUtils$copyFilesTask$OnPostExecuteListener;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask",
        "<[",
        "Ljava/io/File;",
        "Ljava/util/ArrayList",
        "<",
        "Ljava/util/HashMap",
        "<",
        "Ljava/lang/String;",
        "Ljava/lang/Integer;",
        ">;>;",
        "Ljava/util/ArrayList",
        "<",
        "Ljava/util/HashMap",
        "<",
        "Ljava/lang/String;",
        "Ljava/lang/Boolean;",
        ">;>;>;"
    }
.end annotation


# instance fields
.field private onPostExecuteListener:Lcom/cyjh/elfin/util/FileUtils$copyFilesTask$OnPostExecuteListener;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 184
    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method


# virtual methods
.method protected bridge synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 184
    check-cast p1, [[Ljava/io/File;

    invoke-virtual {p0, p1}, Lcom/cyjh/elfin/util/FileUtils$copyFilesTask;->doInBackground([[Ljava/io/File;)Ljava/util/ArrayList;

    move-result-object v0

    return-object v0
.end method

.method protected varargs doInBackground([[Ljava/io/File;)Ljava/util/ArrayList;
    .locals 5
    .param p1, "files"    # [[Ljava/io/File;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([[",
            "Ljava/io/File;",
            ")",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            ">;>;"
        }
    .end annotation

    .prologue
    const/4 v4, 0x0

    .line 199
    new-instance v0, Ljava/util/ArrayList;

    aget-object v2, p1, v4

    array-length v2, v2

    invoke-direct {v0, v2}, Ljava/util/ArrayList;-><init>(I)V

    .line 201
    .local v0, "arrayList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/Boolean;>;>;"
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    aget-object v2, p1, v4

    array-length v2, v2

    if-ge v1, v2, :cond_0

    .line 202
    aget-object v2, p1, v4

    aget-object v2, v2, v1

    const/4 v3, 0x1

    aget-object v3, p1, v3

    aget-object v3, v3, v1

    invoke-static {v2, v3}, Lcom/cyjh/elfin/util/FileUtils;->copyFile(Ljava/io/File;Ljava/io/File;)Z

    .line 201
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 205
    :cond_0
    const/4 v2, 0x0

    return-object v2
.end method

.method protected bridge synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    .prologue
    .line 184
    check-cast p1, Ljava/util/ArrayList;

    invoke-virtual {p0, p1}, Lcom/cyjh/elfin/util/FileUtils$copyFilesTask;->onPostExecute(Ljava/util/ArrayList;)V

    return-void
.end method

.method protected onPostExecute(Ljava/util/ArrayList;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            ">;>;)V"
        }
    .end annotation

    .prologue
    .line 215
    .local p1, "result":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/Boolean;>;>;"
    invoke-super {p0, p1}, Landroid/os/AsyncTask;->onPostExecute(Ljava/lang/Object;)V

    .line 216
    iget-object v0, p0, Lcom/cyjh/elfin/util/FileUtils$copyFilesTask;->onPostExecuteListener:Lcom/cyjh/elfin/util/FileUtils$copyFilesTask$OnPostExecuteListener;

    invoke-interface {v0, p1}, Lcom/cyjh/elfin/util/FileUtils$copyFilesTask$OnPostExecuteListener;->onPostExecute(Ljava/util/ArrayList;)V

    .line 217
    return-void
.end method

.method protected onPreExecute()V
    .locals 0

    .prologue
    .line 194
    invoke-super {p0}, Landroid/os/AsyncTask;->onPreExecute()V

    .line 195
    return-void
.end method

.method protected bridge synthetic onProgressUpdate([Ljava/lang/Object;)V
    .locals 0

    .prologue
    .line 184
    check-cast p1, [Ljava/util/ArrayList;

    invoke-virtual {p0, p1}, Lcom/cyjh/elfin/util/FileUtils$copyFilesTask;->onProgressUpdate([Ljava/util/ArrayList;)V

    return-void
.end method

.method protected varargs onProgressUpdate([Ljava/util/ArrayList;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;>;)V"
        }
    .end annotation

    .prologue
    .line 210
    .local p1, "values":[Ljava/util/ArrayList;, "[Ljava/util/ArrayList<Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/Integer;>;>;"
    invoke-super {p0, p1}, Landroid/os/AsyncTask;->onProgressUpdate([Ljava/lang/Object;)V

    .line 211
    return-void
.end method

.method public setOnPostExecuteListener(Lcom/cyjh/elfin/util/FileUtils$copyFilesTask$OnPostExecuteListener;)V
    .locals 0
    .param p1, "onPostExecuteListener"    # Lcom/cyjh/elfin/util/FileUtils$copyFilesTask$OnPostExecuteListener;

    .prologue
    .line 220
    iput-object p1, p0, Lcom/cyjh/elfin/util/FileUtils$copyFilesTask;->onPostExecuteListener:Lcom/cyjh/elfin/util/FileUtils$copyFilesTask$OnPostExecuteListener;

    .line 221
    return-void
.end method
