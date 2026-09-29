.class public final Lcom/cyjh/mobileanjian/ipc/a/a;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static final a:Ljava/lang/Class;

.field private static b:Z = false

.field private static c:Z = false

.field private static d:Z = false

.field private static e:Ljava/lang/String; = null

.field private static f:Ljava/lang/String; = null

.field private static g:Ljava/lang/String; = null

.field private static h:Ljava/lang/String; = null

.field private static i:I = 0x0

.field private static j:I = 0x0

.field private static k:I = 0x0

.field private static l:I = 0x0

.field private static m:Z = false

.field private static n:Z = false

.field private static o:Ljava/lang/String; = null

.field private static p:Ljava/lang/String; = null

.field private static final q:Ljava/lang/String; = "MobileAnjian"

.field private static final r:Ljava/lang/String; = "ServerTemp"

.field private static final s:Ljava/lang/String; = "Script"

.field private static t:Ljava/lang/String; = null

.field private static final u:I

.field private static final v:Ljava/lang/String;

.field private static final w:Ljava/lang/String;

.field private static final x:Ljava/lang/String;

.field private static final y:Ljava/lang/String; = "com.cyjh.mobileanjian"

.field private static z:Z


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 12
    const-class v0, Lcom/cyjh/mobileanjian/ipc/a/a;

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/a/a;->a:Ljava/lang/Class;

    .line 13
    sput-boolean v2, Lcom/cyjh/mobileanjian/ipc/a/a;->b:Z

    .line 14
    sput-boolean v2, Lcom/cyjh/mobileanjian/ipc/a/a;->c:Z

    .line 15
    sput-boolean v3, Lcom/cyjh/mobileanjian/ipc/a/a;->d:Z

    .line 18
    sput-object v1, Lcom/cyjh/mobileanjian/ipc/a/a;->e:Ljava/lang/String;

    .line 19
    sput-object v1, Lcom/cyjh/mobileanjian/ipc/a/a;->f:Ljava/lang/String;

    .line 20
    sput-object v1, Lcom/cyjh/mobileanjian/ipc/a/a;->g:Ljava/lang/String;

    .line 21
    sput-object v1, Lcom/cyjh/mobileanjian/ipc/a/a;->h:Ljava/lang/String;

    .line 22
    sput v2, Lcom/cyjh/mobileanjian/ipc/a/a;->i:I

    .line 23
    sput v2, Lcom/cyjh/mobileanjian/ipc/a/a;->j:I

    .line 24
    sput v2, Lcom/cyjh/mobileanjian/ipc/a/a;->k:I

    .line 28
    sput-boolean v3, Lcom/cyjh/mobileanjian/ipc/a/a;->n:Z

    .line 30
    sput-object v1, Lcom/cyjh/mobileanjian/ipc/a/a;->o:Ljava/lang/String;

    .line 31
    sput-object v1, Lcom/cyjh/mobileanjian/ipc/a/a;->p:Ljava/lang/String;

    .line 35
    sput-object v1, Lcom/cyjh/mobileanjian/ipc/a/a;->t:Ljava/lang/String;

    .line 38
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    sput v0, Lcom/cyjh/mobileanjian/ipc/a/a;->u:I

    .line 39
    sget-object v0, Landroid/os/Build;->BRAND:Ljava/lang/String;

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/a/a;->v:Ljava/lang/String;

    .line 40
    sget-object v0, Landroid/os/Build;->MODEL:Ljava/lang/String;

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/a/a;->w:Ljava/lang/String;

    .line 41
    sget-object v0, Landroid/os/Build;->ID:Ljava/lang/String;

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/a/a;->x:Ljava/lang/String;

    .line 44
    sput-boolean v2, Lcom/cyjh/mobileanjian/ipc/a/a;->z:Z

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a(I)V
    .locals 0

    .prologue
    .line 96
    sput p0, Lcom/cyjh/mobileanjian/ipc/a/a;->j:I

    .line 97
    return-void
.end method

