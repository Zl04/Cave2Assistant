.class Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$SubmitCountTimer;
.super Lcom/cyjh/elfin/counttimer/SecondTimer;
.source "BottomScreenDisplayXunFeiFloat.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "SubmitCountTimer"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;


# direct methods
.method public constructor <init>(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;I)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;
    .param p2, "secondsInFuture"    # I

    .prologue
    .line 161
    iput-object p1, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$SubmitCountTimer;->this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    .line 162
    invoke-direct {p0, p2}, Lcom/cyjh/elfin/counttimer/SecondTimer;-><init>(I)V

    .line 163
    return-void
.end method


# virtual methods
.method public onFinish()V
    .locals 2

    .prologue
    .line 180
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$SubmitCountTimer;->this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->access$202(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;I)I

    .line 181
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$SubmitCountTimer;->this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    const/4 v1, 0x1

    iput-boolean v1, v0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->isDisplayComplete:Z

    .line 182
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$SubmitCountTimer;->this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    invoke-static {v0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->access$100(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)V

    .line 183
    return-void
.end method

.method protected onTick(I)V
    .locals 8
    .param p1, "second"    # I

    .prologue
    const/16 v7, 0x11

    const/4 v6, 0x0

    .line 166
    iget-object v3, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$SubmitCountTimer;->this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    invoke-static {v3}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->access$208(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)I

    .line 167
    invoke-static {}, Lcom/cyjh/elfin/AppContext;->getInstance()Lcom/cyjh/elfin/AppContext;

    move-result-object v3

    const v4, 0x7f080031

    invoke-virtual {v3, v4}, Lcom/cyjh/elfin/AppContext;->getString(I)Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v4, v6

    invoke-static {v3, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 168
    .local v2, "text":Ljava/lang/String;
    new-instance v0, Landroid/text/SpannableString;

    invoke-direct {v0, v2}, Landroid/text/SpannableString;-><init>(Ljava/lang/CharSequence;)V

    .line 169
    .local v0, "spanText":Landroid/text/SpannableString;
    const-string v1, "\u70b9\u51fb\u5173\u95ed"

    .line 170
    .local v1, "str1":Ljava/lang/String;
    new-instance v3, Landroid/text/style/ForegroundColorSpan;

    const-string v4, "#ff7900"

    invoke-static {v4}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v4

    invoke-direct {v3, v4}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v4

    invoke-virtual {v0, v3, v6, v4, v7}, Landroid/text/SpannableString;->setSpan(Ljava/lang/Object;III)V

    .line 171
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

    .line 172
    iget-object v3, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$SubmitCountTimer;->this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    invoke-static {v3}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->access$700(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)Landroid/widget/TextView;

    move-result-object v3

    invoke-virtual {v3, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 173
    iget-object v3, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$SubmitCountTimer;->this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    invoke-static {v3}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->access$200(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)I

    move-result v3

    const/16 v4, 0xa

    if-le v3, v4, :cond_0

    .line 174
    invoke-virtual {p0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$SubmitCountTimer;->onFinish()V

    .line 176
    :cond_0
    return-void
.end method
