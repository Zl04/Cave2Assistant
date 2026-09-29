.class public Lcom/umeng/commonsdk/proguard/bf$a;
.super Ljava/lang/Object;
.source "TTupleProtocol.java"

# interfaces
.implements Lcom/umeng/commonsdk/proguard/bb;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/umeng/commonsdk/proguard/bf;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "a"
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lcom/umeng/commonsdk/proguard/bn;)Lcom/umeng/commonsdk/proguard/az;
    .locals 1

    .prologue
    .line 35
    new-instance v0, Lcom/umeng/commonsdk/proguard/bf;

    invoke-direct {v0, p1}, Lcom/umeng/commonsdk/proguard/bf;-><init>(Lcom/umeng/commonsdk/proguard/bn;)V

    return-object v0
.end method
