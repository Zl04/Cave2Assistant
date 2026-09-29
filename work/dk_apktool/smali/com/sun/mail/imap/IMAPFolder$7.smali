.class Lcom/sun/mail/imap/IMAPFolder$7;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/sun/mail/imap/IMAPFolder$ProtocolCommand;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/sun/mail/imap/IMAPFolder;->hasNewMessages()Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/sun/mail/imap/IMAPFolder;


# direct methods
.method constructor <init>(Lcom/sun/mail/imap/IMAPFolder;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/sun/mail/imap/IMAPFolder$7;->this$0:Lcom/sun/mail/imap/IMAPFolder;

    .line 789
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public doCommand(Lcom/sun/mail/imap/protocol/IMAPProtocol;)Ljava/lang/Object;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    const/4 v3, 0x0

    .line 791
    const-string v0, ""

    iget-object v1, p0, Lcom/sun/mail/imap/IMAPFolder$7;->this$0:Lcom/sun/mail/imap/IMAPFolder;

    iget-object v1, v1, Lcom/sun/mail/imap/IMAPFolder;->fullName:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->list(Ljava/lang/String;Ljava/lang/String;)[Lcom/sun/mail/imap/protocol/ListInfo;

    move-result-object v0

    .line 792
    if-eqz v0, :cond_1

    .line 793
    aget-object v1, v0, v3

    iget v1, v1, Lcom/sun/mail/imap/protocol/ListInfo;->changeState:I

    const/4 v2, 0x1

    if-ne v1, v2, :cond_0

    .line 794
    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    .line 804
    :goto_0
    return-object v0

    .line 795
    :cond_0
    aget-object v0, v0, v3

    iget v0, v0, Lcom/sun/mail/imap/protocol/ListInfo;->changeState:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_1

    .line 796
    sget-object v0, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    goto :goto_0

    .line 800
    :cond_1
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPFolder$7;->this$0:Lcom/sun/mail/imap/IMAPFolder;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPFolder;->access$0(Lcom/sun/mail/imap/IMAPFolder;)Lcom/sun/mail/imap/protocol/Status;

    move-result-object v0

    .line 801
    iget v0, v0, Lcom/sun/mail/imap/protocol/Status;->recent:I

    if-lez v0, :cond_2

    .line 802
    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    goto :goto_0

    .line 804
    :cond_2
    sget-object v0, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    goto :goto_0
.end method
