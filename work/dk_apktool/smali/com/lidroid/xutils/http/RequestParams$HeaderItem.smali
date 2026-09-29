.class public Lcom/lidroid/xutils/http/RequestParams$HeaderItem;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lidroid/xutils/http/RequestParams;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "HeaderItem"
.end annotation


# instance fields
.field public final header:Lorg/apache/http/Header;

.field public final overwrite:Z

.field final synthetic this$0:Lcom/lidroid/xutils/http/RequestParams;


# direct methods
.method public constructor <init>(Lcom/lidroid/xutils/http/RequestParams;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 332
    iput-object p1, p0, Lcom/lidroid/xutils/http/RequestParams$HeaderItem;->this$0:Lcom/lidroid/xutils/http/RequestParams;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 333
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/lidroid/xutils/http/RequestParams$HeaderItem;->overwrite:Z

    .line 334
    new-instance v0, Lorg/apache/http/message/BasicHeader;

    invoke-direct {v0, p2, p3}, Lorg/apache/http/message/BasicHeader;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/lidroid/xutils/http/RequestParams$HeaderItem;->header:Lorg/apache/http/Header;

    .line 335
    return-void
.end method

.method public constructor <init>(Lcom/lidroid/xutils/http/RequestParams;Ljava/lang/String;Ljava/lang/String;Z)V
    .locals 1

    .prologue
    .line 337
    iput-object p1, p0, Lcom/lidroid/xutils/http/RequestParams$HeaderItem;->this$0:Lcom/lidroid/xutils/http/RequestParams;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 338
    iput-boolean p4, p0, Lcom/lidroid/xutils/http/RequestParams$HeaderItem;->overwrite:Z

    .line 339
    new-instance v0, Lorg/apache/http/message/BasicHeader;

    invoke-direct {v0, p2, p3}, Lorg/apache/http/message/BasicHeader;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/lidroid/xutils/http/RequestParams$HeaderItem;->header:Lorg/apache/http/Header;

    .line 340
    return-void
.end method

.method public constructor <init>(Lcom/lidroid/xutils/http/RequestParams;Lorg/apache/http/Header;)V
    .locals 1

    .prologue
    .line 322
    iput-object p1, p0, Lcom/lidroid/xutils/http/RequestParams$HeaderItem;->this$0:Lcom/lidroid/xutils/http/RequestParams;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 323
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/lidroid/xutils/http/RequestParams$HeaderItem;->overwrite:Z

    .line 324
    iput-object p2, p0, Lcom/lidroid/xutils/http/RequestParams$HeaderItem;->header:Lorg/apache/http/Header;

    .line 325
    return-void
.end method

.method public constructor <init>(Lcom/lidroid/xutils/http/RequestParams;Lorg/apache/http/Header;Z)V
    .locals 0

    .prologue
    .line 327
    iput-object p1, p0, Lcom/lidroid/xutils/http/RequestParams$HeaderItem;->this$0:Lcom/lidroid/xutils/http/RequestParams;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 328
    iput-boolean p3, p0, Lcom/lidroid/xutils/http/RequestParams$HeaderItem;->overwrite:Z

    .line 329
    iput-object p2, p0, Lcom/lidroid/xutils/http/RequestParams$HeaderItem;->header:Lorg/apache/http/Header;

    .line 330
    return-void
.end method
