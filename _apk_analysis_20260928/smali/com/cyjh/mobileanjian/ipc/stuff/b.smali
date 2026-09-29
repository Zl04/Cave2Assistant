.class public final Lcom/cyjh/mobileanjian/ipc/stuff/b;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static a:Z

.field private static b:Ljava/lang/String;

.field private static c:Ljava/lang/String;

.field private static d:Ljava/lang/String;

.field private static e:Ljava/lang/String;

.field private static f:Ljava/lang/String;

.field private static g:I

.field private static h:I

.field private static i:I

.field private static j:I

.field private static k:Z

.field private static l:Ljava/lang/String;

.field private static m:Ljava/lang/String;

.field private static final n:I

.field private static final o:Ljava/lang/String;

.field private static final p:Ljava/lang/String;

.field private static final q:Ljava/lang/String;

.field private static final r:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const/4 v0, 0x0

    const/4 v1, 0x0

    .line 10
    sput-boolean v0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->a:Z

    .line 13
    sput-object v1, Lcom/cyjh/mobileanjian/ipc/stuff/b;->b:Ljava/lang/String;

    .line 14
    sput-object v1, Lcom/cyjh/mobileanjian/ipc/stuff/b;->c:Ljava/lang/String;

    .line 15
    sput-object v1, Lcom/cyjh/mobileanjian/ipc/stuff/b;->d:Ljava/lang/String;

    .line 16
    sput-object v1, Lcom/cyjh/mobileanjian/ipc/stuff/b;->e:Ljava/lang/String;

    .line 17
    sput-object v1, Lcom/cyjh/mobileanjian/ipc/stuff/b;->f:Ljava/lang/String;

    .line 18
    sput v0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->g:I

    .line 19
    sput v0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->h:I

    .line 20
    sput v0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->i:I

    .line 22
    const/16 v0, 0x8fc

    sput v0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->j:I

    .line 26
    const-string v0, ""

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->l:Ljava/lang/String;

    .line 27
    sput-object v1, Lcom/cyjh/mobileanjian/ipc/stuff/b;->m:Ljava/lang/String;

    .line 29
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    sput v0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->n:I

    .line 30
    sget-object v0, Landroid/os/Build;->BRAND:Ljava/lang/String;

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->o:Ljava/lang/String;

    .line 31
    sget-object v0, Landroid/os/Build;->MODEL:Ljava/lang/String;

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->p:Ljava/lang/String;

    .line 32
    sget-object v0, Landroid/os/Build;->ID:Ljava/lang/String;

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->q:Ljava/lang/String;

    .line 33
    sget-object v0, Landroid/os/Build;->CPU_ABI:Ljava/lang/String;

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->r:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a(I)V
    .locals 0

    .prologue
    .line 82
    sput p0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->g:I

    .line 83
    return-void
.end method

