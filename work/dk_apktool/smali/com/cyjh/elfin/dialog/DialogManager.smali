.class public Lcom/cyjh/elfin/dialog/DialogManager;
.super Ljava/lang/Object;
.source "DialogManager.java"


# static fields
.field private static dialogManager:Lcom/cyjh/elfin/dialog/DialogManager;


# instance fields
.field private progressDialog:Landroid/app/ProgressDialog;


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 18
    return-void
.end method

.method public static getInstance()Lcom/cyjh/elfin/dialog/DialogManager;
    .locals 1

    .prologue
    .line 20
    sget-object v0, Lcom/cyjh/elfin/dialog/DialogManager;->dialogManager:Lcom/cyjh/elfin/dialog/DialogManager;

    if-nez v0, :cond_0

    .line 21
    new-instance v0, Lcom/cyjh/elfin/dialog/DialogManager;

    invoke-direct {v0}, Lcom/cyjh/elfin/dialog/DialogManager;-><init>()V

    sput-object v0, Lcom/cyjh/elfin/dialog/DialogManager;->dialogManager:Lcom/cyjh/elfin/dialog/DialogManager;

    .line 23
    :cond_0
    sget-object v0, Lcom/cyjh/elfin/dialog/DialogManager;->dialogManager:Lcom/cyjh/elfin/dialog/DialogManager;

    return-object v0
.end method

.method private setBackgroundShadow(Landroid/app/AlertDialog;)V
    .locals 3
    .param p1, "mAlertDialog"    # Landroid/app/AlertDialog;

    .prologue
    .line 72
    invoke-virtual {p1}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v1

    .line 73
    .local v1, "window":Landroid/view/Window;
    invoke-virtual {v1}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    .line 74
    .local v0, "lp":Landroid/view/WindowManager$LayoutParams;
    const v2, 0x3f19999a    # 0.6f

    iput v2, v0, Landroid/view/WindowManager$LayoutParams;->dimAmount:F

    .line 75
    invoke-virtual {v1, v0}, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V

    .line 76
    const/4 v2, 0x2

    invoke-virtual {v1, v2}, Landroid/view/Window;->addFlags(I)V

    .line 77
    return-void
.end method

.method private showProgressDialog(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "message"    # Ljava/lang/String;

    .prologue
    .line 27
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/DialogManager;->progressDialog:Landroid/app/ProgressDialog;

    if-nez v0, :cond_0

    .line 28
    new-instance v0, Landroid/app/ProgressDialog;

    invoke-direct {v0, p1}, Landroid/app/ProgressDialog;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/cyjh/elfin/dialog/DialogManager;->progressDialog:Landroid/app/ProgressDialog;

    .line 30
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/DialogManager;->progressDialog:Landroid/app/ProgressDialog;

    invoke-virtual {v0, p2}, Landroid/app/ProgressDialog;->setMessage(Ljava/lang/CharSequence;)V

    .line 31
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/DialogManager;->progressDialog:Landroid/app/ProgressDialog;

    invoke-virtual {v0}, Landroid/app/ProgressDialog;->show()V

    .line 32
    return-void
.end method


# virtual methods
.method public hideProgressDialog()V
    .locals 1

    .prologue
    .line 47
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/DialogManager;->progressDialog:Landroid/app/ProgressDialog;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/cyjh/elfin/dialog/DialogManager;->progressDialog:Landroid/app/ProgressDialog;

    invoke-virtual {v0}, Landroid/app/ProgressDialog;->isShowing()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 48
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/DialogManager;->progressDialog:Landroid/app/ProgressDialog;

    invoke-virtual {v0}, Landroid/app/ProgressDialog;->dismiss()V

    .line 49
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/cyjh/elfin/dialog/DialogManager;->progressDialog:Landroid/app/ProgressDialog;

    .line 51
    :cond_0
    return-void
.end method

.method public showMessageDialog(Landroid/content/Context;II)Landroid/app/AlertDialog;
    .locals 4
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "layoutId"    # I
    .param p3, "theme"    # I

    .prologue
    .line 60
    new-instance v1, Landroid/app/AlertDialog$Builder;

    invoke-direct {v1, p1, p3}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;I)V

    .line 61
    .local v1, "mBuilder":Landroid/app/AlertDialog$Builder;
    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v2, p2, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    .line 62
    invoke-virtual {v1}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    .line 63
    .local v0, "mAlertDialog":Landroid/app/AlertDialog;
    invoke-direct {p0, v0}, Lcom/cyjh/elfin/dialog/DialogManager;->setBackgroundShadow(Landroid/app/AlertDialog;)V

    .line 64
    return-object v0
.end method

.method public showProgressDialog(Landroid/content/Context;I)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "resId"    # I

    .prologue
    .line 40
    invoke-virtual {p1, p2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, p1, v0}, Lcom/cyjh/elfin/dialog/DialogManager;->showProgressDialog(Landroid/content/Context;Ljava/lang/String;)V

    .line 41
    return-void
.end method
