.class public Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/sun/mail/imap/protocol/SaslAuthenticator;


# instance fields
.field private debug:Z

.field private host:Ljava/lang/String;

.field private name:Ljava/lang/String;

.field private out:Ljava/io/PrintStream;

.field private pr:Lcom/sun/mail/imap/protocol/IMAPProtocol;

.field private props:Ljava/util/Properties;


# direct methods
.method public constructor <init>(Lcom/sun/mail/imap/protocol/IMAPProtocol;Ljava/lang/String;Ljava/util/Properties;ZLjava/io/PrintStream;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 67
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 69
    iput-object p1, p0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->pr:Lcom/sun/mail/imap/protocol/IMAPProtocol;

    .line 70
    iput-object p2, p0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->name:Ljava/lang/String;

    .line 71
    iput-object p3, p0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->props:Ljava/util/Properties;

    .line 72
    iput-boolean p4, p0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->debug:Z

    .line 73
    iput-object p5, p0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->out:Ljava/io/PrintStream;

    .line 74
    iput-object p6, p0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->host:Ljava/lang/String;

    .line 75
    return-void
.end method

.method static synthetic access$0(Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;)Z
    .locals 1

    .prologue
    .line 63
    iget-boolean v0, p0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->debug:Z

    return v0
.end method

.method static synthetic access$1(Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;)Ljava/io/PrintStream;
    .locals 1

    .prologue
    .line 64
    iget-object v0, p0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->out:Ljava/io/PrintStream;

    return-object v0
.end method


# virtual methods
.method public authenticate([Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z
    .locals 19
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 80
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->pr:Lcom/sun/mail/imap/protocol/IMAPProtocol;

    monitor-enter v12

    .line 81
    :try_start_0
    new-instance v13, Ljava/util/Vector;

    invoke-direct {v13}, Ljava/util/Vector;-><init>()V

    .line 83
    const/4 v11, 0x0

    .line 84
    const/4 v10, 0x0

    .line 85
    move-object/from16 v0, p0

    iget-boolean v4, v0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->debug:Z

    if-eqz v4, :cond_0

    .line 86
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->out:Ljava/io/PrintStream;

    const-string v5, "IMAP SASL DEBUG: Mechanisms:"

    invoke-virtual {v4, v5}, Ljava/io/PrintStream;->print(Ljava/lang/String;)V

    .line 87
    const/4 v4, 0x0

    :goto_0
    move-object/from16 v0, p1

    array-length v5, v0

    if-lt v4, v5, :cond_2

    .line 89
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->out:Ljava/io/PrintStream;

    invoke-virtual {v4}, Ljava/io/PrintStream;->println()V

    .line 96
    :cond_0
    new-instance v9, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator$1;

    move-object/from16 v0, p0

    move-object/from16 v1, p4

    move-object/from16 v2, p5

    move-object/from16 v3, p2

    invoke-direct {v9, v0, v1, v2, v3}, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator$1;-><init>(Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 136
    :try_start_1
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->name:Ljava/lang/String;

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->host:Ljava/lang/String;

    .line 137
    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->props:Ljava/util/Properties;

    move-object/from16 v4, p1

    move-object/from16 v5, p3

    .line 136
    invoke-static/range {v4 .. v9}, Ljavax/security/sasl/Sasl;->createSaslClient([Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Ljavax/security/auth/callback/CallbackHandler;)Ljavax/security/sasl/SaslClient;
    :try_end_1
    .catch Ljavax/security/sasl/SaslException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v7

    .line 144
    if-nez v7, :cond_4

    .line 145
    :try_start_2
    move-object/from16 v0, p0

    iget-boolean v4, v0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->debug:Z

    if-eqz v4, :cond_1

    .line 146
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->out:Ljava/io/PrintStream;

    const-string v5, "IMAP SASL DEBUG: No SASL support"

    invoke-virtual {v4, v5}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 147
    :cond_1
    monitor-exit v12

    const/4 v4, 0x0

    .line 258
    :goto_1
    return v4

    .line 88
    :cond_2
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->out:Ljava/io/PrintStream;

    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, " "

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    aget-object v7, p1, v4

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/io/PrintStream;->print(Ljava/lang/String;)V

    .line 87
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 138
    :catch_0
    move-exception v4

    .line 139
    move-object/from16 v0, p0

    iget-boolean v5, v0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->debug:Z

    if-eqz v5, :cond_3

    .line 140
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->out:Ljava/io/PrintStream;

    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "IMAP SASL DEBUG: Failed to create SASL client: "

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 141
    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 140
    invoke-virtual {v5, v4}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 142
    :cond_3
    monitor-exit v12

    const/4 v4, 0x0

    goto :goto_1

    .line 149
    :cond_4
    move-object/from16 v0, p0

    iget-boolean v4, v0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->debug:Z

    if-eqz v4, :cond_5

    .line 150
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->out:Ljava/io/PrintStream;

    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "IMAP SASL DEBUG: SASL client "

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 151
    invoke-interface {v7}, Ljavax/security/sasl/SaslClient;->getMechanismName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 150
    invoke-virtual {v4, v5}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 154
    :cond_5
    :try_start_3
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->pr:Lcom/sun/mail/imap/protocol/IMAPProtocol;

    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "AUTHENTICATE "

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-interface {v7}, Ljavax/security/sasl/SaslClient;->getMechanismName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 155
    const/4 v6, 0x0

    .line 154
    invoke-virtual {v4, v5, v6}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->writeCommand(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)Ljava/lang/String;
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move-result-object v8

    .line 162
    :try_start_4
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->pr:Lcom/sun/mail/imap/protocol/IMAPProtocol;

    invoke-virtual {v4}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->getIMAPOutputStream()Ljava/io/OutputStream;

    move-result-object v9

    .line 177
    new-instance v14, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v14}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 178
    const/4 v4, 0x2

    new-array v15, v4, [B

    fill-array-data v15, :array_0

    .line 181
    invoke-interface {v7}, Ljavax/security/sasl/SaslClient;->getMechanismName()Ljava/lang/String;

    move-result-object v4

    const-string v5, "XGWTRUSTEDAPP"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v16

    move v5, v10

    move-object v6, v11

    .line 182
    :goto_2
    if-eqz v5, :cond_9

    .line 233
    invoke-interface {v7}, Ljavax/security/sasl/SaslClient;->isComplete()Z

    move-result v4

    if-eqz v4, :cond_15

    .line 234
    const-string v4, "javax.security.sasl.qop"

    invoke-interface {v7, v4}, Ljavax/security/sasl/SaslClient;->getNegotiatedProperty(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    .line 235
    if-eqz v4, :cond_15

    const-string v5, "auth-int"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_6

    .line 236
    const-string v5, "auth-conf"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_15

    .line 238
    :cond_6
    move-object/from16 v0, p0

    iget-boolean v4, v0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->debug:Z

    if-eqz v4, :cond_7

    .line 239
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->out:Ljava/io/PrintStream;

    const-string v5, "IMAP SASL DEBUG: Mechanism requires integrity or confidentiality"

    invoke-virtual {v4, v5}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 241
    :cond_7
    monitor-exit v12

    const/4 v4, 0x0

    goto/16 :goto_1

    .line 156
    :catch_1
    move-exception v4

    .line 157
    move-object/from16 v0, p0

    iget-boolean v5, v0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->debug:Z

    if-eqz v5, :cond_8

    .line 158
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->out:Ljava/io/PrintStream;

    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "IMAP SASL DEBUG: AUTHENTICATE Exception: "

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v5, v4}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 159
    :cond_8
    monitor-exit v12
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    const/4 v4, 0x0

    goto/16 :goto_1

    .line 184
    :cond_9
    :try_start_5
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->pr:Lcom/sun/mail/imap/protocol/IMAPProtocol;

    invoke-virtual {v4}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->readResponse()Lcom/sun/mail/iap/Response;

    move-result-object v6

    .line 185
    invoke-virtual {v6}, Lcom/sun/mail/iap/Response;->isContinuation()Z

    move-result v4

    if-eqz v4, :cond_12

    .line 186
    const/4 v4, 0x0

    check-cast v4, [B

    .line 187
    invoke-interface {v7}, Ljavax/security/sasl/SaslClient;->isComplete()Z

    move-result v10

    if-nez v10, :cond_c

    .line 188
    invoke-virtual {v6}, Lcom/sun/mail/iap/Response;->readByteArray()Lcom/sun/mail/iap/ByteArray;

    move-result-object v4

    invoke-virtual {v4}, Lcom/sun/mail/iap/ByteArray;->getNewBytes()[B

    move-result-object v4

    .line 189
    array-length v10, v4

    if-lez v10, :cond_a

    .line 190
    invoke-static {v4}, Lcom/sun/mail/util/BASE64DecoderStream;->decode([B)[B

    move-result-object v4

    .line 191
    :cond_a
    move-object/from16 v0, p0

    iget-boolean v10, v0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->debug:Z

    if-eqz v10, :cond_b

    .line 192
    move-object/from16 v0, p0

    iget-object v10, v0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->out:Ljava/io/PrintStream;

    new-instance v11, Ljava/lang/StringBuilder;

    const-string v17, "IMAP SASL DEBUG: challenge: "

    move-object/from16 v0, v17

    invoke-direct {v11, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 193
    const/16 v17, 0x0

    array-length v0, v4

    move/from16 v18, v0

    move/from16 v0, v17

    move/from16 v1, v18

    invoke-static {v4, v0, v1}, Lcom/sun/mail/util/ASCIIUtility;->toString([BII)Ljava/lang/String;

    move-result-object v17

    move-object/from16 v0, v17

    invoke-virtual {v11, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v17, " :"

    move-object/from16 v0, v17

    invoke-virtual {v11, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    .line 192
    invoke-virtual {v10, v11}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 194
    :cond_b
    invoke-interface {v7, v4}, Ljavax/security/sasl/SaslClient;->evaluateChallenge([B)[B

    move-result-object v4

    .line 196
    :cond_c
    if-nez v4, :cond_f

    .line 197
    move-object/from16 v0, p0

    iget-boolean v4, v0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->debug:Z

    if-eqz v4, :cond_d

    .line 198
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->out:Ljava/io/PrintStream;

    const-string v10, "IMAP SASL DEBUG: no response"

    invoke-virtual {v4, v10}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 199
    :cond_d
    invoke-virtual {v9, v15}, Ljava/io/OutputStream;->write([B)V

    .line 200
    invoke-virtual {v9}, Ljava/io/OutputStream;->flush()V

    .line 201
    invoke-virtual {v14}, Ljava/io/ByteArrayOutputStream;->reset()V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_2
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    goto/16 :goto_2

    .line 223
    :catch_2
    move-exception v4

    .line 224
    :try_start_6
    move-object/from16 v0, p0

    iget-boolean v5, v0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->debug:Z

    if-eqz v5, :cond_e

    .line 225
    invoke-virtual {v4}, Ljava/lang/Exception;->printStackTrace()V

    .line 227
    :cond_e
    invoke-static {v4}, Lcom/sun/mail/iap/Response;->byeResponse(Ljava/lang/Exception;)Lcom/sun/mail/iap/Response;
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    move-result-object v5

    .line 228
    const/4 v4, 0x1

    move-object v6, v5

    move v5, v4

    goto/16 :goto_2

    .line 203
    :cond_f
    :try_start_7
    move-object/from16 v0, p0

    iget-boolean v10, v0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->debug:Z

    if-eqz v10, :cond_10

    .line 204
    move-object/from16 v0, p0

    iget-object v10, v0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->out:Ljava/io/PrintStream;

    new-instance v11, Ljava/lang/StringBuilder;

    const-string v17, "IMAP SASL DEBUG: response: "

    move-object/from16 v0, v17

    invoke-direct {v11, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 205
    const/16 v17, 0x0

    array-length v0, v4

    move/from16 v18, v0

    move/from16 v0, v17

    move/from16 v1, v18

    invoke-static {v4, v0, v1}, Lcom/sun/mail/util/ASCIIUtility;->toString([BII)Ljava/lang/String;

    move-result-object v17

    move-object/from16 v0, v17

    invoke-virtual {v11, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v17, " :"

    move-object/from16 v0, v17

    invoke-virtual {v11, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    .line 204
    invoke-virtual {v10, v11}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 206
    :cond_10
    invoke-static {v4}, Lcom/sun/mail/util/BASE64EncoderStream;->encode([B)[B

    move-result-object v4

    .line 207
    if-eqz v16, :cond_11

    .line 208
    const-string v10, "XGWTRUSTEDAPP "

    invoke-virtual {v10}, Ljava/lang/String;->getBytes()[B

    move-result-object v10

    invoke-virtual {v14, v10}, Ljava/io/ByteArrayOutputStream;->write([B)V

    .line 209
    :cond_11
    invoke-virtual {v14, v4}, Ljava/io/ByteArrayOutputStream;->write([B)V

    .line 211
    invoke-virtual {v14, v15}, Ljava/io/ByteArrayOutputStream;->write([B)V

    .line 212
    invoke-virtual {v14}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v4

    invoke-virtual {v9, v4}, Ljava/io/OutputStream;->write([B)V

    .line 213
    invoke-virtual {v9}, Ljava/io/OutputStream;->flush()V

    .line 214
    invoke-virtual {v14}, Ljava/io/ByteArrayOutputStream;->reset()V
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_2
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    goto/16 :goto_2

    .line 80
    :catchall_0
    move-exception v4

    :try_start_8
    monitor-exit v12
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    throw v4

    .line 216
    :cond_12
    :try_start_9
    invoke-virtual {v6}, Lcom/sun/mail/iap/Response;->isTagged()Z

    move-result v4

    if-eqz v4, :cond_13

    invoke-virtual {v6}, Lcom/sun/mail/iap/Response;->getTag()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_13

    .line 218
    const/4 v4, 0x1

    move v5, v4

    goto/16 :goto_2

    .line 219
    :cond_13
    invoke-virtual {v6}, Lcom/sun/mail/iap/Response;->isBYE()Z

    move-result v4

    if-eqz v4, :cond_14

    .line 220
    const/4 v4, 0x1

    move v5, v4

    goto/16 :goto_2

    .line 222
    :cond_14
    invoke-virtual {v13, v6}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V
    :try_end_9
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_2
    .catchall {:try_start_9 .. :try_end_9} :catchall_0

    goto/16 :goto_2

    .line 251
    :cond_15
    :try_start_a
    invoke-virtual {v13}, Ljava/util/Vector;->size()I

    move-result v4

    new-array v4, v4, [Lcom/sun/mail/iap/Response;

    .line 252
    invoke-virtual {v13, v4}, Ljava/util/Vector;->copyInto([Ljava/lang/Object;)V

    .line 253
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->pr:Lcom/sun/mail/imap/protocol/IMAPProtocol;

    invoke-virtual {v5, v4}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 256
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->pr:Lcom/sun/mail/imap/protocol/IMAPProtocol;

    invoke-virtual {v4, v6}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->handleResult(Lcom/sun/mail/iap/Response;)V

    .line 257
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/sun/mail/imap/protocol/IMAPSaslAuthenticator;->pr:Lcom/sun/mail/imap/protocol/IMAPProtocol;

    invoke-virtual {v4, v6}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->setCapabilities(Lcom/sun/mail/iap/Response;)V

    .line 258
    monitor-exit v12
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_0

    const/4 v4, 0x1

    goto/16 :goto_1

    .line 178
    :array_0
    .array-data 1
        0xdt
        0xat
    .end array-data
.end method
