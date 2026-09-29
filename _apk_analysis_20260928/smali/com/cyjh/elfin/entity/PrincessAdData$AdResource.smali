.class public Lcom/cyjh/elfin/entity/PrincessAdData$AdResource;
.super Ljava/lang/Object;
.source "PrincessAdData.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/entity/PrincessAdData;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "AdResource"
.end annotation


# instance fields
.field public admaterial:Ljava/lang/String;

.field public adtype:Ljava/lang/String;

.field public click:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field public ct:Ljava/lang/String;

.field public deep_link:Ljava/lang/String;

.field public imgs:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/cyjh/elfin/entity/PrincessAdImgs;",
            ">;"
        }
    .end annotation
.end field

.field public impr:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field public landing_url:Ljava/lang/String;

.field public sbt:Ljava/lang/String;

.field public sessionid:Ljava/lang/String;

.field public snum:Ljava/lang/String;

.field public sub_title:Ljava/lang/String;

.field final synthetic this$0:Lcom/cyjh/elfin/entity/PrincessAdData;

.field public title:Ljava/lang/String;

.field public token:Ljava/lang/String;


# direct methods
.method public constructor <init>(Lcom/cyjh/elfin/entity/PrincessAdData;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/entity/PrincessAdData;

    .prologue
    .line 16
    iput-object p1, p0, Lcom/cyjh/elfin/entity/PrincessAdData$AdResource;->this$0:Lcom/cyjh/elfin/entity/PrincessAdData;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
