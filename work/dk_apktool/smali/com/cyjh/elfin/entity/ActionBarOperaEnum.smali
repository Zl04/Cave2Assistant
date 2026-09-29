.class public final enum Lcom/cyjh/elfin/entity/ActionBarOperaEnum;
.super Ljava/lang/Enum;
.source "ActionBarOperaEnum.java"

# interfaces
.implements Ljava/io/Serializable;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/cyjh/elfin/entity/ActionBarOperaEnum;",
        ">;",
        "Ljava/io/Serializable;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

.field public static final enum ALL_CHECK:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

.field public static final enum CANCLE:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

.field public static final enum CLOUD:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

.field public static final enum CREATE_NEW_FILE:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

.field public static final enum DELETE:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

.field public static final enum EDIT_SCRIPT:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

.field public static final enum HEAD_ICON:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

.field public static final enum MOVE:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

.field public static final enum NO_ALL_CHECK:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

.field public static final enum RENAME:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

.field public static final enum RUN_SCRIPT:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

.field public static final enum SAVE:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

.field public static final enum SEARCH:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

.field public static final enum START_DOWNLOAD:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;


# direct methods
.method static constructor <clinit>()V
    .locals 8

    .prologue
    const/4 v7, 0x4

    const/4 v6, 0x3

    const/4 v5, 0x2

    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 10
    new-instance v0, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    const-string v1, "CANCLE"

    invoke-direct {v0, v1, v3}, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->CANCLE:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    .line 12
    new-instance v0, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    const-string v1, "SAVE"

    invoke-direct {v0, v1, v4}, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->SAVE:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    .line 14
    new-instance v0, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    const-string v1, "RENAME"

    invoke-direct {v0, v1, v5}, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->RENAME:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    .line 16
    new-instance v0, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    const-string v1, "DELETE"

    invoke-direct {v0, v1, v6}, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->DELETE:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    .line 18
    new-instance v0, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    const-string v1, "MOVE"

    invoke-direct {v0, v1, v7}, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->MOVE:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    .line 20
    new-instance v0, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    const-string v1, "EDIT_SCRIPT"

    const/4 v2, 0x5

    invoke-direct {v0, v1, v2}, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->EDIT_SCRIPT:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    .line 22
    new-instance v0, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    const-string v1, "ALL_CHECK"

    const/4 v2, 0x6

    invoke-direct {v0, v1, v2}, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->ALL_CHECK:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    .line 24
    new-instance v0, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    const-string v1, "NO_ALL_CHECK"

    const/4 v2, 0x7

    invoke-direct {v0, v1, v2}, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->NO_ALL_CHECK:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    .line 26
    new-instance v0, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    const-string v1, "CLOUD"

    const/16 v2, 0x8

    invoke-direct {v0, v1, v2}, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->CLOUD:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    .line 28
    new-instance v0, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    const-string v1, "CREATE_NEW_FILE"

    const/16 v2, 0x9

    invoke-direct {v0, v1, v2}, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->CREATE_NEW_FILE:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    .line 30
    new-instance v0, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    const-string v1, "RUN_SCRIPT"

    const/16 v2, 0xa

    invoke-direct {v0, v1, v2}, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->RUN_SCRIPT:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    .line 32
    new-instance v0, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    const-string v1, "HEAD_ICON"

    const/16 v2, 0xb

    invoke-direct {v0, v1, v2}, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->HEAD_ICON:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    .line 33
    new-instance v0, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    const-string v1, "SEARCH"

    const/16 v2, 0xc

    invoke-direct {v0, v1, v2}, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->SEARCH:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    .line 35
    new-instance v0, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    const-string v1, "START_DOWNLOAD"

    const/16 v2, 0xd

    invoke-direct {v0, v1, v2}, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->START_DOWNLOAD:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    .line 8
    const/16 v0, 0xe

    new-array v0, v0, [Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    sget-object v1, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->CANCLE:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    aput-object v1, v0, v3

    sget-object v1, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->SAVE:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    aput-object v1, v0, v4

    sget-object v1, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->RENAME:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    aput-object v1, v0, v5

    sget-object v1, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->DELETE:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    aput-object v1, v0, v6

    sget-object v1, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->MOVE:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    aput-object v1, v0, v7

    const/4 v1, 0x5

    sget-object v2, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->EDIT_SCRIPT:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    aput-object v2, v0, v1

    const/4 v1, 0x6

    sget-object v2, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->ALL_CHECK:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    aput-object v2, v0, v1

    const/4 v1, 0x7

    sget-object v2, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->NO_ALL_CHECK:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    aput-object v2, v0, v1

    const/16 v1, 0x8

    sget-object v2, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->CLOUD:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    aput-object v2, v0, v1

    const/16 v1, 0x9

    sget-object v2, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->CREATE_NEW_FILE:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    aput-object v2, v0, v1

    const/16 v1, 0xa

    sget-object v2, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->RUN_SCRIPT:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    aput-object v2, v0, v1

    const/16 v1, 0xb

    sget-object v2, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->HEAD_ICON:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    aput-object v2, v0, v1

    const/16 v1, 0xc

    sget-object v2, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->SEARCH:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    aput-object v2, v0, v1

    const/16 v1, 0xd

    sget-object v2, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->START_DOWNLOAD:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    aput-object v2, v0, v1

    sput-object v0, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->$VALUES:[Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

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

.method public static valueOf(Ljava/lang/String;)Lcom/cyjh/elfin/entity/ActionBarOperaEnum;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .prologue
    .line 8
    const-class v0, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    return-object v0
.end method

.method public static values()[Lcom/cyjh/elfin/entity/ActionBarOperaEnum;
    .locals 1

    .prologue
    .line 8
    sget-object v0, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->$VALUES:[Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    invoke-virtual {v0}, [Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    return-object v0
.end method
