.class public final enum Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;
.super Ljava/lang/Enum;
.source "LoadStatueEnum.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

.field public static final enum COMPLETE:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

.field public static final enum EMPTY:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

.field public static final enum FAILED:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

.field public static final enum LOADING:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

.field public static final enum NON:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;


# direct methods
.method static constructor <clinit>()V
    .locals 7

    .prologue
    const/4 v6, 0x4

    const/4 v5, 0x3

    const/4 v4, 0x2

    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 11
    new-instance v0, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    const-string v1, "NON"

    invoke-direct {v0, v1, v2}, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;->NON:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    new-instance v0, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    const-string v1, "LOADING"

    invoke-direct {v0, v1, v3}, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;->LOADING:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    new-instance v0, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    const-string v1, "FAILED"

    invoke-direct {v0, v1, v4}, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;->FAILED:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    new-instance v0, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    const-string v1, "EMPTY"

    invoke-direct {v0, v1, v5}, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;->EMPTY:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    new-instance v0, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    const-string v1, "COMPLETE"

    invoke-direct {v0, v1, v6}, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;->COMPLETE:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    .line 8
    const/4 v0, 0x5

    new-array v0, v0, [Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    sget-object v1, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;->NON:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    aput-object v1, v0, v2

    sget-object v1, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;->LOADING:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    aput-object v1, v0, v3

    sget-object v1, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;->FAILED:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    aput-object v1, v0, v4

    sget-object v1, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;->EMPTY:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    aput-object v1, v0, v5

    sget-object v1, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;->COMPLETE:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    aput-object v1, v0, v6

    sput-object v0, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;->$VALUES:[Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 8
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .prologue
    .line 8
    const-class v0, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    return-object v0
.end method

.method public static values()[Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;
    .locals 1

    .prologue
    .line 8
    sget-object v0, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;->$VALUES:[Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    invoke-virtual {v0}, [Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    return-object v0
.end method
