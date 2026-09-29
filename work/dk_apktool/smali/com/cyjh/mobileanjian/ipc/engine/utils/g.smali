.class public Lcom/cyjh/mobileanjian/ipc/engine/utils/g;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static final a:I = 0xa

.field public static final b:Ljava/lang/String; = "v"

.field public static c:Ljava/lang/String; = null

.field public static d:Ljava/lang/String; = null

.field public static final e:Ljava/lang/String; = ".event.localserver"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 8
    sput-object v0, Lcom/cyjh/mobileanjian/ipc/engine/utils/g;->c:Ljava/lang/String;

    .line 9
    sput-object v0, Lcom/cyjh/mobileanjian/ipc/engine/utils/g;->d:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 3
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
