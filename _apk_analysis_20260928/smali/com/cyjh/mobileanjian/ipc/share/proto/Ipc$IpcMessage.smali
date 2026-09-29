.class public final Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;
.super Lcom/google/protobuf/GeneratedMessage;
.source "SourceFile"

# interfaces
.implements Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessageOrBuilder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "IpcMessage"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    }
.end annotation


# static fields
.field public static final ARG1_FIELD_NUMBER:I = 0x2

.field public static final ARG2_FIELD_NUMBER:I = 0x3

.field public static final ARG3_FIELD_NUMBER:I = 0x4

.field public static final ARG4_FIELD_NUMBER:I = 0x6

.field public static final CLASSNAME_FIELD_NUMBER:I = 0x8

.field public static final CMD_FIELD_NUMBER:I = 0x1

.field public static final ENCRYPT_FIELD_NUMBER:I = 0xf

.field public static final FILEDATA_FIELD_NUMBER:I = 0x5

.field public static final ISDEBUG_FIELD_NUMBER:I = 0x10

.field public static final ISSYNCCALL_FIELD_NUMBER:I = 0xc

.field public static final METHODNAME_FIELD_NUMBER:I = 0x9

.field public static final PARAMS_FIELD_NUMBER:I = 0xb

.field public static PARSER:Lcom/google/protobuf/Parser; = null
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/protobuf/Parser",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;",
            ">;"
        }
    .end annotation
.end field

.field public static final PKGNAME_FIELD_NUMBER:I = 0x7

.field public static final RETVALUE_FIELD_NUMBER:I = 0xe

.field public static final TYPES_FIELD_NUMBER:I = 0xa

.field public static final WAITID_FIELD_NUMBER:I = 0xd

.field private static final defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

.field private static final serialVersionUID:J


# instance fields
.field private arg1_:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private arg2_:Lcom/google/protobuf/LazyStringList;

.field private arg3_:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/Float;",
            ">;"
        }
    .end annotation
.end field

.field private arg4_:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/Long;",
            ">;"
        }
    .end annotation
.end field

.field private bitField0_:I

.field private className_:Ljava/lang/Object;

.field private cmd_:I

.field private encrypt_:Z

.field private fileData_:Lcom/google/protobuf/ByteString;

.field private isDebug_:Z

.field private isSyncCall_:Z

.field private memoizedIsInitialized:B

.field private memoizedSerializedSize:I

.field private methodName_:Ljava/lang/Object;

.field private params_:Lcom/google/protobuf/LazyStringList;

.field private pkgName_:Ljava/lang/Object;

.field private retValue_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

.field private types_:Lcom/google/protobuf/LazyStringList;

.field private final unknownFields:Lcom/google/protobuf/UnknownFieldSet;

.field private waitId_:I


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 2213
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$1;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$1;-><init>()V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->PARSER:Lcom/google/protobuf/Parser;

    .line 4291
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;-><init>(Z)V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    .line 4292
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->initFields()V

    .line 4293
    return-void
.end method