.method public static a(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 60
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/a/a;->f:Ljava/lang/String;

    .line 61
    return-void
.end method

.method public static a(Z)V
    .locals 0

    .prologue
    .line 220
    sput-boolean p0, Lcom/cyjh/mobileanjian/ipc/a/a;->m:Z

    .line 221
    return-void
.end method

.method public static a()Z
    .locals 1

    .prologue
    .line 48
    sget-boolean v0, Lcom/cyjh/mobileanjian/ipc/a/a;->b:Z

    return v0
.end method

.method public static b()V
    .locals 1

    .prologue
    .line 52
    const/4 v0, 0x1

    sput-boolean v0, Lcom/cyjh/mobileanjian/ipc/a/a;->b:Z

    .line 53
    return-void
.end method

.method public static b(I)V
    .locals 0

    .prologue
    .line 104
    sput p0, Lcom/cyjh/mobileanjian/ipc/a/a;->k:I

    .line 105
    return-void
.end method

.method public static b(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 68
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/a/a;->e:Ljava/lang/String;

    .line 69
    return-void
.end method

.method public static b(Z)V
    .locals 0

    .prologue
    .line 253
    sput-boolean p0, Lcom/cyjh/mobileanjian/ipc/a/a;->z:Z

    .line 254
    return-void
.end method

.method public static c()Ljava/lang/String;
    .locals 1

    .prologue
    .line 56
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/a/a;->f:Ljava/lang/String;

    return-object v0
.end method

.method public static c(I)V
    .locals 0

    .prologue
    .line 108
    sput p0, Lcom/cyjh/mobileanjian/ipc/a/a;->l:I

    .line 109
    return-void
.end method

.method public static c(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 76
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/a/a;->g:Ljava/lang/String;

    .line 77
    return-void
.end method

.method public static d()Ljava/lang/String;
    .locals 1

    .prologue
    .line 64
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/a/a;->e:Ljava/lang/String;

    return-object v0
.end method

.method public static d(I)V
    .locals 0

    .prologue
    .line 116
    sput p0, Lcom/cyjh/mobileanjian/ipc/a/a;->i:I

    .line 117
    return-void
.end method

.method public static d(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 84
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/a/a;->h:Ljava/lang/String;

    .line 85
    return-void
.end method

.method public static e()Ljava/lang/String;
    .locals 1

    .prologue
    .line 72
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/a/a;->g:Ljava/lang/String;

    return-object v0
.end method

.method public static e(Ljava/lang/String;)V
    .locals 4

    .prologue
    .line 173
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/a/a;->o:Ljava/lang/String;

    .line 174
    new-instance v0, Ljava/io/File;

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/a/a;->o:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "MobileAnjian"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "Script"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 175
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/a/a;->o:Ljava/lang/String;

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/a/a;->p:Ljava/lang/String;

    .line 176
    const/4 v0, 0x1

    sput-boolean v0, Lcom/cyjh/mobileanjian/ipc/a/a;->c:Z

    .line 178
    :cond_0
    return-void
.end method

.method public static f()Ljava/lang/String;
    .locals 1

    .prologue
    .line 80
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/a/a;->h:Ljava/lang/String;

    return-object v0
.end method

.method public static f(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 182
    sget-boolean v0, Lcom/cyjh/mobileanjian/ipc/a/a;->c:Z

    if-eqz v0, :cond_0

    .line 185
    :goto_0
    return-object p0

    :cond_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/a/a;->o:Ljava/lang/String;

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/a/a;->p:Ljava/lang/String;

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p0

    goto :goto_0
.end method

.method public static g()I
    .locals 1

    .prologue
    .line 88
    sget v0, Lcom/cyjh/mobileanjian/ipc/a/a;->i:I

    return v0
.end method

.method public static g(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 231
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/a/a;->t:Ljava/lang/String;

    .line 232
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/a/a;->t:Ljava/lang/String;

    const-string v1, "com.cyjh.mobileanjian"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 233
    const/4 v0, 0x0

    sput-boolean v0, Lcom/cyjh/mobileanjian/ipc/a/a;->d:Z

    .line 234
    :cond_0
    return-void
.end method

.method public static h()I
    .locals 1

    .prologue
    .line 92
    sget v0, Lcom/cyjh/mobileanjian/ipc/a/a;->j:I

    return v0
.end method

.method public static i()I
    .locals 1

    .prologue
    .line 100
    sget v0, Lcom/cyjh/mobileanjian/ipc/a/a;->k:I

    return v0
.end method

.method public static j()I
    .locals 1

    .prologue
    .line 112
    sget v0, Lcom/cyjh/mobileanjian/ipc/a/a;->l:I

    return v0
.end method

.method public static k()I
    .locals 1

    .prologue
    .line 121
    sget v0, Lcom/cyjh/mobileanjian/ipc/a/a;->u:I

    return v0
.end method

.method public static l()Ljava/lang/String;
    .locals 1

    .prologue
    .line 125
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/a/a;->v:Ljava/lang/String;

    return-object v0
.end method

.method public static m()Ljava/lang/String;
    .locals 1

    .prologue
    .line 129
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/a/a;->w:Ljava/lang/String;

    return-object v0
.end method

.method public static n()Ljava/lang/String;
    .locals 1

    .prologue
    .line 133
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/a/a;->x:Ljava/lang/String;

    return-object v0
.end method

.method public static o()Ljava/lang/String;
    .locals 8

    .prologue
    const/4 v1, 0x0

    .line 138
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/a/a;->p:Ljava/lang/String;

    if-nez v0, :cond_1

    .line 140
    const/4 v0, 0x2

    new-array v2, v0, [Ljava/lang/String;

    const-string v0, "EXTERNAL_STORAGE"

    invoke-static {v0}, Ljava/lang/System;->getenv(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    aput-object v0, v2, v1

    const/4 v0, 0x1

    const-string v3, "SECONDARY_STORAGE"

    .line 141
    invoke-static {v3}, Ljava/lang/System;->getenv(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v0

    .line 144
    array-length v3, v2

    move v0, v1

    :goto_0
    if-ge v0, v3, :cond_0

    aget-object v4, v2, v0

    .line 146
    if-eqz v4, :cond_2

    .line 148
    new-instance v5, Ljava/io/File;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    sget-object v7, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "MobileAnjian"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    sget-object v7, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "Script"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5}, Ljava/io/File;->exists()Z

    move-result v5

    if-eqz v5, :cond_2

    .line 150
    sput-object v4, Lcom/cyjh/mobileanjian/ipc/a/a;->p:Ljava/lang/String;

    .line 155
    :cond_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/a/a;->p:Ljava/lang/String;

    if-nez v0, :cond_1

    .line 157
    aget-object v0, v2, v1

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/a/a;->p:Ljava/lang/String;

    .line 158
    sput-boolean v1, Lcom/cyjh/mobileanjian/ipc/a/a;->n:Z

    .line 159
    const-string v0, "NO available SD CARD path."

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/a/a;->a:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->e(Ljava/lang/String;Ljava/lang/Class;)V

    .line 163
    :cond_1
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/a/a;->p:Ljava/lang/String;

    return-object v0

    .line 144
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method

.method public static p()Z
    .locals 1

    .prologue
    .line 168
    sget-boolean v0, Lcom/cyjh/mobileanjian/ipc/a/a;->n:Z

    return v0
.end method

.method public static q()Ljava/lang/String;
    .locals 2

    .prologue
    .line 191
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->u()Ljava/lang/String;

    move-result-object v0

    const-string v1, "com.cyjh.mobileanjian"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 192
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->o()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "MobileAnjian"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 196
    :goto_0
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_0

    .line 197
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->mkdirs()Z

    .line 198
    :cond_0
    return-object v0

    .line 194
    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->o()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->u()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public static r()Ljava/lang/String;
    .locals 2

    .prologue
    .line 207
    sget-boolean v0, Lcom/cyjh/mobileanjian/ipc/a/a;->d:Z

    if-eqz v0, :cond_0

    .line 208
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->q()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "ServerTemp"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 210
    :goto_0
    return-object v0

    :cond_0
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->o()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public static s()Z
    .locals 1

    .prologue
    .line 215
    sget-boolean v0, Lcom/cyjh/mobileanjian/ipc/a/a;->m:Z

    return v0
.end method

.method public static t()Z
    .locals 1

    .prologue
    .line 226
    sget-boolean v0, Lcom/cyjh/mobileanjian/ipc/a/a;->d:Z

    return v0
.end method

.method public static u()Ljava/lang/String;
    .locals 1

    .prologue
    .line 238
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/a/a;->t:Ljava/lang/String;

    return-object v0
.end method

.method public static v()Ljava/lang/String;
    .locals 2

    .prologue
    .line 243
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "/data/data/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->u()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "files"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static w()Ljava/lang/String;
    .locals 2

    .prologue
    .line 248
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "/data/data/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->u()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "lib"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static x()Z
    .locals 1

    .prologue
    .line 258
    sget-boolean v0, Lcom/cyjh/mobileanjian/ipc/a/a;->z:Z

    return v0
.end method

.method public static y()V
    .locals 2

    .prologue
    .line 264
    const-string v0, "----------BEGIN DEVICE INFORMATEION---------"

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/a/a;->a:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 265
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\tBrand: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->l()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/a/a;->a:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 266
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\tModel: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->m()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/a/a;->a:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 267
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\tAPI Level: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->k()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/a/a;->a:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 268
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\tAndroid ID: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->n()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/a/a;->a:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 270
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\tIMEI: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->d()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/a/a;->a:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 271
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\tMAC address: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->c()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/a/a;->a:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 272
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\tDefault IM: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->e()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/a/a;->a:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 273
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\tMy IM: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->f()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/a/a;->a:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 274
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\tAPK SD: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/a/a;->o:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/a/a;->a:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 275
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\tSD Path: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->o()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/a/a;->a:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 276
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\trotation status: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->g()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/a/a;->a:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 279
    const-string v0, "----------ENDDEVICE INFORMATEION---------"

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/a/a;->a:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 280
    return-void
.end method

.method public static z()Ljava/lang/String;
    .locals 2

    .prologue
    .line 284
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Brand: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->l()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\r\nModel: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 285
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->m()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\r\nAPK SD: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/a/a;->o:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\r\nSD Path: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 287
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->o()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\r\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 284
    return-object v0
.end method
