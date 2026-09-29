.class Lcom/cyjh/elfin/customview/TitleView$onLeftImageViewClickListener;
.super Ljava/lang/Object;
.source "TitleView.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/customview/TitleView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "onLeftImageViewClickListener"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/customview/TitleView;


# direct methods
.method private constructor <init>(Lcom/cyjh/elfin/customview/TitleView;)V
    .locals 0

    .prologue
    .line 166
    iput-object p1, p0, Lcom/cyjh/elfin/customview/TitleView$onLeftImageViewClickListener;->this$0:Lcom/cyjh/elfin/customview/TitleView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/cyjh/elfin/customview/TitleView;Lcom/cyjh/elfin/customview/TitleView$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/cyjh/elfin/customview/TitleView;
    .param p2, "x1"    # Lcom/cyjh/elfin/customview/TitleView$1;

    .prologue
    .line 166
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/customview/TitleView$onLeftImageViewClickListener;-><init>(Lcom/cyjh/elfin/customview/TitleView;)V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1
    .param p1, "view"    # Landroid/view/View;

    .prologue
    .line 169
    iget-object v0, p0, Lcom/cyjh/elfin/customview/TitleView$onLeftImageViewClickListener;->this$0:Lcom/cyjh/elfin/customview/TitleView;

    invoke-static {v0}, Lcom/cyjh/elfin/customview/TitleView;->access$300(Lcom/cyjh/elfin/customview/TitleView;)Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 170
    iget-object v0, p0, Lcom/cyjh/elfin/customview/TitleView$onLeftImageViewClickListener;->this$0:Lcom/cyjh/elfin/customview/TitleView;

    invoke-static {v0}, Lcom/cyjh/elfin/customview/TitleView;->access$300(Lcom/cyjh/elfin/customview/TitleView;)Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;->onClick(Landroid/view/View;)V

    .line 172
    :cond_0
    return-void
.end method
