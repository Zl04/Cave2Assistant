.class Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;
.super Ljava/lang/Object;
.source "AbnormalGameAdapter.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/adpter/AbnormalGameAdapter;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "AbnormalGameHolder"
.end annotation


# instance fields
.field mBtnGameDownload:Lcom/cyjh/elfin/customview/GameDownloadView;

.field mImgIcon:Landroid/widget/ImageView;

.field mTvDes:Landroid/widget/TextView;

.field mTvLabelFour:Landroid/widget/TextView;

.field mTvLabelOne:Landroid/widget/TextView;

.field mTvLabelThree:Landroid/widget/TextView;

.field mTvLabelTwo:Landroid/widget/TextView;

.field mTvName:Landroid/widget/TextView;

.field final synthetic this$0:Lcom/cyjh/elfin/adpter/AbnormalGameAdapter;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/adpter/AbnormalGameAdapter;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/adpter/AbnormalGameAdapter;

    .prologue
    .line 100
    iput-object p1, p0, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;->this$0:Lcom/cyjh/elfin/adpter/AbnormalGameAdapter;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
