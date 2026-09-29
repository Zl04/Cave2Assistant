.class public final Lcom/lidroid/xutils/cache/LruDiskCache$Snapshot;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/io/Closeable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lidroid/xutils/cache/LruDiskCache;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x11
    name = "Snapshot"
.end annotation


# instance fields
.field private final diskKey:Ljava/lang/String;

.field private final ins:[Ljava/io/FileInputStream;

.field private final lengths:[J

.field private final sequenceNumber:J

.field final synthetic this$0:Lcom/lidroid/xutils/cache/LruDiskCache;


# direct methods
.method private constructor <init>(Lcom/lidroid/xutils/cache/LruDiskCache;Ljava/lang/String;J[Ljava/io/FileInputStream;[J)V
    .locals 1

    .prologue
    .line 746
    iput-object p1, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Snapshot;->this$0:Lcom/lidroid/xutils/cache/LruDiskCache;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 747
    iput-object p2, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Snapshot;->diskKey:Ljava/lang/String;

    .line 748
    iput-wide p3, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Snapshot;->sequenceNumber:J

    .line 749
    iput-object p5, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Snapshot;->ins:[Ljava/io/FileInputStream;

    .line 750
    iput-object p6, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Snapshot;->lengths:[J

    .line 751
    return-void
.end method

.method synthetic constructor <init>(Lcom/lidroid/xutils/cache/LruDiskCache;Ljava/lang/String;J[Ljava/io/FileInputStream;[JLcom/lidroid/xutils/cache/LruDiskCache$Snapshot;)V
    .locals 1

    .prologue
    .line 746
    invoke-direct/range {p0 .. p6}, Lcom/lidroid/xutils/cache/LruDiskCache$Snapshot;-><init>(Lcom/lidroid/xutils/cache/LruDiskCache;Ljava/lang/String;J[Ljava/io/FileInputStream;[J)V

    return-void
.end method


# virtual methods
.method public close()V
    .locals 4

    .prologue
    .line 785
    iget-object v1, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Snapshot;->ins:[Ljava/io/FileInputStream;

    array-length v2, v1

    const/4 v0, 0x0

    :goto_0
    if-lt v0, v2, :cond_0

    .line 788
    return-void

    .line 785
    :cond_0
    aget-object v3, v1, v0

    .line 786
    invoke-static {v3}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    .line 785
    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method

.method public edit()Lcom/lidroid/xutils/cache/LruDiskCache$Editor;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 759
    iget-object v0, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Snapshot;->this$0:Lcom/lidroid/xutils/cache/LruDiskCache;

    iget-object v1, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Snapshot;->diskKey:Ljava/lang/String;

    iget-wide v2, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Snapshot;->sequenceNumber:J

    invoke-static {v0, v1, v2, v3}, Lcom/lidroid/xutils/cache/LruDiskCache;->access$5(Lcom/lidroid/xutils/cache/LruDiskCache;Ljava/lang/String;J)Lcom/lidroid/xutils/cache/LruDiskCache$Editor;

    move-result-object v0

    return-object v0
.end method

.method public getInputStream(I)Ljava/io/FileInputStream;
    .locals 1

    .prologue
    .line 766
    iget-object v0, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Snapshot;->ins:[Ljava/io/FileInputStream;

    aget-object v0, v0, p1

    return-object v0
.end method

.method public getLength(I)J
    .locals 2

    .prologue
    .line 780
    iget-object v0, p0, Lcom/lidroid/xutils/cache/LruDiskCache$Snapshot;->lengths:[J

    aget-wide v0, v0, p1

    return-wide v0
.end method

.method public getString(I)Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 773
    invoke-virtual {p0, p1}, Lcom/lidroid/xutils/cache/LruDiskCache$Snapshot;->getInputStream(I)Ljava/io/FileInputStream;

    move-result-object v0

    invoke-static {v0}, Lcom/lidroid/xutils/cache/LruDiskCache;->access$6(Ljava/io/InputStream;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
