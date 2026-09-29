.class public final Lcom/cyjh/mobileanjian/ipc/share/proto/a;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static final A:I = 0x21

.field public static final B:I = 0x22

.field public static final C:I = 0x23

.field public static final D:I = 0x24

.field public static final E:I = 0x25

.field public static final F:I = 0x26

.field public static final G:I = 0x27

.field public static final H:I = 0x28

.field public static final I:I = 0x29

.field public static final J:I = 0x2a

.field public static final K:I = 0x2b

.field public static final L:I = 0x30

.field public static final M:I = 0x31

.field public static final N:I = 0x32

.field public static final O:I = 0x33

.field public static final P:I = 0x34

.field public static final Q:I = 0x35

.field public static final R:I = 0x36

.field public static final S:I = 0x37

.field public static final T:I = 0x38

.field public static final U:I = 0x39

.field public static final V:I = 0x3a

.field public static final W:I = 0x3b

.field public static final X:I = 0x40

.field public static final Y:I = 0x41

.field public static final Z:I = 0x42

.field public static final a:I = 0x0

.field public static final aa:I = 0x43

.field public static final ab:I = 0x81

.field public static final ac:I = 0x100

.field public static final ad:I = 0x101

.field public static final ae:I = 0x102

.field public static final b:I = 0xffff

.field public static final c:I = 0x1

.field public static final d:I = 0x2

.field public static final e:I = 0x3

.field public static final f:I = 0x4

.field public static final g:I = 0x5

.field public static final h:I = 0x6

.field public static final i:I = 0x7

.field public static final j:I = 0x8

.field public static final k:I = 0x9

.field public static final l:I = 0xd

.field public static final m:I = 0xe

.field public static final n:I = 0xf

.field public static final o:I = 0x10

.field public static final p:I = 0x11

.field public static final q:I = 0x12

.field public static final r:I = 0x13

.field public static final s:I = 0x14

.field public static final t:I = 0x15

.field public static final u:I = 0x16

.field public static final v:I = 0x17

.field public static final w:I = 0x1a

.field public static final x:I = 0x18

.field public static final y:I = 0x19

.field public static final z:I = 0x20


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a(I)Ljava/lang/String;
    .locals 1

    .prologue
    .line 89
    const-string v0, "OTHER"

    .line 90
    sparse-switch p0, :sswitch_data_0

    .line 191
    :goto_0
    return-object v0

    .line 93
    :sswitch_0
    const-string v0, "DEFAULT"

    goto :goto_0

    .line 96
    :sswitch_1
    const-string v0, "EXIT"

    goto :goto_0

    .line 99
    :sswitch_2
    const-string v0, "INIT_INFO"

    goto :goto_0

    .line 102
    :sswitch_3
    const-string v0, "PREPARE_SCRIPT"

    goto :goto_0

    .line 105
    :sswitch_4
    const-string v0, "RUN_SCRIPT_REQUEST"

    goto :goto_0

    .line 108
    :sswitch_5
    const-string v0, "PAUSE_SCRIPT_REQUEST"

    goto :goto_0

    .line 111
    :sswitch_6
    const-string v0, "STOP_SCRIPT_REQUEST"

    goto :goto_0

    .line 114
    :sswitch_7
    const-string v0, "SCREENSHOT"

    goto :goto_0

    .line 117
    :sswitch_8
    const-string v0, "STOP_RECORD"

    goto :goto_0

    .line 120
    :sswitch_9
    const-string v0, "START_RECORD"

    goto :goto_0

    .line 123
    :sswitch_a
    const-string v0, "NOTIFY_ROTATION_STATUS"

    goto :goto_0

    .line 126
    :sswitch_b
    const-string v0, "SCRIPT_STOPPED"

    goto :goto_0

    .line 129
    :sswitch_c
    const-string v0, "SCRIPT_ALREADY_STARTED"

    goto :goto_0

    .line 132
    :sswitch_d
    const-string v0, "SCRIPT_STARTED"

    goto :goto_0

    .line 135
    :sswitch_e
    const-string v0, "NOTIFY_CONNECT_WITH_PC_STATE"

    goto :goto_0

    .line 138
    :sswitch_f
    const-string v0, "CLEAR_CACHES"

    goto :goto_0

    .line 141
    :sswitch_10
    const-string v0, "RPC_UPWARD"

    goto :goto_0

    .line 144
    :sswitch_11
    const-string v0, "INPUT_TEXT"

    goto :goto_0

    .line 147
    :sswitch_12
    const-string v0, "PAUSE"

    goto :goto_0

    .line 150
    :sswitch_13
    const-string v0, "DEBUG_MESSAGE"

    goto :goto_0

    .line 153
    :sswitch_14
    const-string v0, "DEBUG_SCRIPT"

    goto :goto_0

    .line 156
    :sswitch_15
    const-string v0, "UI_REQUEST"

    goto :goto_0

    .line 159
    :sswitch_16
    const-string v0, "SHOW_ALERT_DIALOG"

    goto :goto_0

    .line 162
    :sswitch_17
    const-string v0, "SHOW_INPUT_DIALOG"

    goto :goto_0

    .line 165
    :sswitch_18
    const-string v0, "DEVICE_LOCK_SCREEN"

    goto :goto_0

    .line 168
    :sswitch_19
    const-string v0, "DEVICE_UNLOCK_SCREEN"

    goto :goto_0

    .line 171
    :sswitch_1a
    const-string v0, "UI_EVENT"

    goto :goto_0

    .line 174
    :sswitch_1b
    const-string v0, "OPEN_RECORD_REQUEST"

    goto :goto_0

    .line 177
    :sswitch_1c
    const-string v0, "START_RECORD_REQUEST"

    goto :goto_0

    .line 180
    :sswitch_1d
    const-string v0, "STOP_RECORD_REQUEST"

    goto :goto_0

    .line 183
    :sswitch_1e
    const-string v0, "PREPARE_SECOND_SCRIPT"

    goto :goto_0

    .line 186
    :sswitch_1f
    const-string v0, "SET_RECORD_UI_STATE"

    goto :goto_0

    .line 90
    :sswitch_data_0
    .sparse-switch
        0x0 -> :sswitch_0
        0x1 -> :sswitch_4
        0x2 -> :sswitch_5
        0x3 -> :sswitch_6
        0x4 -> :sswitch_d
        0x5 -> :sswitch_c
        0x6 -> :sswitch_b
        0x7 -> :sswitch_3
        0x8 -> :sswitch_1e
        0xd -> :sswitch_e
        0xe -> :sswitch_2
        0xf -> :sswitch_a
        0x10 -> :sswitch_9
        0x11 -> :sswitch_8
        0x12 -> :sswitch_1b
        0x14 -> :sswitch_1c
        0x16 -> :sswitch_1d
        0x18 -> :sswitch_7
        0x1a -> :sswitch_1f
        0x26 -> :sswitch_11
        0x29 -> :sswitch_f
        0x30 -> :sswitch_10
        0x37 -> :sswitch_18
        0x38 -> :sswitch_19
        0x40 -> :sswitch_15
        0x41 -> :sswitch_1a
        0x42 -> :sswitch_16
        0x43 -> :sswitch_17
        0x100 -> :sswitch_14
        0x101 -> :sswitch_13
        0x102 -> :sswitch_12
        0xffff -> :sswitch_1
    .end sparse-switch
.end method
