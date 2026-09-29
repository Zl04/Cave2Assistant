.class public Lcom/cyjh/mobileanjian/ipc/ui/g;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field private a:Landroid/content/Context;

.field private b:Landroid/view/LayoutInflater;


# direct methods
.method private constructor <init>(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 37
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 38
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/ui/g;->a:Landroid/content/Context;

    .line 39
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/g;->a:Landroid/content/Context;

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/g;->b:Landroid/view/LayoutInflater;

    .line 40
    return-void
.end method

.method private a(I)I
    .locals 3

    .prologue
    .line 44
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/g;->a:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    .line 45
    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    .line 46
    int-to-float v1, p1

    iget v0, v0, Landroid/util/DisplayMetrics;->densityDpi:I

    int-to-float v0, v0

    const/high16 v2, 0x43200000    # 160.0f

    div-float/2addr v0, v2

    mul-float/2addr v0, v1

    .line 47
    float-to-int v0, v0

    return v0
.end method

.method private a(II)Landroid/widget/LinearLayout$LayoutParams;
    .locals 3

    .prologue
    const/4 v2, 0x0

    const/4 v1, -0x2

    .line 52
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v0, v1, v1}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 53
    if-eq p1, v1, :cond_0

    if-eq p2, v1, :cond_0

    .line 55
    iput p1, v0, Landroid/widget/LinearLayout$LayoutParams;->width:I

    .line 56
    iput p2, v0, Landroid/widget/LinearLayout$LayoutParams;->height:I

    .line 58
    :cond_0
    const/16 v1, 0x8

    invoke-direct {p0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/g;->a(I)I

    move-result v1

    invoke-virtual {v0, v2, v2, v1, v2}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 60
    return-object v0
.end method

.method public static a(Landroid/content/Context;)Lcom/cyjh/mobileanjian/ipc/ui/g;
    .locals 1

    .prologue
    .line 76
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/ui/g;

    invoke-direct {v0, p0}, Lcom/cyjh/mobileanjian/ipc/ui/g;-><init>(Landroid/content/Context;)V

    return-object v0
.end method


# virtual methods
.method public a(F)I
    .locals 4

    .prologue
    .line 64
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/g;->a:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    .line 65
    mul-float/2addr v0, p1

    float-to-double v0, v0

    const-wide/high16 v2, 0x3fe0000000000000L    # 0.5

    add-double/2addr v0, v2

    double-to-int v0, v0

    return v0
.end method

.method public a(ILjava/lang/String;IILjava/lang/String;)Landroid/webkit/WebView;
    .locals 3

    .prologue
    .line 216
    const-string v0, "http://"

    invoke-virtual {p5, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "https://"

    invoke-virtual {p5, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 218
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "http://"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p5

    .line 221
    :cond_0
    new-instance v0, Landroid/webkit/WebView;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/g;->a:Landroid/content/Context;

    invoke-direct {v0, v1}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V

    .line 222
    invoke-virtual {v0, p2}, Landroid/webkit/WebView;->setTag(Ljava/lang/Object;)V

    .line 223
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v1, p3, p4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 224
    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v1

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    .line 225
    invoke-virtual {v0, p5}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    .line 226
    new-instance v1, Lcom/cyjh/mobileanjian/ipc/ui/g$1;

    invoke-direct {v1, p0}, Lcom/cyjh/mobileanjian/ipc/ui/g$1;-><init>(Lcom/cyjh/mobileanjian/ipc/ui/g;)V

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    .line 235
    return-object v0
.end method

.method public a(ILjava/lang/String;Ljava/lang/String;IIZ)Landroid/widget/CheckBox;
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 178
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/g;->a:Landroid/content/Context;

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    sget v1, Lcom/cyjh/rootipc/R$layout;->ui_show_checkbox:I

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/CheckBox;

    .line 181
    invoke-virtual {v0, p2}, Landroid/widget/CheckBox;->setTag(Ljava/lang/Object;)V

    .line 182
    invoke-virtual {v0, p3}, Landroid/widget/CheckBox;->setText(Ljava/lang/CharSequence;)V

    .line 183
    invoke-virtual {v0, p6}, Landroid/widget/CheckBox;->setChecked(Z)V

    .line 184
    invoke-direct {p0, p4, p5}, Lcom/cyjh/mobileanjian/ipc/ui/g;->a(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/CheckBox;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 185
    invoke-virtual {v0, v3, v3, v3, v3}, Landroid/widget/CheckBox;->setPadding(IIII)V

    .line 187
    return-object v0
.end method

.method public a(ILjava/lang/String;)Landroid/widget/LinearLayout;
    .locals 3

    .prologue
    .line 265
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/g;->b:Landroid/view/LayoutInflater;

    sget v1, Lcom/cyjh/rootipc/R$layout;->ui_show_tab_layout:I

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    .line 266
    invoke-virtual {v0, p1}, Landroid/widget/LinearLayout;->setId(I)V

    .line 267
    invoke-virtual {v0, p2}, Landroid/widget/LinearLayout;->setTag(Ljava/lang/Object;)V

    .line 269
    return-object v0
.end method

.method public a(ILjava/lang/String;II)Landroid/widget/LinearLayout;
    .locals 2

    .prologue
    .line 92
    new-instance v0, Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/g;->a:Landroid/content/Context;

    invoke-direct {v0, v1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 94
    invoke-virtual {v0, p2}, Landroid/widget/LinearLayout;->setTag(Ljava/lang/Object;)V

    .line 95
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 96
    const/high16 v1, -0x1000000

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setBackgroundColor(I)V

    .line 97
    const/4 v1, -0x1

    if-ne p3, v1, :cond_0

    .line 99
    const/16 p3, 0xbb8

    .line 101
    :cond_0
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v1, p3, p4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 103
    return-object v0
.end method

.method public a(ILjava/lang/String;Ljava/util/List;III)Landroid/widget/RadioGroup;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/lang/String;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;III)",
            "Landroid/widget/RadioGroup;"
        }
    .end annotation

    .prologue
    const/4 v7, 0x5

    const/4 v6, -0x2

    const/4 v3, 0x0

    .line 192
    new-instance v4, Landroid/widget/RadioGroup;

    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/g;->a:Landroid/content/Context;

    invoke-direct {v4, v0}, Landroid/widget/RadioGroup;-><init>(Landroid/content/Context;)V

    .line 193
    invoke-virtual {v4, p2}, Landroid/widget/RadioGroup;->setTag(Ljava/lang/Object;)V

    .line 194
    invoke-direct {p0, p5, p6}, Lcom/cyjh/mobileanjian/ipc/ui/g;->a(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {v4, v0}, Landroid/widget/RadioGroup;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    move v2, v3

    .line 196
    :goto_0
    invoke-interface {p3}, Ljava/util/List;->size()I

    move-result v0

    if-ge v2, v0, :cond_0

    .line 198
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/g;->b:Landroid/view/LayoutInflater;

    sget v1, Lcom/cyjh/rootipc/R$layout;->ui_show_radio_button:I

    const/4 v5, 0x0

    invoke-virtual {v0, v1, v5}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/RadioButton;

    .line 199
    invoke-virtual {v0, v2}, Landroid/widget/RadioButton;->setId(I)V

    .line 200
    invoke-interface {p3, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Landroid/widget/RadioButton;->setText(Ljava/lang/CharSequence;)V

    .line 201
    invoke-direct {p0, v6, v6}, Lcom/cyjh/mobileanjian/ipc/ui/g;->a(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/RadioButton;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 202
    invoke-direct {p0, v7}, Lcom/cyjh/mobileanjian/ipc/ui/g;->a(I)I

    move-result v1

    invoke-direct {p0, v7}, Lcom/cyjh/mobileanjian/ipc/ui/g;->a(I)I

    move-result v5

    invoke-virtual {v0, v3, v1, v3, v5}, Landroid/widget/RadioButton;->setPadding(IIII)V

    .line 203
    invoke-virtual {v4, v0}, Landroid/widget/RadioGroup;->addView(Landroid/view/View;)V

    .line 205
    const/16 v0, 0x64

    if-lt v2, v0, :cond_1

    .line 208
    :cond_0
    invoke-virtual {v4}, Landroid/widget/RadioGroup;->clearCheck()V

    .line 209
    invoke-virtual {v4}, Landroid/widget/RadioGroup;->getChildCount()I

    move-result v0

    if-ge p4, v0, :cond_2

    .line 210
    :goto_1
    invoke-virtual {v4, p4}, Landroid/widget/RadioGroup;->check(I)V

    .line 211
    return-object v4

    .line 196
    :cond_1
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_0

    :cond_2
    move p4, v3

    .line 209
    goto :goto_1
.end method

.method public a(ILjava/lang/String;Ljava/lang/String;)Landroid/widget/TextView;
    .locals 6

    .prologue
    const/4 v4, -0x2

    .line 121
    move-object v0, p0

    move v1, p1

    move-object v2, p2

    move-object v3, p3

    move v5, v4

    invoke-virtual/range {v0 .. v5}, Lcom/cyjh/mobileanjian/ipc/ui/g;->a(ILjava/lang/String;Ljava/lang/String;II)Landroid/widget/TextView;

    move-result-object v0

    return-object v0
.end method

.method public a(ILjava/lang/String;Ljava/lang/String;II)Landroid/widget/TextView;
    .locals 3

    .prologue
    .line 126
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/g;->b:Landroid/view/LayoutInflater;

    sget v1, Lcom/cyjh/rootipc/R$layout;->ui_show_text_view:I

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 128
    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setTag(Ljava/lang/Object;)V

    .line 129
    invoke-virtual {v0, p3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 131
    invoke-direct {p0, p4, p5}, Lcom/cyjh/mobileanjian/ipc/ui/g;->a(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 132
    return-object v0
.end method

.method public a(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/ui/i;
    .locals 2

    .prologue
    .line 81
    const/4 v0, -0x1

    const/4 v1, -0x2

    invoke-virtual {p0, p1, v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/g;->a(Ljava/lang/String;II)Lcom/cyjh/mobileanjian/ipc/ui/i;

    move-result-object v0

    return-object v0
.end method

.method public a(Ljava/lang/String;II)Lcom/cyjh/mobileanjian/ipc/ui/i;
    .locals 2

    .prologue
    .line 86
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/ui/i;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/g;->a:Landroid/content/Context;

    invoke-direct {v0, v1, p1, p2, p3}, Lcom/cyjh/mobileanjian/ipc/ui/i;-><init>(Landroid/content/Context;Ljava/lang/String;II)V

    .line 87
    return-object v0
.end method

.method public b(F)I
    .locals 4

    .prologue
    .line 70
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/g;->a:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    .line 71
    div-float v0, p1, v0

    float-to-double v0, v0

    const-wide/high16 v2, 0x3fe0000000000000L    # 0.5

    add-double/2addr v0, v2

    double-to-int v0, v0

    return v0
.end method

.method public b(ILjava/lang/String;Ljava/lang/String;)Landroid/widget/Button;
    .locals 6

    .prologue
    const/4 v4, -0x2

    .line 137
    move-object v0, p0

    move v1, p1

    move-object v2, p2

    move-object v3, p3

    move v5, v4

    invoke-virtual/range {v0 .. v5}, Lcom/cyjh/mobileanjian/ipc/ui/g;->b(ILjava/lang/String;Ljava/lang/String;II)Landroid/widget/Button;

    move-result-object v0

    return-object v0
.end method

.method public b(ILjava/lang/String;Ljava/lang/String;II)Landroid/widget/Button;
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 142
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/g;->b:Landroid/view/LayoutInflater;

    sget v1, Lcom/cyjh/rootipc/R$layout;->ui_show_button:I

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    .line 143
    invoke-virtual {v0, p2}, Landroid/widget/Button;->setTag(Ljava/lang/Object;)V

    .line 144
    invoke-virtual {v0, p3}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 145
    invoke-virtual {v0, v3}, Landroid/widget/Button;->setAllCaps(Z)V

    .line 147
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v1, p4, p5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 148
    const/16 v2, 0x8

    invoke-direct {p0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/g;->a(I)I

    move-result v2

    invoke-virtual {v1, v3, v3, v2, v3}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 149
    invoke-virtual {v0, v1}, Landroid/widget/Button;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 150
    sget v1, Lcom/cyjh/rootipc/R$drawable;->bg_default_button:I

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setBackgroundResource(I)V

    .line 152
    return-object v0
.end method

.method public b(ILjava/lang/String;IILjava/lang/String;)Landroid/widget/ImageView;
    .locals 2

    .prologue
    .line 240
    new-instance v0, Landroid/widget/ImageView;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/g;->a:Landroid/content/Context;

    invoke-direct {v0, v1}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    .line 241
    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setId(I)V

    .line 242
    invoke-virtual {v0, p2}, Landroid/widget/ImageView;->setTag(Ljava/lang/Object;)V

    .line 243
    invoke-direct {p0, p3, p4}, Lcom/cyjh/mobileanjian/ipc/ui/g;->a(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 244
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, p5}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v1}, Landroid/net/Uri;->fromFile(Ljava/io/File;)Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageURI(Landroid/net/Uri;)V

    .line 246
    return-object v0
.end method

.method public b(ILjava/lang/String;II)Landroid/widget/LinearLayout;
    .locals 3

    .prologue
    .line 108
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/g;->a:Landroid/content/Context;

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    sget v1, Lcom/cyjh/rootipc/R$layout;->ui_show_row:I

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    .line 110
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 112
    invoke-virtual {v0, p2}, Landroid/widget/LinearLayout;->setTag(Ljava/lang/Object;)V

    .line 114
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v1, p3, p4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 115
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 116
    return-object v0
.end method

.method public b(ILjava/lang/String;Ljava/util/List;III)Landroid/widget/Spinner;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/lang/String;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;III)",
            "Landroid/widget/Spinner;"
        }
    .end annotation

    .prologue
    const/4 v3, -0x2

    .line 251
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/g;->b:Landroid/view/LayoutInflater;

    sget v1, Lcom/cyjh/rootipc/R$layout;->ui_show_spinner:I

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Spinner;

    .line 253
    invoke-virtual {v0, p2}, Landroid/widget/Spinner;->setTag(Ljava/lang/Object;)V

    .line 254
    invoke-direct {p0, v3, v3}, Lcom/cyjh/mobileanjian/ipc/ui/g;->a(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/Spinner;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 255
    new-instance v1, Landroid/widget/ArrayAdapter;

    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/ui/g;->a:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$layout;->ui_show_spinner_dropdown_item:I

    invoke-direct {v1, v2, v3, p3}, Landroid/widget/ArrayAdapter;-><init>(Landroid/content/Context;ILjava/util/List;)V

    .line 256
    invoke-virtual {v0, v1}, Landroid/widget/Spinner;->setAdapter(Landroid/widget/SpinnerAdapter;)V

    .line 257
    invoke-virtual {v1}, Landroid/widget/ArrayAdapter;->getCount()I

    move-result v1

    if-ge p4, v1, :cond_0

    .line 258
    :goto_0
    invoke-virtual {v0, p4}, Landroid/widget/Spinner;->setSelection(I)V

    .line 260
    return-object v0

    .line 257
    :cond_0
    const/4 p4, 0x0

    goto :goto_0
.end method

.method public c(ILjava/lang/String;Ljava/lang/String;)Landroid/widget/EditText;
    .locals 6

    .prologue
    const/4 v4, -0x2

    .line 157
    move-object v0, p0

    move v1, p1

    move-object v2, p2

    move-object v3, p3

    move v5, v4

    invoke-virtual/range {v0 .. v5}, Lcom/cyjh/mobileanjian/ipc/ui/g;->c(ILjava/lang/String;Ljava/lang/String;II)Landroid/widget/EditText;

    move-result-object v0

    return-object v0
.end method

.method public c(ILjava/lang/String;Ljava/lang/String;II)Landroid/widget/EditText;
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 162
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/g;->b:Landroid/view/LayoutInflater;

    sget v1, Lcom/cyjh/rootipc/R$layout;->ui_show_edit_text:I

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    .line 163
    invoke-virtual {v0, p2}, Landroid/widget/EditText;->setTag(Ljava/lang/Object;)V

    .line 164
    invoke-virtual {v0, p3}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 167
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v1, p4, p5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 168
    const/16 v2, 0x8

    invoke-direct {p0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/g;->a(I)I

    move-result v2

    invoke-virtual {v1, v3, v3, v2, v3}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 169
    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 170
    sget v1, Lcom/cyjh/rootipc/R$drawable;->bg_edit_text:I

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setBackgroundResource(I)V

    .line 172
    return-object v0
.end method
