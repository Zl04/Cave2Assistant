.class public Lcom/cyjh/mobileanjian/ipc/utils/l;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static final a:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Class;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 23
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/utils/l$1;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/utils/l$1;-><init>()V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/utils/l;->a:Ljava/util/HashMap;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;
    .locals 4

    .prologue
    .line 78
    const/4 v0, 0x0

    .line 81
    :try_start_0
    sget-object v1, Lcom/cyjh/mobileanjian/ipc/utils/j;->j:Lcom/cyjh/mobileanjian/ipc/utils/g;

    invoke-virtual {v1, p0}, Lcom/cyjh/mobileanjian/ipc/utils/g;->a(Ljava/lang/Class;)I

    move-result v1

    packed-switch v1, :pswitch_data_0

    :goto_0
    :pswitch_0
    move-object p1, v0

    .line 116
    :cond_0
    :goto_1
    return-object p1

    .line 84
    :pswitch_1
    invoke-static {p1}, Ljava/lang/Boolean;->parseBoolean(Ljava/lang/String;)Z

    move-result v1

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    goto :goto_1

    .line 87
    :pswitch_2
    invoke-static {p1}, Ljava/lang/Byte;->parseByte(Ljava/lang/String;)B

    move-object p1, v0

    .line 88
    goto :goto_1

    .line 90
    :pswitch_3
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_1

    const/4 v1, 0x0

    invoke-virtual {p1, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    :goto_2
    invoke-static {v1}, Ljava/lang/Character;->valueOf(C)Ljava/lang/Character;

    move-result-object p1

    goto :goto_1

    :cond_1
    const/16 v1, 0x20

    goto :goto_2

    .line 93
    :pswitch_4
    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    goto :goto_1

    .line 96
    :pswitch_5
    invoke-static {p1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    goto :goto_1

    .line 99
    :pswitch_6
    invoke-static {p1}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v1

    invoke-static {v1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object p1

    goto :goto_1

    .line 102
    :pswitch_7
    invoke-static {p1}, Ljava/lang/Double;->parseDouble(Ljava/lang/String;)D

    move-object p1, v0

    .line 103
    goto :goto_1

    .line 105
    :pswitch_8
    if-nez p1, :cond_0

    const-string p1, ""
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 111
    :catch_0
    move-exception v1

    .line 113
    invoke-virtual {v1}, Ljava/lang/NumberFormatException;->printStackTrace()V

    goto :goto_0

    .line 81
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_3
        :pswitch_2
        :pswitch_4
        :pswitch_5
        :pswitch_6
        :pswitch_7
        :pswitch_0
        :pswitch_8
    .end packed-switch
.end method

.method public static a(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;
    .locals 2

    .prologue
    const/4 v0, 0x0

    .line 38
    .line 40
    sget-object v1, Lcom/cyjh/mobileanjian/ipc/utils/j;->j:Lcom/cyjh/mobileanjian/ipc/utils/g;

    invoke-virtual {v1, p0}, Lcom/cyjh/mobileanjian/ipc/utils/g;->b(Ljava/lang/String;)I

    move-result v1

    packed-switch v1, :pswitch_data_0

    .line 70
    :cond_0
    :goto_0
    :pswitch_0
    return-object v0

    .line 43
    :pswitch_1
    invoke-static {p1}, Ljava/lang/Boolean;->parseBoolean(Ljava/lang/String;)Z

    move-result v0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    goto :goto_0

    .line 46
    :pswitch_2
    invoke-static {p1}, Ljava/lang/Byte;->parseByte(Ljava/lang/String;)B

    goto :goto_0

    .line 49
    :pswitch_3
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_0

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v0}, Ljava/lang/Character;->valueOf(C)Ljava/lang/Character;

    move-result-object v0

    goto :goto_0

    .line 52
    :pswitch_4
    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    goto :goto_0

    .line 55
    :pswitch_5
    invoke-static {p1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    goto :goto_0

    .line 58
    :pswitch_6
    invoke-static {p1}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v0

    invoke-static {v0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v0

    goto :goto_0

    .line 61
    :pswitch_7
    invoke-static {p1}, Ljava/lang/Double;->parseDouble(Ljava/lang/String;)D

    goto :goto_0

    :pswitch_8
    move-object v0, p1

    .line 65
    goto :goto_0

    .line 40
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_3
        :pswitch_2
        :pswitch_4
        :pswitch_5
        :pswitch_6
        :pswitch_7
        :pswitch_0
        :pswitch_8
    .end packed-switch
.end method

.method public static a(Ljava/util/List;Ljava/util/List;)[Ljava/lang/Object;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;)[",
            "Ljava/lang/Object;"
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 150
    if-eqz p0, :cond_0

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    move-object v0, v2

    .line 161
    :goto_0
    return-object v0

    .line 153
    :cond_1
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v5

    .line 154
    new-array v3, v5, [Ljava/lang/Object;

    .line 155
    const/4 v0, 0x0

    move v4, v0

    :goto_1
    if-ge v4, v5, :cond_3

    .line 157
    invoke-interface {p0, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-interface {p1, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/utils/l;->a(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    aput-object v0, v3, v4

    if-nez v0, :cond_2

    move-object v0, v2

    .line 158
    goto :goto_0

    .line 155
    :cond_2
    add-int/lit8 v0, v4, 0x1

    move v4, v0

    goto :goto_1

    :cond_3
    move-object v0, v3

    .line 161
    goto :goto_0
.end method

.method public static a([Ljava/lang/Class;[Ljava/lang/String;)[Ljava/lang/Object;
    .locals 5

    .prologue
    const/4 v1, 0x0

    .line 136
    if-eqz p0, :cond_0

    array-length v0, p0

    if-nez v0, :cond_1

    :cond_0
    move-object v0, v1

    .line 145
    :goto_0
    return-object v0

    .line 139
    :cond_1
    array-length v0, p0

    new-array v2, v0, [Ljava/lang/Object;

    .line 140
    const/4 v0, 0x0

    :goto_1
    array-length v3, p0

    if-ge v0, v3, :cond_3

    .line 142
    aget-object v3, p0, v0

    aget-object v4, p1, v0

    invoke-static {v3, v4}, Lcom/cyjh/mobileanjian/ipc/utils/l;->a(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    aput-object v3, v2, v0

    if-nez v3, :cond_2

    move-object v0, v1

    .line 143
    goto :goto_0

    .line 140
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_3
    move-object v0, v2

    .line 145
    goto :goto_0
.end method

.method public static a([Ljava/lang/String;[Ljava/lang/String;)[Ljava/lang/Object;
    .locals 5

    .prologue
    const/4 v1, 0x0

    .line 121
    if-eqz p0, :cond_0

    array-length v0, p0

    if-nez v0, :cond_1

    :cond_0
    move-object v0, v1

    .line 131
    :goto_0
    return-object v0

    .line 124
    :cond_1
    array-length v0, p0

    new-array v2, v0, [Ljava/lang/Object;

    .line 125
    const/4 v0, 0x0

    :goto_1
    array-length v3, p0

    if-ge v0, v3, :cond_3

    .line 127
    aget-object v3, p0, v0

    aget-object v4, p1, v0

    invoke-static {v3, v4}, Lcom/cyjh/mobileanjian/ipc/utils/l;->a(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    aput-object v3, v2, v0

    if-nez v3, :cond_2

    move-object v0, v1

    .line 128
    goto :goto_0

    .line 125
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_3
    move-object v0, v2

    .line 131
    goto :goto_0
.end method
