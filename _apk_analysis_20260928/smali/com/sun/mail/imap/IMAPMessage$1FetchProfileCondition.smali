.class Lcom/sun/mail/imap/IMAPMessage$1FetchProfileCondition;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/sun/mail/imap/Utility$Condition;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/sun/mail/imap/IMAPMessage;->fetch(Lcom/sun/mail/imap/IMAPFolder;[Ljavax/mail/Message;Ljavax/mail/FetchProfile;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "1FetchProfileCondition"
.end annotation


# instance fields
.field private hdrs:[Ljava/lang/String;

.field private needBodyStructure:Z

.field private needEnvelope:Z

.field private needFlags:Z

.field private needHeaders:Z

.field private needSize:Z

.field private needUID:Z


# direct methods
.method public constructor <init>(Ljavax/mail/FetchProfile;)V
    .locals 2

    .prologue
    const/4 v1, 0x1

    const/4 v0, 0x0

    .line 942
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 934
    iput-boolean v0, p0, Lcom/sun/mail/imap/IMAPMessage$1FetchProfileCondition;->needEnvelope:Z

    .line 935
    iput-boolean v0, p0, Lcom/sun/mail/imap/IMAPMessage$1FetchProfileCondition;->needFlags:Z

    .line 936
    iput-boolean v0, p0, Lcom/sun/mail/imap/IMAPMessage$1FetchProfileCondition;->needBodyStructure:Z

    .line 937
    iput-boolean v0, p0, Lcom/sun/mail/imap/IMAPMessage$1FetchProfileCondition;->needUID:Z

    .line 938
    iput-boolean v0, p0, Lcom/sun/mail/imap/IMAPMessage$1FetchProfileCondition;->needHeaders:Z

    .line 939
    iput-boolean v0, p0, Lcom/sun/mail/imap/IMAPMessage$1FetchProfileCondition;->needSize:Z

    .line 940
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/sun/mail/imap/IMAPMessage$1FetchProfileCondition;->hdrs:[Ljava/lang/String;

    .line 943
    sget-object v0, Ljavax/mail/FetchProfile$Item;->ENVELOPE:Ljavax/mail/FetchProfile$Item;

    invoke-virtual {p1, v0}, Ljavax/mail/FetchProfile;->contains(Ljavax/mail/FetchProfile$Item;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 944
    iput-boolean v1, p0, Lcom/sun/mail/imap/IMAPMessage$1FetchProfileCondition;->needEnvelope:Z

    .line 945
    :cond_0
    sget-object v0, Ljavax/mail/FetchProfile$Item;->FLAGS:Ljavax/mail/FetchProfile$Item;

    invoke-virtual {p1, v0}, Ljavax/mail/FetchProfile;->contains(Ljavax/mail/FetchProfile$Item;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 946
    iput-boolean v1, p0, Lcom/sun/mail/imap/IMAPMessage$1FetchProfileCondition;->needFlags:Z

    .line 947
    :cond_1
    sget-object v0, Ljavax/mail/FetchProfile$Item;->CONTENT_INFO:Ljavax/mail/FetchProfile$Item;

    invoke-virtual {p1, v0}, Ljavax/mail/FetchProfile;->contains(Ljavax/mail/FetchProfile$Item;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 948
    iput-boolean v1, p0, Lcom/sun/mail/imap/IMAPMessage$1FetchProfileCondition;->needBodyStructure:Z

    .line 949
    :cond_2
    sget-object v0, Ljavax/mail/UIDFolder$FetchProfileItem;->UID:Ljavax/mail/UIDFolder$FetchProfileItem;

    invoke-virtual {p1, v0}, Ljavax/mail/FetchProfile;->contains(Ljavax/mail/FetchProfile$Item;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 950
    iput-boolean v1, p0, Lcom/sun/mail/imap/IMAPMessage$1FetchProfileCondition;->needUID:Z

    .line 951
    :cond_3
    sget-object v0, Lcom/sun/mail/imap/IMAPFolder$FetchProfileItem;->HEADERS:Lcom/sun/mail/imap/IMAPFolder$FetchProfileItem;

    invoke-virtual {p1, v0}, Ljavax/mail/FetchProfile;->contains(Ljavax/mail/FetchProfile$Item;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 952
    iput-boolean v1, p0, Lcom/sun/mail/imap/IMAPMessage$1FetchProfileCondition;->needHeaders:Z

    .line 953
    :cond_4
    sget-object v0, Lcom/sun/mail/imap/IMAPFolder$FetchProfileItem;->SIZE:Lcom/sun/mail/imap/IMAPFolder$FetchProfileItem;

    invoke-virtual {p1, v0}, Ljavax/mail/FetchProfile;->contains(Ljavax/mail/FetchProfile$Item;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 954
    iput-boolean v1, p0, Lcom/sun/mail/imap/IMAPMessage$1FetchProfileCondition;->needSize:Z

    .line 955
    :cond_5
    invoke-virtual {p1}, Ljavax/mail/FetchProfile;->getHeaderNames()[Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/sun/mail/imap/IMAPMessage$1FetchProfileCondition;->hdrs:[Ljava/lang/String;

    .line 956
    return-void
.end method


# virtual methods
.method public test(Lcom/sun/mail/imap/IMAPMessage;)Z
    .locals 8

    .prologue
    const/4 v1, 0x0

    const/4 v2, 0x1

    .line 960
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPMessage$1FetchProfileCondition;->needEnvelope:Z

    if-eqz v0, :cond_1

    invoke-static {p1}, Lcom/sun/mail/imap/IMAPMessage;->access$0(Lcom/sun/mail/imap/IMAPMessage;)Lcom/sun/mail/imap/protocol/ENVELOPE;

    move-result-object v0

    if-nez v0, :cond_1

    move v1, v2

    .line 979
    :cond_0
    :goto_0
    return v1

    .line 962
    :cond_1
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPMessage$1FetchProfileCondition;->needFlags:Z

    if-eqz v0, :cond_2

    invoke-static {p1}, Lcom/sun/mail/imap/IMAPMessage;->access$1(Lcom/sun/mail/imap/IMAPMessage;)Ljavax/mail/Flags;

    move-result-object v0

    if-nez v0, :cond_2

    move v1, v2

    .line 963
    goto :goto_0

    .line 964
    :cond_2
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPMessage$1FetchProfileCondition;->needBodyStructure:Z

    if-eqz v0, :cond_3

    invoke-static {p1}, Lcom/sun/mail/imap/IMAPMessage;->access$2(Lcom/sun/mail/imap/IMAPMessage;)Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    move-result-object v0

    if-nez v0, :cond_3

    move v1, v2

    .line 965
    goto :goto_0

    .line 966
    :cond_3
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPMessage$1FetchProfileCondition;->needUID:Z

    if-eqz v0, :cond_4

    invoke-virtual {p1}, Lcom/sun/mail/imap/IMAPMessage;->getUID()J

    move-result-wide v4

    const-wide/16 v6, -0x1

    cmp-long v0, v4, v6

    if-nez v0, :cond_4

    move v1, v2

    .line 967
    goto :goto_0

    .line 968
    :cond_4
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPMessage$1FetchProfileCondition;->needHeaders:Z

    if-eqz v0, :cond_5

    invoke-static {p1}, Lcom/sun/mail/imap/IMAPMessage;->access$3(Lcom/sun/mail/imap/IMAPMessage;)Z

    move-result v0

    if-nez v0, :cond_5

    move v1, v2

    .line 969
    goto :goto_0

    .line 970
    :cond_5
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPMessage$1FetchProfileCondition;->needSize:Z

    if-eqz v0, :cond_6

    invoke-static {p1}, Lcom/sun/mail/imap/IMAPMessage;->access$4(Lcom/sun/mail/imap/IMAPMessage;)I

    move-result v0

    const/4 v3, -0x1

    if-ne v0, v3, :cond_6

    move v1, v2

    .line 971
    goto :goto_0

    :cond_6
    move v0, v1

    .line 974
    :goto_1
    iget-object v3, p0, Lcom/sun/mail/imap/IMAPMessage$1FetchProfileCondition;->hdrs:[Ljava/lang/String;

    array-length v3, v3

    if-ge v0, v3, :cond_0

    .line 975
    iget-object v3, p0, Lcom/sun/mail/imap/IMAPMessage$1FetchProfileCondition;->hdrs:[Ljava/lang/String;

    aget-object v3, v3, v0

    invoke-static {p1, v3}, Lcom/sun/mail/imap/IMAPMessage;->access$5(Lcom/sun/mail/imap/IMAPMessage;Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_7

    move v1, v2

    .line 976
    goto :goto_0

    .line 974
    :cond_7
    add-int/lit8 v0, v0, 0x1

    goto :goto_1
.end method
