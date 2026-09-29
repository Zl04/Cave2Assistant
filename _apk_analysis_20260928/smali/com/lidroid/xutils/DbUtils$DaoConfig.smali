.class public Lcom/lidroid/xutils/DbUtils$DaoConfig;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lidroid/xutils/DbUtils;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "DaoConfig"
.end annotation


# instance fields
.field private context:Landroid/content/Context;

.field private dbDir:Ljava/lang/String;

.field private dbName:Ljava/lang/String;

.field private dbUpgradeListener:Lcom/lidroid/xutils/DbUtils$DbUpgradeListener;

.field private dbVersion:I


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 582
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 576
    const-string v0, "xUtils.db"

    iput-object v0, p0, Lcom/lidroid/xutils/DbUtils$DaoConfig;->dbName:Ljava/lang/String;

    .line 577
    const/4 v0, 0x1

    iput v0, p0, Lcom/lidroid/xutils/DbUtils$DaoConfig;->dbVersion:I

    .line 583
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Lcom/lidroid/xutils/DbUtils$DaoConfig;->context:Landroid/content/Context;

    .line 584
    return-void
.end method


# virtual methods
.method public getContext()Landroid/content/Context;
    .locals 1

    .prologue
    .line 587
    iget-object v0, p0, Lcom/lidroid/xutils/DbUtils$DaoConfig;->context:Landroid/content/Context;

    return-object v0
.end method

.method public getDbDir()Ljava/lang/String;
    .locals 1

    .prologue
    .line 617
    iget-object v0, p0, Lcom/lidroid/xutils/DbUtils$DaoConfig;->dbDir:Ljava/lang/String;

    return-object v0
.end method

.method public getDbName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 591
    iget-object v0, p0, Lcom/lidroid/xutils/DbUtils$DaoConfig;->dbName:Ljava/lang/String;

    return-object v0
.end method

.method public getDbUpgradeListener()Lcom/lidroid/xutils/DbUtils$DbUpgradeListener;
    .locals 1

    .prologue
    .line 609
    iget-object v0, p0, Lcom/lidroid/xutils/DbUtils$DaoConfig;->dbUpgradeListener:Lcom/lidroid/xutils/DbUtils$DbUpgradeListener;

    return-object v0
.end method

.method public getDbVersion()I
    .locals 1

    .prologue
    .line 601
    iget v0, p0, Lcom/lidroid/xutils/DbUtils$DaoConfig;->dbVersion:I

    return v0
.end method

.method public setDbDir(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 626
    iput-object p1, p0, Lcom/lidroid/xutils/DbUtils$DaoConfig;->dbDir:Ljava/lang/String;

    .line 627
    return-void
.end method

.method public setDbName(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 595
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 596
    iput-object p1, p0, Lcom/lidroid/xutils/DbUtils$DaoConfig;->dbName:Ljava/lang/String;

    .line 598
    :cond_0
    return-void
.end method

.method public setDbUpgradeListener(Lcom/lidroid/xutils/DbUtils$DbUpgradeListener;)V
    .locals 0

    .prologue
    .line 613
    iput-object p1, p0, Lcom/lidroid/xutils/DbUtils$DaoConfig;->dbUpgradeListener:Lcom/lidroid/xutils/DbUtils$DbUpgradeListener;

    .line 614
    return-void
.end method

.method public setDbVersion(I)V
    .locals 0

    .prologue
    .line 605
    iput p1, p0, Lcom/lidroid/xutils/DbUtils$DaoConfig;->dbVersion:I

    .line 606
    return-void
.end method
