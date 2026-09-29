.class public Lcom/cyjh/mobileanjian/ipc/engine/utils/a;
.super Ljava/lang/Object;
.source "SourceFile"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a([Ljava/lang/Object;)Z
    .locals 1

    .prologue
    .line 27
    if-eqz p0, :cond_0

    array-length v0, p0

    if-nez v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static b([Ljava/lang/Object;)Z
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 38
    array-length v2, p0

    move v1, v0

    :goto_0
    if-ge v1, v2, :cond_0

    aget-object v3, p0, v1

    .line 39
    if-nez v3, :cond_1

    .line 40
    const/4 v0, 0x1

    .line 41
    :cond_0
    return v0

    .line 38
    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0
.end method
