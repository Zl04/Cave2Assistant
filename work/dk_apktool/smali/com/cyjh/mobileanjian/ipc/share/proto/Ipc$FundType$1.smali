.class final Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType$1;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/google/protobuf/Internal$EnumLiteMap;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/google/protobuf/Internal$EnumLiteMap",
        "<",
        "Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;",
        ">;"
    }
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 97
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public findValueByNumber(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;
    .locals 1

    .prologue
    .line 99
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->valueOf(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic findValueByNumber(I)Lcom/google/protobuf/Internal$EnumLite;
    .locals 1

    .prologue
    .line 97
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType$1;->findValueByNumber(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    move-result-object v0

    return-object v0
.end method
