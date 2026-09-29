.class public Ljavax/activation/ActivationDataFlavor;
.super Lmyjava/awt/datatransfer/DataFlavor;
.source "SourceFile"


# instance fields
.field private humanPresentableName:Ljava/lang/String;

.field private mimeObject:Ljavax/activation/MimeType;

.field private mimeType:Ljava/lang/String;

.field private representationClass:Ljava/lang/Class;


# direct methods
.method public constructor <init>(Ljava/lang/Class;Ljava/lang/String;)V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 121
    invoke-direct {p0, p1, p2}, Lmyjava/awt/datatransfer/DataFlavor;-><init>(Ljava/lang/Class;Ljava/lang/String;)V

    .line 70
    iput-object v0, p0, Ljavax/activation/ActivationDataFlavor;->mimeType:Ljava/lang/String;

    .line 71
    iput-object v0, p0, Ljavax/activation/ActivationDataFlavor;->mimeObject:Ljavax/activation/MimeType;

    .line 72
    iput-object v0, p0, Ljavax/activation/ActivationDataFlavor;->humanPresentableName:Ljava/lang/String;

    .line 73
    iput-object v0, p0, Ljavax/activation/ActivationDataFlavor;->representationClass:Ljava/lang/Class;

    .line 122
    invoke-super {p0}, Lmyjava/awt/datatransfer/DataFlavor;->getMimeType()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Ljavax/activation/ActivationDataFlavor;->mimeType:Ljava/lang/String;

    .line 123
    iput-object p1, p0, Ljavax/activation/ActivationDataFlavor;->representationClass:Ljava/lang/Class;

    .line 124
    iput-object p2, p0, Ljavax/activation/ActivationDataFlavor;->humanPresentableName:Ljava/lang/String;

    .line 125
    return-void
.end method

.method public constructor <init>(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 94
    invoke-direct {p0, p2, p3}, Lmyjava/awt/datatransfer/DataFlavor;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 70
    iput-object v0, p0, Ljavax/activation/ActivationDataFlavor;->mimeType:Ljava/lang/String;

    .line 71
    iput-object v0, p0, Ljavax/activation/ActivationDataFlavor;->mimeObject:Ljavax/activation/MimeType;

    .line 72
    iput-object v0, p0, Ljavax/activation/ActivationDataFlavor;->humanPresentableName:Ljava/lang/String;

    .line 73
    iput-object v0, p0, Ljavax/activation/ActivationDataFlavor;->representationClass:Ljava/lang/Class;

    .line 97
    iput-object p2, p0, Ljavax/activation/ActivationDataFlavor;->mimeType:Ljava/lang/String;

    .line 98
    iput-object p3, p0, Ljavax/activation/ActivationDataFlavor;->humanPresentableName:Ljava/lang/String;

    .line 99
    iput-object p1, p0, Ljavax/activation/ActivationDataFlavor;->representationClass:Ljava/lang/Class;

    .line 100
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 143
    invoke-direct {p0, p1, p2}, Lmyjava/awt/datatransfer/DataFlavor;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 70
    iput-object v0, p0, Ljavax/activation/ActivationDataFlavor;->mimeType:Ljava/lang/String;

    .line 71
    iput-object v0, p0, Ljavax/activation/ActivationDataFlavor;->mimeObject:Ljavax/activation/MimeType;

    .line 72
    iput-object v0, p0, Ljavax/activation/ActivationDataFlavor;->humanPresentableName:Ljava/lang/String;

    .line 73
    iput-object v0, p0, Ljavax/activation/ActivationDataFlavor;->representationClass:Ljava/lang/Class;

    .line 144
    iput-object p1, p0, Ljavax/activation/ActivationDataFlavor;->mimeType:Ljava/lang/String;

    .line 146
    :try_start_0
    const-string v0, "java.io.InputStream"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    iput-object v0, p0, Ljavax/activation/ActivationDataFlavor;->representationClass:Ljava/lang/Class;
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 150
    :goto_0
    iput-object p2, p0, Ljavax/activation/ActivationDataFlavor;->humanPresentableName:Ljava/lang/String;

    .line 151
    return-void

    .line 147
    :catch_0
    move-exception v0

    goto :goto_0
.end method


# virtual methods
.method public equals(Lmyjava/awt/datatransfer/DataFlavor;)Z
    .locals 2

    .prologue
    .line 198
    invoke-virtual {p0, p1}, Ljavax/activation/ActivationDataFlavor;->isMimeTypeEqual(Lmyjava/awt/datatransfer/DataFlavor;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 199
    invoke-virtual {p1}, Lmyjava/awt/datatransfer/DataFlavor;->getRepresentationClass()Ljava/lang/Class;

    move-result-object v0

    iget-object v1, p0, Ljavax/activation/ActivationDataFlavor;->representationClass:Ljava/lang/Class;

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    .line 198
    goto :goto_0
.end method

.method public getHumanPresentableName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 177
    iget-object v0, p0, Ljavax/activation/ActivationDataFlavor;->humanPresentableName:Ljava/lang/String;

    return-object v0
.end method

.method public getMimeType()Ljava/lang/String;
    .locals 1

    .prologue
    .line 159
    iget-object v0, p0, Ljavax/activation/ActivationDataFlavor;->mimeType:Ljava/lang/String;

    return-object v0
.end method

.method public getRepresentationClass()Ljava/lang/Class;
    .locals 1

    .prologue
    .line 168
    iget-object v0, p0, Ljavax/activation/ActivationDataFlavor;->representationClass:Ljava/lang/Class;

    return-object v0
.end method

.method public isMimeTypeEqual(Ljava/lang/String;)Z
    .locals 2

    .prologue
    .line 215
    .line 217
    :try_start_0
    iget-object v0, p0, Ljavax/activation/ActivationDataFlavor;->mimeObject:Ljavax/activation/MimeType;

    if-nez v0, :cond_0

    .line 218
    new-instance v0, Ljavax/activation/MimeType;

    iget-object v1, p0, Ljavax/activation/ActivationDataFlavor;->mimeType:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljavax/activation/MimeType;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Ljavax/activation/ActivationDataFlavor;->mimeObject:Ljavax/activation/MimeType;

    .line 219
    :cond_0
    new-instance v0, Ljavax/activation/MimeType;

    invoke-direct {v0, p1}, Ljavax/activation/MimeType;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljavax/activation/MimeTypeParseException; {:try_start_0 .. :try_end_0} :catch_0

    .line 225
    iget-object v1, p0, Ljavax/activation/ActivationDataFlavor;->mimeObject:Ljavax/activation/MimeType;

    invoke-virtual {v1, v0}, Ljavax/activation/MimeType;->match(Ljavax/activation/MimeType;)Z

    move-result v0

    :goto_0
    return v0

    .line 220
    :catch_0
    move-exception v0

    .line 222
    iget-object v0, p0, Ljavax/activation/ActivationDataFlavor;->mimeType:Ljava/lang/String;

    invoke-virtual {v0, p1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    goto :goto_0
.end method

.method protected normalizeMimeType(Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .prologue
    .line 261
    return-object p1
.end method

.method protected normalizeMimeTypeParameter(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .prologue
    .line 245
    return-object p2
.end method

.method public setHumanPresentableName(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 186
    iput-object p1, p0, Ljavax/activation/ActivationDataFlavor;->humanPresentableName:Ljava/lang/String;

    .line 187
    return-void
.end method
