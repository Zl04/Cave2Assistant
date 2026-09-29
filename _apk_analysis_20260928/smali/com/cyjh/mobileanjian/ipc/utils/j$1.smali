.class final Lcom/cyjh/mobileanjian/ipc/utils/j$1;
.super Lcom/cyjh/mobileanjian/ipc/utils/g;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/utils/j;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 3

    .prologue
    .line 31
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/utils/g;-><init>()V

    .line 33
    const-string v0, "void"

    sget-object v1, Ljava/lang/Void;->TYPE:Ljava/lang/Class;

    const/16 v2, 0x8

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {p0, v0, v1, v2}, Lcom/cyjh/mobileanjian/ipc/utils/j$1;->a(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Integer;)V

    .line 34
    const-string v0, "boolean"

    sget-object v1, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    const/4 v2, 0x1

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {p0, v0, v1, v2}, Lcom/cyjh/mobileanjian/ipc/utils/j$1;->a(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Integer;)V

    .line 35
    const-string v0, "byte"

    sget-object v1, Ljava/lang/Byte;->TYPE:Ljava/lang/Class;

    const/4 v2, 0x3

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {p0, v0, v1, v2}, Lcom/cyjh/mobileanjian/ipc/utils/j$1;->a(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Integer;)V

    .line 36
    const-string v0, "char"

    sget-object v1, Ljava/lang/Character;->TYPE:Ljava/lang/Class;

    const/4 v2, 0x2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {p0, v0, v1, v2}, Lcom/cyjh/mobileanjian/ipc/utils/j$1;->a(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Integer;)V

    .line 37
    const-string v0, "int"

    sget-object v1, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    const/4 v2, 0x4

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {p0, v0, v1, v2}, Lcom/cyjh/mobileanjian/ipc/utils/j$1;->a(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Integer;)V

    .line 38
    const-string v0, "long"

    sget-object v1, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    const/4 v2, 0x5

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {p0, v0, v1, v2}, Lcom/cyjh/mobileanjian/ipc/utils/j$1;->a(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Integer;)V

    .line 39
    const-string v0, "float"

    sget-object v1, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    const/4 v2, 0x6

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {p0, v0, v1, v2}, Lcom/cyjh/mobileanjian/ipc/utils/j$1;->a(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Integer;)V

    .line 40
    const-string v0, "double"

    sget-object v1, Ljava/lang/Double;->TYPE:Ljava/lang/Class;

    const/4 v2, 0x7

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {p0, v0, v1, v2}, Lcom/cyjh/mobileanjian/ipc/utils/j$1;->a(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Integer;)V

    .line 42
    const-string v0, "String"

    const-class v1, Ljava/lang/String;

    const/16 v2, 0x9

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {p0, v0, v1, v2}, Lcom/cyjh/mobileanjian/ipc/utils/j$1;->a(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Integer;)V

    .line 43
    return-void
.end method
