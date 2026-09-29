.class public abstract Lcom/cyjh/elfin/net/volley/VolleyRequestManager;
.super Ljava/lang/Object;
.source "VolleyRequestManager.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/net/volley/VolleyRequestManager$OnRequestErrorListener;,
        Lcom/cyjh/elfin/net/volley/VolleyRequestManager$OnRequestSuccessListener;
    }
.end annotation


# instance fields
.field public mVolleyErrorListener:Lcom/cyjh/elfin/net/volley/VolleyRequestManager$OnRequestErrorListener;

.field public mVolleySuccessListener:Lcom/cyjh/elfin/net/volley/VolleyRequestManager$OnRequestSuccessListener;

.field public networkTime:Ljava/lang/String;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 6
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 33
    new-instance v0, Lcom/cyjh/elfin/net/volley/VolleyRequestManager$OnRequestErrorListener;

    invoke-direct {v0, p0, p1}, Lcom/cyjh/elfin/net/volley/VolleyRequestManager$OnRequestErrorListener;-><init>(Lcom/cyjh/elfin/net/volley/VolleyRequestManager;Landroid/content/Context;)V

    iput-object v0, p0, Lcom/cyjh/elfin/net/volley/VolleyRequestManager;->mVolleyErrorListener:Lcom/cyjh/elfin/net/volley/VolleyRequestManager$OnRequestErrorListener;

    .line 34
    new-instance v0, Lcom/cyjh/elfin/net/volley/VolleyRequestManager$OnRequestSuccessListener;

    invoke-direct {v0, p0, p1}, Lcom/cyjh/elfin/net/volley/VolleyRequestManager$OnRequestSuccessListener;-><init>(Lcom/cyjh/elfin/net/volley/VolleyRequestManager;Landroid/content/Context;)V

    iput-object v0, p0, Lcom/cyjh/elfin/net/volley/VolleyRequestManager;->mVolleySuccessListener:Lcom/cyjh/elfin/net/volley/VolleyRequestManager$OnRequestSuccessListener;

    .line 35
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    new-instance v1, Ljava/text/SimpleDateFormat;

    const-string v2, "yyyy-MM-dd-HH-mm-ss"

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v3

    invoke-direct {v1, v2, v3}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    new-instance v2, Ljava/util/Date;

    .line 36
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-direct {v2, v4, v5}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v1, v2}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\t\trequest begin"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/net/volley/VolleyRequestManager;->networkTime:Ljava/lang/String;

    .line 37
    return-void
.end method


# virtual methods
.method public abstract onRequestErrorRes(Ljava/lang/String;)V
.end method

.method public abstract onRequestSuccessRes(Ljava/lang/String;)V
.end method
