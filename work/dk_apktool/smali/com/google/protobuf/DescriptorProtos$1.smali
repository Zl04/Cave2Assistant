.class Lcom/google/protobuf/DescriptorProtos$1;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/google/protobuf/Descriptors$FileDescriptor$InternalDescriptorAssigner;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/protobuf/DescriptorProtos;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 17569
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1
    return-void
.end method


# virtual methods
.method public assignDescriptors(Lcom/google/protobuf/Descriptors$FileDescriptor;)Lcom/google/protobuf/ExtensionRegistry;
    .locals 10

    .prologue
    const/4 v9, 0x4

    const/4 v8, 0x3

    const/4 v7, 0x2

    const/4 v6, 0x1

    const/4 v5, 0x0

    .line 17572
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos;->access$0(Lcom/google/protobuf/Descriptors$FileDescriptor;)V

    .line 17574
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->getDescriptor()Lcom/google/protobuf/Descriptors$FileDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$FileDescriptor;->getMessageTypes()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$Descriptor;

    .line 17573
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$1(Lcom/google/protobuf/Descriptors$Descriptor;)V

    .line 17576
    new-instance v0, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 17577
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$2()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v1

    .line 17578
    new-array v2, v6, [Ljava/lang/String;

    const-string v3, "File"

    aput-object v3, v2, v5

    .line 17579
    const-class v3, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;

    .line 17580
    const-class v4, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;

    .line 17575
    invoke-direct {v0, v1, v2, v3, v4}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;-><init>(Lcom/google/protobuf/Descriptors$Descriptor;[Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;)V

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$3(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)V

    .line 17582
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->getDescriptor()Lcom/google/protobuf/Descriptors$FileDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$FileDescriptor;->getMessageTypes()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$Descriptor;

    .line 17581
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$4(Lcom/google/protobuf/Descriptors$Descriptor;)V

    .line 17584
    new-instance v0, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 17585
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$5()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v1

    .line 17586
    const/16 v2, 0xb

    new-array v2, v2, [Ljava/lang/String;

    const-string v3, "Name"

    aput-object v3, v2, v5

    const-string v3, "Package"

    aput-object v3, v2, v6

    const-string v3, "Dependency"

    aput-object v3, v2, v7

    const-string v3, "PublicDependency"

    aput-object v3, v2, v8

    const-string v3, "WeakDependency"

    aput-object v3, v2, v9

    const/4 v3, 0x5

    const-string v4, "MessageType"

    aput-object v4, v2, v3

    const/4 v3, 0x6

    const-string v4, "EnumType"

    aput-object v4, v2, v3

    const/4 v3, 0x7

    const-string v4, "Service"

    aput-object v4, v2, v3

    const/16 v3, 0x8

    const-string v4, "Extension"

    aput-object v4, v2, v3

    const/16 v3, 0x9

    const-string v4, "Options"

    aput-object v4, v2, v3

    const/16 v3, 0xa

    const-string v4, "SourceCodeInfo"

    aput-object v4, v2, v3

    .line 17587
    const-class v3, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;

    .line 17588
    const-class v4, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;

    .line 17583
    invoke-direct {v0, v1, v2, v3, v4}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;-><init>(Lcom/google/protobuf/Descriptors$Descriptor;[Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;)V

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$6(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)V

    .line 17590
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->getDescriptor()Lcom/google/protobuf/Descriptors$FileDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$FileDescriptor;->getMessageTypes()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$Descriptor;

    .line 17589
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$7(Lcom/google/protobuf/Descriptors$Descriptor;)V

    .line 17592
    new-instance v0, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 17593
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$8()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v1

    .line 17594
    const/4 v2, 0x7

    new-array v2, v2, [Ljava/lang/String;

    const-string v3, "Name"

    aput-object v3, v2, v5

    const-string v3, "Field"

    aput-object v3, v2, v6

    const-string v3, "Extension"

    aput-object v3, v2, v7

    const-string v3, "NestedType"

    aput-object v3, v2, v8

    const-string v3, "EnumType"

    aput-object v3, v2, v9

    const/4 v3, 0x5

    const-string v4, "ExtensionRange"

    aput-object v4, v2, v3

    const/4 v3, 0x6

    const-string v4, "Options"

    aput-object v4, v2, v3

    .line 17595
    const-class v3, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    .line 17596
    const-class v4, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

    .line 17591
    invoke-direct {v0, v1, v2, v3, v4}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;-><init>(Lcom/google/protobuf/Descriptors$Descriptor;[Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;)V

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$9(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)V

    .line 17598
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$8()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$Descriptor;->getNestedTypes()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$Descriptor;

    .line 17597
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$10(Lcom/google/protobuf/Descriptors$Descriptor;)V

    .line 17600
    new-instance v0, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 17601
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$11()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v1

    .line 17602
    new-array v2, v7, [Ljava/lang/String;

    const-string v3, "Start"

    aput-object v3, v2, v5

    const-string v3, "End"

    aput-object v3, v2, v6

    .line 17603
    const-class v3, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange;

    .line 17604
    const-class v4, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange$Builder;

    .line 17599
    invoke-direct {v0, v1, v2, v3, v4}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;-><init>(Lcom/google/protobuf/Descriptors$Descriptor;[Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;)V

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$12(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)V

    .line 17606
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->getDescriptor()Lcom/google/protobuf/Descriptors$FileDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$FileDescriptor;->getMessageTypes()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, v8}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$Descriptor;

    .line 17605
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$13(Lcom/google/protobuf/Descriptors$Descriptor;)V

    .line 17608
    new-instance v0, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 17609
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$14()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v1

    .line 17610
    const/16 v2, 0x8

    new-array v2, v2, [Ljava/lang/String;

    const-string v3, "Name"

    aput-object v3, v2, v5

    const-string v3, "Number"

    aput-object v3, v2, v6

    const-string v3, "Label"

    aput-object v3, v2, v7

    const-string v3, "Type"

    aput-object v3, v2, v8

    const-string v3, "TypeName"

    aput-object v3, v2, v9

    const/4 v3, 0x5

    const-string v4, "Extendee"

    aput-object v4, v2, v3

    const/4 v3, 0x6

    const-string v4, "DefaultValue"

    aput-object v4, v2, v3

    const/4 v3, 0x7

    const-string v4, "Options"

    aput-object v4, v2, v3

    .line 17611
    const-class v3, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    .line 17612
    const-class v4, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;

    .line 17607
    invoke-direct {v0, v1, v2, v3, v4}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;-><init>(Lcom/google/protobuf/Descriptors$Descriptor;[Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;)V

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$15(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)V

    .line 17614
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->getDescriptor()Lcom/google/protobuf/Descriptors$FileDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$FileDescriptor;->getMessageTypes()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, v9}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$Descriptor;

    .line 17613
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$16(Lcom/google/protobuf/Descriptors$Descriptor;)V

    .line 17616
    new-instance v0, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 17617
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$17()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v1

    .line 17618
    new-array v2, v8, [Ljava/lang/String;

    const-string v3, "Name"

    aput-object v3, v2, v5

    const-string v3, "Value"

    aput-object v3, v2, v6

    const-string v3, "Options"

    aput-object v3, v2, v7

    .line 17619
    const-class v3, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;

    .line 17620
    const-class v4, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;

    .line 17615
    invoke-direct {v0, v1, v2, v3, v4}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;-><init>(Lcom/google/protobuf/Descriptors$Descriptor;[Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;)V

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$18(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)V

    .line 17622
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->getDescriptor()Lcom/google/protobuf/Descriptors$FileDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$FileDescriptor;->getMessageTypes()Ljava/util/List;

    move-result-object v0

    const/4 v1, 0x5

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$Descriptor;

    .line 17621
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$19(Lcom/google/protobuf/Descriptors$Descriptor;)V

    .line 17624
    new-instance v0, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 17625
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$20()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v1

    .line 17626
    new-array v2, v8, [Ljava/lang/String;

    const-string v3, "Name"

    aput-object v3, v2, v5

    const-string v3, "Number"

    aput-object v3, v2, v6

    const-string v3, "Options"

    aput-object v3, v2, v7

    .line 17627
    const-class v3, Lcom/google/protobuf/DescriptorProtos$EnumValueDescriptorProto;

    .line 17628
    const-class v4, Lcom/google/protobuf/DescriptorProtos$EnumValueDescriptorProto$Builder;

    .line 17623
    invoke-direct {v0, v1, v2, v3, v4}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;-><init>(Lcom/google/protobuf/Descriptors$Descriptor;[Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;)V

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$21(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)V

    .line 17630
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->getDescriptor()Lcom/google/protobuf/Descriptors$FileDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$FileDescriptor;->getMessageTypes()Ljava/util/List;

    move-result-object v0

    const/4 v1, 0x6

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$Descriptor;

    .line 17629
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$22(Lcom/google/protobuf/Descriptors$Descriptor;)V

    .line 17632
    new-instance v0, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 17633
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$23()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v1

    .line 17634
    new-array v2, v8, [Ljava/lang/String;

    const-string v3, "Name"

    aput-object v3, v2, v5

    const-string v3, "Method"

    aput-object v3, v2, v6

    const-string v3, "Options"

    aput-object v3, v2, v7

    .line 17635
    const-class v3, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;

    .line 17636
    const-class v4, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    .line 17631
    invoke-direct {v0, v1, v2, v3, v4}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;-><init>(Lcom/google/protobuf/Descriptors$Descriptor;[Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;)V

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$24(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)V

    .line 17638
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->getDescriptor()Lcom/google/protobuf/Descriptors$FileDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$FileDescriptor;->getMessageTypes()Ljava/util/List;

    move-result-object v0

    const/4 v1, 0x7

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$Descriptor;

    .line 17637
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$25(Lcom/google/protobuf/Descriptors$Descriptor;)V

    .line 17640
    new-instance v0, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 17641
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$26()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v1

    .line 17642
    new-array v2, v9, [Ljava/lang/String;

    const-string v3, "Name"

    aput-object v3, v2, v5

    const-string v3, "InputType"

    aput-object v3, v2, v6

    const-string v3, "OutputType"

    aput-object v3, v2, v7

    const-string v3, "Options"

    aput-object v3, v2, v8

    .line 17643
    const-class v3, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;

    .line 17644
    const-class v4, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;

    .line 17639
    invoke-direct {v0, v1, v2, v3, v4}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;-><init>(Lcom/google/protobuf/Descriptors$Descriptor;[Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;)V

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$27(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)V

    .line 17646
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->getDescriptor()Lcom/google/protobuf/Descriptors$FileDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$FileDescriptor;->getMessageTypes()Ljava/util/List;

    move-result-object v0

    const/16 v1, 0x8

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$Descriptor;

    .line 17645
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$28(Lcom/google/protobuf/Descriptors$Descriptor;)V

    .line 17648
    new-instance v0, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 17649
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$29()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v1

    .line 17650
    const/16 v2, 0xa

    new-array v2, v2, [Ljava/lang/String;

    const-string v3, "JavaPackage"

    aput-object v3, v2, v5

    const-string v3, "JavaOuterClassname"

    aput-object v3, v2, v6

    const-string v3, "JavaMultipleFiles"

    aput-object v3, v2, v7

    const-string v3, "JavaGenerateEqualsAndHash"

    aput-object v3, v2, v8

    const-string v3, "OptimizeFor"

    aput-object v3, v2, v9

    const/4 v3, 0x5

    const-string v4, "GoPackage"

    aput-object v4, v2, v3

    const/4 v3, 0x6

    const-string v4, "CcGenericServices"

    aput-object v4, v2, v3

    const/4 v3, 0x7

    const-string v4, "JavaGenericServices"

    aput-object v4, v2, v3

    const/16 v3, 0x8

    const-string v4, "PyGenericServices"

    aput-object v4, v2, v3

    const/16 v3, 0x9

    const-string v4, "UninterpretedOption"

    aput-object v4, v2, v3

    .line 17651
    const-class v3, Lcom/google/protobuf/DescriptorProtos$FileOptions;

    .line 17652
    const-class v4, Lcom/google/protobuf/DescriptorProtos$FileOptions$Builder;

    .line 17647
    invoke-direct {v0, v1, v2, v3, v4}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;-><init>(Lcom/google/protobuf/Descriptors$Descriptor;[Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;)V

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$30(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)V

    .line 17654
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->getDescriptor()Lcom/google/protobuf/Descriptors$FileDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$FileDescriptor;->getMessageTypes()Ljava/util/List;

    move-result-object v0

    const/16 v1, 0x9

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$Descriptor;

    .line 17653
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$31(Lcom/google/protobuf/Descriptors$Descriptor;)V

    .line 17656
    new-instance v0, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 17657
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$32()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v1

    .line 17658
    new-array v2, v8, [Ljava/lang/String;

    const-string v3, "MessageSetWireFormat"

    aput-object v3, v2, v5

    const-string v3, "NoStandardDescriptorAccessor"

    aput-object v3, v2, v6

    const-string v3, "UninterpretedOption"

    aput-object v3, v2, v7

    .line 17659
    const-class v3, Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    .line 17660
    const-class v4, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    .line 17655
    invoke-direct {v0, v1, v2, v3, v4}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;-><init>(Lcom/google/protobuf/Descriptors$Descriptor;[Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;)V

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$33(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)V

    .line 17662
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->getDescriptor()Lcom/google/protobuf/Descriptors$FileDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$FileDescriptor;->getMessageTypes()Ljava/util/List;

    move-result-object v0

    const/16 v1, 0xa

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$Descriptor;

    .line 17661
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$34(Lcom/google/protobuf/Descriptors$Descriptor;)V

    .line 17664
    new-instance v0, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 17665
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$35()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v1

    .line 17666
    const/4 v2, 0x7

    new-array v2, v2, [Ljava/lang/String;

    const-string v3, "Ctype"

    aput-object v3, v2, v5

    const-string v3, "Packed"

    aput-object v3, v2, v6

    const-string v3, "Lazy"

    aput-object v3, v2, v7

    const-string v3, "Deprecated"

    aput-object v3, v2, v8

    const-string v3, "ExperimentalMapKey"

    aput-object v3, v2, v9

    const/4 v3, 0x5

    const-string v4, "Weak"

    aput-object v4, v2, v3

    const/4 v3, 0x6

    const-string v4, "UninterpretedOption"

    aput-object v4, v2, v3

    .line 17667
    const-class v3, Lcom/google/protobuf/DescriptorProtos$FieldOptions;

    .line 17668
    const-class v4, Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;

    .line 17663
    invoke-direct {v0, v1, v2, v3, v4}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;-><init>(Lcom/google/protobuf/Descriptors$Descriptor;[Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;)V

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$36(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)V

    .line 17670
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->getDescriptor()Lcom/google/protobuf/Descriptors$FileDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$FileDescriptor;->getMessageTypes()Ljava/util/List;

    move-result-object v0

    const/16 v1, 0xb

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$Descriptor;

    .line 17669
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$37(Lcom/google/protobuf/Descriptors$Descriptor;)V

    .line 17672
    new-instance v0, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 17673
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$38()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v1

    .line 17674
    new-array v2, v7, [Ljava/lang/String;

    const-string v3, "AllowAlias"

    aput-object v3, v2, v5

    const-string v3, "UninterpretedOption"

    aput-object v3, v2, v6

    .line 17675
    const-class v3, Lcom/google/protobuf/DescriptorProtos$EnumOptions;

    .line 17676
    const-class v4, Lcom/google/protobuf/DescriptorProtos$EnumOptions$Builder;

    .line 17671
    invoke-direct {v0, v1, v2, v3, v4}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;-><init>(Lcom/google/protobuf/Descriptors$Descriptor;[Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;)V

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$39(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)V

    .line 17678
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->getDescriptor()Lcom/google/protobuf/Descriptors$FileDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$FileDescriptor;->getMessageTypes()Ljava/util/List;

    move-result-object v0

    const/16 v1, 0xc

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$Descriptor;

    .line 17677
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$40(Lcom/google/protobuf/Descriptors$Descriptor;)V

    .line 17680
    new-instance v0, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 17681
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$41()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v1

    .line 17682
    new-array v2, v6, [Ljava/lang/String;

    const-string v3, "UninterpretedOption"

    aput-object v3, v2, v5

    .line 17683
    const-class v3, Lcom/google/protobuf/DescriptorProtos$EnumValueOptions;

    .line 17684
    const-class v4, Lcom/google/protobuf/DescriptorProtos$EnumValueOptions$Builder;

    .line 17679
    invoke-direct {v0, v1, v2, v3, v4}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;-><init>(Lcom/google/protobuf/Descriptors$Descriptor;[Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;)V

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$42(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)V

    .line 17686
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->getDescriptor()Lcom/google/protobuf/Descriptors$FileDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$FileDescriptor;->getMessageTypes()Ljava/util/List;

    move-result-object v0

    const/16 v1, 0xd

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$Descriptor;

    .line 17685
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$43(Lcom/google/protobuf/Descriptors$Descriptor;)V

    .line 17688
    new-instance v0, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 17689
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$44()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v1

    .line 17690
    new-array v2, v6, [Ljava/lang/String;

    const-string v3, "UninterpretedOption"

    aput-object v3, v2, v5

    .line 17691
    const-class v3, Lcom/google/protobuf/DescriptorProtos$ServiceOptions;

    .line 17692
    const-class v4, Lcom/google/protobuf/DescriptorProtos$ServiceOptions$Builder;

    .line 17687
    invoke-direct {v0, v1, v2, v3, v4}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;-><init>(Lcom/google/protobuf/Descriptors$Descriptor;[Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;)V

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$45(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)V

    .line 17694
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->getDescriptor()Lcom/google/protobuf/Descriptors$FileDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$FileDescriptor;->getMessageTypes()Ljava/util/List;

    move-result-object v0

    const/16 v1, 0xe

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$Descriptor;

    .line 17693
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$46(Lcom/google/protobuf/Descriptors$Descriptor;)V

    .line 17696
    new-instance v0, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 17697
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$47()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v1

    .line 17698
    new-array v2, v6, [Ljava/lang/String;

    const-string v3, "UninterpretedOption"

    aput-object v3, v2, v5

    .line 17699
    const-class v3, Lcom/google/protobuf/DescriptorProtos$MethodOptions;

    .line 17700
    const-class v4, Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;

    .line 17695
    invoke-direct {v0, v1, v2, v3, v4}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;-><init>(Lcom/google/protobuf/Descriptors$Descriptor;[Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;)V

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$48(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)V

    .line 17702
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->getDescriptor()Lcom/google/protobuf/Descriptors$FileDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$FileDescriptor;->getMessageTypes()Ljava/util/List;

    move-result-object v0

    const/16 v1, 0xf

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$Descriptor;

    .line 17701
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$49(Lcom/google/protobuf/Descriptors$Descriptor;)V

    .line 17704
    new-instance v0, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 17705
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$50()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v1

    .line 17706
    const/4 v2, 0x7

    new-array v2, v2, [Ljava/lang/String;

    const-string v3, "Name"

    aput-object v3, v2, v5

    const-string v3, "IdentifierValue"

    aput-object v3, v2, v6

    const-string v3, "PositiveIntValue"

    aput-object v3, v2, v7

    const-string v3, "NegativeIntValue"

    aput-object v3, v2, v8

    const-string v3, "DoubleValue"

    aput-object v3, v2, v9

    const/4 v3, 0x5

    const-string v4, "StringValue"

    aput-object v4, v2, v3

    const/4 v3, 0x6

    const-string v4, "AggregateValue"

    aput-object v4, v2, v3

    .line 17707
    const-class v3, Lcom/google/protobuf/DescriptorProtos$UninterpretedOption;

    .line 17708
    const-class v4, Lcom/google/protobuf/DescriptorProtos$UninterpretedOption$Builder;

    .line 17703
    invoke-direct {v0, v1, v2, v3, v4}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;-><init>(Lcom/google/protobuf/Descriptors$Descriptor;[Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;)V

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$51(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)V

    .line 17710
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$50()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$Descriptor;->getNestedTypes()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$Descriptor;

    .line 17709
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$52(Lcom/google/protobuf/Descriptors$Descriptor;)V

    .line 17712
    new-instance v0, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 17713
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$53()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v1

    .line 17714
    new-array v2, v7, [Ljava/lang/String;

    const-string v3, "NamePart"

    aput-object v3, v2, v5

    const-string v3, "IsExtension"

    aput-object v3, v2, v6

    .line 17715
    const-class v3, Lcom/google/protobuf/DescriptorProtos$UninterpretedOption$NamePart;

    .line 17716
    const-class v4, Lcom/google/protobuf/DescriptorProtos$UninterpretedOption$NamePart$Builder;

    .line 17711
    invoke-direct {v0, v1, v2, v3, v4}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;-><init>(Lcom/google/protobuf/Descriptors$Descriptor;[Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;)V

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$54(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)V

    .line 17718
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->getDescriptor()Lcom/google/protobuf/Descriptors$FileDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$FileDescriptor;->getMessageTypes()Ljava/util/List;

    move-result-object v0

    const/16 v1, 0x10

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$Descriptor;

    .line 17717
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$55(Lcom/google/protobuf/Descriptors$Descriptor;)V

    .line 17720
    new-instance v0, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 17721
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$56()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v1

    .line 17722
    new-array v2, v6, [Ljava/lang/String;

    const-string v3, "Location"

    aput-object v3, v2, v5

    .line 17723
    const-class v3, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;

    .line 17724
    const-class v4, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Builder;

    .line 17719
    invoke-direct {v0, v1, v2, v3, v4}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;-><init>(Lcom/google/protobuf/Descriptors$Descriptor;[Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;)V

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$57(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)V

    .line 17726
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$56()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$Descriptor;->getNestedTypes()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$Descriptor;

    .line 17725
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$58(Lcom/google/protobuf/Descriptors$Descriptor;)V

    .line 17728
    new-instance v0, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 17729
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$59()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v1

    .line 17730
    new-array v2, v9, [Ljava/lang/String;

    const-string v3, "Path"

    aput-object v3, v2, v5

    const-string v3, "Span"

    aput-object v3, v2, v6

    const-string v3, "LeadingComments"

    aput-object v3, v2, v7

    const-string v3, "TrailingComments"

    aput-object v3, v2, v8

    .line 17731
    const-class v3, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;

    .line 17732
    const-class v4, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;

    .line 17727
    invoke-direct {v0, v1, v2, v3, v4}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;-><init>(Lcom/google/protobuf/Descriptors$Descriptor;[Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;)V

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos;->access$60(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)V

    .line 17733
    const/4 v0, 0x0

    return-object v0
.end method
