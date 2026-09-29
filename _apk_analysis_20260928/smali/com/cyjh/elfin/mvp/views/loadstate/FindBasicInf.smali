.class public interface abstract Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;
.super Ljava/lang/Object;
.source "FindBasicInf.java"

# interfaces
.implements Lcom/cyjh/elfin/mvp/views/loadstate/BaseLoadView;


# virtual methods
.method public abstract firstLoadDataError(Lcom/android/volley/VolleyError;)V
.end method

.method public abstract firstLoadDataSuccess(Ljava/lang/Object;)V
.end method

.method public abstract firstLoadDataSuccessAndEmpty()V
.end method

.method public abstract loadDataButNotNetwork()V
.end method

.method public abstract loadDataSuccessAndLast()V
.end method

.method public abstract moreLoadDataError(Lcom/android/volley/VolleyError;)V
.end method

.method public abstract moreLoadDataSuccess(Ljava/lang/Object;)V
.end method

.method public abstract moreLoadDataSuccessAndEmpty()V
.end method

.method public abstract repeatLoadDataError(Lcom/android/volley/VolleyError;)V
.end method

.method public abstract repeatLoadDataSuccess(Ljava/lang/Object;)V
.end method

.method public abstract repeatLoadDataSuccessAndEmpty()V
.end method
