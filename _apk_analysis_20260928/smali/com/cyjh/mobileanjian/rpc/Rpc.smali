.class public Lcom/cyjh/mobileanjian/rpc/Rpc;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static final MAX_THREAD_COUNT:I = 0x20

.field private static final THE_CLASS:Ljava/lang/Class;

.field private static mRetValue:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

.field private static waits:[Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 33
    const-class v0, Lcom/cyjh/mobileanjian/rpc/Rpc;

    sput-object v0, Lcom/cyjh/mobileanjian/rpc/Rpc;->THE_CLASS:Ljava/lang/Class;

    .line 36
    const/16 v0, 0x20

    new-array v0, v0, [Z

    sput-object v0, Lcom/cyjh/mobileanjian/rpc/Rpc;->waits:[Z

    .line 37
    const/4 v0, 0x0

    sput-object v0, Lcom/cyjh/mobileanjian/rpc/Rpc;->mRetValue:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static AsynCall(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/String;)Z
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 161
    invoke-static {p0}, Lcom/cyjh/mobileanjian/ipc/engine/utils/h;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/h;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    invoke-static {p2}, Lcom/cyjh/mobileanjian/ipc/engine/utils/h;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 183
    :cond_0
    :goto_0
    return v0

    .line 164
    :cond_1
    invoke-static {p3, p4}, Lcom/cyjh/mobileanjian/rpc/Rpc;->checkArgs([Ljava/lang/String;[Ljava/lang/String;)I

    move-result v1

    .line 165
    const/4 v2, -0x1

    if-eq v1, v2, :cond_0

    .line 169
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v2

    .line 170
    const/16 v3, 0x30

    invoke-virtual {v2, v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v3

    .line 171
    invoke-virtual {v3, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setIsSyncCall(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 172
    invoke-virtual {v0, p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setPkgName(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 173
    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setClassName(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 174
    invoke-virtual {v0, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setMethodName(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    .line 175
    if-nez v1, :cond_2

    .line 177
    invoke-static {p3}, Lcom/cyjh/mobileanjian/rpc/Rpc;->arraryToList([Ljava/lang/String;)Ljava/util/List;

    move-result-object v0

    invoke-virtual {v2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addAllTypes(Ljava/lang/Iterable;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    .line 178
    invoke-static {p4}, Lcom/cyjh/mobileanjian/rpc/Rpc;->arraryToList([Ljava/lang/String;)Ljava/util/List;

    move-result-object v0

    invoke-virtual {v2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addAllParams(Ljava/lang/Iterable;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    .line 180
    :cond_2
    invoke-static {}, Lcom/cyjh/mobileanjian/rpc/Rpc;->getClient()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v0

    invoke-virtual {v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 182
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\u5df2\u7ecf\u8c03\u7528\u4e86AsynCall "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "."

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/cyjh/mobileanjian/rpc/Rpc;->THE_CLASS:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 183
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public static SimpleCallReturnInt(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I
    .locals 6

    .prologue
    const/4 v3, 0x0

    .line 140
    const-string v5, "int"

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v4, v3

    invoke-static/range {v0 .. v5}, Lcom/cyjh/mobileanjian/rpc/Rpc;->SynCall(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 141
    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    return v0
.end method

.method public static SimpleCallReturnString(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 6

    .prologue
    const/4 v3, 0x0

    .line 113
    const-string v5, "String"

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v4, v3

    invoke-static/range {v0 .. v5}, Lcom/cyjh/mobileanjian/rpc/Rpc;->SynCall(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 114
    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method public static SimpleCallStringParam(ZLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z
    .locals 4

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 93
    if-eqz p0, :cond_0

    .line 94
    new-array v0, v3, [Ljava/lang/String;

    const-string v1, "String"

    aput-object v1, v0, v2

    new-array v1, v3, [Ljava/lang/String;

    aput-object p4, v1, v2

    invoke-static {p1, p2, p3, v0, v1}, Lcom/cyjh/mobileanjian/rpc/Rpc;->SynCall(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/String;)Z

    move-result v0

    .line 97
    :goto_0
    return v0

    .line 96
    :cond_0
    new-array v0, v3, [Ljava/lang/String;

    const-string v1, "String"

    aput-object v1, v0, v2

    new-array v1, v3, [Ljava/lang/String;

    aput-object p4, v1, v2

    invoke-static {p1, p2, p3, v0, v1}, Lcom/cyjh/mobileanjian/rpc/Rpc;->AsynCall(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/String;)Z

    move-result v0

    goto :goto_0
.end method

.method public static SimpleCallStringStringParam(ZLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z
    .locals 5

    .prologue
    const/4 v4, 0x2

    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 103
    if-eqz p0, :cond_0

    .line 104
    new-array v0, v4, [Ljava/lang/String;

    const-string v1, "String"

    aput-object v1, v0, v2

    const-string v1, "String"

    aput-object v1, v0, v3

    new-array v1, v4, [Ljava/lang/String;

    aput-object p4, v1, v2

    aput-object p5, v1, v3

    invoke-static {p1, p2, p3, v0, v1}, Lcom/cyjh/mobileanjian/rpc/Rpc;->SynCall(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/String;)Z

    move-result v0

    .line 108
    :goto_0
    return v0

    .line 106
    :cond_0
    new-array v0, v4, [Ljava/lang/String;

    const-string v1, "String"

    aput-object v1, v0, v2

    const-string v1, "String"

    aput-object v1, v0, v3

    new-array v1, v4, [Ljava/lang/String;

    aput-object p4, v1, v2

    aput-object p5, v1, v3

    invoke-static {p1, p2, p3, v0, v1}, Lcom/cyjh/mobileanjian/rpc/Rpc;->AsynCall(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/String;)Z

    move-result v0

    goto :goto_0
.end method

.method public static SimpleCallStringStringParamReturnString(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 6

    .prologue
    const/4 v4, 0x2

    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 119
    if-nez p3, :cond_0

    .line 121
    const-string v0, "Use SimpleCallReturnString instead."

    .line 135
    :goto_0
    return-object v0

    .line 124
    :cond_0
    if-nez p4, :cond_1

    .line 126
    new-array v3, v2, [Ljava/lang/String;

    const-class v0, Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    aput-object v0, v3, v1

    .line 127
    new-array v4, v2, [Ljava/lang/String;

    aput-object p3, v4, v1

    .line 134
    :goto_1
    const-string v5, "String"

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    invoke-static/range {v0 .. v5}, Lcom/cyjh/mobileanjian/rpc/Rpc;->SynCall(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 135
    check-cast v0, Ljava/lang/String;

    goto :goto_0

    .line 131
    :cond_1
    new-array v3, v4, [Ljava/lang/String;

    const-class v0, Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    aput-object v0, v3, v1

    const-class v0, Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    aput-object v0, v3, v2

    .line 132
    new-array v4, v4, [Ljava/lang/String;

    aput-object p3, v4, v1

    aput-object p4, v4, v2

    goto :goto_1
.end method

.method public static SynCall(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;
    .locals 6

    .prologue
    const/4 v5, 0x1

    const/4 v2, 0x0

    .line 253
    invoke-static {p0}, Lcom/cyjh/mobileanjian/ipc/engine/utils/h;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/h;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {p2}, Lcom/cyjh/mobileanjian/ipc/engine/utils/h;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 254
    :cond_0
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    .line 326
    :goto_0
    return-object v0

    .line 256
    :cond_1
    invoke-static {p3, p4}, Lcom/cyjh/mobileanjian/rpc/Rpc;->checkArgs([Ljava/lang/String;[Ljava/lang/String;)I

    move-result v0

    .line 257
    const/4 v1, -0x1

    if-ne v0, v1, :cond_2

    .line 258
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    goto :goto_0

    .line 261
    :cond_2
    invoke-static {p5}, Lcom/cyjh/mobileanjian/ipc/engine/utils/c;->a(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    move-result-object v1

    if-nez v1, :cond_3

    .line 263
    const-string v0, "Unsupport return type!!!"

    sget-object v1, Lcom/cyjh/mobileanjian/rpc/Rpc;->THE_CLASS:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->e(Ljava/lang/String;Ljava/lang/Class;)V

    .line 264
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    goto :goto_0

    .line 267
    :cond_3
    invoke-static {}, Lcom/cyjh/mobileanjian/rpc/Rpc;->getAWaitId()I

    move-result v1

    .line 268
    sget-object v2, Lcom/cyjh/mobileanjian/rpc/Rpc;->waits:[Z

    aput-boolean v5, v2, v1

    .line 269
    const/4 v2, 0x0

    sput-object v2, Lcom/cyjh/mobileanjian/rpc/Rpc;->mRetValue:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    .line 271
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v2

    .line 272
    invoke-static {p5}, Lcom/cyjh/mobileanjian/ipc/engine/utils/c;->a(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->setType(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v2

    .line 273
    invoke-virtual {v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    move-result-object v2

    .line 275
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v3

    .line 276
    const/16 v4, 0x30

    invoke-virtual {v3, v4}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v4

    .line 277
    invoke-virtual {v4, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setIsSyncCall(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v4

    .line 278
    invoke-virtual {v4, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setWaitId(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v4

    .line 279
    invoke-virtual {v4, p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setPkgName(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v4

    .line 280
    invoke-virtual {v4, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setClassName(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v4

    .line 281
    invoke-virtual {v4, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setMethodName(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v4

    .line 282
    invoke-virtual {v4, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setRetValue(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    .line 283
    if-nez v0, :cond_4

    .line 285
    invoke-static {p3}, Lcom/cyjh/mobileanjian/rpc/Rpc;->arraryToList([Ljava/lang/String;)Ljava/util/List;

    move-result-object v0

    invoke-virtual {v3, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addAllTypes(Ljava/lang/Iterable;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    .line 286
    invoke-static {p4}, Lcom/cyjh/mobileanjian/rpc/Rpc;->arraryToList([Ljava/lang/String;)Ljava/util/List;

    move-result-object v0

    invoke-virtual {v3, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addAllParams(Ljava/lang/Iterable;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    .line 288
    :cond_4
    invoke-static {}, Lcom/cyjh/mobileanjian/rpc/Rpc;->getClient()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v0

    invoke-virtual {v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v2

    invoke-virtual {v0, v2}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 290
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "\u5df2\u7ecf\u8c03\u7528\u4e86SynCall "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "."

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "."

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v2, Lcom/cyjh/mobileanjian/rpc/Rpc;->THE_CLASS:Ljava/lang/Class;

    invoke-static {v0, v2}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 291
    const-string v0, "\u7b49\u5f85\u8fd4\u56de\u7ed3\u679c..."

    sget-object v2, Lcom/cyjh/mobileanjian/rpc/Rpc;->THE_CLASS:Ljava/lang/Class;

    invoke-static {v0, v2}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 293
    :goto_1
    sget-object v0, Lcom/cyjh/mobileanjian/rpc/Rpc;->waits:[Z

    aget-boolean v0, v0, v1

    if-eqz v0, :cond_5

    .line 297
    const-wide/16 v2, 0x5

    :try_start_0
    invoke-static {v2, v3}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 299
    :catch_0
    move-exception v0

    .line 301
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto :goto_1

    .line 304
    :cond_5
    const-string v0, "\u7b49\u5f85\u7ed3\u675f.."

    sget-object v1, Lcom/cyjh/mobileanjian/rpc/Rpc;->THE_CLASS:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 305
    sget-object v0, Lcom/cyjh/mobileanjian/rpc/Rpc;->mRetValue:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    move-result-object v0

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->VOID:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    if-eq v0, v1, :cond_6

    .line 307
    sget-object v0, Lcom/cyjh/mobileanjian/rpc/Rpc$1;->a:[I

    sget-object v1, Lcom/cyjh/mobileanjian/rpc/Rpc;->mRetValue:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    move-result-object v1

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->ordinal()I

    move-result v1

    aget v0, v0, v1

    packed-switch v0, :pswitch_data_0

    .line 326
    :cond_6
    invoke-static {v5}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    goto/16 :goto_0

    .line 310
    :pswitch_0
    sget-object v0, Lcom/cyjh/mobileanjian/rpc/Rpc;->mRetValue:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getValBoolean()Z

    move-result v0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    goto/16 :goto_0

    .line 312
    :pswitch_1
    sget-object v0, Lcom/cyjh/mobileanjian/rpc/Rpc;->mRetValue:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getValInt()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    goto/16 :goto_0

    .line 314
    :pswitch_2
    sget-object v0, Lcom/cyjh/mobileanjian/rpc/Rpc;->mRetValue:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getValLong()J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    goto/16 :goto_0

    .line 316
    :pswitch_3
    sget-object v0, Lcom/cyjh/mobileanjian/rpc/Rpc;->mRetValue:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getValFloat()F

    move-result v0

    invoke-static {v0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v0

    goto/16 :goto_0

    .line 318
    :pswitch_4
    sget-object v0, Lcom/cyjh/mobileanjian/rpc/Rpc;->mRetValue:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getValDouble()D

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v0

    goto/16 :goto_0

    .line 320
    :pswitch_5
    sget-object v0, Lcom/cyjh/mobileanjian/rpc/Rpc;->mRetValue:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getValString()Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    .line 307
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
    .end packed-switch
.end method

.method public static SynCall(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/String;)Z
    .locals 6

    .prologue
    .line 226
    const-string v5, "void"

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    invoke-static/range {v0 .. v5}, Lcom/cyjh/mobileanjian/rpc/Rpc;->SynCall(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;

    .line 227
    const/4 v0, 0x1

    return v0
.end method

.method private static arraryToList([Ljava/lang/String;)Ljava/util/List;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 84
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 85
    array-length v2, p0

    const/4 v0, 0x0

    :goto_0
    if-ge v0, v2, :cond_0

    aget-object v3, p0, v0

    .line 86
    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 85
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 87
    :cond_0
    return-object v1
.end method

.method private static checkArgs([Ljava/lang/String;[Ljava/lang/String;)I
    .locals 2

    .prologue
    .line 64
    invoke-static {p0}, Lcom/cyjh/mobileanjian/ipc/engine/utils/a;->a([Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/a;->a([Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 65
    const/4 v0, 0x1

    .line 70
    :goto_0
    return v0

    .line 66
    :cond_0
    invoke-static {p0}, Lcom/cyjh/mobileanjian/ipc/engine/utils/a;->a([Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/a;->a([Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {p0}, Lcom/cyjh/mobileanjian/ipc/engine/utils/a;->b([Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 67
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/a;->b([Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    array-length v0, p0

    array-length v1, p1

    if-ne v0, v1, :cond_1

    .line 68
    const/4 v0, 0x0

    goto :goto_0

    .line 70
    :cond_1
    const/4 v0, -0x1

    goto :goto_0
.end method

.method private static getAWaitId()I
    .locals 4

    .prologue
    .line 189
    sget-object v1, Lcom/cyjh/mobileanjian/rpc/Rpc;->waits:[Z

    monitor-enter v1

    .line 191
    const/4 v0, 0x0

    :goto_0
    const/16 v2, 0x20

    if-ge v0, v2, :cond_0

    .line 193
    :try_start_0
    sget-object v2, Lcom/cyjh/mobileanjian/rpc/Rpc;->waits:[Z

    aget-boolean v2, v2, v0

    if-nez v2, :cond_1

    .line 195
    sget-object v2, Lcom/cyjh/mobileanjian/rpc/Rpc;->waits:[Z

    const/4 v3, 0x1

    aput-boolean v3, v2, v0

    .line 199
    :cond_0
    monitor-exit v1

    .line 200
    return v0

    .line 191
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 199
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method private static getClient()Lcom/cyjh/mobileanjian/ipc/b/b;
    .locals 1

    .prologue
    .line 50
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/ClientService;->a()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v0

    return-object v0
.end method

.method public static releaseWaitId(I)V
    .locals 2

    .prologue
    .line 205
    if-ltz p0, :cond_0

    const/16 v0, 0x20

    if-gt p0, v0, :cond_0

    .line 206
    sget-object v0, Lcom/cyjh/mobileanjian/rpc/Rpc;->waits:[Z

    const/4 v1, 0x0

    aput-boolean v1, v0, p0

    .line 207
    :cond_0
    return-void
.end method

.method public static setReturnValue(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;)V
    .locals 0

    .prologue
    .line 41
    sput-object p0, Lcom/cyjh/mobileanjian/rpc/Rpc;->mRetValue:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    .line 42
    return-void
.end method
