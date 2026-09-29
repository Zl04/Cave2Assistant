.class public Lcom/cyjh/mqm/MQLanguageStub$MQAuxiliary;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mqm/MQLanguageStub;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "MQAuxiliary"
.end annotation


# instance fields
.field final synthetic a:Lcom/cyjh/mqm/MQLanguageStub;


# direct methods
.method public constructor <init>(Lcom/cyjh/mqm/MQLanguageStub;)V
    .locals 0

    .prologue
    .line 30
    iput-object p1, p0, Lcom/cyjh/mqm/MQLanguageStub$MQAuxiliary;->a:Lcom/cyjh/mqm/MQLanguageStub;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public native ScreenCap([I)[B
.end method

.method public native SetScreenRotation(I)V
.end method

.method public native WaitKey()I
.end method
