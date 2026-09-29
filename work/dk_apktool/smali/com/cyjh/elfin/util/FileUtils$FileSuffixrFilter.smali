.class public Lcom/cyjh/elfin/util/FileUtils$FileSuffixrFilter;
.super Ljava/lang/Object;
.source "FileUtils.java"

# interfaces
.implements Ljava/io/FilenameFilter;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/util/FileUtils;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "FileSuffixrFilter"
.end annotation


# instance fields
.field private fileSuffix:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 0
    .param p1, "fileSuffix"    # Ljava/lang/String;

    .prologue
    .line 149
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 150
    iput-object p1, p0, Lcom/cyjh/elfin/util/FileUtils$FileSuffixrFilter;->fileSuffix:Ljava/lang/String;

    .line 151
    return-void
.end method


# virtual methods
.method public accept(Ljava/io/File;Ljava/lang/String;)Z
    .locals 1
    .param p1, "dir"    # Ljava/io/File;
    .param p2, "filename"    # Ljava/lang/String;

    .prologue
    .line 155
    iget-object v0, p0, Lcom/cyjh/elfin/util/FileUtils$FileSuffixrFilter;->fileSuffix:Ljava/lang/String;

    invoke-virtual {p2, v0}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method
