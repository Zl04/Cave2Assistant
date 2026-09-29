.class public final Lcom/king/sdk/a;
.super Landroid/app/Service;
.source "SourceFile"


# static fields
.field private static a:Lcom/king/sdk/b;


# instance fields
.field private b:Lcom/king/sdk/f;


# direct methods
.method public static a()Lcom/king/sdk/b;
    .locals 1

    .prologue
    .line 17
    sget-object v0, Lcom/king/sdk/a;->a:Lcom/king/sdk/b;

    return-object v0
.end method


# virtual methods
.method public final onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 1

    .prologue
    .line 31
    iget-object v0, p0, Lcom/king/sdk/a;->b:Lcom/king/sdk/f;

    return-object v0
.end method
