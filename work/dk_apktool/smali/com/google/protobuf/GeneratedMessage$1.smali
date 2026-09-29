.class Lcom/google/protobuf/GeneratedMessage$1;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/google/protobuf/GeneratedMessage$ExtensionDescriptorRetriever;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/google/protobuf/GeneratedMessage;->newMessageScopedGeneratedExtension(Lcom/google/protobuf/Message;ILjava/lang/Class;Lcom/google/protobuf/Message;)Lcom/google/protobuf/GeneratedMessage$GeneratedExtension;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field private final synthetic val$descriptorIndex:I

.field private final synthetic val$scope:Lcom/google/protobuf/Message;


# direct methods
.method constructor <init>(Lcom/google/protobuf/Message;I)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/google/protobuf/GeneratedMessage$1;->val$scope:Lcom/google/protobuf/Message;

    iput p2, p0, Lcom/google/protobuf/GeneratedMessage$1;->val$descriptorIndex:I

    .line 1190
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getDescriptor()Lcom/google/protobuf/Descriptors$FieldDescriptor;
    .locals 2

    .prologue
    .line 1193
    iget-object v0, p0, Lcom/google/protobuf/GeneratedMessage$1;->val$scope:Lcom/google/protobuf/Message;

    invoke-interface {v0}, Lcom/google/protobuf/Message;->getDescriptorForType()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$Descriptor;->getExtensions()Ljava/util/List;

    move-result-object v0

    .line 1194
    iget v1, p0, Lcom/google/protobuf/GeneratedMessage$1;->val$descriptorIndex:I

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$FieldDescriptor;

    .line 1193
    return-object v0
.end method
