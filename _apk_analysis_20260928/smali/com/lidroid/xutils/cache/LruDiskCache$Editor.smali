.class public final Lcom/lidroid/xutils/cache/LruDiskCache$Editor;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lidroid/xutils/cache/LruDiskCache;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x11
    name = "Editor"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lidroid/xutils/cache/LruDiskCache$Editor$FaultHidingOutputStream;
    }
.end annotation


# instance fields
.field private committed:Z

.field private final entry:Lcom/lidroid/xutils/cache/LruDiskCache$Entry;

.field private hasErrors:Z

.field final synthetic this$0:Lcom/lidroid/xutils/cache/LruDiskCache;

.field private final written:[Z


# direct methods
.method private constructor <init>(Lcom/lidroid/xutils/cache/LruDiskCache;Lcom/lidroid/xutils/cache/LruDiskCache$Entry;)V
    .locals 1

    .prologue
    .line 807
    iput-object p1, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;->this$0:Lcom/lidroid/xutils/cache/LruDiskCache;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 808
    iput-object p2, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;->entry:Lcom/lidroid/xutils/cache/LruDiskCache$Entry;

    .line 809
    invoke-static {p2}, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->access$0(Lcom/lidroid/xutils/cache/LruDiskCache$Entry;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    iput-object v0, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;->written:[Z

    .line 810
    return-void

    .line 809
    :cond_0
    invoke-static {p1}, Lcom/lidroid/xutils/cache/LruDiskCache;->access$7(Lcom/lidroid/xutils/cache/LruDiskCache;)I

    move-result v0

    new-array v0, v0, [Z

    goto :goto_0
.end method

.method synthetic constructor <init>(Lcom/lidroid/xutils/cache/LruDiskCache;Lcom/lidroid/xutils/cache/LruDiskCache$Entry;Lcom/lidroid/xutils/cache/LruDiskCache$Editor;)V
    .locals 0

    .prologue
    .line 807
    invoke-direct {p0, p1, p2}, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;-><init>(Lcom/lidroid/xutils/cache/LruDiskCache;Lcom/lidroid/xutils/cache/LruDiskCache$Entry;)V

    return-void
.end method

.method static synthetic access$0(Lcom/lidroid/xutils/cache/LruDiskCache$Editor;Z)V
    .locals 0

    .prologue
    .line 804
    iput-boolean p1, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;->hasErrors:Z

    return-void
.end method

.method static synthetic access$2(Lcom/lidroid/xutils/cache/LruDiskCache$Editor;)Lcom/lidroid/xutils/cache/LruDiskCache$Entry;
    .locals 1

    .prologue
    .line 802
    iget-object v0, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;->entry:Lcom/lidroid/xutils/cache/LruDiskCache$Entry;

    return-object v0
.end method

.method static synthetic access$3(Lcom/lidroid/xutils/cache/LruDiskCache$Editor;)[Z
    .locals 1

    .prologue
    .line 803
    iget-object v0, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;->written:[Z

    return-object v0
.end method


# virtual methods
.method public abort()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 910
    iget-object v0, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;->this$0:Lcom/lidroid/xutils/cache/LruDiskCache;

    const/4 v1, 0x0

    invoke-static {v0, p0, v1}, Lcom/lidroid/xutils/cache/LruDiskCache;->access$10(Lcom/lidroid/xutils/cache/LruDiskCache;Lcom/lidroid/xutils/cache/LruDiskCache$Editor;Z)V

    .line 911
    return-void
.end method

.method public abortUnlessCommitted()V
    .locals 1

    .prologue
    .line 914
    iget-boolean v0, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;->committed:Z

    if-nez v0, :cond_0

    .line 916
    :try_start_0
    invoke-virtual {p0}, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;->abort()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 920
    :cond_0
    :goto_0
    return-void

    .line 917
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public commit()V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x1

    .line 896
    iget-boolean v0, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;->hasErrors:Z

    if-eqz v0, :cond_0

    .line 897
    iget-object v0, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;->this$0:Lcom/lidroid/xutils/cache/LruDiskCache;

    const/4 v1, 0x0

    invoke-static {v0, p0, v1}, Lcom/lidroid/xutils/cache/LruDiskCache;->access$10(Lcom/lidroid/xutils/cache/LruDiskCache;Lcom/lidroid/xutils/cache/LruDiskCache$Editor;Z)V

    .line 898
    iget-object v0, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;->this$0:Lcom/lidroid/xutils/cache/LruDiskCache;

    iget-object v1, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;->entry:Lcom/lidroid/xutils/cache/LruDiskCache$Entry;

    invoke-static {v1}, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->access$3(Lcom/lidroid/xutils/cache/LruDiskCache$Entry;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/lidroid/xutils/cache/LruDiskCache;->access$11(Lcom/lidroid/xutils/cache/LruDiskCache;Ljava/lang/String;)Z

    .line 902
    :goto_0
    iput-boolean v2, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;->committed:Z

    .line 903
    return-void

    .line 900
    :cond_0
    iget-object v0, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;->this$0:Lcom/lidroid/xutils/cache/LruDiskCache;

    invoke-static {v0, p0, v2}, Lcom/lidroid/xutils/cache/LruDiskCache;->access$10(Lcom/lidroid/xutils/cache/LruDiskCache;Lcom/lidroid/xutils/cache/LruDiskCache$Editor;Z)V

    goto :goto_0
.end method

.method public getString(I)Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 841
    invoke-virtual {p0, p1}, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;->newInputStream(I)Ljava/io/InputStream;

    move-result-object v0

    .line 842
    if-eqz v0, :cond_0

    invoke-static {v0}, Lcom/lidroid/xutils/cache/LruDiskCache;->access$6(Ljava/io/InputStream;)Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public newInputStream(I)Ljava/io/InputStream;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    .line 821
    iget-object v2, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;->this$0:Lcom/lidroid/xutils/cache/LruDiskCache;

    monitor-enter v2

    .line 822
    :try_start_0
    iget-object v1, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;->entry:Lcom/lidroid/xutils/cache/LruDiskCache$Entry;

    invoke-static {v1}, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->access$2(Lcom/lidroid/xutils/cache/LruDiskCache$Entry;)Lcom/lidroid/xutils/cache/LruDiskCache$Editor;

    move-result-object v1

    if-eq v1, p0, :cond_0

    .line 823
    new-instance v0, Ljava/lang/IllegalStateException;

    invoke-direct {v0}, Ljava/lang/IllegalStateException;-><init>()V

    throw v0

    .line 821
    :catchall_0
    move-exception v0

    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    .line 825
    :cond_0
    :try_start_1
    iget-object v1, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;->entry:Lcom/lidroid/xutils/cache/LruDiskCache$Entry;

    invoke-static {v1}, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->access$0(Lcom/lidroid/xutils/cache/LruDiskCache$Entry;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 826
    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 831
    :goto_0
    return-object v0

    .line 829
    :cond_1
    :try_start_2
    new-instance v1, Ljava/io/FileInputStream;

    iget-object v3, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;->entry:Lcom/lidroid/xutils/cache/LruDiskCache$Entry;

    invoke-virtual {v3, p1}, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->getCleanFile(I)Ljava/io/File;

    move-result-object v3

    invoke-direct {v1, v3}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_2
    .catch Ljava/io/FileNotFoundException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :try_start_3
    monitor-exit v2

    move-object v0, v1

    goto :goto_0

    .line 830
    :catch_0
    move-exception v1

    .line 831
    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_0
.end method

.method public newOutputStream(I)Ljava/io/OutputStream;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 853
    iget-object v2, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;->this$0:Lcom/lidroid/xutils/cache/LruDiskCache;

    monitor-enter v2

    .line 854
    :try_start_0
    iget-object v0, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;->entry:Lcom/lidroid/xutils/cache/LruDiskCache$Entry;

    invoke-static {v0}, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->access$2(Lcom/lidroid/xutils/cache/LruDiskCache$Entry;)Lcom/lidroid/xutils/cache/LruDiskCache$Editor;

    move-result-object v0

    if-eq v0, p0, :cond_0

    .line 855
    new-instance v0, Ljava/lang/IllegalStateException;

    invoke-direct {v0}, Ljava/lang/IllegalStateException;-><init>()V

    throw v0

    .line 853
    :catchall_0
    move-exception v0

    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    .line 857
    :cond_0
    :try_start_1
    iget-object v0, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;->entry:Lcom/lidroid/xutils/cache/LruDiskCache$Entry;

    invoke-static {v0}, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->access$0(Lcom/lidroid/xutils/cache/LruDiskCache$Entry;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 858
    iget-object v0, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;->written:[Z

    const/4 v1, 0x1

    aput-boolean v1, v0, p1

    .line 860
    :cond_1
    iget-object v0, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;->entry:Lcom/lidroid/xutils/cache/LruDiskCache$Entry;

    invoke-virtual {v0, p1}, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->getDirtyFile(I)Ljava/io/File;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v1

    .line 863
    :try_start_2
    new-instance v0, Ljava/io/FileOutputStream;

    invoke-direct {v0, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_2
    .catch Ljava/io/FileNotFoundException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-object v1, v0

    .line 874
    :goto_0
    :try_start_3
    new-instance v0, Lcom/lidroid/xutils/cache/LruDiskCache$Editor$FaultHidingOutputStream;

    const/4 v3, 0x0

    invoke-direct {v0, p0, v1, v3}, Lcom/lidroid/xutils/cache/LruDiskCache$Editor$FaultHidingOutputStream;-><init>(Lcom/lidroid/xutils/cache/LruDiskCache$Editor;Ljava/io/OutputStream;Lcom/lidroid/xutils/cache/LruDiskCache$Editor$FaultHidingOutputStream;)V

    monitor-exit v2

    :goto_1
    return-object v0

    .line 864
    :catch_0
    move-exception v0

    .line 866
    iget-object v0, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;->this$0:Lcom/lidroid/xutils/cache/LruDiskCache;

    invoke-static {v0}, Lcom/lidroid/xutils/cache/LruDiskCache;->access$8(Lcom/lidroid/xutils/cache/LruDiskCache;)Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 868
    :try_start_4
    new-instance v0, Ljava/io/FileOutputStream;

    invoke-direct {v0, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_4
    .catch Ljava/io/FileNotFoundException; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    move-object v1, v0

    .line 869
    goto :goto_0

    :catch_1
    move-exception v0

    .line 871
    :try_start_5
    invoke-static {}, Lcom/lidroid/xutils/cache/LruDiskCache;->access$9()Ljava/io/OutputStream;

    move-result-object v0

    monitor-exit v2
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    goto :goto_1
.end method

.method public set(ILjava/lang/String;)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 882
    const/4 v2, 0x0

    .line 884
    :try_start_0
    new-instance v1, Ljava/io/OutputStreamWriter;

    invoke-virtual {p0, p1}, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;->newOutputStream(I)Ljava/io/OutputStream;

    move-result-object v0

    const-string v3, "UTF-8"

    invoke-direct {v1, v0, v3}, Ljava/io/OutputStreamWriter;-><init>(Ljava/io/OutputStream;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 885
    :try_start_1
    invoke-virtual {v1, p2}, Ljava/io/Writer;->write(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 887
    invoke-static {v1}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    .line 889
    return-void

    .line 886
    :catchall_0
    move-exception v0

    move-object v1, v2

    .line 887
    :goto_0
    invoke-static {v1}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    .line 888
    throw v0

    .line 886
    :catchall_1
    move-exception v0

    goto :goto_0
.end method

.method public setEntryExpiryTimestamp(J)V
    .locals 1

    .prologue
    .line 813
    iget-object v0, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;->entry:Lcom/lidroid/xutils/cache/LruDiskCache$Entry;

    invoke-static {v0, p1, p2}, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->access$1(Lcom/lidroid/xutils/cache/LruDiskCache$Entry;J)V

    .line 814
    return-void
.end method
