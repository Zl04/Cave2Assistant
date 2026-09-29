.class Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$2;
.super Ljava/lang/Object;
.source "BottomScreenDisplayXunFeiFloat.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->initEvent()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    .prologue
    .line 87
    iput-object p1, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$2;->this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 90
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$2;->this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    invoke-static {v0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->access$200(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)I

    move-result v0

    const/4 v1, 0x5

    if-ge v0, v1, :cond_0

    .line 91
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$2;->this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    invoke-static {v0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->access$000(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)V

    .line 93
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$2;->this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    invoke-static {v0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->access$100(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)V

    .line 94
    return-void
.end method
