.class public Lcom/cyjh/elfin/entity/AbNormalGameEvent$DownloadAppSuccessEvent;
.super Ljava/lang/Object;
.source "AbNormalGameEvent.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/entity/AbNormalGameEvent;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "DownloadAppSuccessEvent"
.end annotation


# instance fields
.field private url:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 0
    .param p1, "url"    # Ljava/lang/String;

    .prologue
    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 20
    iput-object p1, p0, Lcom/cyjh/elfin/entity/AbNormalGameEvent$DownloadAppSuccessEvent;->url:Ljava/lang/String;

    .line 21
    return-void
.end method


# virtual methods
.method public getUrl()Ljava/lang/String;
    .locals 1

    .prologue
    .line 24
    iget-object v0, p0, Lcom/cyjh/elfin/entity/AbNormalGameEvent$DownloadAppSuccessEvent;->url:Ljava/lang/String;

    return-object v0
.end method
