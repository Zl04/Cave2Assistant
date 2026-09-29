.class public Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/widget/AdapterView$OnItemSelectedListener;


# static fields
.field public static final UIP_MESSAGE:I

.field private static final a:Ljava/lang/String;


# instance fields
.field private b:Landroid/content/Context;

.field private c:Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;

.field private d:Lcom/cyjh/mobileanjian/ipc/uip/b;

.field private e:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Landroid/widget/ScrollView;",
            ">;"
        }
    .end annotation
.end field

.field private f:Z

.field private g:Landroid/os/Handler;

.field private h:Lorg/json/JSONObject;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    .line 50
    new-instance v0, Ljava/io/File;

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v1

    const-string v2, ".uip.config.json"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->a:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 59
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 587
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper$1;

    invoke-direct {v0, p0}, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper$1;-><init>(Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->g:Landroid/os/Handler;

    .line 60
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    .line 61
    return-void
.end method

.method private a(Ljava/lang/String;Lcom/cyjh/mobileanjian/ipc/uip/IUipJsonParser;)Landroid/widget/LinearLayout;
    .locals 13

    .prologue
    const/4 v12, 0x7

    const/4 v8, 0x1

    const/4 v7, -0x1

    .line 75
    if-nez p2, :cond_0

    .line 77
    new-instance p2, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;

    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    invoke-direct {p2, v0}, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;-><init>(Landroid/content/Context;)V

    .line 80
    :cond_0
    new-instance v1, Landroid/widget/LinearLayout;

    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    invoke-direct {v1, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 81
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v0, v7, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 82
    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 83
    invoke-virtual {v1, v8}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 85
    new-instance v2, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;

    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    invoke-direct {v2, v3}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;-><init>(Landroid/content/Context;)V

    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->c:Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;

    .line 86
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->c:Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;

    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v4, -0x2

    invoke-direct {v3, v7, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v2, v3}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 87
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->c:Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;

    new-array v3, v8, [I

    const/4 v4, 0x0

    iget-object v5, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    invoke-virtual {v5}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    sget v6, Lcom/cyjh/rootipc/R$color;->ui_show_blue:I

    invoke-virtual {v5, v6}, Landroid/content/res/Resources;->getColor(I)I

    move-result v5

    aput v5, v3, v4

    invoke-virtual {v2, v3}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->setSelectedIndicatorColors([I)V

    .line 88
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->c:Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;

    invoke-virtual {v2, v8}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->setDistributeEvenly(Z)V

    .line 89
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->c:Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 91
    new-instance v2, Landroid/support/v4/view/ViewPager;

    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    invoke-direct {v2, v3}, Landroid/support/v4/view/ViewPager;-><init>(Landroid/content/Context;)V

    .line 92
    new-instance v3, Landroid/widget/TableLayout$LayoutParams;

    invoke-direct {v3, v7, v7}, Landroid/widget/TableLayout$LayoutParams;-><init>(II)V

    .line 93
    const/high16 v4, 0x3f800000    # 1.0f

    iput v4, v3, Landroid/widget/TableLayout$LayoutParams;->weight:F

    .line 94
    invoke-virtual {v2, v3}, Landroid/support/v4/view/ViewPager;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 95
    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 97
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3, v12}, Ljava/util/ArrayList;-><init>(I)V

    .line 98
    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4, v12}, Ljava/util/ArrayList;-><init>(I)V

    .line 100
    new-instance v5, Landroid/util/JsonReader;

    new-instance v6, Ljava/io/StringReader;

    invoke-direct {v6, p1}, Ljava/io/StringReader;-><init>(Ljava/lang/String;)V

    invoke-direct {v5, v6}, Landroid/util/JsonReader;-><init>(Ljava/io/Reader;)V

    .line 103
    :try_start_0
    invoke-virtual {v5}, Landroid/util/JsonReader;->beginObject()V

    .line 104
    :goto_0
    invoke-virtual {v5}, Landroid/util/JsonReader;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_1

    .line 106
    invoke-virtual {v5}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v6

    .line 107
    iget-object v7, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    sget v8, Lcom/cyjh/rootipc/R$string;->ui_activity:I

    invoke-virtual {v7, v8}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v6

    if-nez v6, :cond_2

    .line 170
    :cond_1
    invoke-virtual {v5}, Landroid/util/JsonReader;->endObject()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_1

    .line 180
    :goto_1
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/uip/d;

    invoke-direct {v0, v3, v4}, Lcom/cyjh/mobileanjian/ipc/uip/d;-><init>(Ljava/util/List;Ljava/util/List;)V

    .line 181
    invoke-virtual {v2, v0}, Landroid/support/v4/view/ViewPager;->setAdapter(Landroid/support/v4/view/PagerAdapter;)V

    .line 182
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->c:Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;

    invoke-virtual {v0, v2}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->setViewPager(Landroid/support/v4/view/ViewPager;)V

    .line 185
    invoke-virtual {p0, v3}, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->bindEvent(Ljava/util/List;)V

    .line 186
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->a:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->saveToConfigFile(Ljava/lang/String;)V

    .line 188
    return-object v1

    .line 110
    :cond_2
    :try_start_1
    invoke-virtual {v5}, Landroid/util/JsonReader;->beginObject()V

    .line 111
    :cond_3
    :goto_2
    invoke-virtual {v5}, Landroid/util/JsonReader;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_b

    .line 113
    invoke-virtual {v5}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v6

    .line 114
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "tab title: "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->d(Ljava/lang/String;)V

    .line 116
    new-instance v7, Landroid/widget/LinearLayout;

    iget-object v8, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    invoke-direct {v7, v8}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 117
    const/4 v8, 0x1

    invoke-virtual {v7, v8}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 118
    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 119
    new-instance v8, Landroid/widget/ScrollView;

    iget-object v9, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    invoke-direct {v8, v9}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 120
    invoke-virtual {v8, v6}, Landroid/widget/ScrollView;->setTag(Ljava/lang/Object;)V

    .line 121
    invoke-virtual {v8, v0}, Landroid/widget/ScrollView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 122
    invoke-virtual {v8, v7}, Landroid/widget/ScrollView;->addView(Landroid/view/View;)V

    .line 124
    invoke-virtual {v5}, Landroid/util/JsonReader;->beginObject()V

    .line 125
    :goto_3
    invoke-virtual {v5}, Landroid/util/JsonReader;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_a

    .line 127
    invoke-virtual {v5}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v9

    .line 128
    iget-object v10, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    sget v11, Lcom/cyjh/rootipc/R$string;->ui_linearlayout:I

    invoke-virtual {v10, v11}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_4

    .line 130
    invoke-interface {p2, v5}, Lcom/cyjh/mobileanjian/ipc/uip/IUipJsonParser;->parseHorizontalLinearLayout(Landroid/util/JsonReader;)Lcom/cyjh/mobileanjian/ipc/uip/a;

    move-result-object v9

    .line 131
    invoke-virtual {v7, v9}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/IllegalStateException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_3

    .line 171
    :catch_0
    move-exception v0

    .line 173
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_1

    .line 132
    :cond_4
    :try_start_2
    iget-object v10, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    sget v11, Lcom/cyjh/rootipc/R$string;->ui_textview:I

    invoke-virtual {v10, v11}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_5

    .line 134
    invoke-interface {p2, v5}, Lcom/cyjh/mobileanjian/ipc/uip/IUipJsonParser;->parseTextView(Landroid/util/JsonReader;)Landroid/widget/TextView;

    move-result-object v9

    .line 135
    invoke-virtual {v7, v9}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/IllegalStateException; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_3

    .line 175
    :catch_1
    move-exception v0

    .line 177
    invoke-virtual {v0}, Ljava/lang/IllegalStateException;->printStackTrace()V

    goto/16 :goto_1

    .line 136
    :cond_5
    :try_start_3
    iget-object v10, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    sget v11, Lcom/cyjh/rootipc/R$string;->ui_button:I

    invoke-virtual {v10, v11}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_6

    .line 138
    invoke-interface {p2, v5}, Lcom/cyjh/mobileanjian/ipc/uip/IUipJsonParser;->parseButton(Landroid/util/JsonReader;)Landroid/widget/Button;

    move-result-object v9

    .line 139
    invoke-virtual {v7, v9}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto :goto_3

    .line 140
    :cond_6
    iget-object v10, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    sget v11, Lcom/cyjh/rootipc/R$string;->ui_edittext:I

    invoke-virtual {v10, v11}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_7

    .line 142
    invoke-interface {p2, v5}, Lcom/cyjh/mobileanjian/ipc/uip/IUipJsonParser;->parseEditText(Landroid/util/JsonReader;)Landroid/widget/EditText;

    move-result-object v9

    .line 143
    invoke-virtual {v7, v9}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto :goto_3

    .line 144
    :cond_7
    iget-object v10, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    sget v11, Lcom/cyjh/rootipc/R$string;->ui_checkbox:I

    invoke-virtual {v10, v11}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_8

    .line 146
    invoke-interface {p2, v5}, Lcom/cyjh/mobileanjian/ipc/uip/IUipJsonParser;->parseCheckBox(Landroid/util/JsonReader;)Landroid/widget/CheckBox;

    move-result-object v9

    .line 147
    invoke-virtual {v7, v9}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto/16 :goto_3

    .line 148
    :cond_8
    iget-object v10, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    sget v11, Lcom/cyjh/rootipc/R$string;->ui_spinner:I

    invoke-virtual {v10, v11}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_9

    .line 150
    invoke-interface {p2, v5}, Lcom/cyjh/mobileanjian/ipc/uip/IUipJsonParser;->parseSpinner(Landroid/util/JsonReader;)Landroid/widget/Spinner;

    move-result-object v9

    .line 151
    invoke-virtual {v7, v9}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto/16 :goto_3

    .line 154
    :cond_9
    invoke-virtual {v5}, Landroid/util/JsonReader;->skipValue()V

    .line 155
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "\u6ca1\u6709\u6b64\u8282\u70b9: "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->e(Ljava/lang/String;)V

    goto/16 :goto_3

    .line 158
    :cond_a
    invoke-virtual {v5}, Landroid/util/JsonReader;->endObject()V

    .line 160
    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v7

    if-ge v7, v12, :cond_3

    .line 163
    invoke-interface {v4, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 164
    invoke-interface {v3, v8}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto/16 :goto_2

    .line 167
    :cond_b
    invoke-virtual {v5}, Landroid/util/JsonReader;->endObject()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_0
    .catch Ljava/lang/IllegalStateException; {:try_start_3 .. :try_end_3} :catch_1

    goto/16 :goto_0
.end method

.method private a(Landroid/view/ViewGroup;)V
    .locals 4

    .prologue
    .line 353
    const/4 v0, 0x0

    invoke-virtual {p1}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v3

    move v2, v0

    :goto_0
    if-ge v2, v3, :cond_5

    .line 355
    invoke-virtual {p1, v2}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    .line 356
    instance-of v1, v0, Lcom/cyjh/mobileanjian/ipc/uip/a;

    if-nez v1, :cond_0

    instance-of v1, v0, Landroid/widget/LinearLayout;

    if-eqz v1, :cond_2

    .line 358
    :cond_0
    check-cast v0, Landroid/view/ViewGroup;

    invoke-direct {p0, v0}, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->a(Landroid/view/ViewGroup;)V

    .line 353
    :cond_1
    :goto_1
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_0

    .line 361
    :cond_2
    sget v1, Lcom/cyjh/rootipc/R$id;->uip_function_key:I

    invoke-virtual {v0, v1}, Landroid/view/View;->getTag(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 366
    instance-of v1, v0, Landroid/widget/Spinner;

    if-eqz v1, :cond_3

    .line 368
    check-cast v0, Landroid/widget/Spinner;

    .line 369
    invoke-virtual {v0, p0}, Landroid/widget/Spinner;->setOnItemSelectedListener(Landroid/widget/AdapterView$OnItemSelectedListener;)V

    goto :goto_1

    .line 370
    :cond_3
    instance-of v1, v0, Landroid/widget/CheckBox;

    if-eqz v1, :cond_4

    .line 372
    check-cast v0, Landroid/widget/CheckBox;

    .line 373
    invoke-virtual {v0, p0}, Landroid/widget/CheckBox;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    goto :goto_1

    .line 374
    :cond_4
    instance-of v1, v0, Landroid/widget/Button;

    if-eqz v1, :cond_1

    .line 376
    check-cast v0, Landroid/widget/Button;

    .line 377
    invoke-virtual {v0, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    goto :goto_1

    .line 381
    :cond_5
    return-void
.end method

.method static synthetic a(Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .prologue
    .line 47
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->a(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic a(Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 47
    invoke-direct {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->a(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method private a(Ljava/lang/String;)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .prologue
    .line 390
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 392
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->e:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/ViewGroup;

    .line 394
    invoke-virtual {v0, p1}, Landroid/view/ViewGroup;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    .line 395
    instance-of v3, v0, Landroid/widget/Spinner;

    if-eqz v3, :cond_3

    .line 397
    check-cast v0, Landroid/widget/Spinner;

    .line 398
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$string;->ui_spinner_defaultitem:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0}, Landroid/widget/Spinner;->getSelectedItemPosition()I

    move-result v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 399
    invoke-virtual {v0}, Landroid/widget/Spinner;->getAdapter()Landroid/widget/SpinnerAdapter;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/uip/c;

    .line 400
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/uip/c;->a()Ljava/util/List;

    move-result-object v0

    .line 401
    new-instance v2, Lorg/json/JSONArray;

    invoke-direct {v2}, Lorg/json/JSONArray;-><init>()V

    .line 402
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 404
    invoke-virtual {v2, v0}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    goto :goto_0

    .line 406
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$string;->ui_spinner_items:I

    invoke-virtual {v0, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 433
    :cond_2
    :goto_1
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;->RSP_MSG:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;

    .line 434
    invoke-virtual {v0, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->setCommand(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    const/4 v2, 0x1

    .line 435
    invoke-virtual {v0, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->setIsSuccess(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    .line 436
    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->setUipAttributeData(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    .line 437
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    move-result-object v0

    .line 439
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->toByteString()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/uip/UipEventStub;->UiRequestReturn(Lcom/google/protobuf/ByteString;)V

    .line 440
    return-void

    .line 409
    :cond_3
    instance-of v3, v0, Landroid/widget/CheckBox;

    if-eqz v3, :cond_4

    .line 411
    check-cast v0, Landroid/widget/CheckBox;

    .line 412
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$string;->ui_checkbox_hintcontent:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0}, Landroid/widget/CheckBox;->getText()Ljava/lang/CharSequence;

    move-result-object v3

    invoke-interface {v3}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 413
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$string;->ui_checkbox_checked:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0}, Landroid/widget/CheckBox;->isChecked()Z

    move-result v0

    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    goto :goto_1

    .line 415
    :cond_4
    instance-of v3, v0, Landroid/widget/Button;

    if-eqz v3, :cond_5

    .line 417
    check-cast v0, Landroid/widget/Button;

    .line 418
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$string;->ui_textview_textcontent:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0}, Landroid/widget/Button;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_1

    .line 420
    :cond_5
    instance-of v3, v0, Landroid/widget/EditText;

    if-eqz v3, :cond_6

    .line 422
    check-cast v0, Landroid/widget/EditText;

    .line 423
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$string;->ui_edittext_defaultcontent:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_1

    .line 425
    :cond_6
    instance-of v3, v0, Landroid/widget/TextView;

    if-eqz v3, :cond_0

    .line 427
    check-cast v0, Landroid/widget/TextView;

    .line 428
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$string;->ui_textview_textcontent:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto/16 :goto_1
.end method

.method private a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 7

    .prologue
    .line 444
    new-instance v3, Landroid/util/JsonReader;

    new-instance v0, Ljava/io/StringReader;

    invoke-direct {v0, p2}, Ljava/io/StringReader;-><init>(Ljava/lang/String;)V

    invoke-direct {v3, v0}, Landroid/util/JsonReader;-><init>(Ljava/io/Reader;)V

    .line 448
    :try_start_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->e:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/ViewGroup;

    .line 450
    invoke-virtual {v0, p1}, Landroid/view/ViewGroup;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    .line 451
    instance-of v2, v0, Landroid/widget/Spinner;

    if-eqz v2, :cond_7

    .line 453
    check-cast v0, Landroid/widget/Spinner;

    .line 454
    const/4 v2, -0x1

    .line 455
    const/4 v1, 0x0

    .line 456
    invoke-virtual {v3}, Landroid/util/JsonReader;->beginObject()V

    .line 457
    :goto_0
    invoke-virtual {v3}, Landroid/util/JsonReader;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_5

    .line 459
    invoke-virtual {v3}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v4

    .line 460
    iget-object v5, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    sget v6, Lcom/cyjh/rootipc/R$string;->ui_spinner_defaultitem:I

    invoke-virtual {v5, v6}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 462
    invoke-virtual {v3}, Landroid/util/JsonReader;->nextInt()I

    move-result v2

    goto :goto_0

    .line 463
    :cond_1
    iget-object v5, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    sget v6, Lcom/cyjh/rootipc/R$string;->ui_spinner_items:I

    invoke-virtual {v5, v6}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_4

    .line 465
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 466
    invoke-virtual {v3}, Landroid/util/JsonReader;->beginArray()V

    .line 467
    :goto_1
    invoke-virtual {v3}, Landroid/util/JsonReader;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_3

    .line 469
    invoke-virtual {v3}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v1, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_1

    .line 571
    :catch_0
    move-exception v0

    .line 573
    invoke-virtual {v0}, Ljava/lang/IllegalStateException;->printStackTrace()V

    .line 580
    :cond_2
    :goto_2
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;->RSP_MSG:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;

    .line 581
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->setCommand(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    const/4 v1, 0x1

    .line 582
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->setIsSuccess(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    .line 583
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    move-result-object v0

    .line 584
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->toByteString()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/uip/UipEventStub;->UiRequestReturn(Lcom/google/protobuf/ByteString;)V

    .line 585
    return-void

    .line 471
    :cond_3
    :try_start_1
    invoke-virtual {v3}, Landroid/util/JsonReader;->endArray()V
    :try_end_1
    .catch Ljava/lang/IllegalStateException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    .line 575
    :catch_1
    move-exception v0

    .line 577
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_2

    .line 475
    :cond_4
    :try_start_2
    invoke-virtual {v3}, Landroid/util/JsonReader;->skipValue()V

    goto :goto_0

    .line 478
    :cond_5
    invoke-virtual {v3}, Landroid/util/JsonReader;->endObject()V

    .line 479
    if-eqz v1, :cond_6

    .line 481
    new-instance v3, Lcom/cyjh/mobileanjian/ipc/uip/c;

    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    const v5, 0x1090008

    invoke-direct {v3, v4, v5, v1}, Lcom/cyjh/mobileanjian/ipc/uip/c;-><init>(Landroid/content/Context;ILjava/util/List;)V

    .line 482
    const v1, 0x1090009

    invoke-virtual {v3, v1}, Lcom/cyjh/mobileanjian/ipc/uip/c;->setDropDownViewResource(I)V

    .line 483
    invoke-virtual {v0, v3}, Landroid/widget/Spinner;->setAdapter(Landroid/widget/SpinnerAdapter;)V

    .line 485
    :cond_6
    if-ltz v2, :cond_2

    invoke-virtual {v0}, Landroid/widget/Spinner;->getCount()I

    move-result v1

    if-ge v2, v1, :cond_2

    .line 487
    invoke-virtual {v0, v2}, Landroid/widget/Spinner;->setSelection(I)V

    goto :goto_2

    .line 491
    :cond_7
    instance-of v2, v0, Landroid/widget/CheckBox;

    if-eqz v2, :cond_b

    .line 493
    check-cast v0, Landroid/widget/CheckBox;

    .line 495
    invoke-virtual {v3}, Landroid/util/JsonReader;->beginObject()V

    .line 496
    :goto_3
    invoke-virtual {v3}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_a

    .line 498
    invoke-virtual {v3}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 499
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    sget v4, Lcom/cyjh/rootipc/R$string;->ui_checkbox_hintcontent:I

    invoke-virtual {v2, v4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_8

    .line 501
    invoke-virtual {v3}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/CheckBox;->setText(Ljava/lang/CharSequence;)V

    goto :goto_3

    .line 502
    :cond_8
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    sget v4, Lcom/cyjh/rootipc/R$string;->ui_checkbox_checked:I

    invoke-virtual {v2, v4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_9

    .line 504
    invoke-virtual {v3}, Landroid/util/JsonReader;->nextBoolean()Z

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/CheckBox;->setChecked(Z)V

    goto :goto_3

    .line 508
    :cond_9
    invoke-virtual {v3}, Landroid/util/JsonReader;->skipValue()V

    goto :goto_3

    .line 511
    :cond_a
    invoke-virtual {v3}, Landroid/util/JsonReader;->endObject()V

    goto/16 :goto_2

    .line 513
    :cond_b
    instance-of v2, v0, Landroid/widget/Button;

    if-eqz v2, :cond_e

    .line 515
    check-cast v0, Landroid/widget/Button;

    .line 516
    invoke-virtual {v3}, Landroid/util/JsonReader;->beginObject()V

    .line 517
    :goto_4
    invoke-virtual {v3}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_d

    .line 519
    invoke-virtual {v3}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 520
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    sget v4, Lcom/cyjh/rootipc/R$string;->ui_textview_textcontent:I

    invoke-virtual {v2, v4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_c

    .line 522
    invoke-virtual {v3}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    goto :goto_4

    .line 526
    :cond_c
    invoke-virtual {v3}, Landroid/util/JsonReader;->skipValue()V

    goto :goto_4

    .line 529
    :cond_d
    invoke-virtual {v3}, Landroid/util/JsonReader;->endObject()V

    goto/16 :goto_2

    .line 531
    :cond_e
    instance-of v2, v0, Landroid/widget/EditText;

    if-eqz v2, :cond_11

    .line 533
    check-cast v0, Landroid/widget/EditText;

    .line 535
    invoke-virtual {v3}, Landroid/util/JsonReader;->beginObject()V

    .line 536
    :goto_5
    invoke-virtual {v3}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_10

    .line 538
    invoke-virtual {v3}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 539
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    sget v4, Lcom/cyjh/rootipc/R$string;->ui_edittext_defaultcontent:I

    invoke-virtual {v2, v4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_f

    .line 541
    invoke-virtual {v3}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    goto :goto_5

    .line 545
    :cond_f
    invoke-virtual {v3}, Landroid/util/JsonReader;->skipValue()V

    goto :goto_5

    .line 548
    :cond_10
    invoke-virtual {v3}, Landroid/util/JsonReader;->endObject()V

    goto/16 :goto_2

    .line 550
    :cond_11
    instance-of v2, v0, Landroid/widget/TextView;

    if-eqz v2, :cond_0

    .line 552
    check-cast v0, Landroid/widget/TextView;

    .line 554
    invoke-virtual {v3}, Landroid/util/JsonReader;->beginObject()V

    .line 555
    :goto_6
    invoke-virtual {v3}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_13

    .line 557
    invoke-virtual {v3}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 558
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    sget v4, Lcom/cyjh/rootipc/R$string;->ui_textview_textcontent:I

    invoke-virtual {v2, v4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_12

    .line 560
    invoke-virtual {v3}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_6

    .line 564
    :cond_12
    invoke-virtual {v3}, Landroid/util/JsonReader;->skipValue()V

    goto :goto_6

    .line 567
    :cond_13
    invoke-virtual {v3}, Landroid/util/JsonReader;->endObject()V
    :try_end_2
    .catch Ljava/lang/IllegalStateException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1

    goto/16 :goto_2
.end method

.method private b(Ljava/lang/String;Lcom/cyjh/mobileanjian/ipc/uip/IUipJsonParser;)Landroid/widget/LinearLayout;
    .locals 6

    .prologue
    const/4 v1, 0x0

    .line 193
    if-nez p2, :cond_0

    .line 195
    new-instance p2, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;

    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    invoke-direct {p2, v0}, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;-><init>(Landroid/content/Context;)V

    .line 199
    :cond_0
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/uip/b;

    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    invoke-direct {v0, v2}, Lcom/cyjh/mobileanjian/ipc/uip/b;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->d:Lcom/cyjh/mobileanjian/ipc/uip/b;

    .line 201
    new-instance v2, Landroid/util/JsonReader;

    new-instance v0, Ljava/io/StringReader;

    invoke-direct {v0, p1}, Ljava/io/StringReader;-><init>(Ljava/lang/String;)V

    invoke-direct {v2, v0}, Landroid/util/JsonReader;-><init>(Ljava/io/Reader;)V

    .line 204
    :try_start_0
    invoke-virtual {v2}, Landroid/util/JsonReader;->beginObject()V

    .line 205
    :goto_0
    invoke-virtual {v2}, Landroid/util/JsonReader;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 207
    invoke-virtual {v2}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v0

    .line 208
    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    sget v4, Lcom/cyjh/rootipc/R$string;->ui_activity:I

    invoke-virtual {v3, v4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 260
    :cond_1
    invoke-virtual {v2}, Landroid/util/JsonReader;->endObject()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_1

    .line 270
    :goto_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->d:Lcom/cyjh/mobileanjian/ipc/uip/b;

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/uip/b;->setSelectTab(I)V

    .line 272
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->d:Lcom/cyjh/mobileanjian/ipc/uip/b;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/uip/b;->getScrollViewList()Ljava/util/List;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->bindEvent(Ljava/util/List;)V

    .line 273
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->a:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->saveToConfigFile(Ljava/lang/String;)V

    .line 275
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->d:Lcom/cyjh/mobileanjian/ipc/uip/b;

    return-object v0

    .line 211
    :cond_2
    :try_start_1
    invoke-virtual {v2}, Landroid/util/JsonReader;->beginObject()V

    move v0, v1

    .line 212
    :goto_2
    const/4 v3, 0x7

    if-ge v0, v3, :cond_a

    invoke-virtual {v2}, Landroid/util/JsonReader;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_a

    .line 214
    invoke-virtual {v2}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v3

    .line 217
    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->d:Lcom/cyjh/mobileanjian/ipc/uip/b;

    invoke-virtual {v4, v3}, Lcom/cyjh/mobileanjian/ipc/uip/b;->a(Ljava/lang/String;)V

    .line 218
    invoke-virtual {v2}, Landroid/util/JsonReader;->beginObject()V

    .line 219
    :goto_3
    invoke-virtual {v2}, Landroid/util/JsonReader;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_9

    .line 221
    invoke-virtual {v2}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v3

    .line 222
    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    sget v5, Lcom/cyjh/rootipc/R$string;->ui_linearlayout:I

    invoke-virtual {v4, v5}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 224
    invoke-interface {p2, v2}, Lcom/cyjh/mobileanjian/ipc/uip/IUipJsonParser;->parseHorizontalLinearLayout(Landroid/util/JsonReader;)Lcom/cyjh/mobileanjian/ipc/uip/a;

    move-result-object v3

    .line 225
    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->d:Lcom/cyjh/mobileanjian/ipc/uip/b;

    invoke-virtual {v4, v3}, Lcom/cyjh/mobileanjian/ipc/uip/b;->a(Landroid/view/View;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/IllegalStateException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_3

    .line 261
    :catch_0
    move-exception v0

    .line 263
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_1

    .line 226
    :cond_3
    :try_start_2
    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    sget v5, Lcom/cyjh/rootipc/R$string;->ui_textview:I

    invoke-virtual {v4, v5}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_4

    .line 228
    invoke-interface {p2, v2}, Lcom/cyjh/mobileanjian/ipc/uip/IUipJsonParser;->parseTextView(Landroid/util/JsonReader;)Landroid/widget/TextView;

    move-result-object v3

    .line 229
    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->d:Lcom/cyjh/mobileanjian/ipc/uip/b;

    invoke-virtual {v4, v3}, Lcom/cyjh/mobileanjian/ipc/uip/b;->a(Landroid/view/View;)V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/IllegalStateException; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_3

    .line 265
    :catch_1
    move-exception v0

    .line 267
    invoke-virtual {v0}, Ljava/lang/IllegalStateException;->printStackTrace()V

    goto :goto_1

    .line 230
    :cond_4
    :try_start_3
    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    sget v5, Lcom/cyjh/rootipc/R$string;->ui_button:I

    invoke-virtual {v4, v5}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_5

    .line 232
    invoke-interface {p2, v2}, Lcom/cyjh/mobileanjian/ipc/uip/IUipJsonParser;->parseButton(Landroid/util/JsonReader;)Landroid/widget/Button;

    move-result-object v3

    .line 233
    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->d:Lcom/cyjh/mobileanjian/ipc/uip/b;

    invoke-virtual {v4, v3}, Lcom/cyjh/mobileanjian/ipc/uip/b;->a(Landroid/view/View;)V

    goto :goto_3

    .line 234
    :cond_5
    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    sget v5, Lcom/cyjh/rootipc/R$string;->ui_edittext:I

    invoke-virtual {v4, v5}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_6

    .line 236
    invoke-interface {p2, v2}, Lcom/cyjh/mobileanjian/ipc/uip/IUipJsonParser;->parseEditText(Landroid/util/JsonReader;)Landroid/widget/EditText;

    move-result-object v3

    .line 237
    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->d:Lcom/cyjh/mobileanjian/ipc/uip/b;

    invoke-virtual {v4, v3}, Lcom/cyjh/mobileanjian/ipc/uip/b;->a(Landroid/view/View;)V

    goto :goto_3

    .line 238
    :cond_6
    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    sget v5, Lcom/cyjh/rootipc/R$string;->ui_checkbox:I

    invoke-virtual {v4, v5}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_7

    .line 240
    invoke-interface {p2, v2}, Lcom/cyjh/mobileanjian/ipc/uip/IUipJsonParser;->parseCheckBox(Landroid/util/JsonReader;)Landroid/widget/CheckBox;

    move-result-object v3

    .line 241
    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->d:Lcom/cyjh/mobileanjian/ipc/uip/b;

    invoke-virtual {v4, v3}, Lcom/cyjh/mobileanjian/ipc/uip/b;->a(Landroid/view/View;)V

    goto/16 :goto_3

    .line 242
    :cond_7
    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    sget v5, Lcom/cyjh/rootipc/R$string;->ui_spinner:I

    invoke-virtual {v4, v5}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_8

    .line 244
    invoke-interface {p2, v2}, Lcom/cyjh/mobileanjian/ipc/uip/IUipJsonParser;->parseSpinner(Landroid/util/JsonReader;)Landroid/widget/Spinner;

    move-result-object v3

    .line 245
    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->d:Lcom/cyjh/mobileanjian/ipc/uip/b;

    invoke-virtual {v4, v3}, Lcom/cyjh/mobileanjian/ipc/uip/b;->a(Landroid/view/View;)V

    goto/16 :goto_3

    .line 248
    :cond_8
    invoke-virtual {v2}, Landroid/util/JsonReader;->skipValue()V

    .line 249
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "\u6ca1\u6709\u6b64\u8282\u70b9: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->e(Ljava/lang/String;)V

    goto/16 :goto_3

    .line 252
    :cond_9
    invoke-virtual {v2}, Landroid/util/JsonReader;->endObject()V

    .line 254
    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->d:Lcom/cyjh/mobileanjian/ipc/uip/b;

    invoke-virtual {v3}, Lcom/cyjh/mobileanjian/ipc/uip/b;->a()V

    .line 212
    add-int/lit8 v0, v0, 0x1

    goto/16 :goto_2

    .line 257
    :cond_a
    invoke-virtual {v2}, Landroid/util/JsonReader;->endObject()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_0
    .catch Ljava/lang/IllegalStateException; {:try_start_3 .. :try_end_3} :catch_1

    goto/16 :goto_0
.end method

.method private b(Landroid/view/ViewGroup;)V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .prologue
    .line 714
    const/4 v0, 0x0

    invoke-virtual {p1}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v3

    move v2, v0

    :goto_0
    if-ge v2, v3, :cond_5

    .line 716
    invoke-virtual {p1, v2}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    .line 717
    invoke-virtual {v1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 718
    instance-of v4, v1, Landroid/widget/LinearLayout;

    if-nez v4, :cond_0

    instance-of v4, v1, Lcom/cyjh/mobileanjian/ipc/uip/a;

    if-eqz v4, :cond_2

    :cond_0
    move-object v0, v1

    .line 720
    check-cast v0, Landroid/view/ViewGroup;

    invoke-direct {p0, v0}, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b(Landroid/view/ViewGroup;)V

    .line 714
    :cond_1
    :goto_1
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_0

    .line 721
    :cond_2
    instance-of v4, v1, Landroid/widget/CheckBox;

    if-eqz v4, :cond_3

    .line 723
    check-cast v1, Landroid/widget/CheckBox;

    .line 724
    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->h:Lorg/json/JSONObject;

    invoke-virtual {v1}, Landroid/widget/CheckBox;->isChecked()Z

    move-result v1

    invoke-virtual {v4, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    goto :goto_1

    .line 725
    :cond_3
    instance-of v4, v1, Landroid/widget/Spinner;

    if-eqz v4, :cond_4

    .line 727
    check-cast v1, Landroid/widget/Spinner;

    .line 728
    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->h:Lorg/json/JSONObject;

    invoke-virtual {v1}, Landroid/widget/Spinner;->getSelectedItemPosition()I

    move-result v1

    invoke-virtual {v4, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    goto :goto_1

    .line 729
    :cond_4
    instance-of v4, v1, Landroid/widget/EditText;

    if-eqz v4, :cond_1

    .line 731
    check-cast v1, Landroid/widget/EditText;

    .line 732
    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->h:Lorg/json/JSONObject;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v4, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_1

    .line 735
    :cond_5
    return-void
.end method


# virtual methods
.method public bindEvent(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Landroid/widget/ScrollView;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 338
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->g:Landroid/os/Handler;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/uip/UipEventStub;->registerHandler(Landroid/os/Handler;)V

    .line 340
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->e:Ljava/util/List;

    .line 341
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/widget/ScrollView;

    .line 343
    invoke-direct {p0, v0}, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->a(Landroid/view/ViewGroup;)V

    goto :goto_0

    .line 345
    :cond_0
    return-void
.end method

.method public configViewFromFile(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 627
    :try_start_0
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Lorg/apache/commons/io/FileUtils;->readFileToString(Ljava/io/File;)Ljava/lang/String;

    move-result-object v0

    .line 628
    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->configViewFromJson(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 633
    :goto_0
    return-void

    .line 629
    :catch_0
    move-exception v0

    .line 631
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0
.end method

.method public configViewFromJson(Ljava/lang/String;)V
    .locals 8

    .prologue
    const/4 v3, 0x0

    .line 637
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 675
    :goto_0
    return-void

    .line 640
    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->f:Z

    .line 643
    :try_start_0
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 644
    invoke-virtual {v4}, Lorg/json/JSONObject;->keys()Ljava/util/Iterator;

    move-result-object v5

    .line 645
    :cond_1
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 647
    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 648
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->e:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :cond_2
    :goto_1
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/view/ViewGroup;

    .line 651
    invoke-virtual {v1, v0}, Landroid/view/ViewGroup;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 653
    instance-of v2, v1, Landroid/widget/CheckBox;

    if-eqz v2, :cond_4

    .line 655
    check-cast v1, Landroid/widget/CheckBox;

    .line 656
    invoke-virtual {v4, v0}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v2

    invoke-virtual {v1, v2}, Landroid/widget/CheckBox;->setChecked(Z)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 670
    :catch_0
    move-exception v0

    .line 672
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    .line 674
    :cond_3
    iput-boolean v3, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->f:Z

    goto :goto_0

    .line 657
    :cond_4
    :try_start_1
    instance-of v2, v1, Landroid/widget/Spinner;

    if-eqz v2, :cond_6

    .line 659
    check-cast v1, Landroid/widget/Spinner;

    .line 660
    invoke-virtual {v1}, Landroid/widget/Spinner;->getAdapter()Landroid/widget/SpinnerAdapter;

    move-result-object v2

    invoke-interface {v2}, Landroid/widget/SpinnerAdapter;->getCount()I

    move-result v2

    .line 661
    invoke-virtual {v4, v0}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v7

    if-ge v7, v2, :cond_5

    invoke-virtual {v4, v0}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v2

    :goto_2
    invoke-virtual {v1, v2}, Landroid/widget/Spinner;->setSelection(I)V

    goto :goto_1

    :cond_5
    move v2, v3

    goto :goto_2

    .line 662
    :cond_6
    instance-of v2, v1, Landroid/widget/EditText;

    if-eqz v2, :cond_2

    .line 664
    check-cast v1, Landroid/widget/EditText;

    .line 665
    invoke-virtual {v4, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1
.end method

.method public onClick(Landroid/view/View;)V
    .locals 3

    .prologue
    .line 743
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->f:Z

    if-eqz v0, :cond_0

    .line 756
    :goto_0
    return-void

    .line 745
    :cond_0
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v1

    .line 746
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->setControlId(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->ON_CLICK:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    .line 747
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->setType(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v1

    sget v0, Lcom/cyjh/rootipc/R$id;->uip_function_key:I

    .line 748
    invoke-virtual {p1, v0}, Landroid/view/View;->getTag(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->setEventFunctionName(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    .line 749
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v0

    .line 750
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;->EVENT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;

    .line 751
    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->setCommand(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v1

    const/4 v2, 0x1

    .line 752
    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->setIsSuccess(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v1

    .line 753
    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->setEvent(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    move-result-object v0

    .line 754
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->toByteString()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/uip/UipEventStub;->hasEvent(Lcom/google/protobuf/ByteString;)V

    .line 755
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "onClick Function Name: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget v0, Lcom/cyjh/rootipc/R$id;->uip_function_key:I

    invoke-virtual {p1, v0}, Landroid/view/View;->getTag(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    goto :goto_0
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
    .line 761
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "isCodeEvent: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->f:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 763
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->f:Z

    if-eqz v0, :cond_0

    .line 778
    :goto_0
    return-void

    .line 765
    :cond_0
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v1

    .line 766
    invoke-virtual {p1}, Landroid/widget/AdapterView;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->setControlId(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->ON_CLICK:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    .line 767
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->setType(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    .line 768
    invoke-static {p3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->setEventArgs(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v1

    sget v0, Lcom/cyjh/rootipc/R$id;->uip_function_key:I

    .line 769
    invoke-virtual {p1, v0}, Landroid/widget/AdapterView;->getTag(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->setEventFunctionName(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    .line 770
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v0

    .line 771
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;->EVENT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;

    .line 772
    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->setCommand(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v1

    const/4 v2, 0x1

    .line 773
    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->setIsSuccess(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v1

    .line 774
    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->setEvent(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v1

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    move-result-object v1

    .line 775
    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->toByteString()Lcom/google/protobuf/ByteString;

    move-result-object v1

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/uip/UipEventStub;->hasEvent(Lcom/google/protobuf/ByteString;)V

    .line 777
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onItemSelected: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    goto :goto_0
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
    .line 784
    return-void
.end method

.method public parseLayoutFromJson(Ljava/lang/String;Lcom/cyjh/mobileanjian/ipc/uip/IUipJsonParser;)Landroid/widget/LinearLayout;
    .locals 2

    .prologue
    .line 65
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget v0, v0, Landroid/content/res/Configuration;->orientation:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    .line 67
    invoke-direct {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b(Ljava/lang/String;Lcom/cyjh/mobileanjian/ipc/uip/IUipJsonParser;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 70
    :goto_0
    return-object v0

    :cond_0
    invoke-direct {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->a(Ljava/lang/String;Lcom/cyjh/mobileanjian/ipc/uip/IUipJsonParser;)Landroid/widget/LinearLayout;

    move-result-object v0

    goto :goto_0
.end method

.method public restoreConfig()V
    .locals 1

    .prologue
    .line 385
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->a:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->configViewFromFile(Ljava/lang/String;)V

    .line 386
    return-void
.end method

.method public saveConfigToJson()Ljava/lang/String;
    .locals 3

    .prologue
    .line 681
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->h:Lorg/json/JSONObject;

    .line 682
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->e:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/ViewGroup;

    .line 684
    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    .line 687
    :try_start_0
    invoke-direct {p0, v0}, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b(Landroid/view/ViewGroup;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 688
    :catch_0
    move-exception v0

    .line 690
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0

    .line 693
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->h:Lorg/json/JSONObject;

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public saveToConfigFile(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 705
    :try_start_0
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->saveConfigToJson()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lorg/apache/commons/io/FileUtils;->writeStringToFile(Ljava/io/File;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 710
    :goto_0
    return-void

    .line 706
    :catch_0
    move-exception v0

    .line 708
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0
.end method

.method public transform(I)Landroid/view/View;
    .locals 9

    .prologue
    const/4 v8, 0x0

    const/4 v7, 0x1

    const/4 v6, -0x1

    .line 285
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->e:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/widget/ScrollView;

    .line 287
    invoke-virtual {v0}, Landroid/widget/ScrollView;->getParent()Landroid/view/ViewParent;

    move-result-object v1

    .line 288
    if-eqz v1, :cond_0

    .line 290
    check-cast v1, Landroid/view/ViewGroup;

    invoke-virtual {v1, v0}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V

    .line 292
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "childCount of scrollview: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v0, v8}, Landroid/widget/ScrollView;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/view/ViewGroup;

    invoke-virtual {v0}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->e(Ljava/lang/String;)V

    goto :goto_0

    .line 294
    :cond_1
    const/4 v0, 0x2

    if-ne p1, v0, :cond_2

    .line 296
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/uip/b;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    invoke-direct {v0, v1}, Lcom/cyjh/mobileanjian/ipc/uip/b;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->d:Lcom/cyjh/mobileanjian/ipc/uip/b;

    .line 297
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->d:Lcom/cyjh/mobileanjian/ipc/uip/b;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->e:Ljava/util/List;

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/uip/b;->a(Ljava/util/List;)V

    .line 298
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->d:Lcom/cyjh/mobileanjian/ipc/uip/b;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->c:Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->getViewPager()Landroid/support/v4/view/ViewPager;

    move-result-object v1

    invoke-virtual {v1}, Landroid/support/v4/view/ViewPager;->getCurrentItem()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/uip/b;->setSelectTab(I)V

    .line 300
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->d:Lcom/cyjh/mobileanjian/ipc/uip/b;

    .line 332
    :goto_1
    return-object v0

    .line 304
    :cond_2
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 305
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->e:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_2
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    .line 307
    invoke-virtual {v0}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_2

    .line 310
    :cond_3
    new-instance v0, Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    invoke-direct {v0, v2}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 311
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v2, v6, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 312
    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 313
    invoke-virtual {v0, v7}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 315
    new-instance v2, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;

    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    invoke-direct {v2, v3}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;-><init>(Landroid/content/Context;)V

    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->c:Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;

    .line 316
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->c:Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;

    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v4, -0x2

    invoke-direct {v3, v6, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v2, v3}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 317
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->c:Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;

    new-array v3, v7, [I

    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    invoke-virtual {v4}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    sget v5, Lcom/cyjh/rootipc/R$color;->ui_show_blue:I

    invoke-virtual {v4, v5}, Landroid/content/res/Resources;->getColor(I)I

    move-result v4

    aput v4, v3, v8

    invoke-virtual {v2, v3}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->setSelectedIndicatorColors([I)V

    .line 318
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->c:Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;

    invoke-virtual {v2, v7}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->setDistributeEvenly(Z)V

    .line 319
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->c:Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 321
    new-instance v2, Landroid/support/v4/view/ViewPager;

    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->b:Landroid/content/Context;

    invoke-direct {v2, v3}, Landroid/support/v4/view/ViewPager;-><init>(Landroid/content/Context;)V

    .line 322
    new-instance v3, Landroid/widget/TableLayout$LayoutParams;

    invoke-direct {v3, v6, v6}, Landroid/widget/TableLayout$LayoutParams;-><init>(II)V

    .line 323
    const/high16 v4, 0x3f800000    # 1.0f

    iput v4, v3, Landroid/widget/TableLayout$LayoutParams;->weight:F

    .line 324
    invoke-virtual {v2, v3}, Landroid/support/v4/view/ViewPager;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 325
    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 327
    new-instance v3, Lcom/cyjh/mobileanjian/ipc/uip/d;

    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->e:Ljava/util/List;

    invoke-direct {v3, v4, v1}, Lcom/cyjh/mobileanjian/ipc/uip/d;-><init>(Ljava/util/List;Ljava/util/List;)V

    .line 328
    invoke-virtual {v2, v3}, Landroid/support/v4/view/ViewPager;->setAdapter(Landroid/support/v4/view/PagerAdapter;)V

    .line 329
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->d:Lcom/cyjh/mobileanjian/ipc/uip/b;

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/uip/b;->getCurrentItem()I

    move-result v1

    invoke-virtual {v2, v1}, Landroid/support/v4/view/ViewPager;->setCurrentItem(I)V

    .line 330
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->c:Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;

    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->setViewPager(Landroid/support/v4/view/ViewPager;)V

    goto/16 :goto_1
.end method
