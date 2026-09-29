.class public Lcom/cyjh/mobileanjian/ipc/h;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static final a:Ljava/lang/String; = "start_eventsrv"

.field public static final b:Ljava/lang/String; = "start_eventsrvR"

.field public static final c:Ljava/lang/String; = ".event.localserver"

.field public static final d:Ljava/lang/String;

.field public static final e:Ljava/lang/String; = "libmqm.so"

.field private static f:Landroid/app/Application;

.field private static g:Lcom/cyjh/mobileanjian/ipc/interfaces/OnKeyEventListener;

.field private static h:Lcom/cyjh/mobileanjian/ipc/interfaces/RootProgressListener;

.field private static i:Lcom/cyjh/mobileanjian/ipc/interfaces/OnEngineStartCallback;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 22
    const-class v0, Lcom/cyjh/mobileanjian/ipc/ClientService;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/h;->d:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a()Landroid/app/Application;
    .locals 1

    .prologue
    .line 45
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/h;->f:Landroid/app/Application;

    return-object v0
.end method

.method public static a(Landroid/app/Application;Lcom/cyjh/mobileanjian/ipc/interfaces/OnKeyEventListener;Lcom/cyjh/mobileanjian/ipc/interfaces/RootProgressListener;Lcom/cyjh/mobileanjian/ipc/interfaces/OnEngineStartCallback;)V
    .locals 2

    .prologue
    .line 34
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/h;->f:Landroid/app/Application;

    .line 35
    sput-object p1, Lcom/cyjh/mobileanjian/ipc/h;->g:Lcom/cyjh/mobileanjian/ipc/interfaces/OnKeyEventListener;

    .line 36
    sput-object p2, Lcom/cyjh/mobileanjian/ipc/h;->h:Lcom/cyjh/mobileanjian/ipc/interfaces/RootProgressListener;

    .line 37
    sput-object p3, Lcom/cyjh/mobileanjian/ipc/h;->i:Lcom/cyjh/mobileanjian/ipc/interfaces/OnEngineStartCallback;

    .line 39
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/cyjh/mobileanjian/ipc/IpcService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 40
    invoke-virtual {p0, v0}, Landroid/app/Application;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    .line 41
    return-void
.end method

.method public static b()Landroid/content/Context;
    .locals 1

    .prologue
    .line 50
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/h;->f:Landroid/app/Application;

    invoke-virtual {v0}, Landroid/app/Application;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    return-object v0
.end method

.method public static c()Ljava/io/File;
    .locals 3

    .prologue
    .line 55
    new-instance v0, Ljava/io/File;

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/h;->f:Landroid/app/Application;

    invoke-virtual {v1}, Landroid/app/Application;->getFilesDir()Ljava/io/File;

    move-result-object v1

    const-string v2, "start_eventsrv"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    return-object v0
.end method

.method public static d()Ljava/io/File;
    .locals 3

    .prologue
    .line 60
    new-instance v0, Ljava/io/File;

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/h;->f:Landroid/app/Application;

    invoke-virtual {v1}, Landroid/app/Application;->getFilesDir()Ljava/io/File;

    move-result-object v1

    const-string v2, "start_eventsrvR"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    return-object v0
.end method

.method public static e()Lcom/cyjh/mobileanjian/ipc/interfaces/OnKeyEventListener;
    .locals 1

    .prologue
    .line 65
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/h;->g:Lcom/cyjh/mobileanjian/ipc/interfaces/OnKeyEventListener;

    return-object v0
.end method

.method public static f()Lcom/cyjh/mobileanjian/ipc/interfaces/RootProgressListener;
    .locals 1

    .prologue
    .line 70
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/h;->h:Lcom/cyjh/mobileanjian/ipc/interfaces/RootProgressListener;

    return-object v0
.end method

.method public static g()Lcom/cyjh/mobileanjian/ipc/interfaces/OnEngineStartCallback;
    .locals 1

    .prologue
    .line 75
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/h;->i:Lcom/cyjh/mobileanjian/ipc/interfaces/OnEngineStartCallback;

    return-object v0
.end method
