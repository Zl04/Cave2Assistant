.class public Lcom/cyjh/elfin/fragment/OptionFragment;
.super Lcom/cyjh/elfin/fragment/BaseFragement;
.source "OptionFragment.java"

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lcom/cyjh/elfin/dialog/DownloadDialogFragment$OnDownloadClickListener;
.implements Lcom/cyjh/elfin/mvp/views/AdImageView;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/fragment/OptionFragment$SubmitCountTimer;,
        Lcom/cyjh/elfin/fragment/OptionFragment$RunnableTask;,
        Lcom/cyjh/elfin/fragment/OptionFragment$copyScriptFilesTask;
    }
.end annotation


# static fields
.field private static final CLICK_AD_COUNT_TIME:I = 0x5

.field private static final MESSAGE_IFLYAD_SHOW_COUNT:I = 0x66

.field private static final NID:I = 0x1337959

.field public static final SECONDS_IN_FUTURE:I = 0xa

.field private static final VALUE_SITE:I = 0x2


# instance fields
.field private CheckBoxList:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/widget/CheckBox;",
            ">;"
        }
    .end annotation
.end field

.field private EditTextList:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/widget/EditText;",
            ">;"
        }
    .end annotation
.end field

.field private final MESSAGE_WHAT_IFLYAD:I

.field private final MESSAGE_WHAT_LOADSCRIPT:I

.field private SpinnerList:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/widget/Spinner;",
            ">;"
        }
    .end annotation
.end field

.field private ad:Lcom/cyjh/elfin/entity/Ad;

.field private adDataRef:Lcom/iflytek/voiceads/NativeADDataRef;

.field private adImagePresenter:Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;

.field private backgroundSettingsAdStats:Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;

.field private btnRun:Landroid/widget/Button;

.field private checkOnFailIFLYAD:Z

.field private counter:I

.field private downloadDialog:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

.field private downloadHandler:Lcom/lidroid/xutils/http/HttpHandler;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/lidroid/xutils/http/HttpHandler",
            "<",
            "Ljava/io/File;",
            ">;"
        }
    .end annotation
.end field

.field private elfinFreeActivity:Lcom/cyjh/elfin/activity/ElfinFreeActivity;

.field private handler:Landroid/os/Handler;

.field private isShowConfigAd:Z

.field private mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

.field private mButtonMoreScripts:Landroid/widget/Button;

.field private mCountTimer:Lcom/cyjh/elfin/fragment/OptionFragment$SubmitCountTimer;

.field private mImgAd:Landroid/widget/ImageView;

.field private mNativeAd:Lcom/iflytek/voiceads/IFLYNativeAd;

.field private mNativeListener:Lcom/iflytek/voiceads/IFLYNativeListener;

.field private mNotifyManager:Landroid/app/NotificationManager;

.field private mRelativeAd:Landroid/widget/RelativeLayout;

.field private mRelativeBtn:Landroid/widget/RelativeLayout;

.field private mRunnableTask:Lcom/cyjh/elfin/fragment/OptionFragment$RunnableTask;

.field private mTvDelete:Landroid/widget/TextView;

.field private mTvILFYAdMark:Landroid/widget/TextView;

.field private noRootDialog:Lcom/cyjh/elfin/dialog/NoRootDialog;

.field private preventMultipleClicks:Z

.field private scrollViewUI:Landroid/widget/ScrollView;

.field private uipFileLength:J

.field private uipLinearLayoutUI:Landroid/widget/LinearLayout;

.field private viewParent:Landroid/view/View;


# direct methods
.method public constructor <init>()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 119
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/BaseFragement;-><init>()V

    .line 134
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->CheckBoxList:Ljava/util/ArrayList;

    .line 135
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->SpinnerList:Ljava/util/ArrayList;

    .line 136
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->EditTextList:Ljava/util/ArrayList;

    .line 138
    const/16 v0, 0x64

    iput v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->MESSAGE_WHAT_LOADSCRIPT:I

    .line 139
    const/16 v0, 0x65

    iput v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->MESSAGE_WHAT_IFLYAD:I

    .line 165
    iput-boolean v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->preventMultipleClicks:Z

    .line 170
    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->uipFileLength:J

    .line 179
    iput-boolean v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->checkOnFailIFLYAD:Z

    .line 185
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->isShowConfigAd:Z

    .line 190
    iput v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->counter:I

    .line 1171
    new-instance v0, Lcom/cyjh/elfin/fragment/OptionFragment$4;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/fragment/OptionFragment$4;-><init>(Lcom/cyjh/elfin/fragment/OptionFragment;)V

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->handler:Landroid/os/Handler;

    .line 1315
    new-instance v0, Lcom/cyjh/elfin/fragment/OptionFragment$5;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/fragment/OptionFragment$5;-><init>(Lcom/cyjh/elfin/fragment/OptionFragment;)V

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mNativeListener:Lcom/iflytek/voiceads/IFLYNativeListener;

    return-void
.end method

