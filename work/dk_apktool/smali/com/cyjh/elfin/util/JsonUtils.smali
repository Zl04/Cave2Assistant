.class public Lcom/cyjh/elfin/util/JsonUtils;
.super Ljava/lang/Object;
.source "JsonUtils.java"


# static fields
.field private static final PROPFILE_BESTRESOLUTION:Ljava/lang/String; = "BestResolution"

.field private static final PROPFILE_BESTRESOLUTION_X:Ljava/lang/String; = "X"

.field private static final PROPFILE_BESTRESOLUTION_Y:Ljava/lang/String; = "Y"

.field private static final PROPFILE_CHANGEFILELIST:Ljava/lang/String; = "ChangeFileList"

.field private static final PROPFILE_DESCRIPTION:Ljava/lang/String; = "Description"

.field private static final PROPFILE_FILEVERSION:Ljava/lang/String; = "FileVersion"

.field private static final PROPFILE_SCRIPTID:Ljava/lang/String; = "id"

.field private static final PROPFILE_SCRIPTNAME:Ljava/lang/String; = "Name"

.field private static final PROPFILE_SUFFIX_ATC:Ljava/lang/String; = ".atc"

.field private static final PROPFILE_SUFFIX_MQ:Ljava/lang/String; = ".mq"

.field private static final PROPFILE_SUFFIX_PROP:Ljava/lang/String; = ".prop"

.field private static final PROPFILE_SUFFIX_RTD:Ljava/lang/String; = ".rtd"

.field private static final PROPFILE_SUFFIX_UI:Ljava/lang/String; = ".ui"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static parBestResolutionJson(Landroid/util/JsonReader;)Lcom/cyjh/elfin/entity/BestResolution;
    .locals 3
    .param p0, "reader"    # Landroid/util/JsonReader;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 64
    new-instance v0, Lcom/cyjh/elfin/entity/BestResolution;

    invoke-direct {v0}, Lcom/cyjh/elfin/entity/BestResolution;-><init>()V

    .line 65
    .local v0, "bestResolution":Lcom/cyjh/elfin/entity/BestResolution;
    invoke-virtual {p0}, Landroid/util/JsonReader;->beginObject()V

    .line 66
    :goto_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 67
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 68
    .local v1, "name":Ljava/lang/String;
    const-string v2, "X"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 69
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v2

    invoke-virtual {v0, v2}, Lcom/cyjh/elfin/entity/BestResolution;->setX(I)V

    goto :goto_0

    .line 70
    :cond_0
    const-string v2, "Y"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 71
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v2

    invoke-virtual {v0, v2}, Lcom/cyjh/elfin/entity/BestResolution;->setY(I)V

    goto :goto_0

    .line 73
    :cond_1
    invoke-virtual {p0}, Landroid/util/JsonReader;->skipValue()V

    goto :goto_0

    .line 76
    .end local v1    # "name":Ljava/lang/String;
    :cond_2
    invoke-virtual {p0}, Landroid/util/JsonReader;->endObject()V

    .line 77
    return-object v0
.end method

.method private static parFileVersionJson(Landroid/util/JsonReader;)Lcom/cyjh/elfin/entity/FileVersion;
    .locals 3
    .param p0, "reader"    # Landroid/util/JsonReader;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 90
    new-instance v0, Lcom/cyjh/elfin/entity/FileVersion;

    invoke-direct {v0}, Lcom/cyjh/elfin/entity/FileVersion;-><init>()V

    .line 91
    .local v0, "fileVersion":Lcom/cyjh/elfin/entity/FileVersion;
    invoke-virtual {p0}, Landroid/util/JsonReader;->beginObject()V

    .line 92
    :goto_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_5

    .line 93
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 94
    .local v1, "name":Ljava/lang/String;
    const-string v2, ".atc"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 95
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v2

    invoke-virtual {v0, v2}, Lcom/cyjh/elfin/entity/FileVersion;->setAtc(I)V

    goto :goto_0

    .line 96
    :cond_0
    const-string v2, ".mq"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 97
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v2

    invoke-virtual {v0, v2}, Lcom/cyjh/elfin/entity/FileVersion;->setMq(I)V

    goto :goto_0

    .line 98
    :cond_1
    const-string v2, ".prop"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 99
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v2

    invoke-virtual {v0, v2}, Lcom/cyjh/elfin/entity/FileVersion;->setProp(I)V

    goto :goto_0

    .line 100
    :cond_2
    const-string v2, ".ui"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 101
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v2

    invoke-virtual {v0, v2}, Lcom/cyjh/elfin/entity/FileVersion;->setUI(I)V

    goto :goto_0

    .line 102
    :cond_3
    const-string v2, ".rtd"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 103
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v2

    invoke-virtual {v0, v2}, Lcom/cyjh/elfin/entity/FileVersion;->setRtd(I)V

    goto :goto_0

    .line 105
    :cond_4
    invoke-virtual {p0}, Landroid/util/JsonReader;->skipValue()V

    goto :goto_0

    .line 108
    .end local v1    # "name":Ljava/lang/String;
    :cond_5
    invoke-virtual {p0}, Landroid/util/JsonReader;->endObject()V

    .line 109
    return-object v0
