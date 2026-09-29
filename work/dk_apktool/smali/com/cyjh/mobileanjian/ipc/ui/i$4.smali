.class Lcom/cyjh/mobileanjian/ipc/ui/i$4;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Landroid/support/v4/view/ViewPager$OnPageChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/mobileanjian/ipc/ui/i;->a(Ljava/lang/String;II)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;

.field final synthetic b:Lcom/cyjh/mobileanjian/ipc/ui/i;


# direct methods
.method constructor <init>(Lcom/cyjh/mobileanjian/ipc/ui/i;Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;)V
    .locals 0

    .prologue
    .line 321
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/ui/i$4;->b:Lcom/cyjh/mobileanjian/ipc/ui/i;

    iput-object p2, p0, Lcom/cyjh/mobileanjian/ipc/ui/i$4;->a:Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onPageScrollStateChanged(I)V
    .locals 0

    .prologue
    .line 340
    return-void
.end method

.method public onPageScrolled(IFI)V
    .locals 0

    .prologue
    .line 326
    return-void
.end method

.method public onPageSelected(I)V
    .locals 2

    .prologue
    const/4 v1, 0x1

    .line 331
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i$4;->a:Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->setFocusable(Z)V

    .line 332
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i$4;->a:Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->setFocusableInTouchMode(Z)V

    .line 333
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/i$4;->a:Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout;->getViewPager()Landroid/support/v4/view/ViewPager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/view/ViewPager;->requestFocus()Z

    .line 334
    return-void
.end method
