.class public Lcom/cyjh/elfin/model/PageInfo;
.super Ljava/lang/Object;
.source "PageInfo.java"

# interfaces
.implements Ljava/io/Serializable;


# static fields
.field public static final DEFAULT_PAGE_SIZE:I = 0xa

.field private static final serialVersionUID:J = 0x1L


# instance fields
.field private CurrentPage:I

.field private DataCount:I

.field private IsLastPage:I

.field private PageCount:I

.field private PageSize:I


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 41
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 38
    const/16 v0, 0xa

    iput v0, p0, Lcom/cyjh/elfin/model/PageInfo;->PageSize:I

    .line 42
    const/4 v0, 0x1

    iput v0, p0, Lcom/cyjh/elfin/model/PageInfo;->CurrentPage:I

    .line 43
    return-void
.end method


# virtual methods
.method public getCurrentPage()I
    .locals 1

    .prologue
    .line 54
    iget v0, p0, Lcom/cyjh/elfin/model/PageInfo;->CurrentPage:I

    return v0
.end method

.method public getDataCount()I
    .locals 1

    .prologue
    .line 70
    iget v0, p0, Lcom/cyjh/elfin/model/PageInfo;->DataCount:I

    return v0
.end method

.method public getIsLastPage()I
    .locals 1

    .prologue
    .line 78
    iget v0, p0, Lcom/cyjh/elfin/model/PageInfo;->IsLastPage:I

    return v0
.end method

.method public getPageCount()I
    .locals 1

    .prologue
    .line 46
    iget v0, p0, Lcom/cyjh/elfin/model/PageInfo;->PageCount:I

    return v0
.end method

.method public getPageSize()I
    .locals 1

    .prologue
    .line 62
    iget v0, p0, Lcom/cyjh/elfin/model/PageInfo;->PageSize:I

    return v0
.end method

.method public setCurrentPage(I)V
    .locals 0
    .param p1, "currentPage"    # I

    .prologue
    .line 58
    iput p1, p0, Lcom/cyjh/elfin/model/PageInfo;->CurrentPage:I

    .line 59
    return-void
.end method

.method public setDataCount(I)V
    .locals 0
    .param p1, "dataCount"    # I

    .prologue
    .line 74
    iput p1, p0, Lcom/cyjh/elfin/model/PageInfo;->DataCount:I

    .line 75
    return-void
.end method

.method public setIsLastPage(I)V
    .locals 0
    .param p1, "isLastPage"    # I

    .prologue
    .line 82
    iput p1, p0, Lcom/cyjh/elfin/model/PageInfo;->IsLastPage:I

    .line 83
    return-void
.end method

.method public setPageCount(I)V
    .locals 0
    .param p1, "pageCount"    # I

    .prologue
    .line 50
    iput p1, p0, Lcom/cyjh/elfin/model/PageInfo;->PageCount:I

    .line 51
    return-void
.end method

.method public setPageSize(I)V
    .locals 0
    .param p1, "pageSize"    # I

    .prologue
    .line 66
    iput p1, p0, Lcom/cyjh/elfin/model/PageInfo;->PageSize:I

    .line 67
    return-void
.end method
