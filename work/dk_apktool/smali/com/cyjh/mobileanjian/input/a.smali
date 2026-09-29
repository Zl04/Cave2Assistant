.class public Lcom/cyjh/mobileanjian/input/a;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static a:Lcom/cyjh/mobileanjian/input/a;


# instance fields
.field private b:Landroid/inputmethodservice/InputMethodService;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 11
    const/4 v0, 0x0

    sput-object v0, Lcom/cyjh/mobileanjian/input/a;->a:Lcom/cyjh/mobileanjian/input/a;

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    .prologue
    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 13
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/input/a;->b:Landroid/inputmethodservice/InputMethodService;

    .line 15
    return-void
.end method

.method public static a()Lcom/cyjh/mobileanjian/input/a;
    .locals 1

    .prologue
    .line 19
    sget-object v0, Lcom/cyjh/mobileanjian/input/a;->a:Lcom/cyjh/mobileanjian/input/a;

    if-nez v0, :cond_0

    .line 20
    new-instance v0, Lcom/cyjh/mobileanjian/input/a;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/input/a;-><init>()V

    sput-object v0, Lcom/cyjh/mobileanjian/input/a;->a:Lcom/cyjh/mobileanjian/input/a;

    .line 21
    :cond_0
    sget-object v0, Lcom/cyjh/mobileanjian/input/a;->a:Lcom/cyjh/mobileanjian/input/a;

    return-object v0
.end method


# virtual methods
.method public a(Landroid/inputmethodservice/InputMethodService;)V
    .locals 0

    .prologue
    .line 26
    iput-object p1, p0, Lcom/cyjh/mobileanjian/input/a;->b:Landroid/inputmethodservice/InputMethodService;

    .line 27
    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 36
    iget-object v0, p0, Lcom/cyjh/mobileanjian/input/a;->b:Landroid/inputmethodservice/InputMethodService;

    if-eqz v0, :cond_0

    .line 38
    iget-object v0, p0, Lcom/cyjh/mobileanjian/input/a;->b:Landroid/inputmethodservice/InputMethodService;

    invoke-virtual {v0}, Landroid/inputmethodservice/InputMethodService;->getCurrentInputConnection()Landroid/view/inputmethod/InputConnection;

    move-result-object v0

    .line 39
    if-eqz v0, :cond_0

    .line 40
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    invoke-interface {v0, p1, v1}, Landroid/view/inputmethod/InputConnection;->commitText(Ljava/lang/CharSequence;I)Z

    .line 42
    :cond_0
    return-void
.end method

.method public b()V
    .locals 1

    .prologue
    .line 31
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/input/a;->b:Landroid/inputmethodservice/InputMethodService;

    .line 32
    return-void
.end method

.method public b(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 46
    iget-object v0, p0, Lcom/cyjh/mobileanjian/input/a;->b:Landroid/inputmethodservice/InputMethodService;

    if-eqz v0, :cond_0

    .line 47
    iget-object v0, p0, Lcom/cyjh/mobileanjian/input/a;->b:Landroid/inputmethodservice/InputMethodService;

    invoke-virtual {v0, p1}, Landroid/inputmethodservice/InputMethodService;->switchInputMethod(Ljava/lang/String;)V

    .line 48
    :cond_0
    return-void
.end method
