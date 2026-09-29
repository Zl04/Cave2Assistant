.class public Lcom/cyjh/feedback/lib/entities/PicPathBean;
.super Ljava/lang/Object;
.source "PicPathBean.java"


# instance fields
.field private Image:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getImage()Ljava/lang/String;
    .locals 1

    .prologue
    .line 11
    iget-object v0, p0, Lcom/cyjh/feedback/lib/entities/PicPathBean;->Image:Ljava/lang/String;

    return-object v0
.end method

.method public setImage(Ljava/lang/String;)V
    .locals 0
    .param p1, "image"    # Ljava/lang/String;

    .prologue
    .line 15
    iput-object p1, p0, Lcom/cyjh/feedback/lib/entities/PicPathBean;->Image:Ljava/lang/String;

    .line 16
    return-void
.end method
