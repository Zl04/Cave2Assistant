.class public abstract Lcom/cyjh/elfin/listener/IFLYADListener;
.super Ljava/lang/Object;
.source "IFLYADListener.java"

# interfaces
.implements Lcom/iflytek/voiceads/IFLYNativeListener;


# static fields
.field public static final AD_REDIRECT:Ljava/lang/String; = "redirect"

.field public static final IFLYAD_BOTTOM_SCREEN_KEY:Ljava/lang/String; = "5FF8BF855D9553F32AA0CD1DB70FEDC6"

.field public static final IFLYAD_FULLSCREEN_KEY:Ljava/lang/String; = "21462E427898ADCCC2171718D603B0DE"

.field public static final IFLYAD_FULLSCREEN_KEY_TWO:Ljava/lang/String; = "761D5F3C12409F07DCE571A8AA3C0480"

.field public static final IFLYAD_PART_SCREEN_KEY:Ljava/lang/String; = "410D8AC18806EDFE511A00EFD3329F20"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCancel()V
    .locals 0

    .prologue
    .line 54
    return-void
.end method

.method public onConfirm()V
    .locals 0

    .prologue
    .line 49
    return-void
.end method
