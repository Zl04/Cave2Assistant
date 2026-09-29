.class Ljavax/mail/Session$6;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/security/PrivilegedAction;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Ljavax/mail/Session;->getSystemResources(Ljava/lang/String;)[Ljava/net/URL;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field private final synthetic val$name:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Ljavax/mail/Session$6;->val$name:Ljava/lang/String;

    .line 1238
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()Ljava/lang/Object;
    .locals 4

    .prologue
    .line 1240
    const/4 v0, 0x0

    check-cast v0, [Ljava/net/URL;

    .line 1242
    :try_start_0
    new-instance v2, Ljava/util/Vector;

    invoke-direct {v2}, Ljava/util/Vector;-><init>()V

    .line 1243
    iget-object v1, p0, Ljavax/mail/Session$6;->val$name:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/ClassLoader;->getSystemResources(Ljava/lang/String;)Ljava/util/Enumeration;

    move-result-object v3

    .line 1244
    :cond_0
    :goto_0
    if-eqz v3, :cond_1

    invoke-interface {v3}, Ljava/util/Enumeration;->hasMoreElements()Z

    move-result v1

    if-nez v1, :cond_3

    .line 1249
    :cond_1
    invoke-virtual {v2}, Ljava/util/Vector;->size()I

    move-result v1

    if-lez v1, :cond_2

    .line 1250
    invoke-virtual {v2}, Ljava/util/Vector;->size()I

    move-result v1

    new-array v0, v1, [Ljava/net/URL;

    .line 1251
    invoke-virtual {v2, v0}, Ljava/util/Vector;->copyInto([Ljava/lang/Object;)V

    .line 1255
    :cond_2
    :goto_1
    return-object v0

    .line 1245
    :cond_3
    invoke-interface {v3}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/net/URL;

    .line 1246
    if-eqz v1, :cond_0

    .line 1247
    invoke-virtual {v2, v1}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_0

    .line 1253
    :catch_0
    move-exception v1

    goto :goto_1

    .line 1254
    :catch_1
    move-exception v1

    goto :goto_1
.end method
