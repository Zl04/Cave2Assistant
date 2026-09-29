.class public abstract Lcom/cyjh/mobileanjian/ipc/share/proto/d;
.super Ljava/lang/Object;
.source "SourceFile"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public abstract a()[B
.end method

.method public b()Ljava/nio/ByteBuffer;
    .locals 2

    .prologue
    .line 11
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/d;->a()[B

    move-result-object v0

    array-length v0, v0

    .line 12
    add-int/lit8 v1, v0, 0x4

    new-array v1, v1, [B

    .line 13
    invoke-static {v1}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v1

    .line 14
    invoke-virtual {v1, v0}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    .line 15
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/d;->a()[B

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 16
    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/Buffer;

    .line 18
    return-object v1
.end method
