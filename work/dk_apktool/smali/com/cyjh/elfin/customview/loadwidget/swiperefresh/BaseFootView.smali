.class public abstract Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;
.super Landroid/widget/LinearLayout;
.source "BaseFootView.java"

# interfaces
.implements Lcom/cyjh/elfin/mvp/views/loadstate/ILoadViewState;


# instance fields
.field protected mCallBack:Lcom/cyjh/elfin/mvp/views/loadstate/IListViewLoadCallBack;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 28
    invoke-direct {p0, p1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 29
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .prologue
    .line 24
    invoke-direct {p0, p1, p2}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 25
    return-void
.end method


# virtual methods
.method public setCallBack(Lcom/cyjh/elfin/mvp/views/loadstate/IListViewLoadCallBack;)V
    .locals 0
    .param p1, "mCallBack"    # Lcom/cyjh/elfin/mvp/views/loadstate/IListViewLoadCallBack;

    .prologue
    .line 32
    iput-object p1, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;->mCallBack:Lcom/cyjh/elfin/mvp/views/loadstate/IListViewLoadCallBack;

    .line 33
    return-void
.end method
