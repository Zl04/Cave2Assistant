.class final enum Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;
.super Ljava/lang/Enum;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/protobuf/Descriptors$DescriptorPool;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4018
    name = "SearchFilter"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum AGGREGATES_ONLY:Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;

.field public static final enum ALL_SYMBOLS:Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;

.field private static final synthetic ENUM$VALUES:[Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;

.field public static final enum TYPES_ONLY:Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .prologue
    const/4 v4, 0x2

    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 1620
    new-instance v0, Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;

    const-string v1, "TYPES_ONLY"

    invoke-direct {v0, v1, v2}, Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;->TYPES_ONLY:Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;

    new-instance v0, Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;

    const-string v1, "AGGREGATES_ONLY"

    invoke-direct {v0, v1, v3}, Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;->AGGREGATES_ONLY:Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;

    new-instance v0, Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;

    const-string v1, "ALL_SYMBOLS"

    invoke-direct {v0, v1, v4}, Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;->ALL_SYMBOLS:Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;

    .line 1619
    const/4 v0, 0x3

    new-array v0, v0, [Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;

    sget-object v1, Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;->TYPES_ONLY:Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;

    aput-object v1, v0, v2

    sget-object v1, Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;->AGGREGATES_ONLY:Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;

    aput-object v1, v0, v3

    sget-object v1, Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;->ALL_SYMBOLS:Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;

    aput-object v1, v0, v4

    sput-object v0, Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;->ENUM$VALUES:[Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0

    .prologue
    .line 1619
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;
    .locals 1

    .prologue
    .line 1
    const-class v0, Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;

    return-object v0
.end method

.method public static values()[Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 1
    sget-object v0, Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;->ENUM$VALUES:[Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;

    array-length v1, v0

    new-array v2, v1, [Lcom/google/protobuf/Descriptors$DescriptorPool$SearchFilter;

    invoke-static {v0, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-object v2
.end method
