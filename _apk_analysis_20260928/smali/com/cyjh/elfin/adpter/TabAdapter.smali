.class public Lcom/cyjh/elfin/adpter/TabAdapter;
.super Landroid/support/v4/app/FragmentPagerAdapter;
.source "TabAdapter.java"


# instance fields
.field private fragments:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/support/v4/app/Fragment;",
            ">;"
        }
    .end annotation
.end field

.field private mContext:Landroid/content/Context;

.field private pageTitles:[Ljava/lang/String;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/support/v4/app/FragmentManager;Ljava/util/ArrayList;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "fm"    # Landroid/support/v4/app/FragmentManager;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Landroid/support/v4/app/FragmentManager;",
            "Ljava/util/ArrayList",
            "<",
            "Landroid/support/v4/app/Fragment;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 36
    .local p3, "fragments":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/support/v4/app/Fragment;>;"
    invoke-direct {p0, p2}, Landroid/support/v4/app/FragmentPagerAdapter;-><init>(Landroid/support/v4/app/FragmentManager;)V

    .line 37
    iput-object p1, p0, Lcom/cyjh/elfin/adpter/TabAdapter;->mContext:Landroid/content/Context;

    .line 38
    iput-object p3, p0, Lcom/cyjh/elfin/adpter/TabAdapter;->fragments:Ljava/util/ArrayList;

    .line 39
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const/high16 v1, 0x7f0d0000

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getStringArray(I)[Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/adpter/TabAdapter;->pageTitles:[Ljava/lang/String;

    .line 41
    return-void
.end method


# virtual methods
.method public getCount()I
    .locals 1

    .prologue
    .line 50
    iget-object v0, p0, Lcom/cyjh/elfin/adpter/TabAdapter;->fragments:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    return v0
.end method

.method public getItem(I)Landroid/support/v4/app/Fragment;
    .locals 1
    .param p1, "position"    # I

    .prologue
    .line 45
    iget-object v0, p0, Lcom/cyjh/elfin/adpter/TabAdapter;->fragments:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/support/v4/app/Fragment;

    return-object v0
.end method

.method public getPageTitle(I)Ljava/lang/CharSequence;
    .locals 1
    .param p1, "position"    # I

    .prologue
    .line 65
    iget-object v0, p0, Lcom/cyjh/elfin/adpter/TabAdapter;->pageTitles:[Ljava/lang/String;

    aget-object v0, v0, p1

    return-object v0
.end method
