.class public Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter;
.super Ljava/lang/Object;
.source "TemplatePresenter.java"

# interfaces
.implements Lcom/cyjh/elfin/mvp/managers/BaseManager;


# static fields
.field public static final SINGLE_APK_TEMPLATE:I = 0xb

.field public static final TEMPLATE_APK:I = 0xa


# instance fields
.field private templateManager:Lcom/cyjh/elfin/mvp/managers/TemplateManager;

.field private templateView:Lcom/cyjh/elfin/mvp/views/TemplateView;


# direct methods
.method public constructor <init>(Lcom/cyjh/elfin/mvp/views/TemplateView;)V
    .locals 1
    .param p1, "templateView"    # Lcom/cyjh/elfin/mvp/views/TemplateView;

    .prologue
    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 23
    iput-object p1, p0, Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter;->templateView:Lcom/cyjh/elfin/mvp/views/TemplateView;

    .line 24
    new-instance v0, Lcom/cyjh/elfin/mvp/managers/TemplateManager;

    invoke-direct {v0}, Lcom/cyjh/elfin/mvp/managers/TemplateManager;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter;->templateManager:Lcom/cyjh/elfin/mvp/managers/TemplateManager;

    .line 25
    return-void
.end method

.method static synthetic access$000(Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter;)Lcom/cyjh/elfin/mvp/views/TemplateView;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter;

    .prologue
    .line 16
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter;->templateView:Lcom/cyjh/elfin/mvp/views/TemplateView;

    return-object v0
.end method


# virtual methods
.method public singleApkOrTemplateChecked(Ljava/lang/String;Landroid/content/Context;Ljava/lang/String;)V
    .locals 2
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "context"    # Landroid/content/Context;
    .param p3, "interfaceName"    # Ljava/lang/String;

    .prologue
    .line 35
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter;->templateManager:Lcom/cyjh/elfin/mvp/managers/TemplateManager;

    new-instance v1, Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter$1;

    invoke-direct {v1, p0, p3}, Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter$1;-><init>(Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter;Ljava/lang/String;)V

    invoke-virtual {v0, p1, v1, p2, p3}, Lcom/cyjh/elfin/mvp/managers/TemplateManager;->singleApkOrTemplateChecked(Ljava/lang/String;Lcom/cyjh/elfin/mvp/managers/Callback;Landroid/content/Context;Ljava/lang/String;)V

    .line 53
    return-void
.end method
