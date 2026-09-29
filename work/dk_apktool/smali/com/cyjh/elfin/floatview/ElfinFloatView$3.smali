.class Lcom/cyjh/elfin/floatview/ElfinFloatView$3;
.super Ljava/lang/Object;
.source "ElfinFloatView.java"

# interfaces
.implements Lcom/cyjh/elfin/dialog/HideFWDialog$OnHideOKClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/floatview/ElfinFloatView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/floatview/ElfinFloatView;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/floatview/ElfinFloatView;

    .prologue
    .line 602
    iput-object p1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$3;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 606
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$3;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-virtual {v0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->toggleElfinVisbility()V

    .line 607
    return-void
.end method
