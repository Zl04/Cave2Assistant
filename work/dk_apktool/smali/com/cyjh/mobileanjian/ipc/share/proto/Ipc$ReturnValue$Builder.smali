.class public final Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;
.super Lcom/google/protobuf/GeneratedMessage$Builder;
.source "SourceFile"

# interfaces
.implements Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValueOrBuilder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/protobuf/GeneratedMessage$Builder",
        "<",
        "Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;",
        ">;",
        "Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValueOrBuilder;"
    }
.end annotation


# instance fields
.field private bitField0_:I

.field private type_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

.field private valBoolean_:Z

.field private valDouble_:D

.field private valFloat_:F

.field private valInt_:I

.field private valLong_:J

.field private valString_:Ljava/lang/Object;


# direct methods
.method private constructor <init>()V
    .locals 1

    .prologue
    .line 1290
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage$Builder;-><init>()V

    .line 1446
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->VOID:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->type_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    .line 1647
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valString_:Ljava/lang/Object;

    .line 1291
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->maybeForceBuilderInitialization()V

    .line 1292
    return-void
.end method

.method private constructor <init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V
    .locals 1

    .prologue
    .line 1296
    invoke-direct {p0, p1}, Lcom/google/protobuf/GeneratedMessage$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V

    .line 1446
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->VOID:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->type_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    .line 1647
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valString_:Ljava/lang/Object;

    .line 1297
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->maybeForceBuilderInitialization()V

    .line 1298
    return-void
.end method

.method synthetic constructor <init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$1;)V
    .locals 0

    .prologue
    .line 1274
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V

    return-void
.end method

.method static synthetic access$1300()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;
    .locals 1

    .prologue
    .line 1274
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->create()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v0

    return-object v0
.end method

.method private static create()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;
    .locals 1

    .prologue
    .line 1304
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;-><init>()V

    return-object v0
.end method

.method public static final getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 1279
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->access$1000()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method private maybeForceBuilderInitialization()V
    .locals 1

    .prologue
    .line 1300
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->access$1500()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1302
    :cond_0
    return-void
.end method


# virtual methods
.method public build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;
    .locals 2

    .prologue
    .line 1340
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    move-result-object v0

    .line 1341
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->isInitialized()Z

    move-result v1

    if-nez v1, :cond_0

    .line 1342
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->newUninitializedMessageException(Lcom/google/protobuf/Message;)Lcom/google/protobuf/UninitializedMessageException;

    move-result-object v0

    throw v0

    .line 1344
    :cond_0
    return-object v0
.end method

.method public bridge synthetic build()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 1274
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic build()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 1274
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    move-result-object v0

    return-object v0
.end method

