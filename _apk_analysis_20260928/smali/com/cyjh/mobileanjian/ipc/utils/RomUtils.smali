.class public Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static final a:Lcom/cyjh/mobileanjian/ipc/utils/a;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 10
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/utils/a;->g()Lcom/cyjh/mobileanjian/ipc/utils/a;

    move-result-object v0

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->a:Lcom/cyjh/mobileanjian/ipc/utils/a;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getEmuiVersion()Ljava/lang/String;
    .locals 2

    .prologue
    .line 71
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->a:Lcom/cyjh/mobileanjian/ipc/utils/a;

    const-string v1, "ro.build.version.emui"

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/utils/a;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getFlymeVersion()Ljava/lang/String;
    .locals 1

    .prologue
    .line 60
    sget-object v0, Landroid/os/Build;->DISPLAY:Ljava/lang/String;

    return-object v0
.end method

.method public static getKnownRomVersion()Ljava/lang/String;
    .locals 2

    .prologue
    .line 130
    const-string v0, "undefined"

    .line 131
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->isMIUI()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 133
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->getMUIUDetailVersion()Ljava/lang/String;

    move-result-object v0

    .line 164
    :cond_0
    :goto_0
    return-object v0

    .line 135
    :cond_1
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->isFlyme()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 137
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->getFlymeVersion()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 139
    :cond_2
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->isEmui()Z

    move-result v1

    if-eqz v1, :cond_3

    .line 141
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->getEmuiVersion()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 143
    :cond_3
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->isHaimawanVM()Z

    move-result v1

    if-eqz v1, :cond_4

    .line 145
    const-string v0, "\u6d77\u9a6c\u73a9\u6a21\u62df\u5668"

    goto :goto_0

    .line 147
    :cond_4
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->isTiantianVM()Z

    move-result v1

    if-eqz v1, :cond_5

    .line 149
    const-string v0, "\u5929\u5929\u6a21\u62df\u5668"

    goto :goto_0

    .line 151
    :cond_5
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->isNoxVM()Z

    move-result v1

    if-eqz v1, :cond_6

    .line 153
    const-string v0, "\u591c\u795e\u6a21\u62df\u5668"

    goto :goto_0

    .line 155
    :cond_6
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->isXiaoyaoVM()Z

    move-result v1

    if-eqz v1, :cond_7

    .line 157
    const-string v0, "\u900d\u9065\u6a21\u62df\u5668"

    goto :goto_0

    .line 159
    :cond_7
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->isXXZS()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 161
    const-string v0, "\u7329\u7329\u52a9\u624b"

    goto :goto_0
.end method

