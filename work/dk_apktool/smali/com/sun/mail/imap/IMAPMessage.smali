.class public Lcom/sun/mail/imap/IMAPMessage;
.super Ljavax/mail/internet/MimeMessage;
.source "SourceFile"


# static fields
.field private static EnvelopeCmd:Ljava/lang/String;


# instance fields
.field protected bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

.field private description:Ljava/lang/String;

.field protected envelope:Lcom/sun/mail/imap/protocol/ENVELOPE;

.field private headersLoaded:Z

.field private loadedHeaders:Ljava/util/Hashtable;

.field private peek:Z

.field private receivedDate:Ljava/util/Date;

.field protected sectionId:Ljava/lang/String;

.field private seqnum:I

.field private size:I

.field private subject:Ljava/lang/String;

.field private type:Ljava/lang/String;

.field private uid:J


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 119
    const-string v0, "ENVELOPE INTERNALDATE RFC822.SIZE"

    sput-object v0, Lcom/sun/mail/imap/IMAPMessage;->EnvelopeCmd:Ljava/lang/String;

    .line 82
    return-void
.end method

.method protected constructor <init>(Lcom/sun/mail/imap/IMAPFolder;II)V
    .locals 2

    .prologue
    .line 125
    invoke-direct {p0, p1, p2}, Ljavax/mail/internet/MimeMessage;-><init>(Ljavax/mail/Folder;I)V

    .line 87
    const/4 v0, -0x1

    iput v0, p0, Lcom/sun/mail/imap/IMAPMessage;->size:I

    .line 94
    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lcom/sun/mail/imap/IMAPMessage;->uid:J

    .line 106
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/sun/mail/imap/IMAPMessage;->headersLoaded:Z

    .line 126
    iput p3, p0, Lcom/sun/mail/imap/IMAPMessage;->seqnum:I

    .line 127
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->flags:Ljavax/mail/Flags;

    .line 128
    return-void
.end method

.method protected constructor <init>(Ljavax/mail/Session;)V
    .locals 2

    .prologue
    .line 134
    invoke-direct {p0, p1}, Ljavax/mail/internet/MimeMessage;-><init>(Ljavax/mail/Session;)V

    .line 87
    const/4 v0, -0x1

    iput v0, p0, Lcom/sun/mail/imap/IMAPMessage;->size:I

    .line 94
    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lcom/sun/mail/imap/IMAPMessage;->uid:J

    .line 106
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/sun/mail/imap/IMAPMessage;->headersLoaded:Z

    .line 135
    return-void
.end method

.method private _getBodyStructure()Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;
    .locals 1

    .prologue
    .line 1419
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    return-object v0
.end method

.method private _getEnvelope()Lcom/sun/mail/imap/protocol/ENVELOPE;
    .locals 1

    .prologue
    .line 1415
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->envelope:Lcom/sun/mail/imap/protocol/ENVELOPE;

    return-object v0
.end method

.method private _getFlags()Ljavax/mail/Flags;
    .locals 1

    .prologue
    .line 1411
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->flags:Ljavax/mail/Flags;

    return-object v0
.end method

