.class public Lcom/cyjh/mobileanjian/ipc/engine/utils/d;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static final a:Ljava/lang/String; = "/mnt/sccard/MobileAnjian/MQTemp/compile.lc"


# instance fields
.field public b:Ljava/lang/String;

.field public c:Lcom/google/protobuf/ByteString;

.field public d:Ljava/lang/String;

.field public e:Ljava/lang/String;

.field public f:Ljava/lang/String;

.field public g:Ljava/lang/String;

.field public h:Ljava/lang/String;

.field public i:Ljava/lang/String;

.field public j:Ljava/lang/String;

.field public k:I

.field public l:I

.field public m:I

.field public n:J

.field public o:Z


# direct methods
.method public constructor <init>()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 21
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 25
    const-string v0, "/mnt/sccard/MobileAnjian/MQTemp/compile.lc"

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->b:Ljava/lang/String;

    .line 27
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->d:Ljava/lang/String;

    .line 28
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->e:Ljava/lang/String;

    .line 29
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->f:Ljava/lang/String;

    .line 30
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->g:Ljava/lang/String;

    .line 33
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->h:Ljava/lang/String;

    .line 34
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->i:Ljava/lang/String;

    .line 35
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->j:Ljava/lang/String;

    .line 37
    iput v2, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->k:I

    .line 38
    iput v2, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->l:I

    .line 39
    const/4 v0, 0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->m:I

    .line 40
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->n:J

    .line 41
    iput-boolean v2, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->o:Z

    return-void
.end method


# virtual methods
.method public toString()Ljava/lang/String;
    .locals 4

    .prologue
    .line 46
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "=======> Script4Run <====== \nlcPath: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->b:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\natcPath: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->d:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\nuiCfgPath: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->e:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\nappId: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->f:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\nimeiCode: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->g:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\nduration: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->l:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\nsecondLcPath: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->h:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\nsecondAtcPath: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->i:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\nsecondUiCfgPath: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->j:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\nrepeatNum: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->m:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\nencryptKey: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v2, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->n:J

    invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\nisEncrypt: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->o:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