.method public static getMUIUDetailVersion()Ljava/lang/String;
    .locals 5

    .prologue
    .line 46
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->isMIUI()Z

    move-result v0

    if-nez v0, :cond_0

    .line 47
    const-string v0, ""

    .line 49
    :goto_0
    return-object v0

    :cond_0
    const-string v0, "MIUI %s %s"

    const/4 v1, 0x2

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    sget-object v3, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->a:Lcom/cyjh/mobileanjian/ipc/utils/a;

    const-string v4, "ro.miui.ui.version.name"

    invoke-virtual {v3, v4}, Lcom/cyjh/mobileanjian/ipc/utils/a;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v2

    const/4 v2, 0x1

    sget-object v3, Landroid/os/Build$VERSION;->INCREMENTAL:Ljava/lang/String;

    aput-object v3, v1, v2

    invoke-static {v0, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public static getMUIUVersion()I
    .locals 3

    .prologue
    .line 20
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->isMIUI()Z

    move-result v0

    if-nez v0, :cond_0

    .line 21
    const/4 v0, -0x1

    .line 41
    :goto_0
    return v0

    .line 23
    :cond_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->a:Lcom/cyjh/mobileanjian/ipc/utils/a;

    const-string v1, "ro.miui.ui.version.name"

    const-string v2, "V0"

    invoke-virtual {v0, v1, v2}, Lcom/cyjh/mobileanjian/ipc/utils/a;->a(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 24
    const-string v1, "V8"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 26
    const/16 v0, 0x8

    goto :goto_0

    .line 28
    :cond_1
    const-string v1, "V7"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 30
    const/4 v0, 0x7

    goto :goto_0

    .line 32
    :cond_2
    const-string v1, "V6"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 34
    const/4 v0, 0x6

    goto :goto_0

    .line 36
    :cond_3
    const-string v1, "V5"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 38
    const/4 v0, 0x5

    goto :goto_0

    .line 41
    :cond_4
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static isEmui()Z
    .locals 2

    .prologue
    .line 66
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->a:Lcom/cyjh/mobileanjian/ipc/utils/a;

    const-string v1, "ro.build.version.emui"

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/utils/a;->a(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public static isEmulator()Z
    .locals 1

    .prologue
    .line 124
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->isHaimawanVM()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->isTiantianVM()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->isNoxVM()Z

    move-result v0

    if-nez v0, :cond_0

    .line 125
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->isXiaoyaoVM()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->isXXZS()Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    .line 124
    :goto_0
    return v0

    .line 125
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static isFlyme()Z
    .locals 2

    .prologue
    .line 55
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->a:Lcom/cyjh/mobileanjian/ipc/utils/a;

    const-string v1, "ro.flyme.published"

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/utils/a;->a(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public static isHaimawanVM()Z
    .locals 2

    .prologue
    .line 80
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->a:Lcom/cyjh/mobileanjian/ipc/utils/a;

    const-string v1, "droid4x.inited"

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/utils/a;->a(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->a:Lcom/cyjh/mobileanjian/ipc/utils/a;

    const-string v1, "ro.droid4x.host.mac"

    .line 81
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/utils/a;->a(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->a:Lcom/cyjh/mobileanjian/ipc/utils/a;

    const-string v1, "droid4x.battery.status"

    .line 82
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/utils/a;->a(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->a:Lcom/cyjh/mobileanjian/ipc/utils/a;

    const-string v1, "persist.droid4x.op_alpha"

    .line 83
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/utils/a;->a(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    .line 80
    :goto_0
    return v0

    .line 83
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static isMIUI()Z
    .locals 2

    .prologue
    .line 15
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->a:Lcom/cyjh/mobileanjian/ipc/utils/a;

    const-string v1, "ro.miui.ui.version.name"

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/utils/a;->a(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public static isNoxVM()Z
    .locals 2

    .prologue
    .line 99
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->a:Lcom/cyjh/mobileanjian/ipc/utils/a;

    const-string v1, "nox.inited"

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/utils/a;->a(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->a:Lcom/cyjh/mobileanjian/ipc/utils/a;

    const-string v1, "nox.vbox_dpi"

    .line 100
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/utils/a;->a(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->a:Lcom/cyjh/mobileanjian/ipc/utils/a;

    const-string v1, "ro.nox.host.mac"

    .line 101
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/utils/a;->a(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->a:Lcom/cyjh/mobileanjian/ipc/utils/a;

    const-string v1, "nox.battery.status"

    .line 102
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/utils/a;->a(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    .line 99
    :goto_0
    return v0

    .line 102
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static isTiantianVM()Z
    .locals 2

    .prologue
    .line 89
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->a:Lcom/cyjh/mobileanjian/ipc/utils/a;

    const-string v1, "ttVM.inited"

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/utils/a;->a(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->a:Lcom/cyjh/mobileanjian/ipc/utils/a;

    const-string v1, "ttvmd.battery.status"

    .line 90
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/utils/a;->a(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->a:Lcom/cyjh/mobileanjian/ipc/utils/a;

    const-string v1, "ttVM.vbox_dpi"

    .line 91
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/utils/a;->a(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->a:Lcom/cyjh/mobileanjian/ipc/utils/a;

    const-string v1, "ttvmd.battery.mode"

    .line 92
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/utils/a;->a(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    .line 89
    :goto_0
    return v0

    .line 92
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static isXXZS()Z
    .locals 2

    .prologue
    .line 118
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->a:Lcom/cyjh/mobileanjian/ipc/utils/a;

    const-string v1, "ro.xxzs.DeviceId"

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/utils/a;->a(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->a:Lcom/cyjh/mobileanjian/ipc/utils/a;

    const-string v1, "ro.xxzs.origDeviceId"

    .line 119
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/utils/a;->a(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    .line 118
    :goto_0
    return v0

    .line 119
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static isXiaoyaoVM()Z
    .locals 2

    .prologue
    .line 108
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->a:Lcom/cyjh/mobileanjian/ipc/utils/a;

    const-string v1, "microvirt.inited"

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/utils/a;->a(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->a:Lcom/cyjh/mobileanjian/ipc/utils/a;

    const-string v1, "microvirt.channel"

    .line 109
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/utils/a;->a(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->a:Lcom/cyjh/mobileanjian/ipc/utils/a;

    const-string v1, "ro.microvirt.hmac"

    .line 110
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/utils/a;->a(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->a:Lcom/cyjh/mobileanjian/ipc/utils/a;

    const-string v1, "microvirt.vbox_dpi"

    .line 111
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/utils/a;->a(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    .line 108
    :goto_0
    return v0

    .line 111
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method
