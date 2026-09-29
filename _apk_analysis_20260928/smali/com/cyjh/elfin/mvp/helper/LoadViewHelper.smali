.class public Lcom/cyjh/elfin/mvp/helper/LoadViewHelper;
.super Ljava/lang/Object;
.source "LoadViewHelper.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static loadDataError(Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;Lcom/android/volley/VolleyError;I)V
    .locals 0
    .param p0, "findBasicInf"    # Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;
    .param p1, "error"    # Lcom/android/volley/VolleyError;
    .param p2, "currentState"    # I

    .prologue
    .line 46
    invoke-interface {p0}, Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;->hideLoading()V

    .line 47
    packed-switch p2, :pswitch_data_0

    .line 58
    :goto_0
    return-void

    .line 49
    :pswitch_0
    invoke-interface {p0, p1}, Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;->firstLoadDataError(Lcom/android/volley/VolleyError;)V

    goto :goto_0

    .line 52
    :pswitch_1
    invoke-interface {p0, p1}, Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;->repeatLoadDataError(Lcom/android/volley/VolleyError;)V

    goto :goto_0

    .line 55
    :pswitch_2
    invoke-interface {p0, p1}, Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;->moreLoadDataError(Lcom/android/volley/VolleyError;)V

    goto :goto_0

    .line 47
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method public static loadSuccessHasData(Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;ILjava/lang/Object;Lcom/cyjh/elfin/model/PageInfo;)V
    .locals 2
    .param p0, "findBasicInf"    # Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;
    .param p1, "currentState"    # I
    .param p2, "object"    # Ljava/lang/Object;
    .param p3, "pageInfo"    # Lcom/cyjh/elfin/model/PageInfo;

    .prologue
    .line 15
    packed-switch p1, :pswitch_data_0

    .line 27
    :goto_0
    if-eqz p3, :cond_0

    invoke-virtual {p3}, Lcom/cyjh/elfin/model/PageInfo;->getIsLastPage()I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 28
    invoke-interface {p0}, Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;->loadDataSuccessAndLast()V

    .line 30
    :cond_0
    return-void

    .line 17
    :pswitch_0
    invoke-interface {p0, p2}, Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;->firstLoadDataSuccess(Ljava/lang/Object;)V

    goto :goto_0

    .line 20
    :pswitch_1
    invoke-interface {p0}, Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;->hideLoading()V

    .line 21
    invoke-interface {p0, p2}, Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;->repeatLoadDataSuccess(Ljava/lang/Object;)V

    goto :goto_0

    .line 24
    :pswitch_2
    invoke-interface {p0, p2}, Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;->moreLoadDataSuccess(Ljava/lang/Object;)V

    goto :goto_0

    .line 15
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method public static loadSuccessNoData(Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;I)V
    .locals 0
    .param p0, "findBasicInf"    # Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;
    .param p1, "currentState"    # I

    .prologue
    .line 32
    packed-switch p1, :pswitch_data_0

    .line 44
    :goto_0
    return-void

    .line 34
    :pswitch_0
    invoke-interface {p0}, Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;->firstLoadDataSuccessAndEmpty()V

    goto :goto_0

    .line 37
    :pswitch_1
    invoke-interface {p0}, Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;->hideLoading()V

    .line 38
    invoke-interface {p0}, Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;->repeatLoadDataSuccessAndEmpty()V

    goto :goto_0

    .line 41
    :pswitch_2
    invoke-interface {p0}, Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;->moreLoadDataSuccessAndEmpty()V

    goto :goto_0

    .line 32
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method
