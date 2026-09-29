.class public Lcom/lidroid/xutils/view/EventListenerManager;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lidroid/xutils/view/EventListenerManager$DynamicHandler;
    }
.end annotation


# static fields
.field private static final listenerCache:Lcom/lidroid/xutils/util/DoubleKeyValueMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/lidroid/xutils/util/DoubleKeyValueMap",
            "<",
            "Lcom/lidroid/xutils/view/ViewInjectInfo;",
            "Ljava/lang/Class",
            "<*>;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 41
    new-instance v0, Lcom/lidroid/xutils/util/DoubleKeyValueMap;

    invoke-direct {v0}, Lcom/lidroid/xutils/util/DoubleKeyValueMap;-><init>()V

    .line 40
    sput-object v0, Lcom/lidroid/xutils/view/EventListenerManager;->listenerCache:Lcom/lidroid/xutils/util/DoubleKeyValueMap;

    .line 41
    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 33
    return-void
.end method

.method public static addEventMethod(Lcom/lidroid/xutils/view/ViewFinder;Lcom/lidroid/xutils/view/ViewInjectInfo;Ljava/lang/annotation/Annotation;Ljava/lang/Object;Ljava/lang/reflect/Method;)V
    .locals 7

    .prologue
    const/4 v2, 0x0

    .line 50
    :try_start_0
    invoke-virtual {p0, p1}, Lcom/lidroid/xutils/view/ViewFinder;->findViewByInfo(Lcom/lidroid/xutils/view/ViewInjectInfo;)Landroid/view/View;

    move-result-object v3

    .line 51
    if-eqz v3, :cond_1

    .line 52
    invoke-interface {p2}, Ljava/lang/annotation/Annotation;->annotationType()Ljava/lang/Class;

    move-result-object v0

    const-class v1, Lcom/lidroid/xutils/view/annotation/event/EventBase;

    invoke-virtual {v0, v1}, Ljava/lang/Class;->getAnnotation(Ljava/lang/Class;)Ljava/lang/annotation/Annotation;

    move-result-object v0

    check-cast v0, Lcom/lidroid/xutils/view/annotation/event/EventBase;

    .line 53
    invoke-interface {v0}, Lcom/lidroid/xutils/view/annotation/event/EventBase;->listenerType()Ljava/lang/Class;

    move-result-object v4

    .line 54
    invoke-interface {v0}, Lcom/lidroid/xutils/view/annotation/event/EventBase;->listenerSetter()Ljava/lang/String;

    move-result-object v5

    .line 55
    invoke-interface {v0}, Lcom/lidroid/xutils/view/annotation/event/EventBase;->methodName()Ljava/lang/String;

    move-result-object v6

    .line 58
    sget-object v0, Lcom/lidroid/xutils/view/EventListenerManager;->listenerCache:Lcom/lidroid/xutils/util/DoubleKeyValueMap;

    invoke-virtual {v0, p1, v4}, Lcom/lidroid/xutils/util/DoubleKeyValueMap;->get(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 60
    if-eqz v1, :cond_3

    .line 61
    invoke-static {v1}, Ljava/lang/reflect/Proxy;->getInvocationHandler(Ljava/lang/Object;)Ljava/lang/reflect/InvocationHandler;

    move-result-object v0

    check-cast v0, Lcom/lidroid/xutils/view/EventListenerManager$DynamicHandler;

    .line 62
    invoke-virtual {v0}, Lcom/lidroid/xutils/view/EventListenerManager$DynamicHandler;->getHandler()Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {p3, v2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v2

    .line 63
    if-eqz v2, :cond_0

    .line 64
    invoke-virtual {v0, v6, p4}, Lcom/lidroid/xutils/view/EventListenerManager$DynamicHandler;->addMethod(Ljava/lang/String;Ljava/lang/reflect/Method;)V

    :cond_0
    move v0, v2

    .line 67
    :goto_0
    if-nez v0, :cond_2

    .line 68
    new-instance v0, Lcom/lidroid/xutils/view/EventListenerManager$DynamicHandler;

    invoke-direct {v0, p3}, Lcom/lidroid/xutils/view/EventListenerManager$DynamicHandler;-><init>(Ljava/lang/Object;)V

    .line 69
    invoke-virtual {v0, v6, p4}, Lcom/lidroid/xutils/view/EventListenerManager$DynamicHandler;->addMethod(Ljava/lang/String;Ljava/lang/reflect/Method;)V

    .line 71
    invoke-virtual {v4}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v1

    .line 72
    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Class;

    const/4 v6, 0x0

    aput-object v4, v2, v6

    .line 70
    invoke-static {v1, v2, v0}, Ljava/lang/reflect/Proxy;->newProxyInstance(Ljava/lang/ClassLoader;[Ljava/lang/Class;Ljava/lang/reflect/InvocationHandler;)Ljava/lang/Object;

    move-result-object v0

    .line 75
    sget-object v1, Lcom/lidroid/xutils/view/EventListenerManager;->listenerCache:Lcom/lidroid/xutils/util/DoubleKeyValueMap;

    invoke-virtual {v1, p1, v4, v0}, Lcom/lidroid/xutils/util/DoubleKeyValueMap;->put(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 78
    :goto_1
    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Class;

    const/4 v6, 0x0

    aput-object v4, v2, v6

    invoke-virtual {v1, v5, v2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 79
    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object v0, v2, v4

    invoke-virtual {v1, v3, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 84
    :cond_1
    :goto_2
    return-void

    .line 81
    :catch_0
    move-exception v0

    .line 82
    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Lcom/lidroid/xutils/util/LogUtils;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_2

    :cond_2
    move-object v0, v1

    goto :goto_1

    :cond_3
    move v0, v2

    goto :goto_0
.end method
