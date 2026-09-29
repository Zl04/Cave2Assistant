.class public Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Cloneable;


# static fields
.field public static final DEFAULT_LC_FILEPATH:Ljava/lang/String; = ""


# instance fields
.field public appId:Ljava/lang/String;

.field public atcPath:Ljava/lang/String;

.field public compiledContent:[B

.field public duration:I

.field public encrypt:Z

.field public encryptKey:J

.field public lcPath:Ljava/lang/String;

.field public repeat:I

.field public trialTime:I

.field public uiCfgPath:Ljava/lang/String;

.field public username:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 46
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 32
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->lcPath:Ljava/lang/String;

    .line 33
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->compiledContent:[B

    .line 34
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->atcPath:Ljava/lang/String;

    .line 35
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->uiCfgPath:Ljava/lang/String;

    .line 36
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->appId:Ljava/lang/String;

    .line 37
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->username:Ljava/lang/String;

    .line 39
    iput v2, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->trialTime:I

    .line 40
    const/4 v0, 0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->repeat:I

    .line 41
    const/4 v0, -0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->duration:I

    .line 42
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->encryptKey:J

    .line 43
    iput-boolean v2, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->encrypt:Z

    .line 47
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 50
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 32
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->lcPath:Ljava/lang/String;

    .line 33
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->compiledContent:[B

    .line 34
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->atcPath:Ljava/lang/String;

    .line 35
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->uiCfgPath:Ljava/lang/String;

    .line 36
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->appId:Ljava/lang/String;

    .line 37
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->username:Ljava/lang/String;

    .line 39
    iput v2, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->trialTime:I

    .line 40
    const/4 v0, 0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->repeat:I

    .line 41
    const/4 v0, -0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->duration:I

    .line 42
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->encryptKey:J

    .line 43
    iput-boolean v2, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->encrypt:Z

    .line 51
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->lcPath:Ljava/lang/String;

    .line 52
    iput-object p2, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->atcPath:Ljava/lang/String;

    .line 53
    iput-object p3, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->uiCfgPath:Ljava/lang/String;

    .line 54
    return-void
.end method

.method public constructor <init>([BLjava/lang/String;Ljava/lang/String;)V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 57
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 32
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->lcPath:Ljava/lang/String;

    .line 33
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->compiledContent:[B

    .line 34
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->atcPath:Ljava/lang/String;

    .line 35
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->uiCfgPath:Ljava/lang/String;

    .line 36
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->appId:Ljava/lang/String;

    .line 37
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->username:Ljava/lang/String;

    .line 39
    iput v2, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->trialTime:I

    .line 40
    const/4 v0, 0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->repeat:I

    .line 41
    const/4 v0, -0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->duration:I

    .line 42
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->encryptKey:J

    .line 43
    iput-boolean v2, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->encrypt:Z

    .line 58
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->compiledContent:[B

    .line 59
    iput-object p2, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->atcPath:Ljava/lang/String;

    .line 60
    iput-object p3, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->uiCfgPath:Ljava/lang/String;

    .line 61
    return-void
.end method


# virtual methods
.method public clone()Ljava/lang/Object;
    .locals 2

    .prologue
    .line 65
    const/4 v1, 0x0

    .line 68
    :try_start_0
    invoke-super {p0}, Ljava/lang/Object;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;
    :try_end_0
    .catch Ljava/lang/CloneNotSupportedException; {:try_start_0 .. :try_end_0} :catch_0

    .line 75
    :goto_0
    return-object v0

    .line 70
    :catch_0
    move-exception v0

    .line 72
    invoke-virtual {v0}, Ljava/lang/CloneNotSupportedException;->printStackTrace()V

    move-object v0, v1

    goto :goto_0
.end method

.method public setDuration(I)Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;
    .locals 1

    .prologue
    .line 97
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->duration:I

    .line 98
    const/4 v0, -0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->repeat:I

    .line 100
    return-object p0
.end method

.method public setRepeat(I)Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;
    .locals 1

    .prologue
    .line 86
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->repeat:I

    .line 87
    const/4 v0, -0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->duration:I

    .line 89
    return-object p0
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .prologue
    .line 106
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Script4Run infomation: \nlcPath: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->lcPath:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\natcPath: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->atcPath:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\nuiCfgPath: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->uiCfgPath:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\nappId: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->appId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\nimeiCode: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->username:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\ntrialTime: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->trialTime:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\nrepeatNum: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->repeat:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\nencryptKey: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v2, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->encryptKey:J

    invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\nencrypt: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->encrypt:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
