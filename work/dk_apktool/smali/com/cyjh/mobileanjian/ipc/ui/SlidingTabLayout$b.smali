.class Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout$b;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "b"
.end annotation


# instance fields
.field final synthetic a:Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;


# direct methods
.method private constructor <init>(Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;)V
    .locals 0

    .prologue
    .line 331
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout$b;->a:Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout$1;)V
    .locals 0

    .prologue
    .line 331
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout$b;-><init>(Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;)V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .prologue
    .line 334
    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout$b;->a:Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->a(Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;)Lcom/cyjh/mobileanjian/ipc/ui/d;

    move-result-object v1

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/ui/d;->getChildCount()I

    move-result v1

    if-ge v0, v1, :cond_0

    .line 335
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout$b;->a:Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->a(Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;)Lcom/cyjh/mobileanjian/ipc/ui/d;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/ui/d;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    if-ne p1, v1, :cond_1

    .line 336
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout$b;->a:Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->c(Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;)Landroid/support/v4/view/ViewPager;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/support/v4/view/ViewPager;->setCurrentItem(I)V

    .line 340
    :cond_0
    return-void

    .line 334
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method
