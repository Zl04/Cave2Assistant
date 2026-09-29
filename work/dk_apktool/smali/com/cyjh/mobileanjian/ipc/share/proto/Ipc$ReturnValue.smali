.class public final Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;
.super Lcom/google/protobuf/GeneratedMessage;
.source "SourceFile"

# interfaces
.implements Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValueOrBuilder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "ReturnValue"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;
    }
.end annotation


# static fields
.field public static PARSER:Lcom/google/protobuf/Parser; = null
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/protobuf/Parser",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;",
            ">;"
        }
    .end annotation
.end field

.field public static final TYPE_FIELD_NUMBER:I = 0x1

.field public static final VALBOOLEAN_FIELD_NUMBER:I = 0x2

.field public static final VALDOUBLE_FIELD_NUMBER:I = 0x6

.field public static final VALFLOAT_FIELD_NUMBER:I = 0x5

.field public static final VALINT_FIELD_NUMBER:I = 0x3

.field public static final VALLONG_FIELD_NUMBER:I = 0x4

.field public static final VALSTRING_FIELD_NUMBER:I = 0x7

.field private static final defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

.field private static final serialVersionUID:J


# instance fields
.field private bitField0_:I

.field private memoizedIsInitialized:B

.field private memoizedSerializedSize:I

.field private type_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

.field private final unknownFields:Lcom/google/protobuf/UnknownFieldSet;

.field private valBoolean_:Z

.field private valDouble_:D

.field private valFloat_:F

.field private valInt_:I

.field private valLong_:J

.field private valString_:Ljava/lang/Object;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 959
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$1;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$1;-><init>()V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->PARSER:Lcom/google/protobuf/Parser;

    .line 1724
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;-><init>(Z)V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    .line 1725
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->initFields()V

    .line 1726
    return-void
.end method

