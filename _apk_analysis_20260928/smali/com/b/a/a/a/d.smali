.class public final Lcom/b/a/a/a/d;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field public final a:Lcom/b/a/ao;

.field public final b:Lcom/b/a/as;


# direct methods
.method constructor <init>(Lcom/b/a/ao;Lcom/b/a/as;)V
    .locals 0

    .prologue
    .line 56
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 57
    iput-object p1, p0, Lcom/b/a/a/a/d;->a:Lcom/b/a/ao;

    .line 58
    iput-object p2, p0, Lcom/b/a/a/a/d;->b:Lcom/b/a/as;

    .line 59
    return-void
.end method

.method public static a(Lcom/b/a/as;Lcom/b/a/ao;)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 65
    invoke-virtual {p0}, Lcom/b/a/as;->b()I

    move-result v1

    sparse-switch v1, :sswitch_data_0

    .line 99
    :cond_0
    :goto_0
    return v0

    .line 85
    :sswitch_0
    const-string v1, "Expires"

    invoke-virtual {p0, v1}, Lcom/b/a/as;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    if-nez v1, :cond_1

    .line 86
    invoke-virtual {p0}, Lcom/b/a/as;->g()Lcom/b/a/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/b/a/e;->c()I

    move-result v1

    const/4 v2, -0x1

    if-ne v1, v2, :cond_1

    .line 87
    invoke-virtual {p0}, Lcom/b/a/as;->g()Lcom/b/a/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/b/a/e;->e()Z

    move-result v1

    if-nez v1, :cond_1

    .line 88
    invoke-virtual {p0}, Lcom/b/a/as;->g()Lcom/b/a/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/b/a/e;->d()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 99
    :cond_1
    :sswitch_1
    invoke-virtual {p0}, Lcom/b/a/as;->g()Lcom/b/a/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/b/a/e;->b()Z

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {p1}, Lcom/b/a/ao;->f()Lcom/b/a/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/b/a/e;->b()Z

    move-result v1

    if-nez v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    .line 65
    :sswitch_data_0
    .sparse-switch
        0xc8 -> :sswitch_1
        0xcb -> :sswitch_1
        0xcc -> :sswitch_1
        0x12c -> :sswitch_1
        0x12d -> :sswitch_1
        0x12e -> :sswitch_0
        0x133 -> :sswitch_0
        0x134 -> :sswitch_1
        0x194 -> :sswitch_1
        0x195 -> :sswitch_1
        0x19a -> :sswitch_1
        0x19e -> :sswitch_1
        0x1f5 -> :sswitch_1
    .end sparse-switch
.end method