.method public static a(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 50
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->c:Ljava/lang/String;

    .line 51
    return-void
.end method

.method public static a(Z)V
    .locals 0

    .prologue
    .line 154
    sput-boolean p0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->k:Z

    .line 155
    return-void
.end method

.method public static a()Z
    .locals 1

    .prologue
    .line 38
    sget-boolean v0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->a:Z

    return v0
.end method

.method public static b()V
    .locals 1

    .prologue
    .line 42
    const/4 v0, 0x1

    sput-boolean v0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->a:Z

    .line 43
    return-void
.end method

.method public static b(I)V
    .locals 0

    .prologue
    .line 90
    sput p0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->h:I

    .line 91
    return-void
.end method

.method public static b(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 58
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->b:Ljava/lang/String;

    .line 59
    return-void
.end method

.method public static c()Ljava/lang/String;
    .locals 1

    .prologue
    .line 46
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->c:Ljava/lang/String;

    return-object v0
.end method

.method public static c(I)V
    .locals 0

    .prologue
    .line 98
    sput p0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->i:I

    .line 99
    return-void
.end method

.method public static c(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 66
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->d:Ljava/lang/String;

    .line 67
    return-void
.end method

.method public static d()Ljava/lang/String;
    .locals 1

    .prologue
    .line 54
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->b:Ljava/lang/String;

    return-object v0
.end method

.method public static d(I)V
    .locals 0

    .prologue
    .line 169
    sput p0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->j:I

    .line 170
    return-void
.end method

.method public static d(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 74
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->e:Ljava/lang/String;

    .line 75
    return-void
.end method

.method public static e()Ljava/lang/String;
    .locals 1

    .prologue
    .line 62
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->d:Ljava/lang/String;

    return-object v0
.end method

.method public static e(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 132
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->f:Ljava/lang/String;

    .line 133
    return-void
.end method

.method public static f()Ljava/lang/String;
    .locals 1

    .prologue
    .line 70
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->e:Ljava/lang/String;

    return-object v0
.end method

.method public static f(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 137
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->l:Ljava/lang/String;

    .line 138
    return-void
.end method

.method public static g()I
    .locals 1

    .prologue
    .line 78
    sget v0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->g:I

    return v0
.end method

.method public static g(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 141
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->m:Ljava/lang/String;

    .line 142
    return-void
.end method

.method public static h()I
    .locals 1

    .prologue
    .line 86
    sget v0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->h:I

    return v0
.end method

.method public static i()I
    .locals 1

    .prologue
    .line 94
    sget v0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->i:I

    return v0
.end method

.method public static j()I
    .locals 1

    .prologue
    .line 102
    sget v0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->n:I

    return v0
.end method

.method public static k()Ljava/lang/String;
    .locals 1

    .prologue
    .line 106
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->o:Ljava/lang/String;

    return-object v0
.end method

.method public static l()Ljava/lang/String;
    .locals 1

    .prologue
    .line 110
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->p:Ljava/lang/String;

    return-object v0
.end method

.method public static m()Ljava/lang/String;
    .locals 1

    .prologue
    .line 114
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->q:Ljava/lang/String;

    return-object v0
.end method

.method public static n()Ljava/lang/String;
    .locals 1

    .prologue
    .line 118
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->r:Ljava/lang/String;

    return-object v0
.end method

.method public static o()Z
    .locals 1

    .prologue
    .line 123
    sget v0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->j:I

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static p()Ljava/lang/String;
    .locals 1

    .prologue
    .line 128
    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static q()Ljava/lang/String;
    .locals 1

    .prologue
    .line 145
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->l:Ljava/lang/String;

    return-object v0
.end method

.method public static r()Ljava/lang/String;
    .locals 1

    .prologue
    .line 149
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->m:Ljava/lang/String;

    return-object v0
.end method

.method public static s()Z
    .locals 1

    .prologue
    .line 159
    sget-boolean v0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->k:Z

    return v0
.end method

.method public static t()I
    .locals 1

    .prologue
    .line 164
    sget v0, Lcom/cyjh/mobileanjian/ipc/stuff/b;->j:I

    return v0
.end method

.method public static u()V
    .locals 2

    .prologue
    .line 176
    const-string v0, "----------BEGIN DEVICE INFORMATEION---------"

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 177
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\tBrand: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/stuff/b;->k()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 178
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\tModel: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/stuff/b;->l()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 179
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\tAPI Level: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/stuff/b;->j()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 180
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\tAndroid ID: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/stuff/b;->m()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 181
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\tCPU ABI: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/stuff/b;->n()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 183
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\tIMEI: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/stuff/b;->d()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 184
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\tMAC address: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/stuff/b;->c()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 185
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\tDefault IM: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/stuff/b;->e()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 186
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\tMy IM: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/stuff/b;->f()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 187
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\trotation status: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/stuff/b;->g()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 190
    const-string v0, "----------ENDDEVICE INFORMATEION---------"

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 191
    return-void
.end method

.method public static v()Ljava/lang/String;
    .locals 2

    .prologue
    .line 195
    const-string v0, "==== \u8bbe\u5907\u4fe1\u606f ===="

    .line 196
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n\u54c1\u724c: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 197
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/stuff/b;->k()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n\u578b\u53f7: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 198
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/stuff/b;->l()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\nIMEI: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 199
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/stuff/b;->d()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\nMAC\u5730\u5740: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 200
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/stuff/b;->c()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n\u5206\u8fa8\u7387: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 201
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/stuff/b;->h()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/stuff/b;->i()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n\n\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 196
    return-object v0
.end method
