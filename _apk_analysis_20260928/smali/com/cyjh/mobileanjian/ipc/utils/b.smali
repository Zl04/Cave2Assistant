.class public Lcom/cyjh/mobileanjian/ipc/utils/b;
.super Ljava/lang/Object;
.source "SourceFile"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a(I)I
    .locals 3

    .prologue
    .line 12
    invoke-static {p0}, Landroid/graphics/Color;->blue(I)I

    move-result v0

    .line 13
    invoke-static {p0}, Landroid/graphics/Color;->green(I)I

    move-result v1

    .line 14
    invoke-static {p0}, Landroid/graphics/Color;->red(I)I

    move-result v2

    .line 16
    invoke-static {v0, v1, v2}, Landroid/graphics/Color;->rgb(III)I

    move-result v0

    return v0
.end method
