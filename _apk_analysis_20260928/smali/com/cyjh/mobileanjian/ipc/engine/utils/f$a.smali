.class public Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/engine/utils/f;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "a"
.end annotation


# instance fields
.field public a:I

.field public b:Ljava/lang/String;

.field public c:Ljava/lang/String;


# direct methods
.method public constructor <init>(I)V
    .locals 0

    .prologue
    .line 225
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 226
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;->a:I

    .line 227
    return-void
.end method

.method public constructor <init>(ILjava/lang/String;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 229
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 230
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;->a:I

    .line 231
    iput-object p2, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;->b:Ljava/lang/String;

    .line 232
    iput-object p3, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;->c:Ljava/lang/String;

    .line 233
    return-void
.end method