.method public buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;
    .locals 6

    .prologue
    const/4 v0, 0x1

    .line 1348
    new-instance v2, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    const/4 v1, 0x0

    invoke-direct {v2, p0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;-><init>(Lcom/google/protobuf/GeneratedMessage$Builder;Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$1;)V

    .line 1349
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    .line 1350
    const/4 v1, 0x0

    .line 1351
    and-int/lit8 v4, v3, 0x1

    if-ne v4, v0, :cond_6

    .line 1354
    :goto_0
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->type_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->access$1702(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    .line 1355
    and-int/lit8 v1, v3, 0x2

    const/4 v4, 0x2

    if-ne v1, v4, :cond_0

    .line 1356
    or-int/lit8 v0, v0, 0x2

    .line 1358
    :cond_0
    iget-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valBoolean_:Z

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->access$1802(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;Z)Z

    .line 1359
    and-int/lit8 v1, v3, 0x4

    const/4 v4, 0x4

    if-ne v1, v4, :cond_1

    .line 1360
    or-int/lit8 v0, v0, 0x4

    .line 1362
    :cond_1
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valInt_:I

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->access$1902(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;I)I

    .line 1363
    and-int/lit8 v1, v3, 0x8

    const/16 v4, 0x8

    if-ne v1, v4, :cond_2

    .line 1364
    or-int/lit8 v0, v0, 0x8

    .line 1366
    :cond_2
    iget-wide v4, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valLong_:J

    invoke-static {v2, v4, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->access$2002(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;J)J

    .line 1367
    and-int/lit8 v1, v3, 0x10

    const/16 v4, 0x10

    if-ne v1, v4, :cond_3

    .line 1368
    or-int/lit8 v0, v0, 0x10

    .line 1370
    :cond_3
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valFloat_:F

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->access$2102(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;F)F

    .line 1371
    and-int/lit8 v1, v3, 0x20

    const/16 v4, 0x20

    if-ne v1, v4, :cond_4

    .line 1372
    or-int/lit8 v0, v0, 0x20

    .line 1374
    :cond_4
    iget-wide v4, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valDouble_:D

    invoke-static {v2, v4, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->access$2202(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;D)D

    .line 1375
    and-int/lit8 v1, v3, 0x40

    const/16 v3, 0x40

    if-ne v1, v3, :cond_5

    .line 1376
    or-int/lit8 v0, v0, 0x40

    .line 1378
    :cond_5
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valString_:Ljava/lang/Object;

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->access$2302(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1379
    invoke-static {v2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->access$2402(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;I)I

    .line 1380
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->onBuilt()V

    .line 1381
    return-object v2

    :cond_6
    move v0, v1

    goto :goto_0
.end method

.method public bridge synthetic buildPartial()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 1274
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic buildPartial()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 1274
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    move-result-object v0

    return-object v0
.end method

.method public clear()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 1308
    invoke-super {p0}, Lcom/google/protobuf/GeneratedMessage$Builder;->clear()Lcom/google/protobuf/GeneratedMessage$Builder;

    .line 1309
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->VOID:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->type_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    .line 1310
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    .line 1311
    iput-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valBoolean_:Z

    .line 1312
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x3

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    .line 1313
    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valInt_:I

    .line 1314
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x5

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    .line 1315
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valLong_:J

    .line 1316
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x9

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    .line 1317
    const/4 v0, 0x0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valFloat_:F

    .line 1318
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x11

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    .line 1319
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valDouble_:D

    .line 1320
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x21

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    .line 1321
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valString_:Ljava/lang/Object;

    .line 1322
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x41

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    .line 1323
    return-object p0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1

    .prologue
    .line 1274
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/GeneratedMessage$Builder;
    .locals 1

    .prologue
    .line 1274
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1274
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 1274
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v0

    return-object v0
.end method

.method public clearType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;
    .locals 1

    .prologue
    .line 1475
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    .line 1476
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->VOID:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->type_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    .line 1477
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->onChanged()V

    .line 1478
    return-object p0
.end method

.method public clearValBoolean()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;
    .locals 1

    .prologue
    .line 1508
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x3

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    .line 1509
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valBoolean_:Z

    .line 1510
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->onChanged()V

    .line 1511
    return-object p0
.end method

.method public clearValDouble()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;
    .locals 2

    .prologue
    .line 1640
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x21

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    .line 1641
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valDouble_:D

    .line 1642
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->onChanged()V

    .line 1643
    return-object p0
.end method

.method public clearValFloat()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;
    .locals 1

    .prologue
    .line 1607
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x11

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    .line 1608
    const/4 v0, 0x0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valFloat_:F

    .line 1609
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->onChanged()V

    .line 1610
    return-object p0
.end method

.method public clearValInt()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;
    .locals 1

    .prologue
    .line 1541
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x5

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    .line 1542
    const/4 v0, 0x0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valInt_:I

    .line 1543
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->onChanged()V

    .line 1544
    return-object p0
.end method

.method public clearValLong()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;
    .locals 2

    .prologue
    .line 1574
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x9

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    .line 1575
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valLong_:J

    .line 1576
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->onChanged()V

    .line 1577
    return-object p0
.end method

.method public clearValString()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;
    .locals 1

    .prologue
    .line 1701
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x41

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    .line 1702
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getValString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valString_:Ljava/lang/Object;

    .line 1703
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->onChanged()V

    .line 1704
    return-object p0
.end method

.method public clone()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;
    .locals 2

    .prologue
    .line 1327
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->create()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1

    .prologue
    .line 1274
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/AbstractMessageLite$Builder;
    .locals 1

    .prologue
    .line 1274
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/GeneratedMessage$Builder;
    .locals 1

    .prologue
    .line 1274
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1274
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 1274
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/CloneNotSupportedException;
        }
    .end annotation

    .prologue
    .line 1274
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v0

    return-object v0
.end method

.method public getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;
    .locals 1

    .prologue
    .line 1336
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 1274
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 1274
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    move-result-object v0

    return-object v0
.end method

.method public getDescriptorForType()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 1332
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->access$1000()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method public getType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;
    .locals 1

    .prologue
    .line 1457
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->type_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    return-object v0
.end method

.method public getValBoolean()Z
    .locals 1

    .prologue
    .line 1493
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valBoolean_:Z

    return v0
.end method

.method public getValDouble()D
    .locals 2

    .prologue
    .line 1625
    iget-wide v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valDouble_:D

    return-wide v0
.end method

.method public getValFloat()F
    .locals 1

    .prologue
    .line 1592
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valFloat_:F

    return v0
.end method

.method public getValInt()I
    .locals 1

    .prologue
    .line 1526
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valInt_:I

    return v0
.end method

.method public getValLong()J
    .locals 2

    .prologue
    .line 1559
    iget-wide v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valLong_:J

    return-wide v0
.end method

.method public getValString()Ljava/lang/String;
    .locals 2

    .prologue
    .line 1658
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valString_:Ljava/lang/Object;

    .line 1659
    instance-of v1, v0, Ljava/lang/String;

    if-nez v1, :cond_0

    .line 1660
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 1661
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v0

    .line 1662
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valString_:Ljava/lang/Object;

    .line 1665
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Ljava/lang/String;

    goto :goto_0
.end method

.method public getValStringBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 1673
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valString_:Ljava/lang/Object;

    .line 1674
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 1675
    check-cast v0, Ljava/lang/String;

    .line 1676
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 1678
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valString_:Ljava/lang/Object;

    .line 1681
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

    .line 1451
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

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
    .line 1487
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

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
    .line 1619
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

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
    .line 1586
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

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
    .line 1520
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

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
    .line 1553
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

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
    .line 1652
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

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
    .line 1284
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->access$1100()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    const-class v1, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    const-class v2, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    .line 1285
    invoke-virtual {v0, v1, v2}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;->ensureFieldAccessorsInitialized(Ljava/lang/Class;Ljava/lang/Class;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    .line 1284
    return-object v0
.end method

.method public final isInitialized()Z
    .locals 1

    .prologue
    .line 1423
    const/4 v0, 0x1

    return v0
.end method

.method public mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;
    .locals 2

    .prologue
    .line 1394
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    move-result-object v0

    if-ne p1, v0, :cond_0

    .line 1419
    :goto_0
    return-object p0

    .line 1395
    :cond_0
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->hasType()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1396
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->setType(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    .line 1398
    :cond_1
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->hasValBoolean()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 1399
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getValBoolean()Z

    move-result v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->setValBoolean(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    .line 1401
    :cond_2
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->hasValInt()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 1402
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getValInt()I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->setValInt(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    .line 1404
    :cond_3
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->hasValLong()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 1405
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getValLong()J

    move-result-wide v0

    invoke-virtual {p0, v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->setValLong(J)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    .line 1407
    :cond_4
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->hasValFloat()Z

    move-result v0

    if-eqz v0, :cond_5

    .line 1408
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getValFloat()F

    move-result v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->setValFloat(F)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    .line 1410
    :cond_5
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->hasValDouble()Z

    move-result v0

    if-eqz v0, :cond_6

    .line 1411
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getValDouble()D

    move-result-wide v0

    invoke-virtual {p0, v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->setValDouble(D)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    .line 1413
    :cond_6
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->hasValString()Z

    move-result v0

    if-eqz v0, :cond_7

    .line 1414
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x40

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    .line 1415
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->access$2300(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valString_:Ljava/lang/Object;

    .line 1416
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->onChanged()V

    .line 1418
    :cond_7
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->mergeUnknownFields(Lcom/google/protobuf/UnknownFieldSet;)Lcom/google/protobuf/GeneratedMessage$Builder;

    goto :goto_0
.end method

.method public mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 1430
    const/4 v2, 0x0

    .line 1432
    :try_start_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p1, p2}, Lcom/google/protobuf/Parser;->parsePartialFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;
    :try_end_0
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1437
    if-eqz v0, :cond_0

    .line 1438
    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    .line 1441
    :cond_0
    return-object p0

    .line 1433
    :catch_0
    move-exception v0

    move-object v1, v0

    .line 1434
    :try_start_1
    invoke-virtual {v1}, Lcom/google/protobuf/InvalidProtocolBufferException;->getUnfinishedMessage()Lcom/google/protobuf/MessageLite;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 1435
    :try_start_2
    throw v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 1437
    :catchall_0
    move-exception v1

    move-object v3, v1

    move-object v1, v0

    move-object v0, v3

    :goto_0
    if-eqz v1, :cond_1

    .line 1438
    invoke-virtual {p0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    :cond_1
    throw v0

    .line 1437
    :catchall_1
    move-exception v0

    move-object v1, v2

    goto :goto_0
.end method

.method public mergeFrom(Lcom/google/protobuf/Message;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;
    .locals 1

    .prologue
    .line 1385
    instance-of v0, p1, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    if-eqz v0, :cond_0

    .line 1386
    check-cast p1, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object p0

    .line 1389
    :goto_0
    return-object p0

    .line 1388
    :cond_0
    invoke-super {p0, p1}, Lcom/google/protobuf/GeneratedMessage$Builder;->mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/AbstractMessage$Builder;

    goto :goto_0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 1274
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1

    .prologue
    .line 1274
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->mergeFrom(Lcom/google/protobuf/Message;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/AbstractMessageLite$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 1274
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/Message$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 1274
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1274
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->mergeFrom(Lcom/google/protobuf/Message;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/MessageLite$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 1274
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v0

    return-object v0
.end method

.method public setType(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;
    .locals 1

    .prologue
    .line 1463
    if-nez p1, :cond_0

    .line 1464
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 1466
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    .line 1467
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->type_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    .line 1468
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->onChanged()V

    .line 1469
    return-object p0
.end method

.method public setValBoolean(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;
    .locals 1

    .prologue
    .line 1499
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    .line 1500
    iput-boolean p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valBoolean_:Z

    .line 1501
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->onChanged()V

    .line 1502
    return-object p0
.end method

.method public setValDouble(D)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;
    .locals 1

    .prologue
    .line 1631
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x20

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    .line 1632
    iput-wide p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valDouble_:D

    .line 1633
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->onChanged()V

    .line 1634
    return-object p0
.end method

.method public setValFloat(F)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;
    .locals 1

    .prologue
    .line 1598
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x10

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    .line 1599
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valFloat_:F

    .line 1600
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->onChanged()V

    .line 1601
    return-object p0
.end method

.method public setValInt(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;
    .locals 1

    .prologue
    .line 1532
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x4

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    .line 1533
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valInt_:I

    .line 1534
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->onChanged()V

    .line 1535
    return-object p0
.end method

.method public setValLong(J)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;
    .locals 1

    .prologue
    .line 1565
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x8

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    .line 1566
    iput-wide p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valLong_:J

    .line 1567
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->onChanged()V

    .line 1568
    return-object p0
.end method

.method public setValString(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;
    .locals 1

    .prologue
    .line 1689
    if-nez p1, :cond_0

    .line 1690
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 1692
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x40

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    .line 1693
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valString_:Ljava/lang/Object;

    .line 1694
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->onChanged()V

    .line 1695
    return-object p0
.end method

.method public setValStringBytes(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;
    .locals 1

    .prologue
    .line 1711
    if-nez p1, :cond_0

    .line 1712
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 1714
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x40

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->bitField0_:I

    .line 1715
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->valString_:Ljava/lang/Object;

    .line 1716
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->onChanged()V

    .line 1717
    return-object p0
.end method
