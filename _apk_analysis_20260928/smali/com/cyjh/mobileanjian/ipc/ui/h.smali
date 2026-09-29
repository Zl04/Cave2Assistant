.class public Lcom/cyjh/mobileanjian/ipc/ui/h;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/widget/AdapterView$OnItemSelectedListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/mobileanjian/ipc/ui/h$a;
    }
.end annotation


# static fields
.field private static final a:Ljava/lang/String; = "^#*([0-9A-Fa-f]{6})|([0-9A-Fa-f]{3})"

.field private static final b:I = 0x20


# instance fields
.field private c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

.field private d:I

.field private e:Landroid/content/Context;

.field private f:Lcom/cyjh/mobileanjian/ipc/ui/g;

.field private g:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private h:[Ljava/util/HashMap;

.field private i:Landroid/widget/LinearLayout;

.field private j:I


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 2

    .prologue
    const/16 v1, 0x20

    .line 73
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 59
    new-array v0, v1, [Lcom/cyjh/mobileanjian/ipc/ui/i;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    .line 60
    const/4 v0, 0x0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    .line 64
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->g:Ljava/util/HashMap;

    .line 65
    new-array v0, v1, [Ljava/util/HashMap;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    .line 69
    const/4 v0, 0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->j:I

    .line 74
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->e:Landroid/content/Context;

    .line 75
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/ui/g;->a(Landroid/content/Context;)Lcom/cyjh/mobileanjian/ipc/ui/g;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->f:Lcom/cyjh/mobileanjian/ipc/ui/g;

    .line 76
    return-void
.end method

.method private a(I)I
    .locals 3

    .prologue
    .line 85
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->e:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    .line 86
    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    .line 87
    int-to-float v1, p1

    iget v0, v0, Landroid/util/DisplayMetrics;->densityDpi:I

    int-to-float v0, v0

    const/high16 v2, 0x43200000    # 160.0f

    div-float/2addr v0, v2

    mul-float/2addr v0, v1

    .line 88
    float-to-int v0, v0

    return v0
.end method

.method private varargs a(I[Ljava/lang/Object;)V
    .locals 3

    .prologue
    .line 1366
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->e:Landroid/content/Context;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->e:Landroid/content/Context;

    invoke-virtual {v1, p1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, p2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/16 v2, 0xdac

    invoke-static {v0, v1, v2}, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Lcom/cyjh/mobileanjian/ipc/view/ExToast;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->show()V

    .line 1367
    return-void
.end method

.method private a(Ljava/lang/String;II)V
    .locals 3

    .prologue
    .line 1173
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    .line 1174
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->f:Lcom/cyjh/mobileanjian/ipc/ui/g;

    invoke-virtual {v2, p1, p2, p3}, Lcom/cyjh/mobileanjian/ipc/ui/g;->a(Ljava/lang/String;II)Lcom/cyjh/mobileanjian/ipc/ui/i;

    move-result-object v2

    aput-object v2, v0, v1

    .line 1175
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->g:Ljava/util/HashMap;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1177
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    new-instance v2, Ljava/util/HashMap;

    invoke-direct {v2}, Ljava/util/HashMap;-><init>()V

    aput-object v2, v0, v1

    .line 1179
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    new-instance v1, Lcom/cyjh/mobileanjian/ipc/ui/h$1;

    invoke-direct {v1, p0, p1}, Lcom/cyjh/mobileanjian/ipc/ui/h$1;-><init>(Lcom/cyjh/mobileanjian/ipc/ui/h;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(Landroid/view/View$OnClickListener;)V

    .line 1196
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    new-instance v1, Lcom/cyjh/mobileanjian/ipc/ui/h$2;

    invoke-direct {v1, p0, p1}, Lcom/cyjh/mobileanjian/ipc/ui/h$2;-><init>(Lcom/cyjh/mobileanjian/ipc/ui/h;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/i;->a(Landroid/view/View$OnClickListener;)V

    .line 1217
    return-void
.end method

.method private a(Z)V
    .locals 2

    .prologue
    .line 332
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->RSP_MSG:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    .line 333
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setCommand(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    .line 334
    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setIsSuccess(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    .line 335
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    move-result-object v0

    .line 336
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->getInstance()Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v1

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->toByteString()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->sendUiResponse(Lcom/google/protobuf/ByteString;)V

    .line 337
    return-void
.end method

.method private a(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 3

    .prologue
    const/4 v1, 0x1

    const/4 v0, 0x0

    .line 1250
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->g:Ljava/util/HashMap;

    invoke-virtual {v2, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    if-nez v2, :cond_0

    .line 1252
    sget v2, Lcom/cyjh/rootipc/R$string;->ui_show_not_found_ui:I

    new-array v1, v1, [Ljava/lang/Object;

    aput-object p1, v1, v0

    invoke-direct {p0, v2, v1}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(I[Ljava/lang/Object;)V

    .line 1257
    :goto_0
    return v0

    .line 1256
    :cond_0
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->g:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    aget-object v0, v2, v0

    invoke-virtual {v0, p2}, Lcom/cyjh/mobileanjian/ipc/ui/i;->a(Ljava/lang/String;)V

    move v0, v1

    .line 1257
    goto :goto_0
.end method

.method static synthetic a(Lcom/cyjh/mobileanjian/ipc/ui/h;)[Lcom/cyjh/mobileanjian/ipc/ui/i;
    .locals 1

    .prologue
    .line 55
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    return-object v0
.end method

.method private b()I
    .locals 1

    .prologue
    .line 80
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->j:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->j:I

    return v0
.end method

.method static synthetic b(Lcom/cyjh/mobileanjian/ipc/ui/h;)I
    .locals 1

    .prologue
    .line 55
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    return v0
.end method

.method private b(Ljava/lang/String;)V
    .locals 3

    .prologue
    .line 506
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->g:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 510
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    .line 524
    :goto_0
    return-void

    .line 514
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_1

    .line 516
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto :goto_0

    .line 520
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    .line 521
    invoke-virtual {v1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout$LayoutParams;

    .line 522
    const/4 v2, -0x1

    iput v2, v0, Landroid/widget/LinearLayout$LayoutParams;->width:I

    .line 523
    invoke-virtual {v1, v0}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    goto :goto_0
.end method

.method private b(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)Z
    .locals 10

    .prologue
    const/4 v9, 0x5

    const/4 v8, -0x2

    const/4 v5, 0x1

    const/4 v4, 0x0

    .line 341
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    if-nez v0, :cond_1

    .line 500
    :cond_0
    :goto_0
    return v4

    .line 346
    :cond_1
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getControlId()Ljava/lang/String;

    move-result-object v1

    .line 348
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v2

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    if-nez v0, :cond_2

    .line 350
    sget v0, Lcom/cyjh/rootipc/R$string;->ui_show_not_found_widget:I

    new-array v2, v5, [Ljava/lang/Object;

    aput-object v1, v2, v4

    invoke-direct {p0, v0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(I[Ljava/lang/Object;)V

    goto :goto_0

    .line 355
    :cond_2
    sget-object v2, Lcom/cyjh/mobileanjian/ipc/ui/h$3;->a:[I

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getCommand()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;

    move-result-object v3

    invoke-virtual {v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;->ordinal()I

    move-result v3

    aget v2, v2, v3

    packed-switch v2, :pswitch_data_0

    :cond_3
    :goto_1
    move v4, v5

    .line 500
    goto :goto_0

    .line 358
    :pswitch_0
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v2, v2, v3

    invoke-virtual {v2, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/ui/k;->a:Lcom/cyjh/mobileanjian/ipc/ui/k;

    if-ne v1, v2, :cond_0

    .line 361
    check-cast v0, Landroid/widget/TextView;

    .line 362
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getText()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 363
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getWidth()I

    move-result v2

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getHeight()I

    move-result v3

    invoke-direct {v1, v2, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    goto :goto_1

    .line 366
    :pswitch_1
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v2, v2, v3

    invoke-virtual {v2, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/ui/k;->b:Lcom/cyjh/mobileanjian/ipc/ui/k;

    if-ne v1, v2, :cond_0

    .line 369
    check-cast v0, Landroid/widget/EditText;

    .line 370
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getText()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 371
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getWidth()I

    move-result v2

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getHeight()I

    move-result v3

    invoke-direct {v1, v2, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    goto :goto_1

    .line 374
    :pswitch_2
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v2, v2, v3

    invoke-virtual {v2, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/ui/k;->c:Lcom/cyjh/mobileanjian/ipc/ui/k;

    if-ne v1, v2, :cond_0

    .line 377
    check-cast v0, Landroid/widget/Button;

    .line 378
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getText()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 379
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getWidth()I

    move-result v2

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getHeight()I

    move-result v3

    invoke-direct {v1, v2, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    goto :goto_1

    .line 382
    :pswitch_3
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v2, v2, v3

    invoke-virtual {v2, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/ui/k;->d:Lcom/cyjh/mobileanjian/ipc/ui/k;

    if-ne v1, v2, :cond_0

    .line 385
    check-cast v0, Landroid/widget/CheckBox;

    .line 386
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getDefaultCheckStatus()Z

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/CheckBox;->setChecked(Z)V

    .line 387
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getText()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/CheckBox;->setText(Ljava/lang/CharSequence;)V

    .line 388
    invoke-virtual {v0}, Landroid/widget/CheckBox;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getWidth()I

    move-result v2

    iput v2, v1, Landroid/view/ViewGroup$LayoutParams;->width:I

    .line 389
    invoke-virtual {v0}, Landroid/widget/CheckBox;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getHeight()I

    move-result v1

    iput v1, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    goto/16 :goto_1

    .line 392
    :pswitch_4
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v2, v2, v3

    invoke-virtual {v2, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/ui/k;->g:Lcom/cyjh/mobileanjian/ipc/ui/k;

    if-ne v1, v2, :cond_0

    move-object v1, v0

    .line 395
    check-cast v1, Landroid/widget/ImageView;

    .line 396
    invoke-virtual {v0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout$LayoutParams;

    .line 397
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getWidth()I

    move-result v2

    iput v2, v0, Landroid/widget/LinearLayout$LayoutParams;->width:I

    .line 398
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getHeight()I

    move-result v2

    iput v2, v0, Landroid/widget/LinearLayout$LayoutParams;->height:I

    .line 399
    invoke-virtual {v1, v0}, Landroid/widget/ImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 401
    new-instance v0, Ljava/io/File;

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getPath()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Landroid/net/Uri;->fromFile(Ljava/io/File;)Landroid/net/Uri;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/ImageView;->setImageURI(Landroid/net/Uri;)V

    goto/16 :goto_1

    .line 404
    :pswitch_5
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v2, v2, v3

    invoke-virtual {v2, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/ui/k;->h:Lcom/cyjh/mobileanjian/ipc/ui/k;

    if-ne v1, v2, :cond_0

    .line 407
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getUrl()Ljava/lang/String;

    move-result-object v1

    .line 408
    const-string v2, "http://"

    invoke-virtual {v1, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_4

    const-string v2, "https://"

    invoke-virtual {v1, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_4

    .line 410
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "http://"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 413
    :cond_4
    check-cast v0, Landroid/webkit/WebView;

    .line 414
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    .line 415
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getWidth()I

    move-result v2

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getHeight()I

    move-result v3

    invoke-direct {v1, v2, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    goto/16 :goto_1

    .line 418
    :pswitch_6
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v2, v2, v3

    invoke-virtual {v2, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/ui/k;->e:Lcom/cyjh/mobileanjian/ipc/ui/k;

    if-ne v1, v2, :cond_0

    move-object v1, v0

    .line 421
    check-cast v1, Landroid/widget/RadioGroup;

    .line 422
    invoke-virtual {v1}, Landroid/widget/RadioGroup;->clearCheck()V

    .line 424
    invoke-virtual {v0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout$LayoutParams;

    .line 425
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getWidth()I

    move-result v2

    int-to-float v2, v2

    iput v2, v0, Landroid/widget/LinearLayout$LayoutParams;->weight:F

    .line 426
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getHeight()I

    move-result v2

    iput v2, v0, Landroid/widget/LinearLayout$LayoutParams;->height:I

    .line 427
    invoke-virtual {v1, v0}, Landroid/widget/RadioGroup;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 428
    invoke-virtual {v1}, Landroid/widget/RadioGroup;->removeAllViews()V

    .line 430
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getItemTextList()Ljava/util/List;

    move-result-object v6

    move v3, v4

    .line 431
    :goto_2
    invoke-interface {v6}, Ljava/util/List;->size()I

    move-result v0

    if-ge v3, v0, :cond_5

    .line 433
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->e:Landroid/content/Context;

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    sget v2, Lcom/cyjh/rootipc/R$layout;->ui_show_radio_button:I

    const/4 v7, 0x0

    invoke-virtual {v0, v2, v7}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/RadioButton;

    .line 434
    invoke-virtual {v0, v3}, Landroid/widget/RadioButton;->setId(I)V

    .line 435
    invoke-interface {v6, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-virtual {v0, v2}, Landroid/widget/RadioButton;->setText(Ljava/lang/CharSequence;)V

    .line 436
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v2, v8, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v2}, Landroid/widget/RadioButton;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 437
    invoke-direct {p0, v9}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(I)I

    move-result v2

    invoke-direct {p0, v9}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(I)I

    move-result v7

    invoke-virtual {v0, v4, v2, v4, v7}, Landroid/widget/RadioButton;->setPadding(IIII)V

    .line 438
    invoke-virtual {v1, v0}, Landroid/widget/RadioGroup;->addView(Landroid/view/View;)V

    .line 431
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    goto :goto_2

    .line 440
    :cond_5
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getDefaultItemIndex()I

    move-result v0

    invoke-virtual {v1}, Landroid/widget/RadioGroup;->getChildCount()I

    move-result v2

    if-ge v0, v2, :cond_6

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getDefaultItemIndex()I

    move-result v4

    .line 441
    :cond_6
    invoke-virtual {v1, v4}, Landroid/widget/RadioGroup;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/RadioButton;

    invoke-virtual {v0, v5}, Landroid/widget/RadioButton;->setChecked(Z)V

    goto/16 :goto_1

    .line 444
    :pswitch_7
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v2, v2, v3

    invoke-virtual {v2, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/ui/k;->f:Lcom/cyjh/mobileanjian/ipc/ui/k;

    if-ne v1, v2, :cond_0

    .line 447
    check-cast v0, Landroid/widget/Spinner;

    .line 451
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getItemTextList()Ljava/util/List;

    move-result-object v1

    .line 452
    new-instance v2, Landroid/widget/ArrayAdapter;

    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->e:Landroid/content/Context;

    sget v6, Lcom/cyjh/rootipc/R$layout;->ui_show_spinner_dropdown_item:I

    invoke-direct {v2, v3, v6, v1}, Landroid/widget/ArrayAdapter;-><init>(Landroid/content/Context;ILjava/util/List;)V

    .line 453
    invoke-virtual {v0, v2}, Landroid/widget/Spinner;->setAdapter(Landroid/widget/SpinnerAdapter;)V

    .line 454
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getDefaultItemIndex()I

    move-result v1

    invoke-virtual {v2}, Landroid/widget/ArrayAdapter;->getCount()I

    move-result v2

    if-ge v1, v2, :cond_7

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getDefaultItemIndex()I

    move-result v4

    .line 455
    :cond_7
    invoke-virtual {v0, v4}, Landroid/widget/Spinner;->setSelection(I)V

    goto/16 :goto_1

    .line 458
    :pswitch_8
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v2, v2, v3

    invoke-virtual {v2, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/ui/k;->i:Lcom/cyjh/mobileanjian/ipc/ui/k;

    if-ne v1, v2, :cond_0

    .line 460
    check-cast v0, Landroid/widget/LinearLayout;

    .line 461
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getWidth()I

    move-result v2

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getHeight()I

    move-result v3

    invoke-direct {v1, v2, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    goto/16 :goto_1

    .line 464
    :pswitch_9
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v2, v2, v3

    invoke-virtual {v2, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    sget-object v3, Lcom/cyjh/mobileanjian/ipc/ui/k;->e:Lcom/cyjh/mobileanjian/ipc/ui/k;

    if-ne v2, v3, :cond_8

    .line 466
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getEnabledStatus()Z

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->setEnabled(Z)V

    .line 467
    check-cast v0, Landroid/widget/RadioGroup;

    .line 468
    :goto_3
    invoke-virtual {v0}, Landroid/widget/RadioGroup;->getChildCount()I

    move-result v1

    if-ge v4, v1, :cond_3

    .line 470
    invoke-virtual {v0, v4}, Landroid/widget/RadioGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getEnabledStatus()Z

    move-result v2

    invoke-virtual {v1, v2}, Landroid/view/View;->setEnabled(Z)V

    .line 468
    add-int/lit8 v4, v4, 0x1

    goto :goto_3

    .line 472
    :cond_8
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v2, v2, v3

    invoke-virtual {v2, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/ui/k;->b:Lcom/cyjh/mobileanjian/ipc/ui/k;

    if-ne v1, v2, :cond_9

    .line 474
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "set edittext enabled. "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getEnabledStatus()Z

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    move-object v1, v0

    .line 475
    check-cast v1, Landroid/widget/EditText;

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getEnabledStatus()Z

    move-result v2

    invoke-virtual {v1, v2}, Landroid/widget/EditText;->setFocusable(Z)V

    .line 476
    check-cast v0, Landroid/widget/EditText;

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getEnabledStatus()Z

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setFocusableInTouchMode(Z)V

    goto/16 :goto_1

    .line 479
    :cond_9
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getEnabledStatus()Z

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->setEnabled(Z)V

    goto/16 :goto_1

    .line 484
    :pswitch_a
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getVisibleStatus()I

    move-result v1

    .line 485
    packed-switch v1, :pswitch_data_1

    .line 495
    invoke-virtual {v0, v4}, Landroid/view/View;->setVisibility(I)V

    goto/16 :goto_1

    .line 488
    :pswitch_b
    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    goto/16 :goto_1

    .line 491
    :pswitch_c
    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    goto/16 :goto_1

    .line 355
    nop

    :pswitch_data_0
    .packed-switch 0x17
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
        :pswitch_6
        :pswitch_7
        :pswitch_9
        :pswitch_8
        :pswitch_a
    .end packed-switch

    .line 485
    :pswitch_data_1
    .packed-switch 0x2
        :pswitch_b
        :pswitch_c
    .end packed-switch
.end method

.method private c()V
    .locals 3

    .prologue
    .line 1354
    const/16 v0, 0x1f

    :goto_0
    if-lez v0, :cond_1

    .line 1356
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    aget-object v1, v1, v0

    .line 1357
    if-eqz v1, :cond_0

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/ui/i;->e()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 1359
    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/ui/i;->f()V

    .line 1354
    :cond_0
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    .line 1362
    :cond_1
    return-void
.end method

.method private c(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)V
    .locals 10

    .prologue
    const/4 v9, 0x1

    const/4 v8, 0x2

    const/4 v3, 0x0

    .line 528
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    if-nez v0, :cond_0

    .line 530
    invoke-direct {p0, v3}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    .line 593
    :goto_0
    return-void

    .line 534
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "SET FONT type: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getFontType()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 535
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getControlId()Ljava/lang/String;

    move-result-object v4

    .line 536
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getFontType()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, v3}, Landroid/graphics/Typeface;->create(Ljava/lang/String;I)Landroid/graphics/Typeface;

    move-result-object v5

    .line 537
    if-nez v5, :cond_1

    .line 539
    invoke-direct {p0, v3}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto :goto_0

    .line 542
    :cond_1
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getFontSize()I

    move-result v0

    if-gez v0, :cond_2

    const/16 v0, 0xe

    move v2, v0

    .line 544
    :goto_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->g:Ljava/util/HashMap;

    invoke-virtual {v0, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_3

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->g:Ljava/util/HashMap;

    invoke-virtual {v0, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    aget-object v0, v1, v0

    if-eqz v0, :cond_3

    .line 546
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->g:Ljava/util/HashMap;

    invoke-virtual {v0, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    aget-object v0, v1, v0

    invoke-virtual {v0, v5, v2}, Lcom/cyjh/mobileanjian/ipc/ui/i;->a(Landroid/graphics/Typeface;I)V

    .line 547
    invoke-direct {p0, v9}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto :goto_0

    .line 542
    :cond_2
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getFontSize()I

    move-result v0

    move v2, v0

    goto :goto_1

    .line 551
    :cond_3
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    invoke-virtual {v0, v4}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    .line 552
    if-nez v1, :cond_4

    .line 554
    invoke-direct {p0, v3}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto :goto_0

    .line 558
    :cond_4
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v6, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v6

    invoke-virtual {v0, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_5

    .line 560
    invoke-direct {p0, v3}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto/16 :goto_0

    .line 564
    :cond_5
    sget-object v6, Lcom/cyjh/mobileanjian/ipc/ui/h$3;->b:[I

    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v7, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v7

    invoke-virtual {v0, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/ui/k;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/ui/k;->ordinal()I

    move-result v0

    aget v0, v6, v0

    packed-switch v0, :pswitch_data_0

    .line 589
    invoke-direct {p0, v3}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto/16 :goto_0

    :pswitch_0
    move-object v0, v1

    .line 569
    check-cast v0, Landroid/widget/TextView;

    .line 570
    invoke-virtual {v0, v5}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 571
    int-to-float v1, v2

    invoke-virtual {v0, v8, v1}, Landroid/widget/TextView;->setTextSize(IF)V

    .line 592
    :cond_6
    :goto_2
    invoke-direct {p0, v9}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto/16 :goto_0

    .line 574
    :pswitch_1
    check-cast v1, Landroid/widget/CheckBox;

    .line 575
    invoke-virtual {v1, v5}, Landroid/widget/CheckBox;->setTypeface(Landroid/graphics/Typeface;)V

    .line 576
    int-to-float v0, v2

    invoke-virtual {v1, v8, v0}, Landroid/widget/CheckBox;->setTextSize(IF)V

    goto :goto_2

    .line 579
    :pswitch_2
    check-cast v1, Landroid/widget/RadioGroup;

    .line 580
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getItemIndex()I

    move-result v0

    invoke-virtual {v1, v0}, Landroid/widget/RadioGroup;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/RadioButton;

    .line 581
    :goto_3
    invoke-virtual {v1}, Landroid/widget/RadioGroup;->getChildCount()I

    move-result v0

    if-ge v3, v0, :cond_6

    .line 583
    invoke-virtual {v1, v3}, Landroid/widget/RadioGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/RadioButton;

    .line 584
    invoke-virtual {v0, v5}, Landroid/widget/RadioButton;->setTypeface(Landroid/graphics/Typeface;)V

    .line 585
    int-to-float v4, v2

    invoke-virtual {v0, v8, v4}, Landroid/widget/RadioButton;->setTextSize(IF)V

    .line 581
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    goto :goto_3

    .line 564
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method

.method private c(Ljava/lang/String;)V
    .locals 4

    .prologue
    const/4 v2, 0x0

    .line 875
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    if-nez v0, :cond_0

    .line 877
    invoke-direct {p0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    .line 900
    :goto_0
    return-void

    .line 881
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    .line 882
    if-nez v0, :cond_1

    .line 884
    invoke-direct {p0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto :goto_0

    .line 887
    :cond_1
    invoke-virtual {v0}, Landroid/view/View;->isEnabled()Z

    move-result v1

    .line 888
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v2, v2, v3

    invoke-virtual {v2, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    sget-object v3, Lcom/cyjh/mobileanjian/ipc/ui/k;->b:Lcom/cyjh/mobileanjian/ipc/ui/k;

    if-ne v2, v3, :cond_2

    .line 890
    check-cast v0, Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->isFocusable()Z

    move-result v0

    .line 892
    :goto_1
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v1

    .line 893
    invoke-virtual {v1, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->setControlId(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->BOOL:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    .line 894
    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->setType(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v1

    .line 895
    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->setBoolValue(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v0

    .line 896
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->RSP_MSG:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    .line 897
    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setCommand(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v1

    const/4 v2, 0x1

    .line 898
    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setIsSuccess(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->addVarTable(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    move-result-object v0

    .line 899
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->getInstance()Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v1

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->toByteString()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->sendUiResponse(Lcom/google/protobuf/ByteString;)V

    goto :goto_0

    :cond_2
    move v0, v1

    goto :goto_1
.end method

.method private d(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 597
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    if-nez v0, :cond_0

    .line 599
    invoke-direct {p0, v4}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    .line 622
    :goto_0
    return-void

    .line 603
    :cond_0
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getControlId()Ljava/lang/String;

    move-result-object v1

    .line 604
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getText()Ljava/lang/String;

    .line 606
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v2

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    .line 607
    if-nez v0, :cond_1

    .line 609
    invoke-direct {p0, v4}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto :goto_0

    .line 613
    :cond_1
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v2, v2, v3

    invoke-virtual {v2, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/ui/k;->b:Lcom/cyjh/mobileanjian/ipc/ui/k;

    if-eq v1, v2, :cond_2

    .line 615
    invoke-direct {p0, v4}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto :goto_0

    .line 619
    :cond_2
    check-cast v0, Landroid/widget/EditText;

    .line 620
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getEditInputType()I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setInputType(I)V

    .line 621
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto :goto_0
.end method

.method private d(Ljava/lang/String;)V
    .locals 4

    .prologue
    const/4 v3, 0x0

    const/4 v1, 0x1

    .line 904
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v2

    if-nez v0, :cond_0

    .line 906
    invoke-direct {p0, v3}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    .line 937
    :goto_0
    return-void

    .line 910
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v2

    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    .line 911
    if-nez v0, :cond_1

    .line 913
    invoke-direct {p0, v3}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto :goto_0

    .line 917
    :cond_1
    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v0

    sparse-switch v0, :sswitch_data_0

    move v0, v1

    .line 929
    :goto_1
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v2

    .line 930
    invoke-virtual {v2, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->setControlId(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v2

    sget-object v3, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->INT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    .line 931
    invoke-virtual {v2, v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->setType(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v2

    .line 932
    invoke-virtual {v2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->setIntValue(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v0

    .line 933
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v2

    sget-object v3, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->RSP_MSG:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    .line 934
    invoke-virtual {v2, v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setCommand(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v2

    .line 935
    invoke-virtual {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setIsSuccess(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->addVarTable(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    move-result-object v0

    .line 936
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->getInstance()Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v1

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->toByteString()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->sendUiResponse(Lcom/google/protobuf/ByteString;)V

    goto :goto_0

    :sswitch_0
    move v0, v1

    .line 921
    goto :goto_1

    .line 923
    :sswitch_1
    const/4 v0, 0x2

    .line 924
    goto :goto_1

    .line 926
    :sswitch_2
    const/4 v0, 0x3

    goto :goto_1

    .line 917
    :sswitch_data_0
    .sparse-switch
        0x0 -> :sswitch_0
        0x4 -> :sswitch_1
        0x8 -> :sswitch_2
    .end sparse-switch
.end method

.method private e(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)V
    .locals 7

    .prologue
    const/4 v2, 0x0

    .line 626
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    if-nez v0, :cond_0

    .line 628
    invoke-direct {p0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    .line 699
    :goto_0
    return-void

    .line 632
    :cond_0
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getControlId()Ljava/lang/String;

    move-result-object v0

    .line 633
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getText()Ljava/lang/String;

    move-result-object v3

    .line 635
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v4, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v1, v1, v4

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    .line 636
    if-nez v1, :cond_1

    .line 638
    invoke-direct {p0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto :goto_0

    .line 642
    :cond_1
    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v5, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v4, v4, v5

    invoke-virtual {v4, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    if-nez v4, :cond_2

    .line 644
    invoke-direct {p0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto :goto_0

    .line 648
    :cond_2
    sget-object v4, Lcom/cyjh/mobileanjian/ipc/ui/h$3;->b:[I

    iget-object v5, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v6, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v5, v5, v6

    invoke-virtual {v5, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/ui/k;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/ui/k;->ordinal()I

    move-result v0

    aget v0, v4, v0

    packed-switch v0, :pswitch_data_0

    .line 694
    invoke-direct {p0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto :goto_0

    :pswitch_0
    move-object v0, v1

    .line 653
    check-cast v0, Landroid/widget/TextView;

    .line 654
    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 698
    :goto_1
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto :goto_0

    .line 657
    :pswitch_1
    check-cast v1, Landroid/widget/CheckBox;

    .line 658
    invoke-virtual {v1, v3}, Landroid/widget/CheckBox;->setText(Ljava/lang/CharSequence;)V

    goto :goto_1

    .line 661
    :pswitch_2
    check-cast v1, Landroid/widget/RadioGroup;

    .line 662
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getItemIndex()I

    move-result v0

    invoke-virtual {v1, v0}, Landroid/widget/RadioGroup;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/RadioButton;

    .line 663
    if-nez v0, :cond_3

    .line 665
    invoke-direct {p0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto :goto_0

    .line 668
    :cond_3
    invoke-virtual {v0, v3}, Landroid/widget/RadioButton;->setText(Ljava/lang/CharSequence;)V

    goto :goto_1

    .line 671
    :pswitch_3
    check-cast v1, Landroid/widget/Spinner;

    .line 672
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getItemIndex()I

    move-result v0

    invoke-virtual {v1}, Landroid/widget/Spinner;->getCount()I

    move-result v4

    if-lt v0, v4, :cond_4

    .line 674
    invoke-direct {p0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto :goto_0

    .line 678
    :cond_4
    invoke-virtual {v1}, Landroid/widget/Spinner;->getAdapter()Landroid/widget/SpinnerAdapter;

    move-result-object v0

    check-cast v0, Landroid/widget/ArrayAdapter;

    .line 680
    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    .line 681
    :goto_2
    invoke-virtual {v0}, Landroid/widget/ArrayAdapter;->getCount()I

    move-result v5

    if-ge v2, v5, :cond_5

    .line 683
    invoke-virtual {v0, v2}, Landroid/widget/ArrayAdapter;->getItem(I)Ljava/lang/Object;

    move-result-object v5

    invoke-interface {v4, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 681
    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    .line 685
    :cond_5
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getItemIndex()I

    move-result v0

    invoke-interface {v4, v0, v3}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 687
    new-instance v0, Landroid/widget/ArrayAdapter;

    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->e:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$layout;->ui_show_spinner_dropdown_item:I

    invoke-direct {v0, v2, v3, v4}, Landroid/widget/ArrayAdapter;-><init>(Landroid/content/Context;ILjava/util/List;)V

    .line 688
    invoke-virtual {v1, v0}, Landroid/widget/Spinner;->setAdapter(Landroid/widget/SpinnerAdapter;)V

    .line 689
    invoke-virtual {v0}, Landroid/widget/ArrayAdapter;->notifyDataSetChanged()V

    goto :goto_1

    .line 648
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method

.method private e(Ljava/lang/String;)V
    .locals 4

    .prologue
    const/4 v2, 0x0

    .line 1000
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    if-nez v0, :cond_0

    .line 1002
    invoke-direct {p0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    .line 1026
    :goto_0
    return-void

    .line 1006
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    .line 1007
    if-nez v0, :cond_1

    .line 1009
    invoke-direct {p0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto :goto_0

    .line 1012
    :cond_1
    invoke-virtual {v0}, Landroid/view/View;->getSolidColor()I

    move-result v0

    .line 1013
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/b;->a(I)I

    move-result v0

    .line 1014
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "#"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const v2, 0xffffff

    and-int/2addr v2, v0

    invoke-static {v2}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 1015
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "colorValue = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 1016
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "color String: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 1018
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    .line 1019
    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->setControlId(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->STRING:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    .line 1020
    invoke-virtual {v0, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->setType(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    .line 1021
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->setStringValue(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v0

    .line 1022
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->RSP_MSG:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    .line 1023
    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setCommand(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v1

    const/4 v2, 0x1

    .line 1024
    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setIsSuccess(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->addVarTable(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    move-result-object v0

    .line 1025
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->getInstance()Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v1

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->toByteString()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->sendUiResponse(Lcom/google/protobuf/ByteString;)V

    goto/16 :goto_0
.end method

.method private f(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)V
    .locals 8

    .prologue
    const/4 v7, 0x1

    const/4 v6, 0x0

    .line 703
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    if-nez v0, :cond_0

    .line 705
    invoke-direct {p0, v6}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    .line 777
    :goto_0
    return-void

    .line 709
    :cond_0
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getControlId()Ljava/lang/String;

    move-result-object v2

    .line 710
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getColor()Ljava/lang/String;

    move-result-object v0

    .line 712
    const-string v1, "^#*([0-9A-Fa-f]{6})|([0-9A-Fa-f]{3})"

    invoke-virtual {v0, v1}, Ljava/lang/String;->matches(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 714
    sget v0, Lcom/cyjh/rootipc/R$string;->ui_show_invalid_color_value:I

    new-array v1, v6, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(I[Ljava/lang/Object;)V

    .line 715
    invoke-direct {p0, v6}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto :goto_0

    .line 719
    :cond_1
    const-string v1, "#"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_2

    .line 720
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "#"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 721
    :cond_2
    invoke-static {v0}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v0

    .line 722
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/b;->a(I)I

    move-result v3

    .line 725
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->g:Ljava/util/HashMap;

    invoke-virtual {v0, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_3

    .line 727
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->g:Ljava/util/HashMap;

    invoke-virtual {v0, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    aget-object v0, v1, v0

    invoke-virtual {v0, v3}, Lcom/cyjh/mobileanjian/ipc/ui/i;->a(I)V

    .line 728
    invoke-direct {p0, v7}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto :goto_0

    .line 732
    :cond_3
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    invoke-virtual {v0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    .line 733
    if-nez v1, :cond_4

    .line 735
    invoke-direct {p0, v6}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto :goto_0

    .line 739
    :cond_4
    sget-object v4, Lcom/cyjh/mobileanjian/ipc/ui/h$3;->b:[I

    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v5, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v5

    invoke-virtual {v0, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/ui/k;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/ui/k;->ordinal()I

    move-result v0

    aget v0, v4, v0

    packed-switch v0, :pswitch_data_0

    .line 772
    invoke-direct {p0, v6}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto/16 :goto_0

    :pswitch_0
    move-object v0, v1

    .line 744
    check-cast v0, Landroid/widget/TextView;

    .line 745
    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setTextColor(I)V

    .line 776
    :cond_5
    :goto_1
    invoke-direct {p0, v7}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto/16 :goto_0

    .line 748
    :pswitch_1
    check-cast v1, Landroid/widget/CheckBox;

    .line 749
    invoke-virtual {v1, v3}, Landroid/widget/CheckBox;->setTextColor(I)V

    goto :goto_1

    .line 752
    :pswitch_2
    check-cast v1, Landroid/widget/RadioGroup;

    .line 753
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getItemIndex()I

    move-result v0

    invoke-virtual {v1, v0}, Landroid/widget/RadioGroup;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/RadioButton;

    .line 754
    if-nez v0, :cond_6

    .line 756
    invoke-direct {p0, v6}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto/16 :goto_0

    .line 759
    :cond_6
    invoke-virtual {v0, v3}, Landroid/widget/RadioButton;->setTextColor(I)V

    goto :goto_1

    .line 762
    :pswitch_3
    check-cast v1, Landroid/widget/Spinner;

    .line 763
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getItemIndex()I

    move-result v0

    invoke-virtual {v1}, Landroid/widget/Spinner;->getCount()I

    move-result v1

    if-lt v0, v1, :cond_5

    .line 765
    invoke-direct {p0, v6}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto/16 :goto_0

    .line 739
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method

.method private f(Ljava/lang/String;)V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;,
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 1096
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    if-nez v0, :cond_0

    .line 1125
    :goto_0
    return-void

    .line 1099
    :cond_0
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 1100
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    invoke-virtual {v0}, Ljava/util/HashMap;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 1102
    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 1103
    sget-object v4, Lcom/cyjh/mobileanjian/ipc/ui/h$3;->b:[I

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/ui/k;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/ui/k;->ordinal()I

    move-result v0

    aget v0, v4, v0

    packed-switch v0, :pswitch_data_0

    :pswitch_0
    goto :goto_1

    .line 1106
    :pswitch_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v4, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v4

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    .line 1107
    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v1, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_1

    .line 1110
    :pswitch_2
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v4, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v4

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Spinner;

    .line 1111
    invoke-virtual {v0}, Landroid/widget/Spinner;->getSelectedItemId()J

    move-result-wide v4

    invoke-virtual {v2, v1, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    goto :goto_1

    .line 1114
    :pswitch_3
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v4, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v4

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/RadioGroup;

    .line 1115
    invoke-virtual {v0}, Landroid/widget/RadioGroup;->getCheckedRadioButtonId()I

    move-result v0

    invoke-virtual {v2, v1, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    goto :goto_1

    .line 1118
    :pswitch_4
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v4, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v4

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/CheckBox;

    .line 1119
    invoke-virtual {v0}, Landroid/widget/CheckBox;->isChecked()Z

    move-result v0

    invoke-virtual {v2, v1, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    goto :goto_1

    .line 1124
    :cond_1
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lorg/apache/commons/io/FileUtils;->writeStringToFile(Ljava/io/File;Ljava/lang/String;)V

    goto/16 :goto_0

    .line 1103
    :pswitch_data_0
    .packed-switch 0x2
        :pswitch_1
        :pswitch_0
        :pswitch_4
        :pswitch_3
        :pswitch_2
    .end packed-switch
.end method

.method private g(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)V
    .locals 6

    .prologue
    const/4 v5, 0x1

    const/4 v4, 0x0

    .line 781
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    if-nez v0, :cond_0

    .line 783
    invoke-direct {p0, v4}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    .line 822
    :goto_0
    return-void

    .line 787
    :cond_0
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getControlId()Ljava/lang/String;

    move-result-object v1

    .line 788
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v2

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v2

    .line 789
    if-nez v2, :cond_1

    .line 791
    invoke-direct {p0, v4}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto :goto_0

    .line 795
    :cond_1
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getColor()Ljava/lang/String;

    move-result-object v0

    .line 796
    const-string v3, "^#*([0-9A-Fa-f]{6})|([0-9A-Fa-f]{3})"

    invoke-virtual {v0, v3}, Ljava/lang/String;->matches(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_2

    .line 798
    sget v0, Lcom/cyjh/rootipc/R$string;->ui_show_invalid_color_value:I

    new-array v1, v4, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(I[Ljava/lang/Object;)V

    .line 799
    invoke-direct {p0, v4}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto :goto_0

    .line 803
    :cond_2
    const-string v3, "#"

    invoke-virtual {v0, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_3

    .line 804
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "#"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 805
    :cond_3
    invoke-static {v0}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v0

    .line 806
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/b;->a(I)I

    move-result v0

    .line 807
    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v4, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v3, v3, v4

    invoke-virtual {v3, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    sget-object v4, Lcom/cyjh/mobileanjian/ipc/ui/k;->c:Lcom/cyjh/mobileanjian/ipc/ui/k;

    if-ne v3, v4, :cond_4

    .line 809
    new-instance v1, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v1}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    .line 810
    invoke-virtual {v1, v0}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    .line 811
    const/4 v0, 0x5

    invoke-direct {p0, v0}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(I)I

    move-result v0

    int-to-float v0, v0

    .line 812
    invoke-virtual {v1, v0}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    .line 813
    invoke-virtual {v2, v1}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 814
    invoke-direct {p0, v5}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto :goto_0

    .line 817
    :cond_4
    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v4, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v3, v3, v4

    invoke-virtual {v3, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    sget-object v3, Lcom/cyjh/mobileanjian/ipc/ui/k;->f:Lcom/cyjh/mobileanjian/ipc/ui/k;

    if-eq v1, v3, :cond_5

    .line 819
    invoke-virtual {v2, v0}, Landroid/view/View;->setBackgroundColor(I)V

    .line 821
    :cond_5
    invoke-direct {p0, v5}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto/16 :goto_0
.end method

.method private g(Ljava/lang/String;)V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/json/JSONException;
        }
    .end annotation

    .prologue
    .line 1129
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    if-nez v0, :cond_1

    .line 1169
    :cond_0
    return-void

    .line 1132
    :cond_1
    new-instance v2, Lorg/json/JSONObject;

    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Lorg/apache/commons/io/FileUtils;->readFileToString(Ljava/io/File;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v2, v0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 1134
    invoke-virtual {v2}, Lorg/json/JSONObject;->keys()Ljava/util/Iterator;

    move-result-object v3

    .line 1135
    :cond_2
    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1137
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 1138
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v4, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v1, v1, v4

    invoke-virtual {v1, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 1140
    sget-object v4, Lcom/cyjh/mobileanjian/ipc/ui/h$3;->b:[I

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v5, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v1, v1, v5

    invoke-virtual {v1, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/cyjh/mobileanjian/ipc/ui/k;

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/ui/k;->ordinal()I

    move-result v1

    aget v1, v4, v1

    packed-switch v1, :pswitch_data_0

    :pswitch_0
    goto :goto_0

    .line 1143
    :pswitch_1
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v4, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v1, v1, v4

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/EditText;

    .line 1144
    invoke-virtual {v2, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 1147
    :pswitch_2
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v4, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v1, v1, v4

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/Spinner;

    .line 1148
    invoke-virtual {v2, v0}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v4

    invoke-virtual {v1}, Landroid/widget/Spinner;->getCount()I

    move-result v5

    if-ge v4, v5, :cond_2

    .line 1152
    invoke-virtual {v2, v0}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {v1, v0}, Landroid/widget/Spinner;->setSelection(I)V

    goto :goto_0

    .line 1155
    :pswitch_3
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v4, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v1, v1, v4

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/RadioGroup;

    .line 1156
    invoke-virtual {v2, v0}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v4

    invoke-virtual {v1}, Landroid/widget/RadioGroup;->getChildCount()I

    move-result v5

    if-ge v4, v5, :cond_2

    .line 1160
    invoke-virtual {v2, v0}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {v1, v0}, Landroid/widget/RadioGroup;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/RadioButton;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/RadioButton;->setChecked(Z)V

    goto/16 :goto_0

    .line 1163
    :pswitch_4
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v4, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v1, v1, v4

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/CheckBox;

    .line 1164
    invoke-virtual {v2, v0}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    invoke-virtual {v1, v0}, Landroid/widget/CheckBox;->setChecked(Z)V

    goto/16 :goto_0

    .line 1140
    :pswitch_data_0
    .packed-switch 0x2
        :pswitch_1
        :pswitch_0
        :pswitch_4
        :pswitch_3
        :pswitch_2
    .end packed-switch
.end method

.method private h(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 826
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    if-nez v0, :cond_0

    .line 828
    invoke-direct {p0, v3}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    .line 846
    :goto_0
    return-void

    .line 832
    :cond_0
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getControlId()Ljava/lang/String;

    move-result-object v0

    .line 833
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v1, v1, v2

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    .line 834
    if-nez v1, :cond_1

    .line 836
    invoke-direct {p0, v3}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto :goto_0

    .line 840
    :cond_1
    invoke-virtual {v1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout$LayoutParams;

    .line 841
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getAlignType()I

    move-result v2

    iput v2, v0, Landroid/widget/LinearLayout$LayoutParams;->gravity:I

    .line 842
    invoke-virtual {v1, v0}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 844
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "set gravity ok; "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 845
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto :goto_0
.end method

.method private h(Ljava/lang/String;)V
    .locals 4

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 1221
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->g:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_0

    .line 1223
    sget v0, Lcom/cyjh/rootipc/R$string;->ui_show_not_found_ui:I

    new-array v1, v3, [Ljava/lang/Object;

    aput-object p1, v1, v2

    invoke-direct {p0, v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(I[Ljava/lang/Object;)V

    .line 1224
    invoke-direct {p0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    .line 1246
    :goto_0
    return-void

    .line 1228
    :cond_0
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->g:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    aget-object v0, v1, v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/ui/i;->e()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1230
    invoke-direct {p0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto :goto_0

    .line 1234
    :cond_1
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->g:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    aget-object v0, v1, v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/ui/i;->d()V

    .line 1235
    invoke-direct {p0, v3}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    .line 1236
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    .line 1237
    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->setControlId(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->ON_SHOW:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    .line 1238
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->setType(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    .line 1239
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v0

    .line 1240
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->EVENT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    .line 1241
    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setCommand(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v1

    .line 1242
    invoke-virtual {v1, v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setIsSuccess(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v1

    .line 1243
    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setEvent(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    .line 1244
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    move-result-object v0

    .line 1245
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->getInstance()Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v1

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->toByteString()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->notifyUiEvent(Lcom/google/protobuf/ByteString;)V

    goto :goto_0
.end method

.method private i(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)V
    .locals 5

    .prologue
    const/4 v3, 0x0

    .line 850
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    if-nez v0, :cond_0

    .line 852
    invoke-direct {p0, v3}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    .line 871
    :goto_0
    return-void

    .line 856
    :cond_0
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getControlId()Ljava/lang/String;

    move-result-object v0

    .line 857
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v1, v1, v2

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    .line 858
    if-nez v0, :cond_1

    .line 860
    invoke-direct {p0, v3}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto :goto_0

    .line 864
    :cond_1
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getPadding()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    move-result-object v1

    .line 865
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "padding: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->getLeft()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 866
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "padding: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->getTop()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 867
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "padding: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->getRight()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 868
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "padding: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->getBottom()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 869
    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->getLeft()I

    move-result v2

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->getTop()I

    move-result v3

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->getRight()I

    move-result v4

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->getBottom()I

    move-result v1

    invoke-virtual {v0, v2, v3, v4, v1}, Landroid/view/View;->setPadding(IIII)V

    .line 870
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto/16 :goto_0
.end method

.method private i(Ljava/lang/String;)V
    .locals 4

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 1262
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->g:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_0

    .line 1264
    sget v0, Lcom/cyjh/rootipc/R$string;->ui_show_not_found_ui:I

    new-array v1, v3, [Ljava/lang/Object;

    aput-object p1, v1, v2

    invoke-direct {p0, v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(I[Ljava/lang/Object;)V

    .line 1265
    invoke-direct {p0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    .line 1278
    :goto_0
    return-void

    .line 1269
    :cond_0
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->g:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    aget-object v0, v1, v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/ui/i;->a()Ljava/lang/String;

    move-result-object v0

    .line 1270
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v1

    .line 1271
    invoke-virtual {v1, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->setControlId(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->STRING:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    .line 1272
    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->setType(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v1

    .line 1273
    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->setStringValue(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v0

    .line 1274
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->RSP_MSG:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    .line 1275
    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setCommand(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v1

    .line 1276
    invoke-virtual {v1, v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setIsSuccess(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->addVarTable(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    move-result-object v0

    .line 1277
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->getInstance()Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v1

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->toByteString()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->sendUiResponse(Lcom/google/protobuf/ByteString;)V

    goto :goto_0
.end method

.method private j(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)V
    .locals 7

    .prologue
    const/4 v6, 0x1

    const/4 v5, 0x0

    .line 941
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    if-nez v0, :cond_0

    .line 943
    invoke-direct {p0, v5}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    .line 996
    :goto_0
    return-void

    .line 947
    :cond_0
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getControlId()Ljava/lang/String;

    move-result-object v1

    .line 950
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v2

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_1

    .line 952
    invoke-direct {p0, v5}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto :goto_0

    .line 956
    :cond_1
    sget-object v2, Lcom/cyjh/mobileanjian/ipc/ui/h$3;->b:[I

    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v3

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/ui/k;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/ui/k;->ordinal()I

    move-result v0

    aget v0, v2, v0

    packed-switch v0, :pswitch_data_0

    .line 980
    invoke-direct {p0, v5}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto :goto_0

    .line 961
    :pswitch_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v2

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 962
    invoke-virtual {v0}, Landroid/widget/TextView;->getPaint()Landroid/text/TextPaint;

    move-result-object v0

    invoke-virtual {v0}, Landroid/text/TextPaint;->getColor()I

    move-result v0

    .line 986
    :goto_1
    const-string v2, "%02X%02X%02X"

    const/4 v3, 0x3

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {v0}, Landroid/graphics/Color;->blue(I)I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v5

    invoke-static {v0}, Landroid/graphics/Color;->green(I)I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v6

    const/4 v4, 0x2

    invoke-static {v0}, Landroid/graphics/Color;->red(I)I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    aput-object v0, v3, v4

    invoke-static {v2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 988
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v2

    .line 989
    invoke-virtual {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->setControlId(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->STRING:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    .line 990
    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->setType(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v1

    .line 991
    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->setStringValue(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v0

    .line 992
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->RSP_MSG:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    .line 993
    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setCommand(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v1

    .line 994
    invoke-virtual {v1, v6}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setIsSuccess(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->addVarTable(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    move-result-object v0

    .line 995
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->getInstance()Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v1

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->toByteString()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->sendUiResponse(Lcom/google/protobuf/ByteString;)V

    goto/16 :goto_0

    .line 965
    :pswitch_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v2

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/CheckBox;

    .line 966
    invoke-virtual {v0}, Landroid/widget/CheckBox;->getPaint()Landroid/text/TextPaint;

    move-result-object v0

    invoke-virtual {v0}, Landroid/text/TextPaint;->getColor()I

    move-result v0

    goto :goto_1

    .line 969
    :pswitch_2
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v2

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/RadioGroup;

    .line 970
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getItemIndex()I

    move-result v2

    invoke-virtual {v0, v2}, Landroid/widget/RadioGroup;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/RadioButton;

    .line 971
    if-nez v0, :cond_2

    .line 973
    invoke-direct {p0, v5}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto/16 :goto_0

    .line 976
    :cond_2
    invoke-virtual {v0}, Landroid/widget/RadioButton;->getPaint()Landroid/text/TextPaint;

    move-result-object v0

    invoke-virtual {v0}, Landroid/text/TextPaint;->getColor()I

    move-result v0

    goto/16 :goto_1

    .line 956
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method

.method private j(Ljava/lang/String;)V
    .locals 3

    .prologue
    .line 1310
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    .line 1311
    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->setControlId(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->ON_CLOSE_CONTINUE:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    .line 1312
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->setType(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    .line 1313
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v0

    .line 1314
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->EVENT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    .line 1315
    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setCommand(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v1

    const/4 v2, 0x1

    .line 1316
    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setIsSuccess(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v1

    .line 1317
    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setEvent(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    .line 1318
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    move-result-object v0

    .line 1319
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->getInstance()Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v1

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->toByteString()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->notifyUiEvent(Lcom/google/protobuf/ByteString;)V

    .line 1320
    return-void
.end method

.method private k(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 1030
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    if-nez v0, :cond_0

    .line 1032
    invoke-direct {p0, v4}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    .line 1092
    :goto_0
    return-void

    .line 1036
    :cond_0
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getControlId()Ljava/lang/String;

    move-result-object v1

    .line 1037
    const-string v0, ""

    .line 1039
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v2

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_1

    .line 1041
    invoke-direct {p0, v4}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto :goto_0

    .line 1045
    :cond_1
    sget-object v2, Lcom/cyjh/mobileanjian/ipc/ui/h$3;->b:[I

    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v3

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/ui/k;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/ui/k;->ordinal()I

    move-result v0

    aget v0, v2, v0

    packed-switch v0, :pswitch_data_0

    .line 1079
    invoke-direct {p0, v4}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto :goto_0

    .line 1050
    :pswitch_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v2

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 1051
    invoke-virtual {v0}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1083
    :goto_1
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v2

    .line 1084
    invoke-virtual {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->setControlId(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->STRING:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    .line 1085
    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->setType(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v1

    .line 1086
    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->setStringValue(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v0

    .line 1087
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->RSP_MSG:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    .line 1088
    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setCommand(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v1

    const/4 v2, 0x1

    .line 1089
    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setIsSuccess(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->addVarTable(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    move-result-object v0

    .line 1090
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->getInstance()Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v1

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->toByteString()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->sendUiResponse(Lcom/google/protobuf/ByteString;)V

    goto :goto_0

    .line 1054
    :pswitch_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v2

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/CheckBox;

    .line 1055
    invoke-virtual {v0}, Landroid/widget/CheckBox;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    .line 1058
    :pswitch_2
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v2

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/RadioGroup;

    .line 1059
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getItemIndex()I

    move-result v2

    invoke-virtual {v0, v2}, Landroid/widget/RadioGroup;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/RadioButton;

    .line 1060
    if-nez v0, :cond_2

    .line 1062
    invoke-direct {p0, v4}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto/16 :goto_0

    .line 1065
    :cond_2
    invoke-virtual {v0}, Landroid/widget/RadioButton;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    .line 1068
    :pswitch_3
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v2

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Spinner;

    .line 1069
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getItemIndex()I

    move-result v2

    invoke-virtual {v0}, Landroid/widget/Spinner;->getCount()I

    move-result v3

    if-lt v2, v3, :cond_3

    .line 1071
    invoke-direct {p0, v4}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto/16 :goto_0

    .line 1074
    :cond_3
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Spinner Get pos: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getItemIndex()I

    move-result v3

    invoke-virtual {v0, v3}, Landroid/widget/Spinner;->getItemAtPosition(I)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 1075
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getItemIndex()I

    move-result v2

    invoke-virtual {v0, v2}, Landroid/widget/Spinner;->getItemAtPosition(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    goto/16 :goto_1

    .line 1045
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method

.method private k(Ljava/lang/String;)Z
    .locals 4

    .prologue
    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 1324
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->g:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_0

    .line 1326
    sget v0, Lcom/cyjh/rootipc/R$string;->ui_show_not_found_ui:I

    new-array v2, v2, [Ljava/lang/Object;

    aput-object p1, v2, v1

    invoke-direct {p0, v0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(I[Ljava/lang/Object;)V

    move v0, v1

    .line 1349
    :goto_0
    return v0

    .line 1330
    :cond_0
    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->g:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    aget-object v0, v3, v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/ui/i;->e()Z

    move-result v0

    if-nez v0, :cond_1

    move v0, v1

    .line 1332
    goto :goto_0

    .line 1335
    :cond_1
    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->g:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    aget-object v0, v3, v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/ui/i;->f()V

    .line 1336
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->g:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    if-ne v0, v3, :cond_3

    .line 1338
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    .line 1339
    :goto_1
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    if-lez v0, :cond_2

    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v3

    if-nez v0, :cond_2

    .line 1341
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    goto :goto_1

    .line 1343
    :cond_2
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    if-gez v0, :cond_3

    .line 1345
    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    :cond_3
    move v0, v2

    .line 1349
    goto :goto_0
.end method

.method private l(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)V
    .locals 5

    .prologue
    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 1282
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getControlId()Ljava/lang/String;

    move-result-object v2

    .line 1283
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getColor()Ljava/lang/String;

    move-result-object v0

    .line 1285
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->g:Ljava/util/HashMap;

    invoke-virtual {v1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    if-nez v1, :cond_0

    .line 1287
    sget v0, Lcom/cyjh/rootipc/R$string;->ui_show_not_found_ui:I

    new-array v1, v4, [Ljava/lang/Object;

    aput-object v2, v1, v3

    invoke-direct {p0, v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(I[Ljava/lang/Object;)V

    .line 1288
    invoke-direct {p0, v3}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    .line 1306
    :goto_0
    return-void

    .line 1292
    :cond_0
    const-string v1, "^#*([0-9A-Fa-f]{6})|([0-9A-Fa-f]{3})"

    invoke-virtual {v0, v1}, Ljava/lang/String;->matches(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 1294
    sget v0, Lcom/cyjh/rootipc/R$string;->ui_show_invalid_color_value:I

    new-array v1, v3, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(I[Ljava/lang/Object;)V

    .line 1295
    invoke-direct {p0, v3}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto :goto_0

    .line 1299
    :cond_1
    const-string v1, "#"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_2

    .line 1300
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "#"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    move-object v1, v0

    .line 1301
    :goto_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->g:Ljava/util/HashMap;

    invoke-virtual {v0, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    .line 1302
    invoke-static {v1}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v1

    .line 1303
    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/utils/b;->a(I)I

    move-result v1

    .line 1304
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    aget-object v0, v2, v0

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(I)V

    .line 1305
    invoke-direct {p0, v4}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    goto :goto_0

    :cond_2
    move-object v1, v0

    goto :goto_1
.end method


# virtual methods
.method public a()V
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 93
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/ui/h;->c()V

    .line 94
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    .line 95
    const/4 v1, 0x1

    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->j:I

    .line 96
    :goto_0
    const/16 v1, 0x20

    if-ge v0, v1, :cond_1

    .line 98
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    const/4 v2, 0x0

    aput-object v2, v1, v0

    .line 99
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    aget-object v1, v1, v0

    if-eqz v1, :cond_0

    .line 100
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    aget-object v1, v1, v0

    invoke-virtual {v1}, Ljava/util/HashMap;->clear()V

    .line 96
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 102
    :cond_1
    return-void
.end method

.method public a(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)V
    .locals 8

    .prologue
    .line 106
    const/4 v7, 0x1

    .line 107
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getControlId()Ljava/lang/String;

    move-result-object v2

    .line 108
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getCommand()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;

    move-result-object v0

    .line 109
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "command: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 111
    sget-object v1, Lcom/cyjh/mobileanjian/ipc/ui/h$3;->a:[I

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;->ordinal()I

    move-result v0

    aget v0, v1, v0

    packed-switch v0, :pswitch_data_0

    :cond_0
    move v0, v7

    .line 327
    :goto_0
    invoke-direct {p0, v0}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Z)V

    .line 328
    :goto_1
    return-void

    .line 116
    :pswitch_0
    :try_start_0
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getPath()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/cyjh/mobileanjian/ipc/ui/h;->f(Ljava/lang/String;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    move v0, v7

    .line 123
    goto :goto_0

    .line 117
    :catch_0
    move-exception v0

    .line 119
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    move v0, v7

    .line 123
    goto :goto_0

    .line 120
    :catch_1
    move-exception v0

    .line 122
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    move v0, v7

    .line 124
    goto :goto_0

    .line 128
    :pswitch_1
    :try_start_1
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getPath()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/cyjh/mobileanjian/ipc/ui/h;->g(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_2
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_3

    move v0, v7

    .line 135
    goto :goto_0

    .line 129
    :catch_2
    move-exception v0

    .line 131
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    move v0, v7

    .line 135
    goto :goto_0

    .line 132
    :catch_3
    move-exception v0

    .line 134
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    move v0, v7

    .line 136
    goto :goto_0

    .line 138
    :pswitch_2
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getWidth()I

    move-result v0

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getHeight()I

    move-result v1

    invoke-direct {p0, v2, v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Ljava/lang/String;II)V

    move v0, v7

    .line 139
    goto :goto_0

    .line 141
    :pswitch_3
    invoke-direct {p0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/h;->h(Ljava/lang/String;)V

    goto :goto_1

    .line 144
    :pswitch_4
    invoke-direct {p0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/h;->j(Ljava/lang/String;)V

    move v0, v7

    .line 145
    goto :goto_0

    .line 147
    :pswitch_5
    invoke-direct {p0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/h;->k(Ljava/lang/String;)Z

    move-result v0

    goto :goto_0

    .line 150
    :pswitch_6
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/ui/h;->c()V

    move v0, v7

    .line 151
    goto :goto_0

    .line 153
    :pswitch_7
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    if-eqz v0, :cond_0

    .line 155
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/ui/h;->b()I

    move-result v1

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getParentId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getWidth()I

    move-result v4

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getHeight()I

    move-result v5

    invoke-virtual/range {v0 .. v5}, Lcom/cyjh/mobileanjian/ipc/ui/i;->a(ILjava/lang/String;Ljava/lang/String;II)V

    move v0, v7

    goto :goto_0

    .line 160
    :pswitch_8
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getText()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v2, v0}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    goto :goto_0

    .line 163
    :pswitch_9
    invoke-direct {p0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/h;->i(Ljava/lang/String;)V

    goto :goto_1

    .line 166
    :pswitch_a
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/ui/h;->l(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)V

    goto :goto_1

    .line 171
    :pswitch_b
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    if-eqz v0, :cond_0

    .line 174
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->f:Lcom/cyjh/mobileanjian/ipc/ui/g;

    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/ui/h;->b()I

    move-result v1

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getWidth()I

    move-result v3

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getHeight()I

    move-result v4

    invoke-virtual {v0, v1, v2, v3, v4}, Lcom/cyjh/mobileanjian/ipc/ui/g;->a(ILjava/lang/String;II)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 175
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v1, v1, v3

    sget-object v3, Lcom/cyjh/mobileanjian/ipc/ui/k;->i:Lcom/cyjh/mobileanjian/ipc/ui/k;

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 176
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v1, v1, v2

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getParentId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/i;->a(Landroid/view/View;Ljava/lang/String;)V

    move v0, v7

    .line 177
    goto/16 :goto_0

    .line 181
    :pswitch_c
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    if-eqz v0, :cond_0

    .line 183
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->f:Lcom/cyjh/mobileanjian/ipc/ui/g;

    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/ui/h;->b()I

    move-result v1

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getText()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getWidth()I

    move-result v4

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getHeight()I

    move-result v5

    invoke-virtual/range {v0 .. v5}, Lcom/cyjh/mobileanjian/ipc/ui/g;->a(ILjava/lang/String;Ljava/lang/String;II)Landroid/widget/TextView;

    move-result-object v0

    .line 184
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v1, v1, v3

    sget-object v3, Lcom/cyjh/mobileanjian/ipc/ui/k;->a:Lcom/cyjh/mobileanjian/ipc/ui/k;

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 185
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v1, v1, v2

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getParentId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/i;->a(Landroid/view/View;Ljava/lang/String;)V

    move v0, v7

    .line 186
    goto/16 :goto_0

    .line 189
    :pswitch_d
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    if-eqz v0, :cond_0

    .line 191
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->f:Lcom/cyjh/mobileanjian/ipc/ui/g;

    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/ui/h;->b()I

    move-result v1

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getText()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getWidth()I

    move-result v4

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getHeight()I

    move-result v5

    invoke-virtual/range {v0 .. v5}, Lcom/cyjh/mobileanjian/ipc/ui/g;->c(ILjava/lang/String;Ljava/lang/String;II)Landroid/widget/EditText;

    move-result-object v0

    .line 192
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v1, v1, v3

    sget-object v3, Lcom/cyjh/mobileanjian/ipc/ui/k;->b:Lcom/cyjh/mobileanjian/ipc/ui/k;

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 193
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v1, v1, v3

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getParentId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v0, v3}, Lcom/cyjh/mobileanjian/ipc/ui/i;->a(Landroid/view/View;Ljava/lang/String;)V

    .line 194
    new-instance v1, Lcom/cyjh/mobileanjian/ipc/ui/h$a;

    invoke-direct {v1, p0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/h$a;-><init>(Lcom/cyjh/mobileanjian/ipc/ui/h;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    move v0, v7

    .line 195
    goto/16 :goto_0

    .line 198
    :pswitch_e
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    if-eqz v0, :cond_0

    .line 200
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->f:Lcom/cyjh/mobileanjian/ipc/ui/g;

    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/ui/h;->b()I

    move-result v1

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getText()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getWidth()I

    move-result v4

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getHeight()I

    move-result v5

    invoke-virtual/range {v0 .. v5}, Lcom/cyjh/mobileanjian/ipc/ui/g;->b(ILjava/lang/String;Ljava/lang/String;II)Landroid/widget/Button;

    move-result-object v0

    .line 201
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v1, v1, v3

    sget-object v3, Lcom/cyjh/mobileanjian/ipc/ui/k;->c:Lcom/cyjh/mobileanjian/ipc/ui/k;

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 202
    invoke-virtual {v0, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 203
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v1, v1, v2

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getParentId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/i;->a(Landroid/view/View;Ljava/lang/String;)V

    move v0, v7

    .line 204
    goto/16 :goto_0

    .line 207
    :pswitch_f
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    if-eqz v0, :cond_0

    .line 209
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->f:Lcom/cyjh/mobileanjian/ipc/ui/g;

    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/ui/h;->b()I

    move-result v1

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getItemTextList()Ljava/util/List;

    move-result-object v3

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getDefaultItemIndex()I

    move-result v4

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getWidth()I

    move-result v5

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getHeight()I

    move-result v6

    invoke-virtual/range {v0 .. v6}, Lcom/cyjh/mobileanjian/ipc/ui/g;->a(ILjava/lang/String;Ljava/util/List;III)Landroid/widget/RadioGroup;

    move-result-object v0

    .line 210
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v1, v1, v3

    sget-object v3, Lcom/cyjh/mobileanjian/ipc/ui/k;->e:Lcom/cyjh/mobileanjian/ipc/ui/k;

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 211
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v1, v1, v2

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getParentId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/i;->a(Landroid/view/View;Ljava/lang/String;)V

    move v0, v7

    .line 212
    goto/16 :goto_0

    .line 216
    :pswitch_10
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    if-eqz v0, :cond_0

    .line 218
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->f:Lcom/cyjh/mobileanjian/ipc/ui/g;

    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/ui/h;->b()I

    move-result v1

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getText()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getWidth()I

    move-result v4

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getHeight()I

    move-result v5

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getDefaultCheckStatus()Z

    move-result v6

    invoke-virtual/range {v0 .. v6}, Lcom/cyjh/mobileanjian/ipc/ui/g;->a(ILjava/lang/String;Ljava/lang/String;IIZ)Landroid/widget/CheckBox;

    move-result-object v0

    .line 219
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v1, v1, v3

    sget-object v3, Lcom/cyjh/mobileanjian/ipc/ui/k;->d:Lcom/cyjh/mobileanjian/ipc/ui/k;

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 220
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v1, v1, v2

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getParentId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/i;->a(Landroid/view/View;Ljava/lang/String;)V

    move v0, v7

    .line 221
    goto/16 :goto_0

    .line 225
    :pswitch_11
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    if-eqz v0, :cond_0

    .line 227
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->f:Lcom/cyjh/mobileanjian/ipc/ui/g;

    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/ui/h;->b()I

    move-result v1

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getWidth()I

    move-result v3

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getHeight()I

    move-result v4

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getPath()Ljava/lang/String;

    move-result-object v5

    invoke-virtual/range {v0 .. v5}, Lcom/cyjh/mobileanjian/ipc/ui/g;->b(ILjava/lang/String;IILjava/lang/String;)Landroid/widget/ImageView;

    move-result-object v0

    .line 228
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v1, v1, v3

    sget-object v3, Lcom/cyjh/mobileanjian/ipc/ui/k;->g:Lcom/cyjh/mobileanjian/ipc/ui/k;

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 229
    invoke-virtual {v0, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 230
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v1, v1, v2

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getParentId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/i;->a(Landroid/view/View;Ljava/lang/String;)V

    move v0, v7

    .line 231
    goto/16 :goto_0

    .line 235
    :pswitch_12
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    if-eqz v0, :cond_0

    .line 237
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->f:Lcom/cyjh/mobileanjian/ipc/ui/g;

    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/ui/h;->b()I

    move-result v1

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getWidth()I

    move-result v3

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getHeight()I

    move-result v4

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getUrl()Ljava/lang/String;

    move-result-object v5

    invoke-virtual/range {v0 .. v5}, Lcom/cyjh/mobileanjian/ipc/ui/g;->a(ILjava/lang/String;IILjava/lang/String;)Landroid/webkit/WebView;

    move-result-object v0

    .line 238
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v1, v1, v3

    sget-object v3, Lcom/cyjh/mobileanjian/ipc/ui/k;->h:Lcom/cyjh/mobileanjian/ipc/ui/k;

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 239
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v1, v1, v2

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getParentId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/i;->a(Landroid/view/View;Ljava/lang/String;)V

    move v0, v7

    .line 240
    goto/16 :goto_0

    .line 244
    :pswitch_13
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    if-eqz v0, :cond_0

    .line 246
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->f:Lcom/cyjh/mobileanjian/ipc/ui/g;

    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/ui/h;->b()I

    move-result v1

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getItemTextList()Ljava/util/List;

    move-result-object v3

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getDefaultItemIndex()I

    move-result v4

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getWidth()I

    move-result v5

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getHeight()I

    move-result v6

    invoke-virtual/range {v0 .. v6}, Lcom/cyjh/mobileanjian/ipc/ui/g;->b(ILjava/lang/String;Ljava/util/List;III)Landroid/widget/Spinner;

    move-result-object v0

    .line 247
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v1, v1, v3

    sget-object v3, Lcom/cyjh/mobileanjian/ipc/ui/k;->f:Lcom/cyjh/mobileanjian/ipc/ui/k;

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 248
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v1, v1, v2

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getParentId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/i;->a(Landroid/view/View;Ljava/lang/String;)V

    .line 249
    invoke-virtual {v0, p0}, Landroid/widget/Spinner;->setOnItemSelectedListener(Landroid/widget/AdapterView$OnItemSelectedListener;)V

    move v0, v7

    .line 250
    goto/16 :goto_0

    .line 253
    :pswitch_14
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    if-eqz v0, :cond_0

    .line 255
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getControlId()Ljava/lang/String;

    move-result-object v1

    const/4 v2, -0x1

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getHeight()I

    move-result v3

    invoke-virtual {v0, v1, v2, v3}, Lcom/cyjh/mobileanjian/ipc/ui/i;->a(Ljava/lang/String;II)V

    move v0, v7

    goto/16 :goto_0

    .line 259
    :pswitch_15
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    if-eqz v0, :cond_0

    .line 261
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->d:I

    aget-object v0, v0, v1

    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/ui/h;->b()I

    move-result v1

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getControlId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getParentId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getText()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v1, v2, v3, v4}, Lcom/cyjh/mobileanjian/ipc/ui/i;->a(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    goto/16 :goto_0

    .line 277
    :pswitch_16
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/ui/h;->b(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)Z

    move-result v0

    goto/16 :goto_0

    .line 280
    :pswitch_17
    invoke-direct {p0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/h;->b(Ljava/lang/String;)V

    move v0, v7

    .line 281
    goto/16 :goto_0

    .line 283
    :pswitch_18
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/ui/h;->e(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)V

    goto/16 :goto_1

    .line 286
    :pswitch_19
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/ui/h;->c(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)V

    goto/16 :goto_1

    .line 289
    :pswitch_1a
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/ui/h;->d(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)V

    goto/16 :goto_1

    .line 293
    :pswitch_1b
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/ui/h;->k(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)V

    goto/16 :goto_1

    .line 296
    :pswitch_1c
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/ui/h;->f(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)V

    goto/16 :goto_1

    .line 299
    :pswitch_1d
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/ui/h;->g(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)V

    goto/16 :goto_1

    .line 302
    :pswitch_1e
    invoke-virtual {p0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Ljava/lang/String;)V

    goto/16 :goto_1

    .line 305
    :pswitch_1f
    invoke-direct {p0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/h;->c(Ljava/lang/String;)V

    goto/16 :goto_1

    .line 308
    :pswitch_20
    invoke-direct {p0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/h;->d(Ljava/lang/String;)V

    goto/16 :goto_1

    .line 311
    :pswitch_21
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/ui/h;->j(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)V

    goto/16 :goto_1

    :pswitch_22
    move v0, v7

    .line 315
    goto/16 :goto_0

    .line 317
    :pswitch_23
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/ui/h;->h(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)V

    goto/16 :goto_1

    :pswitch_24
    move v0, v7

    .line 321
    goto/16 :goto_0

    .line 323
    :pswitch_25
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/ui/h;->i(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)V

    goto/16 :goto_1

    .line 111
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
        :pswitch_6
        :pswitch_7
        :pswitch_8
        :pswitch_9
        :pswitch_a
        :pswitch_b
        :pswitch_c
        :pswitch_d
        :pswitch_e
        :pswitch_f
        :pswitch_10
        :pswitch_11
        :pswitch_12
        :pswitch_13
        :pswitch_14
        :pswitch_15
        :pswitch_16
        :pswitch_16
        :pswitch_16
        :pswitch_16
        :pswitch_16
        :pswitch_16
        :pswitch_16
        :pswitch_16
        :pswitch_16
        :pswitch_16
        :pswitch_16
        :pswitch_17
        :pswitch_18
        :pswitch_19
        :pswitch_1a
        :pswitch_1b
        :pswitch_1c
        :pswitch_1d
        :pswitch_1e
        :pswitch_1f
        :pswitch_20
        :pswitch_21
        :pswitch_22
        :pswitch_23
        :pswitch_24
        :pswitch_25
    .end packed-switch
.end method

.method public a(Ljava/lang/String;)V
    .locals 8

    .prologue
    const/4 v7, 0x1

    const/4 v2, 0x0

    .line 1387
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->RSP_MSG:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    .line 1388
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setCommand(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    .line 1389
    invoke-virtual {v0, v7}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setIsSuccess(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v3

    .line 1390
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->setControlId(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v4

    .line 1393
    const/4 v0, 0x0

    move v1, v2

    .line 1394
    :goto_0
    const/16 v5, 0x20

    if-ge v1, v5, :cond_3

    .line 1396
    iget-object v5, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    aget-object v5, v5, v1

    if-nez v5, :cond_1

    .line 1394
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1398
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->h:[Ljava/util/HashMap;

    aget-object v0, v0, v1

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/ui/k;

    if-eqz v0, :cond_0

    .line 1405
    :goto_1
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "type="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "; tempIndex="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->d(Ljava/lang/String;)V

    .line 1407
    if-nez v0, :cond_2

    .line 1409
    sget v0, Lcom/cyjh/rootipc/R$string;->ui_show_not_found_widget:I

    new-array v1, v7, [Ljava/lang/Object;

    aput-object p1, v1, v2

    invoke-direct {p0, v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(I[Ljava/lang/Object;)V

    .line 1410
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->getInstance()Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v0

    invoke-virtual {v3, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setIsSuccess(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v1

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    move-result-object v1

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->toByteString()Lcom/google/protobuf/ByteString;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->sendUiResponse(Lcom/google/protobuf/ByteString;)V

    .line 1448
    :goto_2
    return-void

    .line 1413
    :cond_2
    sget-object v5, Lcom/cyjh/mobileanjian/ipc/ui/h$3;->b:[I

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/ui/k;->ordinal()I

    move-result v0

    aget v0, v5, v0

    packed-switch v0, :pswitch_data_0

    .line 1442
    invoke-virtual {v3, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setIsSuccess(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    .line 1446
    :goto_3
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Ui.getValue result: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 1447
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->getInstance()Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v0

    invoke-virtual {v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    move-result-object v1

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->toByteString()Lcom/google/protobuf/ByteString;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->sendUiResponse(Lcom/google/protobuf/ByteString;)V

    goto :goto_2

    .line 1418
    :pswitch_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    aget-object v0, v0, v1

    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 1419
    sget-object v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->STRING:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    invoke-virtual {v4, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->setType(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v1

    .line 1420
    invoke-virtual {v0}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->setStringValue(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    .line 1421
    invoke-virtual {v4}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v0

    invoke-virtual {v3, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->addVarTable(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    goto :goto_3

    .line 1424
    :pswitch_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    aget-object v0, v0, v1

    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/CheckBox;

    .line 1425
    sget-object v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->BOOL:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    invoke-virtual {v4, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->setType(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v1

    .line 1426
    invoke-virtual {v0}, Landroid/widget/CheckBox;->isChecked()Z

    move-result v0

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->setBoolValue(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    .line 1427
    invoke-virtual {v4}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v0

    invoke-virtual {v3, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->addVarTable(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    goto :goto_3

    .line 1430
    :pswitch_2
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    aget-object v0, v0, v1

    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/RadioGroup;

    .line 1431
    sget-object v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->INT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    invoke-virtual {v4, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->setType(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v1

    .line 1432
    invoke-virtual {v0}, Landroid/widget/RadioGroup;->getCheckedRadioButtonId()I

    move-result v0

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->setIntValue(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    .line 1433
    invoke-virtual {v4}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v0

    invoke-virtual {v3, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->addVarTable(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    goto/16 :goto_3

    .line 1436
    :pswitch_3
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h;->c:[Lcom/cyjh/mobileanjian/ipc/ui/i;

    aget-object v0, v0, v1

    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/ui/i;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Spinner;

    .line 1437
    sget-object v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->INT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    invoke-virtual {v4, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->setType(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v1

    .line 1438
    invoke-virtual {v0}, Landroid/widget/Spinner;->getSelectedItemPosition()I

    move-result v0

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->setIntValue(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    .line 1439
    invoke-virtual {v4}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v0

    invoke-virtual {v3, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->addVarTable(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    goto/16 :goto_3

    :cond_3
    move v1, v2

    goto/16 :goto_1

    .line 1413
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method

.method public onClick(Landroid/view/View;)V
    .locals 3

    .prologue
    .line 1372
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v1

    .line 1373
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->setControlId(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->ON_CLICK:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    .line 1374
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->setType(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    .line 1375
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v0

    .line 1377
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->EVENT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    .line 1378
    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setCommand(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v1

    .line 1379
    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setEvent(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    const/4 v1, 0x1

    .line 1380
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setIsSuccess(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    .line 1381
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    move-result-object v0

    .line 1382
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->getInstance()Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v1

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->toByteString()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->notifyUiEvent(Lcom/google/protobuf/ByteString;)V

    .line 1383
    return-void
.end method

.method public onItemSelected(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView",
            "<*>;",
            "Landroid/view/View;",
            "IJ)V"
        }
    .end annotation

    .prologue
    .line 1453
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v1

    .line 1454
    invoke-virtual {p1}, Landroid/widget/AdapterView;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->setControlId(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    .line 1455
    invoke-static {p3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->setEventArgs(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->ON_CLICK:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    .line 1456
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->setType(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    .line 1457
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v0

    .line 1459
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->EVENT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    .line 1460
    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setCommand(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v1

    .line 1461
    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setEvent(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    const/4 v1, 0x1

    .line 1462
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setIsSuccess(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    .line 1463
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    move-result-object v0

    .line 1464
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->getInstance()Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v1

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->toByteString()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->notifyUiEvent(Lcom/google/protobuf/ByteString;)V

    .line 1465
    return-void
.end method

.method public onNothingSelected(Landroid/widget/AdapterView;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView",
            "<*>;)V"
        }
    .end annotation

    .prologue
    .line 1471
    return-void
.end method
