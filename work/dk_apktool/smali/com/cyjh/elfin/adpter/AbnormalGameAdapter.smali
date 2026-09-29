.class public Lcom/cyjh/elfin/adpter/AbnormalGameAdapter;
.super Lcom/cyjh/elfin/adpter/CYJHAdapter;
.source "AbnormalGameAdapter.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/cyjh/elfin/adpter/CYJHAdapter",
        "<",
        "Lcom/cyjh/elfin/entity/GameInfo;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/util/List;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List",
            "<",
            "Lcom/cyjh/elfin/entity/GameInfo;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 30
    .local p2, "data":Ljava/util/List;, "Ljava/util/List<Lcom/cyjh/elfin/entity/GameInfo;>;"
    invoke-direct {p0, p1, p2}, Lcom/cyjh/elfin/adpter/CYJHAdapter;-><init>(Landroid/content/Context;Ljava/util/List;)V

    .line 31
    return-void
.end method

.method private isVisitibityLabel(Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;[Ljava/lang/String;)V
    .locals 7
    .param p1, "mHolder"    # Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;
    .param p2, "arrLabel"    # [Ljava/lang/String;

    .prologue
    const/4 v6, 0x4

    const/4 v5, 0x3

    const/4 v4, 0x2

    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 74
    array-length v0, p2

    if-lez v0, :cond_0

    aget-object v0, p2, v2

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 75
    iget-object v0, p1, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;->mTvLabelOne:Landroid/widget/TextView;

    aget-object v1, p2, v2

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 76
    iget-object v0, p1, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;->mTvLabelOne:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    .line 80
    :goto_0
    array-length v0, p2

    if-le v0, v3, :cond_1

    aget-object v0, p2, v3

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 81
    iget-object v0, p1, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;->mTvLabelTwo:Landroid/widget/TextView;

    aget-object v1, p2, v3

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 82
    iget-object v0, p1, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;->mTvLabelTwo:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    .line 86
    :goto_1
    array-length v0, p2

    if-le v0, v4, :cond_2

    aget-object v0, p2, v4

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 87
    iget-object v0, p1, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;->mTvLabelThree:Landroid/widget/TextView;

    aget-object v1, p2, v4

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 88
    iget-object v0, p1, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;->mTvLabelThree:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    .line 92
    :goto_2
    array-length v0, p2

    if-le v0, v5, :cond_3

    aget-object v0, p2, v5

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_3

    .line 93
    iget-object v0, p1, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;->mTvLabelFour:Landroid/widget/TextView;

    aget-object v1, p2, v5

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 94
    iget-object v0, p1, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;->mTvLabelFour:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    .line 98
    :goto_3
    return-void

    .line 78
    :cond_0
    iget-object v0, p1, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;->mTvLabelOne:Landroid/widget/TextView;

    invoke-virtual {v0, v6}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_0

    .line 84
    :cond_1
    iget-object v0, p1, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;->mTvLabelTwo:Landroid/widget/TextView;

    invoke-virtual {v0, v6}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_1

    .line 90
    :cond_2
    iget-object v0, p1, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;->mTvLabelThree:Landroid/widget/TextView;

    invoke-virtual {v0, v6}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_2

    .line 96
    :cond_3
    iget-object v0, p1, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;->mTvLabelFour:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_3
.end method


# virtual methods
.method public getItemId(I)J
    .locals 2
    .param p1, "position"    # I

    .prologue
    .line 35
    const-wide/16 v0, 0x0

    return-wide v0
.end method

.method public getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 7
    .param p1, "position"    # I
    .param p2, "convertView"    # Landroid/view/View;
    .param p3, "parent"    # Landroid/view/ViewGroup;

    .prologue
    const v6, 0x7f0200a4

    .line 41
    if-nez p2, :cond_0

    .line 42
    new-instance v2, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;

    invoke-direct {v2, p0}, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;-><init>(Lcom/cyjh/elfin/adpter/AbnormalGameAdapter;)V

    .line 43
    .local v2, "mHolder":Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;
    iget-object v3, p0, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter;->mContext:Landroid/content/Context;

    invoke-static {v3}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v3

    const v4, 0x7f040055

    const/4 v5, 0x0

    invoke-virtual {v3, v4, p3, v5}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p2

    .line 44
    const v3, 0x7f0f0128

    invoke-virtual {p2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/ImageView;

    iput-object v3, v2, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;->mImgIcon:Landroid/widget/ImageView;

    .line 45
    const v3, 0x7f0f012a

    invoke-virtual {p2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    iput-object v3, v2, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;->mTvName:Landroid/widget/TextView;

    .line 46
    const v3, 0x7f0f012b

    invoke-virtual {p2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    iput-object v3, v2, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;->mTvDes:Landroid/widget/TextView;

    .line 47
    const v3, 0x7f0f012c

    invoke-virtual {p2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    iput-object v3, v2, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;->mTvLabelOne:Landroid/widget/TextView;

    .line 48
    const v3, 0x7f0f012d

    invoke-virtual {p2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    iput-object v3, v2, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;->mTvLabelTwo:Landroid/widget/TextView;

    .line 49
    const v3, 0x7f0f012e

    invoke-virtual {p2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    iput-object v3, v2, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;->mTvLabelThree:Landroid/widget/TextView;

    .line 50
    const v3, 0x7f0f012f

    invoke-virtual {p2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    iput-object v3, v2, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;->mTvLabelFour:Landroid/widget/TextView;

    .line 51
    const v3, 0x7f0f0129

    invoke-virtual {p2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Lcom/cyjh/elfin/customview/GameDownloadView;

    iput-object v3, v2, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;->mBtnGameDownload:Lcom/cyjh/elfin/customview/GameDownloadView;

    .line 52
    invoke-virtual {p2, v2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    .line 56
    :goto_0
    iget-object v3, p0, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter;->mData:Ljava/util/List;

    invoke-interface {v3, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/entity/GameInfo;

    .line 57
    .local v0, "gameInfo":Lcom/cyjh/elfin/entity/GameInfo;
    iget-object v3, v2, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;->mTvDes:Landroid/widget/TextView;

    iget-object v4, v0, Lcom/cyjh/elfin/entity/GameInfo;->Intro:Ljava/lang/String;

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 58
    iget-object v3, v2, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;->mTvName:Landroid/widget/TextView;

    iget-object v4, v0, Lcom/cyjh/elfin/entity/GameInfo;->Name:Ljava/lang/String;

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 59
    iget-object v3, p0, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter;->mContext:Landroid/content/Context;

    invoke-static {v3}, Lcom/squareup/picasso/Picasso;->with(Landroid/content/Context;)Lcom/squareup/picasso/Picasso;

    move-result-object v3

    iget-object v4, v0, Lcom/cyjh/elfin/entity/GameInfo;->Icon:Ljava/lang/String;

    invoke-virtual {v3, v4}, Lcom/squareup/picasso/Picasso;->load(Ljava/lang/String;)Lcom/squareup/picasso/RequestCreator;

    move-result-object v3

    invoke-virtual {v3, v6}, Lcom/squareup/picasso/RequestCreator;->error(I)Lcom/squareup/picasso/RequestCreator;

    move-result-object v3

    .line 60
    invoke-virtual {v3, v6}, Lcom/squareup/picasso/RequestCreator;->placeholder(I)Lcom/squareup/picasso/RequestCreator;

    move-result-object v3

    iget-object v4, v2, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;->mImgIcon:Landroid/widget/ImageView;

    invoke-virtual {v3, v4}, Lcom/squareup/picasso/RequestCreator;->into(Landroid/widget/ImageView;)V

    .line 61
    iget-object v3, v0, Lcom/cyjh/elfin/entity/GameInfo;->Label:Ljava/lang/String;

    const-string v4, "-"

    invoke-virtual {v3, v4}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    .line 62
    .local v1, "labelStrArray":[Ljava/lang/String;
    invoke-direct {p0, v2, v1}, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter;->isVisitibityLabel(Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;[Ljava/lang/String;)V

    .line 63
    iget-object v3, v2, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;->mBtnGameDownload:Lcom/cyjh/elfin/customview/GameDownloadView;

    invoke-virtual {v3, v0}, Lcom/cyjh/elfin/customview/GameDownloadView;->setInfo(Lcom/cyjh/elfin/entity/GameInfo;)V

    .line 64
    return-object p2

    .line 54
    .end local v0    # "gameInfo":Lcom/cyjh/elfin/entity/GameInfo;
    .end local v1    # "labelStrArray":[Ljava/lang/String;
    .end local v2    # "mHolder":Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;
    :cond_0
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;

    .restart local v2    # "mHolder":Lcom/cyjh/elfin/adpter/AbnormalGameAdapter$AbnormalGameHolder;
    goto :goto_0
.end method