.method private aaclone([Ljavax/mail/internet/InternetAddress;)[Ljavax/mail/internet/InternetAddress;
    .locals 1

    .prologue
    .line 1404
    if-nez p1, :cond_0

    .line 1405
    const/4 v0, 0x0

    .line 1407
    :goto_0
    return-object v0

    :cond_0
    invoke-virtual {p1}, [Ljavax/mail/internet/InternetAddress;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljavax/mail/internet/InternetAddress;

    goto :goto_0
.end method

.method static synthetic access$0(Lcom/sun/mail/imap/IMAPMessage;)Lcom/sun/mail/imap/protocol/ENVELOPE;
    .locals 1

    .prologue
    .line 1414
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPMessage;->_getEnvelope()Lcom/sun/mail/imap/protocol/ENVELOPE;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$1(Lcom/sun/mail/imap/IMAPMessage;)Ljavax/mail/Flags;
    .locals 1

    .prologue
    .line 1410
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPMessage;->_getFlags()Ljavax/mail/Flags;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$2(Lcom/sun/mail/imap/IMAPMessage;)Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;
    .locals 1

    .prologue
    .line 1418
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPMessage;->_getBodyStructure()Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$3(Lcom/sun/mail/imap/IMAPMessage;)Z
    .locals 1

    .prologue
    .line 1357
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPMessage;->areHeadersLoaded()Z

    move-result v0

    return v0
.end method

.method static synthetic access$4(Lcom/sun/mail/imap/IMAPMessage;)I
    .locals 1

    .prologue
    .line 87
    iget v0, p0, Lcom/sun/mail/imap/IMAPMessage;->size:I

    return v0
.end method

.method static synthetic access$5(Lcom/sun/mail/imap/IMAPMessage;Ljava/lang/String;)Z
    .locals 1

    .prologue
    .line 1371
    invoke-direct {p0, p1}, Lcom/sun/mail/imap/IMAPMessage;->isHeaderLoaded(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method private declared-synchronized areHeadersLoaded()Z
    .locals 1

    .prologue
    .line 1358
    monitor-enter p0

    :try_start_0
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPMessage;->headersLoaded:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method private static craftHeaderCmd(Lcom/sun/mail/imap/protocol/IMAPProtocol;[Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 1232
    invoke-virtual {p0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->isREV1()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1233
    new-instance v0, Ljava/lang/StringBuffer;

    const-string v1, "BODY.PEEK[HEADER.FIELDS ("

    invoke-direct {v0, v1}, Ljava/lang/StringBuffer;-><init>(Ljava/lang/String;)V

    .line 1237
    :goto_0
    const/4 v1, 0x0

    :goto_1
    array-length v2, p1

    if-lt v1, v2, :cond_1

    .line 1243
    invoke-virtual {p0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->isREV1()Z

    move-result v1

    if-eqz v1, :cond_3

    .line 1244
    const-string v1, ")]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 1248
    :goto_2
    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 1235
    :cond_0
    new-instance v0, Ljava/lang/StringBuffer;

    const-string v1, "RFC822.HEADER.LINES ("

    invoke-direct {v0, v1}, Ljava/lang/StringBuffer;-><init>(Ljava/lang/String;)V

    goto :goto_0

    .line 1238
    :cond_1
    if-lez v1, :cond_2

    .line 1239
    const-string v2, " "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 1240
    :cond_2
    aget-object v2, p1, v1

    invoke-virtual {v0, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 1237
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 1246
    :cond_3
    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    goto :goto_2
.end method

.method static fetch(Lcom/sun/mail/imap/IMAPFolder;[Ljavax/mail/Message;Ljavax/mail/FetchProfile;)V
    .locals 18
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 983
    new-instance v6, Ljava/lang/StringBuffer;

    invoke-direct {v6}, Ljava/lang/StringBuffer;-><init>()V

    .line 984
    const/4 v2, 0x1

    .line 985
    const/4 v3, 0x0

    .line 987
    sget-object v4, Ljavax/mail/FetchProfile$Item;->ENVELOPE:Ljavax/mail/FetchProfile$Item;

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Ljavax/mail/FetchProfile;->contains(Ljavax/mail/FetchProfile$Item;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 988
    sget-object v2, Lcom/sun/mail/imap/IMAPMessage;->EnvelopeCmd:Ljava/lang/String;

    invoke-virtual {v6, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 989
    const/4 v2, 0x0

    .line 991
    :cond_0
    sget-object v4, Ljavax/mail/FetchProfile$Item;->FLAGS:Ljavax/mail/FetchProfile$Item;

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Ljavax/mail/FetchProfile;->contains(Ljavax/mail/FetchProfile$Item;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 992
    if-eqz v2, :cond_6

    const-string v2, "FLAGS"

    :goto_0
    invoke-virtual {v6, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 993
    const/4 v2, 0x0

    .line 995
    :cond_1
    sget-object v4, Ljavax/mail/FetchProfile$Item;->CONTENT_INFO:Ljavax/mail/FetchProfile$Item;

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Ljavax/mail/FetchProfile;->contains(Ljavax/mail/FetchProfile$Item;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 996
    if-eqz v2, :cond_7

    const-string v2, "BODYSTRUCTURE"

    :goto_1
    invoke-virtual {v6, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 997
    const/4 v2, 0x0

    .line 999
    :cond_2
    sget-object v4, Ljavax/mail/UIDFolder$FetchProfileItem;->UID:Ljavax/mail/UIDFolder$FetchProfileItem;

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Ljavax/mail/FetchProfile;->contains(Ljavax/mail/FetchProfile$Item;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 1000
    if-eqz v2, :cond_8

    const-string v2, "UID"

    :goto_2
    invoke-virtual {v6, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 1001
    const/4 v2, 0x0

    .line 1003
    :cond_3
    sget-object v4, Lcom/sun/mail/imap/IMAPFolder$FetchProfileItem;->HEADERS:Lcom/sun/mail/imap/IMAPFolder$FetchProfileItem;

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Ljavax/mail/FetchProfile;->contains(Ljavax/mail/FetchProfile$Item;)Z

    move-result v4

    if-eqz v4, :cond_28

    .line 1004
    const/4 v3, 0x1

    .line 1005
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/sun/mail/imap/IMAPFolder;->protocol:Lcom/sun/mail/imap/protocol/IMAPProtocol;

    invoke-virtual {v4}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->isREV1()Z

    move-result v4

    if-eqz v4, :cond_a

    .line 1006
    if-eqz v2, :cond_9

    .line 1007
    const-string v2, "BODY.PEEK[HEADER]"

    .line 1006
    :goto_3
    invoke-virtual {v6, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 1010
    :goto_4
    const/4 v2, 0x0

    move v4, v3

    .line 1012
    :goto_5
    sget-object v3, Lcom/sun/mail/imap/IMAPFolder$FetchProfileItem;->SIZE:Lcom/sun/mail/imap/IMAPFolder$FetchProfileItem;

    move-object/from16 v0, p2

    invoke-virtual {v0, v3}, Ljavax/mail/FetchProfile;->contains(Ljavax/mail/FetchProfile$Item;)Z

    move-result v3

    if-eqz v3, :cond_27

    .line 1013
    if-eqz v2, :cond_c

    const-string v2, "RFC822.SIZE"

    :goto_6
    invoke-virtual {v6, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 1014
    const/4 v2, 0x0

    move v3, v2

    .line 1018
    :goto_7
    const/4 v2, 0x0

    check-cast v2, [Ljava/lang/String;

    .line 1019
    if-nez v4, :cond_5

    .line 1020
    invoke-virtual/range {p2 .. p2}, Ljavax/mail/FetchProfile;->getHeaderNames()[Ljava/lang/String;

    move-result-object v2

    .line 1021
    array-length v5, v2

    if-lez v5, :cond_5

    .line 1022
    if-nez v3, :cond_4

    .line 1023
    const-string v3, " "

    invoke-virtual {v6, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 1024
    :cond_4
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/sun/mail/imap/IMAPFolder;->protocol:Lcom/sun/mail/imap/protocol/IMAPProtocol;

    invoke-static {v3, v2}, Lcom/sun/mail/imap/IMAPMessage;->craftHeaderCmd(Lcom/sun/mail/imap/protocol/IMAPProtocol;[Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v6, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    :cond_5
    move-object v5, v2

    .line 1028
    new-instance v2, Lcom/sun/mail/imap/IMAPMessage$1FetchProfileCondition;

    move-object/from16 v0, p2

    invoke-direct {v2, v0}, Lcom/sun/mail/imap/IMAPMessage$1FetchProfileCondition;-><init>(Ljavax/mail/FetchProfile;)V

    .line 1031
    move-object/from16 v0, p0

    iget-object v10, v0, Lcom/sun/mail/imap/IMAPFolder;->messageCacheLock:Ljava/lang/Object;

    monitor-enter v10

    .line 1035
    :try_start_0
    move-object/from16 v0, p1

    invoke-static {v0, v2}, Lcom/sun/mail/imap/Utility;->toMessageSet([Ljavax/mail/Message;Lcom/sun/mail/imap/Utility$Condition;)[Lcom/sun/mail/imap/protocol/MessageSet;

    move-result-object v3

    .line 1037
    if-nez v3, :cond_d

    .line 1039
    monitor-exit v10
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1168
    :goto_8
    return-void

    .line 992
    :cond_6
    const-string v2, " FLAGS"

    goto/16 :goto_0

    .line 996
    :cond_7
    const-string v2, " BODYSTRUCTURE"

    goto/16 :goto_1

    .line 1000
    :cond_8
    const-string v2, " UID"

    goto :goto_2

    .line 1007
    :cond_9
    const-string v2, " BODY.PEEK[HEADER]"

    goto :goto_3

    .line 1009
    :cond_a
    if-eqz v2, :cond_b

    const-string v2, "RFC822.HEADER"

    :goto_9
    invoke-virtual {v6, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    goto :goto_4

    :cond_b
    const-string v2, " RFC822.HEADER"

    goto :goto_9

    .line 1013
    :cond_c
    const-string v2, " RFC822.SIZE"

    goto :goto_6

    .line 1041
    :cond_d
    const/4 v2, 0x0

    :try_start_1
    check-cast v2, [Lcom/sun/mail/iap/Response;

    .line 1042
    new-instance v11, Ljava/util/Vector;

    invoke-direct {v11}, Ljava/util/Vector;-><init>()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1045
    :try_start_2
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/sun/mail/imap/IMAPFolder;->protocol:Lcom/sun/mail/imap/protocol/IMAPProtocol;

    invoke-virtual {v6}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v7, v3, v6}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->fetch([Lcom/sun/mail/imap/protocol/MessageSet;Ljava/lang/String;)[Lcom/sun/mail/iap/Response;
    :try_end_2
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Lcom/sun/mail/iap/CommandFailedException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_2 .. :try_end_2} :catch_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-result-object v2

    move-object v9, v2

    .line 1054
    :goto_a
    if-nez v9, :cond_e

    .line 1055
    :try_start_3
    monitor-exit v10

    goto :goto_8

    .line 1031
    :catchall_0
    move-exception v2

    monitor-exit v10
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw v2

    .line 1046
    :catch_0
    move-exception v2

    .line 1047
    :try_start_4
    new-instance v3, Ljavax/mail/FolderClosedException;

    invoke-virtual {v2}, Lcom/sun/mail/iap/ConnectionException;->getMessage()Ljava/lang/String;

    move-result-object v2

    move-object/from16 v0, p0

    invoke-direct {v3, v0, v2}, Ljavax/mail/FolderClosedException;-><init>(Ljavax/mail/Folder;Ljava/lang/String;)V

    throw v3

    .line 1048
    :catch_1
    move-exception v3

    move-object v9, v2

    goto :goto_a

    .line 1050
    :catch_2
    move-exception v2

    .line 1051
    new-instance v3, Ljavax/mail/MessagingException;

    invoke-virtual {v2}, Lcom/sun/mail/iap/ProtocolException;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4, v2}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v3

    .line 1057
    :cond_e
    const/4 v2, 0x0

    move v8, v2

    :goto_b
    array-length v2, v9

    if-lt v8, v2, :cond_10

    .line 1160
    invoke-virtual {v11}, Ljava/util/Vector;->size()I

    move-result v2

    .line 1161
    if-eqz v2, :cond_f

    .line 1162
    new-array v2, v2, [Lcom/sun/mail/iap/Response;

    .line 1163
    invoke-virtual {v11, v2}, Ljava/util/Vector;->copyInto([Ljava/lang/Object;)V

    .line 1164
    move-object/from16 v0, p0

    invoke-virtual {v0, v2}, Lcom/sun/mail/imap/IMAPFolder;->handleResponses([Lcom/sun/mail/iap/Response;)V

    .line 1031
    :cond_f
    monitor-exit v10

    goto :goto_8

    .line 1058
    :cond_10
    aget-object v2, v9, v8

    if-nez v2, :cond_12

    .line 1057
    :cond_11
    :goto_c
    add-int/lit8 v2, v8, 0x1

    move v8, v2

    goto :goto_b

    .line 1060
    :cond_12
    aget-object v2, v9, v8

    instance-of v2, v2, Lcom/sun/mail/imap/protocol/FetchResponse;

    if-nez v2, :cond_13

    .line 1061
    aget-object v2, v9, v8

    invoke-virtual {v11, v2}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    goto :goto_c

    .line 1066
    :cond_13
    aget-object v2, v9, v8

    check-cast v2, Lcom/sun/mail/imap/protocol/FetchResponse;

    .line 1068
    invoke-virtual {v2}, Lcom/sun/mail/imap/protocol/FetchResponse;->getNumber()I

    move-result v3

    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/sun/mail/imap/IMAPFolder;->getMessageBySeqNumber(I)Lcom/sun/mail/imap/IMAPMessage;

    move-result-object v12

    .line 1070
    invoke-virtual {v2}, Lcom/sun/mail/imap/protocol/FetchResponse;->getItemCount()I

    move-result v13

    .line 1071
    const/4 v6, 0x0

    .line 1073
    const/4 v3, 0x0

    move v7, v3

    :goto_d
    if-lt v7, v13, :cond_14

    .line 1155
    if-eqz v6, :cond_11

    .line 1156
    invoke-virtual {v11, v2}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    goto :goto_c

    .line 1074
    :cond_14
    invoke-virtual {v2, v7}, Lcom/sun/mail/imap/protocol/FetchResponse;->getItem(I)Lcom/sun/mail/imap/protocol/Item;

    move-result-object v3

    .line 1077
    instance-of v14, v3, Ljavax/mail/Flags;

    if-eqz v14, :cond_17

    .line 1078
    sget-object v14, Ljavax/mail/FetchProfile$Item;->FLAGS:Ljavax/mail/FetchProfile$Item;

    move-object/from16 v0, p2

    invoke-virtual {v0, v14}, Ljavax/mail/FetchProfile;->contains(Ljavax/mail/FetchProfile$Item;)Z

    move-result v14

    if-eqz v14, :cond_15

    .line 1079
    if-nez v12, :cond_16

    .line 1081
    :cond_15
    const/4 v3, 0x1

    .line 1073
    :goto_e
    add-int/lit8 v6, v7, 0x1

    move v7, v6

    move v6, v3

    goto :goto_d

    .line 1083
    :cond_16
    check-cast v3, Ljavax/mail/Flags;

    iput-object v3, v12, Lcom/sun/mail/imap/IMAPMessage;->flags:Ljavax/mail/Flags;

    move v3, v6

    goto :goto_e

    .line 1087
    :cond_17
    instance-of v14, v3, Lcom/sun/mail/imap/protocol/ENVELOPE;

    if-eqz v14, :cond_18

    .line 1088
    check-cast v3, Lcom/sun/mail/imap/protocol/ENVELOPE;

    iput-object v3, v12, Lcom/sun/mail/imap/IMAPMessage;->envelope:Lcom/sun/mail/imap/protocol/ENVELOPE;

    move v3, v6

    goto :goto_e

    .line 1089
    :cond_18
    instance-of v14, v3, Lcom/sun/mail/imap/protocol/INTERNALDATE;

    if-eqz v14, :cond_19

    .line 1090
    check-cast v3, Lcom/sun/mail/imap/protocol/INTERNALDATE;

    invoke-virtual {v3}, Lcom/sun/mail/imap/protocol/INTERNALDATE;->getDate()Ljava/util/Date;

    move-result-object v3

    iput-object v3, v12, Lcom/sun/mail/imap/IMAPMessage;->receivedDate:Ljava/util/Date;

    move v3, v6

    goto :goto_e

    .line 1091
    :cond_19
    instance-of v14, v3, Lcom/sun/mail/imap/protocol/RFC822SIZE;

    if-eqz v14, :cond_1a

    .line 1092
    check-cast v3, Lcom/sun/mail/imap/protocol/RFC822SIZE;

    iget v3, v3, Lcom/sun/mail/imap/protocol/RFC822SIZE;->size:I

    iput v3, v12, Lcom/sun/mail/imap/IMAPMessage;->size:I

    move v3, v6

    goto :goto_e

    .line 1095
    :cond_1a
    instance-of v14, v3, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    if-eqz v14, :cond_1b

    .line 1096
    check-cast v3, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iput-object v3, v12, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    move v3, v6

    goto :goto_e

    .line 1098
    :cond_1b
    instance-of v14, v3, Lcom/sun/mail/imap/protocol/UID;

    if-eqz v14, :cond_1d

    .line 1099
    check-cast v3, Lcom/sun/mail/imap/protocol/UID;

    .line 1100
    iget-wide v14, v3, Lcom/sun/mail/imap/protocol/UID;->uid:J

    iput-wide v14, v12, Lcom/sun/mail/imap/IMAPMessage;->uid:J

    .line 1102
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/sun/mail/imap/IMAPFolder;->uidTable:Ljava/util/Hashtable;

    if-nez v14, :cond_1c

    .line 1103
    new-instance v14, Ljava/util/Hashtable;

    invoke-direct {v14}, Ljava/util/Hashtable;-><init>()V

    move-object/from16 v0, p0

    iput-object v14, v0, Lcom/sun/mail/imap/IMAPFolder;->uidTable:Ljava/util/Hashtable;

    .line 1104
    :cond_1c
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/sun/mail/imap/IMAPFolder;->uidTable:Ljava/util/Hashtable;

    new-instance v15, Ljava/lang/Long;

    iget-wide v0, v3, Lcom/sun/mail/imap/protocol/UID;->uid:J

    move-wide/from16 v16, v0

    invoke-direct/range {v15 .. v17}, Ljava/lang/Long;-><init>(J)V

    invoke-virtual {v14, v15, v12}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move v3, v6

    goto :goto_e

    .line 1108
    :cond_1d
    instance-of v14, v3, Lcom/sun/mail/imap/protocol/RFC822DATA;

    if-nez v14, :cond_1e

    .line 1109
    instance-of v14, v3, Lcom/sun/mail/imap/protocol/BODY;

    if-eqz v14, :cond_25

    .line 1111
    :cond_1e
    instance-of v14, v3, Lcom/sun/mail/imap/protocol/RFC822DATA;

    if-eqz v14, :cond_21

    .line 1113
    check-cast v3, Lcom/sun/mail/imap/protocol/RFC822DATA;

    invoke-virtual {v3}, Lcom/sun/mail/imap/protocol/RFC822DATA;->getByteArrayInputStream()Ljava/io/ByteArrayInputStream;

    move-result-object v3

    .line 1119
    :goto_f
    new-instance v14, Ljavax/mail/internet/InternetHeaders;

    invoke-direct {v14}, Ljavax/mail/internet/InternetHeaders;-><init>()V

    .line 1120
    invoke-virtual {v14, v3}, Ljavax/mail/internet/InternetHeaders;->load(Ljava/io/InputStream;)V

    .line 1121
    iget-object v3, v12, Lcom/sun/mail/imap/IMAPMessage;->headers:Ljavax/mail/internet/InternetHeaders;

    if-eqz v3, :cond_1f

    if-eqz v4, :cond_22

    .line 1122
    :cond_1f
    iput-object v14, v12, Lcom/sun/mail/imap/IMAPMessage;->headers:Ljavax/mail/internet/InternetHeaders;

    .line 1143
    :cond_20
    if-eqz v4, :cond_24

    .line 1144
    const/4 v3, 0x1

    invoke-direct {v12, v3}, Lcom/sun/mail/imap/IMAPMessage;->setHeadersLoaded(Z)V

    move v3, v6

    goto/16 :goto_e

    .line 1116
    :cond_21
    check-cast v3, Lcom/sun/mail/imap/protocol/BODY;

    invoke-virtual {v3}, Lcom/sun/mail/imap/protocol/BODY;->getByteArrayInputStream()Ljava/io/ByteArrayInputStream;

    move-result-object v3

    goto :goto_f

    .line 1133
    :cond_22
    invoke-virtual {v14}, Ljavax/mail/internet/InternetHeaders;->getAllHeaders()Ljava/util/Enumeration;

    move-result-object v14

    .line 1134
    :cond_23
    :goto_10
    invoke-interface {v14}, Ljava/util/Enumeration;->hasMoreElements()Z

    move-result v3

    if-eqz v3, :cond_20

    .line 1135
    invoke-interface {v14}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljavax/mail/Header;

    .line 1136
    invoke-virtual {v3}, Ljavax/mail/Header;->getName()Ljava/lang/String;

    move-result-object v15

    invoke-direct {v12, v15}, Lcom/sun/mail/imap/IMAPMessage;->isHeaderLoaded(Ljava/lang/String;)Z

    move-result v15

    if-nez v15, :cond_23

    .line 1137
    iget-object v15, v12, Lcom/sun/mail/imap/IMAPMessage;->headers:Ljavax/mail/internet/InternetHeaders;

    .line 1138
    invoke-virtual {v3}, Ljavax/mail/Header;->getName()Ljava/lang/String;

    move-result-object v16

    invoke-virtual {v3}, Ljavax/mail/Header;->getValue()Ljava/lang/String;

    move-result-object v3

    .line 1137
    move-object/from16 v0, v16

    invoke-virtual {v15, v0, v3}, Ljavax/mail/internet/InternetHeaders;->addHeader(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_10

    .line 1147
    :cond_24
    const/4 v3, 0x0

    :goto_11
    array-length v14, v5

    if-lt v3, v14, :cond_26

    :cond_25
    move v3, v6

    goto/16 :goto_e

    .line 1148
    :cond_26
    aget-object v14, v5, v3

    invoke-direct {v12, v14}, Lcom/sun/mail/imap/IMAPMessage;->setHeaderLoaded(Ljava/lang/String;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 1147
    add-int/lit8 v3, v3, 0x1

    goto :goto_11

    :cond_27
    move v3, v2

    goto/16 :goto_7

    :cond_28
    move v4, v3

    goto/16 :goto_5
.end method

.method private declared-synchronized isHeaderLoaded(Ljava/lang/String;)Z
    .locals 2

    .prologue
    .line 1372
    monitor-enter p0

    :try_start_0
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPMessage;->headersLoaded:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v0, :cond_0

    .line 1373
    const/4 v0, 0x1

    .line 1375
    :goto_0
    monitor-exit p0

    return v0

    :cond_0
    :try_start_1
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->loadedHeaders:Ljava/util/Hashtable;

    if-eqz v0, :cond_1

    .line 1376
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->loadedHeaders:Ljava/util/Hashtable;

    sget-object v1, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {p1, v1}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/Hashtable;->containsKey(Ljava/lang/Object;)Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result v0

    goto :goto_0

    .line 1377
    :cond_1
    const/4 v0, 0x0

    goto :goto_0

    .line 1372
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method private declared-synchronized loadBODYSTRUCTURE()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 1256
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    if-eqz v0, :cond_0

    .line 1283
    :goto_0
    monitor-exit p0

    return-void

    .line 1260
    :cond_0
    :try_start_1
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getMessageCacheLock()Ljava/lang/Object;

    move-result-object v1

    monitor-enter v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 1262
    :try_start_2
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getProtocol()Lcom/sun/mail/imap/protocol/IMAPProtocol;

    move-result-object v0

    .line 1266
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 1268
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getSequenceNumber()I

    move-result v2

    invoke-virtual {v0, v2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->fetchBodyStructure(I)Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    move-result-object v0

    iput-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;
    :try_end_2
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 1275
    :try_start_3
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    if-nez v0, :cond_1

    .line 1279
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->forceCheckExpunged()V

    .line 1280
    new-instance v0, Ljavax/mail/MessagingException;

    const-string v2, "Unable to load BODYSTRUCTURE"

    invoke-direct {v0, v2}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1260
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :try_start_4
    throw v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    .line 1256
    :catchall_1
    move-exception v0

    monitor-exit p0

    throw v0

    .line 1269
    :catch_0
    move-exception v0

    .line 1270
    :try_start_5
    new-instance v2, Ljavax/mail/FolderClosedException;

    iget-object v3, p0, Lcom/sun/mail/imap/IMAPMessage;->folder:Ljavax/mail/Folder;

    invoke-virtual {v0}, Lcom/sun/mail/iap/ConnectionException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v2, v3, v0}, Ljavax/mail/FolderClosedException;-><init>(Ljavax/mail/Folder;Ljava/lang/String;)V

    throw v2

    .line 1271
    :catch_1
    move-exception v0

    .line 1272
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->forceCheckExpunged()V

    .line 1273
    new-instance v2, Ljavax/mail/MessagingException;

    invoke-virtual {v0}, Lcom/sun/mail/iap/ProtocolException;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v2

    .line 1260
    :cond_1
    monitor-exit v1
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    goto :goto_0
.end method

.method private declared-synchronized loadEnvelope()V
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    const/4 v3, 0x0

    .line 1174
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->envelope:Lcom/sun/mail/imap/protocol/ENVELOPE;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v0, :cond_1

    .line 1227
    :cond_0
    monitor-exit p0

    return-void

    .line 1177
    :cond_1
    const/4 v0, 0x0

    :try_start_1
    check-cast v0, [Lcom/sun/mail/iap/Response;

    .line 1180
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getMessageCacheLock()Ljava/lang/Object;

    move-result-object v5

    monitor-enter v5
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1182
    :try_start_2
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getProtocol()Lcom/sun/mail/imap/protocol/IMAPProtocol;

    move-result-object v6

    .line 1184
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 1186
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getSequenceNumber()I

    move-result v7

    .line 1187
    sget-object v0, Lcom/sun/mail/imap/IMAPMessage;->EnvelopeCmd:Ljava/lang/String;

    invoke-virtual {v6, v7, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->fetch(ILjava/lang/String;)[Lcom/sun/mail/iap/Response;

    move-result-object v8

    move v4, v3

    .line 1189
    :goto_0
    array-length v0, v8

    if-lt v4, v0, :cond_2

    .line 1214
    invoke-virtual {v6, v8}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 1215
    array-length v0, v8

    add-int/lit8 v0, v0, -0x1

    aget-object v0, v8, v0

    invoke-virtual {v6, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->handleResult(Lcom/sun/mail/iap/Response;)V
    :try_end_2
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1180
    :try_start_3
    monitor-exit v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1225
    :try_start_4
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->envelope:Lcom/sun/mail/imap/protocol/ENVELOPE;

    if-nez v0, :cond_0

    .line 1226
    new-instance v0, Ljavax/mail/MessagingException;

    const-string v1, "Failed to load IMAP envelope"

    invoke-direct {v0, v1}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 1174
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    .line 1192
    :cond_2
    :try_start_5
    aget-object v0, v8, v4

    if-eqz v0, :cond_3

    .line 1193
    aget-object v0, v8, v4

    instance-of v0, v0, Lcom/sun/mail/imap/protocol/FetchResponse;

    if-eqz v0, :cond_3

    .line 1194
    aget-object v0, v8, v4

    check-cast v0, Lcom/sun/mail/imap/protocol/FetchResponse;

    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/FetchResponse;->getNumber()I

    move-result v0

    if-eq v0, v7, :cond_4

    .line 1189
    :cond_3
    add-int/lit8 v0, v4, 0x1

    move v4, v0

    goto :goto_0

    .line 1197
    :cond_4
    aget-object v0, v8, v4

    check-cast v0, Lcom/sun/mail/imap/protocol/FetchResponse;

    .line 1200
    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/FetchResponse;->getItemCount()I

    move-result v9

    move v2, v3

    .line 1201
    :goto_1
    if-ge v2, v9, :cond_3

    .line 1202
    invoke-virtual {v0, v2}, Lcom/sun/mail/imap/protocol/FetchResponse;->getItem(I)Lcom/sun/mail/imap/protocol/Item;

    move-result-object v1

    .line 1204
    instance-of v10, v1, Lcom/sun/mail/imap/protocol/ENVELOPE;

    if-eqz v10, :cond_6

    .line 1205
    check-cast v1, Lcom/sun/mail/imap/protocol/ENVELOPE;

    iput-object v1, p0, Lcom/sun/mail/imap/IMAPMessage;->envelope:Lcom/sun/mail/imap/protocol/ENVELOPE;

    .line 1201
    :cond_5
    :goto_2
    add-int/lit8 v1, v2, 0x1

    move v2, v1

    goto :goto_1

    .line 1206
    :cond_6
    instance-of v10, v1, Lcom/sun/mail/imap/protocol/INTERNALDATE;

    if-eqz v10, :cond_7

    .line 1207
    check-cast v1, Lcom/sun/mail/imap/protocol/INTERNALDATE;

    invoke-virtual {v1}, Lcom/sun/mail/imap/protocol/INTERNALDATE;->getDate()Ljava/util/Date;

    move-result-object v1

    iput-object v1, p0, Lcom/sun/mail/imap/IMAPMessage;->receivedDate:Ljava/util/Date;
    :try_end_5
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_5 .. :try_end_5} :catch_0
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_5 .. :try_end_5} :catch_1
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    goto :goto_2

    .line 1216
    :catch_0
    move-exception v0

    .line 1217
    :try_start_6
    new-instance v1, Ljavax/mail/FolderClosedException;

    iget-object v2, p0, Lcom/sun/mail/imap/IMAPMessage;->folder:Ljavax/mail/Folder;

    invoke-virtual {v0}, Lcom/sun/mail/iap/ConnectionException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v2, v0}, Ljavax/mail/FolderClosedException;-><init>(Ljavax/mail/Folder;Ljava/lang/String;)V

    throw v1

    .line 1180
    :catchall_1
    move-exception v0

    monitor-exit v5
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    :try_start_7
    throw v0
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    .line 1208
    :cond_7
    :try_start_8
    instance-of v10, v1, Lcom/sun/mail/imap/protocol/RFC822SIZE;

    if-eqz v10, :cond_5

    .line 1209
    check-cast v1, Lcom/sun/mail/imap/protocol/RFC822SIZE;

    iget v1, v1, Lcom/sun/mail/imap/protocol/RFC822SIZE;->size:I

    iput v1, p0, Lcom/sun/mail/imap/IMAPMessage;->size:I
    :try_end_8
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_8 .. :try_end_8} :catch_0
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_8 .. :try_end_8} :catch_1
    .catchall {:try_start_8 .. :try_end_8} :catchall_1

    goto :goto_2

    .line 1218
    :catch_1
    move-exception v0

    .line 1219
    :try_start_9
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->forceCheckExpunged()V

    .line 1220
    new-instance v1, Ljavax/mail/MessagingException;

    invoke-virtual {v0}, Lcom/sun/mail/iap/ProtocolException;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v1
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_1
.end method

.method private declared-synchronized loadFlags()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 1332
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->flags:Ljavax/mail/Flags;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    if-eqz v0, :cond_0

    .line 1352
    :goto_0
    monitor-exit p0

    return-void

    .line 1336
    :cond_0
    :try_start_1
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getMessageCacheLock()Ljava/lang/Object;

    move-result-object v1

    monitor-enter v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 1338
    :try_start_2
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getProtocol()Lcom/sun/mail/imap/protocol/IMAPProtocol;

    move-result-object v0

    .line 1342
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 1344
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getSequenceNumber()I

    move-result v2

    invoke-virtual {v0, v2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->fetchFlags(I)Ljavax/mail/Flags;

    move-result-object v0

    iput-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->flags:Ljavax/mail/Flags;
    :try_end_2
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 1336
    :try_start_3
    monitor-exit v1

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :try_start_4
    throw v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    .line 1332
    :catchall_1
    move-exception v0

    monitor-exit p0

    throw v0

    .line 1345
    :catch_0
    move-exception v0

    .line 1346
    :try_start_5
    new-instance v2, Ljavax/mail/FolderClosedException;

    iget-object v3, p0, Lcom/sun/mail/imap/IMAPMessage;->folder:Ljavax/mail/Folder;

    invoke-virtual {v0}, Lcom/sun/mail/iap/ConnectionException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v2, v3, v0}, Ljavax/mail/FolderClosedException;-><init>(Ljavax/mail/Folder;Ljava/lang/String;)V

    throw v2

    .line 1347
    :catch_1
    move-exception v0

    .line 1348
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->forceCheckExpunged()V

    .line 1349
    new-instance v2, Ljavax/mail/MessagingException;

    invoke-virtual {v0}, Lcom/sun/mail/iap/ProtocolException;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v2
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0
.end method

.method private declared-synchronized loadHeaders()V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 1289
    monitor-enter p0

    :try_start_0
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPMessage;->headersLoaded:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v0, :cond_0

    .line 1326
    :goto_0
    monitor-exit p0

    return-void

    .line 1292
    :cond_0
    const/4 v0, 0x0

    .line 1295
    :try_start_1
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getMessageCacheLock()Ljava/lang/Object;

    move-result-object v1

    monitor-enter v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1297
    :try_start_2
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getProtocol()Lcom/sun/mail/imap/protocol/IMAPProtocol;

    move-result-object v2

    .line 1301
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 1303
    invoke-virtual {v2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->isREV1()Z

    move-result v3

    if-eqz v3, :cond_2

    .line 1304
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getSequenceNumber()I

    move-result v3

    .line 1305
    const-string v4, "HEADER"

    invoke-direct {p0, v4}, Lcom/sun/mail/imap/IMAPMessage;->toSection(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 1304
    invoke-virtual {v2, v3, v4}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->peekBody(ILjava/lang/String;)Lcom/sun/mail/imap/protocol/BODY;

    move-result-object v2

    .line 1306
    if-eqz v2, :cond_1

    .line 1307
    invoke-virtual {v2}, Lcom/sun/mail/imap/protocol/BODY;->getByteArrayInputStream()Ljava/io/ByteArrayInputStream;
    :try_end_2
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    move-result-object v0

    .line 1295
    :cond_1
    :goto_1
    :try_start_3
    monitor-exit v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1322
    if-nez v0, :cond_3

    .line 1323
    :try_start_4
    new-instance v0, Ljavax/mail/MessagingException;

    const-string v1, "Cannot load header"

    invoke-direct {v0, v1}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 1289
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    .line 1309
    :cond_2
    :try_start_5
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getSequenceNumber()I

    move-result v3

    .line 1310
    const-string v4, "HEADER"

    .line 1309
    invoke-virtual {v2, v3, v4}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->fetchRFC822(ILjava/lang/String;)Lcom/sun/mail/imap/protocol/RFC822DATA;

    move-result-object v2

    .line 1311
    if-eqz v2, :cond_1

    .line 1312
    invoke-virtual {v2}, Lcom/sun/mail/imap/protocol/RFC822DATA;->getByteArrayInputStream()Ljava/io/ByteArrayInputStream;
    :try_end_5
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_5 .. :try_end_5} :catch_0
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_5 .. :try_end_5} :catch_1
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    move-result-object v0

    goto :goto_1

    .line 1314
    :catch_0
    move-exception v0

    .line 1315
    :try_start_6
    new-instance v2, Ljavax/mail/FolderClosedException;

    iget-object v3, p0, Lcom/sun/mail/imap/IMAPMessage;->folder:Ljavax/mail/Folder;

    invoke-virtual {v0}, Lcom/sun/mail/iap/ConnectionException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v2, v3, v0}, Ljavax/mail/FolderClosedException;-><init>(Ljavax/mail/Folder;Ljava/lang/String;)V

    throw v2

    .line 1295
    :catchall_1
    move-exception v0

    monitor-exit v1
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    :try_start_7
    throw v0
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    .line 1316
    :catch_1
    move-exception v0

    .line 1317
    :try_start_8
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->forceCheckExpunged()V

    .line 1318
    new-instance v2, Ljavax/mail/MessagingException;

    invoke-virtual {v0}, Lcom/sun/mail/iap/ProtocolException;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v2
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_1

    .line 1324
    :cond_3
    :try_start_9
    new-instance v1, Ljavax/mail/internet/InternetHeaders;

    invoke-direct {v1, v0}, Ljavax/mail/internet/InternetHeaders;-><init>(Ljava/io/InputStream;)V

    iput-object v1, p0, Lcom/sun/mail/imap/IMAPMessage;->headers:Ljavax/mail/internet/InternetHeaders;

    .line 1325
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/sun/mail/imap/IMAPMessage;->headersLoaded:Z
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_0

    goto :goto_0
.end method

.method private declared-synchronized setHeaderLoaded(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 1384
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->loadedHeaders:Ljava/util/Hashtable;

    if-nez v0, :cond_0

    .line 1385
    new-instance v0, Ljava/util/Hashtable;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Ljava/util/Hashtable;-><init>(I)V

    iput-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->loadedHeaders:Ljava/util/Hashtable;

    .line 1386
    :cond_0
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->loadedHeaders:Ljava/util/Hashtable;

    sget-object v1, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {p1, v1}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, p1}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1387
    monitor-exit p0

    return-void

    .line 1384
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method private declared-synchronized setHeadersLoaded(Z)V
    .locals 1

    .prologue
    .line 1365
    monitor-enter p0

    :try_start_0
    iput-boolean p1, p0, Lcom/sun/mail/imap/IMAPMessage;->headersLoaded:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1366
    monitor-exit p0

    return-void

    .line 1365
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method private toSection(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 1394
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->sectionId:Ljava/lang/String;

    if-nez v0, :cond_0

    .line 1397
    :goto_0
    return-object p1

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/sun/mail/imap/IMAPMessage;->sectionId:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "."

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    goto :goto_0
.end method


# virtual methods
.method _getSession()Ljavax/mail/Session;
    .locals 1

    .prologue
    .line 1439
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->session:Ljavax/mail/Session;

    return-object v0
.end method

.method _setFlags(Ljavax/mail/Flags;)V
    .locals 0

    .prologue
    .line 1432
    iput-object p1, p0, Lcom/sun/mail/imap/IMAPMessage;->flags:Ljavax/mail/Flags;

    .line 1433
    return-void
.end method

.method public addFrom([Ljavax/mail/Address;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 261
    new-instance v0, Ljavax/mail/IllegalWriteException;

    const-string v1, "IMAPMessage is read-only"

    invoke-direct {v0, v1}, Ljavax/mail/IllegalWriteException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public addHeader(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 774
    new-instance v0, Ljavax/mail/IllegalWriteException;

    const-string v1, "IMAPMessage is read-only"

    invoke-direct {v0, v1}, Ljavax/mail/IllegalWriteException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public addHeaderLine(Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 812
    new-instance v0, Ljavax/mail/IllegalWriteException;

    const-string v1, "IMAPMessage is read-only"

    invoke-direct {v0, v1}, Ljavax/mail/IllegalWriteException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public addRecipients(Ljavax/mail/Message$RecipientType;[Ljavax/mail/Address;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 306
    new-instance v0, Ljavax/mail/IllegalWriteException;

    const-string v1, "IMAPMessage is read-only"

    invoke-direct {v0, v1}, Ljavax/mail/IllegalWriteException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected checkExpunged()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessageRemovedException;
        }
    .end annotation

    .prologue
    .line 219
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPMessage;->expunged:Z

    if-eqz v0, :cond_0

    .line 220
    new-instance v0, Ljavax/mail/MessageRemovedException;

    invoke-direct {v0}, Ljavax/mail/MessageRemovedException;-><init>()V

    throw v0

    .line 221
    :cond_0
    return-void
.end method

.method protected forceCheckExpunged()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessageRemovedException;,
            Ljavax/mail/FolderClosedException;
        }
    .end annotation

    .prologue
    .line 229
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getMessageCacheLock()Ljava/lang/Object;

    move-result-object v1

    monitor-enter v1

    .line 231
    :try_start_0
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getProtocol()Lcom/sun/mail/imap/protocol/IMAPProtocol;

    move-result-object v0

    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->noop()V
    :try_end_0
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 229
    :goto_0
    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 238
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPMessage;->expunged:Z

    if-eqz v0, :cond_0

    .line 239
    new-instance v0, Ljavax/mail/MessageRemovedException;

    invoke-direct {v0}, Ljavax/mail/MessageRemovedException;-><init>()V

    throw v0

    .line 232
    :catch_0
    move-exception v0

    .line 233
    :try_start_2
    new-instance v2, Ljavax/mail/FolderClosedException;

    iget-object v3, p0, Lcom/sun/mail/imap/IMAPMessage;->folder:Ljavax/mail/Folder;

    invoke-virtual {v0}, Lcom/sun/mail/iap/ConnectionException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v2, v3, v0}, Ljavax/mail/FolderClosedException;-><init>(Ljavax/mail/Folder;Ljava/lang/String;)V

    throw v2

    .line 229
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0

    .line 240
    :cond_0
    return-void

    .line 234
    :catch_1
    move-exception v0

    goto :goto_0
.end method

.method public getAllHeaderLines()Ljava/util/Enumeration;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 819
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 820
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPMessage;->loadHeaders()V

    .line 821
    invoke-super {p0}, Ljavax/mail/internet/MimeMessage;->getAllHeaderLines()Ljava/util/Enumeration;

    move-result-object v0

    return-object v0
.end method

.method public getAllHeaders()Ljava/util/Enumeration;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 786
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 787
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPMessage;->loadHeaders()V

    .line 788
    invoke-super {p0}, Ljavax/mail/internet/MimeMessage;->getAllHeaders()Ljava/util/Enumeration;

    move-result-object v0

    return-object v0
.end method

.method public getContentID()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 477
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 478
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPMessage;->loadBODYSTRUCTURE()V

    .line 479
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->id:Ljava/lang/String;

    return-object v0
.end method

.method public getContentLanguage()[Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 408
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 409
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPMessage;->loadBODYSTRUCTURE()V

    .line 410
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->language:[Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 411
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->language:[Ljava/lang/String;

    invoke-virtual {v0}, [Ljava/lang/String;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    .line 413
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public getContentMD5()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 490
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 491
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPMessage;->loadBODYSTRUCTURE()V

    .line 492
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->md5:Ljava/lang/String;

    return-object v0
.end method

.method protected getContentStream()Ljava/io/InputStream;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    const/4 v1, -0x1

    .line 565
    const/4 v0, 0x0

    .line 566
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getPeek()Z

    move-result v2

    .line 569
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getMessageCacheLock()Ljava/lang/Object;

    move-result-object v3

    monitor-enter v3

    .line 571
    :try_start_0
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getProtocol()Lcom/sun/mail/imap/protocol/IMAPProtocol;

    move-result-object v4

    .line 575
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 577
    invoke-virtual {v4}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->isREV1()Z

    move-result v5

    if-eqz v5, :cond_2

    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getFetchBlockSize()I

    move-result v5

    if-eq v5, v1, :cond_2

    .line 578
    new-instance v0, Lcom/sun/mail/imap/IMAPInputStream;

    const-string v4, "TEXT"

    invoke-direct {p0, v4}, Lcom/sun/mail/imap/IMAPMessage;->toSection(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 579
    iget-object v5, p0, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    if-eqz v5, :cond_0

    iget-object v1, p0, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget v1, v1, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->size:I

    .line 578
    :cond_0
    invoke-direct {v0, p0, v4, v1, v2}, Lcom/sun/mail/imap/IMAPInputStream;-><init>(Lcom/sun/mail/imap/IMAPMessage;Ljava/lang/String;IZ)V
    :try_end_0
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    monitor-exit v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 605
    :cond_1
    return-object v0

    .line 581
    :cond_2
    :try_start_2
    invoke-virtual {v4}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->isREV1()Z

    move-result v1

    if-eqz v1, :cond_5

    .line 583
    if-eqz v2, :cond_4

    .line 584
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getSequenceNumber()I

    move-result v1

    const-string v2, "TEXT"

    invoke-direct {p0, v2}, Lcom/sun/mail/imap/IMAPMessage;->toSection(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v4, v1, v2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->peekBody(ILjava/lang/String;)Lcom/sun/mail/imap/protocol/BODY;

    move-result-object v1

    .line 587
    :goto_0
    if-eqz v1, :cond_3

    .line 588
    invoke-virtual {v1}, Lcom/sun/mail/imap/protocol/BODY;->getByteArrayInputStream()Ljava/io/ByteArrayInputStream;
    :try_end_2
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-result-object v0

    .line 569
    :cond_3
    :goto_1
    :try_start_3
    monitor-exit v3
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 602
    if-nez v0, :cond_1

    .line 603
    new-instance v0, Ljavax/mail/MessagingException;

    const-string v1, "No content"

    invoke-direct {v0, v1}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 586
    :cond_4
    :try_start_4
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getSequenceNumber()I

    move-result v1

    const-string v2, "TEXT"

    invoke-direct {p0, v2}, Lcom/sun/mail/imap/IMAPMessage;->toSection(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v4, v1, v2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->fetchBody(ILjava/lang/String;)Lcom/sun/mail/imap/protocol/BODY;

    move-result-object v1

    goto :goto_0

    .line 590
    :cond_5
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getSequenceNumber()I

    move-result v1

    const-string v2, "TEXT"

    invoke-virtual {v4, v1, v2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->fetchRFC822(ILjava/lang/String;)Lcom/sun/mail/imap/protocol/RFC822DATA;

    move-result-object v1

    .line 591
    if-eqz v1, :cond_3

    .line 592
    invoke-virtual {v1}, Lcom/sun/mail/imap/protocol/RFC822DATA;->getByteArrayInputStream()Ljava/io/ByteArrayInputStream;
    :try_end_4
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_4 .. :try_end_4} :catch_0
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    move-result-object v0

    goto :goto_1

    .line 594
    :catch_0
    move-exception v0

    .line 595
    :try_start_5
    new-instance v1, Ljavax/mail/FolderClosedException;

    iget-object v2, p0, Lcom/sun/mail/imap/IMAPMessage;->folder:Ljavax/mail/Folder;

    invoke-virtual {v0}, Lcom/sun/mail/iap/ConnectionException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v2, v0}, Ljavax/mail/FolderClosedException;-><init>(Ljavax/mail/Folder;Ljava/lang/String;)V

    throw v1

    .line 569
    :catchall_0
    move-exception v0

    monitor-exit v3
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    throw v0

    .line 596
    :catch_1
    move-exception v0

    .line 597
    :try_start_6
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->forceCheckExpunged()V

    .line 598
    new-instance v1, Ljavax/mail/MessagingException;

    invoke-virtual {v0}, Lcom/sun/mail/iap/ProtocolException;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v1
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0
.end method

.method public getContentType()Ljava/lang/String;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 439
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 442
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->type:Ljava/lang/String;

    if-nez v0, :cond_0

    .line 443
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPMessage;->loadBODYSTRUCTURE()V

    .line 445
    new-instance v0, Ljavax/mail/internet/ContentType;

    iget-object v1, p0, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v1, v1, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->type:Ljava/lang/String;

    iget-object v2, p0, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v2, v2, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->subtype:Ljava/lang/String;

    iget-object v3, p0, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v3, v3, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->cParams:Ljavax/mail/internet/ParameterList;

    invoke-direct {v0, v1, v2, v3}, Ljavax/mail/internet/ContentType;-><init>(Ljava/lang/String;Ljava/lang/String;Ljavax/mail/internet/ParameterList;)V

    .line 446
    invoke-virtual {v0}, Ljavax/mail/internet/ContentType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->type:Ljava/lang/String;

    .line 448
    :cond_0
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->type:Ljava/lang/String;

    return-object v0
.end method

.method public declared-synchronized getDataHandler()Ljavax/activation/DataHandler;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 613
    monitor-enter p0

    :try_start_0
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 615
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->dh:Ljavax/activation/DataHandler;

    if-nez v0, :cond_1

    .line 616
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPMessage;->loadBODYSTRUCTURE()V

    .line 617
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->type:Ljava/lang/String;

    if-nez v0, :cond_0

    .line 619
    new-instance v0, Ljavax/mail/internet/ContentType;

    iget-object v1, p0, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v1, v1, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->type:Ljava/lang/String;

    iget-object v2, p0, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v2, v2, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->subtype:Ljava/lang/String;

    .line 620
    iget-object v3, p0, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v3, v3, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->cParams:Ljavax/mail/internet/ParameterList;

    .line 619
    invoke-direct {v0, v1, v2, v3}, Ljavax/mail/internet/ContentType;-><init>(Ljava/lang/String;Ljava/lang/String;Ljavax/mail/internet/ParameterList;)V

    .line 621
    invoke-virtual {v0}, Ljavax/mail/internet/ContentType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->type:Ljava/lang/String;

    .line 627
    :cond_0
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->isMulti()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 628
    new-instance v0, Ljavax/activation/DataHandler;

    .line 629
    new-instance v1, Lcom/sun/mail/imap/IMAPMultipartDataSource;

    iget-object v2, p0, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v2, v2, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->bodies:[Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    .line 630
    iget-object v3, p0, Lcom/sun/mail/imap/IMAPMessage;->sectionId:Ljava/lang/String;

    .line 629
    invoke-direct {v1, p0, v2, v3, p0}, Lcom/sun/mail/imap/IMAPMultipartDataSource;-><init>(Ljavax/mail/internet/MimePart;[Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;Ljava/lang/String;Lcom/sun/mail/imap/IMAPMessage;)V

    invoke-direct {v0, v1}, Ljavax/activation/DataHandler;-><init>(Ljavax/activation/DataSource;)V

    .line 628
    iput-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->dh:Ljavax/activation/DataHandler;

    .line 646
    :cond_1
    :goto_0
    invoke-super {p0}, Ljavax/mail/internet/MimeMessage;->getDataHandler()Ljavax/activation/DataHandler;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    monitor-exit p0

    return-object v0

    .line 632
    :cond_2
    :try_start_1
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->isNested()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->isREV1()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 637
    new-instance v1, Ljavax/activation/DataHandler;

    .line 638
    new-instance v2, Lcom/sun/mail/imap/IMAPNestedMessage;

    .line 639
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->bodies:[Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    const/4 v3, 0x0

    aget-object v3, v0, v3

    .line 640
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v4, v0, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->envelope:Lcom/sun/mail/imap/protocol/ENVELOPE;

    .line 641
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->sectionId:Ljava/lang/String;

    if-nez v0, :cond_3

    const-string v0, "1"

    .line 638
    :goto_1
    invoke-direct {v2, p0, v3, v4, v0}, Lcom/sun/mail/imap/IMAPNestedMessage;-><init>(Lcom/sun/mail/imap/IMAPMessage;Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;Lcom/sun/mail/imap/protocol/ENVELOPE;Ljava/lang/String;)V

    .line 642
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->type:Ljava/lang/String;

    invoke-direct {v1, v2, v0}, Ljavax/activation/DataHandler;-><init>(Ljava/lang/Object;Ljava/lang/String;)V

    .line 637
    iput-object v1, p0, Lcom/sun/mail/imap/IMAPMessage;->dh:Ljavax/activation/DataHandler;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 613
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    .line 641
    :cond_3
    :try_start_2
    new-instance v0, Ljava/lang/StringBuilder;

    iget-object v5, p0, Lcom/sun/mail/imap/IMAPMessage;->sectionId:Ljava/lang/String;

    invoke-static {v5}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v0, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v5, ".1"

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-result-object v0

    goto :goto_1
.end method

.method public getDescription()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 503
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 505
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->description:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 506
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->description:Ljava/lang/String;

    .line 518
    :goto_0
    return-object v0

    .line 508
    :cond_0
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPMessage;->loadBODYSTRUCTURE()V

    .line 509
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->description:Ljava/lang/String;

    if-nez v0, :cond_1

    .line 510
    const/4 v0, 0x0

    goto :goto_0

    .line 513
    :cond_1
    :try_start_0
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->description:Ljava/lang/String;

    invoke-static {v0}, Ljavax/mail/internet/MimeUtility;->decodeText(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->description:Ljava/lang/String;
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    .line 518
    :goto_1
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->description:Ljava/lang/String;

    goto :goto_0

    .line 514
    :catch_0
    move-exception v0

    .line 515
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->description:Ljava/lang/String;

    iput-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->description:Ljava/lang/String;

    goto :goto_1
.end method

.method public getDisposition()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 455
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 456
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPMessage;->loadBODYSTRUCTURE()V

    .line 457
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->disposition:Ljava/lang/String;

    return-object v0
.end method

.method public getEncoding()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 468
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 469
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPMessage;->loadBODYSTRUCTURE()V

    .line 470
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->encoding:Ljava/lang/String;

    return-object v0
.end method

.method protected getFetchBlockSize()I
    .locals 1

    .prologue
    .line 244
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->folder:Ljavax/mail/Folder;

    invoke-virtual {v0}, Ljavax/mail/Folder;->getStore()Ljavax/mail/Store;

    move-result-object v0

    check-cast v0, Lcom/sun/mail/imap/IMAPStore;

    invoke-virtual {v0}, Lcom/sun/mail/imap/IMAPStore;->getFetchBlockSize()I

    move-result v0

    return v0
.end method

.method public getFileName()Ljava/lang/String;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 541
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 543
    const/4 v0, 0x0

    .line 544
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPMessage;->loadBODYSTRUCTURE()V

    .line 546
    iget-object v1, p0, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v1, v1, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->dParams:Ljavax/mail/internet/ParameterList;

    if-eqz v1, :cond_0

    .line 547
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->dParams:Ljavax/mail/internet/ParameterList;

    const-string v1, "filename"

    invoke-virtual {v0, v1}, Ljavax/mail/internet/ParameterList;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 548
    :cond_0
    if-nez v0, :cond_1

    iget-object v1, p0, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v1, v1, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->cParams:Ljavax/mail/internet/ParameterList;

    if-eqz v1, :cond_1

    .line 549
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->cParams:Ljavax/mail/internet/ParameterList;

    const-string v1, "name"

    invoke-virtual {v0, v1}, Ljavax/mail/internet/ParameterList;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 550
    :cond_1
    return-object v0
.end method

.method public declared-synchronized getFlags()Ljavax/mail/Flags;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 848
    monitor-enter p0

    :try_start_0
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 849
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPMessage;->loadFlags()V

    .line 850
    invoke-super {p0}, Ljavax/mail/internet/MimeMessage;->getFlags()Ljavax/mail/Flags;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    monitor-exit p0

    return-object v0

    .line 848
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public getFrom()[Ljavax/mail/Address;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 251
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 252
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPMessage;->loadEnvelope()V

    .line 253
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->envelope:Lcom/sun/mail/imap/protocol/ENVELOPE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/ENVELOPE;->from:[Ljavax/mail/internet/InternetAddress;

    invoke-direct {p0, v0}, Lcom/sun/mail/imap/IMAPMessage;->aaclone([Ljavax/mail/internet/InternetAddress;)[Ljavax/mail/internet/InternetAddress;

    move-result-object v0

    return-object v0
.end method

.method public getHeader(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 759
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 762
    invoke-virtual {p0, p1}, Lcom/sun/mail/imap/IMAPMessage;->getHeader(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_0

    .line 763
    const/4 v0, 0x0

    .line 764
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->headers:Ljavax/mail/internet/InternetHeaders;

    invoke-virtual {v0, p1, p2}, Ljavax/mail/internet/InternetHeaders;->getHeader(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public getHeader(Ljava/lang/String;)[Ljava/lang/String;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    .line 704
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 706
    invoke-direct {p0, p1}, Lcom/sun/mail/imap/IMAPMessage;->isHeaderLoaded(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 707
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->headers:Ljavax/mail/internet/InternetHeaders;

    invoke-virtual {v0, p1}, Ljavax/mail/internet/InternetHeaders;->getHeader(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 751
    :cond_0
    :goto_0
    return-object v0

    .line 713
    :cond_1
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getMessageCacheLock()Ljava/lang/Object;

    move-result-object v2

    monitor-enter v2

    .line 715
    :try_start_0
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getProtocol()Lcom/sun/mail/imap/protocol/IMAPProtocol;

    move-result-object v1

    .line 719
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 721
    invoke-virtual {v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->isREV1()Z

    move-result v3

    if-eqz v3, :cond_3

    .line 722
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getSequenceNumber()I

    move-result v3

    .line 723
    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "HEADER.FIELDS ("

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ")"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v4}, Lcom/sun/mail/imap/IMAPMessage;->toSection(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 722
    invoke-virtual {v1, v3, v4}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->peekBody(ILjava/lang/String;)Lcom/sun/mail/imap/protocol/BODY;

    move-result-object v1

    .line 725
    if-eqz v1, :cond_4

    .line 726
    invoke-virtual {v1}, Lcom/sun/mail/imap/protocol/BODY;->getByteArrayInputStream()Ljava/io/ByteArrayInputStream;
    :try_end_0
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v1

    .line 713
    :goto_1
    :try_start_1
    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 743
    if-eqz v1, :cond_0

    .line 746
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->headers:Ljavax/mail/internet/InternetHeaders;

    if-nez v0, :cond_2

    .line 747
    new-instance v0, Ljavax/mail/internet/InternetHeaders;

    invoke-direct {v0}, Ljavax/mail/internet/InternetHeaders;-><init>()V

    iput-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->headers:Ljavax/mail/internet/InternetHeaders;

    .line 748
    :cond_2
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->headers:Ljavax/mail/internet/InternetHeaders;

    invoke-virtual {v0, v1}, Ljavax/mail/internet/InternetHeaders;->load(Ljava/io/InputStream;)V

    .line 749
    invoke-direct {p0, p1}, Lcom/sun/mail/imap/IMAPMessage;->setHeaderLoaded(Ljava/lang/String;)V

    .line 751
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->headers:Ljavax/mail/internet/InternetHeaders;

    invoke-virtual {v0, p1}, Ljavax/mail/internet/InternetHeaders;->getHeader(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 728
    :cond_3
    :try_start_2
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getSequenceNumber()I

    move-result v3

    .line 729
    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "HEADER.LINES ("

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ")"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 728
    invoke-virtual {v1, v3, v4}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->fetchRFC822(ILjava/lang/String;)Lcom/sun/mail/imap/protocol/RFC822DATA;

    move-result-object v1

    .line 730
    if-eqz v1, :cond_4

    .line 731
    invoke-virtual {v1}, Lcom/sun/mail/imap/protocol/RFC822DATA;->getByteArrayInputStream()Ljava/io/ByteArrayInputStream;
    :try_end_2
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-result-object v1

    goto :goto_1

    .line 733
    :catch_0
    move-exception v0

    .line 734
    :try_start_3
    new-instance v1, Ljavax/mail/FolderClosedException;

    iget-object v3, p0, Lcom/sun/mail/imap/IMAPMessage;->folder:Ljavax/mail/Folder;

    invoke-virtual {v0}, Lcom/sun/mail/iap/ConnectionException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v3, v0}, Ljavax/mail/FolderClosedException;-><init>(Ljavax/mail/Folder;Ljava/lang/String;)V

    throw v1

    .line 713
    :catchall_0
    move-exception v0

    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw v0

    .line 735
    :catch_1
    move-exception v0

    .line 736
    :try_start_4
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->forceCheckExpunged()V

    .line 737
    new-instance v1, Ljavax/mail/MessagingException;

    invoke-virtual {v0}, Lcom/sun/mail/iap/ProtocolException;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v3, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v1
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    :cond_4
    move-object v1, v0

    goto :goto_1
.end method

.method public getInReplyTo()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 427
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 428
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPMessage;->loadEnvelope()V

    .line 429
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->envelope:Lcom/sun/mail/imap/protocol/ENVELOPE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/ENVELOPE;->inReplyTo:Ljava/lang/String;

    return-object v0
.end method

.method public getLineCount()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 399
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 400
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPMessage;->loadBODYSTRUCTURE()V

    .line 401
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget v0, v0, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->lines:I

    return v0
.end method

.method public getMatchingHeaderLines([Ljava/lang/String;)Ljava/util/Enumeration;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 829
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 830
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPMessage;->loadHeaders()V

    .line 831
    invoke-super {p0, p1}, Ljavax/mail/internet/MimeMessage;->getMatchingHeaderLines([Ljava/lang/String;)Ljava/util/Enumeration;

    move-result-object v0

    return-object v0
.end method

.method public getMatchingHeaders([Ljava/lang/String;)Ljava/util/Enumeration;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 796
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 797
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPMessage;->loadHeaders()V

    .line 798
    invoke-super {p0, p1}, Ljavax/mail/internet/MimeMessage;->getMatchingHeaders([Ljava/lang/String;)Ljava/util/Enumeration;

    move-result-object v0

    return-object v0
.end method

.method protected getMessageCacheLock()Ljava/lang/Object;
    .locals 1

    .prologue
    .line 172
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->folder:Ljavax/mail/Folder;

    check-cast v0, Lcom/sun/mail/imap/IMAPFolder;

    iget-object v0, v0, Lcom/sun/mail/imap/IMAPFolder;->messageCacheLock:Ljava/lang/Object;

    return-object v0
.end method

.method public getMessageID()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 530
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 531
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPMessage;->loadEnvelope()V

    .line 532
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->envelope:Lcom/sun/mail/imap/protocol/ENVELOPE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/ENVELOPE;->messageId:Ljava/lang/String;

    return-object v0
.end method

.method public getNonMatchingHeaderLines([Ljava/lang/String;)Ljava/util/Enumeration;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 839
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 840
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPMessage;->loadHeaders()V

    .line 841
    invoke-super {p0, p1}, Ljavax/mail/internet/MimeMessage;->getNonMatchingHeaderLines([Ljava/lang/String;)Ljava/util/Enumeration;

    move-result-object v0

    return-object v0
.end method

.method public getNonMatchingHeaders([Ljava/lang/String;)Ljava/util/Enumeration;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 806
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 807
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPMessage;->loadHeaders()V

    .line 808
    invoke-super {p0, p1}, Ljavax/mail/internet/MimeMessage;->getNonMatchingHeaders([Ljava/lang/String;)Ljava/util/Enumeration;

    move-result-object v0

    return-object v0
.end method

.method public declared-synchronized getPeek()Z
    .locals 1

    .prologue
    .line 899
    monitor-enter p0

    :try_start_0
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPMessage;->peek:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method protected getProtocol()Lcom/sun/mail/imap/protocol/IMAPProtocol;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;,
            Ljavax/mail/FolderClosedException;
        }
    .end annotation

    .prologue
    .line 146
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->folder:Ljavax/mail/Folder;

    check-cast v0, Lcom/sun/mail/imap/IMAPFolder;

    invoke-virtual {v0}, Lcom/sun/mail/imap/IMAPFolder;->waitIfIdle()V

    .line 147
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->folder:Ljavax/mail/Folder;

    check-cast v0, Lcom/sun/mail/imap/IMAPFolder;

    iget-object v0, v0, Lcom/sun/mail/imap/IMAPFolder;->protocol:Lcom/sun/mail/imap/protocol/IMAPProtocol;

    .line 148
    if-nez v0, :cond_0

    .line 149
    new-instance v0, Ljavax/mail/FolderClosedException;

    iget-object v1, p0, Lcom/sun/mail/imap/IMAPMessage;->folder:Ljavax/mail/Folder;

    invoke-direct {v0, v1}, Ljavax/mail/FolderClosedException;-><init>(Ljavax/mail/Folder;)V

    throw v0

    .line 151
    :cond_0
    return-object v0
.end method

.method public getReceivedDate()Ljava/util/Date;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 370
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 371
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPMessage;->loadEnvelope()V

    .line 372
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->receivedDate:Ljava/util/Date;

    if-nez v0, :cond_0

    .line 373
    const/4 v0, 0x0

    .line 375
    :goto_0
    return-object v0

    :cond_0
    new-instance v0, Ljava/util/Date;

    iget-object v1, p0, Lcom/sun/mail/imap/IMAPMessage;->receivedDate:Ljava/util/Date;

    invoke-virtual {v1}, Ljava/util/Date;->getTime()J

    move-result-wide v2

    invoke-direct {v0, v2, v3}, Ljava/util/Date;-><init>(J)V

    goto :goto_0
.end method

.method public getRecipients(Ljavax/mail/Message$RecipientType;)[Ljavax/mail/Address;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 286
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 287
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPMessage;->loadEnvelope()V

    .line 289
    sget-object v0, Ljavax/mail/Message$RecipientType;->TO:Ljavax/mail/Message$RecipientType;

    if-ne p1, v0, :cond_0

    .line 290
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->envelope:Lcom/sun/mail/imap/protocol/ENVELOPE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/ENVELOPE;->to:[Ljavax/mail/internet/InternetAddress;

    invoke-direct {p0, v0}, Lcom/sun/mail/imap/IMAPMessage;->aaclone([Ljavax/mail/internet/InternetAddress;)[Ljavax/mail/internet/InternetAddress;

    move-result-object v0

    .line 296
    :goto_0
    return-object v0

    .line 291
    :cond_0
    sget-object v0, Ljavax/mail/Message$RecipientType;->CC:Ljavax/mail/Message$RecipientType;

    if-ne p1, v0, :cond_1

    .line 292
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->envelope:Lcom/sun/mail/imap/protocol/ENVELOPE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/ENVELOPE;->cc:[Ljavax/mail/internet/InternetAddress;

    invoke-direct {p0, v0}, Lcom/sun/mail/imap/IMAPMessage;->aaclone([Ljavax/mail/internet/InternetAddress;)[Ljavax/mail/internet/InternetAddress;

    move-result-object v0

    goto :goto_0

    .line 293
    :cond_1
    sget-object v0, Ljavax/mail/Message$RecipientType;->BCC:Ljavax/mail/Message$RecipientType;

    if-ne p1, v0, :cond_2

    .line 294
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->envelope:Lcom/sun/mail/imap/protocol/ENVELOPE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/ENVELOPE;->bcc:[Ljavax/mail/internet/InternetAddress;

    invoke-direct {p0, v0}, Lcom/sun/mail/imap/IMAPMessage;->aaclone([Ljavax/mail/internet/InternetAddress;)[Ljavax/mail/internet/InternetAddress;

    move-result-object v0

    goto :goto_0

    .line 296
    :cond_2
    invoke-super {p0, p1}, Ljavax/mail/internet/MimeMessage;->getRecipients(Ljavax/mail/Message$RecipientType;)[Ljavax/mail/Address;

    move-result-object v0

    goto :goto_0
.end method

.method public getReplyTo()[Ljavax/mail/Address;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 313
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 314
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPMessage;->loadEnvelope()V

    .line 315
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->envelope:Lcom/sun/mail/imap/protocol/ENVELOPE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/ENVELOPE;->replyTo:[Ljavax/mail/internet/InternetAddress;

    invoke-direct {p0, v0}, Lcom/sun/mail/imap/IMAPMessage;->aaclone([Ljavax/mail/internet/InternetAddress;)[Ljavax/mail/internet/InternetAddress;

    move-result-object v0

    return-object v0
.end method

.method public getSender()Ljavax/mail/Address;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 268
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 269
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPMessage;->loadEnvelope()V

    .line 270
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->envelope:Lcom/sun/mail/imap/protocol/ENVELOPE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/ENVELOPE;->sender:[Ljavax/mail/internet/InternetAddress;

    if-eqz v0, :cond_0

    .line 271
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->envelope:Lcom/sun/mail/imap/protocol/ENVELOPE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/ENVELOPE;->sender:[Ljavax/mail/internet/InternetAddress;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    .line 273
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public getSentDate()Ljava/util/Date;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 354
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 355
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPMessage;->loadEnvelope()V

    .line 356
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->envelope:Lcom/sun/mail/imap/protocol/ENVELOPE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/ENVELOPE;->date:Ljava/util/Date;

    if-nez v0, :cond_0

    .line 357
    const/4 v0, 0x0

    .line 359
    :goto_0
    return-object v0

    :cond_0
    new-instance v0, Ljava/util/Date;

    iget-object v1, p0, Lcom/sun/mail/imap/IMAPMessage;->envelope:Lcom/sun/mail/imap/protocol/ENVELOPE;

    iget-object v1, v1, Lcom/sun/mail/imap/protocol/ENVELOPE;->date:Ljava/util/Date;

    invoke-virtual {v1}, Ljava/util/Date;->getTime()J

    move-result-wide v2

    invoke-direct {v0, v2, v3}, Ljava/util/Date;-><init>(J)V

    goto :goto_0
.end method

.method protected getSequenceNumber()I
    .locals 1

    .prologue
    .line 182
    iget v0, p0, Lcom/sun/mail/imap/IMAPMessage;->seqnum:I

    return v0
.end method

.method public getSize()I
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 385
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 386
    iget v0, p0, Lcom/sun/mail/imap/IMAPMessage;->size:I

    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    .line 387
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPMessage;->loadEnvelope()V

    .line 388
    :cond_0
    iget v0, p0, Lcom/sun/mail/imap/IMAPMessage;->size:I

    return v0
.end method

.method public getSubject()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 326
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 328
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->subject:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 329
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->subject:Ljava/lang/String;

    .line 342
    :goto_0
    return-object v0

    .line 331
    :cond_0
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPMessage;->loadEnvelope()V

    .line 332
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->envelope:Lcom/sun/mail/imap/protocol/ENVELOPE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/ENVELOPE;->subject:Ljava/lang/String;

    if-nez v0, :cond_1

    .line 333
    const/4 v0, 0x0

    goto :goto_0

    .line 337
    :cond_1
    :try_start_0
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->envelope:Lcom/sun/mail/imap/protocol/ENVELOPE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/ENVELOPE;->subject:Ljava/lang/String;

    invoke-static {v0}, Ljavax/mail/internet/MimeUtility;->decodeText(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->subject:Ljava/lang/String;
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    .line 342
    :goto_1
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->subject:Ljava/lang/String;

    goto :goto_0

    .line 338
    :catch_0
    move-exception v0

    .line 339
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->envelope:Lcom/sun/mail/imap/protocol/ENVELOPE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/ENVELOPE;->subject:Ljava/lang/String;

    iput-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->subject:Ljava/lang/String;

    goto :goto_1
.end method

.method protected getUID()J
    .locals 2

    .prologue
    .line 204
    iget-wide v0, p0, Lcom/sun/mail/imap/IMAPMessage;->uid:J

    return-wide v0
.end method

.method public declared-synchronized invalidateHeaders()V
    .locals 1

    .prologue
    .line 910
    monitor-enter p0

    const/4 v0, 0x0

    :try_start_0
    iput-boolean v0, p0, Lcom/sun/mail/imap/IMAPMessage;->headersLoaded:Z

    .line 911
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->loadedHeaders:Ljava/util/Hashtable;

    .line 912
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->envelope:Lcom/sun/mail/imap/protocol/ENVELOPE;

    .line 913
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    .line 914
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->receivedDate:Ljava/util/Date;

    .line 915
    const/4 v0, -0x1

    iput v0, p0, Lcom/sun/mail/imap/IMAPMessage;->size:I

    .line 916
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->type:Ljava/lang/String;

    .line 917
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->subject:Ljava/lang/String;

    .line 918
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->description:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 919
    monitor-exit p0

    return-void

    .line 910
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method protected isREV1()Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/FolderClosedException;
        }
    .end annotation

    .prologue
    .line 160
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPMessage;->folder:Ljavax/mail/Folder;

    check-cast v0, Lcom/sun/mail/imap/IMAPFolder;

    iget-object v0, v0, Lcom/sun/mail/imap/IMAPFolder;->protocol:Lcom/sun/mail/imap/protocol/IMAPProtocol;

    .line 161
    if-nez v0, :cond_0

    .line 162
    new-instance v0, Ljavax/mail/FolderClosedException;

    iget-object v1, p0, Lcom/sun/mail/imap/IMAPMessage;->folder:Ljavax/mail/Folder;

    invoke-direct {v0, v1}, Ljavax/mail/FolderClosedException;-><init>(Ljavax/mail/Folder;)V

    throw v0

    .line 164
    :cond_0
    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->isREV1()Z

    move-result v0

    return v0
.end method

.method public declared-synchronized isSet(Ljavax/mail/Flags$Flag;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 858
    monitor-enter p0

    :try_start_0
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 859
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPMessage;->loadFlags()V

    .line 860
    invoke-super {p0, p1}, Ljavax/mail/internet/MimeMessage;->isSet(Ljavax/mail/Flags$Flag;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    monitor-exit p0

    return v0

    .line 858
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public removeHeader(Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 779
    new-instance v0, Ljavax/mail/IllegalWriteException;

    const-string v1, "IMAPMessage is read-only"

    invoke-direct {v0, v1}, Ljavax/mail/IllegalWriteException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setContentID(Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 483
    new-instance v0, Ljavax/mail/IllegalWriteException;

    const-string v1, "IMAPMessage is read-only"

    invoke-direct {v0, v1}, Ljavax/mail/IllegalWriteException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setContentLanguage([Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 418
    new-instance v0, Ljavax/mail/IllegalWriteException;

    const-string v1, "IMAPMessage is read-only"

    invoke-direct {v0, v1}, Ljavax/mail/IllegalWriteException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setContentMD5(Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 496
    new-instance v0, Ljavax/mail/IllegalWriteException;

    const-string v1, "IMAPMessage is read-only"

    invoke-direct {v0, v1}, Ljavax/mail/IllegalWriteException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setDataHandler(Ljavax/activation/DataHandler;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 651
    new-instance v0, Ljavax/mail/IllegalWriteException;

    const-string v1, "IMAPMessage is read-only"

    invoke-direct {v0, v1}, Ljavax/mail/IllegalWriteException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setDescription(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 523
    new-instance v0, Ljavax/mail/IllegalWriteException;

    const-string v1, "IMAPMessage is read-only"

    invoke-direct {v0, v1}, Ljavax/mail/IllegalWriteException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setDisposition(Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 461
    new-instance v0, Ljavax/mail/IllegalWriteException;

    const-string v1, "IMAPMessage is read-only"

    invoke-direct {v0, v1}, Ljavax/mail/IllegalWriteException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected setExpunged(Z)V
    .locals 1

    .prologue
    .line 213
    invoke-super {p0, p1}, Ljavax/mail/internet/MimeMessage;->setExpunged(Z)V

    .line 214
    const/4 v0, -0x1

    iput v0, p0, Lcom/sun/mail/imap/IMAPMessage;->seqnum:I

    .line 215
    return-void
.end method

.method public setFileName(Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 554
    new-instance v0, Ljavax/mail/IllegalWriteException;

    const-string v1, "IMAPMessage is read-only"

    invoke-direct {v0, v1}, Ljavax/mail/IllegalWriteException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public declared-synchronized setFlags(Ljavax/mail/Flags;Z)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 869
    monitor-enter p0

    :try_start_0
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getMessageCacheLock()Ljava/lang/Object;

    move-result-object v1

    monitor-enter v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 871
    :try_start_1
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getProtocol()Lcom/sun/mail/imap/protocol/IMAPProtocol;

    move-result-object v0

    .line 872
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 873
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getSequenceNumber()I

    move-result v2

    invoke-virtual {v0, v2, p1, p2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->storeFlags(ILjavax/mail/Flags;Z)V
    :try_end_1
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 869
    :try_start_2
    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 880
    monitor-exit p0

    return-void

    .line 874
    :catch_0
    move-exception v0

    .line 875
    :try_start_3
    new-instance v2, Ljavax/mail/FolderClosedException;

    iget-object v3, p0, Lcom/sun/mail/imap/IMAPMessage;->folder:Ljavax/mail/Folder;

    invoke-virtual {v0}, Lcom/sun/mail/iap/ConnectionException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v2, v3, v0}, Ljavax/mail/FolderClosedException;-><init>(Ljavax/mail/Folder;Ljava/lang/String;)V

    throw v2

    .line 869
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :try_start_4
    throw v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    :catchall_1
    move-exception v0

    monitor-exit p0

    throw v0

    .line 876
    :catch_1
    move-exception v0

    .line 877
    :try_start_5
    new-instance v2, Ljavax/mail/MessagingException;

    invoke-virtual {v0}, Lcom/sun/mail/iap/ProtocolException;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v2
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0
.end method

.method public setFrom(Ljavax/mail/Address;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 257
    new-instance v0, Ljavax/mail/IllegalWriteException;

    const-string v1, "IMAPMessage is read-only"

    invoke-direct {v0, v1}, Ljavax/mail/IllegalWriteException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setHeader(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 769
    new-instance v0, Ljavax/mail/IllegalWriteException;

    const-string v1, "IMAPMessage is read-only"

    invoke-direct {v0, v1}, Ljavax/mail/IllegalWriteException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected setMessageNumber(I)V
    .locals 0

    .prologue
    .line 200
    invoke-super {p0, p1}, Ljavax/mail/internet/MimeMessage;->setMessageNumber(I)V

    .line 201
    return-void
.end method

.method public declared-synchronized setPeek(Z)V
    .locals 1

    .prologue
    .line 889
    monitor-enter p0

    :try_start_0
    iput-boolean p1, p0, Lcom/sun/mail/imap/IMAPMessage;->peek:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 890
    monitor-exit p0

    return-void

    .line 889
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public setRecipients(Ljavax/mail/Message$RecipientType;[Ljavax/mail/Address;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 301
    new-instance v0, Ljavax/mail/IllegalWriteException;

    const-string v1, "IMAPMessage is read-only"

    invoke-direct {v0, v1}, Ljavax/mail/IllegalWriteException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setReplyTo([Ljavax/mail/Address;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 319
    new-instance v0, Ljavax/mail/IllegalWriteException;

    const-string v1, "IMAPMessage is read-only"

    invoke-direct {v0, v1}, Ljavax/mail/IllegalWriteException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setSender(Ljavax/mail/Address;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 278
    new-instance v0, Ljavax/mail/IllegalWriteException;

    const-string v1, "IMAPMessage is read-only"

    invoke-direct {v0, v1}, Ljavax/mail/IllegalWriteException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setSentDate(Ljava/util/Date;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 363
    new-instance v0, Ljavax/mail/IllegalWriteException;

    const-string v1, "IMAPMessage is read-only"

    invoke-direct {v0, v1}, Ljavax/mail/IllegalWriteException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected setSequenceNumber(I)V
    .locals 0

    .prologue
    .line 192
    iput p1, p0, Lcom/sun/mail/imap/IMAPMessage;->seqnum:I

    .line 193
    return-void
.end method

.method public setSubject(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 347
    new-instance v0, Ljavax/mail/IllegalWriteException;

    const-string v1, "IMAPMessage is read-only"

    invoke-direct {v0, v1}, Ljavax/mail/IllegalWriteException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected setUID(J)V
    .locals 1

    .prologue
    .line 208
    iput-wide p1, p0, Lcom/sun/mail/imap/IMAPMessage;->uid:J

    .line 209
    return-void
.end method

.method public writeTo(Ljava/io/OutputStream;)V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    .line 659
    .line 660
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getPeek()Z

    move-result v1

    .line 663
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getMessageCacheLock()Ljava/lang/Object;

    move-result-object v2

    monitor-enter v2

    .line 665
    :try_start_0
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getProtocol()Lcom/sun/mail/imap/protocol/IMAPProtocol;

    move-result-object v3

    .line 667
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 669
    invoke-virtual {v3}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->isREV1()Z

    move-result v4

    if-eqz v4, :cond_2

    .line 671
    if-eqz v1, :cond_1

    .line 672
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getSequenceNumber()I

    move-result v1

    iget-object v4, p0, Lcom/sun/mail/imap/IMAPMessage;->sectionId:Ljava/lang/String;

    invoke-virtual {v3, v1, v4}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->peekBody(ILjava/lang/String;)Lcom/sun/mail/imap/protocol/BODY;

    move-result-object v1

    .line 675
    :goto_0
    if-eqz v1, :cond_0

    .line 676
    invoke-virtual {v1}, Lcom/sun/mail/imap/protocol/BODY;->getByteArrayInputStream()Ljava/io/ByteArrayInputStream;
    :try_end_0
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 663
    :cond_0
    :goto_1
    :try_start_1
    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 690
    if-nez v0, :cond_3

    .line 691
    new-instance v0, Ljavax/mail/MessagingException;

    const-string v1, "No content"

    invoke-direct {v0, v1}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 674
    :cond_1
    :try_start_2
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getSequenceNumber()I

    move-result v1

    iget-object v4, p0, Lcom/sun/mail/imap/IMAPMessage;->sectionId:Ljava/lang/String;

    invoke-virtual {v3, v1, v4}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->fetchBody(ILjava/lang/String;)Lcom/sun/mail/imap/protocol/BODY;

    move-result-object v1

    goto :goto_0

    .line 678
    :cond_2
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->getSequenceNumber()I

    move-result v1

    const/4 v4, 0x0

    invoke-virtual {v3, v1, v4}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->fetchRFC822(ILjava/lang/String;)Lcom/sun/mail/imap/protocol/RFC822DATA;

    move-result-object v1

    .line 679
    if-eqz v1, :cond_0

    .line 680
    invoke-virtual {v1}, Lcom/sun/mail/imap/protocol/RFC822DATA;->getByteArrayInputStream()Ljava/io/ByteArrayInputStream;
    :try_end_2
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-result-object v0

    goto :goto_1

    .line 682
    :catch_0
    move-exception v0

    .line 683
    :try_start_3
    new-instance v1, Ljavax/mail/FolderClosedException;

    iget-object v3, p0, Lcom/sun/mail/imap/IMAPMessage;->folder:Ljavax/mail/Folder;

    invoke-virtual {v0}, Lcom/sun/mail/iap/ConnectionException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v3, v0}, Ljavax/mail/FolderClosedException;-><init>(Ljavax/mail/Folder;Ljava/lang/String;)V

    throw v1

    .line 663
    :catchall_0
    move-exception v0

    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw v0

    .line 684
    :catch_1
    move-exception v0

    .line 685
    :try_start_4
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPMessage;->forceCheckExpunged()V

    .line 686
    new-instance v1, Ljavax/mail/MessagingException;

    invoke-virtual {v0}, Lcom/sun/mail/iap/ProtocolException;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v3, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v1
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 694
    :cond_3
    const/16 v1, 0x400

    new-array v1, v1, [B

    .line 696
    :goto_2
    invoke-virtual {v0, v1}, Ljava/io/InputStream;->read([B)I

    move-result v2

    const/4 v3, -0x1

    if-ne v2, v3, :cond_4

    .line 698
    return-void

    .line 697
    :cond_4
    const/4 v3, 0x0

    invoke-virtual {p1, v1, v3, v2}, Ljava/io/OutputStream;->write([BII)V

    goto :goto_2
.end method
