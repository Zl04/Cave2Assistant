.class public interface abstract Lcom/cyjh/elfin/mvp/views/loadstate/ILoadState;
.super Ljava/lang/Object;
.source "ILoadState.java"


# static fields
.field public static final MESSAGE_ID_COMMON_LOADDATA_EMPTY:I = 0x1

.field public static final MESSAGE_ID_COMMON_LOADDATA_FAILED:I = 0x2

.field public static final MESSAGE_ID_COMMON_LOADDATA_FINISH:I = 0x3

.field public static final MESSAGE_ID_COMMON_LOADDATA_NOTWORK:I = 0x4

.field public static final MESSAGE_ID_COMMON_LOADDATA_START:I


# virtual methods
.method public abstract getContentView()Landroid/view/View;
.end method

.method public abstract getEmptyView()Landroid/view/View;
.end method

.method public abstract getLoadFailedView()Landroid/view/View;
.end method

.method public abstract getLoadingView()Landroid/view/View;
.end method

.method public abstract getNotNetworkView()Landroid/view/View;
.end method

.method public abstract initStateViews()V
.end method

.method public abstract invalidateViews()V
.end method

.method public abstract onLoadEmpty()V
.end method

.method public abstract onLoadFailed()V
.end method

.method public abstract onLoadNotNetwork()V
.end method

.method public abstract onLoadStart()V
.end method

.method public abstract onLoadSuccess()V
.end method
