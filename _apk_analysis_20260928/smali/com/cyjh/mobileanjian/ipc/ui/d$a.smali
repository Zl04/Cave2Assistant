.class Lcom/cyjh/mobileanjian/ipc/ui/d$a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/cyjh/mobileanjian/ipc/ui/SlidingTabLayout$c;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/ui/d;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "a"
.end annotation


# instance fields
.field private a:[I


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 152
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/cyjh/mobileanjian/ipc/ui/d$1;)V
    .locals 0

    .prologue
    .line 152
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/ui/d$a;-><init>()V

    return-void
.end method


# virtual methods
.method public final a(I)I
    .locals 2

    .prologue
    .line 157
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/d$a;->a:[I

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/d$a;->a:[I

    array-length v1, v1

    rem-int v1, p1, v1

    aget v0, v0, v1

    return v0
.end method

.method varargs a([I)V
    .locals 0

    .prologue
    .line 161
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/ui/d$a;->a:[I

    .line 162
    return-void
.end method
