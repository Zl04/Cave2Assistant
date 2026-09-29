.class public Lcom/cyjh/mobileanjian/ipc/engine/utils/c;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static final a:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 24
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/engine/utils/c$1;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/engine/utils/c$1;-><init>()V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/engine/utils/c;->a:Ljava/util/HashMap;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;
    .locals 1

    .prologue
    .line 39
    invoke-static {p0}, Lcom/cyjh/mobileanjian/ipc/engine/utils/h;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 40
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->VOID:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    .line 42
    :goto_0
    return-object v0

    :cond_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/engine/utils/c;->a:Ljava/util/HashMap;

    invoke-virtual {v0, p0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    goto :goto_0
.end method
