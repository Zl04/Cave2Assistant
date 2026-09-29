.class public Lcom/cyjh/elfin/entity/Ad$DataBean;
.super Ljava/lang/Object;
.source "Ad.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/entity/Ad;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "DataBean"
.end annotation


# instance fields
.field public AdvertisementTitle:Ljava/lang/String;

.field public Id:Ljava/lang/String;

.field public Link:Ljava/lang/String;

.field public LinkType:Ljava/lang/String;

.field public Url:Ljava/lang/String;

.field final synthetic this$0:Lcom/cyjh/elfin/entity/Ad;


# direct methods
.method public constructor <init>(Lcom/cyjh/elfin/entity/Ad;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/entity/Ad;

    .prologue
    .line 15
    iput-object p1, p0, Lcom/cyjh/elfin/entity/Ad$DataBean;->this$0:Lcom/cyjh/elfin/entity/Ad;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
