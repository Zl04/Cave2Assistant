.class Lcom/cyjh/elfin/fragment/OptionFragment$2;
.super Ljava/lang/Object;
.source "OptionFragment.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/fragment/OptionFragment;->ParsButton(Landroid/util/JsonReader;)Landroid/widget/Button;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/fragment/OptionFragment;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/fragment/OptionFragment;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/fragment/OptionFragment;

    .prologue
    .line 967
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$2;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 970
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$2;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$500(Lcom/cyjh/elfin/fragment/OptionFragment;)Lcom/cyjh/elfin/activity/ElfinFreeActivity;

    move-result-object v0

    const-string v1, "\u70b9\u51fb\u4e86\u6309\u94ae\uff0c\u89e3\u6790\u65f6\u521b\u5efa\u7684"

    const/4 v2, 0x1

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 971
    return-void
.end method
