.class public Lcom/cyjh/mobileanjian/ipc/utils/a;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field private final a:Ljava/util/Properties;


# direct methods
.method private constructor <init>()V
    .locals 5

    .prologue
    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 26
    new-instance v0, Ljava/util/Properties;

    invoke-direct {v0}, Ljava/util/Properties;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/utils/a;->a:Ljava/util/Properties;

    .line 29
    :try_start_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/utils/a;->a:Ljava/util/Properties;

    new-instance v1, Ljava/io/FileInputStream;

    new-instance v2, Ljava/io/File;

    invoke-static {}, Landroid/os/Environment;->getRootDirectory()Ljava/io/File;

    move-result-object v3

    const-string v4, "build.prop"

    invoke-direct {v2, v3, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-direct {v1, v2}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    invoke-virtual {v0, v1}, Ljava/util/Properties;->load(Ljava/io/InputStream;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 35
    :goto_0
    return-void

    .line 31
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public static g()Lcom/cyjh/mobileanjian/ipc/utils/a;
    .locals 1

    .prologue
    .line 78
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/utils/a;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/utils/a;-><init>()V

    return-object v0
.end method


# virtual methods
.method public a(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 50
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/utils/a;->a:Ljava/util/Properties;

    invoke-virtual {v0, p1}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 54
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/utils/a;->a:Ljava/util/Properties;

    invoke-virtual {v0, p1, p2}, Ljava/util/Properties;->getProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public a()Ljava/util/Set;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Set",
            "<",
            "Ljava/util/Map$Entry",
            "<",
            "Ljava/lang/Object;",
            "Ljava/lang/Object;",
            ">;>;"
        }
    .end annotation

    .prologue
    .line 46
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/utils/a;->a:Ljava/util/Properties;

    invoke-virtual {v0}, Ljava/util/Properties;->entrySet()Ljava/util/Set;

    move-result-object v0

    return-object v0
.end method

.method public a(Ljava/lang/Object;)Z
    .locals 1

    .prologue
    .line 38
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/utils/a;->a:Ljava/util/Properties;

    invoke-virtual {v0, p1}, Ljava/util/Properties;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public b()Z
    .locals 1

    .prologue
    .line 58
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/utils/a;->a:Ljava/util/Properties;

    invoke-virtual {v0}, Ljava/util/Properties;->isEmpty()Z

    move-result v0

    return v0
.end method

.method public b(Ljava/lang/Object;)Z
    .locals 1

    .prologue
    .line 42
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/utils/a;->a:Ljava/util/Properties;

    invoke-virtual {v0, p1}, Ljava/util/Properties;->containsValue(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public c()Ljava/util/Enumeration;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Enumeration",
            "<",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation

    .prologue
    .line 62
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/utils/a;->a:Ljava/util/Properties;

    invoke-virtual {v0}, Ljava/util/Properties;->keys()Ljava/util/Enumeration;

    move-result-object v0

    return-object v0
.end method

.method public d()Ljava/util/Set;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Set",
            "<",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation

    .prologue
    .line 66
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/utils/a;->a:Ljava/util/Properties;

    invoke-virtual {v0}, Ljava/util/Properties;->keySet()Ljava/util/Set;

    move-result-object v0

    return-object v0
.end method

.method public e()I
    .locals 1

    .prologue
    .line 70
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/utils/a;->a:Ljava/util/Properties;

    invoke-virtual {v0}, Ljava/util/Properties;->size()I

    move-result v0

    return v0
.end method

.method public f()Ljava/util/Collection;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Collection",
            "<",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation

    .prologue
    .line 74
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/utils/a;->a:Ljava/util/Properties;

    invoke-virtual {v0}, Ljava/util/Properties;->values()Ljava/util/Collection;

    move-result-object v0

    return-object v0
.end method
