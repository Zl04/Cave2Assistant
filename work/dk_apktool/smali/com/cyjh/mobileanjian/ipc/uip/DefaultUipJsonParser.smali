.class public Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/cyjh/mobileanjian/ipc/uip/IUipJsonParser;


# instance fields
.field protected mContext:Landroid/content/Context;

.field private mDefaultFlowLayoutChildLayoutParams:Lcom/cyjh/mobileanjian/ipc/uip/a$a;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 2

    .prologue
    const/4 v1, -0x2

    .line 34
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 35
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    .line 36
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/uip/a$a;

    invoke-direct {v0, v1, v1}, Lcom/cyjh/mobileanjian/ipc/uip/a$a;-><init>(II)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mDefaultFlowLayoutChildLayoutParams:Lcom/cyjh/mobileanjian/ipc/uip/a$a;

    .line 40
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mDefaultFlowLayoutChildLayoutParams:Lcom/cyjh/mobileanjian/ipc/uip/a$a;

    const/16 v1, 0x11

    iput v1, v0, Lcom/cyjh/mobileanjian/ipc/uip/a$a;->a:I

    .line 41
    return-void
.end method


# virtual methods
.method public parseButton(Landroid/util/JsonReader;)Landroid/widget/Button;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljava/lang/IllegalStateException;
        }
    .end annotation

    .prologue
    const/4 v2, -0x2

    .line 137
    new-instance v0, Landroid/widget/Button;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    invoke-direct {v0, v1}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V

    .line 138
    const/16 v1, 0x11

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setGravity(I)V

    .line 139
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v1, v2, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 140
    invoke-virtual {v0, v1}, Landroid/widget/Button;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 141
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    sget v2, Lcom/cyjh/rootipc/R$integer;->ui_textSize_normal:I

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v1

    int-to-float v1, v1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setTextSize(F)V

    .line 142
    invoke-virtual {p1}, Landroid/util/JsonReader;->beginObject()V

    .line 143
    :cond_0
    :goto_0
    invoke-virtual {p1}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_8

    .line 144
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 146
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$string;->ui_name:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 147
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    .line 149
    invoke-virtual {v0, v1}, Landroid/widget/Button;->setTag(Ljava/lang/Object;)V

    goto :goto_0

    .line 150
    :cond_1
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$string;->ui_textview_textcontent:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 151
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    .line 153
    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 155
    :cond_2
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$string;->ui_onclick:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 157
    sget v1, Lcom/cyjh/rootipc/R$id;->uip_function_key:I

    invoke-virtual {p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/Button;->setTag(ILjava/lang/Object;)V

    goto :goto_0

    .line 159
    :cond_3
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$string;->ui_textsize:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_5

    .line 160
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    .line 162
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    sget v3, Lcom/cyjh/rootipc/R$integer;->ui_textsize_min:I

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v2

    if-le v1, v2, :cond_4

    .line 163
    int-to-float v1, v1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setTextSize(F)V

    goto :goto_0

    .line 164
    :cond_4
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    sget v3, Lcom/cyjh/rootipc/R$integer;->ui_textSize_default:I

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v2

    if-eq v1, v2, :cond_0

    .line 165
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    sget v2, Lcom/cyjh/rootipc/R$integer;->ui_textsize_min:I

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v1

    int-to-float v1, v1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setTextSize(F)V

    goto/16 :goto_0

    .line 167
    :cond_5
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$string;->ui_layout_height:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_6

    .line 168
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    .line 170
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    sget v3, Lcom/cyjh/rootipc/R$integer;->ui_default_height:I

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v2

    if-le v1, v2, :cond_0

    .line 171
    invoke-virtual {v0, v1}, Landroid/widget/Button;->setHeight(I)V

    goto/16 :goto_0

    .line 173
    :cond_6
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$string;->ui_layout_width:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_7

    .line 174
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    .line 176
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    sget v3, Lcom/cyjh/rootipc/R$integer;->ui_default_width:I

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v2

    if-le v1, v2, :cond_0

    .line 177
    invoke-virtual {v0, v1}, Landroid/widget/Button;->setWidth(I)V

    goto/16 :goto_0

    .line 182
    :cond_7
    const-string v1, "ParsTextView\u6ca1\u6709\u6b64\u8282\u70b9"

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->e(Ljava/lang/String;)V

    .line 183
    invoke-virtual {p1}, Landroid/util/JsonReader;->skipValue()V

    goto/16 :goto_0

    .line 186
    :cond_8
    invoke-virtual {p1}, Landroid/util/JsonReader;->endObject()V

    .line 188
    return-object v0
.end method

.method public parseCheckBox(Landroid/util/JsonReader;)Landroid/widget/CheckBox;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljava/lang/IllegalStateException;
        }
    .end annotation

    .prologue
    const/4 v2, -0x2

    .line 265
    new-instance v0, Landroid/widget/CheckBox;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    invoke-direct {v0, v1}, Landroid/widget/CheckBox;-><init>(Landroid/content/Context;)V

    .line 266
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v1, v2, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 267
    invoke-virtual {v0, v1}, Landroid/widget/CheckBox;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 268
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    sget v2, Lcom/cyjh/rootipc/R$integer;->ui_textSize_normal:I

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v1

    int-to-float v1, v1

    invoke-virtual {v0, v1}, Landroid/widget/CheckBox;->setTextSize(F)V

    .line 269
    invoke-virtual {p1}, Landroid/util/JsonReader;->beginObject()V

    .line 270
    :cond_0
    :goto_0
    invoke-virtual {p1}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_a

    .line 271
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 273
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$string;->ui_name:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 274
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    .line 275
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\u540d\u79f0>>>>"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->e(Ljava/lang/String;)V

    .line 276
    invoke-virtual {v0, v1}, Landroid/widget/CheckBox;->setTag(Ljava/lang/Object;)V

    goto :goto_0

    .line 278
    :cond_1
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$string;->ui_onclick:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 280
    sget v1, Lcom/cyjh/rootipc/R$id;->uip_function_key:I

    invoke-virtual {p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/CheckBox;->setTag(ILjava/lang/Object;)V

    goto :goto_0

    .line 282
    :cond_2
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$string;->ui_checkbox_hintcontent:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 283
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    .line 285
    invoke-virtual {v0, v1}, Landroid/widget/CheckBox;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 286
    :cond_3
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$string;->ui_checkbox_checked:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_5

    .line 287
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextBoolean()Z

    move-result v1

    .line 289
    if-eqz v1, :cond_4

    .line 290
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/CheckBox;->setChecked(Z)V

    goto :goto_0

    .line 292
    :cond_4
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/CheckBox;->setChecked(Z)V

    goto/16 :goto_0

    .line 294
    :cond_5
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$string;->ui_textsize:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_7

    .line 295
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    .line 297
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    sget v3, Lcom/cyjh/rootipc/R$integer;->ui_textsize_min:I

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v2

    if-le v1, v2, :cond_6

    .line 298
    int-to-float v1, v1

    invoke-virtual {v0, v1}, Landroid/widget/CheckBox;->setTextSize(F)V

    goto/16 :goto_0

    .line 299
    :cond_6
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    sget v3, Lcom/cyjh/rootipc/R$integer;->ui_textSize_default:I

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v2

    if-eq v1, v2, :cond_0

    .line 300
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    sget v2, Lcom/cyjh/rootipc/R$integer;->ui_textsize_min:I

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v1

    int-to-float v1, v1

    invoke-virtual {v0, v1}, Landroid/widget/CheckBox;->setTextSize(F)V

    goto/16 :goto_0

    .line 302
    :cond_7
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$string;->ui_layout_height:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_8

    .line 303
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    .line 305
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    sget v3, Lcom/cyjh/rootipc/R$integer;->ui_default_height:I

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v2

    if-le v1, v2, :cond_0

    .line 306
    invoke-virtual {v0, v1}, Landroid/widget/CheckBox;->setHeight(I)V

    goto/16 :goto_0

    .line 308
    :cond_8
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$string;->ui_layout_width:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_9

    .line 309
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    .line 311
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    sget v3, Lcom/cyjh/rootipc/R$integer;->ui_default_width:I

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v2

    if-le v1, v2, :cond_0

    .line 312
    invoke-virtual {v0, v1}, Landroid/widget/CheckBox;->setWidth(I)V

    goto/16 :goto_0

    .line 317
    :cond_9
    const-string v1, "ParsCheckBox\u6ca1\u6709\u6b64\u8282\u70b9"

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->e(Ljava/lang/String;)V

    .line 318
    invoke-virtual {p1}, Landroid/util/JsonReader;->skipValue()V

    goto/16 :goto_0

    .line 321
    :cond_a
    invoke-virtual {p1}, Landroid/util/JsonReader;->endObject()V

    .line 322
    return-object v0
.end method

.method public parseEditText(Landroid/util/JsonReader;)Landroid/widget/EditText;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljava/lang/IllegalStateException;
        }
    .end annotation

    .prologue
    const/4 v5, 0x1

    const/4 v1, 0x0

    const/4 v3, -0x2

    .line 194
    new-instance v2, Landroid/widget/EditText;

    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    invoke-direct {v2, v0}, Landroid/widget/EditText;-><init>(Landroid/content/Context;)V

    .line 195
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v0, v3, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 196
    invoke-virtual {v2, v0}, Landroid/widget/EditText;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 197
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    sget v3, Lcom/cyjh/rootipc/R$integer;->ui_textSize_normal:I

    invoke-virtual {v0, v3}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v0

    int-to-float v0, v0

    invoke-virtual {v2, v0}, Landroid/widget/EditText;->setTextSize(F)V

    .line 198
    invoke-virtual {v2, v5}, Landroid/widget/EditText;->setSingleLine(Z)V

    .line 199
    invoke-virtual {p1}, Landroid/util/JsonReader;->beginObject()V

    .line 200
    :cond_0
    :goto_0
    invoke-virtual {p1}, Landroid/util/JsonReader;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_a

    .line 201
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v0

    .line 203
    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v4, Lcom/cyjh/rootipc/R$string;->ui_name:I

    invoke-virtual {v3, v4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 204
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v0

    .line 206
    invoke-virtual {v2, v0}, Landroid/widget/EditText;->setTag(Ljava/lang/Object;)V

    goto :goto_0

    .line 207
    :cond_1
    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v4, Lcom/cyjh/rootipc/R$string;->ui_edittext_hintcontent:I

    invoke-virtual {v3, v4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 208
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v0

    .line 210
    invoke-virtual {v2, v0}, Landroid/widget/EditText;->setHint(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 211
    :cond_2
    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v4, Lcom/cyjh/rootipc/R$string;->ui_textsize:I

    invoke-virtual {v3, v4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_4

    .line 212
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v0

    .line 214
    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    sget v4, Lcom/cyjh/rootipc/R$integer;->ui_textsize_min:I

    invoke-virtual {v3, v4}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v3

    if-le v0, v3, :cond_3

    .line 215
    int-to-float v0, v0

    invoke-virtual {v2, v0}, Landroid/widget/EditText;->setTextSize(F)V

    goto :goto_0

    .line 216
    :cond_3
    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    sget v4, Lcom/cyjh/rootipc/R$integer;->ui_textSize_default:I

    invoke-virtual {v3, v4}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v3

    if-eq v0, v3, :cond_0

    .line 217
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    sget v3, Lcom/cyjh/rootipc/R$integer;->ui_textsize_min:I

    invoke-virtual {v0, v3}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v0

    int-to-float v0, v0

    invoke-virtual {v2, v0}, Landroid/widget/EditText;->setTextSize(F)V

    goto :goto_0

    .line 219
    :cond_4
    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v4, Lcom/cyjh/rootipc/R$string;->ui_layout_height:I

    invoke-virtual {v3, v4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_5

    .line 220
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v0

    .line 222
    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    sget v4, Lcom/cyjh/rootipc/R$integer;->ui_default_height:I

    invoke-virtual {v3, v4}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v3

    if-le v0, v3, :cond_0

    .line 223
    invoke-virtual {v2, v0}, Landroid/widget/EditText;->setHeight(I)V

    goto/16 :goto_0

    .line 225
    :cond_5
    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v4, Lcom/cyjh/rootipc/R$string;->ui_layout_width:I

    invoke-virtual {v3, v4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_6

    .line 226
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v0

    .line 228
    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    sget v4, Lcom/cyjh/rootipc/R$integer;->ui_default_width:I

    invoke-virtual {v3, v4}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v3

    if-le v0, v3, :cond_0

    .line 229
    invoke-virtual {v2, v0}, Landroid/widget/EditText;->setWidth(I)V

    goto/16 :goto_0

    .line 231
    :cond_6
    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v4, Lcom/cyjh/rootipc/R$string;->ui_edittext_maxlength:I

    invoke-virtual {v3, v4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_7

    .line 232
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v0

    .line 234
    if-lez v0, :cond_0

    .line 235
    new-array v3, v5, [Landroid/text/InputFilter;

    .line 236
    new-instance v4, Landroid/text/InputFilter$LengthFilter;

    invoke-direct {v4, v0}, Landroid/text/InputFilter$LengthFilter;-><init>(I)V

    aput-object v4, v3, v1

    .line 237
    invoke-virtual {v2, v3}, Landroid/widget/EditText;->setFilters([Landroid/text/InputFilter;)V

    goto/16 :goto_0

    .line 239
    :cond_7
    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v4, Lcom/cyjh/rootipc/R$string;->ui_edittext_inputnumber:I

    invoke-virtual {v3, v4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_8

    .line 242
    :try_start_0
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextBoolean()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 247
    :goto_1
    if-eqz v0, :cond_0

    .line 248
    const/4 v0, 0x2

    invoke-virtual {v2, v0}, Landroid/widget/EditText;->setInputType(I)V

    goto/16 :goto_0

    .line 243
    :catch_0
    move-exception v0

    .line 244
    const-string v0, "EditText\u89e3\u6790\u5f02\u5e38\u4e86"

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->e(Ljava/lang/String;)V

    move v0, v1

    goto :goto_1

    .line 250
    :cond_8
    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v4, Lcom/cyjh/rootipc/R$string;->ui_edittext_defaultcontent:I

    invoke-virtual {v3, v4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_9

    .line 251
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v0

    .line 252
    invoke-virtual {v2, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    goto/16 :goto_0

    .line 254
    :cond_9
    const-string v0, "ParsEditText\u6ca1\u6709\u6b64\u8282\u70b9"

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->e(Ljava/lang/String;)V

    .line 255
    invoke-virtual {p1}, Landroid/util/JsonReader;->skipValue()V

    goto/16 :goto_0

    .line 258
    :cond_a
    invoke-virtual {p1}, Landroid/util/JsonReader;->endObject()V

    .line 259
    return-object v2
.end method

.method public parseHorizontalLinearLayout(Landroid/util/JsonReader;)Lcom/cyjh/mobileanjian/ipc/uip/a;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljava/lang/IllegalStateException;
        }
    .end annotation

    .prologue
    .line 46
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/uip/a;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    invoke-direct {v0, v1}, Lcom/cyjh/mobileanjian/ipc/uip/a;-><init>(Landroid/content/Context;)V

    .line 47
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v2, -0x1

    const/4 v3, -0x2

    invoke-direct {v1, v2, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 49
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/uip/a;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 50
    const/16 v1, 0x10

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/uip/a;->setGravity(I)V

    .line 51
    invoke-virtual {p1}, Landroid/util/JsonReader;->beginObject()V

    .line 52
    :goto_0
    invoke-virtual {p1}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_6

    .line 53
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 55
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$string;->ui_linearlayout:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 56
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->parseHorizontalLinearLayout(Landroid/util/JsonReader;)Lcom/cyjh/mobileanjian/ipc/uip/a;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/uip/a;->addView(Landroid/view/View;)V

    goto :goto_0

    .line 57
    :cond_0
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$string;->ui_textview:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 58
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->parseTextView(Landroid/util/JsonReader;)Landroid/widget/TextView;

    move-result-object v1

    .line 59
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mDefaultFlowLayoutChildLayoutParams:Lcom/cyjh/mobileanjian/ipc/uip/a$a;

    invoke-virtual {v0, v1, v2}, Lcom/cyjh/mobileanjian/ipc/uip/a;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    goto :goto_0

    .line 60
    :cond_1
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$string;->ui_edittext:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 61
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->parseEditText(Landroid/util/JsonReader;)Landroid/widget/EditText;

    move-result-object v1

    .line 62
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mDefaultFlowLayoutChildLayoutParams:Lcom/cyjh/mobileanjian/ipc/uip/a$a;

    invoke-virtual {v0, v1, v2}, Lcom/cyjh/mobileanjian/ipc/uip/a;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    goto :goto_0

    .line 63
    :cond_2
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$string;->ui_checkbox:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 64
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->parseCheckBox(Landroid/util/JsonReader;)Landroid/widget/CheckBox;

    move-result-object v1

    .line 65
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mDefaultFlowLayoutChildLayoutParams:Lcom/cyjh/mobileanjian/ipc/uip/a$a;

    invoke-virtual {v0, v1, v2}, Lcom/cyjh/mobileanjian/ipc/uip/a;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    goto :goto_0

    .line 66
    :cond_3
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$string;->ui_spinner:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 67
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->parseSpinner(Landroid/util/JsonReader;)Landroid/widget/Spinner;

    move-result-object v1

    .line 68
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mDefaultFlowLayoutChildLayoutParams:Lcom/cyjh/mobileanjian/ipc/uip/a$a;

    invoke-virtual {v0, v1, v2}, Lcom/cyjh/mobileanjian/ipc/uip/a;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    goto :goto_0

    .line 69
    :cond_4
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$string;->ui_button:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 70
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->parseButton(Landroid/util/JsonReader;)Landroid/widget/Button;

    move-result-object v1

    .line 71
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mDefaultFlowLayoutChildLayoutParams:Lcom/cyjh/mobileanjian/ipc/uip/a$a;

    invoke-virtual {v0, v1, v2}, Lcom/cyjh/mobileanjian/ipc/uip/a;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    goto/16 :goto_0

    .line 73
    :cond_5
    const-string v1, "Parslayout\u6ca1\u6709\u6b64\u8282\u70b9"

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->e(Ljava/lang/String;)V

    .line 74
    invoke-virtual {p1}, Landroid/util/JsonReader;->skipValue()V

    goto/16 :goto_0

    .line 77
    :cond_6
    invoke-virtual {p1}, Landroid/util/JsonReader;->endObject()V

    .line 78
    return-object v0
.end method

.method public parseSpinner(Landroid/util/JsonReader;)Landroid/widget/Spinner;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljava/lang/IllegalStateException;
        }
    .end annotation

    .prologue
    const/4 v3, -0x2

    const/4 v1, 0x0

    .line 328
    new-instance v2, Landroid/widget/Spinner;

    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    invoke-direct {v2, v0}, Landroid/widget/Spinner;-><init>(Landroid/content/Context;)V

    .line 329
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v0, v3, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 330
    invoke-virtual {v2, v0}, Landroid/widget/Spinner;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 331
    sget v0, Lcom/cyjh/rootipc/R$drawable;->spinner_bg:I

    invoke-virtual {v2, v0}, Landroid/widget/Spinner;->setBackgroundResource(I)V

    .line 332
    const/4 v0, 0x5

    invoke-virtual {v2, v1, v1, v0, v1}, Landroid/widget/Spinner;->setPadding(IIII)V

    .line 333
    const/4 v0, 0x3

    invoke-virtual {v2, v0}, Landroid/widget/Spinner;->setGravity(I)V

    .line 334
    invoke-virtual {p1}, Landroid/util/JsonReader;->beginObject()V

    .line 335
    :goto_0
    invoke-virtual {p1}, Landroid/util/JsonReader;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_6

    .line 336
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v0

    .line 338
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 339
    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v5, Lcom/cyjh/rootipc/R$string;->ui_name:I

    invoke-virtual {v4, v5}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 340
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v0

    .line 342
    invoke-virtual {v2, v0}, Landroid/widget/Spinner;->setTag(Ljava/lang/Object;)V

    goto :goto_0

    .line 344
    :cond_0
    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v5, Lcom/cyjh/rootipc/R$string;->ui_onSelect:I

    invoke-virtual {v4, v5}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 346
    sget v0, Lcom/cyjh/rootipc/R$id;->uip_function_key:I

    invoke-virtual {p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v0, v3}, Landroid/widget/Spinner;->setTag(ILjava/lang/Object;)V

    goto :goto_0

    .line 348
    :cond_1
    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v5, Lcom/cyjh/rootipc/R$string;->ui_spinner_items:I

    invoke-virtual {v4, v5}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 350
    invoke-virtual {p1}, Landroid/util/JsonReader;->beginArray()V

    .line 351
    :goto_1
    invoke-virtual {p1}, Landroid/util/JsonReader;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 352
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v0

    .line 354
    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .line 356
    :cond_2
    invoke-virtual {p1}, Landroid/util/JsonReader;->endArray()V

    .line 357
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/uip/c;

    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    const v5, 0x1090008

    invoke-direct {v0, v4, v5, v3}, Lcom/cyjh/mobileanjian/ipc/uip/c;-><init>(Landroid/content/Context;ILjava/util/List;)V

    .line 358
    const v3, 0x1090009

    invoke-virtual {v0, v3}, Lcom/cyjh/mobileanjian/ipc/uip/c;->setDropDownViewResource(I)V

    .line 359
    invoke-virtual {v2, v0}, Landroid/widget/Spinner;->setAdapter(Landroid/widget/SpinnerAdapter;)V

    goto :goto_0

    .line 361
    :cond_3
    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v4, Lcom/cyjh/rootipc/R$string;->ui_spinner_defaultitem:I

    invoke-virtual {v3, v4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 362
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v0

    .line 363
    invoke-virtual {v2}, Landroid/widget/Spinner;->getAdapter()Landroid/widget/SpinnerAdapter;

    move-result-object v3

    invoke-interface {v3}, Landroid/widget/SpinnerAdapter;->getCount()I

    move-result v3

    .line 364
    if-ge v0, v3, :cond_4

    :goto_2
    invoke-virtual {v2, v0}, Landroid/widget/Spinner;->setSelection(I)V

    goto/16 :goto_0

    :cond_4
    move v0, v1

    goto :goto_2

    .line 371
    :cond_5
    const-string v0, "ParseSpinner\u6ca1\u6709\u6b64\u8282\u70b9"

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->e(Ljava/lang/String;)V

    .line 372
    invoke-virtual {p1}, Landroid/util/JsonReader;->skipValue()V

    goto/16 :goto_0

    .line 375
    :cond_6
    invoke-virtual {p1}, Landroid/util/JsonReader;->endObject()V

    .line 376
    return-object v2
.end method

.method public parseTextView(Landroid/util/JsonReader;)Landroid/widget/TextView;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljava/lang/IllegalStateException;
        }
    .end annotation

    .prologue
    const/4 v2, -0x2

    .line 85
    new-instance v0, Landroid/widget/TextView;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    invoke-direct {v0, v1}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 86
    const/16 v1, 0x11

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setGravity(I)V

    .line 87
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v1, v2, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 88
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 89
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    sget v2, Lcom/cyjh/rootipc/R$integer;->ui_textSize_normal:I

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v1

    int-to-float v1, v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextSize(F)V

    .line 90
    invoke-virtual {p1}, Landroid/util/JsonReader;->beginObject()V

    .line 91
    :cond_0
    :goto_0
    invoke-virtual {p1}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_7

    .line 92
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 94
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$string;->ui_name:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 95
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    .line 97
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTag(Ljava/lang/Object;)V

    goto :goto_0

    .line 98
    :cond_1
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$string;->ui_textview_textcontent:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 99
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    .line 101
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 102
    :cond_2
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$string;->ui_textsize:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 103
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    .line 105
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    sget v3, Lcom/cyjh/rootipc/R$integer;->ui_textsize_min:I

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v2

    if-le v1, v2, :cond_3

    .line 106
    int-to-float v1, v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextSize(F)V

    goto :goto_0

    .line 107
    :cond_3
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    sget v3, Lcom/cyjh/rootipc/R$integer;->ui_textSize_default:I

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v2

    if-eq v1, v2, :cond_0

    .line 108
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    sget v2, Lcom/cyjh/rootipc/R$integer;->ui_textsize_min:I

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v1

    int-to-float v1, v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextSize(F)V

    goto :goto_0

    .line 110
    :cond_4
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$string;->ui_layout_height:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_5

    .line 111
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    .line 113
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    sget v3, Lcom/cyjh/rootipc/R$integer;->ui_default_height:I

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v2

    if-le v1, v2, :cond_0

    .line 114
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setHeight(I)V

    goto/16 :goto_0

    .line 116
    :cond_5
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    sget v3, Lcom/cyjh/rootipc/R$string;->ui_layout_width:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_6

    .line 117
    invoke-virtual {p1}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    .line 119
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/uip/DefaultUipJsonParser;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    sget v3, Lcom/cyjh/rootipc/R$integer;->ui_default_width:I

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v2

    if-le v1, v2, :cond_0

    .line 120
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setWidth(I)V

    goto/16 :goto_0

    .line 125
    :cond_6
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ParsTextView\u6ca1\u6709\u6b64\u8282\u70b9: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->e(Ljava/lang/String;)V

    .line 126
    invoke-virtual {p1}, Landroid/util/JsonReader;->skipValue()V

    goto/16 :goto_0

    .line 129
    :cond_7
    invoke-virtual {p1}, Landroid/util/JsonReader;->endObject()V

    .line 131
    return-object v0
.end method
