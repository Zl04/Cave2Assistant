.class public Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;
.super Ljava/lang/Object;
.source "UpdateVersionManager.java"

# interfaces
.implements Lcom/cyjh/elfin/mvp/managers/BaseManager;
.implements Lcom/cyjh/elfin/mvp/views/UpdateVersionView;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager$OnUpdateVersionBack;
    }
.end annotation


# static fields
.field public static final EMPTY_VALUE:I = 0x3

.field public static final ERROR_VALUE:I = 0x1

.field public static final SUCCESSFUL_VALUE:I = 0x2

.field private static sInstance:Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;


# instance fields
.field private isDismiss:Z

.field private mDismissBack:Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager$OnUpdateVersionBack;

.field private mUpdateVersionPresenter:Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;


# direct methods
.method private constructor <init>()V
    .locals 2

    .prologue
    .line 33
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 85
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;->isDismiss:Z

    .line 34
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;->mUpdateVersionPresenter:Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;

    if-nez v0, :cond_0

    .line 35
    new-instance v0, Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;

    invoke-static {}, Lcom/cyjh/elfin/AppContext;->getInstance()Lcom/cyjh/elfin/AppContext;

    move-result-object v1

    invoke-direct {v0, v1, p0}, Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;-><init>(Landroid/content/Context;Lcom/cyjh/elfin/mvp/views/UpdateVersionView;)V

    iput-object v0, p0, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;->mUpdateVersionPresenter:Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;

    .line 37
    :cond_0
    return-void
.end method

.method public static builder()Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;
    .locals 1

    .prologue
    .line 41
    sget-object v0, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;->sInstance:Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;

    if-nez v0, :cond_0

    .line 42
    new-instance v0, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;

    invoke-direct {v0}, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;-><init>()V

    sput-object v0, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;->sInstance:Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;

    .line 44
    :cond_0
    sget-object v0, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;->sInstance:Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;

    return-object v0
.end method


# virtual methods
.method public onUpdateEmpty()V
    .locals 2

    .prologue
    .line 80
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;->mDismissBack:Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager$OnUpdateVersionBack;

    if-eqz v0, :cond_0

    .line 81
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;->mDismissBack:Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager$OnUpdateVersionBack;

    const/4 v1, 0x3

    invoke-interface {v0, v1}, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager$OnUpdateVersionBack;->onCall(I)V

    .line 83
    :cond_0
    return-void
.end method

.method public onUpdateFailure(Ljava/lang/String;)V
    .locals 2
    .param p1, "errorMsg"    # Ljava/lang/String;

    .prologue
    .line 73
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;->mDismissBack:Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager$OnUpdateVersionBack;

    if-eqz v0, :cond_0

    .line 74
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;->mDismissBack:Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager$OnUpdateVersionBack;

    const/4 v1, 0x1

    invoke-interface {v0, v1}, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager$OnUpdateVersionBack;->onCall(I)V

    .line 76
    :cond_0
    return-void
.end method

.method public onUpdateSuccessful(Lcom/cyjh/elfin/entity/UpdateInfo;)V
    .locals 5
    .param p1, "updateInfo"    # Lcom/cyjh/elfin/entity/UpdateInfo;

    .prologue
    const/4 v2, 0x0

    .line 53
    iget-boolean v3, p0, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;->isDismiss:Z

    invoke-virtual {p1, v3}, Lcom/cyjh/elfin/entity/UpdateInfo;->setDismissing(Z)V

    .line 55
    iget-boolean v3, p0, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;->isDismiss:Z

    if-eqz v3, :cond_0

    iget-object v3, p0, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;->mDismissBack:Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager$OnUpdateVersionBack;

    if-nez v3, :cond_1

    :cond_0
    iget-boolean v3, p0, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;->isDismiss:Z

    if-nez v3, :cond_4

    iget-object v3, p0, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;->mDismissBack:Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager$OnUpdateVersionBack;

    if-nez v3, :cond_4

    :cond_1
    const/4 v0, 0x1

    .line 56
    .local v0, "isPopUp":Z
    :goto_0
    if-eqz v0, :cond_2

    .line 57
    new-instance v1, Lcom/cyjh/elfin/dialog/UpdateDialog;

    iget-object v3, p1, Lcom/cyjh/elfin/entity/UpdateInfo;->mContext:Landroid/content/Context;

    invoke-direct {v1, v3, p1}, Lcom/cyjh/elfin/dialog/UpdateDialog;-><init>(Landroid/content/Context;Lcom/cyjh/elfin/entity/UpdateInfo;)V

    .line 58
    .local v1, "updateDialog":Lcom/cyjh/elfin/dialog/UpdateDialog;
    invoke-virtual {v1}, Lcom/cyjh/elfin/dialog/UpdateDialog;->show()V

    .line 60
    .end local v1    # "updateDialog":Lcom/cyjh/elfin/dialog/UpdateDialog;
    :cond_2
    iget-object v3, p0, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;->mDismissBack:Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager$OnUpdateVersionBack;

    if-eqz v3, :cond_3

    .line 61
    invoke-virtual {p1}, Lcom/cyjh/elfin/entity/UpdateInfo;->getUpdateType()I

    move-result v3

    if-nez v3, :cond_5

    .line 62
    iget-object v3, p0, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;->mDismissBack:Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager$OnUpdateVersionBack;

    const/4 v4, 0x2

    invoke-interface {v3, v4}, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager$OnUpdateVersionBack;->onCall(I)V

    .line 68
    :cond_3
    :goto_1
    iput-boolean v2, p0, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;->isDismiss:Z

    .line 69
    return-void

    .end local v0    # "isPopUp":Z
    :cond_4
    move v0, v2

    .line 55
    goto :goto_0

    .line 64
    .restart local v0    # "isPopUp":Z
    :cond_5
    iget-object v3, p0, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;->mDismissBack:Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager$OnUpdateVersionBack;

    const/4 v4, 0x3

    invoke-interface {v3, v4}, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager$OnUpdateVersionBack;->onCall(I)V

    goto :goto_1
.end method

.method public setDismiss(Z)Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;
    .locals 0
    .param p1, "dismiss"    # Z

    .prologue
    .line 88
    iput-boolean p1, p0, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;->isDismiss:Z

    .line 89
    return-object p0
.end method

.method public setDismissBack(Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager$OnUpdateVersionBack;)Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;
    .locals 0
    .param p1, "dismissBack"    # Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager$OnUpdateVersionBack;

    .prologue
    .line 103
    iput-object p1, p0, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;->mDismissBack:Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager$OnUpdateVersionBack;

    .line 104
    return-object p0
.end method

.method public updateVersion(ZLandroid/content/Context;)V
    .locals 1
    .param p1, "isToast"    # Z
    .param p2, "context"    # Landroid/content/Context;

    .prologue
    .line 48
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;->mUpdateVersionPresenter:Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;

    invoke-virtual {v0, p1, p2}, Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;->updateVersion(ZLandroid/content/Context;)V

    .line 49
    return-void
.end method
