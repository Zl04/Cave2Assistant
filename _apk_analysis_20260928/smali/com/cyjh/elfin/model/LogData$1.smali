.class Lcom/cyjh/elfin/model/LogData$1;
.super Lcom/lidroid/xutils/http/callback/RequestCallBack;
.source "LogData.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/model/LogData;->sendLog(Landroid/content/Context;Lcom/lidroid/xutils/http/callback/RequestCallBack;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/lidroid/xutils/http/callback/RequestCallBack",
        "<",
        "Ljava/lang/String;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/model/LogData;

.field final synthetic val$commonLog:Lcom/cyjh/elfin/log/CommonLog;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/model/LogData;Lcom/cyjh/elfin/log/CommonLog;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/model/LogData;

    .prologue
    .line 73
    iput-object p1, p0, Lcom/cyjh/elfin/model/LogData$1;->this$0:Lcom/cyjh/elfin/model/LogData;

    iput-object p2, p0, Lcom/cyjh/elfin/model/LogData$1;->val$commonLog:Lcom/cyjh/elfin/log/CommonLog;

    invoke-direct {p0}, Lcom/lidroid/xutils/http/callback/RequestCallBack;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailure(Lcom/lidroid/xutils/exception/HttpException;Ljava/lang/String;)V
    .locals 3
    .param p1, "e"    # Lcom/lidroid/xutils/exception/HttpException;
    .param p2, "s"    # Ljava/lang/String;

    .prologue
    .line 81
    iget-object v0, p0, Lcom/cyjh/elfin/model/LogData$1;->val$commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "\u8bbf\u95ee\u5931\u8d25"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Lcom/lidroid/xutils/exception/HttpException;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 82
    return-void
.end method

.method public onSuccess(Lcom/lidroid/xutils/http/ResponseInfo;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/lidroid/xutils/http/ResponseInfo",
            "<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 76
    .local p1, "responseInfo":Lcom/lidroid/xutils/http/ResponseInfo;, "Lcom/lidroid/xutils/http/ResponseInfo<Ljava/lang/String;>;"
    iget-object v0, p0, Lcom/cyjh/elfin/model/LogData$1;->val$commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v1, "\u8bbf\u95ee\u6210\u529f"

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 77
    return-void
.end method
