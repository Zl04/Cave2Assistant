.class public Lcom/cyjh/elfin/dialog/ScriptUIDialog;
.super Lcom/cyjh/elfin/dialog/BaseDialog;
.source "ScriptUIDialog.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field private mArrayListCheckBox:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/widget/CheckBox;",
            ">;"
        }
    .end annotation
.end field

.field private mArrayListEditText:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/widget/EditText;",
            ">;"
        }
    .end annotation
.end field

.field private mArrayListSpinner:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/widget/Spinner;",
            ">;"
        }
    .end annotation
.end field

.field private mButtonSave:Landroid/widget/Button;

.field public mContext:Landroid/content/Context;

.field private mImageViewSetting:Landroid/widget/ImageView;

.field private mScrollViewUI:Landroid/widget/ScrollView;

.field private mUipLinearLayoutUI:Landroid/widget/LinearLayout;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 58
    const v0, 0x7f0a00f8

    invoke-direct {p0, p1, v0}, Lcom/cyjh/elfin/dialog/BaseDialog;-><init>(Landroid/content/Context;I)V

    .line 51
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mArrayListCheckBox:Ljava/util/ArrayList;

    .line 52
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mArrayListSpinner:Ljava/util/ArrayList;

    .line 53
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mArrayListEditText:Ljava/util/ArrayList;

    .line 59
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x13

    if-lt v0, v1, :cond_0

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x18

    if-ge v0, v1, :cond_0

    .line 61
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getWindow()Landroid/view/Window;

    move-result-object v0

    const/16 v1, 0x7d5

    invoke-virtual {v0, v1}, Landroid/view/Window;->setType(I)V

    .line 66
    :goto_0
    return-void

    .line 64
    :cond_0
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getWindow()Landroid/view/Window;

    move-result-object v0

    const/16 v1, 0x7d2

    invoke-virtual {v0, v1}, Landroid/view/Window;->setType(I)V

    goto :goto_0
.end method

