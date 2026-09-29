.class Lcom/cyjh/elfin/fragment/OptionFragment$SubmitCountTimer;
.super Lcom/cyjh/elfin/counttimer/SecondTimer;
.source "OptionFragment.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/fragment/OptionFragment;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "SubmitCountTimer"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/fragment/OptionFragment;


# direct methods
.method public constructor <init>(Lcom/cyjh/elfin/fragment/OptionFragment;I)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/fragment/OptionFragment;
    .param p2, "secondsInFuture"    # I

    .prologue
    .line 1367
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$SubmitCountTimer;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    .line 1368
    invoke-direct {p0, p2}, Lcom/cyjh/elfin/counttimer/SecondTimer;-><init>(I)V

    .line 1369
    return-void
.end method


# virtual methods
.method public onFinish()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 1386
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$SubmitCountTimer;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v0, v2}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$2002(Lcom/cyjh/elfin/fragment/OptionFragment;I)I

    .line 1388
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$SubmitCountTimer;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$200(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/widget/RelativeLayout;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/RelativeLayout;->setVisibility(I)V

    .line 1389
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$SubmitCountTimer;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$300(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/widget/RelativeLayout;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/widget/RelativeLayout;->setVisibility(I)V

    .line 1390
    return-void
.end method

.method protected onTick(I)V
    .locals 8
    .param p1, "second"    # I

    .prologue
    const/16 v7, 0x11

    const/4 v6, 0x0

    .line 1373
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/OptionFragment$SubmitCountTimer;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-virtual {v3}, Lcom/cyjh/elfin/fragment/OptionFragment;->isAdded()Z

    move-result v3

    if-eqz v3, :cond_0

    .line 1374
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/OptionFragment$SubmitCountTimer;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v3}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$2008(Lcom/cyjh/elfin/fragment/OptionFragment;)I

    .line 1375
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/OptionFragment$SubmitCountTimer;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    const v4, 0x7f080031

    invoke-virtual {v3, v4}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v4, v6

    invoke-static {v3, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 1376
    .local v2, "text":Ljava/lang/String;
    new-instance v0, Landroid/text/SpannableString;

    invoke-direct {v0, v2}, Landroid/text/SpannableString;-><init>(Ljava/lang/CharSequence;)V

    .line 1377
    .local v0, "spanText":Landroid/text/SpannableString;
    const-string v1, "\u70b9\u51fb\u5173\u95ed"

    .line 1378
    .local v1, "str1":Ljava/lang/String;
    new-instance v3, Landroid/text/style/ForegroundColorSpan;

    const-string v4, "#ff7900"

    invoke-static {v4}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v4

    invoke-direct {v3, v4}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v4

    invoke-virtual {v0, v3, v6, v4, v7}, Landroid/text/SpannableString;->setSpan(Ljava/lang/Object;III)V

    .line 1379
    new-instance v3, Landroid/text/style/ForegroundColorSpan;

    const-string v4, "#999999"

    invoke-static {v4}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v4

    invoke-direct {v3, v4}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v4

    add-int/lit8 v4, v4, 0x1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v5

    add-int/lit8 v5, v5, 0x2

    invoke-virtual {v0, v3, v4, v5, v7}, Landroid/text/SpannableString;->setSpan(Ljava/lang/Object;III)V

    .line 1380
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/OptionFragment$SubmitCountTimer;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v3}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$1700(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/widget/TextView;

    move-result-object v3

    invoke-virtual {v3, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 1382
    .end local v0    # "spanText":Landroid/text/SpannableString;
    .end local v1    # "str1":Ljava/lang/String;
    .end local v2    # "text":Ljava/lang/String;
    :cond_0
    return-void
.end method
