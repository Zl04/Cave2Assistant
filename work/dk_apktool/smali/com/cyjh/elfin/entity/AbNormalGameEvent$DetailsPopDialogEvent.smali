.class public Lcom/cyjh/elfin/entity/AbNormalGameEvent$DetailsPopDialogEvent;
.super Ljava/lang/Object;
.source "AbNormalGameEvent.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/entity/AbNormalGameEvent;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "DetailsPopDialogEvent"
.end annotation


# instance fields
.field private url:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 0
    .param p1, "url"    # Ljava/lang/String;

    .prologue
    .line 99
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 100
    iput-object p1, p0, Lcom/cyjh/elfin/entity/AbNormalGameEvent$DetailsPopDialogEvent;->url:Ljava/lang/String;

    .line 101
    return-void
.end method


# virtual methods
.method public getUrl()Ljava/lang/String;
    .locals 1

    .prologue
    .line 104
    iget-object v0, p0, Lcom/cyjh/elfin/entity/AbNormalGameEvent$DetailsPopDialogEvent;->url:Ljava/lang/String;

    return-object v0
.end method