.method private ParMainLayout(Landroid/util/JsonReader;)Landroid/widget/LinearLayout;
    .locals 10
    .param p1, "reader"    # Landroid/util/JsonReader;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v8, -0x1

    .line 221
    new-instance v5, Landroid/widget/LinearLayout;

    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v7

    invoke-direct {v5, v7}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 222
    .local v5, "verticalLayout":Landroid/widget/LinearLayout;
    new-instance v7, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v7, v8, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v5, v7}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 223
    const/4 v7, 0x1

    invoke-virtual {v5, v7}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 224
    invoke-virtual {p1}, Landroid/util/JsonReader;->beginObject()V

    .line 225
    :goto_0
    invoke-virtual {p1}, Landroid/util/JsonReader;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_5

    .line 226
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v6

    .line 227
    .local v6, "widgetName":Ljava/lang/String;
    iget-object v7, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "widgetName>>>"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 228
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v7

    const v8, 0x7f08011c

    invoke-virtual {v7, v8}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v7, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_0

    .line 229
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->ParsHorizontalLayout(Landroid/util/JsonReader;)Landroid/widget/LinearLayout;

    move-result-object v2

    .line 230
    .local v2, "horizontalLayout":Landroid/widget/LinearLayout;
    invoke-virtual {v5, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto :goto_0

    .line 231
    .end local v2    # "horizontalLayout":Landroid/widget/LinearLayout;
    :cond_0
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v7

    const v8, 0x7f080129

    invoke-virtual {v7, v8}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v7, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_1

    .line 232
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->ParsTextView(Landroid/util/JsonReader;)Landroid/widget/TextView;

    move-result-object v4

    .line 233
    .local v4, "textView":Landroid/widget/TextView;
    invoke-virtual {v5, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto :goto_0

    .line 234
    .end local v4    # "textView":Landroid/widget/TextView;
    :cond_1
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v7

    const v8, 0x7f080115

    invoke-virtual {v7, v8}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v7, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_2

    .line 235
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->ParsEditText(Landroid/util/JsonReader;)Landroid/widget/EditText;

    move-result-object v1

    .line 236
    .local v1, "editText":Landroid/widget/EditText;
    invoke-virtual {v5, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto :goto_0

    .line 237
    .end local v1    # "editText":Landroid/widget/EditText;
    :cond_2
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v7

    const v8, 0x7f080112

    invoke-virtual {v7, v8}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v7, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_3

    .line 238
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->ParsCheckBox(Landroid/util/JsonReader;)Landroid/widget/CheckBox;

    move-result-object v3

    .line 239
    .local v3, "parsCheckBox":Landroid/widget/CheckBox;
    invoke-virtual {v5, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto/16 :goto_0

    .line 240
    .end local v3    # "parsCheckBox":Landroid/widget/CheckBox;
    :cond_3
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v7

    const v8, 0x7f080125

    invoke-virtual {v7, v8}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v7, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_4

    .line 241
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->ParSpinner(Landroid/util/JsonReader;)Landroid/widget/Spinner;

    move-result-object v0

    .line 242
    .local v0, "Spinner":Landroid/widget/Spinner;
    invoke-virtual {v5, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto/16 :goto_0

    .line 244
    .end local v0    # "Spinner":Landroid/widget/Spinner;
    :cond_4
    invoke-virtual {p1}, Landroid/util/JsonReader;->skipValue()V

    .line 245
    iget-object v7, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v8, "ParMainLayout\u6ca1\u6709\u6b64\u8282\u70b9"

    invoke-virtual {v7, v8}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    goto/16 :goto_0

    .line 248
    .end local v6    # "widgetName":Ljava/lang/String;
    :cond_5
    invoke-virtual {p1}, Landroid/util/JsonReader;->endObject()V

    .line 249
    return-object v5
.end method

.method private ParSpinner(Landroid/util/JsonReader;)Landroid/widget/Spinner;
    .locals 12
    .param p1, "reader"    # Landroid/util/JsonReader;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v11, -0x2

    .line 514
    iget-object v9, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v10, "\u5f00\u59cbSpinner\u8282\u70b9\u89e3\u6790"

    invoke-virtual {v9, v10}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 515
    new-instance v8, Landroid/widget/Spinner;

    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v9

    invoke-direct {v8, v9}, Landroid/widget/Spinner;-><init>(Landroid/content/Context;)V

    .line 516
    .local v8, "spinner":Landroid/widget/Spinner;
    new-instance v5, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v5, v11, v11}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 517
    .local v5, "layoutParams":Landroid/widget/LinearLayout$LayoutParams;
    invoke-virtual {v8, v5}, Landroid/widget/Spinner;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 518
    invoke-virtual {p1}, Landroid/util/JsonReader;->beginObject()V

    .line 519
    :goto_0
    invoke-virtual {p1}, Landroid/util/JsonReader;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_4

    .line 520
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 521
    .local v1, "attributeName":Ljava/lang/String;
    iget-object v9, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "Spinner\u8282\u70b9>>>"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 522
    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    .line 523
    .local v4, "itemList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v9

    const v10, 0x7f08011d

    invoke-virtual {v9, v10}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_0

    .line 524
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v6

    .line 526
    .local v6, "name":Ljava/lang/String;
    invoke-virtual {v8, v6}, Landroid/widget/Spinner;->setTag(Ljava/lang/Object;)V

    goto :goto_0

    .line 527
    .end local v6    # "name":Ljava/lang/String;
    :cond_0
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v9

    const v10, 0x7f080127

    invoke-virtual {v9, v10}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_2

    .line 529
    invoke-virtual {p1}, Landroid/util/JsonReader;->beginArray()V

    .line 530
    :goto_1
    invoke-virtual {p1}, Landroid/util/JsonReader;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_1

    .line 531
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v3

    .line 533
    .local v3, "item":Ljava/lang/String;
    invoke-virtual {v4, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .line 535
    .end local v3    # "item":Ljava/lang/String;
    :cond_1
    invoke-virtual {p1}, Landroid/util/JsonReader;->endArray()V

    .line 538
    new-instance v0, Landroid/widget/ArrayAdapter;

    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v9

    const v10, 0x1090008

    invoke-direct {v0, v9, v10, v4}, Landroid/widget/ArrayAdapter;-><init>(Landroid/content/Context;ILjava/util/List;)V

    .line 539
    .local v0, "arrayAdapter":Landroid/widget/ArrayAdapter;, "Landroid/widget/ArrayAdapter<Ljava/lang/String;>;"
    const v9, 0x1090009

    invoke-virtual {v0, v9}, Landroid/widget/ArrayAdapter;->setDropDownViewResource(I)V

    .line 541
    invoke-virtual {v8, v0}, Landroid/widget/Spinner;->setAdapter(Landroid/widget/SpinnerAdapter;)V

    goto :goto_0

    .line 543
    .end local v0    # "arrayAdapter":Landroid/widget/ArrayAdapter;, "Landroid/widget/ArrayAdapter<Ljava/lang/String;>;"
    :cond_2
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v9

    const v10, 0x7f080126

    invoke-virtual {v9, v10}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_3

    .line 544
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v7

    .line 546
    .local v7, "position":I
    const/4 v9, 0x1

    :try_start_0
    invoke-virtual {v8, v7, v9}, Landroid/widget/Spinner;->setSelection(IZ)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_0

    .line 547
    :catch_0
    move-exception v2

    .line 548
    .local v2, "e":Ljava/lang/Exception;
    const/4 v9, 0x0

    invoke-virtual {v8, v9}, Landroid/widget/Spinner;->setSelection(I)V

    goto/16 :goto_0

    .line 551
    .end local v2    # "e":Ljava/lang/Exception;
    .end local v7    # "position":I
    :cond_3
    iget-object v9, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v10, "ParSpinner\u6ca1\u6709\u6b64\u8282\u70b9"

    invoke-virtual {v9, v10}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 552
    invoke-virtual {p1}, Landroid/util/JsonReader;->skipValue()V

    goto/16 :goto_0

    .line 555
    .end local v1    # "attributeName":Ljava/lang/String;
    .end local v4    # "itemList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    :cond_4
    invoke-virtual {p1}, Landroid/util/JsonReader;->endObject()V

    .line 556
    iget-object v9, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mArrayListSpinner:Ljava/util/ArrayList;

    invoke-virtual {v9, v8}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 557
    return-object v8
.end method

.method private ParsCheckBox(Landroid/util/JsonReader;)Landroid/widget/CheckBox;
    .locals 13
    .param p1, "reader"    # Landroid/util/JsonReader;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const v12, 0x7f0c000b

    const/4 v11, -0x2

    .line 446
    iget-object v9, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v10, "\u5f00\u59cbCheckBox\u8282\u70b9\u89e3\u6790"

    invoke-virtual {v9, v10}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 447
    new-instance v1, Landroid/widget/CheckBox;

    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v9

    invoke-direct {v1, v9}, Landroid/widget/CheckBox;-><init>(Landroid/content/Context;)V

    .line 448
    .local v1, "checkBox":Landroid/widget/CheckBox;
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v4, v11, v11}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 449
    .local v4, "layoutParams":Landroid/widget/LinearLayout$LayoutParams;
    invoke-virtual {v1, v4}, Landroid/widget/CheckBox;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 450
    const v9, 0x7f0c000a

    invoke-direct {p0, v9}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getInteger(I)I

    move-result v9

    int-to-float v9, v9

    invoke-virtual {v1, v9}, Landroid/widget/CheckBox;->setTextSize(F)V

    .line 452
    invoke-virtual {p1}, Landroid/util/JsonReader;->beginObject()V

    .line 453
    :cond_0
    :goto_0
    invoke-virtual {p1}, Landroid/util/JsonReader;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_9

    .line 454
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v0

    .line 455
    .local v0, "attributeName":Ljava/lang/String;
    iget-object v9, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "CheckBox\u8282\u70b9>>>"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 456
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v9

    const v10, 0x7f08011d

    invoke-virtual {v9, v10}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_1

    .line 457
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v5

    .line 459
    .local v5, "name":Ljava/lang/String;
    invoke-virtual {v1, v5}, Landroid/widget/CheckBox;->setTag(Ljava/lang/Object;)V

    goto :goto_0

    .line 460
    .end local v5    # "name":Ljava/lang/String;
    :cond_1
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v9

    const v10, 0x7f080114

    invoke-virtual {v9, v10}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_2

    .line 461
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v2

    .line 463
    .local v2, "content":Ljava/lang/String;
    invoke-virtual {v1, v2}, Landroid/widget/CheckBox;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 464
    .end local v2    # "content":Ljava/lang/String;
    :cond_2
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v9

    const v10, 0x7f080113

    invoke-virtual {v9, v10}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_4

    .line 465
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextBoolean()Z

    move-result v6

    .line 467
    .local v6, "state":Z
    if-eqz v6, :cond_3

    .line 468
    const/4 v9, 0x1

    invoke-virtual {v1, v9}, Landroid/widget/CheckBox;->setChecked(Z)V

    goto :goto_0

    .line 470
    :cond_3
    const/4 v9, 0x0

    invoke-virtual {v1, v9}, Landroid/widget/CheckBox;->setChecked(Z)V

    goto :goto_0

    .line 472
    .end local v6    # "state":Z
    :cond_4
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v9

    const v10, 0x7f080128

    invoke-virtual {v9, v10}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_6

    .line 473
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v7

    .line 475
    .local v7, "textSize":I
    invoke-direct {p0, v12}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getInteger(I)I

    move-result v9

    if-le v7, v9, :cond_5

    .line 476
    int-to-float v9, v7

    invoke-virtual {v1, v9}, Landroid/widget/CheckBox;->setTextSize(F)V

    goto/16 :goto_0

    .line 477
    :cond_5
    const v9, 0x7f0c0009

    invoke-direct {p0, v9}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getInteger(I)I

    move-result v9

    if-eq v7, v9, :cond_0

    .line 478
    invoke-direct {p0, v12}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getInteger(I)I

    move-result v9

    int-to-float v9, v9

    invoke-virtual {v1, v9}, Landroid/widget/CheckBox;->setTextSize(F)V

    goto/16 :goto_0

    .line 480
    .end local v7    # "textSize":I
    :cond_6
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v9

    const v10, 0x7f08011a

    invoke-virtual {v9, v10}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_7

    .line 481
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v3

    .line 483
    .local v3, "height":I
    const v9, 0x7f0c0007

    invoke-direct {p0, v9}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getInteger(I)I

    move-result v9

    if-le v3, v9, :cond_0

    .line 484
    invoke-virtual {v1, v3}, Landroid/widget/CheckBox;->setHeight(I)V

    goto/16 :goto_0

    .line 486
    .end local v3    # "height":I
    :cond_7
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v9

    const v10, 0x7f08011b

    invoke-virtual {v9, v10}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_8

    .line 487
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v8

    .line 489
    .local v8, "width":I
    const v9, 0x7f0c0008

    invoke-direct {p0, v9}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getInteger(I)I

    move-result v9

    if-le v8, v9, :cond_0

    .line 490
    invoke-virtual {v1, v8}, Landroid/widget/CheckBox;->setWidth(I)V

    goto/16 :goto_0

    .line 495
    .end local v8    # "width":I
    :cond_8
    iget-object v9, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v10, "ParsCheckBox\u6ca1\u6709\u6b64\u8282\u70b9"

    invoke-virtual {v9, v10}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 496
    invoke-virtual {p1}, Landroid/util/JsonReader;->skipValue()V

    goto/16 :goto_0

    .line 499
    .end local v0    # "attributeName":Ljava/lang/String;
    :cond_9
    iget-object v9, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mArrayListCheckBox:Ljava/util/ArrayList;

    invoke-virtual {v9, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 500
    invoke-virtual {p1}, Landroid/util/JsonReader;->endObject()V

    .line 501
    return-object v1
.end method

.method private ParsEditText(Landroid/util/JsonReader;)Landroid/widget/EditText;
    .locals 17
    .param p1, "reader"    # Landroid/util/JsonReader;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 365
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v15, "\u5f00\u59cbEditText\u89e3\u6790"

    invoke-virtual {v14, v15}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 366
    new-instance v4, Landroid/widget/EditText;

    invoke-virtual/range {p0 .. p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v14

    invoke-direct {v4, v14}, Landroid/widget/EditText;-><init>(Landroid/content/Context;)V

    .line 367
    .local v4, "editText":Landroid/widget/EditText;
    new-instance v8, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v14, -0x2

    const/4 v15, -0x2

    invoke-direct {v8, v14, v15}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 368
    .local v8, "layoutParams":Landroid/widget/LinearLayout$LayoutParams;
    invoke-virtual {v4, v8}, Landroid/widget/EditText;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 369
    const v14, 0x7f0c000a

    move-object/from16 v0, p0

    invoke-direct {v0, v14}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getInteger(I)I

    move-result v14

    int-to-float v14, v14

    invoke-virtual {v4, v14}, Landroid/widget/EditText;->setTextSize(F)V

    .line 371
    const/4 v14, 0x1

    invoke-virtual {v4, v14}, Landroid/widget/EditText;->setSingleLine(Z)V

    .line 372
    invoke-virtual/range {p1 .. p1}, Landroid/util/JsonReader;->beginObject()V

    .line 373
    :cond_0
    :goto_0
    invoke-virtual/range {p1 .. p1}, Landroid/util/JsonReader;->hasNext()Z

    move-result v14

    if-eqz v14, :cond_a

    .line 374
    invoke-virtual/range {p1 .. p1}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 375
    .local v1, "attributeName":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, "EditText\u8282\u70b9>>>"

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v14, v15}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 376
    invoke-virtual/range {p0 .. p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v14

    const v15, 0x7f08011d

    invoke-virtual {v14, v15}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v14, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v14

    if-eqz v14, :cond_1

    .line 377
    invoke-virtual/range {p1 .. p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v10

    .line 379
    .local v10, "name":Ljava/lang/String;
    invoke-virtual {v4, v10}, Landroid/widget/EditText;->setTag(Ljava/lang/Object;)V

    goto :goto_0

    .line 380
    .end local v10    # "name":Ljava/lang/String;
    :cond_1
    invoke-virtual/range {p0 .. p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v14

    const v15, 0x7f080117

    invoke-virtual {v14, v15}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v14, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v14

    if-eqz v14, :cond_2

    .line 381
    invoke-virtual/range {p1 .. p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v7

    .line 383
    .local v7, "hintContent":Ljava/lang/String;
    invoke-virtual {v4, v7}, Landroid/widget/EditText;->setHint(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 384
    .end local v7    # "hintContent":Ljava/lang/String;
    :cond_2
    invoke-virtual/range {p0 .. p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v14

    const v15, 0x7f080128

    invoke-virtual {v14, v15}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v14, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v14

    if-eqz v14, :cond_4

    .line 385
    invoke-virtual/range {p1 .. p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v12

    .line 387
    .local v12, "textSize":I
    const v14, 0x7f0c000b

    move-object/from16 v0, p0

    invoke-direct {v0, v14}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getInteger(I)I

    move-result v14

    if-le v12, v14, :cond_3

    .line 388
    int-to-float v14, v12

    invoke-virtual {v4, v14}, Landroid/widget/EditText;->setTextSize(F)V

    goto :goto_0

    .line 389
    :cond_3
    const v14, 0x7f0c0009

    move-object/from16 v0, p0

    invoke-direct {v0, v14}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getInteger(I)I

    move-result v14

    if-eq v12, v14, :cond_0

    .line 390
    const v14, 0x7f0c000b

    move-object/from16 v0, p0

    invoke-direct {v0, v14}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getInteger(I)I

    move-result v14

    int-to-float v14, v14

    invoke-virtual {v4, v14}, Landroid/widget/EditText;->setTextSize(F)V

    goto/16 :goto_0

    .line 392
    .end local v12    # "textSize":I
    :cond_4
    invoke-virtual/range {p0 .. p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v14

    const v15, 0x7f08011a

    invoke-virtual {v14, v15}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v14, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v14

    if-eqz v14, :cond_5

    .line 393
    invoke-virtual/range {p1 .. p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v6

    .line 395
    .local v6, "height":I
    const v14, 0x7f0c0007

    move-object/from16 v0, p0

    invoke-direct {v0, v14}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getInteger(I)I

    move-result v14

    if-le v6, v14, :cond_0

    .line 396
    invoke-virtual {v4, v6}, Landroid/widget/EditText;->setHeight(I)V

    goto/16 :goto_0

    .line 398
    .end local v6    # "height":I
    :cond_5
    invoke-virtual/range {p0 .. p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v14

    const v15, 0x7f08011b

    invoke-virtual {v14, v15}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v14, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v14

    if-eqz v14, :cond_6

    .line 399
    invoke-virtual/range {p1 .. p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v13

    .line 401
    .local v13, "width":I
    const v14, 0x7f0c0008

    move-object/from16 v0, p0

    invoke-direct {v0, v14}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getInteger(I)I

    move-result v14

    if-le v13, v14, :cond_0

    .line 402
    invoke-virtual {v4, v13}, Landroid/widget/EditText;->setWidth(I)V

    goto/16 :goto_0

    .line 404
    .end local v13    # "width":I
    :cond_6
    invoke-virtual/range {p0 .. p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v14

    const v15, 0x7f080119

    invoke-virtual {v14, v15}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v14, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v14

    if-eqz v14, :cond_7

    .line 405
    invoke-virtual/range {p1 .. p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v9

    .line 407
    .local v9, "maxLenth":I
    if-lez v9, :cond_0

    .line 408
    const/4 v14, 0x1

    new-array v5, v14, [Landroid/text/InputFilter;

    .line 409
    .local v5, "filters":[Landroid/text/InputFilter;
    const/4 v14, 0x0

    new-instance v15, Landroid/text/InputFilter$LengthFilter;

    invoke-direct {v15, v9}, Landroid/text/InputFilter$LengthFilter;-><init>(I)V

    aput-object v15, v5, v14

    .line 410
    invoke-virtual {v4, v5}, Landroid/widget/EditText;->setFilters([Landroid/text/InputFilter;)V

    goto/16 :goto_0

    .line 412
    .end local v5    # "filters":[Landroid/text/InputFilter;
    .end local v9    # "maxLenth":I
    :cond_7
    invoke-virtual/range {p0 .. p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v14

    const v15, 0x7f080118

    invoke-virtual {v14, v15}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v14, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v14

    if-eqz v14, :cond_8

    .line 413
    const/4 v11, 0x0

    .line 415
    .local v11, "onlyNumber":Z
    :try_start_0
    invoke-virtual/range {p1 .. p1}, Landroid/util/JsonReader;->nextBoolean()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v11

    .line 420
    :goto_1
    if-eqz v11, :cond_0

    .line 421
    const/4 v14, 0x2

    invoke-virtual {v4, v14}, Landroid/widget/EditText;->setInputType(I)V

    goto/16 :goto_0

    .line 416
    :catch_0
    move-exception v3

    .line 417
    .local v3, "e":Ljava/lang/Exception;
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v15, "EditText\u89e3\u6790\u5f02\u5e38\u4e86"

    invoke-virtual {v14, v15}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    goto :goto_1

    .line 423
    .end local v3    # "e":Ljava/lang/Exception;
    .end local v11    # "onlyNumber":Z
    :cond_8
    invoke-virtual/range {p0 .. p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v14

    const v15, 0x7f080116

    invoke-virtual {v14, v15}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v14, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v14

    if-eqz v14, :cond_9

    .line 424
    invoke-virtual/range {p1 .. p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v2

    .line 425
    .local v2, "defaultText":Ljava/lang/String;
    invoke-virtual {v4, v2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    goto/16 :goto_0

    .line 427
    .end local v2    # "defaultText":Ljava/lang/String;
    :cond_9
    invoke-virtual/range {p1 .. p1}, Landroid/util/JsonReader;->skipValue()V

    .line 428
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v15, "ParsEditText\u6ca1\u6709\u6b64\u8282\u70b9"

    invoke-virtual {v14, v15}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    goto/16 :goto_0

    .line 431
    .end local v1    # "attributeName":Ljava/lang/String;
    :cond_a
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mArrayListEditText:Ljava/util/ArrayList;

    invoke-virtual {v14, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 432
    invoke-virtual/range {p1 .. p1}, Landroid/util/JsonReader;->endObject()V

    .line 433
    return-object v4
.end method

.method private ParsHorizontalLayout(Landroid/util/JsonReader;)Landroid/widget/LinearLayout;
    .locals 10
    .param p1, "reader"    # Landroid/util/JsonReader;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v9, -0x2

    .line 262
    iget-object v7, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v8, "\u5f00\u59cbLinearLayout\u89e3\u6790"

    invoke-virtual {v7, v8}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 263
    new-instance v2, Landroid/widget/LinearLayout;

    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v7

    invoke-direct {v2, v7}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 264
    .local v2, "horizontalLayout":Landroid/widget/LinearLayout;
    const/4 v7, 0x0

    invoke-virtual {v2, v7}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 265
    const/16 v7, 0x10

    invoke-virtual {v2, v7}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 266
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v3, v9, v9}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 268
    .local v3, "layoutParams":Landroid/widget/LinearLayout$LayoutParams;
    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 269
    invoke-virtual {p1}, Landroid/util/JsonReader;->beginObject()V

    .line 270
    :goto_0
    invoke-virtual {p1}, Landroid/util/JsonReader;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_5

    .line 271
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v6

    .line 272
    .local v6, "widgetName":Ljava/lang/String;
    iget-object v7, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "\u5f00\u59cbLinearLayout\u89e3\u6790"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 273
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v7

    const v8, 0x7f08011c

    invoke-virtual {v7, v8}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v7, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_0

    .line 274
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->ParsHorizontalLayout(Landroid/util/JsonReader;)Landroid/widget/LinearLayout;

    move-result-object v7

    invoke-virtual {v2, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto :goto_0

    .line 275
    :cond_0
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v7

    const v8, 0x7f080129

    invoke-virtual {v7, v8}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v7, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_1

    .line 276
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->ParsTextView(Landroid/util/JsonReader;)Landroid/widget/TextView;

    move-result-object v5

    .line 277
    .local v5, "textView":Landroid/widget/TextView;
    invoke-virtual {v2, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto :goto_0

    .line 278
    .end local v5    # "textView":Landroid/widget/TextView;
    :cond_1
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v7

    const v8, 0x7f080115

    invoke-virtual {v7, v8}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v7, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_2

    .line 279
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->ParsEditText(Landroid/util/JsonReader;)Landroid/widget/EditText;

    move-result-object v1

    .line 280
    .local v1, "editText":Landroid/widget/EditText;
    invoke-virtual {v2, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto :goto_0

    .line 281
    .end local v1    # "editText":Landroid/widget/EditText;
    :cond_2
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v7

    const v8, 0x7f080112

    invoke-virtual {v7, v8}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v7, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_3

    .line 282
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->ParsCheckBox(Landroid/util/JsonReader;)Landroid/widget/CheckBox;

    move-result-object v4

    .line 283
    .local v4, "parsCheckBox":Landroid/widget/CheckBox;
    invoke-virtual {v2, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto/16 :goto_0

    .line 284
    .end local v4    # "parsCheckBox":Landroid/widget/CheckBox;
    :cond_3
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v7

    const v8, 0x7f080125

    invoke-virtual {v7, v8}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v7, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_4

    .line 285
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->ParSpinner(Landroid/util/JsonReader;)Landroid/widget/Spinner;

    move-result-object v0

    .line 286
    .local v0, "Spinner":Landroid/widget/Spinner;
    invoke-virtual {v2, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto/16 :goto_0

    .line 288
    .end local v0    # "Spinner":Landroid/widget/Spinner;
    :cond_4
    iget-object v7, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v8, "ParsHorizontalLayout\u6ca1\u6709\u6b64\u8282\u70b9"

    invoke-virtual {v7, v8}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 289
    invoke-virtual {p1}, Landroid/util/JsonReader;->skipValue()V

    goto/16 :goto_0

    .line 292
    .end local v6    # "widgetName":Ljava/lang/String;
    :cond_5
    invoke-virtual {p1}, Landroid/util/JsonReader;->endObject()V

    .line 293
    return-object v2
.end method

.method private ParsTextView(Landroid/util/JsonReader;)Landroid/widget/TextView;
    .locals 12
    .param p1, "reader"    # Landroid/util/JsonReader;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const v11, 0x7f0c000b

    const/4 v10, -0x2

    .line 306
    iget-object v8, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v9, "\u5f00\u59cbTextView\u89e3\u6790"

    invoke-virtual {v8, v9}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 307
    new-instance v6, Landroid/widget/TextView;

    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v8

    invoke-direct {v6, v8}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 308
    .local v6, "textView":Landroid/widget/TextView;
    const/16 v8, 0x11

    invoke-virtual {v6, v8}, Landroid/widget/TextView;->setGravity(I)V

    .line 309
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v3, v10, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 310
    .local v3, "layoutParams":Landroid/widget/LinearLayout$LayoutParams;
    invoke-virtual {v6, v3}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 311
    const v8, 0x7f0c000a

    invoke-direct {p0, v8}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getInteger(I)I

    move-result v8

    int-to-float v8, v8

    invoke-virtual {v6, v8}, Landroid/widget/TextView;->setTextSize(F)V

    .line 313
    invoke-virtual {p1}, Landroid/util/JsonReader;->beginObject()V

    .line 314
    :cond_0
    :goto_0
    invoke-virtual {p1}, Landroid/util/JsonReader;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_7

    .line 315
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v0

    .line 316
    .local v0, "attributeName":Ljava/lang/String;
    iget-object v8, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "TextView\u8282\u70b9>>>"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 317
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v8

    const v9, 0x7f08011d

    invoke-virtual {v8, v9}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_1

    .line 318
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v4

    .line 320
    .local v4, "name":Ljava/lang/String;
    invoke-virtual {v6, v4}, Landroid/widget/TextView;->setTag(Ljava/lang/Object;)V

    goto :goto_0

    .line 321
    .end local v4    # "name":Ljava/lang/String;
    :cond_1
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v8

    const v9, 0x7f08012a

    invoke-virtual {v8, v9}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_2

    .line 322
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    .line 324
    .local v1, "content":Ljava/lang/String;
    invoke-virtual {v6, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 325
    .end local v1    # "content":Ljava/lang/String;
    :cond_2
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v8

    const v9, 0x7f080128

    invoke-virtual {v8, v9}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_4

    .line 326
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v5

    .line 328
    .local v5, "textSize":I
    invoke-direct {p0, v11}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getInteger(I)I

    move-result v8

    if-le v5, v8, :cond_3

    .line 329
    int-to-float v8, v5

    invoke-virtual {v6, v8}, Landroid/widget/TextView;->setTextSize(F)V

    goto :goto_0

    .line 330
    :cond_3
    const v8, 0x7f0c0009

    invoke-direct {p0, v8}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getInteger(I)I

    move-result v8

    if-eq v5, v8, :cond_0

    .line 331
    invoke-direct {p0, v11}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getInteger(I)I

    move-result v8

    int-to-float v8, v8

    invoke-virtual {v6, v8}, Landroid/widget/TextView;->setTextSize(F)V

    goto/16 :goto_0

    .line 333
    .end local v5    # "textSize":I
    :cond_4
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v8

    const v9, 0x7f08011a

    invoke-virtual {v8, v9}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_5

    .line 334
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v2

    .line 336
    .local v2, "height":I
    const v8, 0x7f0c0007

    invoke-direct {p0, v8}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getInteger(I)I

    move-result v8

    if-le v2, v8, :cond_0

    .line 337
    invoke-virtual {v6, v2}, Landroid/widget/TextView;->setHeight(I)V

    goto/16 :goto_0

    .line 339
    .end local v2    # "height":I
    :cond_5
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v8

    const v9, 0x7f08011b

    invoke-virtual {v8, v9}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_6

    .line 340
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v7

    .line 342
    .local v7, "width":I
    const v8, 0x7f0c0008

    invoke-direct {p0, v8}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getInteger(I)I

    move-result v8

    if-le v7, v8, :cond_0

    .line 343
    invoke-virtual {v6, v7}, Landroid/widget/TextView;->setWidth(I)V

    goto/16 :goto_0

    .line 346
    .end local v7    # "width":I
    :cond_6
    invoke-virtual {p1}, Landroid/util/JsonReader;->skipValue()V

    .line 347
    iget-object v8, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v9, "ParsTextView\u6ca1\u6709\u6b64\u8282\u70b9"

    invoke-virtual {v8, v9}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    goto/16 :goto_0

    .line 350
    .end local v0    # "attributeName":Ljava/lang/String;
    :cond_7
    invoke-virtual {p1}, Landroid/util/JsonReader;->endObject()V

    .line 352
    return-object v6
.end method

.method private ParsUIFile(Ljava/lang/String;)Landroid/widget/LinearLayout;
    .locals 7
    .param p1, "JsonUI"    # Ljava/lang/String;

    .prologue
    .line 193
    new-instance v2, Landroid/util/JsonReader;

    new-instance v4, Ljava/io/StringReader;

    invoke-direct {v4, p1}, Ljava/io/StringReader;-><init>(Ljava/lang/String;)V

    invoke-direct {v2, v4}, Landroid/util/JsonReader;-><init>(Ljava/io/Reader;)V

    .line 194
    .local v2, "reader":Landroid/util/JsonReader;
    new-instance v3, Landroid/widget/LinearLayout;

    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-direct {v3, v4}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 196
    .local v3, "verticalLayout":Landroid/widget/LinearLayout;
    :try_start_0
    invoke-virtual {v2}, Landroid/util/JsonReader;->beginObject()V

    .line 197
    :goto_0
    invoke-virtual {v2}, Landroid/util/JsonReader;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_1

    .line 198
    invoke-virtual {v2}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v0

    .line 199
    .local v0, "activityName":Ljava/lang/String;
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v4

    const v5, 0x7f080110

    invoke-virtual {v4, v5}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 200
    invoke-direct {p0, v2}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->ParMainLayout(Landroid/util/JsonReader;)Landroid/widget/LinearLayout;

    move-result-object v3

    goto :goto_0

    .line 202
    :cond_0
    invoke-virtual {v2}, Landroid/util/JsonReader;->skipValue()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 207
    .end local v0    # "activityName":Ljava/lang/String;
    :catch_0
    move-exception v1

    .line 208
    .local v1, "e":Ljava/lang/Exception;
    iget-object v4, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "ParsUIFile"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 211
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_1
    return-object v3

    .line 205
    :cond_1
    :try_start_1
    invoke-virtual {v2}, Landroid/util/JsonReader;->endObject()V

    .line 206
    invoke-virtual {v2}, Landroid/util/JsonReader;->close()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1
.end method

.method static synthetic access$000(Lcom/cyjh/elfin/dialog/ScriptUIDialog;FFIZ)V
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/dialog/ScriptUIDialog;
    .param p1, "x1"    # F
    .param p2, "x2"    # F
    .param p3, "x3"    # I
    .param p4, "x4"    # Z

    .prologue
    .line 45
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->convertScreen(FFIZ)V

    return-void
.end method

.method static synthetic access$100(Lcom/cyjh/elfin/dialog/ScriptUIDialog;IZ)V
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/dialog/ScriptUIDialog;
    .param p1, "x1"    # I
    .param p2, "x2"    # Z

    .prologue
    .line 45
    invoke-direct {p0, p1, p2}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->initUIFile(IZ)V

    return-void
.end method

.method private convertScreen(FFIZ)V
    .locals 7
    .param p1, "width"    # F
    .param p2, "height"    # F
    .param p3, "flag"    # I
    .param p4, "isCreatedFirst"    # Z

    .prologue
    .line 115
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->isShowing()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 116
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->dismiss()V

    .line 117
    new-instance v6, Landroid/os/Handler;

    invoke-direct {v6}, Landroid/os/Handler;-><init>()V

    new-instance v0, Lcom/cyjh/elfin/dialog/ScriptUIDialog$2;

    move-object v1, p0

    move v2, p1

    move v3, p2

    move v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lcom/cyjh/elfin/dialog/ScriptUIDialog$2;-><init>(Lcom/cyjh/elfin/dialog/ScriptUIDialog;FFIZ)V

    const-wide/16 v2, 0x1f4

    invoke-virtual {v6, v0, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 126
    :cond_0
    return-void
.end method

.method private generateUIConfigFile(Ljava/io/File;)V
    .locals 8
    .param p1, "UIConfigFile"    # Ljava/io/File;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 610
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/io/File;->isDirectory()Z

    move-result v4

    if-eqz v4, :cond_1

    .line 630
    :cond_0
    :goto_0
    return-void

    .line 613
    :cond_1
    iget-object v4, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget-object v4, v4, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v4}, Lcom/cyjh/elfin/entity/Script;->getUipFile()Ljava/io/File;

    move-result-object v4

    invoke-virtual {v4}, Ljava/io/File;->exists()Z

    move-result v4

    if-eqz v4, :cond_2

    iget-object v4, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget-object v4, v4, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v4}, Lcom/cyjh/elfin/entity/Script;->getUipFile()Ljava/io/File;

    move-result-object v4

    invoke-virtual {v4}, Ljava/io/File;->length()J

    move-result-wide v4

    const-wide/16 v6, 0x0

    cmp-long v4, v4, v6

    if-lez v4, :cond_2

    .line 615
    iget-object v4, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget-object v4, v4, Lcom/cyjh/elfin/AppContext;->mUipHelper:Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;

    iget-object v5, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget-object v5, v5, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v5}, Lcom/cyjh/elfin/entity/Script;->getCfgFile()Ljava/io/File;

    move-result-object v5

    invoke-virtual {v5}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->saveToConfigFile(Ljava/lang/String;)V

    goto :goto_0

    .line 619
    :cond_2
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 620
    .local v2, "optionJsonObject":Lorg/json/JSONObject;
    iget-object v4, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mArrayListCheckBox:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_1
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_3

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/widget/CheckBox;

    .line 621
    .local v0, "checkBox":Landroid/widget/CheckBox;
    invoke-virtual {v0}, Landroid/widget/CheckBox;->getTag()Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v0}, Landroid/widget/CheckBox;->isChecked()Z

    move-result v6

    invoke-virtual {v2, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    goto :goto_1

    .line 623
    .end local v0    # "checkBox":Landroid/widget/CheckBox;
    :cond_3
    iget-object v4, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mArrayListSpinner:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_2
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_4

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/widget/Spinner;

    .line 624
    .local v3, "spinner":Landroid/widget/Spinner;
    invoke-virtual {v3}, Landroid/widget/Spinner;->getTag()Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3}, Landroid/widget/Spinner;->getSelectedItemPosition()I

    move-result v6

    invoke-virtual {v2, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    goto :goto_2

    .line 626
    .end local v3    # "spinner":Landroid/widget/Spinner;
    :cond_4
    iget-object v4, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mArrayListEditText:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_3
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_5

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/widget/EditText;

    .line 627
    .local v1, "editText":Landroid/widget/EditText;
    invoke-virtual {v1}, Landroid/widget/EditText;->getTag()Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v2, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_3

    .line 629
    .end local v1    # "editText":Landroid/widget/EditText;
    :cond_5
    invoke-virtual {v2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v4

    const-string v5, "UTF-8"

    invoke-static {p1, v4, v5}, Lorg/apache/commons/io/FileUtils;->writeStringToFile(Ljava/io/File;Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_0
.end method

.method private getInteger(I)I
    .locals 1
    .param p1, "resId"    # I

    .prologue
    .line 633
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v0

    return v0
.end method

.method private initEvent()V
    .locals 2

    .prologue
    .line 102
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    new-instance v1, Lcom/cyjh/elfin/dialog/ScriptUIDialog$1;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog$1;-><init>(Lcom/cyjh/elfin/dialog/ScriptUIDialog;)V

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/AppContext;->setScreenConversion(Lcom/cyjh/elfin/AppContext$ScreenOrientationConversion;)V

    .line 112
    return-void
.end method

.method private initUIFile(IZ)V
    .locals 11
    .param p1, "flag"    # I
    .param p2, "isCreateFirst"    # Z

    .prologue
    const/4 v10, 0x1

    .line 132
    new-instance v3, Lcom/cyjh/mqm/MiscUtilities;

    invoke-direct {v3}, Lcom/cyjh/mqm/MiscUtilities;-><init>()V

    .line 133
    .local v3, "miscUtilities":Lcom/cyjh/mqm/MiscUtilities;
    const/4 v2, 0x0

    .line 134
    .local v2, "linearLayout":Landroid/widget/LinearLayout;
    iget-object v6, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget-object v6, v6, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v6}, Lcom/cyjh/elfin/entity/Script;->getUipFile()Ljava/io/File;

    move-result-object v6

    invoke-virtual {v6}, Ljava/io/File;->exists()Z

    move-result v6

    if-eqz v6, :cond_2

    iget-object v6, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget-object v6, v6, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v6}, Lcom/cyjh/elfin/entity/Script;->getUipFile()Ljava/io/File;

    move-result-object v6

    invoke-virtual {v6}, Ljava/io/File;->length()J

    move-result-wide v6

    const-wide/16 v8, 0x0

    cmp-long v6, v6, v8

    if-lez v6, :cond_2

    .line 135
    iget-object v6, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget-object v6, v6, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v6}, Lcom/cyjh/elfin/entity/Script;->getUipFile()Ljava/io/File;

    move-result-object v6

    invoke-virtual {v6}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3, v6, v10}, Lcom/cyjh/mqm/MiscUtilities;->LoadUIFile(Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v0

    .line 136
    .local v0, "JsonUI":Ljava/lang/String;
    if-eqz p2, :cond_1

    .line 137
    iget-object v6, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget-object v6, v6, Lcom/cyjh/elfin/AppContext;->mUipHelper:Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;

    const/4 v7, 0x0

    invoke-virtual {v6, v0, v7}, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->parseLayoutFromJson(Ljava/lang/String;Lcom/cyjh/mobileanjian/ipc/uip/IUipJsonParser;)Landroid/widget/LinearLayout;

    move-result-object v2

    .line 138
    iget-object v6, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "isCreateFirst-----mAppContext.mUipHelper.parseLayoutFromJson"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 139
    iget-object v6, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mUipLinearLayoutUI:Landroid/widget/LinearLayout;

    invoke-virtual {v6}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 140
    iget-object v6, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mUipLinearLayoutUI:Landroid/widget/LinearLayout;

    invoke-virtual {v6, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 142
    :try_start_0
    iget-object v6, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget-object v6, v6, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v6}, Lcom/cyjh/elfin/entity/Script;->getCfgFile()Ljava/io/File;

    move-result-object v6

    invoke-direct {p0, v6}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->parseUIConfigFile(Ljava/io/File;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 185
    :cond_0
    :goto_0
    return-void

    .line 143
    :catch_0
    move-exception v1

    .line 144
    .local v1, "e":Lorg/json/JSONException;
    invoke-virtual {v1}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0

    .line 152
    .end local v1    # "e":Lorg/json/JSONException;
    :cond_1
    iget-object v6, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mUipLinearLayoutUI:Landroid/widget/LinearLayout;

    invoke-virtual {v6}, Landroid/widget/LinearLayout;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v4

    check-cast v4, Landroid/widget/LinearLayout$LayoutParams;

    .line 153
    .local v4, "params":Landroid/widget/LinearLayout$LayoutParams;
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v6

    invoke-static {v6}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getResolution(Landroid/content/Context;)Landroid/graphics/Point;

    move-result-object v6

    iget v6, v6, Landroid/graphics/Point;->x:I

    int-to-float v6, v6

    const v7, 0x3f666666    # 0.9f

    mul-float/2addr v6, v7

    float-to-int v6, v6

    iput v6, v4, Landroid/widget/LinearLayout$LayoutParams;->width:I

    .line 154
    iget-object v6, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mUipLinearLayoutUI:Landroid/widget/LinearLayout;

    invoke-virtual {v6, v4}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 155
    iget-object v6, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget-object v6, v6, Lcom/cyjh/elfin/AppContext;->mUipHelper:Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;

    invoke-virtual {v6, p1}, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->transform(I)Landroid/view/View;

    move-result-object v5

    .line 156
    .local v5, "view":Landroid/view/View;
    iget-object v6, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "isCreateFirst------mAppContext.mUipHelper.transform"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 157
    iget-object v6, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mUipLinearLayoutUI:Landroid/widget/LinearLayout;

    invoke-virtual {v6}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 158
    iget-object v6, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mUipLinearLayoutUI:Landroid/widget/LinearLayout;

    invoke-virtual {v6, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto :goto_0

    .line 162
    .end local v0    # "JsonUI":Ljava/lang/String;
    .end local v4    # "params":Landroid/widget/LinearLayout$LayoutParams;
    .end local v5    # "view":Landroid/view/View;
    :cond_2
    iget-object v6, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget-object v6, v6, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v6}, Lcom/cyjh/elfin/entity/Script;->getUiFile()Ljava/io/File;

    move-result-object v6

    invoke-virtual {v6}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3, v6, v10}, Lcom/cyjh/mqm/MiscUtilities;->LoadUIFile(Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v0

    .line 163
    .restart local v0    # "JsonUI":Ljava/lang/String;
    invoke-direct {p0, v0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->ParsUIFile(Ljava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v2

    .line 164
    invoke-virtual {v2}, Landroid/widget/LinearLayout;->getChildCount()I

    move-result v6

    if-lez v6, :cond_0

    .line 165
    iget-object v6, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mScrollViewUI:Landroid/widget/ScrollView;

    const/4 v7, 0x0

    invoke-virtual {v6, v7}, Landroid/widget/ScrollView;->removeViewAt(I)V

    .line 166
    iget-object v6, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mScrollViewUI:Landroid/widget/ScrollView;

    invoke-virtual {v6, v2}, Landroid/widget/ScrollView;->addView(Landroid/view/View;)V

    .line 168
    :try_start_1
    iget-object v6, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget-object v6, v6, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v6}, Lcom/cyjh/elfin/entity/Script;->getCfgFile()Ljava/io/File;

    move-result-object v6

    invoke-direct {p0, v6}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->parseUIConfigFile(Ljava/io/File;)V
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_2

    .line 173
    :goto_1
    :try_start_2
    iget-object v6, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget-object v6, v6, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v6}, Lcom/cyjh/elfin/entity/Script;->getCfgFile()Ljava/io/File;

    move-result-object v6

    invoke-direct {p0, v6}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->generateUIConfigFile(Ljava/io/File;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    goto/16 :goto_0

    .line 174
    :catch_1
    move-exception v1

    .line 175
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    goto/16 :goto_0

    .line 169
    .end local v1    # "e":Ljava/lang/Exception;
    :catch_2
    move-exception v1

    .line 170
    .local v1, "e":Lorg/json/JSONException;
    invoke-virtual {v1}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_1
.end method

.method private initView()V
    .locals 3

    .prologue
    .line 85
    const v1, 0x7f0f00c7

    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageView;

    iput-object v1, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mImageViewSetting:Landroid/widget/ImageView;

    .line 87
    const v1, 0x7f0f00cb

    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/Button;

    iput-object v1, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mButtonSave:Landroid/widget/Button;

    .line 89
    const v1, 0x7f0f00c9

    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ScrollView;

    iput-object v1, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mScrollViewUI:Landroid/widget/ScrollView;

    .line 91
    iget-object v1, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mImageViewSetting:Landroid/widget/ImageView;

    invoke-virtual {v1, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 93
    iget-object v1, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mButtonSave:Landroid/widget/Button;

    invoke-virtual {v1, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 95
    const v1, 0x7f0f00c8

    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/LinearLayout;

    iput-object v1, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mUipLinearLayoutUI:Landroid/widget/LinearLayout;

    .line 96
    iget-object v1, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mUipLinearLayoutUI:Landroid/widget/LinearLayout;

    invoke-virtual {v1}, Landroid/widget/LinearLayout;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout$LayoutParams;

    .line 97
    .local v0, "params":Landroid/widget/LinearLayout$LayoutParams;
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getResolution(Landroid/content/Context;)Landroid/graphics/Point;

    move-result-object v1

    iget v1, v1, Landroid/graphics/Point;->x:I

    int-to-float v1, v1

    const v2, 0x3f666666    # 0.9f

    mul-float/2addr v1, v2

    float-to-int v1, v1

    iput v1, v0, Landroid/widget/LinearLayout$LayoutParams;->width:I

    .line 98
    iget-object v1, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mUipLinearLayoutUI:Landroid/widget/LinearLayout;

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 99
    return-void
.end method

.method private parseUIConfigFile(Ljava/io/File;)V
    .locals 14
    .param p1, "UIConfigFile"    # Ljava/io/File;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .prologue
    .line 568
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result v10

    if-eqz v10, :cond_0

    invoke-virtual {p1}, Ljava/io/File;->isDirectory()Z

    move-result v10

    if-eqz v10, :cond_1

    .line 600
    :cond_0
    :goto_0
    return-void

    .line 571
    :cond_1
    iget-object v10, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget-object v10, v10, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v10}, Lcom/cyjh/elfin/entity/Script;->getUipFile()Ljava/io/File;

    move-result-object v10

    invoke-virtual {v10}, Ljava/io/File;->exists()Z

    move-result v10

    if-eqz v10, :cond_2

    iget-object v10, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget-object v10, v10, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v10}, Lcom/cyjh/elfin/entity/Script;->getUipFile()Ljava/io/File;

    move-result-object v10

    invoke-virtual {v10}, Ljava/io/File;->length()J

    move-result-wide v10

    const-wide/16 v12, 0x0

    cmp-long v10, v10, v12

    if-lez v10, :cond_2

    .line 573
    invoke-static {p1}, Lcom/cyjh/elfin/util/FileUtils;->readTextFile(Ljava/io/File;)Ljava/lang/String;

    move-result-object v4

    .line 574
    .local v4, "json":Ljava/lang/String;
    iget-object v10, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget-object v10, v10, Lcom/cyjh/elfin/AppContext;->mUipHelper:Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;

    invoke-virtual {v10, v4}, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->configViewFromJson(Ljava/lang/String;)V

    goto :goto_0

    .line 578
    .end local v4    # "json":Ljava/lang/String;
    :cond_2
    const/4 v4, 0x0

    .line 580
    .restart local v4    # "json":Ljava/lang/String;
    :try_start_0
    const-string v10, "UTF-8"

    invoke-static {p1, v10}, Lorg/apache/commons/io/FileUtils;->readFileToString(Ljava/io/File;Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v4

    .line 585
    :goto_1
    new-instance v6, Lorg/json/JSONObject;

    invoke-direct {v6, v4}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 586
    .local v6, "propObject":Lorg/json/JSONObject;
    iget-object v10, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "uiDialog:"

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 587
    iget-object v10, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mArrayListSpinner:Ljava/util/ArrayList;

    invoke-virtual {v10}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v10

    :goto_2
    invoke-interface {v10}, Ljava/util/Iterator;->hasNext()Z

    move-result v11

    if-eqz v11, :cond_3

    invoke-interface {v10}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Landroid/widget/Spinner;

    .line 588
    .local v7, "spinner":Landroid/widget/Spinner;
    invoke-virtual {v7}, Landroid/widget/Spinner;->getTag()Ljava/lang/Object;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v9

    .line 589
    .local v9, "tag":Ljava/lang/String;
    invoke-virtual {v6, v9}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v5

    .line 590
    .local v5, "position":I
    invoke-virtual {v7, v5}, Landroid/widget/Spinner;->setSelection(I)V

    goto :goto_2

    .line 581
    .end local v5    # "position":I
    .end local v6    # "propObject":Lorg/json/JSONObject;
    .end local v7    # "spinner":Landroid/widget/Spinner;
    .end local v9    # "tag":Ljava/lang/String;
    :catch_0
    move-exception v2

    .line 582
    .local v2, "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_1

    .line 592
    .end local v2    # "e":Ljava/io/IOException;
    .restart local v6    # "propObject":Lorg/json/JSONObject;
    :cond_3
    iget-object v10, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mArrayListCheckBox:Ljava/util/ArrayList;

    invoke-virtual {v10}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v10

    :goto_3
    invoke-interface {v10}, Ljava/util/Iterator;->hasNext()Z

    move-result v11

    if-eqz v11, :cond_4

    invoke-interface {v10}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/widget/CheckBox;

    .line 593
    .local v0, "checkBox":Landroid/widget/CheckBox;
    invoke-virtual {v0}, Landroid/widget/CheckBox;->getTag()Ljava/lang/Object;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v6, v11}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v1

    .line 594
    .local v1, "checked":Z
    invoke-virtual {v0, v1}, Landroid/widget/CheckBox;->setChecked(Z)V

    goto :goto_3

    .line 596
    .end local v0    # "checkBox":Landroid/widget/CheckBox;
    .end local v1    # "checked":Z
    :cond_4
    iget-object v10, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mArrayListEditText:Ljava/util/ArrayList;

    invoke-virtual {v10}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v10

    :goto_4
    invoke-interface {v10}, Ljava/util/Iterator;->hasNext()Z

    move-result v11

    if-eqz v11, :cond_0

    invoke-interface {v10}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/widget/EditText;

    .line 597
    .local v3, "editText":Landroid/widget/EditText;
    invoke-virtual {v3}, Landroid/widget/EditText;->getTag()Ljava/lang/Object;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v6, v11}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 598
    .local v8, "string":Ljava/lang/String;
    invoke-virtual {v3, v8}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    goto :goto_4
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 5
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 638
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v2

    sparse-switch v2, :sswitch_data_0

    .line 672
    :goto_0
    return-void

    .line 640
    :sswitch_0
    new-instance v1, Lcom/cyjh/elfin/dialog/SettingDialog;

    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/cyjh/elfin/dialog/SettingDialog;-><init>(Landroid/content/Context;)V

    .line 641
    .local v1, "settingDialog":Lcom/cyjh/elfin/dialog/SettingDialog;
    iget-object v2, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mContext:Landroid/content/Context;

    iput-object v2, v1, Lcom/cyjh/elfin/dialog/SettingDialog;->mContext:Landroid/content/Context;

    .line 642
    new-instance v2, Lcom/cyjh/elfin/dialog/ScriptUIDialog$3;

    invoke-direct {v2, p0, v1}, Lcom/cyjh/elfin/dialog/ScriptUIDialog$3;-><init>(Lcom/cyjh/elfin/dialog/ScriptUIDialog;Lcom/cyjh/elfin/dialog/SettingDialog;)V

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/dialog/SettingDialog;->setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)V

    .line 651
    invoke-virtual {v1}, Lcom/cyjh/elfin/dialog/SettingDialog;->show()V

    .line 652
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->dismiss()V

    goto :goto_0

    .line 662
    .end local v1    # "settingDialog":Lcom/cyjh/elfin/dialog/SettingDialog;
    :sswitch_1
    :try_start_0
    iget-object v2, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget-object v2, v2, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v2}, Lcom/cyjh/elfin/entity/Script;->getCfgFile()Ljava/io/File;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->generateUIConfigFile(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 666
    :goto_1
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v2

    new-instance v3, Lcom/cyjh/elfin/entity/MsgItem;

    const/16 v4, 0x3f0

    invoke-direct {v3, v4}, Lcom/cyjh/elfin/entity/MsgItem;-><init>(I)V

    invoke-virtual {v2, v3}, Lorg/greenrobot/eventbus/EventBus;->post(Ljava/lang/Object;)V

    .line 667
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->dismiss()V

    goto :goto_0

    .line 663
    :catch_0
    move-exception v0

    .line 664
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_1

    .line 638
    :sswitch_data_0
    .sparse-switch
        0x7f0f00c7 -> :sswitch_0
        0x7f0f00cb -> :sswitch_1
    .end sparse-switch
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 3
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    const/4 v2, 0x1

    const v1, 0x3f666666    # 0.9f

    .line 70
    invoke-super {p0, p1}, Lcom/cyjh/elfin/dialog/BaseDialog;->onCreate(Landroid/os/Bundle;)V

    .line 71
    const v0, 0x7f04003d

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->setContentView(I)V

    .line 72
    const v0, 0x3dcccccd    # 0.1f

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->setBlurEffect(F)V

    .line 74
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget-boolean v0, v0, Lcom/cyjh/elfin/AppContext;->checkedScreenOrientation:Z

    if-eqz v0, :cond_0

    .line 75
    const v0, 0x3f4ccccd    # 0.8f

    invoke-virtual {p0, v1, v0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->setDialogSize(FF)V

    .line 79
    :goto_0
    invoke-direct {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->initView()V

    .line 80
    invoke-direct {p0, v2, v2}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->initUIFile(IZ)V

    .line 81
    invoke-direct {p0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->initEvent()V

    .line 82
    return-void

    .line 77
    :cond_0
    const v0, 0x3f19999a    # 0.6f

    invoke-virtual {p0, v1, v0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->setDialogSize(FF)V

    goto :goto_0
.end method
