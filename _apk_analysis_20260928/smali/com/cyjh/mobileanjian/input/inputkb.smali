.class public Lcom/cyjh/mobileanjian/input/inputkb;
.super Landroid/inputmethodservice/InputMethodService;
.source "SourceFile"


# static fields
.field public static mgHandler:Landroid/os/Handler;


# instance fields
.field a:Landroid/view/inputmethod/EditorInfo;

.field private b:Landroid/inputmethodservice/KeyboardView;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 10
    invoke-direct {p0}, Landroid/inputmethodservice/InputMethodService;-><init>()V

    return-void
.end method


# virtual methods
.method public onCreate()V
    .locals 1

    .prologue
    .line 20
    invoke-super {p0}, Landroid/inputmethodservice/InputMethodService;->onCreate()V

    .line 21
    invoke-static {}, Lcom/cyjh/mobileanjian/input/a;->a()Lcom/cyjh/mobileanjian/input/a;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/cyjh/mobileanjian/input/a;->a(Landroid/inputmethodservice/InputMethodService;)V

    .line 22
    return-void
.end method

.method public onCreateInputView()Landroid/view/View;
    .locals 1

    .prologue
    .line 27
    iget-object v0, p0, Lcom/cyjh/mobileanjian/input/inputkb;->b:Landroid/inputmethodservice/KeyboardView;

    return-object v0
.end method

.method public onDestroy()V
    .locals 1

    .prologue
    .line 55
    invoke-super {p0}, Landroid/inputmethodservice/InputMethodService;->onDestroy()V

    .line 56
    invoke-static {}, Lcom/cyjh/mobileanjian/input/a;->a()Lcom/cyjh/mobileanjian/input/a;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/input/a;->b()V

    .line 57
    return-void
.end method

.method public onEvaluateFullscreenMode()Z
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 32
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/input/inputkb;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    .line 33
    iget v0, v0, Landroid/content/res/Configuration;->orientation:I

    const/4 v1, 0x2

    if-eq v0, v1, :cond_1

    .line 41
    :cond_0
    :goto_0
    return v2

    .line 37
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/input/inputkb;->a:Landroid/view/inputmethod/EditorInfo;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/cyjh/mobileanjian/input/inputkb;->a:Landroid/view/inputmethod/EditorInfo;

    iget v0, v0, Landroid/view/inputmethod/EditorInfo;->imeOptions:I

    const/high16 v1, 0x10000000

    and-int/2addr v0, v1

    if-eqz v0, :cond_0

    goto :goto_0
.end method

.method public onFinishInputView(Z)V
    .locals 0

    .prologue
    .line 48
    invoke-super {p0, p1}, Landroid/inputmethodservice/InputMethodService;->onFinishInputView(Z)V

    .line 49
    return-void
.end method
