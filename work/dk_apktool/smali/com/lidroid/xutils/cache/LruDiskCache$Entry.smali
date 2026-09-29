.class final Lcom/lidroid/xutils/cache/LruDiskCache$Entry;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lidroid/xutils/cache/LruDiskCache;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "Entry"
.end annotation


# instance fields
.field private currentEditor:Lcom/lidroid/xutils/cache/LruDiskCache$Editor;

.field private final diskKey:Ljava/lang/String;

.field private expiryTimestamp:J

.field private final lengths:[J

.field private readable:Z

.field private sequenceNumber:J

.field final synthetic this$0:Lcom/lidroid/xutils/cache/LruDiskCache;


# direct methods
.method private constructor <init>(Lcom/lidroid/xutils/cache/LruDiskCache;Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 991
    iput-object p1, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->this$0:Lcom/lidroid/xutils/cache/LruDiskCache;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 969
    const-wide v0, 0x7fffffffffffffffL

    iput-wide v0, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->expiryTimestamp:J

    .line 992
    iput-object p2, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->diskKey:Ljava/lang/String;

    .line 993
    invoke-static {p1}, Lcom/lidroid/xutils/cache/LruDiskCache;->access$7(Lcom/lidroid/xutils/cache/LruDiskCache;)I

    move-result v0

    new-array v0, v0, [J

    iput-object v0, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->lengths:[J

    .line 994
    return-void
.end method

.method synthetic constructor <init>(Lcom/lidroid/xutils/cache/LruDiskCache;Ljava/lang/String;Lcom/lidroid/xutils/cache/LruDiskCache$Entry;)V
    .locals 0

    .prologue
    .line 991
    invoke-direct {p0, p1, p2}, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;-><init>(Lcom/lidroid/xutils/cache/LruDiskCache;Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$0(Lcom/lidroid/xutils/cache/LruDiskCache$Entry;)Z
    .locals 1

    .prologue
    .line 979
    iget-boolean v0, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->readable:Z

    return v0
.end method

.method static synthetic access$1(Lcom/lidroid/xutils/cache/LruDiskCache$Entry;J)V
    .locals 1

    .prologue
    .line 969
    iput-wide p1, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->expiryTimestamp:J

    return-void
.end method

.method static synthetic access$10(Lcom/lidroid/xutils/cache/LruDiskCache$Entry;)J
    .locals 2

    .prologue
    .line 989
    iget-wide v0, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->sequenceNumber:J

    return-wide v0
.end method

.method static synthetic access$11(Lcom/lidroid/xutils/cache/LruDiskCache$Entry;J)V
    .locals 1

    .prologue
    .line 989
    iput-wide p1, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->sequenceNumber:J

    return-void
.end method

.method static synthetic access$2(Lcom/lidroid/xutils/cache/LruDiskCache$Entry;)Lcom/lidroid/xutils/cache/LruDiskCache$Editor;
    .locals 1

    .prologue
    .line 984
    iget-object v0, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->currentEditor:Lcom/lidroid/xutils/cache/LruDiskCache$Editor;

    return-object v0
.end method

.method static synthetic access$3(Lcom/lidroid/xutils/cache/LruDiskCache$Entry;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 967
    iget-object v0, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->diskKey:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$5(Lcom/lidroid/xutils/cache/LruDiskCache$Entry;Z)V
    .locals 0

    .prologue
    .line 979
    iput-boolean p1, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->readable:Z

    return-void
.end method

.method static synthetic access$6(Lcom/lidroid/xutils/cache/LruDiskCache$Entry;Lcom/lidroid/xutils/cache/LruDiskCache$Editor;)V
    .locals 0

    .prologue
    .line 984
    iput-object p1, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->currentEditor:Lcom/lidroid/xutils/cache/LruDiskCache$Editor;

    return-void
.end method

.method static synthetic access$7(Lcom/lidroid/xutils/cache/LruDiskCache$Entry;[Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 1007
    invoke-direct {p0, p1, p2}, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->setLengths([Ljava/lang/String;I)V

    return-void
.end method

.method static synthetic access$8(Lcom/lidroid/xutils/cache/LruDiskCache$Entry;)[J
    .locals 1

    .prologue
    .line 974
    iget-object v0, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->lengths:[J

    return-object v0
.end method

.method static synthetic access$9(Lcom/lidroid/xutils/cache/LruDiskCache$Entry;)J
    .locals 2

    .prologue
    .line 969
    iget-wide v0, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->expiryTimestamp:J

    return-wide v0
.end method

.method private invalidLengths([Ljava/lang/String;)Ljava/io/IOException;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 1022
    new-instance v0, Ljava/io/IOException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "unexpected journal line: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {p1}, Ljava/util/Arrays;->toString([Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private setLengths([Ljava/lang/String;I)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 1008
    array-length v0, p1

    sub-int/2addr v0, p2

    iget-object v1, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->this$0:Lcom/lidroid/xutils/cache/LruDiskCache;

    invoke-static {v1}, Lcom/lidroid/xutils/cache/LruDiskCache;->access$7(Lcom/lidroid/xutils/cache/LruDiskCache;)I

    move-result v1

    if-eq v0, v1, :cond_0

    .line 1009
    invoke-direct {p0, p1}, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->invalidLengths([Ljava/lang/String;)Ljava/io/IOException;

    move-result-object v0

    throw v0

    .line 1013
    :cond_0
    const/4 v0, 0x0

    :goto_0
    :try_start_0
    iget-object v1, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->this$0:Lcom/lidroid/xutils/cache/LruDiskCache;

    invoke-static {v1}, Lcom/lidroid/xutils/cache/LruDiskCache;->access$7(Lcom/lidroid/xutils/cache/LruDiskCache;)I

    move-result v1

    if-lt v0, v1, :cond_1

    .line 1019
    return-void

    .line 1014
    :cond_1
    iget-object v1, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->lengths:[J

    add-int v2, v0, p2

    aget-object v2, p1, v2

    invoke-static {v2}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v2

    aput-wide v2, v1, v0
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1013
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1016
    :catch_0
    move-exception v0

    .line 1017
    invoke-direct {p0, p1}, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->invalidLengths([Ljava/lang/String;)Ljava/io/IOException;

    move-result-object v0

    throw v0
.end method


# virtual methods
.method public getCleanFile(I)Ljava/io/File;
    .locals 4

    .prologue
    .line 1026
    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->this$0:Lcom/lidroid/xutils/cache/LruDiskCache;

    invoke-static {v1}, Lcom/lidroid/xutils/cache/LruDiskCache;->access$8(Lcom/lidroid/xutils/cache/LruDiskCache;)Ljava/io/File;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    iget-object v3, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->diskKey:Ljava/lang/String;

    invoke-static {v3}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v3, "."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    return-object v0
.end method

.method public getDirtyFile(I)Ljava/io/File;
    .locals 4

    .prologue
    .line 1030
    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->this$0:Lcom/lidroid/xutils/cache/LruDiskCache;

    invoke-static {v1}, Lcom/lidroid/xutils/cache/LruDiskCache;->access$8(Lcom/lidroid/xutils/cache/LruDiskCache;)Ljava/io/File;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    iget-object v3, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->diskKey:Ljava/lang/String;

    invoke-static {v3}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v3, "."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ".tmp"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    return-object v0
.end method

.method public getLengths()Ljava/lang/String;
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 997
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 998
    iget-object v2, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Entry;->lengths:[J

    array-length v3, v2

    const/4 v0, 0x0

    :goto_0
    if-lt v0, v3, :cond_0

    .line 1001
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 998
    :cond_0
    aget-wide v4, v2, v0

    .line 999
    const-string v6, " "

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    .line 998
    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method