.method private ParMainLayout(Landroid/util/JsonReader;)Landroid/widget/LinearLayout;
    .locals 11
    .param p1, "reader"    # Landroid/util/JsonReader;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v9, -0x1

    .line 573
    new-instance v6, Landroid/widget/LinearLayout;

    iget-object v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->elfinFreeActivity:Lcom/cyjh/elfin/activity/ElfinFreeActivity;

    invoke-direct {v6, v8}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 574
    .local v6, "verticalLayout":Landroid/widget/LinearLayout;
    new-instance v8, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v8, v9, v9}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v6, v8}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 575
    const/4 v8, 0x1

    invoke-virtual {v6, v8}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 576
    invoke-virtual {p1}, Landroid/util/JsonReader;->beginObject()V

    .line 577
    :goto_0
    invoke-virtual {p1}, Landroid/util/JsonReader;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_6

    .line 578
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v7

    .line 579
    .local v7, "widgetName":Ljava/lang/String;
    iget-object v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "ParMainLayout:widgetName>>>"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 580
    const v8, 0x7f08011c

    invoke-virtual {p0, v8}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_0

    .line 581
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/fragment/OptionFragment;->ParsHorizontalLayout(Landroid/util/JsonReader;)Landroid/widget/LinearLayout;

    move-result-object v3

    .line 582
    .local v3, "horizontalLayout":Landroid/widget/LinearLayout;
    invoke-virtual {v6, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto :goto_0

    .line 583
    .end local v3    # "horizontalLayout":Landroid/widget/LinearLayout;
    :cond_0
    const v8, 0x7f080129

    invoke-virtual {p0, v8}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_1

    .line 584
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/fragment/OptionFragment;->ParsTextView(Landroid/util/JsonReader;)Landroid/widget/TextView;

    move-result-object v5

    .line 585
    .local v5, "textView":Landroid/widget/TextView;
    invoke-virtual {v6, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto :goto_0

    .line 586
    .end local v5    # "textView":Landroid/widget/TextView;
    :cond_1
    const v8, 0x7f080115

    invoke-virtual {p0, v8}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_2

    .line 587
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/fragment/OptionFragment;->ParsEditText(Landroid/util/JsonReader;)Landroid/widget/EditText;

    move-result-object v2

    .line 588
    .local v2, "editText":Landroid/widget/EditText;
    invoke-virtual {v6, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto :goto_0

    .line 589
    .end local v2    # "editText":Landroid/widget/EditText;
    :cond_2
    const v8, 0x7f080112

    invoke-virtual {p0, v8}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_3

    .line 590
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/fragment/OptionFragment;->ParsCheckBox(Landroid/util/JsonReader;)Landroid/widget/CheckBox;

    move-result-object v4

    .line 591
    .local v4, "parsCheckBox":Landroid/widget/CheckBox;
    invoke-virtual {v6, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto :goto_0

    .line 592
    .end local v4    # "parsCheckBox":Landroid/widget/CheckBox;
    :cond_3
    const v8, 0x7f080125

    invoke-virtual {p0, v8}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_4

    .line 593
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/fragment/OptionFragment;->ParSpinner(Landroid/util/JsonReader;)Landroid/widget/Spinner;

    move-result-object v0

    .line 594
    .local v0, "Spinner":Landroid/widget/Spinner;
    invoke-virtual {v6, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto/16 :goto_0

    .line 595
    .end local v0    # "Spinner":Landroid/widget/Spinner;
    :cond_4
    const v8, 0x7f080111

    invoke-virtual {p0, v8}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_5

    .line 596
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/fragment/OptionFragment;->ParsButton(Landroid/util/JsonReader;)Landroid/widget/Button;

    move-result-object v1

    .line 597
    .local v1, "button":Landroid/widget/Button;
    invoke-virtual {v6, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto/16 :goto_0

    .line 599
    .end local v1    # "button":Landroid/widget/Button;
    :cond_5
    invoke-virtual {p1}, Landroid/util/JsonReader;->skipValue()V

    .line 600
    iget-object v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v9, "ParMainLayout\u6ca1\u6709\u6b64\u8282\u70b9"

    invoke-virtual {v8, v9}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    goto/16 :goto_0

    .line 603
    .end local v7    # "widgetName":Ljava/lang/String;
    :cond_6
    invoke-virtual {p1}, Landroid/util/JsonReader;->endObject()V

    .line 606
    return-object v6
.end method

.method private ParSpinner(Landroid/util/JsonReader;)Landroid/widget/Spinner;
    .locals 13
    .param p1, "reader"    # Landroid/util/JsonReader;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v11, -0x2

    const/4 v12, 0x0

    .line 869
    iget-object v9, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v10, "\u5f00\u59cbSpinner\u89e3\u6790"

    invoke-virtual {v9, v10}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 870
    new-instance v8, Landroid/widget/Spinner;

    iget-object v9, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->elfinFreeActivity:Lcom/cyjh/elfin/activity/ElfinFreeActivity;

    invoke-direct {v8, v9}, Landroid/widget/Spinner;-><init>(Landroid/content/Context;)V

    .line 871
    .local v8, "spinner":Landroid/widget/Spinner;
    new-instance v5, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v5, v11, v11}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 872
    .local v5, "layoutParams":Landroid/widget/LinearLayout$LayoutParams;
    invoke-virtual {v8, v5}, Landroid/widget/Spinner;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 873
    const v9, 0x7f02004a

    invoke-virtual {v8, v9}, Landroid/widget/Spinner;->setBackgroundResource(I)V

    .line 874
    const/4 v9, 0x5

    invoke-virtual {v8, v12, v12, v9, v12}, Landroid/widget/Spinner;->setPadding(IIII)V

    .line 875
    const/4 v9, 0x3

    invoke-virtual {v8, v9}, Landroid/widget/Spinner;->setGravity(I)V

    .line 876
    invoke-virtual {p1}, Landroid/util/JsonReader;->beginObject()V

    .line 877
    :goto_0
    invoke-virtual {p1}, Landroid/util/JsonReader;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_4

    .line 878
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 879
    .local v1, "attributeName":Ljava/lang/String;
    iget-object v9, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "ParSpinner>>>"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 880
    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    .line 881
    .local v4, "itemList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    const v9, 0x7f08011d

    invoke-virtual {p0, v9}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_0

    .line 882
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v6

    .line 883
    .local v6, "name":Ljava/lang/String;
    iget-object v9, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "\u540d\u79f0>>>>"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 884
    invoke-virtual {v8, v6}, Landroid/widget/Spinner;->setTag(Ljava/lang/Object;)V

    goto :goto_0

    .line 885
    .end local v6    # "name":Ljava/lang/String;
    :cond_0
    const v9, 0x7f080127

    invoke-virtual {p0, v9}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_2

    .line 887
    invoke-virtual {p1}, Landroid/util/JsonReader;->beginArray()V

    .line 888
    :goto_1
    invoke-virtual {p1}, Landroid/util/JsonReader;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_1

    .line 889
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v3

    .line 891
    .local v3, "item":Ljava/lang/String;
    invoke-virtual {v4, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .line 893
    .end local v3    # "item":Ljava/lang/String;
    :cond_1
    invoke-virtual {p1}, Landroid/util/JsonReader;->endArray()V

    .line 894
    new-instance v0, Landroid/widget/ArrayAdapter;

    iget-object v9, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->elfinFreeActivity:Lcom/cyjh/elfin/activity/ElfinFreeActivity;

    const v10, 0x1090008

    invoke-direct {v0, v9, v10, v4}, Landroid/widget/ArrayAdapter;-><init>(Landroid/content/Context;ILjava/util/List;)V

    .line 895
    .local v0, "arrayAdapter":Landroid/widget/ArrayAdapter;, "Landroid/widget/ArrayAdapter<Ljava/lang/String;>;"
    const v9, 0x1090009

    invoke-virtual {v0, v9}, Landroid/widget/ArrayAdapter;->setDropDownViewResource(I)V

    .line 896
    invoke-virtual {v8, v0}, Landroid/widget/Spinner;->setAdapter(Landroid/widget/SpinnerAdapter;)V

    goto/16 :goto_0

    .line 898
    .end local v0    # "arrayAdapter":Landroid/widget/ArrayAdapter;, "Landroid/widget/ArrayAdapter<Ljava/lang/String;>;"
    :cond_2
    const v9, 0x7f080126

    invoke-virtual {p0, v9}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_3

    .line 899
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v7

    .line 901
    .local v7, "position":I
    const/4 v9, 0x1

    :try_start_0
    invoke-virtual {v8, v7, v9}, Landroid/widget/Spinner;->setSelection(IZ)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_0

    .line 902
    :catch_0
    move-exception v2

    .line 903
    .local v2, "e":Ljava/lang/Exception;
    invoke-virtual {v8, v12}, Landroid/widget/Spinner;->setSelection(I)V

    goto/16 :goto_0

    .line 906
    .end local v2    # "e":Ljava/lang/Exception;
    .end local v7    # "position":I
    :cond_3
    iget-object v9, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v10, "ParSpinner\u6ca1\u6709\u6b64\u8282\u70b9"

    invoke-virtual {v9, v10}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 907
    invoke-virtual {p1}, Landroid/util/JsonReader;->skipValue()V

    goto/16 :goto_0

    .line 910
    .end local v1    # "attributeName":Ljava/lang/String;
    .end local v4    # "itemList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    :cond_4
    invoke-virtual {p1}, Landroid/util/JsonReader;->endObject()V

    .line 911
    iget-object v9, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->SpinnerList:Ljava/util/ArrayList;

    invoke-virtual {v9, v8}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 912
    return-object v8
.end method

.method private ParsButton(Landroid/util/JsonReader;)Landroid/widget/Button;
    .locals 14
    .param p1, "reader"    # Landroid/util/JsonReader;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const v13, 0x7f0c000b

    const/4 v12, 0x2

    const/4 v11, 0x1

    const/4 v9, -0x2

    .line 923
    new-instance v1, Landroid/widget/Button;

    iget-object v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->elfinFreeActivity:Lcom/cyjh/elfin/activity/ElfinFreeActivity;

    invoke-direct {v1, v8}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V

    .line 924
    .local v1, "button":Landroid/widget/Button;
    const/16 v8, 0x11

    invoke-virtual {v1, v8}, Landroid/widget/Button;->setGravity(I)V

    .line 925
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v4, v9, v9}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 926
    .local v4, "layoutParams":Landroid/widget/LinearLayout$LayoutParams;
    invoke-virtual {v1, v4}, Landroid/widget/Button;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 927
    iget-object v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    const v9, 0x7f0c000a

    invoke-virtual {v8, v9}, Lcom/cyjh/elfin/AppContext;->getInteger(I)I

    move-result v8

    int-to-float v8, v8

    invoke-virtual {v1, v8}, Landroid/widget/Button;->setTextSize(F)V

    .line 928
    invoke-virtual {p1}, Landroid/util/JsonReader;->beginObject()V

    .line 929
    :cond_0
    :goto_0
    invoke-virtual {p1}, Landroid/util/JsonReader;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_7

    .line 930
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v0

    .line 931
    .local v0, "attributeName":Ljava/lang/String;
    iget-object v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "Button\u8282\u70b9>>>"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 932
    const v8, 0x7f08011d

    invoke-virtual {p0, v8}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_1

    .line 933
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v5

    .line 934
    .local v5, "name":Ljava/lang/String;
    iget-object v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "Button\u540d\u79f0>>>"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 935
    invoke-virtual {v1, v5}, Landroid/widget/Button;->setTag(Ljava/lang/Object;)V

    goto :goto_0

    .line 936
    .end local v5    # "name":Ljava/lang/String;
    :cond_1
    const v8, 0x7f08012a

    invoke-virtual {p0, v8}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_2

    .line 937
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v2

    .line 938
    .local v2, "content":Ljava/lang/String;
    iget-object v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "Button\u663e\u793a\u5185\u5bb9>>>"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 939
    invoke-virtual {v1, v2}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 940
    .end local v2    # "content":Ljava/lang/String;
    :cond_2
    const v8, 0x7f080128

    invoke-virtual {p0, v8}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_4

    .line 941
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v6

    .line 942
    .local v6, "textSize":I
    iget-object v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "\u6587\u5b57\u5927\u5c0f>>>>"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 943
    iget-object v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    invoke-virtual {v8, v13}, Lcom/cyjh/elfin/AppContext;->getInteger(I)I

    move-result v8

    if-le v6, v8, :cond_3

    .line 944
    int-to-float v8, v6

    invoke-virtual {v1, v12, v8}, Landroid/widget/Button;->setTextSize(IF)V

    goto/16 :goto_0

    .line 946
    :cond_3
    iget-object v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    invoke-virtual {v8, v13}, Lcom/cyjh/elfin/AppContext;->getInteger(I)I

    move-result v8

    int-to-float v8, v8

    invoke-virtual {v1, v12, v8}, Landroid/widget/Button;->setTextSize(IF)V

    goto/16 :goto_0

    .line 948
    .end local v6    # "textSize":I
    :cond_4
    const v8, 0x7f08011a

    invoke-virtual {p0, v8}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_5

    .line 949
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v3

    .line 950
    .local v3, "height":I
    iget-object v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    const v9, 0x7f0c0007

    invoke-virtual {v8, v9}, Lcom/cyjh/elfin/AppContext;->getInteger(I)I

    move-result v8

    if-le v3, v8, :cond_0

    .line 951
    int-to-float v8, v3

    .line 952
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->getResources()Landroid/content/res/Resources;

    move-result-object v9

    invoke-virtual {v9}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v9

    .line 951
    invoke-static {v11, v8, v9}, Landroid/util/TypedValue;->applyDimension(IFLandroid/util/DisplayMetrics;)F

    move-result v8

    float-to-int v8, v8

    invoke-virtual {v1, v8}, Landroid/widget/Button;->setHeight(I)V

    goto/16 :goto_0

    .line 954
    .end local v3    # "height":I
    :cond_5
    const v8, 0x7f08011b

    invoke-virtual {p0, v8}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_6

    .line 955
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v7

    .line 956
    .local v7, "width":I
    iget-object v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    const v9, 0x7f0c0008

    invoke-virtual {v8, v9}, Lcom/cyjh/elfin/AppContext;->getInteger(I)I

    move-result v8

    if-le v7, v8, :cond_0

    .line 957
    int-to-float v8, v7

    .line 958
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->getResources()Landroid/content/res/Resources;

    move-result-object v9

    invoke-virtual {v9}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v9

    .line 957
    invoke-static {v11, v8, v9}, Landroid/util/TypedValue;->applyDimension(IFLandroid/util/DisplayMetrics;)F

    move-result v8

    float-to-int v8, v8

    invoke-virtual {v1, v8}, Landroid/widget/Button;->setWidth(I)V

    goto/16 :goto_0

    .line 961
    .end local v7    # "width":I
    :cond_6
    iget-object v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v9, "Button>>>>\u6ca1\u6709\u6b64\u8282\u70b9"

    invoke-virtual {v8, v9}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 962
    invoke-virtual {p1}, Landroid/util/JsonReader;->skipValue()V

    goto/16 :goto_0

    .line 965
    .end local v0    # "attributeName":Ljava/lang/String;
    :cond_7
    invoke-virtual {p1}, Landroid/util/JsonReader;->endObject()V

    .line 967
    new-instance v8, Lcom/cyjh/elfin/fragment/OptionFragment$2;

    invoke-direct {v8, p0}, Lcom/cyjh/elfin/fragment/OptionFragment$2;-><init>(Lcom/cyjh/elfin/fragment/OptionFragment;)V

    invoke-virtual {v1, v8}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 973
    return-object v1
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

    .line 803
    iget-object v9, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v10, "\u5f00\u59cbCheckBox\u89e3\u6790"

    invoke-virtual {v9, v10}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 804
    new-instance v1, Landroid/widget/CheckBox;

    iget-object v9, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->elfinFreeActivity:Lcom/cyjh/elfin/activity/ElfinFreeActivity;

    invoke-direct {v1, v9}, Landroid/widget/CheckBox;-><init>(Landroid/content/Context;)V

    .line 805
    .local v1, "checkBox":Landroid/widget/CheckBox;
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v4, v11, v11}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 806
    .local v4, "layoutParams":Landroid/widget/LinearLayout$LayoutParams;
    invoke-virtual {v1, v4}, Landroid/widget/CheckBox;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 807
    iget-object v9, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    const v10, 0x7f0c000a

    invoke-virtual {v9, v10}, Lcom/cyjh/elfin/AppContext;->getInteger(I)I

    move-result v9

    int-to-float v9, v9

    invoke-virtual {v1, v9}, Landroid/widget/CheckBox;->setTextSize(F)V

    .line 808
    invoke-virtual {p1}, Landroid/util/JsonReader;->beginObject()V

    .line 809
    :cond_0
    :goto_0
    invoke-virtual {p1}, Landroid/util/JsonReader;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_9

    .line 810
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v0

    .line 811
    .local v0, "attributeName":Ljava/lang/String;
    iget-object v9, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "ParsCheckBox>>>"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 812
    const v9, 0x7f08011d

    invoke-virtual {p0, v9}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_1

    .line 813
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v5

    .line 814
    .local v5, "name":Ljava/lang/String;
    iget-object v9, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "\u540d\u79f0>>>>"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 815
    invoke-virtual {v1, v5}, Landroid/widget/CheckBox;->setTag(Ljava/lang/Object;)V

    goto :goto_0

    .line 816
    .end local v5    # "name":Ljava/lang/String;
    :cond_1
    const v9, 0x7f080114

    invoke-virtual {p0, v9}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_2

    .line 817
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v2

    .line 819
    .local v2, "content":Ljava/lang/String;
    invoke-virtual {v1, v2}, Landroid/widget/CheckBox;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 820
    .end local v2    # "content":Ljava/lang/String;
    :cond_2
    const v9, 0x7f080113

    invoke-virtual {p0, v9}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_4

    .line 821
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextBoolean()Z

    move-result v6

    .line 823
    .local v6, "state":Z
    if-eqz v6, :cond_3

    .line 824
    const/4 v9, 0x1

    invoke-virtual {v1, v9}, Landroid/widget/CheckBox;->setChecked(Z)V

    goto :goto_0

    .line 826
    :cond_3
    const/4 v9, 0x0

    invoke-virtual {v1, v9}, Landroid/widget/CheckBox;->setChecked(Z)V

    goto :goto_0

    .line 828
    .end local v6    # "state":Z
    :cond_4
    const v9, 0x7f080128

    invoke-virtual {p0, v9}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_6

    .line 829
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v7

    .line 831
    .local v7, "textSize":I
    iget-object v9, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    invoke-virtual {v9, v12}, Lcom/cyjh/elfin/AppContext;->getInteger(I)I

    move-result v9

    if-le v7, v9, :cond_5

    .line 832
    int-to-float v9, v7

    invoke-virtual {v1, v9}, Landroid/widget/CheckBox;->setTextSize(F)V

    goto/16 :goto_0

    .line 833
    :cond_5
    iget-object v9, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    const v10, 0x7f0c0009

    invoke-virtual {v9, v10}, Lcom/cyjh/elfin/AppContext;->getInteger(I)I

    move-result v9

    if-eq v7, v9, :cond_0

    .line 834
    iget-object v9, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    invoke-virtual {v9, v12}, Lcom/cyjh/elfin/AppContext;->getInteger(I)I

    move-result v9

    int-to-float v9, v9

    invoke-virtual {v1, v9}, Landroid/widget/CheckBox;->setTextSize(F)V

    goto/16 :goto_0

    .line 836
    .end local v7    # "textSize":I
    :cond_6
    const v9, 0x7f08011a

    invoke-virtual {p0, v9}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_7

    .line 837
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v3

    .line 839
    .local v3, "height":I
    iget-object v9, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    const v10, 0x7f0c0007

    invoke-virtual {v9, v10}, Lcom/cyjh/elfin/AppContext;->getInteger(I)I

    move-result v9

    if-le v3, v9, :cond_0

    .line 840
    invoke-virtual {v1, v3}, Landroid/widget/CheckBox;->setHeight(I)V

    goto/16 :goto_0

    .line 842
    .end local v3    # "height":I
    :cond_7
    const v9, 0x7f08011b

    invoke-virtual {p0, v9}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_8

    .line 843
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v8

    .line 845
    .local v8, "width":I
    iget-object v9, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    const v10, 0x7f0c0008

    invoke-virtual {v9, v10}, Lcom/cyjh/elfin/AppContext;->getInteger(I)I

    move-result v9

    if-le v8, v9, :cond_0

    .line 846
    invoke-virtual {v1, v8}, Landroid/widget/CheckBox;->setWidth(I)V

    goto/16 :goto_0

    .line 851
    .end local v8    # "width":I
    :cond_8
    iget-object v9, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v10, "ParsCheckBox\u6ca1\u6709\u6b64\u8282\u70b9"

    invoke-virtual {v9, v10}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 852
    invoke-virtual {p1}, Landroid/util/JsonReader;->skipValue()V

    goto/16 :goto_0

    .line 855
    .end local v0    # "attributeName":Ljava/lang/String;
    :cond_9
    invoke-virtual {p1}, Landroid/util/JsonReader;->endObject()V

    .line 856
    iget-object v9, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->CheckBoxList:Ljava/util/ArrayList;

    invoke-virtual {v9, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 857
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
    .line 724
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v15, "\u5f00\u59cbEditText\u89e3\u6790"

    invoke-virtual {v14, v15}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 725
    new-instance v4, Landroid/widget/EditText;

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/cyjh/elfin/fragment/OptionFragment;->elfinFreeActivity:Lcom/cyjh/elfin/activity/ElfinFreeActivity;

    invoke-direct {v4, v14}, Landroid/widget/EditText;-><init>(Landroid/content/Context;)V

    .line 726
    .local v4, "editText":Landroid/widget/EditText;
    new-instance v8, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v14, -0x2

    const/4 v15, -0x2

    invoke-direct {v8, v14, v15}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 727
    .local v8, "layoutParams":Landroid/widget/LinearLayout$LayoutParams;
    invoke-virtual {v4, v8}, Landroid/widget/EditText;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 728
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    const v15, 0x7f0c000a

    invoke-virtual {v14, v15}, Lcom/cyjh/elfin/AppContext;->getInteger(I)I

    move-result v14

    int-to-float v14, v14

    invoke-virtual {v4, v14}, Landroid/widget/EditText;->setTextSize(F)V

    .line 729
    const/4 v14, 0x1

    invoke-virtual {v4, v14}, Landroid/widget/EditText;->setSingleLine(Z)V

    .line 730
    invoke-virtual/range {p1 .. p1}, Landroid/util/JsonReader;->beginObject()V

    .line 731
    :cond_0
    :goto_0
    invoke-virtual/range {p1 .. p1}, Landroid/util/JsonReader;->hasNext()Z

    move-result v14

    if-eqz v14, :cond_a

    .line 732
    invoke-virtual/range {p1 .. p1}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 733
    .local v1, "attributeName":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, "ParsEditText>>>"

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v14, v15}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 734
    const v14, 0x7f08011d

    move-object/from16 v0, p0

    invoke-virtual {v0, v14}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v14, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v14

    if-eqz v14, :cond_1

    .line 735
    invoke-virtual/range {p1 .. p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v10

    .line 737
    .local v10, "name":Ljava/lang/String;
    invoke-virtual {v4, v10}, Landroid/widget/EditText;->setTag(Ljava/lang/Object;)V

    goto :goto_0

    .line 738
    .end local v10    # "name":Ljava/lang/String;
    :cond_1
    const v14, 0x7f080117

    move-object/from16 v0, p0

    invoke-virtual {v0, v14}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v14, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v14

    if-eqz v14, :cond_2

    .line 739
    invoke-virtual/range {p1 .. p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v7

    .line 741
    .local v7, "hintContent":Ljava/lang/String;
    invoke-virtual {v4, v7}, Landroid/widget/EditText;->setHint(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 742
    .end local v7    # "hintContent":Ljava/lang/String;
    :cond_2
    const v14, 0x7f080128

    move-object/from16 v0, p0

    invoke-virtual {v0, v14}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v14, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v14

    if-eqz v14, :cond_4

    .line 743
    invoke-virtual/range {p1 .. p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v12

    .line 745
    .local v12, "textSize":I
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    const v15, 0x7f0c000b

    invoke-virtual {v14, v15}, Lcom/cyjh/elfin/AppContext;->getInteger(I)I

    move-result v14

    if-le v12, v14, :cond_3

    .line 746
    int-to-float v14, v12

    invoke-virtual {v4, v14}, Landroid/widget/EditText;->setTextSize(F)V

    goto :goto_0

    .line 747
    :cond_3
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    const v15, 0x7f0c0009

    invoke-virtual {v14, v15}, Lcom/cyjh/elfin/AppContext;->getInteger(I)I

    move-result v14

    if-eq v12, v14, :cond_0

    .line 748
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    const v15, 0x7f0c000b

    invoke-virtual {v14, v15}, Lcom/cyjh/elfin/AppContext;->getInteger(I)I

    move-result v14

    int-to-float v14, v14

    invoke-virtual {v4, v14}, Landroid/widget/EditText;->setTextSize(F)V

    goto/16 :goto_0

    .line 750
    .end local v12    # "textSize":I
    :cond_4
    const v14, 0x7f08011a

    move-object/from16 v0, p0

    invoke-virtual {v0, v14}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v14, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v14

    if-eqz v14, :cond_5

    .line 751
    invoke-virtual/range {p1 .. p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v6

    .line 753
    .local v6, "height":I
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    const v15, 0x7f0c0007

    invoke-virtual {v14, v15}, Lcom/cyjh/elfin/AppContext;->getInteger(I)I

    move-result v14

    if-le v6, v14, :cond_0

    .line 754
    invoke-virtual {v4, v6}, Landroid/widget/EditText;->setHeight(I)V

    goto/16 :goto_0

    .line 756
    .end local v6    # "height":I
    :cond_5
    const v14, 0x7f08011b

    move-object/from16 v0, p0

    invoke-virtual {v0, v14}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v14, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v14

    if-eqz v14, :cond_6

    .line 757
    invoke-virtual/range {p1 .. p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v13

    .line 759
    .local v13, "width":I
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    const v15, 0x7f0c0008

    invoke-virtual {v14, v15}, Lcom/cyjh/elfin/AppContext;->getInteger(I)I

    move-result v14

    if-le v13, v14, :cond_0

    .line 760
    invoke-virtual {v4, v13}, Landroid/widget/EditText;->setWidth(I)V

    goto/16 :goto_0

    .line 762
    .end local v13    # "width":I
    :cond_6
    const v14, 0x7f080119

    move-object/from16 v0, p0

    invoke-virtual {v0, v14}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v14, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v14

    if-eqz v14, :cond_7

    .line 763
    invoke-virtual/range {p1 .. p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v9

    .line 765
    .local v9, "maxLenth":I
    if-lez v9, :cond_0

    .line 766
    const/4 v14, 0x1

    new-array v5, v14, [Landroid/text/InputFilter;

    .line 767
    .local v5, "filters":[Landroid/text/InputFilter;
    const/4 v14, 0x0

    new-instance v15, Landroid/text/InputFilter$LengthFilter;

    invoke-direct {v15, v9}, Landroid/text/InputFilter$LengthFilter;-><init>(I)V

    aput-object v15, v5, v14

    .line 768
    invoke-virtual {v4, v5}, Landroid/widget/EditText;->setFilters([Landroid/text/InputFilter;)V

    goto/16 :goto_0

    .line 770
    .end local v5    # "filters":[Landroid/text/InputFilter;
    .end local v9    # "maxLenth":I
    :cond_7
    const v14, 0x7f080118

    move-object/from16 v0, p0

    invoke-virtual {v0, v14}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v14, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v14

    if-eqz v14, :cond_8

    .line 771
    const/4 v11, 0x0

    .line 773
    .local v11, "onlyNumber":Z
    :try_start_0
    invoke-virtual/range {p1 .. p1}, Landroid/util/JsonReader;->nextBoolean()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v11

    .line 777
    :goto_1
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, "\u662f\u5426\u4ec5\u8f93\u5165\u6570\u5b57>>>>"

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15, v11}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v14, v15}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 778
    if-eqz v11, :cond_0

    .line 779
    const/4 v14, 0x2

    invoke-virtual {v4, v14}, Landroid/widget/EditText;->setInputType(I)V

    goto/16 :goto_0

    .line 774
    :catch_0
    move-exception v3

    .line 775
    .local v3, "e":Ljava/lang/Exception;
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v15, "EditText\u89e3\u6790\u5f02\u5e38\u4e86"

    invoke-virtual {v14, v15}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    goto :goto_1

    .line 781
    .end local v3    # "e":Ljava/lang/Exception;
    .end local v11    # "onlyNumber":Z
    :cond_8
    const v14, 0x7f080116

    move-object/from16 v0, p0

    invoke-virtual {v0, v14}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v14, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v14

    if-eqz v14, :cond_9

    .line 782
    invoke-virtual/range {p1 .. p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v2

    .line 783
    .local v2, "defaultText":Ljava/lang/String;
    invoke-virtual {v4, v2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    goto/16 :goto_0

    .line 785
    .end local v2    # "defaultText":Ljava/lang/String;
    :cond_9
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v15, "ParsEditText\u6ca1\u6709\u6b64\u8282\u70b9"

    invoke-virtual {v14, v15}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 786
    invoke-virtual/range {p1 .. p1}, Landroid/util/JsonReader;->skipValue()V

    goto/16 :goto_0

    .line 789
    .end local v1    # "attributeName":Ljava/lang/String;
    :cond_a
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/cyjh/elfin/fragment/OptionFragment;->EditTextList:Ljava/util/ArrayList;

    invoke-virtual {v14, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 790
    invoke-virtual/range {p1 .. p1}, Landroid/util/JsonReader;->endObject()V

    .line 791
    return-object v4
.end method

.method private ParsHorizontalLayout(Landroid/util/JsonReader;)Landroid/widget/LinearLayout;
    .locals 11
    .param p1, "reader"    # Landroid/util/JsonReader;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v10, -0x2

    .line 618
    iget-object v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v9, "\u5f00\u59cbParsHorizontalLayout\u89e3\u6790"

    invoke-virtual {v8, v9}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 619
    new-instance v3, Landroid/widget/LinearLayout;

    iget-object v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->elfinFreeActivity:Lcom/cyjh/elfin/activity/ElfinFreeActivity;

    invoke-direct {v3, v8}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 620
    .local v3, "horizontalLayout":Landroid/widget/LinearLayout;
    const/4 v8, 0x0

    invoke-virtual {v3, v8}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 621
    const/16 v8, 0x10

    invoke-virtual {v3, v8}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 622
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v4, v10, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 624
    .local v4, "layoutParams":Landroid/widget/LinearLayout$LayoutParams;
    invoke-virtual {v3, v4}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 625
    invoke-virtual {p1}, Landroid/util/JsonReader;->beginObject()V

    .line 626
    :goto_0
    invoke-virtual {p1}, Landroid/util/JsonReader;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_6

    .line 627
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v7

    .line 628
    .local v7, "widgetName":Ljava/lang/String;
    iget-object v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "ParsHorizontalLayout>>>"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 629
    const v8, 0x7f08011c

    invoke-virtual {p0, v8}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_0

    .line 630
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/fragment/OptionFragment;->ParsHorizontalLayout(Landroid/util/JsonReader;)Landroid/widget/LinearLayout;

    move-result-object v8

    invoke-virtual {v3, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto :goto_0

    .line 631
    :cond_0
    const v8, 0x7f080129

    invoke-virtual {p0, v8}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_1

    .line 632
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/fragment/OptionFragment;->ParsTextView(Landroid/util/JsonReader;)Landroid/widget/TextView;

    move-result-object v6

    .line 633
    .local v6, "textView":Landroid/widget/TextView;
    invoke-virtual {v3, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto :goto_0

    .line 634
    .end local v6    # "textView":Landroid/widget/TextView;
    :cond_1
    const v8, 0x7f080115

    invoke-virtual {p0, v8}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_2

    .line 635
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/fragment/OptionFragment;->ParsEditText(Landroid/util/JsonReader;)Landroid/widget/EditText;

    move-result-object v2

    .line 636
    .local v2, "editText":Landroid/widget/EditText;
    invoke-virtual {v3, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto :goto_0

    .line 637
    .end local v2    # "editText":Landroid/widget/EditText;
    :cond_2
    const v8, 0x7f080112

    invoke-virtual {p0, v8}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_3

    .line 638
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/fragment/OptionFragment;->ParsCheckBox(Landroid/util/JsonReader;)Landroid/widget/CheckBox;

    move-result-object v5

    .line 639
    .local v5, "parsCheckBox":Landroid/widget/CheckBox;
    invoke-virtual {v3, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto :goto_0

    .line 640
    .end local v5    # "parsCheckBox":Landroid/widget/CheckBox;
    :cond_3
    const v8, 0x7f080125

    invoke-virtual {p0, v8}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_4

    .line 641
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/fragment/OptionFragment;->ParSpinner(Landroid/util/JsonReader;)Landroid/widget/Spinner;

    move-result-object v0

    .line 642
    .local v0, "Spinner":Landroid/widget/Spinner;
    invoke-virtual {v3, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto/16 :goto_0

    .line 643
    .end local v0    # "Spinner":Landroid/widget/Spinner;
    :cond_4
    const v8, 0x7f080111

    invoke-virtual {p0, v8}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_5

    .line 644
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/fragment/OptionFragment;->ParsButton(Landroid/util/JsonReader;)Landroid/widget/Button;

    move-result-object v1

    .line 645
    .local v1, "button":Landroid/widget/Button;
    invoke-virtual {v3, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto/16 :goto_0

    .line 647
    .end local v1    # "button":Landroid/widget/Button;
    :cond_5
    iget-object v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v9, "ParsHorizontalLayout\u6ca1\u6709\u6b64\u8282\u70b9"

    invoke-virtual {v8, v9}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 648
    invoke-virtual {p1}, Landroid/util/JsonReader;->skipValue()V

    goto/16 :goto_0

    .line 651
    .end local v7    # "widgetName":Ljava/lang/String;
    :cond_6
    invoke-virtual {p1}, Landroid/util/JsonReader;->endObject()V

    .line 653
    return-object v3
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

    .line 665
    iget-object v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v9, "\u5f00\u59cbTextView\u89e3\u6790"

    invoke-virtual {v8, v9}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 666
    new-instance v6, Landroid/widget/TextView;

    iget-object v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->elfinFreeActivity:Lcom/cyjh/elfin/activity/ElfinFreeActivity;

    invoke-direct {v6, v8}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 667
    .local v6, "textView":Landroid/widget/TextView;
    const/16 v8, 0x11

    invoke-virtual {v6, v8}, Landroid/widget/TextView;->setGravity(I)V

    .line 668
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v3, v10, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 669
    .local v3, "layoutParams":Landroid/widget/LinearLayout$LayoutParams;
    invoke-virtual {v6, v3}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 670
    iget-object v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    const v9, 0x7f0c000a

    invoke-virtual {v8, v9}, Lcom/cyjh/elfin/AppContext;->getInteger(I)I

    move-result v8

    int-to-float v8, v8

    invoke-virtual {v6, v8}, Landroid/widget/TextView;->setTextSize(F)V

    .line 671
    invoke-virtual {p1}, Landroid/util/JsonReader;->beginObject()V

    .line 672
    :cond_0
    :goto_0
    invoke-virtual {p1}, Landroid/util/JsonReader;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_7

    .line 673
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v0

    .line 674
    .local v0, "attributeName":Ljava/lang/String;
    iget-object v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "ParsTextView>>>"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 675
    const v8, 0x7f08011d

    invoke-virtual {p0, v8}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_1

    .line 676
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v4

    .line 678
    .local v4, "name":Ljava/lang/String;
    invoke-virtual {v6, v4}, Landroid/widget/TextView;->setTag(Ljava/lang/Object;)V

    goto :goto_0

    .line 679
    .end local v4    # "name":Ljava/lang/String;
    :cond_1
    const v8, 0x7f08012a

    invoke-virtual {p0, v8}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_2

    .line 680
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    .line 682
    .local v1, "content":Ljava/lang/String;
    invoke-virtual {v6, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 683
    .end local v1    # "content":Ljava/lang/String;
    :cond_2
    const v8, 0x7f080128

    invoke-virtual {p0, v8}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_4

    .line 684
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v5

    .line 686
    .local v5, "textSize":I
    iget-object v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    invoke-virtual {v8, v11}, Lcom/cyjh/elfin/AppContext;->getInteger(I)I

    move-result v8

    if-le v5, v8, :cond_3

    .line 687
    int-to-float v8, v5

    invoke-virtual {v6, v8}, Landroid/widget/TextView;->setTextSize(F)V

    goto :goto_0

    .line 688
    :cond_3
    iget-object v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    const v9, 0x7f0c0009

    invoke-virtual {v8, v9}, Lcom/cyjh/elfin/AppContext;->getInteger(I)I

    move-result v8

    if-eq v5, v8, :cond_0

    .line 689
    iget-object v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    invoke-virtual {v8, v11}, Lcom/cyjh/elfin/AppContext;->getInteger(I)I

    move-result v8

    int-to-float v8, v8

    invoke-virtual {v6, v8}, Landroid/widget/TextView;->setTextSize(F)V

    goto :goto_0

    .line 691
    .end local v5    # "textSize":I
    :cond_4
    const v8, 0x7f08011a

    invoke-virtual {p0, v8}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_5

    .line 692
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v2

    .line 694
    .local v2, "height":I
    iget-object v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    const v9, 0x7f0c0007

    invoke-virtual {v8, v9}, Lcom/cyjh/elfin/AppContext;->getInteger(I)I

    move-result v8

    if-le v2, v8, :cond_0

    .line 695
    invoke-virtual {v6, v2}, Landroid/widget/TextView;->setHeight(I)V

    goto/16 :goto_0

    .line 697
    .end local v2    # "height":I
    :cond_5
    const v8, 0x7f08011b

    invoke-virtual {p0, v8}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_6

    .line 698
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v7

    .line 700
    .local v7, "width":I
    iget-object v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    const v9, 0x7f0c0008

    invoke-virtual {v8, v9}, Lcom/cyjh/elfin/AppContext;->getInteger(I)I

    move-result v8

    if-le v7, v8, :cond_0

    .line 701
    invoke-virtual {v6, v7}, Landroid/widget/TextView;->setWidth(I)V

    goto/16 :goto_0

    .line 706
    .end local v7    # "width":I
    :cond_6
    iget-object v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v9, "ParsTextView\u6ca1\u6709\u6b64\u8282\u70b9"

    invoke-virtual {v8, v9}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 707
    invoke-virtual {p1}, Landroid/util/JsonReader;->skipValue()V

    goto/16 :goto_0

    .line 710
    .end local v0    # "attributeName":Ljava/lang/String;
    :cond_7
    invoke-virtual {p1}, Landroid/util/JsonReader;->endObject()V

    .line 712
    return-object v6
.end method

.method private ParsUIFile(Ljava/lang/String;)Landroid/widget/LinearLayout;
    .locals 7
    .param p1, "JsonUI"    # Ljava/lang/String;

    .prologue
    .line 550
    new-instance v2, Landroid/util/JsonReader;

    new-instance v4, Ljava/io/StringReader;

    invoke-direct {v4, p1}, Ljava/io/StringReader;-><init>(Ljava/lang/String;)V

    invoke-direct {v2, v4}, Landroid/util/JsonReader;-><init>(Ljava/io/Reader;)V

    .line 551
    .local v2, "reader":Landroid/util/JsonReader;
    new-instance v3, Landroid/widget/LinearLayout;

    iget-object v4, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->elfinFreeActivity:Lcom/cyjh/elfin/activity/ElfinFreeActivity;

    invoke-direct {v3, v4}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 553
    .local v3, "verticalLayout":Landroid/widget/LinearLayout;
    :try_start_0
    invoke-virtual {v2}, Landroid/util/JsonReader;->beginObject()V

    .line 554
    :goto_0
    invoke-virtual {v2}, Landroid/util/JsonReader;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_1

    .line 555
    invoke-virtual {v2}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v0

    .line 556
    .local v0, "activityName":Ljava/lang/String;
    iget-object v4, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "ParsUIFile>>>>"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 557
    const v4, 0x7f080110

    invoke-virtual {p0, v4}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 558
    invoke-direct {p0, v2}, Lcom/cyjh/elfin/fragment/OptionFragment;->ParMainLayout(Landroid/util/JsonReader;)Landroid/widget/LinearLayout;

    move-result-object v3

    goto :goto_0

    .line 560
    :cond_0
    invoke-virtual {v2}, Landroid/util/JsonReader;->skipValue()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 565
    .end local v0    # "activityName":Ljava/lang/String;
    :catch_0
    move-exception v1

    .line 566
    .local v1, "e":Ljava/lang/Exception;
    iget-object v4, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v5, "ParsUIFile\u754c\u9762\u6807\u7b7e\u89e3\u6790\u51fa\u9519\u4e86\uff01\uff01"

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 569
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_1
    return-object v3

    .line 563
    :cond_1
    :try_start_1
    invoke-virtual {v2}, Landroid/util/JsonReader;->endObject()V

    .line 564
    invoke-virtual {v2}, Landroid/util/JsonReader;->close()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1
.end method

.method static synthetic access$000(Lcom/cyjh/elfin/fragment/OptionFragment;)V
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/OptionFragment;

    .prologue
    .line 119
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->initQUI()V

    return-void
.end method

.method static synthetic access$100(Lcom/cyjh/elfin/fragment/OptionFragment;)V
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/OptionFragment;

    .prologue
    .line 119
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->startCountTimer()V

    return-void
.end method

.method static synthetic access$1000(Lcom/cyjh/elfin/fragment/OptionFragment;)Lcom/cyjh/elfin/entity/Ad;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/OptionFragment;

    .prologue
    .line 119
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->ad:Lcom/cyjh/elfin/entity/Ad;

    return-object v0
.end method

.method static synthetic access$1100(Lcom/cyjh/elfin/fragment/OptionFragment;Lcom/cyjh/elfin/entity/Ad;)V
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/OptionFragment;
    .param p1, "x1"    # Lcom/cyjh/elfin/entity/Ad;

    .prologue
    .line 119
    return-void
.end method

.method static synthetic access$1202(Lcom/cyjh/elfin/fragment/OptionFragment;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/OptionFragment;
    .param p1, "x1"    # Z

    .prologue
    .line 119
    iput-boolean p1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->isShowConfigAd:Z

    return p1
.end method

.method static synthetic access$1300(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/os/Handler;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/OptionFragment;

    .prologue
    .line 119
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->handler:Landroid/os/Handler;

    return-object v0
.end method

.method static synthetic access$1400(Lcom/cyjh/elfin/fragment/OptionFragment;)Lcom/iflytek/voiceads/NativeADDataRef;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/OptionFragment;

    .prologue
    .line 119
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->adDataRef:Lcom/iflytek/voiceads/NativeADDataRef;

    return-object v0
.end method

.method static synthetic access$1402(Lcom/cyjh/elfin/fragment/OptionFragment;Lcom/iflytek/voiceads/NativeADDataRef;)Lcom/iflytek/voiceads/NativeADDataRef;
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/OptionFragment;
    .param p1, "x1"    # Lcom/iflytek/voiceads/NativeADDataRef;

    .prologue
    .line 119
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->adDataRef:Lcom/iflytek/voiceads/NativeADDataRef;

    return-object p1
.end method

.method static synthetic access$1500(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/widget/ImageView;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/OptionFragment;

    .prologue
    .line 119
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mImgAd:Landroid/widget/ImageView;

    return-object v0
.end method

.method static synthetic access$1600(Lcom/cyjh/elfin/fragment/OptionFragment;)Lcom/iflytek/voiceads/IFLYNativeAd;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/OptionFragment;

    .prologue
    .line 119
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mNativeAd:Lcom/iflytek/voiceads/IFLYNativeAd;

    return-object v0
.end method

.method static synthetic access$1700(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/widget/TextView;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/OptionFragment;

    .prologue
    .line 119
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mTvDelete:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic access$1800(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/widget/TextView;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/OptionFragment;

    .prologue
    .line 119
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mTvILFYAdMark:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic access$1902(Lcom/cyjh/elfin/fragment/OptionFragment;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/OptionFragment;
    .param p1, "x1"    # Z

    .prologue
    .line 119
    iput-boolean p1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->checkOnFailIFLYAD:Z

    return p1
.end method

.method static synthetic access$200(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/widget/RelativeLayout;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/OptionFragment;

    .prologue
    .line 119
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mRelativeAd:Landroid/widget/RelativeLayout;

    return-object v0
.end method

.method static synthetic access$2002(Lcom/cyjh/elfin/fragment/OptionFragment;I)I
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/OptionFragment;
    .param p1, "x1"    # I

    .prologue
    .line 119
    iput p1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->counter:I

    return p1
.end method

.method static synthetic access$2008(Lcom/cyjh/elfin/fragment/OptionFragment;)I
    .locals 2
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/OptionFragment;

    .prologue
    .line 119
    iget v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->counter:I

    add-int/lit8 v1, v0, 0x1

    iput v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->counter:I

    return v0
.end method

.method static synthetic access$300(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/widget/RelativeLayout;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/OptionFragment;

    .prologue
    .line 119
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mRelativeBtn:Landroid/widget/RelativeLayout;

    return-object v0
.end method

.method static synthetic access$400(Lcom/cyjh/elfin/fragment/OptionFragment;)Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/OptionFragment;

    .prologue
    .line 119
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->backgroundSettingsAdStats:Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;

    return-object v0
.end method

.method static synthetic access$500(Lcom/cyjh/elfin/fragment/OptionFragment;)Lcom/cyjh/elfin/activity/ElfinFreeActivity;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/OptionFragment;

    .prologue
    .line 119
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->elfinFreeActivity:Lcom/cyjh/elfin/activity/ElfinFreeActivity;

    return-object v0
.end method

.method static synthetic access$600(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/support/v4/app/NotificationCompat$Builder;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/OptionFragment;

    .prologue
    .line 119
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    return-object v0
.end method

.method static synthetic access$700(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/app/NotificationManager;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/OptionFragment;

    .prologue
    .line 119
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mNotifyManager:Landroid/app/NotificationManager;

    return-object v0
.end method

.method static synthetic access$800(Lcom/cyjh/elfin/fragment/OptionFragment;)Lcom/cyjh/elfin/dialog/DownloadDialogFragment;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/OptionFragment;

    .prologue
    .line 119
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->downloadDialog:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    return-object v0
.end method

.method private clickImgAd()V
    .locals 9

    .prologue
    const/4 v8, 0x0

    .line 1112
    const-string v4, "zzz"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "clickImgAd--"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-boolean v6, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->checkOnFailIFLYAD:Z

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ",ad---"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->ad:Lcom/cyjh/elfin/entity/Ad;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1113
    iget-object v4, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->ad:Lcom/cyjh/elfin/entity/Ad;

    if-eqz v4, :cond_3

    iget-boolean v4, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->checkOnFailIFLYAD:Z

    if-eqz v4, :cond_3

    .line 1114
    iget-object v4, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->ad:Lcom/cyjh/elfin/entity/Ad;

    iget-object v4, v4, Lcom/cyjh/elfin/entity/Ad;->Data:Ljava/util/List;

    invoke-interface {v4, v8}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/entity/Ad$DataBean;

    .line 1116
    .local v0, "dataBean":Lcom/cyjh/elfin/entity/Ad$DataBean;
    iget-object v4, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->backgroundSettingsAdStats:Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v5

    iget-object v6, v0, Lcom/cyjh/elfin/entity/Ad$DataBean;->Id:Ljava/lang/String;

    const-string v7, "1"

    invoke-virtual {v4, v5, v6, v7}, Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;->backgroundStatisticsAdCount(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    .line 1135
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ",dataBean.LinkType=="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, v0, Lcom/cyjh/elfin/entity/Ad$DataBean;->LinkType:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    new-array v5, v8, [Ljava/lang/Object;

    invoke-static {v4, v5}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1136
    iget-object v4, v0, Lcom/cyjh/elfin/entity/Ad$DataBean;->LinkType:Ljava/lang/String;

    const-string v5, "1"

    invoke-static {v4, v5}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 1137
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ",dataBean.Link="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, v0, Lcom/cyjh/elfin/entity/Ad$DataBean;->Link:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    new-array v5, v8, [Ljava/lang/Object;

    invoke-static {v4, v5}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1138
    iget-object v4, v0, Lcom/cyjh/elfin/entity/Ad$DataBean;->Link:Ljava/lang/String;

    invoke-static {v4}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v3

    .line 1139
    .local v3, "uri":Landroid/net/Uri;
    new-instance v2, Landroid/content/Intent;

    const-string v4, "android.intent.action.VIEW"

    invoke-direct {v2, v4, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    .line 1140
    .local v2, "intent":Landroid/content/Intent;
    const/high16 v4, 0x10000000

    invoke-virtual {v2, v4}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 1141
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v4

    invoke-virtual {v4, v2}, Landroid/support/v4/app/FragmentActivity;->startActivity(Landroid/content/Intent;)V

    .line 1157
    .end local v0    # "dataBean":Lcom/cyjh/elfin/entity/Ad$DataBean;
    .end local v2    # "intent":Landroid/content/Intent;
    .end local v3    # "uri":Landroid/net/Uri;
    :cond_0
    :goto_0
    return-void

    .line 1142
    .restart local v0    # "dataBean":Lcom/cyjh/elfin/entity/Ad$DataBean;
    :cond_1
    iget-object v4, v0, Lcom/cyjh/elfin/entity/Ad$DataBean;->LinkType:Ljava/lang/String;

    const-string v5, "2"

    invoke-static {v4, v5}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 1143
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ",dataBean.AdvertisementTitle="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, v0, Lcom/cyjh/elfin/entity/Ad$DataBean;->AdvertisementTitle:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    new-array v5, v8, [Ljava/lang/Object;

    invoke-static {v4, v5}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1144
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "dataBean.LinkType,\"2\",dataBean.Link="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, v0, Lcom/cyjh/elfin/entity/Ad$DataBean;->Link:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    new-array v5, v8, [Ljava/lang/Object;

    invoke-static {v4, v5}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1145
    iget-object v4, v0, Lcom/cyjh/elfin/entity/Ad$DataBean;->AdvertisementTitle:Ljava/lang/String;

    const v5, 0x7f0800fd

    invoke-virtual {p0, v5}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 1146
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->getContext()Landroid/content/Context;

    move-result-object v4

    iget-object v5, v0, Lcom/cyjh/elfin/entity/Ad$DataBean;->AdvertisementTitle:Ljava/lang/String;

    invoke-static {v4, v5}, Lcom/cyjh/elfin/util/IntentUtils;->toCallAbGames(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_0

    .line 1148
    :cond_2
    new-instance v1, Lcom/cyjh/elfin/entity/GameInfo;

    invoke-direct {v1}, Lcom/cyjh/elfin/entity/GameInfo;-><init>()V

    .line 1149
    .local v1, "gameInfo":Lcom/cyjh/elfin/entity/GameInfo;
    iget-object v4, v0, Lcom/cyjh/elfin/entity/Ad$DataBean;->Link:Ljava/lang/String;

    iput-object v4, v1, Lcom/cyjh/elfin/entity/GameInfo;->Id:Ljava/lang/String;

    .line 1150
    iget-object v4, v0, Lcom/cyjh/elfin/entity/Ad$DataBean;->AdvertisementTitle:Ljava/lang/String;

    iput-object v4, v1, Lcom/cyjh/elfin/entity/GameInfo;->Name:Ljava/lang/String;

    .line 1151
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-static {v4, v1}, Lcom/cyjh/elfin/util/IntentUtils;->toAbGamesDetailsActivity(Landroid/content/Context;Lcom/cyjh/elfin/entity/GameInfo;)V

    goto/16 :goto_0

    .line 1155
    .end local v0    # "dataBean":Lcom/cyjh/elfin/entity/Ad$DataBean;
    .end local v1    # "gameInfo":Lcom/cyjh/elfin/entity/GameInfo;
    :cond_3
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->clickXunFeiAd()V

    goto/16 :goto_0
.end method

.method private clickXunFeiAd()V
    .locals 4

    .prologue
    .line 1163
    const-string v1, "zzz"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "OptionFragment---clickXunFeiAd--"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-boolean v3, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->checkOnFailIFLYAD:Z

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ",--"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->adDataRef:Lcom/iflytek/voiceads/NativeADDataRef;

    invoke-virtual {v3}, Lcom/iflytek/voiceads/NativeADDataRef;->getAdtype()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1164
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->adDataRef:Lcom/iflytek/voiceads/NativeADDataRef;

    if-eqz v1, :cond_0

    iget-boolean v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->checkOnFailIFLYAD:Z

    if-nez v1, :cond_0

    .line 1165
    const-string v1, "zzz"

    const-string v2, "OptionFragment---clickXunFeiAd--2"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1166
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->adDataRef:Lcom/iflytek/voiceads/NativeADDataRef;

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mImgAd:Landroid/widget/ImageView;

    invoke-virtual {v1, v2}, Lcom/iflytek/voiceads/NativeADDataRef;->onClicked(Landroid/view/View;)Z

    move-result v0

    .line 1167
    .local v0, "xunFeiAdClick":Z
    const-string v1, "zzz"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "OptionFragment---clickXunFeiAd--3"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1169
    .end local v0    # "xunFeiAdClick":Z
    :cond_0
    return-void
.end method

.method private initData()V
    .locals 0

    .prologue
    .line 233
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->copyScriptFiles()V

    .line 234
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->initNotification()V

    .line 235
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->initNativeAd()V

    .line 236
    return-void
.end method

.method private initNativeAd()V
    .locals 4

    .prologue
    .line 239
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mNativeAd:Lcom/iflytek/voiceads/IFLYNativeAd;

    if-nez v0, :cond_0

    .line 240
    new-instance v0, Lcom/iflytek/voiceads/IFLYNativeAd;

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    const-string v2, "410D8AC18806EDFE511A00EFD3329F20"

    iget-object v3, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mNativeListener:Lcom/iflytek/voiceads/IFLYNativeListener;

    invoke-direct {v0, v1, v2, v3}, Lcom/iflytek/voiceads/IFLYNativeAd;-><init>(Landroid/content/Context;Ljava/lang/String;Lcom/iflytek/voiceads/IFLYNativeListener;)V

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mNativeAd:Lcom/iflytek/voiceads/IFLYNativeAd;

    .line 242
    :cond_0
    return-void
.end method

.method private initNotification()V
    .locals 2

    .prologue
    .line 984
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const-string v1, "notification"

    invoke-virtual {v0, v1}, Landroid/support/v4/app/FragmentActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mNotifyManager:Landroid/app/NotificationManager;

    .line 985
    new-instance v0, Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/support/v4/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    .line 986
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    const-string v1, "\u4e0b\u8f7d"

    invoke-virtual {v0, v1}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v0

    const-string v1, "\u6e38\u620f\u8702\u7a9d\u4e0b\u8f7d"

    .line 987
    invoke-virtual {v0, v1}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v0

    const v1, 0x7f020098

    .line 988
    invoke-virtual {v0, v1}, Landroid/support/v4/app/NotificationCompat$Builder;->setSmallIcon(I)Landroid/support/v4/app/NotificationCompat$Builder;

    .line 989
    return-void
.end method

.method private initQUI()V
    .locals 9

    .prologue
    const/4 v8, 0x1

    .line 513
    new-instance v3, Lcom/cyjh/mqm/MiscUtilities;

    invoke-direct {v3}, Lcom/cyjh/mqm/MiscUtilities;-><init>()V

    .line 514
    .local v3, "miscUtilities":Lcom/cyjh/mqm/MiscUtilities;
    const/4 v2, 0x0

    .line 515
    .local v2, "linearLayout":Landroid/widget/LinearLayout;
    iget-object v4, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v4, v4, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v4}, Lcom/cyjh/elfin/entity/Script;->getUipFile()Ljava/io/File;

    move-result-object v4

    invoke-virtual {v4}, Ljava/io/File;->length()J

    move-result-wide v4

    iput-wide v4, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->uipFileLength:J

    .line 516
    iget-object v4, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v4, v4, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v4}, Lcom/cyjh/elfin/entity/Script;->getUipFile()Ljava/io/File;

    move-result-object v4

    invoke-virtual {v4}, Ljava/io/File;->exists()Z

    move-result v4

    if-eqz v4, :cond_1

    iget-wide v4, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->uipFileLength:J

    const-wide/16 v6, 0x0

    cmp-long v4, v4, v6

    if-lez v4, :cond_1

    .line 518
    iget-object v4, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v4, v4, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v4}, Lcom/cyjh/elfin/entity/Script;->getUipFile()Ljava/io/File;

    move-result-object v4

    invoke-virtual {v4}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4, v8}, Lcom/cyjh/mqm/MiscUtilities;->LoadUIFile(Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v0

    .line 519
    .local v0, "JsonUI":Ljava/lang/String;
    iget-object v4, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "uip\u8f6c\u6362\u540e>>>"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 520
    iget-object v4, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v4, v4, Lcom/cyjh/elfin/AppContext;->mUipHelper:Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;

    const/4 v5, 0x0

    invoke-virtual {v4, v0, v5}, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->parseLayoutFromJson(Ljava/lang/String;Lcom/cyjh/mobileanjian/ipc/uip/IUipJsonParser;)Landroid/widget/LinearLayout;

    move-result-object v2

    .line 521
    iget-object v4, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->uipLinearLayoutUI:Landroid/widget/LinearLayout;

    invoke-virtual {v4}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 522
    iget-object v4, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->uipLinearLayoutUI:Landroid/widget/LinearLayout;

    invoke-virtual {v4, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 536
    :cond_0
    :goto_0
    :try_start_0
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->parseOptionJson()V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 547
    :goto_1
    return-void

    .line 525
    .end local v0    # "JsonUI":Ljava/lang/String;
    :cond_1
    iget-object v4, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v4, v4, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v4}, Lcom/cyjh/elfin/entity/Script;->getUiFile()Ljava/io/File;

    move-result-object v4

    invoke-virtual {v4}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4, v8}, Lcom/cyjh/mqm/MiscUtilities;->LoadUIFile(Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v0

    .line 526
    .restart local v0    # "JsonUI":Ljava/lang/String;
    iget-object v4, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "ui\u8f6c\u6362\u540e>>>"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 527
    invoke-direct {p0, v0}, Lcom/cyjh/elfin/fragment/OptionFragment;->ParsUIFile(Ljava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v2

    .line 528
    invoke-virtual {v2}, Landroid/widget/LinearLayout;->getChildCount()I

    move-result v4

    if-lez v4, :cond_0

    .line 529
    iget-object v4, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->scrollViewUI:Landroid/widget/ScrollView;

    const/4 v5, 0x0

    invoke-virtual {v4, v5}, Landroid/widget/ScrollView;->removeViewAt(I)V

    .line 530
    iget-object v4, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->scrollViewUI:Landroid/widget/ScrollView;

    invoke-virtual {v4, v2}, Landroid/widget/ScrollView;->addView(Landroid/view/View;)V

    goto :goto_0

    .line 537
    :catch_0
    move-exception v1

    .line 538
    .local v1, "e":Lorg/json/JSONException;
    invoke-virtual {v1}, Lorg/json/JSONException;->printStackTrace()V

    .line 539
    iget-object v4, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "\u5f02\u5e38"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v1}, Lorg/json/JSONException;->getMessage()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ","

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v1}, Lorg/json/JSONException;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    goto :goto_1
.end method

.method private initView()V
    .locals 4

    .prologue
    .line 370
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->viewParent:Landroid/view/View;

    const v3, 0x7f0f0107

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/ScrollView;

    iput-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->scrollViewUI:Landroid/widget/ScrollView;

    .line 371
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->viewParent:Landroid/view/View;

    const v3, 0x7f0f0106

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/LinearLayout;

    iput-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->uipLinearLayoutUI:Landroid/widget/LinearLayout;

    .line 372
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->viewParent:Landroid/view/View;

    const v3, 0x7f0f010a

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/Button;

    iput-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->btnRun:Landroid/widget/Button;

    .line 373
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->viewParent:Landroid/view/View;

    const v3, 0x7f0f010b

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/Button;

    iput-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mButtonMoreScripts:Landroid/widget/Button;

    .line 374
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->viewParent:Landroid/view/View;

    const v3, 0x7f0f00d3

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/RelativeLayout;

    iput-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mRelativeAd:Landroid/widget/RelativeLayout;

    .line 375
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->viewParent:Landroid/view/View;

    const v3, 0x7f0f0109

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/RelativeLayout;

    iput-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mRelativeBtn:Landroid/widget/RelativeLayout;

    .line 376
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->viewParent:Landroid/view/View;

    const v3, 0x7f0f00d4

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/ImageView;

    iput-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mImgAd:Landroid/widget/ImageView;

    .line 377
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->viewParent:Landroid/view/View;

    const v3, 0x7f0f00d5

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mTvDelete:Landroid/widget/TextView;

    .line 378
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mTvDelete:Landroid/widget/TextView;

    invoke-virtual {v2, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 379
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mImgAd:Landroid/widget/ImageView;

    invoke-virtual {v2, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 380
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->btnRun:Landroid/widget/Button;

    invoke-virtual {v2, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 381
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mButtonMoreScripts:Landroid/widget/Button;

    invoke-virtual {v2, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 382
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->viewParent:Landroid/view/View;

    const v3, 0x7f0f00d6

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mTvILFYAdMark:Landroid/widget/TextView;

    .line 384
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getResolution(Landroid/content/Context;)Landroid/graphics/Point;

    move-result-object v1

    .line 385
    .local v1, "resolution":Landroid/graphics/Point;
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->uipLinearLayoutUI:Landroid/widget/LinearLayout;

    invoke-virtual {v2}, Landroid/widget/LinearLayout;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout$LayoutParams;

    .line 386
    .local v0, "params":Landroid/widget/LinearLayout$LayoutParams;
    iget v2, v1, Landroid/graphics/Point;->x:I

    int-to-float v2, v2

    const v3, 0x3f666666    # 0.9f

    mul-float/2addr v2, v3

    float-to-int v2, v2

    iput v2, v0, Landroid/widget/LinearLayout$LayoutParams;->width:I

    .line 387
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->uipLinearLayoutUI:Landroid/widget/LinearLayout;

    invoke-virtual {v2, v0}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 389
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mTvDelete:Landroid/widget/TextView;

    const-string v3, "#ffffff"

    invoke-static {v3}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setTextColor(I)V

    .line 390
    return-void
.end method

.method private parseOptionJson()V
    .locals 14
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .prologue
    .line 1261
    iget-object v10, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v10, v10, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v10}, Lcom/cyjh/elfin/entity/Script;->getCfgFile()Ljava/io/File;

    move-result-object v0

    .line 1262
    .local v0, "cfgFile":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v10

    if-nez v10, :cond_1

    .line 1296
    :cond_0
    :goto_0
    return-void

    .line 1265
    :cond_1
    iget-object v10, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v10, v10, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v10}, Lcom/cyjh/elfin/entity/Script;->getUipFile()Ljava/io/File;

    move-result-object v10

    invoke-virtual {v10}, Ljava/io/File;->exists()Z

    move-result v10

    if-eqz v10, :cond_3

    iget-wide v10, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->uipFileLength:J

    const-wide/16 v12, 0x0

    cmp-long v10, v10, v12

    if-lez v10, :cond_3

    .line 1266
    invoke-static {v0}, Lcom/cyjh/elfin/util/FileUtils;->readTextFile(Ljava/io/File;)Ljava/lang/String;

    move-result-object v4

    .line 1267
    .local v4, "json":Ljava/lang/String;
    iget-object v10, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v10, v10, Lcom/cyjh/elfin/AppContext;->mUipHelper:Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;

    if-nez v10, :cond_2

    .line 1268
    iget-object v10, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    new-instance v11, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v12

    invoke-direct {v11, v12}, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;-><init>(Landroid/content/Context;)V

    iput-object v11, v10, Lcom/cyjh/elfin/AppContext;->mUipHelper:Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;

    .line 1270
    :cond_2
    iget-object v10, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v10, v10, Lcom/cyjh/elfin/AppContext;->mUipHelper:Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;

    invoke-virtual {v10, v4}, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->configViewFromJson(Ljava/lang/String;)V

    goto :goto_0

    .line 1273
    .end local v4    # "json":Ljava/lang/String;
    :cond_3
    invoke-static {v0}, Lcom/cyjh/elfin/util/FileUtils;->readTextFile(Ljava/io/File;)Ljava/lang/String;

    move-result-object v4

    .line 1274
    .restart local v4    # "json":Ljava/lang/String;
    new-instance v6, Lorg/json/JSONObject;

    invoke-direct {v6, v4}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 1275
    .local v6, "propObject":Lorg/json/JSONObject;
    iget-object v10, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "json:"

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 1276
    iget-object v10, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "SpinnerList:"

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    iget-object v12, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->SpinnerList:Ljava/util/ArrayList;

    invoke-virtual {v12}, Ljava/util/ArrayList;->size()I

    move-result v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 1277
    iget-object v10, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->SpinnerList:Ljava/util/ArrayList;

    invoke-virtual {v10}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v10

    :goto_1
    invoke-interface {v10}, Ljava/util/Iterator;->hasNext()Z

    move-result v11

    if-eqz v11, :cond_4

    invoke-interface {v10}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Landroid/widget/Spinner;

    .line 1278
    .local v7, "spinner":Landroid/widget/Spinner;
    invoke-virtual {v7}, Landroid/widget/Spinner;->getTag()Ljava/lang/Object;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v9

    .line 1279
    .local v9, "tag":Ljava/lang/String;
    iget-object v11, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "parseOptionJson Spinner tag>>>"

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 1280
    invoke-virtual {v6, v9}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v5

    .line 1281
    .local v5, "position":I
    invoke-virtual {v7, v5}, Landroid/widget/Spinner;->setSelection(I)V

    goto :goto_1

    .line 1283
    .end local v5    # "position":I
    .end local v7    # "spinner":Landroid/widget/Spinner;
    .end local v9    # "tag":Ljava/lang/String;
    :cond_4
    iget-object v10, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "CheckBoxList:"

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    iget-object v12, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->CheckBoxList:Ljava/util/ArrayList;

    invoke-virtual {v12}, Ljava/util/ArrayList;->size()I

    move-result v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 1284
    iget-object v10, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->CheckBoxList:Ljava/util/ArrayList;

    invoke-virtual {v10}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v10

    :goto_2
    invoke-interface {v10}, Ljava/util/Iterator;->hasNext()Z

    move-result v11

    if-eqz v11, :cond_5

    invoke-interface {v10}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/widget/CheckBox;

    .line 1285
    .local v1, "checkBox":Landroid/widget/CheckBox;
    invoke-virtual {v1}, Landroid/widget/CheckBox;->getTag()Ljava/lang/Object;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v6, v11}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v2

    .line 1286
    .local v2, "checked":Z
    iget-object v11, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "parseOptionJson checkBoxList:"

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v12

    const-string v13, ",tag"

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v1}, Landroid/widget/CheckBox;->getTag()Ljava/lang/Object;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 1287
    invoke-virtual {v1, v2}, Landroid/widget/CheckBox;->setChecked(Z)V

    goto :goto_2

    .line 1289
    .end local v1    # "checkBox":Landroid/widget/CheckBox;
    .end local v2    # "checked":Z
    :cond_5
    iget-object v10, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "EditTextList:"

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    iget-object v12, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->EditTextList:Ljava/util/ArrayList;

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 1290
    iget-object v10, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "EditTextList:"

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    iget-object v12, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->EditTextList:Ljava/util/ArrayList;

    invoke-virtual {v12}, Ljava/util/ArrayList;->size()I

    move-result v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 1291
    iget-object v10, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->EditTextList:Ljava/util/ArrayList;

    invoke-virtual {v10}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v10

    :goto_3
    invoke-interface {v10}, Ljava/util/Iterator;->hasNext()Z

    move-result v11

    if-eqz v11, :cond_0

    invoke-interface {v10}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/widget/EditText;

    .line 1292
    .local v3, "editText":Landroid/widget/EditText;
    invoke-virtual {v3}, Landroid/widget/EditText;->getTag()Ljava/lang/Object;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v6, v11}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 1293
    .local v8, "string":Ljava/lang/String;
    iget-object v11, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "parseOptionJson:EditTextList"

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    const-string v13, ",tag"

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v3}, Landroid/widget/EditText;->getTag()Ljava/lang/Object;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 1294
    invoke-virtual {v3, v8}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    goto :goto_3
.end method

.method private showAdToBackstage(Lcom/cyjh/elfin/entity/Ad;)V
    .locals 5
    .param p1, "ad"    # Lcom/cyjh/elfin/entity/Ad;

    .prologue
    .line 477
    iget-object v1, p1, Lcom/cyjh/elfin/entity/Ad;->Data:Ljava/util/List;

    const/4 v2, 0x0

    invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/entity/Ad$DataBean;

    .line 478
    .local v0, "dataBean":Lcom/cyjh/elfin/entity/Ad$DataBean;
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->backgroundSettingsAdStats:Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    iget-object v3, v0, Lcom/cyjh/elfin/entity/Ad$DataBean;->Id:Ljava/lang/String;

    const-string v4, "2"

    invoke-virtual {v1, v2, v3, v4}, Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;->backgroundStatisticsAdCount(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    .line 480
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-static {v1}, Lcom/squareup/picasso/Picasso;->with(Landroid/content/Context;)Lcom/squareup/picasso/Picasso;

    move-result-object v1

    iget-object v2, v0, Lcom/cyjh/elfin/entity/Ad$DataBean;->Url:Ljava/lang/String;

    invoke-virtual {v1, v2}, Lcom/squareup/picasso/Picasso;->load(Ljava/lang/String;)Lcom/squareup/picasso/RequestCreator;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mImgAd:Landroid/widget/ImageView;

    new-instance v3, Lcom/cyjh/elfin/fragment/OptionFragment$1;

    invoke-direct {v3, p0, v0}, Lcom/cyjh/elfin/fragment/OptionFragment$1;-><init>(Lcom/cyjh/elfin/fragment/OptionFragment;Lcom/cyjh/elfin/entity/Ad$DataBean;)V

    invoke-virtual {v1, v2, v3}, Lcom/squareup/picasso/RequestCreator;->into(Landroid/widget/ImageView;Lcom/squareup/picasso/Callback;)V

    .line 496
    return-void
.end method

.method private startCountTimer()V
    .locals 2

    .prologue
    .line 499
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mCountTimer:Lcom/cyjh/elfin/fragment/OptionFragment$SubmitCountTimer;

    if-nez v0, :cond_0

    .line 500
    new-instance v0, Lcom/cyjh/elfin/fragment/OptionFragment$SubmitCountTimer;

    const/16 v1, 0xa

    invoke-direct {v0, p0, v1}, Lcom/cyjh/elfin/fragment/OptionFragment$SubmitCountTimer;-><init>(Lcom/cyjh/elfin/fragment/OptionFragment;I)V

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mCountTimer:Lcom/cyjh/elfin/fragment/OptionFragment$SubmitCountTimer;

    .line 502
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mCountTimer:Lcom/cyjh/elfin/fragment/OptionFragment$SubmitCountTimer;

    invoke-virtual {v0}, Lcom/cyjh/elfin/fragment/OptionFragment$SubmitCountTimer;->start()Landroid/os/CountDownTimer;

    .line 503
    return-void
.end method


# virtual methods
.method public copyScriptFiles()V
    .locals 20

    .prologue
    .line 298
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    move-object/from16 v17, v0

    invoke-virtual/range {v17 .. v17}, Lcom/cyjh/elfin/AppContext;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v3

    .line 300
    .local v3, "assets":Landroid/content/res/AssetManager;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    move-object/from16 v17, v0

    move-object/from16 v0, v17

    iget-object v0, v0, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    move-object/from16 v17, v0

    invoke-virtual/range {v17 .. v17}, Lcom/cyjh/elfin/entity/Script;->getLcFile()Ljava/io/File;

    move-result-object v7

    .line 301
    .local v7, "lcFile":Ljava/io/File;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    move-object/from16 v17, v0

    move-object/from16 v0, v17

    iget-object v0, v0, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    move-object/from16 v17, v0

    invoke-virtual/range {v17 .. v17}, Lcom/cyjh/elfin/entity/Script;->getPropFile()Ljava/io/File;

    move-result-object v9

    .line 302
    .local v9, "propFile":Ljava/io/File;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    move-object/from16 v17, v0

    move-object/from16 v0, v17

    iget-object v0, v0, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    move-object/from16 v17, v0

    invoke-virtual/range {v17 .. v17}, Lcom/cyjh/elfin/entity/Script;->getAtcFile()Ljava/io/File;

    move-result-object v4

    .line 303
    .local v4, "atcFile":Ljava/io/File;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    move-object/from16 v17, v0

    move-object/from16 v0, v17

    iget-object v0, v0, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    move-object/from16 v17, v0

    invoke-virtual/range {v17 .. v17}, Lcom/cyjh/elfin/entity/Script;->getUiFile()Ljava/io/File;

    move-result-object v13

    .line 304
    .local v13, "uiFile":Ljava/io/File;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    move-object/from16 v17, v0

    move-object/from16 v0, v17

    iget-object v0, v0, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    move-object/from16 v17, v0

    invoke-virtual/range {v17 .. v17}, Lcom/cyjh/elfin/entity/Script;->getUipFile()Ljava/io/File;

    move-result-object v15

    .line 305
    .local v15, "uipFile":Ljava/io/File;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    move-object/from16 v17, v0

    move-object/from16 v0, v17

    iget-object v0, v0, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    move-object/from16 v17, v0

    invoke-virtual/range {v17 .. v17}, Lcom/cyjh/elfin/entity/Script;->getRtdFile()Ljava/io/File;

    move-result-object v11

    .line 306
    .local v11, "rtdFile":Ljava/io/File;
    const/4 v8, 0x0

    .line 307
    .local v8, "lcInputStream":Ljava/io/InputStream;
    const/4 v10, 0x0

    .line 308
    .local v10, "propInputStream":Ljava/io/InputStream;
    const/4 v5, 0x0

    .line 309
    .local v5, "atcInputStream":Ljava/io/InputStream;
    const/4 v14, 0x0

    .line 310
    .local v14, "uiInputStream":Ljava/io/InputStream;
    const/16 v16, 0x0

    .line 311
    .local v16, "uipInputStream":Ljava/io/InputStream;
    const/4 v12, 0x0

    .line 314
    .local v12, "rtdInputStream":Ljava/io/InputStream;
    :try_start_0
    const-string v17, "script.lc"

    move-object/from16 v0, v17

    invoke-virtual {v3, v0}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v8

    .line 315
    const-string v17, "script.prop"

    move-object/from16 v0, v17

    invoke-virtual {v3, v0}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v10

    .line 316
    const-string v17, "script.atc"

    move-object/from16 v0, v17

    invoke-virtual {v3, v0}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v5

    .line 317
    const-string v17, "script.ui"

    move-object/from16 v0, v17

    invoke-virtual {v3, v0}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v14

    .line 318
    const-string v17, "script.uip"

    move-object/from16 v0, v17

    invoke-virtual {v3, v0}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v16

    .line 319
    const-string v17, "script.rtd"

    move-object/from16 v0, v17

    invoke-virtual {v3, v0}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v12

    .line 320
    new-instance v17, Lcom/cyjh/elfin/fragment/OptionFragment$copyScriptFilesTask;

    const/16 v18, 0x6

    move/from16 v0, v18

    new-array v0, v0, [Ljava/io/File;

    move-object/from16 v18, v0

    const/16 v19, 0x0

    aput-object v7, v18, v19

    const/16 v19, 0x1

    aput-object v9, v18, v19

    const/16 v19, 0x2

    aput-object v4, v18, v19

    const/16 v19, 0x3

    aput-object v13, v18, v19

    const/16 v19, 0x4

    aput-object v11, v18, v19

    const/16 v19, 0x5

    aput-object v15, v18, v19

    move-object/from16 v0, v17

    move-object/from16 v1, p0

    move-object/from16 v2, v18

    invoke-direct {v0, v1, v2}, Lcom/cyjh/elfin/fragment/OptionFragment$copyScriptFilesTask;-><init>(Lcom/cyjh/elfin/fragment/OptionFragment;[Ljava/io/File;)V

    const/16 v18, 0x6

    move/from16 v0, v18

    new-array v0, v0, [Ljava/io/InputStream;

    move-object/from16 v18, v0

    const/16 v19, 0x0

    aput-object v8, v18, v19

    const/16 v19, 0x1

    aput-object v10, v18, v19

    const/16 v19, 0x2

    aput-object v5, v18, v19

    const/16 v19, 0x3

    aput-object v14, v18, v19

    const/16 v19, 0x4

    aput-object v12, v18, v19

    const/16 v19, 0x5

    aput-object v16, v18, v19

    invoke-virtual/range {v17 .. v18}, Lcom/cyjh/elfin/fragment/OptionFragment$copyScriptFilesTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 327
    :goto_0
    return-void

    .line 322
    :catch_0
    move-exception v6

    .line 324
    .local v6, "e":Ljava/io/IOException;
    new-instance v17, Lcom/cyjh/elfin/fragment/OptionFragment$copyScriptFilesTask;

    const/16 v18, 0x5

    move/from16 v0, v18

    new-array v0, v0, [Ljava/io/File;

    move-object/from16 v18, v0

    const/16 v19, 0x0

    aput-object v7, v18, v19

    const/16 v19, 0x1

    aput-object v9, v18, v19

    const/16 v19, 0x2

    aput-object v4, v18, v19

    const/16 v19, 0x3

    aput-object v13, v18, v19

    const/16 v19, 0x4

    aput-object v15, v18, v19

    move-object/from16 v0, v17

    move-object/from16 v1, p0

    move-object/from16 v2, v18

    invoke-direct {v0, v1, v2}, Lcom/cyjh/elfin/fragment/OptionFragment$copyScriptFilesTask;-><init>(Lcom/cyjh/elfin/fragment/OptionFragment;[Ljava/io/File;)V

    const/16 v18, 0x5

    move/from16 v0, v18

    new-array v0, v0, [Ljava/io/InputStream;

    move-object/from16 v18, v0

    const/16 v19, 0x0

    aput-object v8, v18, v19

    const/16 v19, 0x1

    aput-object v10, v18, v19

    const/16 v19, 0x2

    aput-object v5, v18, v19

    const/16 v19, 0x3

    aput-object v14, v18, v19

    const/16 v19, 0x4

    aput-object v16, v18, v19

    invoke-virtual/range {v17 .. v18}, Lcom/cyjh/elfin/fragment/OptionFragment$copyScriptFilesTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    goto :goto_0
.end method

.method public downloadOnClick(Lcom/dd/processbutton/iml/SubmitProcessButton;)V
    .locals 4
    .param p1, "buttonDownload"    # Lcom/dd/processbutton/iml/SubmitProcessButton;

    .prologue
    .line 994
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->downloadDialog:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    iget-object v1, v1, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->apkPackageName:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/cyjh/elfin/util/AppDeviceUtils;->isAInstallPackage(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 995
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->downloadDialog:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    iget-object v1, v1, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->apkPackageName:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/cyjh/elfin/util/AppDeviceUtils;->openApp(Landroid/content/Context;Ljava/lang/String;)Z

    .line 1037
    :goto_0
    return-void

    .line 998
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->downloadDialog:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    iget-boolean v0, v0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->isDownloadComplete:Z

    if-eqz v0, :cond_1

    .line 999
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->downloadDialog:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    iget-object v1, v1, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->desApkFile:Ljava/io/File;

    invoke-static {v0, v1}, Lcom/cyjh/elfin/util/AppDeviceUtils;->installAPK(Landroid/content/Context;Ljava/io/File;)V

    .line 1000
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->downloadDialog:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    invoke-virtual {v0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->dismiss()V

    goto :goto_0

    .line 1003
    :cond_1
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/elfin/net/xutils/XUtilsHttpClient;->getInstence(Landroid/content/Context;)Lcom/lidroid/xutils/HttpUtils;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->downloadDialog:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    iget-object v1, v1, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->apkDownloadUrl:Ljava/lang/String;

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->downloadDialog:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    iget-object v2, v2, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->desApkFile:Ljava/io/File;

    .line 1004
    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Lcom/cyjh/elfin/fragment/OptionFragment$3;

    invoke-direct {v3, p0, p1}, Lcom/cyjh/elfin/fragment/OptionFragment$3;-><init>(Lcom/cyjh/elfin/fragment/OptionFragment;Lcom/dd/processbutton/iml/SubmitProcessButton;)V

    .line 1003
    invoke-virtual {v0, v1, v2, v3}, Lcom/lidroid/xutils/HttpUtils;->download(Ljava/lang/String;Ljava/lang/String;Lcom/lidroid/xutils/http/callback/RequestCallBack;)Lcom/lidroid/xutils/http/HttpHandler;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->downloadHandler:Lcom/lidroid/xutils/http/HttpHandler;

    goto :goto_0
.end method

.method public generateOptionJson()V
    .locals 12
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 1219
    iget-object v7, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v7, v7, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v7}, Lcom/cyjh/elfin/entity/Script;->getUipFile()Ljava/io/File;

    move-result-object v7

    invoke-virtual {v7}, Ljava/io/File;->exists()Z

    move-result v7

    if-eqz v7, :cond_0

    iget-wide v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->uipFileLength:J

    const-wide/16 v10, 0x0

    cmp-long v7, v8, v10

    if-lez v7, :cond_0

    .line 1221
    iget-object v7, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v7, v7, Lcom/cyjh/elfin/AppContext;->mUipHelper:Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;

    iget-object v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v8, v8, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v8}, Lcom/cyjh/elfin/entity/Script;->getCfgFile()Ljava/io/File;

    move-result-object v8

    invoke-virtual {v8}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->saveToConfigFile(Ljava/lang/String;)V

    .line 1252
    :goto_0
    return-void

    .line 1224
    :cond_0
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4}, Lorg/json/JSONObject;-><init>()V

    .line 1225
    .local v4, "optionJsonObject":Lorg/json/JSONObject;
    iget-object v7, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->CheckBoxList:Ljava/util/ArrayList;

    invoke-virtual {v7}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v7

    :goto_1
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_1

    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/widget/CheckBox;

    .line 1226
    .local v1, "checkBox":Landroid/widget/CheckBox;
    invoke-virtual {v1}, Landroid/widget/CheckBox;->getTag()Ljava/lang/Object;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v1}, Landroid/widget/CheckBox;->isChecked()Z

    move-result v9

    invoke-virtual {v4, v8, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 1227
    iget-object v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "generateOptionJson CheckBox tag"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v1}, Landroid/widget/CheckBox;->getTag()Ljava/lang/Object;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ",value"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v1}, Landroid/widget/CheckBox;->isChecked()Z

    move-result v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    goto :goto_1

    .line 1229
    .end local v1    # "checkBox":Landroid/widget/CheckBox;
    :cond_1
    iget-object v7, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->SpinnerList:Ljava/util/ArrayList;

    invoke-virtual {v7}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v7

    :goto_2
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_2

    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Landroid/widget/Spinner;

    .line 1230
    .local v6, "spinner":Landroid/widget/Spinner;
    iget-object v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "generateOptionJson Spinner tag"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v6}, Landroid/widget/Spinner;->getTag()Ljava/lang/Object;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ",value"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v6}, Landroid/widget/Spinner;->getSelectedItemPosition()I

    move-result v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 1231
    invoke-virtual {v6}, Landroid/widget/Spinner;->getTag()Ljava/lang/Object;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v6}, Landroid/widget/Spinner;->getSelectedItemPosition()I

    move-result v9

    invoke-virtual {v4, v8, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    goto :goto_2

    .line 1233
    .end local v6    # "spinner":Landroid/widget/Spinner;
    :cond_2
    iget-object v7, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->EditTextList:Ljava/util/ArrayList;

    invoke-virtual {v7}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v7

    :goto_3
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_3

    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/widget/EditText;

    .line 1234
    .local v2, "editText":Landroid/widget/EditText;
    iget-object v8, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "generateOptionJson EditText tag:"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v2}, Landroid/widget/EditText;->getTag()Ljava/lang/Object;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ",value"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v2}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 1235
    invoke-virtual {v2}, Landroid/widget/EditText;->getTag()Ljava/lang/Object;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v2}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v4, v8, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_3

    .line 1241
    .end local v2    # "editText":Landroid/widget/EditText;
    :cond_3
    new-instance v3, Ljava/io/FileOutputStream;

    iget-object v7, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v7, v7, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v7}, Lcom/cyjh/elfin/entity/Script;->getCfgFile()Ljava/io/File;

    move-result-object v7

    invoke-virtual {v7}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v3, v7}, Ljava/io/FileOutputStream;-><init>(Ljava/lang/String;)V

    .line 1247
    .local v3, "fileOutputStream":Ljava/io/FileOutputStream;
    new-instance v5, Ljava/io/OutputStreamWriter;

    const-string v7, "UTF-8"

    invoke-direct {v5, v3, v7}, Ljava/io/OutputStreamWriter;-><init>(Ljava/io/OutputStream;Ljava/lang/String;)V

    .line 1248
    .local v5, "outputStreamWriter":Ljava/io/OutputStreamWriter;
    new-instance v0, Ljava/io/BufferedWriter;

    invoke-direct {v0, v5}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;)V

    .line 1249
    .local v0, "bufferedWriter":Ljava/io/BufferedWriter;
    invoke-virtual {v4}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v0, v7}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V

    .line 1250
    iget-object v7, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "save:"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v4}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 1251
    invoke-virtual {v0}, Ljava/io/BufferedWriter;->close()V

    goto/16 :goto_0
.end method

.method public getFragmentLayoutId()I
    .locals 1

    .prologue
    .line 246
    const v0, 0x7f04004b

    return v0
.end method

.method public imgAdResult(Lcom/cyjh/elfin/entity/Ad;)V
    .locals 1
    .param p1, "ad"    # Lcom/cyjh/elfin/entity/Ad;

    .prologue
    .line 462
    iget-object v0, p1, Lcom/cyjh/elfin/entity/Ad;->Data:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_0

    .line 463
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->ad:Lcom/cyjh/elfin/entity/Ad;

    .line 465
    iget-boolean v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->isShowConfigAd:Z

    if-nez v0, :cond_0

    .line 466
    .line 470
    :cond_0
    return-void
.end method

.method public onActivityCreated(Landroid/os/Bundle;)V
    .locals 5
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    const/4 v4, 0x2

    .line 205
    invoke-super {p0, p1}, Lcom/cyjh/elfin/fragment/BaseFragement;->onActivityCreated(Landroid/os/Bundle;)V

    .line 206
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v1

    invoke-virtual {v1, p0}, Lorg/greenrobot/eventbus/EventBus;->register(Ljava/lang/Object;)V

    .line 207
    new-instance v1, Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;-><init>(Lcom/cyjh/elfin/mvp/views/AdImageView;)V

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->adImagePresenter:Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;

    .line 208
    new-instance v1, Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;

    invoke-direct {v1}, Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;-><init>()V

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->backgroundSettingsAdStats:Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;

    .line 210
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-static {v1}, Lcom/cyjh/elfin/util/NetworkUtils;->isAvailable(Landroid/content/Context;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 211
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->adImagePresenter:Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    const-class v3, Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-virtual {v3}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v4, v3}, Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;->adShow(Landroid/content/Context;ILjava/lang/String;)V

    .line 212
    new-instance v0, Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;

    invoke-direct {v0}, Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;-><init>()V

    .line 215
    .local v0, "iflyAdSwitchManager":Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-virtual {v0, v1, v4}, Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;->checkedSwitchAd(Landroid/content/Context;I)V

    .line 218
    .end local v0    # "iflyAdSwitchManager":Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;
    :cond_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 6
    .param p1, "v"    # Landroid/view/View;

    .prologue
    const/16 v5, 0x8

    const/4 v3, 0x0

    const/4 v4, 0x0

    .line 1041
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v1

    sparse-switch v1, :sswitch_data_0

    .line 1106
    :cond_0
    :goto_0
    return-void

    .line 1043
    :sswitch_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "\u9632\u6b62\u591a\u6b21\u70b9\u51fb:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->preventMultipleClicks:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-array v2, v3, [Ljava/lang/Object;

    invoke-static {v1, v2}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1044
    invoke-static {}, Lcom/cyjh/elfin/util/RootUtil;->isRoot()Z

    move-result v1

    if-nez v1, :cond_4

    .line 1045
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->downloadDialog:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->downloadDialog:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    invoke-virtual {v1}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->getDialog()Landroid/app/Dialog;

    move-result-object v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->downloadDialog:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    invoke-virtual {v1}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->getDialog()Landroid/app/Dialog;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/Dialog;->isShowing()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 1046
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->downloadDialog:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    invoke-virtual {v1}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->dismiss()V

    .line 1047
    iput-object v4, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->downloadDialog:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    .line 1049
    :cond_1
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->noRootDialog:Lcom/cyjh/elfin/dialog/NoRootDialog;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->noRootDialog:Lcom/cyjh/elfin/dialog/NoRootDialog;

    invoke-virtual {v1}, Lcom/cyjh/elfin/dialog/NoRootDialog;->isShowing()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 1050
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->noRootDialog:Lcom/cyjh/elfin/dialog/NoRootDialog;

    invoke-virtual {v1}, Lcom/cyjh/elfin/dialog/NoRootDialog;->dismiss()V

    .line 1051
    iput-object v4, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->noRootDialog:Lcom/cyjh/elfin/dialog/NoRootDialog;

    .line 1053
    :cond_2
    iget-boolean v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->preventMultipleClicks:Z

    if-nez v1, :cond_0

    .line 1054
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->preventMultipleClicks:Z

    .line 1055
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-static {v1}, Lcom/cyjh/elfin/util/NetworkUtils;->isAvailable(Landroid/content/Context;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 1056
    new-instance v0, Lcom/cyjh/elfin/mvp/managers/RootSetRequestManager;

    invoke-direct {v0}, Lcom/cyjh/elfin/mvp/managers/RootSetRequestManager;-><init>()V

    .line 1057
    .local v0, "rootManager":Lcom/cyjh/elfin/mvp/managers/RootSetRequestManager;
    const-string v1, "GetRootConfiguration"

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    const-class v3, Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-virtual {v3}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v1, v2, v3}, Lcom/cyjh/elfin/mvp/managers/RootSetRequestManager;->isRootRequired(Ljava/lang/String;Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_0

    .line 1059
    .end local v0    # "rootManager":Lcom/cyjh/elfin/mvp/managers/RootSetRequestManager;
    :cond_3
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v1

    new-instance v2, Lcom/cyjh/elfin/entity/MsgItem;

    const/16 v3, 0x3ed

    invoke-direct {v2, v3}, Lcom/cyjh/elfin/entity/MsgItem;-><init>(I)V

    invoke-virtual {v1, v2}, Lorg/greenrobot/eventbus/EventBus;->post(Ljava/lang/Object;)V

    goto/16 :goto_0

    .line 1064
    :cond_4
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mRunnableTask:Lcom/cyjh/elfin/fragment/OptionFragment$RunnableTask;

    if-nez v1, :cond_5

    .line 1065
    new-instance v1, Lcom/cyjh/elfin/fragment/OptionFragment$RunnableTask;

    invoke-direct {v1, p0, v4}, Lcom/cyjh/elfin/fragment/OptionFragment$RunnableTask;-><init>(Lcom/cyjh/elfin/fragment/OptionFragment;Lcom/cyjh/elfin/fragment/OptionFragment$1;)V

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mRunnableTask:Lcom/cyjh/elfin/fragment/OptionFragment$RunnableTask;

    .line 1067
    :cond_5
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mRunnableTask:Lcom/cyjh/elfin/fragment/OptionFragment$RunnableTask;

    invoke-virtual {v1}, Lcom/cyjh/elfin/fragment/OptionFragment$RunnableTask;->start()V

    goto/16 :goto_0

    .line 1070
    :sswitch_1
    iput-object v4, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->downloadDialog:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    .line 1072
    const-string v1, "http://m.anjian.com/help/jiaoben/youxifengwo-xiaojl.apk"

    const-string v2, "youxifengwo.apk"

    const-string v3, "com.cyjh.gundam"

    invoke-static {v1, v2, v3, v4}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->newInstance(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->downloadDialog:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    .line 1075
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->downloadDialog:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->downloadHandler:Lcom/lidroid/xutils/http/HttpHandler;

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->setHttpHandler(Lcom/lidroid/xutils/http/HttpHandler;)V

    .line 1076
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->downloadDialog:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    invoke-virtual {v1, p0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->setOnDownloadClickListener(Lcom/cyjh/elfin/dialog/DownloadDialogFragment$OnDownloadClickListener;)V

    .line 1077
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->downloadDialog:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->getFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object v2

    const-class v3, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    invoke-virtual {v3}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->show(Landroid/support/v4/app/FragmentManager;Ljava/lang/String;)V

    goto/16 :goto_0

    .line 1080
    :sswitch_2
    const-string v1, "zzz"

    const-string v2, "OptionFragment--- R.id.id_tv_delete--"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1081
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mRelativeAd:Landroid/widget/RelativeLayout;

    invoke-virtual {v1, v5}, Landroid/widget/RelativeLayout;->setVisibility(I)V

    .line 1082
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mRelativeBtn:Landroid/widget/RelativeLayout;

    invoke-virtual {v1, v3}, Landroid/widget/RelativeLayout;->setVisibility(I)V

    .line 1083
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mCountTimer:Lcom/cyjh/elfin/fragment/OptionFragment$SubmitCountTimer;

    if-eqz v1, :cond_6

    .line 1084
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mCountTimer:Lcom/cyjh/elfin/fragment/OptionFragment$SubmitCountTimer;

    invoke-virtual {v1}, Lcom/cyjh/elfin/fragment/OptionFragment$SubmitCountTimer;->cancel()V

    .line 1086
    :cond_6
    iget v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->counter:I

    const/4 v2, 0x5

    if-ge v1, v2, :cond_7

    .line 1087
    const-string v1, "zzz"

    const-string v2, "OptionFragment--- R.id.id_tv_delete--2"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1089
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->clickImgAd()V

    .line 1091
    :cond_7
    iput v3, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->counter:I

    goto/16 :goto_0

    .line 1094
    :sswitch_3
    const-string v1, "zzz"

    const-string v2, "OptionFragment---R.id.id_img_ad--"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1095
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->clickImgAd()V

    .line 1096
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mCountTimer:Lcom/cyjh/elfin/fragment/OptionFragment$SubmitCountTimer;

    if-eqz v1, :cond_8

    .line 1097
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mCountTimer:Lcom/cyjh/elfin/fragment/OptionFragment$SubmitCountTimer;

    invoke-virtual {v1}, Lcom/cyjh/elfin/fragment/OptionFragment$SubmitCountTimer;->cancel()V

    .line 1100
    :cond_8
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mRelativeAd:Landroid/widget/RelativeLayout;

    invoke-virtual {v1, v5}, Landroid/widget/RelativeLayout;->setVisibility(I)V

    .line 1101
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mRelativeBtn:Landroid/widget/RelativeLayout;

    invoke-virtual {v1, v3}, Landroid/widget/RelativeLayout;->setVisibility(I)V

    goto/16 :goto_0

    .line 1041
    nop

    :sswitch_data_0
    .sparse-switch
        0x7f0f00d4 -> :sswitch_3
        0x7f0f00d5 -> :sswitch_2
        0x7f0f010a -> :sswitch_0
        0x7f0f010b -> :sswitch_1
    .end sparse-switch
.end method

.method public onDestroy()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 268
    invoke-super {p0}, Lcom/cyjh/elfin/fragment/BaseFragement;->onDestroy()V

    .line 269
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v0

    invoke-virtual {v0, p0}, Lorg/greenrobot/eventbus/EventBus;->unregister(Ljava/lang/Object;)V

    .line 270
    invoke-static {}, Lcom/cyjh/elfin/mvp/managers/IFLYAdCountStatistics;->cancelReqCountStatistics()V

    .line 271
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->backgroundSettingsAdStats:Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;

    invoke-virtual {v0}, Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;->cancelReqCountStatistics()V

    .line 272
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mRunnableTask:Lcom/cyjh/elfin/fragment/OptionFragment$RunnableTask;

    if-eqz v0, :cond_0

    .line 273
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->handler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mRunnableTask:Lcom/cyjh/elfin/fragment/OptionFragment$RunnableTask;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 274
    iput-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mRunnableTask:Lcom/cyjh/elfin/fragment/OptionFragment$RunnableTask;

    .line 276
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->downloadDialog:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->downloadDialog:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    invoke-virtual {v0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->getDialog()Landroid/app/Dialog;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->downloadDialog:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    invoke-virtual {v0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->getDialog()Landroid/app/Dialog;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Dialog;->isShowing()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 277
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->downloadDialog:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    invoke-virtual {v0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->dismiss()V

    .line 278
    iput-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->downloadDialog:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    .line 280
    :cond_1
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->noRootDialog:Lcom/cyjh/elfin/dialog/NoRootDialog;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->noRootDialog:Lcom/cyjh/elfin/dialog/NoRootDialog;

    invoke-virtual {v0}, Lcom/cyjh/elfin/dialog/NoRootDialog;->isShowing()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 281
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->noRootDialog:Lcom/cyjh/elfin/dialog/NoRootDialog;

    invoke-virtual {v0}, Lcom/cyjh/elfin/dialog/NoRootDialog;->dismiss()V

    .line 282
    iput-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->noRootDialog:Lcom/cyjh/elfin/dialog/NoRootDialog;

    .line 284
    :cond_2
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mCountTimer:Lcom/cyjh/elfin/fragment/OptionFragment$SubmitCountTimer;

    if-eqz v0, :cond_3

    .line 285
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mCountTimer:Lcom/cyjh/elfin/fragment/OptionFragment$SubmitCountTimer;

    invoke-virtual {v0}, Lcom/cyjh/elfin/fragment/OptionFragment$SubmitCountTimer;->cancel()V

    .line 286
    iput-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mCountTimer:Lcom/cyjh/elfin/fragment/OptionFragment$SubmitCountTimer;

    .line 288
    :cond_3
    return-void
.end method

.method public onMessageMainThread(Lcom/cyjh/elfin/entity/MsgItem$CheckedSwitchAdEvent;)V
    .locals 4
    .param p1, "event"    # Lcom/cyjh/elfin/entity/MsgItem$CheckedSwitchAdEvent;
    .annotation runtime Lorg/greenrobot/eventbus/Subscribe;
        threadMode = .enum Lorg/greenrobot/eventbus/ThreadMode;->MAIN:Lorg/greenrobot/eventbus/ThreadMode;
    .end annotation

    .prologue
    const/4 v3, 0x1

    .line 419
    const-string v0, "zzz"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "MsgItem.CheckedSwitchAdEvent:event"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p1, Lcom/cyjh/elfin/entity/MsgItem$CheckedSwitchAdEvent;->isShow:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p1, Lcom/cyjh/elfin/entity/MsgItem$CheckedSwitchAdEvent;->status:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p1, Lcom/cyjh/elfin/entity/MsgItem$CheckedSwitchAdEvent;->type:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 420
    iget v0, p1, Lcom/cyjh/elfin/entity/MsgItem$CheckedSwitchAdEvent;->type:I

    const/4 v1, 0x4

    if-ne v0, v1, :cond_1

    iget-object v0, p1, Lcom/cyjh/elfin/entity/MsgItem$CheckedSwitchAdEvent;->status:Ljava/lang/String;

    const-string v1, "1"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-boolean v0, p1, Lcom/cyjh/elfin/entity/MsgItem$CheckedSwitchAdEvent;->isShow:Z

    if-eqz v0, :cond_1

    .line 421
    invoke-static {}, Lcom/cyjh/elfin/AppContext;->getInstance()Lcom/cyjh/elfin/AppContext;

    move-result-object v0

    iput-boolean v3, v0, Lcom/cyjh/elfin/AppContext;->isLoadBottomAd:Z

    .line 434
    :cond_0
    :goto_0
    return-void

    .line 422
    :cond_1
    iget v0, p1, Lcom/cyjh/elfin/entity/MsgItem$CheckedSwitchAdEvent;->type:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    .line 423
    iget-object v0, p1, Lcom/cyjh/elfin/entity/MsgItem$CheckedSwitchAdEvent;->status:Ljava/lang/String;

    const-string v1, "1"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    iget-boolean v0, p1, Lcom/cyjh/elfin/entity/MsgItem$CheckedSwitchAdEvent;->isShow:Z

    if-eqz v0, :cond_2

    .line 425
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mNativeAd:Lcom/iflytek/voiceads/IFLYNativeAd;

    invoke-virtual {v0, v3}, Lcom/iflytek/voiceads/IFLYNativeAd;->loadAd(I)V

    goto :goto_0

    .line 428
    :cond_2
    const-string v0, "zzz"

    const-string v1, "MsgItem.CheckedSwitchAdEvent"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 429
    iput-boolean v3, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->checkOnFailIFLYAD:Z

    .line 430
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->handler:Landroid/os/Handler;

    const/16 v1, 0x65

    invoke-virtual {v0, v1}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    goto :goto_0
.end method

.method public onMessageMainThread(Lcom/cyjh/elfin/entity/MsgItem$RootDataEvent;)V
    .locals 4
    .param p1, "event"    # Lcom/cyjh/elfin/entity/MsgItem$RootDataEvent;
    .annotation runtime Lorg/greenrobot/eventbus/Subscribe;
        threadMode = .enum Lorg/greenrobot/eventbus/ThreadMode;->MAIN:Lorg/greenrobot/eventbus/ThreadMode;
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 439
    iget-object v0, p1, Lcom/cyjh/elfin/entity/MsgItem$RootDataEvent;->data:Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;

    .line 440
    .local v0, "data":Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;
    iput-boolean v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->preventMultipleClicks:Z

    .line 441
    iget-object v1, v0, Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;->Type:Ljava/lang/String;

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v1, v2}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 442
    iget-object v1, v0, Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;->Type:Ljava/lang/String;

    const-string v2, "0"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 443
    new-instance v1, Lcom/cyjh/elfin/dialog/NoRootDialog;

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/cyjh/elfin/dialog/NoRootDialog;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->noRootDialog:Lcom/cyjh/elfin/dialog/NoRootDialog;

    .line 444
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->noRootDialog:Lcom/cyjh/elfin/dialog/NoRootDialog;

    invoke-virtual {v1}, Lcom/cyjh/elfin/dialog/NoRootDialog;->show()V

    .line 454
    :goto_0
    return-void

    .line 446
    :cond_0
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->downloadDialog:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    .line 448
    invoke-static {v0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->newInstance(Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;)Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->downloadDialog:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    .line 450
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->downloadDialog:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->downloadHandler:Lcom/lidroid/xutils/http/HttpHandler;

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->setHttpHandler(Lcom/lidroid/xutils/http/HttpHandler;)V

    .line 451
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->downloadDialog:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    invoke-virtual {v1, p0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->setOnDownloadClickListener(Lcom/cyjh/elfin/dialog/DownloadDialogFragment$OnDownloadClickListener;)V

    .line 452
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->downloadDialog:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->getFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object v2

    const-class v3, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    invoke-virtual {v3}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->show(Landroid/support/v4/app/FragmentManager;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public onMessageMainThread(Lcom/cyjh/elfin/entity/MsgItem;)V
    .locals 4
    .param p1, "msgItem"    # Lcom/cyjh/elfin/entity/MsgItem;
    .annotation runtime Lorg/greenrobot/eventbus/Subscribe;
        threadMode = .enum Lorg/greenrobot/eventbus/ThreadMode;->MAIN:Lorg/greenrobot/eventbus/ThreadMode;
    .end annotation

    .prologue
    const/4 v3, 0x0

    .line 398
    invoke-virtual {p1}, Lcom/cyjh/elfin/entity/MsgItem;->getMsgType()I

    move-result v0

    .line 399
    .local v0, "msgType":I
    sparse-switch v0, :sswitch_data_0

    .line 415
    :goto_0
    return-void

    .line 401
    :sswitch_0
    const-string v1, "\u63a5\u6536\u5230\u4e86\u6d88\u606f"

    new-array v2, v3, [Ljava/lang/Object;

    invoke-static {v1, v2}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 402
    new-instance v1, Lcom/cyjh/elfin/dialog/NoRootDialog;

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/cyjh/elfin/dialog/NoRootDialog;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->noRootDialog:Lcom/cyjh/elfin/dialog/NoRootDialog;

    .line 403
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->noRootDialog:Lcom/cyjh/elfin/dialog/NoRootDialog;

    invoke-virtual {v1}, Lcom/cyjh/elfin/dialog/NoRootDialog;->show()V

    .line 404
    iput-boolean v3, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->preventMultipleClicks:Z

    goto :goto_0

    .line 407
    :sswitch_1
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->initQUI()V

    goto :goto_0

    .line 410
    :sswitch_2
    const-string v1, "zzz"

    const-string v2, "MsgItem:MsgItem.IFLYAD_PARTSCREEN_REQ_FAIL"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 411
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->handler:Landroid/os/Handler;

    const/16 v2, 0x65

    invoke-virtual {v1, v2}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v1

    invoke-virtual {v1}, Landroid/os/Message;->sendToTarget()V

    .line 412
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->checkOnFailIFLYAD:Z

    goto :goto_0

    .line 399
    nop

    :sswitch_data_0
    .sparse-switch
        0x3ed -> :sswitch_0
        0x3f0 -> :sswitch_1
        0x3f3 -> :sswitch_2
    .end sparse-switch
.end method

.method public onPause()V
    .locals 1

    .prologue
    .line 292
    invoke-super {p0}, Lcom/cyjh/elfin/fragment/BaseFragement;->onPause()V

    .line 294
    const-class v0, Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/analytics/MobclickAgent;->onPageEnd(Ljava/lang/String;)V

    .line 295
    return-void
.end method

.method public onResume()V
    .locals 6

    .prologue
    .line 252
    invoke-super {p0}, Lcom/cyjh/elfin/fragment/BaseFragement;->onResume()V

    .line 254
    const-class v1, Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-virtual {v1}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/umeng/analytics/MobclickAgent;->onPageStart(Ljava/lang/String;)V

    .line 255
    iget-wide v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->uipFileLength:J

    const-wide/16 v4, 0x0

    cmp-long v1, v2, v4

    if-lez v1, :cond_0

    .line 256
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->initQUI()V

    .line 264
    :goto_0
    return-void

    .line 259
    :cond_0
    :try_start_0
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->parseOptionJson()V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 260
    :catch_0
    move-exception v0

    .line 261
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method

.method public onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 1
    .param p1, "outState"    # Landroid/os/Bundle;

    .prologue
    .line 199
    invoke-super {p0, p1}, Lcom/cyjh/elfin/fragment/BaseFragement;->onSaveInstanceState(Landroid/os/Bundle;)V

    .line 200
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/fragment/OptionFragment;->setUserVisibleHint(Z)V

    .line 201
    return-void
.end method

.method public onStop()V
    .locals 2

    .prologue
    const/16 v1, 0x8

    .line 1395
    invoke-super {p0}, Lcom/cyjh/elfin/fragment/BaseFragement;->onStop()V

    .line 1396
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mCountTimer:Lcom/cyjh/elfin/fragment/OptionFragment$SubmitCountTimer;

    if-eqz v0, :cond_1

    .line 1397
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mCountTimer:Lcom/cyjh/elfin/fragment/OptionFragment$SubmitCountTimer;

    invoke-virtual {v0}, Lcom/cyjh/elfin/fragment/OptionFragment$SubmitCountTimer;->cancel()V

    .line 1398
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mRelativeBtn:Landroid/widget/RelativeLayout;

    invoke-virtual {v0}, Landroid/widget/RelativeLayout;->getVisibility()I

    move-result v0

    if-ne v0, v1, :cond_0

    .line 1399
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mRelativeAd:Landroid/widget/RelativeLayout;

    invoke-virtual {v0, v1}, Landroid/widget/RelativeLayout;->setVisibility(I)V

    .line 1400
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mRelativeBtn:Landroid/widget/RelativeLayout;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/RelativeLayout;->setVisibility(I)V

    .line 1402
    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->mCountTimer:Lcom/cyjh/elfin/fragment/OptionFragment$SubmitCountTimer;

    .line 1404
    :cond_1
    return-void
.end method

.method public onViewCreated(Landroid/view/View;Landroid/os/Bundle;)V
    .locals 1
    .param p1, "view"    # Landroid/view/View;
    .param p2, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 222
    invoke-super {p0, p1, p2}, Lcom/cyjh/elfin/fragment/BaseFragement;->onViewCreated(Landroid/view/View;Landroid/os/Bundle;)V

    .line 223
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->elfinFreeActivity:Lcom/cyjh/elfin/activity/ElfinFreeActivity;

    .line 224
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->elfinFreeActivity:Lcom/cyjh/elfin/activity/ElfinFreeActivity;

    invoke-virtual {v0}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/AppContext;

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    .line 225
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->getView()Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 226
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->getView()Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment;->viewParent:Landroid/view/View;

    .line 227
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->initView()V

    .line 228
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/OptionFragment;->initData()V

    .line 230
    :cond_0
    return-void
.end method