.end method

.method public static parPropJson(Ljava/io/InputStream;)Lcom/cyjh/elfin/entity/Script;
    .locals 5
    .param p0, "propInputStream"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 31
    new-instance v1, Landroid/util/JsonReader;

    new-instance v3, Ljava/io/InputStreamReader;

    const-string v4, "GBK"

    invoke-direct {v3, p0, v4}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/lang/String;)V

    invoke-direct {v1, v3}, Landroid/util/JsonReader;-><init>(Ljava/io/Reader;)V

    .line 32
    .local v1, "reader":Landroid/util/JsonReader;
    invoke-virtual {v1}, Landroid/util/JsonReader;->beginObject()V

    .line 33
    new-instance v2, Lcom/cyjh/elfin/entity/Script;

    invoke-direct {v2}, Lcom/cyjh/elfin/entity/Script;-><init>()V

    .line 34
    .local v2, "script":Lcom/cyjh/elfin/entity/Script;
    :cond_0
    :goto_0
    invoke-virtual {v1}, Landroid/util/JsonReader;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_6

    .line 35
    invoke-virtual {v1}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v0

    .line 36
    .local v0, "name":Ljava/lang/String;
    const-string v3, "BestResolution"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 37
    invoke-static {v1}, Lcom/cyjh/elfin/util/JsonUtils;->parBestResolutionJson(Landroid/util/JsonReader;)Lcom/cyjh/elfin/entity/BestResolution;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/cyjh/elfin/entity/Script;->setBestResolution(Lcom/cyjh/elfin/entity/BestResolution;)V

    goto :goto_0

    .line 38
    :cond_1
    const-string v3, "ChangeFileList"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 39
    invoke-virtual {v1}, Landroid/util/JsonReader;->nextInt()I

    move-result v3

    invoke-virtual {v2, v3}, Lcom/cyjh/elfin/entity/Script;->setChangeFileList(I)V

    goto :goto_0

    .line 40
    :cond_2
    const-string v3, "Description"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 41
    invoke-virtual {v1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/cyjh/elfin/entity/Script;->setDescription(Ljava/lang/String;)V

    goto :goto_0

    .line 42
    :cond_3
    const-string v3, "FileVersion"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4

    .line 43
    invoke-static {v1}, Lcom/cyjh/elfin/util/JsonUtils;->parFileVersionJson(Landroid/util/JsonReader;)Lcom/cyjh/elfin/entity/FileVersion;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/cyjh/elfin/entity/Script;->setFileVersion(Lcom/cyjh/elfin/entity/FileVersion;)V

    goto :goto_0

    .line 44
    :cond_4
    const-string v3, "Name"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_5

    .line 45
    invoke-virtual {v1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/cyjh/elfin/entity/Script;->setName(Ljava/lang/String;)V

    goto :goto_0

    .line 46
    :cond_5
    const-string v3, "id"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 47
    invoke-virtual {v1}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/cyjh/elfin/entity/Script;->setId(Ljava/lang/String;)V

    goto :goto_0

    .line 50
    .end local v0    # "name":Ljava/lang/String;
    :cond_6
    invoke-virtual {v1}, Landroid/util/JsonReader;->endObject()V

    .line 51
    return-object v2
.end method