.method private constructor <init>(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)V
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 2006
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage;-><init>()V

    .line 2673
    const/4 v0, -0x1

    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->memoizedIsInitialized:B

    .line 2736
    const/4 v0, -0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->memoizedSerializedSize:I

    .line 2007
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->initFields()V

    .line 2008
    const/4 v2, 0x0

    .line 2010
    invoke-static {}, Lcom/google/protobuf/UnknownFieldSet;->newBuilder()Lcom/google/protobuf/UnknownFieldSet$Builder;

    move-result-object v4

    .line 2012
    const/4 v1, 0x0

    .line 2013
    :goto_0
    if-nez v1, :cond_b

    .line 2014
    :try_start_0
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readTag()I

    move-result v0

    .line 2015
    sparse-switch v0, :sswitch_data_0

    .line 2020
    invoke-virtual {p0, p1, v4, p2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->parseUnknownField(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/UnknownFieldSet$Builder;Lcom/google/protobuf/ExtensionRegistryLite;I)Z

    move-result v0

    if-nez v0, :cond_a

    .line 2022
    const/4 v0, 0x1

    move v1, v2

    :goto_1
    move v2, v1

    move v1, v0

    .line 2172
    goto :goto_0

    .line 2017
    :sswitch_0
    const/4 v0, 0x1

    move v1, v2

    .line 2018
    goto :goto_1

    .line 2027
    :sswitch_1
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    or-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    .line 2028
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readInt32()I

    move-result v0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->cmd_:I

    move v0, v1

    move v1, v2

    .line 2029
    goto :goto_1

    .line 2032
    :sswitch_2
    and-int/lit8 v0, v2, 0x2

    const/4 v3, 0x2

    if-eq v0, v3, :cond_1b

    .line 2033
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg1_:Ljava/util/List;
    :try_end_0
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2034
    or-int/lit8 v0, v2, 0x2

    .line 2036
    :goto_2
    :try_start_1
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg1_:Ljava/util/List;

    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readInt32()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move v8, v1

    move v1, v0

    move v0, v8

    .line 2037
    goto :goto_1

    .line 2040
    :sswitch_3
    :try_start_2
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readRawVarint32()I

    move-result v0

    .line 2041
    invoke-virtual {p1, v0}, Lcom/google/protobuf/CodedInputStream;->pushLimit(I)I

    move-result v3

    .line 2042
    and-int/lit8 v0, v2, 0x2

    const/4 v5, 0x2

    if-eq v0, v5, :cond_1a

    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->getBytesUntilLimit()I

    move-result v0

    if-lez v0, :cond_1a

    .line 2043
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg1_:Ljava/util/List;
    :try_end_2
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_2 .. :try_end_2} :catch_3
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 2044
    or-int/lit8 v0, v2, 0x2

    .line 2046
    :goto_3
    :try_start_3
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->getBytesUntilLimit()I

    move-result v2

    if-lez v2, :cond_6

    .line 2047
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg1_:Ljava/util/List;

    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readInt32()I

    move-result v5

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-interface {v2, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_3
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_3 .. :try_end_3} :catch_0
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    goto :goto_3

    .line 2173
    :catch_0
    move-exception v1

    move v2, v0

    move-object v0, v1

    .line 2174
    :goto_4
    :try_start_4
    invoke-virtual {v0, p0}, Lcom/google/protobuf/InvalidProtocolBufferException;->setUnfinishedMessage(Lcom/google/protobuf/MessageLite;)Lcom/google/protobuf/InvalidProtocolBufferException;

    move-result-object v0

    throw v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 2179
    :catchall_0
    move-exception v0

    :goto_5
    and-int/lit8 v1, v2, 0x2

    const/4 v3, 0x2

    if-ne v1, v3, :cond_0

    .line 2180
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg1_:Ljava/util/List;

    invoke-static {v1}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg1_:Ljava/util/List;

    .line 2182
    :cond_0
    and-int/lit8 v1, v2, 0x4

    const/4 v3, 0x4

    if-ne v1, v3, :cond_1

    .line 2183
    new-instance v1, Lcom/google/protobuf/UnmodifiableLazyStringList;

    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg2_:Lcom/google/protobuf/LazyStringList;

    invoke-direct {v1, v3}, Lcom/google/protobuf/UnmodifiableLazyStringList;-><init>(Lcom/google/protobuf/LazyStringList;)V

    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg2_:Lcom/google/protobuf/LazyStringList;

    .line 2185
    :cond_1
    and-int/lit8 v1, v2, 0x8

    const/16 v3, 0x8

    if-ne v1, v3, :cond_2

    .line 2186
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg3_:Ljava/util/List;

    invoke-static {v1}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg3_:Ljava/util/List;

    .line 2188
    :cond_2
    and-int/lit8 v1, v2, 0x20

    const/16 v3, 0x20

    if-ne v1, v3, :cond_3

    .line 2189
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg4_:Ljava/util/List;

    invoke-static {v1}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg4_:Ljava/util/List;

    .line 2191
    :cond_3
    and-int/lit16 v1, v2, 0x200

    const/16 v3, 0x200

    if-ne v1, v3, :cond_4

    .line 2192
    new-instance v1, Lcom/google/protobuf/UnmodifiableLazyStringList;

    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->types_:Lcom/google/protobuf/LazyStringList;

    invoke-direct {v1, v3}, Lcom/google/protobuf/UnmodifiableLazyStringList;-><init>(Lcom/google/protobuf/LazyStringList;)V

    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->types_:Lcom/google/protobuf/LazyStringList;

    .line 2194
    :cond_4
    and-int/lit16 v1, v2, 0x400

    const/16 v2, 0x400

    if-ne v1, v2, :cond_5

    .line 2195
    new-instance v1, Lcom/google/protobuf/UnmodifiableLazyStringList;

    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->params_:Lcom/google/protobuf/LazyStringList;

    invoke-direct {v1, v2}, Lcom/google/protobuf/UnmodifiableLazyStringList;-><init>(Lcom/google/protobuf/LazyStringList;)V

    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->params_:Lcom/google/protobuf/LazyStringList;

    .line 2197
    :cond_5
    invoke-virtual {v4}, Lcom/google/protobuf/UnknownFieldSet$Builder;->build()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    .line 2198
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->makeExtensionsImmutable()V

    throw v0

    .line 2049
    :cond_6
    :try_start_5
    invoke-virtual {p1, v3}, Lcom/google/protobuf/CodedInputStream;->popLimit(I)V
    :try_end_5
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_5 .. :try_end_5} :catch_0
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_1
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    move v8, v1

    move v1, v0

    move v0, v8

    .line 2050
    goto/16 :goto_1

    .line 2053
    :sswitch_4
    and-int/lit8 v0, v2, 0x4

    const/4 v3, 0x4

    if-eq v0, v3, :cond_19

    .line 2054
    :try_start_6
    new-instance v0, Lcom/google/protobuf/LazyStringArrayList;

    invoke-direct {v0}, Lcom/google/protobuf/LazyStringArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg2_:Lcom/google/protobuf/LazyStringList;
    :try_end_6
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_6 .. :try_end_6} :catch_3
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_2
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    .line 2055
    or-int/lit8 v0, v2, 0x4

    .line 2057
    :goto_6
    :try_start_7
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg2_:Lcom/google/protobuf/LazyStringList;

    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v3

    invoke-interface {v2, v3}, Lcom/google/protobuf/LazyStringList;->add(Lcom/google/protobuf/ByteString;)V
    :try_end_7
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_7 .. :try_end_7} :catch_0
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_1
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    move v8, v1

    move v1, v0

    move v0, v8

    .line 2058
    goto/16 :goto_1

    .line 2061
    :sswitch_5
    and-int/lit8 v0, v2, 0x8

    const/16 v3, 0x8

    if-eq v0, v3, :cond_18

    .line 2062
    :try_start_8
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg3_:Ljava/util/List;
    :try_end_8
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_8 .. :try_end_8} :catch_3
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_2
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    .line 2063
    or-int/lit8 v0, v2, 0x8

    .line 2065
    :goto_7
    :try_start_9
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg3_:Ljava/util/List;

    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readFloat()F

    move-result v3

    invoke-static {v3}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v3

    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_9
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_9 .. :try_end_9} :catch_0
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_1
    .catchall {:try_start_9 .. :try_end_9} :catchall_1

    move v8, v1

    move v1, v0

    move v0, v8

    .line 2066
    goto/16 :goto_1

    .line 2069
    :sswitch_6
    :try_start_a
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readRawVarint32()I

    move-result v0

    .line 2070
    invoke-virtual {p1, v0}, Lcom/google/protobuf/CodedInputStream;->pushLimit(I)I

    move-result v3

    .line 2071
    and-int/lit8 v0, v2, 0x8

    const/16 v5, 0x8

    if-eq v0, v5, :cond_17

    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->getBytesUntilLimit()I

    move-result v0

    if-lez v0, :cond_17

    .line 2072
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg3_:Ljava/util/List;
    :try_end_a
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_a .. :try_end_a} :catch_3
    .catch Ljava/io/IOException; {:try_start_a .. :try_end_a} :catch_2
    .catchall {:try_start_a .. :try_end_a} :catchall_0

    .line 2073
    or-int/lit8 v0, v2, 0x8

    .line 2075
    :goto_8
    :try_start_b
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->getBytesUntilLimit()I

    move-result v2

    if-lez v2, :cond_7

    .line 2076
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg3_:Ljava/util/List;

    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readFloat()F

    move-result v5

    invoke-static {v5}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v5

    invoke-interface {v2, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_b
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_b .. :try_end_b} :catch_0
    .catch Ljava/io/IOException; {:try_start_b .. :try_end_b} :catch_1
    .catchall {:try_start_b .. :try_end_b} :catchall_1

    goto :goto_8

    .line 2175
    :catch_1
    move-exception v1

    move v2, v0

    move-object v0, v1

    .line 2176
    :goto_9
    :try_start_c
    new-instance v1, Lcom/google/protobuf/InvalidProtocolBufferException;

    .line 2177
    invoke-virtual {v0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Lcom/google/protobuf/InvalidProtocolBufferException;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Lcom/google/protobuf/InvalidProtocolBufferException;->setUnfinishedMessage(Lcom/google/protobuf/MessageLite;)Lcom/google/protobuf/InvalidProtocolBufferException;

    move-result-object v0

    throw v0
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_0

    .line 2078
    :cond_7
    :try_start_d
    invoke-virtual {p1, v3}, Lcom/google/protobuf/CodedInputStream;->popLimit(I)V
    :try_end_d
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_d .. :try_end_d} :catch_0
    .catch Ljava/io/IOException; {:try_start_d .. :try_end_d} :catch_1
    .catchall {:try_start_d .. :try_end_d} :catchall_1

    move v8, v1

    move v1, v0

    move v0, v8

    .line 2079
    goto/16 :goto_1

    .line 2082
    :sswitch_7
    :try_start_e
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    .line 2083
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->fileData_:Lcom/google/protobuf/ByteString;

    move v0, v1

    move v1, v2

    .line 2084
    goto/16 :goto_1

    .line 2087
    :sswitch_8
    and-int/lit8 v0, v2, 0x20

    const/16 v3, 0x20

    if-eq v0, v3, :cond_16

    .line 2088
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg4_:Ljava/util/List;
    :try_end_e
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_e .. :try_end_e} :catch_3
    .catch Ljava/io/IOException; {:try_start_e .. :try_end_e} :catch_2
    .catchall {:try_start_e .. :try_end_e} :catchall_0

    .line 2089
    or-int/lit8 v0, v2, 0x20

    .line 2091
    :goto_a
    :try_start_f
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg4_:Ljava/util/List;

    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readInt64()J

    move-result-wide v6

    invoke-static {v6, v7}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_f
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_f .. :try_end_f} :catch_0
    .catch Ljava/io/IOException; {:try_start_f .. :try_end_f} :catch_1
    .catchall {:try_start_f .. :try_end_f} :catchall_1

    move v8, v1

    move v1, v0

    move v0, v8

    .line 2092
    goto/16 :goto_1

    .line 2095
    :sswitch_9
    :try_start_10
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readRawVarint32()I

    move-result v0

    .line 2096
    invoke-virtual {p1, v0}, Lcom/google/protobuf/CodedInputStream;->pushLimit(I)I

    move-result v3

    .line 2097
    and-int/lit8 v0, v2, 0x20

    const/16 v5, 0x20

    if-eq v0, v5, :cond_15

    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->getBytesUntilLimit()I

    move-result v0

    if-lez v0, :cond_15

    .line 2098
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg4_:Ljava/util/List;
    :try_end_10
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_10 .. :try_end_10} :catch_3
    .catch Ljava/io/IOException; {:try_start_10 .. :try_end_10} :catch_2
    .catchall {:try_start_10 .. :try_end_10} :catchall_0

    .line 2099
    or-int/lit8 v0, v2, 0x20

    .line 2101
    :goto_b
    :try_start_11
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->getBytesUntilLimit()I

    move-result v2

    if-lez v2, :cond_8

    .line 2102
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg4_:Ljava/util/List;

    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readInt64()J

    move-result-wide v6

    invoke-static {v6, v7}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v5

    invoke-interface {v2, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_b

    .line 2179
    :catchall_1
    move-exception v1

    move v2, v0

    move-object v0, v1

    goto/16 :goto_5

    .line 2104
    :cond_8
    invoke-virtual {p1, v3}, Lcom/google/protobuf/CodedInputStream;->popLimit(I)V
    :try_end_11
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_11 .. :try_end_11} :catch_0
    .catch Ljava/io/IOException; {:try_start_11 .. :try_end_11} :catch_1
    .catchall {:try_start_11 .. :try_end_11} :catchall_1

    move v8, v1

    move v1, v0

    move v0, v8

    .line 2105
    goto/16 :goto_1

    .line 2108
    :sswitch_a
    :try_start_12
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    or-int/lit8 v0, v0, 0x4

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    .line 2109
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->pkgName_:Ljava/lang/Object;

    move v0, v1

    move v1, v2

    .line 2110
    goto/16 :goto_1

    .line 2113
    :sswitch_b
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    or-int/lit8 v0, v0, 0x8

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    .line 2114
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->className_:Ljava/lang/Object;

    move v0, v1

    move v1, v2

    .line 2115
    goto/16 :goto_1

    .line 2118
    :sswitch_c
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    or-int/lit8 v0, v0, 0x10

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    .line 2119
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->methodName_:Ljava/lang/Object;

    move v0, v1

    move v1, v2

    .line 2120
    goto/16 :goto_1

    .line 2123
    :sswitch_d
    and-int/lit16 v0, v2, 0x200

    const/16 v3, 0x200

    if-eq v0, v3, :cond_14

    .line 2124
    new-instance v0, Lcom/google/protobuf/LazyStringArrayList;

    invoke-direct {v0}, Lcom/google/protobuf/LazyStringArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->types_:Lcom/google/protobuf/LazyStringList;
    :try_end_12
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_12 .. :try_end_12} :catch_3
    .catch Ljava/io/IOException; {:try_start_12 .. :try_end_12} :catch_2
    .catchall {:try_start_12 .. :try_end_12} :catchall_0

    .line 2125
    or-int/lit16 v0, v2, 0x200

    .line 2127
    :goto_c
    :try_start_13
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->types_:Lcom/google/protobuf/LazyStringList;

    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v3

    invoke-interface {v2, v3}, Lcom/google/protobuf/LazyStringList;->add(Lcom/google/protobuf/ByteString;)V
    :try_end_13
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_13 .. :try_end_13} :catch_0
    .catch Ljava/io/IOException; {:try_start_13 .. :try_end_13} :catch_1
    .catchall {:try_start_13 .. :try_end_13} :catchall_1

    move v8, v1

    move v1, v0

    move v0, v8

    .line 2128
    goto/16 :goto_1

    .line 2131
    :sswitch_e
    and-int/lit16 v0, v2, 0x400

    const/16 v3, 0x400

    if-eq v0, v3, :cond_13

    .line 2132
    :try_start_14
    new-instance v0, Lcom/google/protobuf/LazyStringArrayList;

    invoke-direct {v0}, Lcom/google/protobuf/LazyStringArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->params_:Lcom/google/protobuf/LazyStringList;
    :try_end_14
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_14 .. :try_end_14} :catch_3
    .catch Ljava/io/IOException; {:try_start_14 .. :try_end_14} :catch_2
    .catchall {:try_start_14 .. :try_end_14} :catchall_0

    .line 2133
    or-int/lit16 v0, v2, 0x400

    .line 2135
    :goto_d
    :try_start_15
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->params_:Lcom/google/protobuf/LazyStringList;

    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v3

    invoke-interface {v2, v3}, Lcom/google/protobuf/LazyStringList;->add(Lcom/google/protobuf/ByteString;)V
    :try_end_15
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_15 .. :try_end_15} :catch_0
    .catch Ljava/io/IOException; {:try_start_15 .. :try_end_15} :catch_1
    .catchall {:try_start_15 .. :try_end_15} :catchall_1

    move v8, v1

    move v1, v0

    move v0, v8

    .line 2136
    goto/16 :goto_1

    .line 2139
    :sswitch_f
    :try_start_16
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    or-int/lit8 v0, v0, 0x20

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    .line 2140
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBool()Z

    move-result v0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->isSyncCall_:Z

    move v0, v1

    move v1, v2

    .line 2141
    goto/16 :goto_1

    .line 2144
    :sswitch_10
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    or-int/lit8 v0, v0, 0x40

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    .line 2145
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readInt32()I

    move-result v0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->waitId_:I

    move v0, v1

    move v1, v2

    .line 2146
    goto/16 :goto_1

    .line 2149
    :sswitch_11
    const/4 v0, 0x0

    .line 2150
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    and-int/lit16 v3, v3, 0x80

    const/16 v5, 0x80

    if-ne v3, v5, :cond_12

    .line 2151
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->retValue_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v0

    move-object v3, v0

    .line 2153
    :goto_e
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->PARSER:Lcom/google/protobuf/Parser;

    invoke-virtual {p1, v0, p2}, Lcom/google/protobuf/CodedInputStream;->readMessage(Lcom/google/protobuf/Parser;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/MessageLite;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->retValue_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    .line 2154
    if-eqz v3, :cond_9

    .line 2155
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->retValue_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    invoke-virtual {v3, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    .line 2156
    invoke-virtual {v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->retValue_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    .line 2158
    :cond_9
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    or-int/lit16 v0, v0, 0x80

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    move v0, v1

    move v1, v2

    .line 2159
    goto/16 :goto_1

    .line 2162
    :sswitch_12
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    or-int/lit16 v0, v0, 0x100

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    .line 2163
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBool()Z

    move-result v0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->encrypt_:Z

    move v0, v1

    move v1, v2

    .line 2164
    goto/16 :goto_1

    .line 2167
    :sswitch_13
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    or-int/lit16 v0, v0, 0x200

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    .line 2168
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBool()Z

    move-result v0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->isDebug_:Z
    :try_end_16
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_16 .. :try_end_16} :catch_3
    .catch Ljava/io/IOException; {:try_start_16 .. :try_end_16} :catch_2
    .catchall {:try_start_16 .. :try_end_16} :catchall_0

    :cond_a
    move v0, v1

    move v1, v2

    goto/16 :goto_1

    .line 2179
    :cond_b
    and-int/lit8 v0, v2, 0x2

    const/4 v1, 0x2

    if-ne v0, v1, :cond_c

    .line 2180
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg1_:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg1_:Ljava/util/List;

    .line 2182
    :cond_c
    and-int/lit8 v0, v2, 0x4

    const/4 v1, 0x4

    if-ne v0, v1, :cond_d

    .line 2183
    new-instance v0, Lcom/google/protobuf/UnmodifiableLazyStringList;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg2_:Lcom/google/protobuf/LazyStringList;

    invoke-direct {v0, v1}, Lcom/google/protobuf/UnmodifiableLazyStringList;-><init>(Lcom/google/protobuf/LazyStringList;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg2_:Lcom/google/protobuf/LazyStringList;

    .line 2185
    :cond_d
    and-int/lit8 v0, v2, 0x8

    const/16 v1, 0x8

    if-ne v0, v1, :cond_e

    .line 2186
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg3_:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg3_:Ljava/util/List;

    .line 2188
    :cond_e
    and-int/lit8 v0, v2, 0x20

    const/16 v1, 0x20

    if-ne v0, v1, :cond_f

    .line 2189
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg4_:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg4_:Ljava/util/List;

    .line 2191
    :cond_f
    and-int/lit16 v0, v2, 0x200

    const/16 v1, 0x200

    if-ne v0, v1, :cond_10

    .line 2192
    new-instance v0, Lcom/google/protobuf/UnmodifiableLazyStringList;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->types_:Lcom/google/protobuf/LazyStringList;

    invoke-direct {v0, v1}, Lcom/google/protobuf/UnmodifiableLazyStringList;-><init>(Lcom/google/protobuf/LazyStringList;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->types_:Lcom/google/protobuf/LazyStringList;

    .line 2194
    :cond_10
    and-int/lit16 v0, v2, 0x400

    const/16 v1, 0x400

    if-ne v0, v1, :cond_11

    .line 2195
    new-instance v0, Lcom/google/protobuf/UnmodifiableLazyStringList;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->params_:Lcom/google/protobuf/LazyStringList;

    invoke-direct {v0, v1}, Lcom/google/protobuf/UnmodifiableLazyStringList;-><init>(Lcom/google/protobuf/LazyStringList;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->params_:Lcom/google/protobuf/LazyStringList;

    .line 2197
    :cond_11
    invoke-virtual {v4}, Lcom/google/protobuf/UnknownFieldSet$Builder;->build()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    .line 2198
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->makeExtensionsImmutable()V

    .line 2200
    return-void

    .line 2175
    :catch_2
    move-exception v0

    goto/16 :goto_9

    .line 2173
    :catch_3
    move-exception v0

    goto/16 :goto_4

    :cond_12
    move-object v3, v0

    goto/16 :goto_e

    :cond_13
    move v0, v2

    goto/16 :goto_d

    :cond_14
    move v0, v2

    goto/16 :goto_c

    :cond_15
    move v0, v2

    goto/16 :goto_b

    :cond_16
    move v0, v2

    goto/16 :goto_a

    :cond_17
    move v0, v2

    goto/16 :goto_8

    :cond_18
    move v0, v2

    goto/16 :goto_7

    :cond_19
    move v0, v2

    goto/16 :goto_6

    :cond_1a
    move v0, v2

    goto/16 :goto_3

    :cond_1b
    move v0, v2

    goto/16 :goto_2

    .line 2015
    nop

    :sswitch_data_0
    .sparse-switch
        0x0 -> :sswitch_0
        0x8 -> :sswitch_1
        0x10 -> :sswitch_2
        0x12 -> :sswitch_3
        0x1a -> :sswitch_4
        0x22 -> :sswitch_6
        0x25 -> :sswitch_5
        0x2a -> :sswitch_7
        0x30 -> :sswitch_8
        0x32 -> :sswitch_9
        0x3a -> :sswitch_a
        0x42 -> :sswitch_b
        0x4a -> :sswitch_c
        0x52 -> :sswitch_d
        0x5a -> :sswitch_e
        0x60 -> :sswitch_f
        0x68 -> :sswitch_10
        0x72 -> :sswitch_11
        0x78 -> :sswitch_12
        0x80 -> :sswitch_13
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
    .line 1978
    invoke-direct {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;-><init>(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)V

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

    .line 1983
    invoke-direct {p0, p1}, Lcom/google/protobuf/GeneratedMessage;-><init>(Lcom/google/protobuf/GeneratedMessage$Builder;)V

    .line 2673
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->memoizedIsInitialized:B

    .line 2736
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->memoizedSerializedSize:I

    .line 1984
    invoke-virtual {p1}, Lcom/google/protobuf/GeneratedMessage$Builder;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    .line 1985
    return-void
.end method

.method synthetic constructor <init>(Lcom/google/protobuf/GeneratedMessage$Builder;Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$1;)V
    .locals 0

    .prologue
    .line 1978
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;-><init>(Lcom/google/protobuf/GeneratedMessage$Builder;)V

    return-void
.end method

.method private constructor <init>(Z)V
    .locals 1

    .prologue
    const/4 v0, -0x1

    .line 1986
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage;-><init>()V

    .line 2673
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->memoizedIsInitialized:B

    .line 2736
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->memoizedSerializedSize:I

    .line 1986
    invoke-static {}, Lcom/google/protobuf/UnknownFieldSet;->getDefaultInstance()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    return-void
.end method

.method static synthetic access$3000()Z
    .locals 1

    .prologue
    .line 1978
    sget-boolean v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->alwaysUseFieldBuilders:Z

    return v0
.end method

.method static synthetic access$3202(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;I)I
    .locals 0

    .prologue
    .line 1978
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->cmd_:I

    return p1
.end method

.method static synthetic access$3300(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Ljava/util/List;
    .locals 1

    .prologue
    .line 1978
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg1_:Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$3302(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;Ljava/util/List;)Ljava/util/List;
    .locals 0

    .prologue
    .line 1978
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg1_:Ljava/util/List;

    return-object p1
.end method

.method static synthetic access$3400(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Lcom/google/protobuf/LazyStringList;
    .locals 1

    .prologue
    .line 1978
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg2_:Lcom/google/protobuf/LazyStringList;

    return-object v0
.end method

.method static synthetic access$3402(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;Lcom/google/protobuf/LazyStringList;)Lcom/google/protobuf/LazyStringList;
    .locals 0

    .prologue
    .line 1978
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg2_:Lcom/google/protobuf/LazyStringList;

    return-object p1
.end method

.method static synthetic access$3500(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Ljava/util/List;
    .locals 1

    .prologue
    .line 1978
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg3_:Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$3502(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;Ljava/util/List;)Ljava/util/List;
    .locals 0

    .prologue
    .line 1978
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg3_:Ljava/util/List;

    return-object p1
.end method

.method static synthetic access$3602(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;Lcom/google/protobuf/ByteString;)Lcom/google/protobuf/ByteString;
    .locals 0

    .prologue
    .line 1978
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->fileData_:Lcom/google/protobuf/ByteString;

    return-object p1
.end method

.method static synthetic access$3700(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Ljava/util/List;
    .locals 1

    .prologue
    .line 1978
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg4_:Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$3702(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;Ljava/util/List;)Ljava/util/List;
    .locals 0

    .prologue
    .line 1978
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg4_:Ljava/util/List;

    return-object p1
.end method

.method static synthetic access$3800(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 1978
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->pkgName_:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$3802(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .prologue
    .line 1978
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->pkgName_:Ljava/lang/Object;

    return-object p1
.end method

.method static synthetic access$3900(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 1978
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->className_:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$3902(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .prologue
    .line 1978
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->className_:Ljava/lang/Object;

    return-object p1
.end method

.method static synthetic access$4000(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 1978
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->methodName_:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$4002(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .prologue
    .line 1978
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->methodName_:Ljava/lang/Object;

    return-object p1
.end method

.method static synthetic access$4100(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Lcom/google/protobuf/LazyStringList;
    .locals 1

    .prologue
    .line 1978
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->types_:Lcom/google/protobuf/LazyStringList;

    return-object v0
.end method

.method static synthetic access$4102(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;Lcom/google/protobuf/LazyStringList;)Lcom/google/protobuf/LazyStringList;
    .locals 0

    .prologue
    .line 1978
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->types_:Lcom/google/protobuf/LazyStringList;

    return-object p1
.end method

.method static synthetic access$4200(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Lcom/google/protobuf/LazyStringList;
    .locals 1

    .prologue
    .line 1978
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->params_:Lcom/google/protobuf/LazyStringList;

    return-object v0
.end method

.method static synthetic access$4202(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;Lcom/google/protobuf/LazyStringList;)Lcom/google/protobuf/LazyStringList;
    .locals 0

    .prologue
    .line 1978
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->params_:Lcom/google/protobuf/LazyStringList;

    return-object p1
.end method

.method static synthetic access$4302(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;Z)Z
    .locals 0

    .prologue
    .line 1978
    iput-boolean p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->isSyncCall_:Z

    return p1
.end method

.method static synthetic access$4402(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;I)I
    .locals 0

    .prologue
    .line 1978
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->waitId_:I

    return p1
.end method

.method static synthetic access$4502(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;
    .locals 0

    .prologue
    .line 1978
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->retValue_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    return-object p1
.end method

.method static synthetic access$4602(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;Z)Z
    .locals 0

    .prologue
    .line 1978
    iput-boolean p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->encrypt_:Z

    return p1
.end method

.method static synthetic access$4702(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;Z)Z
    .locals 0

    .prologue
    .line 1978
    iput-boolean p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->isDebug_:Z

    return p1
.end method

.method static synthetic access$4802(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;I)I
    .locals 0

    .prologue
    .line 1978
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    return p1
.end method

.method public static getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;
    .locals 1

    .prologue
    .line 1990
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    return-object v0
.end method

.method public static final getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 2203
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->access$2500()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method private initFields()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 2656
    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->cmd_:I

    .line 2657
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg1_:Ljava/util/List;

    .line 2658
    sget-object v0, Lcom/google/protobuf/LazyStringArrayList;->EMPTY:Lcom/google/protobuf/LazyStringList;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg2_:Lcom/google/protobuf/LazyStringList;

    .line 2659
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg3_:Ljava/util/List;

    .line 2660
    sget-object v0, Lcom/google/protobuf/ByteString;->EMPTY:Lcom/google/protobuf/ByteString;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->fileData_:Lcom/google/protobuf/ByteString;

    .line 2661
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg4_:Ljava/util/List;

    .line 2662
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->pkgName_:Ljava/lang/Object;

    .line 2663
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->className_:Ljava/lang/Object;

    .line 2664
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->methodName_:Ljava/lang/Object;

    .line 2665
    sget-object v0, Lcom/google/protobuf/LazyStringArrayList;->EMPTY:Lcom/google/protobuf/LazyStringList;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->types_:Lcom/google/protobuf/LazyStringList;

    .line 2666
    sget-object v0, Lcom/google/protobuf/LazyStringArrayList;->EMPTY:Lcom/google/protobuf/LazyStringList;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->params_:Lcom/google/protobuf/LazyStringList;

    .line 2667
    iput-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->isSyncCall_:Z

    .line 2668
    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->waitId_:I

    .line 2669
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->retValue_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    .line 2670
    iput-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->encrypt_:Z

    .line 2671
    iput-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->isDebug_:Z

    .line 2672
    return-void
.end method

.method public static newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 2898
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->access$2800()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static newBuilder(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 2901
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static parseDelimitedFrom(Ljava/io/InputStream;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 2878
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseDelimitedFrom(Ljava/io/InputStream;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    return-object v0
.end method

.method public static parseDelimitedFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 2884
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseDelimitedFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 2848
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/ByteString;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/ByteString;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 2854
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/ByteString;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/CodedInputStream;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 2889
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/CodedInputStream;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 2895
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    return-object v0
.end method

.method public static parseFrom(Ljava/io/InputStream;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 2868
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom(Ljava/io/InputStream;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    return-object v0
.end method

.method public static parseFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 2874
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    return-object v0
.end method

.method public static parseFrom([B)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 2858
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom([B)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    return-object v0
.end method

.method public static parseFrom([BLcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 2864
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom([BLcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    return-object v0
.end method


# virtual methods
.method public getArg1(I)I
    .locals 1

    .prologue
    .line 2265
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg1_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    return v0
.end method

.method public getArg1Count()I
    .locals 1

    .prologue
    .line 2259
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg1_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public getArg1List()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    .prologue
    .line 2253
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg1_:Ljava/util/List;

    return-object v0
.end method

.method public getArg2(I)Ljava/lang/String;
    .locals 1

    .prologue
    .line 2288
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg2_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0, p1}, Lcom/google/protobuf/LazyStringList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method public getArg2Bytes(I)Lcom/google/protobuf/ByteString;
    .locals 1

    .prologue
    .line 2295
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg2_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0, p1}, Lcom/google/protobuf/LazyStringList;->getByteString(I)Lcom/google/protobuf/ByteString;

    move-result-object v0

    return-object v0
.end method

.method public getArg2Count()I
    .locals 1

    .prologue
    .line 2282
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg2_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0}, Lcom/google/protobuf/LazyStringList;->size()I

    move-result v0

    return v0
.end method

.method public getArg2List()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 2276
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg2_:Lcom/google/protobuf/LazyStringList;

    return-object v0
.end method

.method public getArg3(I)F
    .locals 1

    .prologue
    .line 2318
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg3_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Float;

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v0

    return v0
.end method

.method public getArg3Count()I
    .locals 1

    .prologue
    .line 2312
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg3_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public getArg3List()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Ljava/lang/Float;",
            ">;"
        }
    .end annotation

    .prologue
    .line 2306
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg3_:Ljava/util/List;

    return-object v0
.end method

.method public getArg4(I)J
    .locals 2

    .prologue
    .line 2357
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg4_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    return-wide v0
.end method

.method public getArg4Count()I
    .locals 1

    .prologue
    .line 2351
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg4_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public getArg4List()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Ljava/lang/Long;",
            ">;"
        }
    .end annotation

    .prologue
    .line 2345
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg4_:Ljava/util/List;

    return-object v0
.end method

.method public getClassName()Ljava/lang/String;
    .locals 2

    .prologue
    .line 2428
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->className_:Ljava/lang/Object;

    .line 2429
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 2430
    check-cast v0, Ljava/lang/String;

    .line 2438
    :goto_0
    return-object v0

    .line 2432
    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 2434
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v1

    .line 2435
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->isValidUtf8()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 2436
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->className_:Ljava/lang/Object;

    :cond_1
    move-object v0, v1

    .line 2438
    goto :goto_0
.end method

.method public getClassNameBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 2446
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->className_:Ljava/lang/Object;

    .line 2447
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 2448
    check-cast v0, Ljava/lang/String;

    .line 2449
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 2451
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->className_:Ljava/lang/Object;

    .line 2454
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public getCmd()I
    .locals 1

    .prologue
    .line 2242
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->cmd_:I

    return v0
.end method

.method public getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;
    .locals 1

    .prologue
    .line 1994
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 1978
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 1978
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    return-object v0
.end method

.method public getEncrypt()Z
    .locals 1

    .prologue
    .line 2636
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->encrypt_:Z

    return v0
.end method

.method public getFileData()Lcom/google/protobuf/ByteString;
    .locals 1

    .prologue
    .line 2334
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->fileData_:Lcom/google/protobuf/ByteString;

    return-object v0
.end method

.method public getIsDebug()Z
    .locals 1

    .prologue
    .line 2652
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->isDebug_:Z

    return v0
.end method

.method public getIsSyncCall()Z
    .locals 1

    .prologue
    .line 2574
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->isSyncCall_:Z

    return v0
.end method

.method public getMethodName()Ljava/lang/String;
    .locals 2

    .prologue
    .line 2471
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->methodName_:Ljava/lang/Object;

    .line 2472
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 2473
    check-cast v0, Ljava/lang/String;

    .line 2481
    :goto_0
    return-object v0

    .line 2475
    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 2477
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v1

    .line 2478
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->isValidUtf8()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 2479
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->methodName_:Ljava/lang/Object;

    :cond_1
    move-object v0, v1

    .line 2481
    goto :goto_0
.end method

.method public getMethodNameBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 2489
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->methodName_:Ljava/lang/Object;

    .line 2490
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 2491
    check-cast v0, Ljava/lang/String;

    .line 2492
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 2494
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->methodName_:Ljava/lang/Object;

    .line 2497
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public getParams(I)Ljava/lang/String;
    .locals 1

    .prologue
    .line 2551
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->params_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0, p1}, Lcom/google/protobuf/LazyStringList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method public getParamsBytes(I)Lcom/google/protobuf/ByteString;
    .locals 1

    .prologue
    .line 2558
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->params_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0, p1}, Lcom/google/protobuf/LazyStringList;->getByteString(I)Lcom/google/protobuf/ByteString;

    move-result-object v0

    return-object v0
.end method

.method public getParamsCount()I
    .locals 1

    .prologue
    .line 2545
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->params_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0}, Lcom/google/protobuf/LazyStringList;->size()I

    move-result v0

    return v0
.end method

.method public getParamsList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 2539
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->params_:Lcom/google/protobuf/LazyStringList;

    return-object v0
.end method

.method public getParserForType()Lcom/google/protobuf/Parser;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/protobuf/Parser",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;",
            ">;"
        }
    .end annotation

    .prologue
    .line 2225
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->PARSER:Lcom/google/protobuf/Parser;

    return-object v0
.end method

.method public getPkgName()Ljava/lang/String;
    .locals 2

    .prologue
    .line 2381
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->pkgName_:Ljava/lang/Object;

    .line 2382
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 2383
    check-cast v0, Ljava/lang/String;

    .line 2391
    :goto_0
    return-object v0

    .line 2385
    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 2387
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v1

    .line 2388
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->isValidUtf8()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 2389
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->pkgName_:Ljava/lang/Object;

    :cond_1
    move-object v0, v1

    .line 2391
    goto :goto_0
.end method

.method public getPkgNameBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 2403
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->pkgName_:Ljava/lang/Object;

    .line 2404
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 2405
    check-cast v0, Ljava/lang/String;

    .line 2406
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 2408
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->pkgName_:Ljava/lang/Object;

    .line 2411
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public getRetValue()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;
    .locals 1

    .prologue
    .line 2606
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->retValue_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    return-object v0
.end method

.method public getRetValueOrBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValueOrBuilder;
    .locals 1

    .prologue
    .line 2612
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->retValue_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    return-object v0
.end method

.method public getSerializedSize()I
    .locals 9

    .prologue
    const/16 v8, 0x10

    const/16 v5, 0x8

    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 2738
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->memoizedSerializedSize:I

    .line 2739
    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    .line 2835
    :goto_0
    return v0

    .line 2742
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    and-int/lit8 v0, v0, 0x1

    if-ne v0, v3, :cond_f

    .line 2743
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->cmd_:I

    .line 2744
    invoke-static {v3, v0}, Lcom/google/protobuf/CodedOutputStream;->computeInt32Size(II)I

    move-result v0

    add-int/2addr v0, v2

    move v1, v0

    :goto_1
    move v3, v2

    move v4, v2

    .line 2748
    :goto_2
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg1_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v3, v0, :cond_1

    .line 2749
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg1_:Ljava/util/List;

    .line 2750
    invoke-interface {v0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-static {v0}, Lcom/google/protobuf/CodedOutputStream;->computeInt32SizeNoTag(I)I

    move-result v0

    add-int/2addr v4, v0

    .line 2748
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    goto :goto_2

    .line 2752
    :cond_1
    add-int v0, v1, v4

    .line 2753
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg1List()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    mul-int/lit8 v1, v1, 0x1

    add-int v3, v0, v1

    move v0, v2

    move v1, v2

    .line 2757
    :goto_3
    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg2_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v4}, Lcom/google/protobuf/LazyStringList;->size()I

    move-result v4

    if-ge v0, v4, :cond_2

    .line 2758
    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg2_:Lcom/google/protobuf/LazyStringList;

    .line 2759
    invoke-interface {v4, v0}, Lcom/google/protobuf/LazyStringList;->getByteString(I)Lcom/google/protobuf/ByteString;

    move-result-object v4

    invoke-static {v4}, Lcom/google/protobuf/CodedOutputStream;->computeBytesSizeNoTag(Lcom/google/protobuf/ByteString;)I

    move-result v4

    add-int/2addr v1, v4

    .line 2757
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 2761
    :cond_2
    add-int v0, v3, v1

    .line 2762
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg2List()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    mul-int/lit8 v1, v1, 0x1

    add-int/2addr v0, v1

    .line 2766
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg3List()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    mul-int/lit8 v1, v1, 0x4

    .line 2767
    add-int/2addr v0, v1

    .line 2768
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg3List()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    mul-int/lit8 v1, v1, 0x1

    add-int/2addr v0, v1

    .line 2770
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    and-int/lit8 v1, v1, 0x2

    const/4 v3, 0x2

    if-ne v1, v3, :cond_e

    .line 2771
    const/4 v1, 0x5

    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->fileData_:Lcom/google/protobuf/ByteString;

    .line 2772
    invoke-static {v1, v3}, Lcom/google/protobuf/CodedOutputStream;->computeBytesSize(ILcom/google/protobuf/ByteString;)I

    move-result v1

    add-int/2addr v0, v1

    move v1, v0

    :goto_4
    move v3, v2

    move v4, v2

    .line 2776
    :goto_5
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg4_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v3, v0, :cond_3

    .line 2777
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg4_:Ljava/util/List;

    .line 2778
    invoke-interface {v0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v6

    invoke-static {v6, v7}, Lcom/google/protobuf/CodedOutputStream;->computeInt64SizeNoTag(J)I

    move-result v0

    add-int/2addr v4, v0

    .line 2776
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    goto :goto_5

    .line 2780
    :cond_3
    add-int v0, v1, v4

    .line 2781
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getArg4List()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    mul-int/lit8 v1, v1, 0x1

    add-int/2addr v0, v1

    .line 2783
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    and-int/lit8 v1, v1, 0x4

    const/4 v3, 0x4

    if-ne v1, v3, :cond_4

    .line 2784
    const/4 v1, 0x7

    .line 2785
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getPkgNameBytes()Lcom/google/protobuf/ByteString;

    move-result-object v3

    invoke-static {v1, v3}, Lcom/google/protobuf/CodedOutputStream;->computeBytesSize(ILcom/google/protobuf/ByteString;)I

    move-result v1

    add-int/2addr v0, v1

    .line 2787
    :cond_4
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    and-int/lit8 v1, v1, 0x8

    if-ne v1, v5, :cond_5

    .line 2789
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getClassNameBytes()Lcom/google/protobuf/ByteString;

    move-result-object v1

    invoke-static {v5, v1}, Lcom/google/protobuf/CodedOutputStream;->computeBytesSize(ILcom/google/protobuf/ByteString;)I

    move-result v1

    add-int/2addr v0, v1

    .line 2791
    :cond_5
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    and-int/lit8 v1, v1, 0x10

    if-ne v1, v8, :cond_6

    .line 2792
    const/16 v1, 0x9

    .line 2793
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getMethodNameBytes()Lcom/google/protobuf/ByteString;

    move-result-object v3

    invoke-static {v1, v3}, Lcom/google/protobuf/CodedOutputStream;->computeBytesSize(ILcom/google/protobuf/ByteString;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_6
    move v1, v2

    move v3, v2

    .line 2797
    :goto_6
    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->types_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v4}, Lcom/google/protobuf/LazyStringList;->size()I

    move-result v4

    if-ge v1, v4, :cond_7

    .line 2798
    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->types_:Lcom/google/protobuf/LazyStringList;

    .line 2799
    invoke-interface {v4, v1}, Lcom/google/protobuf/LazyStringList;->getByteString(I)Lcom/google/protobuf/ByteString;

    move-result-object v4

    invoke-static {v4}, Lcom/google/protobuf/CodedOutputStream;->computeBytesSizeNoTag(Lcom/google/protobuf/ByteString;)I

    move-result v4

    add-int/2addr v3, v4

    .line 2797
    add-int/lit8 v1, v1, 0x1

    goto :goto_6

    .line 2801
    :cond_7
    add-int/2addr v0, v3

    .line 2802
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getTypesList()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    mul-int/lit8 v1, v1, 0x1

    add-int/2addr v1, v0

    move v0, v2

    .line 2806
    :goto_7
    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->params_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v3}, Lcom/google/protobuf/LazyStringList;->size()I

    move-result v3

    if-ge v2, v3, :cond_8

    .line 2807
    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->params_:Lcom/google/protobuf/LazyStringList;

    .line 2808
    invoke-interface {v3, v2}, Lcom/google/protobuf/LazyStringList;->getByteString(I)Lcom/google/protobuf/ByteString;

    move-result-object v3

    invoke-static {v3}, Lcom/google/protobuf/CodedOutputStream;->computeBytesSizeNoTag(Lcom/google/protobuf/ByteString;)I

    move-result v3

    add-int/2addr v0, v3

    .line 2806
    add-int/lit8 v2, v2, 0x1

    goto :goto_7

    .line 2810
    :cond_8
    add-int/2addr v0, v1

    .line 2811
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getParamsList()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    mul-int/lit8 v1, v1, 0x1

    add-int/2addr v0, v1

    .line 2813
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    and-int/lit8 v1, v1, 0x20

    const/16 v2, 0x20

    if-ne v1, v2, :cond_9

    .line 2814
    const/16 v1, 0xc

    iget-boolean v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->isSyncCall_:Z

    .line 2815
    invoke-static {v1, v2}, Lcom/google/protobuf/CodedOutputStream;->computeBoolSize(IZ)I

    move-result v1

    add-int/2addr v0, v1

    .line 2817
    :cond_9
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    and-int/lit8 v1, v1, 0x40

    const/16 v2, 0x40

    if-ne v1, v2, :cond_a

    .line 2818
    const/16 v1, 0xd

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->waitId_:I

    .line 2819
    invoke-static {v1, v2}, Lcom/google/protobuf/CodedOutputStream;->computeInt32Size(II)I

    move-result v1

    add-int/2addr v0, v1

    .line 2821
    :cond_a
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    and-int/lit16 v1, v1, 0x80

    const/16 v2, 0x80

    if-ne v1, v2, :cond_b

    .line 2822
    const/16 v1, 0xe

    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->retValue_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    .line 2823
    invoke-static {v1, v2}, Lcom/google/protobuf/CodedOutputStream;->computeMessageSize(ILcom/google/protobuf/MessageLite;)I

    move-result v1

    add-int/2addr v0, v1

    .line 2825
    :cond_b
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    and-int/lit16 v1, v1, 0x100

    const/16 v2, 0x100

    if-ne v1, v2, :cond_c

    .line 2826
    const/16 v1, 0xf

    iget-boolean v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->encrypt_:Z

    .line 2827
    invoke-static {v1, v2}, Lcom/google/protobuf/CodedOutputStream;->computeBoolSize(IZ)I

    move-result v1

    add-int/2addr v0, v1

    .line 2829
    :cond_c
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    and-int/lit16 v1, v1, 0x200

    const/16 v2, 0x200

    if-ne v1, v2, :cond_d

    .line 2830
    iget-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->isDebug_:Z

    .line 2831
    invoke-static {v8, v1}, Lcom/google/protobuf/CodedOutputStream;->computeBoolSize(IZ)I

    move-result v1

    add-int/2addr v0, v1

    .line 2833
    :cond_d
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/protobuf/UnknownFieldSet;->getSerializedSize()I

    move-result v1

    add-int/2addr v0, v1

    .line 2834
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->memoizedSerializedSize:I

    goto/16 :goto_0

    :cond_e
    move v1, v0

    goto/16 :goto_4

    :cond_f
    move v1, v2

    goto/16 :goto_1
.end method

.method public getTypes(I)Ljava/lang/String;
    .locals 1

    .prologue
    .line 2521
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->types_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0, p1}, Lcom/google/protobuf/LazyStringList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method public getTypesBytes(I)Lcom/google/protobuf/ByteString;
    .locals 1

    .prologue
    .line 2528
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->types_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0, p1}, Lcom/google/protobuf/LazyStringList;->getByteString(I)Lcom/google/protobuf/ByteString;

    move-result-object v0

    return-object v0
.end method

.method public getTypesCount()I
    .locals 1

    .prologue
    .line 2515
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->types_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0}, Lcom/google/protobuf/LazyStringList;->size()I

    move-result v0

    return v0
.end method

.method public getTypesList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 2509
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->types_:Lcom/google/protobuf/LazyStringList;

    return-object v0
.end method

.method public final getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;
    .locals 1

    .prologue
    .line 2001
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    return-object v0
.end method

.method public getWaitId()I
    .locals 1

    .prologue
    .line 2590
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->waitId_:I

    return v0
.end method

.method public hasClassName()Z
    .locals 2

    .prologue
    .line 2422
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

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

.method public hasCmd()Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 2236
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    and-int/lit8 v1, v1, 0x1

    if-ne v1, v0, :cond_0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasEncrypt()Z
    .locals 2

    .prologue
    .line 2626
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    and-int/lit16 v0, v0, 0x100

    const/16 v1, 0x100

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasFileData()Z
    .locals 2

    .prologue
    .line 2328
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

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

.method public hasIsDebug()Z
    .locals 2

    .prologue
    .line 2646
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    and-int/lit16 v0, v0, 0x200

    const/16 v1, 0x200

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasIsSyncCall()Z
    .locals 2

    .prologue
    .line 2568
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

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

.method public hasMethodName()Z
    .locals 2

    .prologue
    .line 2465
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

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

.method public hasPkgName()Z
    .locals 2

    .prologue
    .line 2371
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

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

.method public hasRetValue()Z
    .locals 2

    .prologue
    .line 2600
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    and-int/lit16 v0, v0, 0x80

    const/16 v1, 0x80

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasWaitId()Z
    .locals 2

    .prologue
    .line 2584
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

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
    .line 2208
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->access$2600()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    const-class v1, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    const-class v2, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    .line 2209
    invoke-virtual {v0, v1, v2}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;->ensureFieldAccessorsInitialized(Ljava/lang/Class;Ljava/lang/Class;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    .line 2208
    return-object v0
.end method

.method public final isInitialized()Z
    .locals 3

    .prologue
    const/4 v0, 0x1

    .line 2675
    iget-byte v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->memoizedIsInitialized:B

    .line 2676
    const/4 v2, -0x1

    if-eq v1, v2, :cond_1

    if-ne v1, v0, :cond_0

    .line 2679
    :goto_0
    return v0

    .line 2676
    :cond_0
    const/4 v0, 0x0

    goto :goto_0

    .line 2678
    :cond_1
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->memoizedIsInitialized:B

    goto :goto_0
.end method

.method public newBuilderForType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 2899
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 2

    .prologue
    .line 2908
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    const/4 v1, 0x0

    invoke-direct {v0, p1, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$1;)V

    .line 2909
    return-object v0
.end method

.method public bridge synthetic newBuilderForType()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1978
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilderForType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected bridge synthetic newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1978
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic newBuilderForType()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 1978
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilderForType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    return-object v0
.end method

.method public toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 2903
    invoke-static {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic toBuilder()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1978
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic toBuilder()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 1978
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

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
    .line 2842
    invoke-super {p0}, Lcom/google/protobuf/GeneratedMessage;->writeReplace()Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public writeTo(Lcom/google/protobuf/CodedOutputStream;)V
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/16 v7, 0x8

    const/4 v6, 0x4

    const/4 v4, 0x2

    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 2684
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getSerializedSize()I

    .line 2685
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    and-int/lit8 v0, v0, 0x1

    if-ne v0, v1, :cond_0

    .line 2686
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->cmd_:I

    invoke-virtual {p1, v1, v0}, Lcom/google/protobuf/CodedOutputStream;->writeInt32(II)V

    :cond_0
    move v1, v2

    .line 2688
    :goto_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg1_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_1

    .line 2689
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg1_:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-virtual {p1, v4, v0}, Lcom/google/protobuf/CodedOutputStream;->writeInt32(II)V

    .line 2688
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    :cond_1
    move v0, v2

    .line 2691
    :goto_1
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg2_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v1}, Lcom/google/protobuf/LazyStringList;->size()I

    move-result v1

    if-ge v0, v1, :cond_2

    .line 2692
    const/4 v1, 0x3

    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg2_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v3, v0}, Lcom/google/protobuf/LazyStringList;->getByteString(I)Lcom/google/protobuf/ByteString;

    move-result-object v3

    invoke-virtual {p1, v1, v3}, Lcom/google/protobuf/CodedOutputStream;->writeBytes(ILcom/google/protobuf/ByteString;)V

    .line 2691
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_2
    move v1, v2

    .line 2694
    :goto_2
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg3_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_3

    .line 2695
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg3_:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Float;

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v0

    invoke-virtual {p1, v6, v0}, Lcom/google/protobuf/CodedOutputStream;->writeFloat(IF)V

    .line 2694
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_2

    .line 2697
    :cond_3
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    and-int/lit8 v0, v0, 0x2

    if-ne v0, v4, :cond_4

    .line 2698
    const/4 v0, 0x5

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->fileData_:Lcom/google/protobuf/ByteString;

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeBytes(ILcom/google/protobuf/ByteString;)V

    :cond_4
    move v1, v2

    .line 2700
    :goto_3
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg4_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_5

    .line 2701
    const/4 v3, 0x6

    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->arg4_:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v4

    invoke-virtual {p1, v3, v4, v5}, Lcom/google/protobuf/CodedOutputStream;->writeInt64(IJ)V

    .line 2700
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_3

    .line 2703
    :cond_5
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    and-int/lit8 v0, v0, 0x4

    if-ne v0, v6, :cond_6

    .line 2704
    const/4 v0, 0x7

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getPkgNameBytes()Lcom/google/protobuf/ByteString;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeBytes(ILcom/google/protobuf/ByteString;)V

    .line 2706
    :cond_6
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    and-int/lit8 v0, v0, 0x8

    if-ne v0, v7, :cond_7

    .line 2707
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getClassNameBytes()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-virtual {p1, v7, v0}, Lcom/google/protobuf/CodedOutputStream;->writeBytes(ILcom/google/protobuf/ByteString;)V

    .line 2709
    :cond_7
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    and-int/lit8 v0, v0, 0x10

    const/16 v1, 0x10

    if-ne v0, v1, :cond_8

    .line 2710
    const/16 v0, 0x9

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getMethodNameBytes()Lcom/google/protobuf/ByteString;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeBytes(ILcom/google/protobuf/ByteString;)V

    :cond_8
    move v0, v2

    .line 2712
    :goto_4
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->types_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v1}, Lcom/google/protobuf/LazyStringList;->size()I

    move-result v1

    if-ge v0, v1, :cond_9

    .line 2713
    const/16 v1, 0xa

    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->types_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v3, v0}, Lcom/google/protobuf/LazyStringList;->getByteString(I)Lcom/google/protobuf/ByteString;

    move-result-object v3

    invoke-virtual {p1, v1, v3}, Lcom/google/protobuf/CodedOutputStream;->writeBytes(ILcom/google/protobuf/ByteString;)V

    .line 2712
    add-int/lit8 v0, v0, 0x1

    goto :goto_4

    .line 2715
    :cond_9
    :goto_5
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->params_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0}, Lcom/google/protobuf/LazyStringList;->size()I

    move-result v0

    if-ge v2, v0, :cond_a

    .line 2716
    const/16 v0, 0xb

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->params_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v1, v2}, Lcom/google/protobuf/LazyStringList;->getByteString(I)Lcom/google/protobuf/ByteString;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeBytes(ILcom/google/protobuf/ByteString;)V

    .line 2715
    add-int/lit8 v2, v2, 0x1

    goto :goto_5

    .line 2718
    :cond_a
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    and-int/lit8 v0, v0, 0x20

    const/16 v1, 0x20

    if-ne v0, v1, :cond_b

    .line 2719
    const/16 v0, 0xc

    iget-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->isSyncCall_:Z

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeBool(IZ)V

    .line 2721
    :cond_b
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    and-int/lit8 v0, v0, 0x40

    const/16 v1, 0x40

    if-ne v0, v1, :cond_c

    .line 2722
    const/16 v0, 0xd

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->waitId_:I

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeInt32(II)V

    .line 2724
    :cond_c
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    and-int/lit16 v0, v0, 0x80

    const/16 v1, 0x80

    if-ne v0, v1, :cond_d

    .line 2725
    const/16 v0, 0xe

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->retValue_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeMessage(ILcom/google/protobuf/MessageLite;)V

    .line 2727
    :cond_d
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    and-int/lit16 v0, v0, 0x100

    const/16 v1, 0x100

    if-ne v0, v1, :cond_e

    .line 2728
    const/16 v0, 0xf

    iget-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->encrypt_:Z

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeBool(IZ)V

    .line 2730
    :cond_e
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->bitField0_:I

    and-int/lit16 v0, v0, 0x200

    const/16 v1, 0x200

    if-ne v0, v1, :cond_f

    .line 2731
    const/16 v0, 0x10

    iget-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->isDebug_:Z

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeBool(IZ)V

    .line 2733
    :cond_f
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/google/protobuf/UnknownFieldSet;->writeTo(Lcom/google/protobuf/CodedOutputStream;)V

    .line 2734
    return-void
.end method
