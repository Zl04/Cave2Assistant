.class final Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$1;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/google/protobuf/Descriptors$FileDescriptor$InternalDescriptorAssigner;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 9299
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

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

    .line 9302
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->a(Lcom/google/protobuf/Descriptors$FileDescriptor;)Lcom/google/protobuf/Descriptors$FileDescriptor;

    .line 9304
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->a()Lcom/google/protobuf/Descriptors$FileDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$FileDescriptor;->getMessageTypes()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$Descriptor;

    .line 9303
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->a(Lcom/google/protobuf/Descriptors$Descriptor;)Lcom/google/protobuf/Descriptors$Descriptor;

    .line 9305
    new-instance v0, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 9307
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->b()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v1

    new-array v2, v9, [Ljava/lang/String;

    const-string v3, "Top"

    aput-object v3, v2, v5

    const-string v3, "Left"

    aput-object v3, v2, v6

    const-string v3, "Bottom"

    aput-object v3, v2, v7

    const-string v3, "Right"

    aput-object v3, v2, v8

    invoke-direct {v0, v1, v2}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;-><init>(Lcom/google/protobuf/Descriptors$Descriptor;[Ljava/lang/String;)V

    .line 9305
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->a(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 9310
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->a()Lcom/google/protobuf/Descriptors$FileDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$FileDescriptor;->getMessageTypes()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$Descriptor;

    .line 9309
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->b(Lcom/google/protobuf/Descriptors$Descriptor;)Lcom/google/protobuf/Descriptors$Descriptor;

    .line 9311
    new-instance v0, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 9313
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->d()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v1

    const/16 v2, 0x16

    new-array v2, v2, [Ljava/lang/String;

    const-string v3, "Command"

    aput-object v3, v2, v5

    const-string v3, "ControlId"

    aput-object v3, v2, v6

    const-string v3, "ParentId"

    aput-object v3, v2, v7

    const-string v3, "Text"

    aput-object v3, v2, v8

    const-string v3, "Width"

    aput-object v3, v2, v9

    const/4 v3, 0x5

    const-string v4, "Height"

    aput-object v4, v2, v3

    const/4 v3, 0x6

    const-string v4, "LayoutStyle"

    aput-object v4, v2, v3

    const/4 v3, 0x7

    const-string v4, "DefaultCheckStatus"

    aput-object v4, v2, v3

    const/16 v3, 0x8

    const-string v4, "ItemText"

    aput-object v4, v2, v3

    const/16 v3, 0x9

    const-string v4, "ItemIndex"

    aput-object v4, v2, v3

    const/16 v3, 0xa

    const-string v4, "DefaultItemIndex"

    aput-object v4, v2, v3

    const/16 v3, 0xb

    const-string v4, "Path"

    aput-object v4, v2, v3

    const/16 v3, 0xc

    const-string v4, "Url"

    aput-object v4, v2, v3

    const/16 v3, 0xd

    const-string v4, "EnabledStatus"

    aput-object v4, v2, v3

    const/16 v3, 0xe

    const-string v4, "VisibleStatus"

    aput-object v4, v2, v3

    const/16 v3, 0xf

    const-string v4, "Color"

    aput-object v4, v2, v3

    const/16 v3, 0x10

    const-string v4, "AlignType"

    aput-object v4, v2, v3

    const/16 v3, 0x11

    const-string v4, "Padding"

    aput-object v4, v2, v3

    const/16 v3, 0x12

    const-string v4, "UipData"

    aput-object v4, v2, v3

    const/16 v3, 0x13

    const-string v4, "EditInputType"

    aput-object v4, v2, v3

    const/16 v3, 0x14

    const-string v4, "FontType"

    aput-object v4, v2, v3

    const/16 v3, 0x15

    const-string v4, "FontSize"

    aput-object v4, v2, v3

    invoke-direct {v0, v1, v2}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;-><init>(Lcom/google/protobuf/Descriptors$Descriptor;[Ljava/lang/String;)V

    .line 9311
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->b(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 9316
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->a()Lcom/google/protobuf/Descriptors$FileDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$FileDescriptor;->getMessageTypes()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$Descriptor;

    .line 9315
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->c(Lcom/google/protobuf/Descriptors$Descriptor;)Lcom/google/protobuf/Descriptors$Descriptor;

    .line 9317
    new-instance v0, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 9319
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->f()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v1

    new-array v2, v9, [Ljava/lang/String;

    const-string v3, "ControlId"

    aput-object v3, v2, v5

    const-string v3, "Type"

    aput-object v3, v2, v6

    const-string v3, "EventArgs"

    aput-object v3, v2, v7

    const-string v3, "EventFunctionName"

    aput-object v3, v2, v8

    invoke-direct {v0, v1, v2}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;-><init>(Lcom/google/protobuf/Descriptors$Descriptor;[Ljava/lang/String;)V

    .line 9317
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->c(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 9322
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->a()Lcom/google/protobuf/Descriptors$FileDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$FileDescriptor;->getMessageTypes()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, v8}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$Descriptor;

    .line 9321
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->d(Lcom/google/protobuf/Descriptors$Descriptor;)Lcom/google/protobuf/Descriptors$Descriptor;

    .line 9323
    new-instance v0, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 9325
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->h()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v1

    const/4 v2, 0x5

    new-array v2, v2, [Ljava/lang/String;

    const-string v3, "ControlId"

    aput-object v3, v2, v5

    const-string v3, "Type"

    aput-object v3, v2, v6

    const-string v3, "BoolValue"

    aput-object v3, v2, v7

    const-string v3, "IntValue"

    aput-object v3, v2, v8

    const-string v3, "StringValue"

    aput-object v3, v2, v9

    invoke-direct {v0, v1, v2}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;-><init>(Lcom/google/protobuf/Descriptors$Descriptor;[Ljava/lang/String;)V

    .line 9323
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->d(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 9328
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->a()Lcom/google/protobuf/Descriptors$FileDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$FileDescriptor;->getMessageTypes()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, v9}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$Descriptor;

    .line 9327
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->e(Lcom/google/protobuf/Descriptors$Descriptor;)Lcom/google/protobuf/Descriptors$Descriptor;

    .line 9329
    new-instance v0, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 9331
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->j()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v1

    new-array v2, v9, [Ljava/lang/String;

    const-string v3, "Command"

    aput-object v3, v2, v5

    const-string v3, "Event"

    aput-object v3, v2, v6

    const-string v3, "IsSuccess"

    aput-object v3, v2, v7

    const-string v3, "VarTable"

    aput-object v3, v2, v8

    invoke-direct {v0, v1, v2}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;-><init>(Lcom/google/protobuf/Descriptors$Descriptor;[Ljava/lang/String;)V

    .line 9329
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->e(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 9334
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->a()Lcom/google/protobuf/Descriptors$FileDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$FileDescriptor;->getMessageTypes()Ljava/util/List;

    move-result-object v0

    const/4 v1, 0x5

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$Descriptor;

    .line 9333
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->f(Lcom/google/protobuf/Descriptors$Descriptor;)Lcom/google/protobuf/Descriptors$Descriptor;

    .line 9335
    new-instance v0, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 9337
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->l()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v1

    new-array v2, v8, [Ljava/lang/String;

    const-string v3, "Command"

    aput-object v3, v2, v5

    const-string v3, "ControlId"

    aput-object v3, v2, v6

    const-string v3, "UipAttributeData"

    aput-object v3, v2, v7

    invoke-direct {v0, v1, v2}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;-><init>(Lcom/google/protobuf/Descriptors$Descriptor;[Ljava/lang/String;)V

    .line 9335
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->f(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 9340
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->a()Lcom/google/protobuf/Descriptors$FileDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$FileDescriptor;->getMessageTypes()Ljava/util/List;

    move-result-object v0

    const/4 v1, 0x6

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$Descriptor;

    .line 9339
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->g(Lcom/google/protobuf/Descriptors$Descriptor;)Lcom/google/protobuf/Descriptors$Descriptor;

    .line 9341
    new-instance v0, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 9343
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->n()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v1

    new-array v2, v9, [Ljava/lang/String;

    const-string v3, "Command"

    aput-object v3, v2, v5

    const-string v3, "Event"

    aput-object v3, v2, v6

    const-string v3, "IsSuccess"

    aput-object v3, v2, v7

    const-string v3, "UipAttributeData"

    aput-object v3, v2, v8

    invoke-direct {v0, v1, v2}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;-><init>(Lcom/google/protobuf/Descriptors$Descriptor;[Ljava/lang/String;)V

    .line 9341
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->g(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 9345
    const/4 v0, 0x0

    return-object v0
.end method