.method private constructor <init>(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    const/4 v0, -0x1

    const/4 v1, 0x1

    .line 874
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage;-><init>()V

    .line 1123
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->memoizedIsInitialized:B

    .line 1159
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->memoizedSerializedSize:I

    .line 875
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->initFields()V

    .line 878
    invoke-static {}, Lcom/google/protobuf/UnknownFieldSet;->newBuilder()Lcom/google/protobuf/UnknownFieldSet$Builder;

    move-result-object v2

    .line 880
    const/4 v0, 0x0

    .line 881
    :cond_0
    :goto_0
    if-nez v0, :cond_2

    .line 882
    :try_start_0
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readTag()I

    move-result v3

    .line 883
    sparse-switch v3, :sswitch_data_0

    .line 888
    invoke-virtual {p0, p1, v2, p2, v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->parseUnknownField(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/UnknownFieldSet$Builder;Lcom/google/protobuf/ExtensionRegistryLite;I)Z

    move-result v3

    if-nez v3, :cond_0

    move v0, v1

    .line 890
    goto :goto_0

    :sswitch_0
    move v0, v1

    .line 886
    goto :goto_0

    .line 895
    :sswitch_1
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readEnum()I

    move-result v3

    .line 896
    invoke-static {v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->valueOf(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    move-result-object v4

    .line 897
    if-nez v4, :cond_1

    .line 898
    const/4 v4, 0x1

    invoke-virtual {v2, v4, v3}, Lcom/google/protobuf/UnknownFieldSet$Builder;->mergeVarintField(II)Lcom/google/protobuf/UnknownFieldSet$Builder;
    :try_end_0
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 937
    :catch_0
    move-exception v0

    .line 938
    :try_start_1
    invoke-virtual {v0, p0}, Lcom/google/protobuf/InvalidProtocolBufferException;->setUnfinishedMessage(Lcom/google/protobuf/MessageLite;)Lcom/google/protobuf/InvalidProtocolBufferException;

    move-result-object v0

    throw v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 943
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Lcom/google/protobuf/UnknownFieldSet$Builder;->build()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    .line 944
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->makeExtensionsImmutable()V

    throw v0

    .line 900
    :cond_1
    :try_start_2
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    or-int/lit8 v3, v3, 0x1

    iput v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    .line 901
    iput-object v4, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->type_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;
    :try_end_2
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    .line 939
    :catch_1
    move-exception v0

    .line 940
    :try_start_3
    new-instance v1, Lcom/google/protobuf/InvalidProtocolBufferException;

    .line 941
    invoke-virtual {v0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Lcom/google/protobuf/InvalidProtocolBufferException;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Lcom/google/protobuf/InvalidProtocolBufferException;->setUnfinishedMessage(Lcom/google/protobuf/MessageLite;)Lcom/google/protobuf/InvalidProtocolBufferException;

    move-result-object v0

    throw v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 906
    :sswitch_2
    :try_start_4
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    or-int/lit8 v3, v3, 0x2

    iput v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    .line 907
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBool()Z

    move-result v3

    iput-boolean v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valBoolean_:Z

    goto :goto_0

    .line 911
    :sswitch_3
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    or-int/lit8 v3, v3, 0x4

    iput v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    .line 912
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readInt32()I

    move-result v3

    iput v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valInt_:I

    goto :goto_0

    .line 916
    :sswitch_4
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    or-int/lit8 v3, v3, 0x8

    iput v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    .line 917
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readInt64()J

    move-result-wide v4

    iput-wide v4, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valLong_:J

    goto :goto_0

    .line 921
    :sswitch_5
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    or-int/lit8 v3, v3, 0x10

    iput v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    .line 922
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readFloat()F

    move-result v3

    iput v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valFloat_:F

    goto :goto_0

    .line 926
    :sswitch_6
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    or-int/lit8 v3, v3, 0x20

    iput v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    .line 927
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readDouble()D

    move-result-wide v4

    iput-wide v4, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valDouble_:D

    goto/16 :goto_0

    .line 931
    :sswitch_7
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    or-int/lit8 v3, v3, 0x40

    iput v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    .line 932
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v3

    iput-object v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valString_:Ljava/lang/Object;
    :try_end_4
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_4 .. :try_end_4} :catch_0
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto/16 :goto_0

    .line 943
    :cond_2
    invoke-virtual {v2}, Lcom/google/protobuf/UnknownFieldSet$Builder;->build()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    .line 944
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->makeExtensionsImmutable()V

    .line 946
    return-void

    .line 883
    :sswitch_data_0
    .sparse-switch
        0x0 -> :sswitch_0
        0x8 -> :sswitch_1
        0x10 -> :sswitch_2
        0x18 -> :sswitch_3
        0x20 -> :sswitch_4
        0x2d -> :sswitch_5
        0x31 -> :sswitch_6
        0x3a -> :sswitch_7
    .end sparse-switch
.end method

.method synthetic constructor <init>(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$1;)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 846
    invoke-direct {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;-><init>(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)V

    return-void
.end method

.method private constructor <init>(Lcom/google/protobuf/GeneratedMessage$Builder;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/protobuf/GeneratedMessage$Builder",
            "<*>;)V"
        }
    .end annotation

    .prologue
    const/4 v0, -0x1

    .line 851
    invoke-direct {p0, p1}, Lcom/google/protobuf/GeneratedMessage;-><init>(Lcom/google/protobuf/GeneratedMessage$Builder;)V

    .line 1123
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->memoizedIsInitialized:B

    .line 1159
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->memoizedSerializedSize:I

    .line 852
    invoke-virtual {p1}, Lcom/google/protobuf/GeneratedMessage$Builder;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    .line 853
    return-void
.end method

.method synthetic constructor <init>(Lcom/google/protobuf/GeneratedMessage$Builder;Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$1;)V
    .locals 0

    .prologue
    .line 846
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;-><init>(Lcom/google/protobuf/GeneratedMessage$Builder;)V

    return-void
.end method

.method private constructor <init>(Z)V
    .locals 1

    .prologue
    const/4 v0, -0x1

    .line 854
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage;-><init>()V

    .line 1123
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->memoizedIsInitialized:B

    .line 1159
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->memoizedSerializedSize:I

    .line 854
    invoke-static {}, Lcom/google/protobuf/UnknownFieldSet;->getDefaultInstance()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    return-void
.end method

.method static synthetic access$1500()Z
    .locals 1

    .prologue
    .line 846
    sget-boolean v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->alwaysUseFieldBuilders:Z

    return v0
.end method

.method static synthetic access$1702(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;
    .locals 0

    .prologue
    .line 846
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->type_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    return-object p1
.end method

.method static synthetic access$1802(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;Z)Z
    .locals 0

    .prologue
    .line 846
    iput-boolean p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valBoolean_:Z

    return p1
.end method

.method static synthetic access$1902(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;I)I
    .locals 0

    .prologue
    .line 846
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valInt_:I

    return p1
.end method

.method static synthetic access$2002(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;J)J
    .locals 1

    .prologue
    .line 846
    iput-wide p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valLong_:J

    return-wide p1
.end method

.method static synthetic access$2102(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;F)F
    .locals 0

    .prologue
    .line 846
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valFloat_:F

    return p1
.end method

.method static synthetic access$2202(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;D)D
    .locals 1

    .prologue
    .line 846
    iput-wide p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valDouble_:D

    return-wide p1
.end method

.method static synthetic access$2300(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 846
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valString_:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$2302(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .prologue
    .line 846
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valString_:Ljava/lang/Object;

    return-object p1
.end method

.method static synthetic access$2402(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;I)I
    .locals 0

    .prologue
    .line 846
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    return p1
.end method

.method public static getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;
    .locals 1

    .prologue
    .line 858
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    return-object v0
.end method

.method public static final getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 949
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->access$1000()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method private initFields()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 1115
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->VOID:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->type_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    .line 1116
    iput-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valBoolean_:Z

    .line 1117
    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valInt_:I

    .line 1118
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valLong_:J

    .line 1119
    const/4 v0, 0x0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valFloat_:F

    .line 1120
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valDouble_:D

    .line 1121
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valString_:Ljava/lang/Object;

    .line 1122
    return-void
.end method

.method public static newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;
    .locals 1

    .prologue
    .line 1258
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->access$1300()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static newBuilder(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;
    .locals 1

    .prologue
    .line 1261
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static parseDelimitedFrom(Ljava/io/InputStream;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 1238
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseDelimitedFrom(Ljava/io/InputStream;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    return-object v0
.end method

.method public static parseDelimitedFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 1244
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseDelimitedFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 1208
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/ByteString;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/ByteString;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 1214
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/ByteString;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/CodedInputStream;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 1249
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/CodedInputStream;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 1255
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    return-object v0
.end method

.method public static parseFrom(Ljava/io/InputStream;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 1228
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom(Ljava/io/InputStream;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    return-object v0
.end method

.method public static parseFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 1234
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    return-object v0
.end method

.method public static parseFrom([B)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 1218
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom([B)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    return-object v0
.end method

.method public static parseFrom([BLcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 1224
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom([BLcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    return-object v0
.end method


# virtual methods
.method public getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;
    .locals 1

    .prologue
    .line 862
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 846
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 846
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    move-result-object v0

    return-object v0
.end method

.method public getParserForType()Lcom/google/protobuf/Parser;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/protobuf/Parser",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;",
            ">;"
        }
    .end annotation

    .prologue
    .line 971
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->PARSER:Lcom/google/protobuf/Parser;

    return-object v0
.end method

.method public getSerializedSize()I
    .locals 5

    .prologue
    const/4 v4, 0x4

    const/4 v3, 0x2

    const/4 v2, 0x1

    .line 1161
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->memoizedSerializedSize:I

    .line 1162
    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    .line 1195
    :goto_0
    return v0

    .line 1164
    :cond_0
    const/4 v0, 0x0

    .line 1165
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    and-int/lit8 v1, v1, 0x1

    if-ne v1, v2, :cond_1

    .line 1166
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->type_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    .line 1167
    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->getNumber()I

    move-result v1

    invoke-static {v2, v1}, Lcom/google/protobuf/CodedOutputStream;->computeEnumSize(II)I

    move-result v1

    add-int/2addr v0, v1

    .line 1169
    :cond_1
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    and-int/lit8 v1, v1, 0x2

    if-ne v1, v3, :cond_2

    .line 1170
    iget-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valBoolean_:Z

    .line 1171
    invoke-static {v3, v1}, Lcom/google/protobuf/CodedOutputStream;->computeBoolSize(IZ)I

    move-result v1

    add-int/2addr v0, v1

    .line 1173
    :cond_2
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    and-int/lit8 v1, v1, 0x4

    if-ne v1, v4, :cond_3

    .line 1174
    const/4 v1, 0x3

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valInt_:I

    .line 1175
    invoke-static {v1, v2}, Lcom/google/protobuf/CodedOutputStream;->computeInt32Size(II)I

    move-result v1

    add-int/2addr v0, v1

    .line 1177
    :cond_3
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    and-int/lit8 v1, v1, 0x8

    const/16 v2, 0x8

    if-ne v1, v2, :cond_4

    .line 1178
    iget-wide v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valLong_:J

    .line 1179
    invoke-static {v4, v2, v3}, Lcom/google/protobuf/CodedOutputStream;->computeInt64Size(IJ)I

    move-result v1

    add-int/2addr v0, v1

    .line 1181
    :cond_4
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    and-int/lit8 v1, v1, 0x10

    const/16 v2, 0x10

    if-ne v1, v2, :cond_5

    .line 1182
    const/4 v1, 0x5

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valFloat_:F

    .line 1183
    invoke-static {v1, v2}, Lcom/google/protobuf/CodedOutputStream;->computeFloatSize(IF)I

    move-result v1

    add-int/2addr v0, v1

    .line 1185
    :cond_5
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    and-int/lit8 v1, v1, 0x20

    const/16 v2, 0x20

    if-ne v1, v2, :cond_6

    .line 1186
    const/4 v1, 0x6

    iget-wide v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valDouble_:D

    .line 1187
    invoke-static {v1, v2, v3}, Lcom/google/protobuf/CodedOutputStream;->computeDoubleSize(ID)I

    move-result v1

    add-int/2addr v0, v1

    .line 1189
    :cond_6
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    and-int/lit8 v1, v1, 0x40

    const/16 v2, 0x40

    if-ne v1, v2, :cond_7

    .line 1190
    const/4 v1, 0x7

    .line 1191
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getValStringBytes()Lcom/google/protobuf/ByteString;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/google/protobuf/CodedOutputStream;->computeBytesSize(ILcom/google/protobuf/ByteString;)I

    move-result v1

    add-int/2addr v0, v1

    .line 1193
    :cond_7
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/protobuf/UnknownFieldSet;->getSerializedSize()I

    move-result v1

    add-int/2addr v0, v1

    .line 1194
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->memoizedSerializedSize:I

    goto :goto_0
.end method

.method public getType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;
    .locals 1

    .prologue
    .line 988
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->type_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    return-object v0
.end method

.method public final getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;
    .locals 1

    .prologue
    .line 869
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    return-object v0
.end method

.method public getValBoolean()Z
    .locals 1

    .prologue
    .line 1004
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valBoolean_:Z

    return v0
.end method

.method public getValDouble()D
    .locals 2

    .prologue
    .line 1068
    iget-wide v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valDouble_:D

    return-wide v0
.end method

.method public getValFloat()F
    .locals 1

    .prologue
    .line 1052
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valFloat_:F

    return v0
.end method

.method public getValInt()I
    .locals 1

    .prologue
    .line 1020
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valInt_:I

    return v0
.end method

.method public getValLong()J
    .locals 2

    .prologue
    .line 1036
    iget-wide v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valLong_:J

    return-wide v0
.end method

.method public getValString()Ljava/lang/String;
    .locals 2

    .prologue
    .line 1084
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valString_:Ljava/lang/Object;

    .line 1085
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 1086
    check-cast v0, Ljava/lang/String;

    .line 1094
    :goto_0
    return-object v0

    .line 1088
    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 1090
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v1

    .line 1091
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->isValidUtf8()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1092
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valString_:Ljava/lang/Object;

    :cond_1
    move-object v0, v1

    .line 1094
    goto :goto_0
.end method

.method public getValStringBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 1102
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valString_:Ljava/lang/Object;

    .line 1103
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 1104
    check-cast v0, Ljava/lang/String;

    .line 1105
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 1107
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valString_:Ljava/lang/Object;

    .line 1110
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public hasType()Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 982
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    and-int/lit8 v1, v1, 0x1

    if-ne v1, v0, :cond_0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasValBoolean()Z
    .locals 2

    .prologue
    .line 998
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    and-int/lit8 v0, v0, 0x2

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasValDouble()Z
    .locals 2

    .prologue
    .line 1062
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    and-int/lit8 v0, v0, 0x20

    const/16 v1, 0x20

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasValFloat()Z
    .locals 2

    .prologue
    .line 1046
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    and-int/lit8 v0, v0, 0x10

    const/16 v1, 0x10

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasValInt()Z
    .locals 2

    .prologue
    .line 1014
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    and-int/lit8 v0, v0, 0x4

    const/4 v1, 0x4

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasValLong()Z
    .locals 2

    .prologue
    .line 1030
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    and-int/lit8 v0, v0, 0x8

    const/16 v1, 0x8

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasValString()Z
    .locals 2

    .prologue
    .line 1078
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    and-int/lit8 v0, v0, 0x40

    const/16 v1, 0x40

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method protected internalGetFieldAccessorTable()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;
    .locals 3

    .prologue
    .line 954
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->access$1100()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    const-class v1, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    const-class v2, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    .line 955
    invoke-virtual {v0, v1, v2}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;->ensureFieldAccessorsInitialized(Ljava/lang/Class;Ljava/lang/Class;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    .line 954
    return-object v0
.end method

.method public final isInitialized()Z
    .locals 3

    .prologue
    const/4 v0, 0x1

    .line 1125
    iget-byte v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->memoizedIsInitialized:B

    .line 1126
    const/4 v2, -0x1

    if-eq v1, v2, :cond_1

    if-ne v1, v0, :cond_0

    .line 1129
    :goto_0
    return v0

    .line 1126
    :cond_0
    const/4 v0, 0x0

    goto :goto_0

    .line 1128
    :cond_1
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->memoizedIsInitialized:B

    goto :goto_0
.end method

.method public newBuilderForType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;
    .locals 1

    .prologue
    .line 1259
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;
    .locals 2

    .prologue
    .line 1268
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    const/4 v1, 0x0

    invoke-direct {v0, p1, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$1;)V

    .line 1269
    return-object v0
.end method

.method public bridge synthetic newBuilderForType()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 846
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->newBuilderForType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected bridge synthetic newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 846
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic newBuilderForType()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 846
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->newBuilderForType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v0

    return-object v0
.end method

.method public toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;
    .locals 1

    .prologue
    .line 1263
    invoke-static {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->newBuilder(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic toBuilder()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 846
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic toBuilder()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 846
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected writeReplace()Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/ObjectStreamException;
        }
    .end annotation

    .prologue
    .line 1202
    invoke-super {p0}, Lcom/google/protobuf/GeneratedMessage;->writeReplace()Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public writeTo(Lcom/google/protobuf/CodedOutputStream;)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v3, 0x4

    const/4 v2, 0x2

    const/4 v1, 0x1

    .line 1134
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getSerializedSize()I

    .line 1135
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    and-int/lit8 v0, v0, 0x1

    if-ne v0, v1, :cond_0

    .line 1136
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->type_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->getNumber()I

    move-result v0

    invoke-virtual {p1, v1, v0}, Lcom/google/protobuf/CodedOutputStream;->writeEnum(II)V

    .line 1138
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    and-int/lit8 v0, v0, 0x2

    if-ne v0, v2, :cond_1

    .line 1139
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valBoolean_:Z

    invoke-virtual {p1, v2, v0}, Lcom/google/protobuf/CodedOutputStream;->writeBool(IZ)V

    .line 1141
    :cond_1
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    and-int/lit8 v0, v0, 0x4

    if-ne v0, v3, :cond_2

    .line 1142
    const/4 v0, 0x3

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valInt_:I

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeInt32(II)V

    .line 1144
    :cond_2
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    and-int/lit8 v0, v0, 0x8

    const/16 v1, 0x8

    if-ne v0, v1, :cond_3

    .line 1145
    iget-wide v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valLong_:J

    invoke-virtual {p1, v3, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeInt64(IJ)V

    .line 1147
    :cond_3
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    and-int/lit8 v0, v0, 0x10

    const/16 v1, 0x10

    if-ne v0, v1, :cond_4

    .line 1148
    const/4 v0, 0x5

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valFloat_:F

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeFloat(IF)V

    .line 1150
    :cond_4
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    and-int/lit8 v0, v0, 0x20

    const/16 v1, 0x20

    if-ne v0, v1, :cond_5

    .line 1151
    const/4 v0, 0x6

    iget-wide v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->valDouble_:D

    invoke-virtual {p1, v0, v2, v3}, Lcom/google/protobuf/CodedOutputStream;->writeDouble(ID)V

    .line 1153
    :cond_5
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->bitField0_:I

    and-int/lit8 v0, v0, 0x40

    const/16 v1, 0x40

    if-ne v0, v1, :cond_6

    .line 1154
    const/4 v0, 0x7

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getValStringBytes()Lcom/google/protobuf/ByteString;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeBytes(ILcom/google/protobuf/ByteString;)V

    .line 1156
    :cond_6
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/google/protobuf/UnknownFieldSet;->writeTo(Lcom/google/protobuf/CodedOutputStream;)V

    .line 1157
    return-void
.end method
