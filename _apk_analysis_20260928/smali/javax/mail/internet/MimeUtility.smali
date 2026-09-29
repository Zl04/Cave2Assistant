.class public Ljavax/mail/internet/MimeUtility;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static final ALL:I = -0x1

.field static final ALL_ASCII:I = 0x1

.field static final MOSTLY_ASCII:I = 0x2

.field static final MOSTLY_NONASCII:I = 0x3

.field private static decodeStrict:Z

.field private static defaultJavaCharset:Ljava/lang/String;

.field private static defaultMIMECharset:Ljava/lang/String;

.field private static encodeEolStrict:Z

.field private static foldEncodedWords:Z

.field private static foldText:Z

.field private static java2mime:Ljava/util/Hashtable;

.field private static mime2java:Ljava/util/Hashtable;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .prologue
    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 135
    sput-boolean v2, Ljavax/mail/internet/MimeUtility;->decodeStrict:Z

    .line 136
    sput-boolean v1, Ljavax/mail/internet/MimeUtility;->encodeEolStrict:Z

    .line 137
    sput-boolean v1, Ljavax/mail/internet/MimeUtility;->foldEncodedWords:Z

    .line 138
    sput-boolean v2, Ljavax/mail/internet/MimeUtility;->foldText:Z

    .line 142
    :try_start_0
    const-string v3, "mail.mime.decodetext.strict"

    invoke-static {v3}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 144
    if-eqz v3, :cond_3

    const-string v4, "false"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    move v3, v1

    :goto_0
    sput-boolean v3, Ljavax/mail/internet/MimeUtility;->decodeStrict:Z

    .line 145
    const-string v3, "mail.mime.encodeeol.strict"

    invoke-static {v3}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 147
    if-eqz v3, :cond_4

    const-string v4, "true"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_4

    move v3, v2

    :goto_1
    sput-boolean v3, Ljavax/mail/internet/MimeUtility;->encodeEolStrict:Z

    .line 148
    const-string v3, "mail.mime.foldencodedwords"

    invoke-static {v3}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 150
    if-eqz v3, :cond_5

    const-string v4, "true"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_5

    move v3, v2

    :goto_2
    sput-boolean v3, Ljavax/mail/internet/MimeUtility;->foldEncodedWords:Z

    .line 151
    const-string v3, "mail.mime.foldtext"

    invoke-static {v3}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 153
    if-eqz v3, :cond_6

    const-string v4, "false"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_6

    :goto_3
    sput-boolean v1, Ljavax/mail/internet/MimeUtility;->foldText:Z
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_3

    .line 1209
    :goto_4
    new-instance v1, Ljava/util/Hashtable;

    const/16 v2, 0x28

    invoke-direct {v1, v2}, Ljava/util/Hashtable;-><init>(I)V

    sput-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    .line 1210
    new-instance v1, Ljava/util/Hashtable;

    const/16 v2, 0xa

    invoke-direct {v1, v2}, Ljava/util/Hashtable;-><init>(I)V

    sput-object v1, Ljavax/mail/internet/MimeUtility;->mime2java:Ljava/util/Hashtable;

    .line 1216
    :try_start_1
    const-class v1, Ljavax/mail/internet/MimeUtility;

    .line 1217
    const-string v2, "/META-INF/javamail.charset.map"

    .line 1216
    invoke-virtual {v1, v2}, Ljava/lang/Class;->getResourceAsStream(Ljava/lang/String;)Ljava/io/InputStream;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    move-result-object v3

    .line 1219
    if-eqz v3, :cond_0

    .line 1221
    :try_start_2
    new-instance v2, Lcom/sun/mail/util/LineInputStream;

    invoke-direct {v2, v3}, Lcom/sun/mail/util/LineInputStream;-><init>(Ljava/io/InputStream;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 1224
    :try_start_3
    move-object v0, v2

    check-cast v0, Lcom/sun/mail/util/LineInputStream;

    move-object v1, v0

    sget-object v3, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    invoke-static {v1, v3}, Ljavax/mail/internet/MimeUtility;->loadMappings(Lcom/sun/mail/util/LineInputStream;Ljava/util/Hashtable;)V

    .line 1227
    move-object v0, v2

    check-cast v0, Lcom/sun/mail/util/LineInputStream;

    move-object v1, v0

    sget-object v3, Ljavax/mail/internet/MimeUtility;->mime2java:Ljava/util/Hashtable;

    invoke-static {v1, v3}, Ljavax/mail/internet/MimeUtility;->loadMappings(Lcom/sun/mail/util/LineInputStream;Ljava/util/Hashtable;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1230
    :try_start_4
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_2

    .line 1241
    :cond_0
    :goto_5
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    invoke-virtual {v1}, Ljava/util/Hashtable;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 1242
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "8859_1"

    const-string v3, "ISO-8859-1"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1243
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "iso8859_1"

    const-string v3, "ISO-8859-1"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1244
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "iso8859-1"

    const-string v3, "ISO-8859-1"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1246
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "8859_2"

    const-string v3, "ISO-8859-2"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1247
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "iso8859_2"

    const-string v3, "ISO-8859-2"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1248
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "iso8859-2"

    const-string v3, "ISO-8859-2"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1250
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "8859_3"

    const-string v3, "ISO-8859-3"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1251
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "iso8859_3"

    const-string v3, "ISO-8859-3"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1252
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "iso8859-3"

    const-string v3, "ISO-8859-3"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1254
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "8859_4"

    const-string v3, "ISO-8859-4"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1255
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "iso8859_4"

    const-string v3, "ISO-8859-4"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1256
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "iso8859-4"

    const-string v3, "ISO-8859-4"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1258
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "8859_5"

    const-string v3, "ISO-8859-5"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1259
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "iso8859_5"

    const-string v3, "ISO-8859-5"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1260
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "iso8859-5"

    const-string v3, "ISO-8859-5"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1262
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "8859_6"

    const-string v3, "ISO-8859-6"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1263
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "iso8859_6"

    const-string v3, "ISO-8859-6"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1264
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "iso8859-6"

    const-string v3, "ISO-8859-6"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1266
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "8859_7"

    const-string v3, "ISO-8859-7"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1267
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "iso8859_7"

    const-string v3, "ISO-8859-7"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1268
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "iso8859-7"

    const-string v3, "ISO-8859-7"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1270
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "8859_8"

    const-string v3, "ISO-8859-8"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1271
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "iso8859_8"

    const-string v3, "ISO-8859-8"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1272
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "iso8859-8"

    const-string v3, "ISO-8859-8"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1274
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "8859_9"

    const-string v3, "ISO-8859-9"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1275
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "iso8859_9"

    const-string v3, "ISO-8859-9"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1276
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "iso8859-9"

    const-string v3, "ISO-8859-9"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1278
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "sjis"

    const-string v3, "Shift_JIS"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1279
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "jis"

    const-string v3, "ISO-2022-JP"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1280
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "iso2022jp"

    const-string v3, "ISO-2022-JP"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1281
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "euc_jp"

    const-string v3, "euc-jp"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1282
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "koi8_r"

    const-string v3, "koi8-r"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1283
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "euc_cn"

    const-string v3, "euc-cn"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1284
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "euc_tw"

    const-string v3, "euc-tw"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1285
    sget-object v1, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    const-string v2, "euc_kr"

    const-string v3, "euc-kr"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1287
    :cond_1
    sget-object v1, Ljavax/mail/internet/MimeUtility;->mime2java:Ljava/util/Hashtable;

    invoke-virtual {v1}, Ljava/util/Hashtable;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 1288
    sget-object v1, Ljavax/mail/internet/MimeUtility;->mime2java:Ljava/util/Hashtable;

    const-string v2, "iso-2022-cn"

    const-string v3, "ISO2022CN"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1289
    sget-object v1, Ljavax/mail/internet/MimeUtility;->mime2java:Ljava/util/Hashtable;

    const-string v2, "iso-2022-kr"

    const-string v3, "ISO2022KR"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1290
    sget-object v1, Ljavax/mail/internet/MimeUtility;->mime2java:Ljava/util/Hashtable;

    const-string v2, "utf-8"

    const-string v3, "UTF8"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1291
    sget-object v1, Ljavax/mail/internet/MimeUtility;->mime2java:Ljava/util/Hashtable;

    const-string v2, "utf8"

    const-string v3, "UTF8"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1292
    sget-object v1, Ljavax/mail/internet/MimeUtility;->mime2java:Ljava/util/Hashtable;

    const-string v2, "ja_jp.iso2022-7"

    const-string v3, "ISO2022JP"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1293
    sget-object v1, Ljavax/mail/internet/MimeUtility;->mime2java:Ljava/util/Hashtable;

    const-string v2, "ja_jp.eucjp"

    const-string v3, "EUCJIS"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1294
    sget-object v1, Ljavax/mail/internet/MimeUtility;->mime2java:Ljava/util/Hashtable;

    const-string v2, "euc-kr"

    const-string v3, "KSC5601"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1295
    sget-object v1, Ljavax/mail/internet/MimeUtility;->mime2java:Ljava/util/Hashtable;

    const-string v2, "euckr"

    const-string v3, "KSC5601"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1296
    sget-object v1, Ljavax/mail/internet/MimeUtility;->mime2java:Ljava/util/Hashtable;

    const-string v2, "us-ascii"

    const-string v3, "ISO-8859-1"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1297
    sget-object v1, Ljavax/mail/internet/MimeUtility;->mime2java:Ljava/util/Hashtable;

    const-string v2, "x-us-ascii"

    const-string v3, "ISO-8859-1"

    invoke-virtual {v1, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 128
    :cond_2
    return-void

    :cond_3
    move v3, v2

    .line 144
    goto/16 :goto_0

    :cond_4
    move v3, v1

    .line 147
    goto/16 :goto_1

    :cond_5
    move v3, v1

    .line 150
    goto/16 :goto_2

    :cond_6
    move v1, v2

    .line 153
    goto/16 :goto_3

    .line 1228
    :catchall_0
    move-exception v1

    move-object v2, v3

    .line 1230
    :goto_6
    :try_start_5
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_1

    .line 1234
    :goto_7
    :try_start_6
    throw v1
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_0

    .line 1236
    :catch_0
    move-exception v1

    goto/16 :goto_5

    .line 1231
    :catch_1
    move-exception v2

    goto :goto_7

    :catch_2
    move-exception v1

    goto/16 :goto_5

    .line 1228
    :catchall_1
    move-exception v1

    goto :goto_6

    .line 154
    :catch_3
    move-exception v1

    goto/16 :goto_4
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 131
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static checkAscii(Ljava/io/InputStream;IZ)I
    .locals 17

    .prologue
    .line 1416
    const/4 v7, 0x0

    const/4 v6, 0x0

    .line 1418
    const/16 v3, 0x1000

    .line 1419
    const/4 v9, 0x0

    .line 1420
    const/4 v5, 0x0

    const/4 v4, 0x0

    .line 1421
    sget-boolean v1, Ljavax/mail/internet/MimeUtility;->encodeEolStrict:Z

    if-eqz v1, :cond_1

    if-eqz p2, :cond_1

    const/4 v1, 0x1

    move v2, v1

    .line 1422
    :goto_0
    const/4 v1, 0x0

    check-cast v1, [B

    .line 1423
    if-eqz p1, :cond_13

    .line 1424
    const/4 v1, -0x1

    move/from16 v0, p1

    if-ne v0, v1, :cond_2

    const/16 v1, 0x1000

    .line 1425
    :goto_1
    new-array v3, v1, [B

    move-object v10, v3

    move v8, v9

    move v11, v1

    move v1, v4

    move v3, v5

    move v4, v6

    move v5, v7

    .line 1427
    :goto_2
    if-nez p1, :cond_3

    .line 1465
    :cond_0
    :goto_3
    if-nez p1, :cond_d

    if-eqz p2, :cond_d

    .line 1472
    const/4 v1, 0x3

    .line 1489
    :goto_4
    return v1

    .line 1421
    :cond_1
    const/4 v1, 0x0

    move v2, v1

    goto :goto_0

    .line 1424
    :cond_2
    const/16 v1, 0x1000

    move/from16 v0, p1

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v1

    goto :goto_1

    .line 1429
    :cond_3
    const/4 v6, 0x0

    :try_start_0
    move-object/from16 v0, p0

    invoke-virtual {v0, v10, v6, v11}, Ljava/io/InputStream;->read([BII)I
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v12

    const/4 v6, -0x1

    if-eq v12, v6, :cond_0

    .line 1431
    const/4 v7, 0x0

    .line 1432
    const/4 v6, 0x0

    move v9, v8

    move v14, v7

    move v7, v6

    move v6, v14

    move v15, v3

    move v3, v5

    move v5, v15

    move/from16 v16, v4

    move v4, v1

    move/from16 v1, v16

    :goto_5
    if-lt v7, v12, :cond_4

    .line 1461
    const/4 v6, -0x1

    move/from16 v0, p1

    if-eq v0, v6, :cond_12

    .line 1462
    sub-int p1, p1, v12

    move v8, v9

    move v14, v5

    move v5, v3

    move v3, v14

    move v15, v1

    move v1, v4

    move v4, v15

    goto :goto_2

    .line 1437
    :cond_4
    :try_start_1
    aget-byte v8, v10, v7

    and-int/lit16 v8, v8, 0xff

    .line 1438
    if-eqz v2, :cond_7

    .line 1439
    const/16 v13, 0xd

    if-ne v6, v13, :cond_5

    const/16 v13, 0xa

    if-ne v8, v13, :cond_6

    .line 1440
    :cond_5
    const/16 v13, 0xd

    if-eq v6, v13, :cond_7

    const/16 v6, 0xa

    if-ne v8, v6, :cond_7

    .line 1441
    :cond_6
    const/4 v4, 0x1

    .line 1442
    :cond_7
    const/16 v6, 0xd

    if-eq v8, v6, :cond_8

    const/16 v6, 0xa

    if-ne v8, v6, :cond_a

    .line 1443
    :cond_8
    const/4 v6, 0x0

    .line 1449
    :cond_9
    :goto_6
    invoke-static {v8}, Ljavax/mail/internet/MimeUtility;->nonascii(I)Z
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    move-result v9

    if-eqz v9, :cond_c

    .line 1450
    if-eqz p2, :cond_b

    .line 1451
    const/4 v1, 0x3

    goto :goto_4

    .line 1445
    :cond_a
    add-int/lit8 v6, v9, 0x1

    .line 1446
    const/16 v9, 0x3e6

    if-le v6, v9, :cond_9

    .line 1447
    const/4 v5, 0x1

    goto :goto_6

    .line 1453
    :cond_b
    add-int/lit8 v1, v1, 0x1

    .line 1432
    :goto_7
    add-int/lit8 v7, v7, 0x1

    move v9, v6

    move v6, v8

    goto :goto_5

    .line 1455
    :cond_c
    add-int/lit8 v3, v3, 0x1

    goto :goto_7

    .line 1458
    :catch_0
    move-exception v2

    move v2, v3

    move v3, v4

    move v4, v5

    :goto_8
    move v5, v4

    move v4, v3

    move v3, v2

    .line 1459
    goto :goto_3

    .line 1474
    :cond_d
    if-nez v4, :cond_10

    .line 1479
    if-eqz v1, :cond_e

    .line 1480
    const/4 v1, 0x3

    goto :goto_4

    .line 1482
    :cond_e
    if-eqz v3, :cond_f

    .line 1483
    const/4 v1, 0x2

    goto/16 :goto_4

    .line 1485
    :cond_f
    const/4 v1, 0x1

    goto/16 :goto_4

    .line 1487
    :cond_10
    if-le v5, v4, :cond_11

    .line 1488
    const/4 v1, 0x2

    goto/16 :goto_4

    .line 1489
    :cond_11
    const/4 v1, 0x3

    goto/16 :goto_4

    .line 1458
    :catch_1
    move-exception v2

    move v2, v5

    move v14, v4

    move v4, v3

    move v3, v1

    move v1, v14

    goto :goto_8

    :cond_12
    move v8, v9

    move v14, v5

    move v5, v3

    move v3, v14

    move v15, v1

    move v1, v4

    move v4, v15

    goto/16 :goto_2

    :cond_13
    move-object v10, v1

    move v8, v9

    move v11, v3

    move v1, v4

    move v3, v5

    move v4, v6

    move v5, v7

    goto/16 :goto_2
.end method

.method static checkAscii(Ljava/lang/String;)I
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 1345
    .line 1346
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v3

    move v2, v0

    move v1, v0

    .line 1348
    :goto_0
    if-lt v2, v3, :cond_0

    .line 1355
    if-nez v0, :cond_2

    .line 1356
    const/4 v0, 0x1

    .line 1360
    :goto_1
    return v0

    .line 1349
    :cond_0
    invoke-virtual {p0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v4

    invoke-static {v4}, Ljavax/mail/internet/MimeUtility;->nonascii(I)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 1350
    add-int/lit8 v0, v0, 0x1

    .line 1348
    :goto_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 1352
    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 1357
    :cond_2
    if-le v1, v0, :cond_3

    .line 1358
    const/4 v0, 0x2

    goto :goto_1

    .line 1360
    :cond_3
    const/4 v0, 0x3

    goto :goto_1
.end method

.method static checkAscii([B)I
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 1374
    move v1, v0

    move v2, v0

    .line 1376
    :goto_0
    array-length v3, p0

    if-lt v0, v3, :cond_0

    .line 1386
    if-nez v1, :cond_2

    .line 1387
    const/4 v0, 0x1

    .line 1391
    :goto_1
    return v0

    .line 1380
    :cond_0
    aget-byte v3, p0, v0

    and-int/lit16 v3, v3, 0xff

    invoke-static {v3}, Ljavax/mail/internet/MimeUtility;->nonascii(I)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 1381
    add-int/lit8 v1, v1, 0x1

    .line 1376
    :goto_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1383
    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    .line 1388
    :cond_2
    if-le v2, v1, :cond_3

    .line 1389
    const/4 v0, 0x2

    goto :goto_1

    .line 1391
    :cond_3
    const/4 v0, 0x3

    goto :goto_1
.end method

.method public static decode(Ljava/io/InputStream;Ljava/lang/String;)Ljava/io/InputStream;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 306
    const-string v0, "base64"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 307
    new-instance v0, Lcom/sun/mail/util/BASE64DecoderStream;

    invoke-direct {v0, p0}, Lcom/sun/mail/util/BASE64DecoderStream;-><init>(Ljava/io/InputStream;)V

    move-object p0, v0

    .line 317
    :cond_0
    :goto_0
    return-object p0

    .line 308
    :cond_1
    const-string v0, "quoted-printable"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 309
    new-instance v0, Lcom/sun/mail/util/QPDecoderStream;

    invoke-direct {v0, p0}, Lcom/sun/mail/util/QPDecoderStream;-><init>(Ljava/io/InputStream;)V

    move-object p0, v0

    goto :goto_0

    .line 310
    :cond_2
    const-string v0, "uuencode"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    .line 311
    const-string v0, "x-uuencode"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    .line 312
    const-string v0, "x-uue"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 313
    :cond_3
    new-instance v0, Lcom/sun/mail/util/UUDecoderStream;

    invoke-direct {v0, p0}, Lcom/sun/mail/util/UUDecoderStream;-><init>(Ljava/io/InputStream;)V

    move-object p0, v0

    goto :goto_0

    .line 314
    :cond_4
    const-string v0, "binary"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 315
    const-string v0, "7bit"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 316
    const-string v0, "8bit"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 319
    new-instance v0, Ljavax/mail/MessagingException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Unknown encoding: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static decodeInnerWords(Ljava/lang/String;)Ljava/lang/String;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/UnsupportedEncodingException;
        }
    .end annotation

    .prologue
    const/16 v5, 0x3f

    .line 861
    const/4 v0, 0x0

    .line 862
    new-instance v1, Ljava/lang/StringBuffer;

    invoke-direct {v1}, Ljava/lang/StringBuffer;-><init>()V

    .line 863
    :goto_0
    const-string v2, "=?"

    invoke-virtual {p0, v2, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;I)I

    move-result v2

    if-gez v2, :cond_1

    .line 886
    :cond_0
    if-nez v0, :cond_2

    .line 890
    :goto_1
    return-object p0

    .line 864
    :cond_1
    invoke-virtual {p0, v0, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 866
    add-int/lit8 v3, v2, 0x2

    invoke-virtual {p0, v5, v3}, Ljava/lang/String;->indexOf(II)I

    move-result v3

    .line 867
    if-ltz v3, :cond_0

    .line 870
    add-int/lit8 v3, v3, 0x1

    invoke-virtual {p0, v5, v3}, Ljava/lang/String;->indexOf(II)I

    move-result v3

    .line 871
    if-ltz v3, :cond_0

    .line 874
    const-string v4, "?="

    add-int/lit8 v3, v3, 0x1

    invoke-virtual {p0, v4, v3}, Ljava/lang/String;->indexOf(Ljava/lang/String;I)I

    move-result v3

    .line 875
    if-ltz v3, :cond_0

    .line 877
    add-int/lit8 v0, v3, 0x2

    invoke-virtual {p0, v2, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    .line 879
    :try_start_0
    invoke-static {v0}, Ljavax/mail/internet/MimeUtility;->decodeWord(Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljavax/mail/internet/ParseException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 883
    :goto_2
    invoke-virtual {v1, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 884
    add-int/lit8 v0, v3, 0x2

    goto :goto_0

    .line 888
    :cond_2
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v0, v2, :cond_3

    .line 889
    invoke-virtual {p0, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 890
    :cond_3
    invoke-virtual {v1}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p0

    goto :goto_1

    .line 880
    :catch_0
    move-exception v2

    goto :goto_2
.end method

.method public static decodeText(Ljava/lang/String;)Ljava/lang/String;
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/UnsupportedEncodingException;
        }
    .end annotation

    .prologue
    const/4 v4, 0x1

    const/4 v1, 0x0

    .line 501
    const-string v0, " \t\n\r"

    .line 513
    const-string v2, "=?"

    invoke-virtual {p0, v2}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v2

    const/4 v3, -0x1

    if-ne v2, v3, :cond_0

    .line 581
    :goto_0
    return-object p0

    .line 518
    :cond_0
    new-instance v5, Ljava/util/StringTokenizer;

    invoke-direct {v5, p0, v0, v4}, Ljava/util/StringTokenizer;-><init>(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 519
    new-instance v6, Ljava/lang/StringBuffer;

    invoke-direct {v6}, Ljava/lang/StringBuffer;-><init>()V

    .line 520
    new-instance v7, Ljava/lang/StringBuffer;

    invoke-direct {v7}, Ljava/lang/StringBuffer;-><init>()V

    move v0, v1

    .line 523
    :goto_1
    invoke-virtual {v5}, Ljava/util/StringTokenizer;->hasMoreTokens()Z

    move-result v2

    if-nez v2, :cond_1

    .line 580
    invoke-virtual {v6, v7}, Ljava/lang/StringBuffer;->append(Ljava/lang/StringBuffer;)Ljava/lang/StringBuffer;

    .line 581
    invoke-virtual {v6}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p0

    goto :goto_0

    .line 525
    :cond_1
    invoke-virtual {v5}, Ljava/util/StringTokenizer;->nextToken()Ljava/lang/String;

    move-result-object v3

    .line 527
    invoke-virtual {v3, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    const/16 v8, 0x20

    if-eq v2, v8, :cond_2

    const/16 v8, 0x9

    if-eq v2, v8, :cond_2

    .line 528
    const/16 v8, 0xd

    if-eq v2, v8, :cond_2

    const/16 v8, 0xa

    if-ne v2, v8, :cond_3

    .line 529
    :cond_2
    invoke-virtual {v7, v2}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    goto :goto_1

    .line 534
    :cond_3
    :try_start_0
    invoke-static {v3}, Ljavax/mail/internet/MimeUtility;->decodeWord(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 536
    if-nez v0, :cond_4

    invoke-virtual {v7}, Ljava/lang/StringBuffer;->length()I

    move-result v8

    if-lez v8, :cond_4

    .line 540
    invoke-virtual {v6, v7}, Ljava/lang/StringBuffer;->append(Ljava/lang/StringBuffer;)Ljava/lang/StringBuffer;
    :try_end_0
    .catch Ljavax/mail/internet/ParseException; {:try_start_0 .. :try_end_0} :catch_0

    :cond_4
    move v0, v4

    .line 576
    :goto_2
    invoke-virtual {v6, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 577
    invoke-virtual {v7, v1}, Ljava/lang/StringBuffer;->setLength(I)V

    goto :goto_1

    .line 543
    :catch_0
    move-exception v2

    .line 547
    sget-boolean v2, Ljavax/mail/internet/MimeUtility;->decodeStrict:Z

    if-nez v2, :cond_9

    .line 548
    invoke-static {v3}, Ljavax/mail/internet/MimeUtility;->decodeInnerWords(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 549
    if-eq v2, v3, :cond_7

    .line 552
    if-eqz v0, :cond_5

    const-string v0, "=?"

    invoke-virtual {v3, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_6

    .line 557
    :cond_5
    invoke-virtual {v7}, Ljava/lang/StringBuffer;->length()I

    move-result v0

    if-lez v0, :cond_6

    .line 558
    invoke-virtual {v6, v7}, Ljava/lang/StringBuffer;->append(Ljava/lang/StringBuffer;)Ljava/lang/StringBuffer;

    .line 561
    :cond_6
    const-string v0, "?="

    invoke-virtual {v3, v0}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    goto :goto_2

    .line 565
    :cond_7
    invoke-virtual {v7}, Ljava/lang/StringBuffer;->length()I

    move-result v0

    if-lez v0, :cond_8

    .line 566
    invoke-virtual {v6, v7}, Ljava/lang/StringBuffer;->append(Ljava/lang/StringBuffer;)Ljava/lang/StringBuffer;

    :cond_8
    move-object v2, v3

    move v0, v1

    .line 567
    goto :goto_2

    .line 571
    :cond_9
    invoke-virtual {v7}, Ljava/lang/StringBuffer;->length()I

    move-result v0

    if-lez v0, :cond_a

    .line 572
    invoke-virtual {v6, v7}, Ljava/lang/StringBuffer;->append(Ljava/lang/StringBuffer;)Ljava/lang/StringBuffer;

    :cond_a
    move-object v2, v3

    move v0, v1

    .line 573
    goto :goto_2
.end method

.method public static decodeWord(Ljava/lang/String;)Ljava/lang/String;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/internet/ParseException;,
            Ljava/io/UnsupportedEncodingException;
        }
    .end annotation

    .prologue
    const/16 v3, 0x3f

    const/4 v4, -0x1

    .line 760
    const-string v0, "=?"

    invoke-virtual {p0, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 761
    new-instance v0, Ljavax/mail/internet/ParseException;

    .line 762
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "encoded word does not start with \"=?\": "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 761
    invoke-direct {v0, v1}, Ljavax/mail/internet/ParseException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 765
    :cond_0
    const/4 v0, 0x2

    .line 766
    invoke-virtual {p0, v3, v0}, Ljava/lang/String;->indexOf(II)I

    move-result v1

    if-ne v1, v4, :cond_1

    .line 767
    new-instance v0, Ljavax/mail/internet/ParseException;

    .line 768
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "encoded word does not include charset: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 767
    invoke-direct {v0, v1}, Ljavax/mail/internet/ParseException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 769
    :cond_1
    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljavax/mail/internet/MimeUtility;->javaCharset(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 772
    add-int/lit8 v0, v1, 0x1

    .line 773
    invoke-virtual {p0, v3, v0}, Ljava/lang/String;->indexOf(II)I

    move-result v1

    if-ne v1, v4, :cond_2

    .line 774
    new-instance v0, Ljavax/mail/internet/ParseException;

    .line 775
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "encoded word does not include encoding: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 774
    invoke-direct {v0, v1}, Ljavax/mail/internet/ParseException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 776
    :cond_2
    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    .line 779
    add-int/lit8 v1, v1, 0x1

    .line 780
    const-string v3, "?="

    invoke-virtual {p0, v3, v1}, Ljava/lang/String;->indexOf(Ljava/lang/String;I)I

    move-result v3

    if-ne v3, v4, :cond_3

    .line 781
    new-instance v0, Ljavax/mail/internet/ParseException;

    .line 782
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "encoded word does not end with \"?=\": "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 781
    invoke-direct {v0, v1}, Ljavax/mail/internet/ParseException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 790
    :cond_3
    invoke-virtual {p0, v1, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    .line 794
    :try_start_0
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v4

    if-lez v4, :cond_9

    .line 797
    new-instance v4, Ljava/io/ByteArrayInputStream;

    invoke-static {v1}, Lcom/sun/mail/util/ASCIIUtility;->getBytes(Ljava/lang/String;)[B

    move-result-object v1

    invoke-direct {v4, v1}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    .line 801
    const-string v1, "B"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_6

    .line 802
    new-instance v0, Lcom/sun/mail/util/BASE64DecoderStream;

    invoke-direct {v0, v4}, Lcom/sun/mail/util/BASE64DecoderStream;-><init>(Ljava/io/InputStream;)V

    .line 814
    :goto_0
    invoke-virtual {v4}, Ljava/io/ByteArrayInputStream;->available()I

    move-result v1

    .line 815
    new-array v4, v1, [B

    .line 817
    const/4 v5, 0x0

    invoke-virtual {v0, v4, v5, v1}, Ljava/io/InputStream;->read([BII)I

    move-result v1

    .line 821
    if-gtz v1, :cond_8

    const-string v0, ""

    .line 827
    :goto_1
    add-int/lit8 v1, v3, 0x2

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v4

    if-ge v1, v4, :cond_5

    .line 829
    add-int/lit8 v1, v3, 0x2

    invoke-virtual {p0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    .line 830
    sget-boolean v3, Ljavax/mail/internet/MimeUtility;->decodeStrict:Z

    if-nez v3, :cond_4

    .line 831
    invoke-static {v1}, Ljavax/mail/internet/MimeUtility;->decodeInnerWords(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 832
    :cond_4
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 834
    :cond_5
    return-object v0

    .line 803
    :cond_6
    const-string v1, "Q"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_7

    .line 804
    new-instance v0, Lcom/sun/mail/util/QDecoderStream;

    invoke-direct {v0, v4}, Lcom/sun/mail/util/QDecoderStream;-><init>(Ljava/io/InputStream;)V
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_2

    goto :goto_0

    .line 835
    :catch_0
    move-exception v0

    .line 838
    throw v0

    .line 806
    :cond_7
    :try_start_1
    new-instance v1, Ljava/io/UnsupportedEncodingException;

    .line 807
    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "unknown encoding: "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 806
    invoke-direct {v1, v0}, Ljava/io/UnsupportedEncodingException;-><init>(Ljava/lang/String;)V

    throw v1
    :try_end_1
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/IllegalArgumentException; {:try_start_1 .. :try_end_1} :catch_2

    .line 839
    :catch_1
    move-exception v0

    .line 841
    new-instance v1, Ljavax/mail/internet/ParseException;

    invoke-virtual {v0}, Ljava/io/IOException;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljavax/mail/internet/ParseException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 822
    :cond_8
    :try_start_2
    new-instance v0, Ljava/lang/String;

    const/4 v5, 0x0

    invoke-direct {v0, v4, v5, v1, v2}, Ljava/lang/String;-><init>([BIILjava/lang/String;)V
    :try_end_2
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/lang/IllegalArgumentException; {:try_start_2 .. :try_end_2} :catch_2

    goto :goto_1

    .line 842
    :catch_2
    move-exception v0

    .line 850
    new-instance v0, Ljava/io/UnsupportedEncodingException;

    invoke-direct {v0, v2}, Ljava/io/UnsupportedEncodingException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 825
    :cond_9
    :try_start_3
    const-string v0, ""
    :try_end_3
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_3 .. :try_end_3} :catch_0
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1
    .catch Ljava/lang/IllegalArgumentException; {:try_start_3 .. :try_end_3} :catch_2

    goto :goto_1
.end method

.method private static doEncode(Ljava/lang/String;ZLjava/lang/String;ILjava/lang/String;ZZLjava/lang/StringBuffer;)V
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/UnsupportedEncodingException;
        }
    .end annotation

    .prologue
    .line 699
    invoke-virtual {p0, p2}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v2

    .line 701
    if-eqz p1, :cond_0

    .line 702
    invoke-static {v2}, Lcom/sun/mail/util/BEncoderStream;->encodedLength([B)I

    move-result v1

    .line 707
    :goto_0
    if-le v1, p3, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v9

    const/4 v1, 0x1

    if-le v9, v1, :cond_1

    .line 710
    const/4 v1, 0x0

    div-int/lit8 v2, v9, 0x2

    invoke-virtual {p0, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    move v2, p1

    move-object v3, p2

    move v4, p3

    move-object v5, p4

    move v6, p5

    move/from16 v7, p6

    move-object/from16 v8, p7

    invoke-static/range {v1 .. v8}, Ljavax/mail/internet/MimeUtility;->doEncode(Ljava/lang/String;ZLjava/lang/String;ILjava/lang/String;ZZLjava/lang/StringBuffer;)V

    .line 712
    div-int/lit8 v1, v9, 0x2

    invoke-virtual {p0, v1, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    .line 713
    const/4 v6, 0x0

    move v2, p1

    move-object v3, p2

    move v4, p3

    move-object v5, p4

    move/from16 v7, p6

    move-object/from16 v8, p7

    .line 712
    invoke-static/range {v1 .. v8}, Ljavax/mail/internet/MimeUtility;->doEncode(Ljava/lang/String;ZLjava/lang/String;ILjava/lang/String;ZZLjava/lang/StringBuffer;)V

    .line 742
    :goto_1
    return-void

    .line 704
    :cond_0
    move/from16 v0, p6

    invoke-static {v2, v0}, Lcom/sun/mail/util/QEncoderStream;->encodedLength([BZ)I

    move-result v1

    goto :goto_0

    .line 716
    :cond_1
    new-instance v3, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v3}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 718
    if-eqz p1, :cond_3

    .line 719
    new-instance v1, Lcom/sun/mail/util/BEncoderStream;

    invoke-direct {v1, v3}, Lcom/sun/mail/util/BEncoderStream;-><init>(Ljava/io/OutputStream;)V

    .line 724
    :goto_2
    :try_start_0
    invoke-virtual {v1, v2}, Ljava/io/OutputStream;->write([B)V

    .line 725
    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 728
    :goto_3
    invoke-virtual {v3}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v2

    .line 731
    if-nez p5, :cond_2

    .line 732
    sget-boolean v1, Ljavax/mail/internet/MimeUtility;->foldEncodedWords:Z

    if-eqz v1, :cond_4

    .line 733
    const-string v1, "\r\n "

    move-object/from16 v0, p7

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 737
    :cond_2
    :goto_4
    move-object/from16 v0, p7

    invoke-virtual {v0, p4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 738
    const/4 v1, 0x0

    :goto_5
    array-length v3, v2

    if-lt v1, v3, :cond_5

    .line 740
    const-string v1, "?="

    move-object/from16 v0, p7

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    goto :goto_1

    .line 721
    :cond_3
    new-instance v1, Lcom/sun/mail/util/QEncoderStream;

    move/from16 v0, p6

    invoke-direct {v1, v3, v0}, Lcom/sun/mail/util/QEncoderStream;-><init>(Ljava/io/OutputStream;Z)V

    goto :goto_2

    .line 735
    :cond_4
    const-string v1, " "

    move-object/from16 v0, p7

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    goto :goto_4

    .line 739
    :cond_5
    aget-byte v3, v2, v1

    int-to-char v3, v3

    move-object/from16 v0, p7

    invoke-virtual {v0, v3}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 738
    add-int/lit8 v1, v1, 0x1

    goto :goto_5

    .line 726
    :catch_0
    move-exception v1

    goto :goto_3
.end method

.method public static encode(Ljava/io/OutputStream;Ljava/lang/String;)Ljava/io/OutputStream;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 335
    if-nez p1, :cond_1

    .line 348
    :cond_0
    :goto_0
    return-object p0

    .line 337
    :cond_1
    const-string v0, "base64"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 338
    new-instance v0, Lcom/sun/mail/util/BASE64EncoderStream;

    invoke-direct {v0, p0}, Lcom/sun/mail/util/BASE64EncoderStream;-><init>(Ljava/io/OutputStream;)V

    move-object p0, v0

    goto :goto_0

    .line 339
    :cond_2
    const-string v0, "quoted-printable"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 340
    new-instance v0, Lcom/sun/mail/util/QPEncoderStream;

    invoke-direct {v0, p0}, Lcom/sun/mail/util/QPEncoderStream;-><init>(Ljava/io/OutputStream;)V

    move-object p0, v0

    goto :goto_0

    .line 341
    :cond_3
    const-string v0, "uuencode"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_4

    .line 342
    const-string v0, "x-uuencode"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_4

    .line 343
    const-string v0, "x-uue"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 344
    :cond_4
    new-instance v0, Lcom/sun/mail/util/UUEncoderStream;

    invoke-direct {v0, p0}, Lcom/sun/mail/util/UUEncoderStream;-><init>(Ljava/io/OutputStream;)V

    move-object p0, v0

    goto :goto_0

    .line 345
    :cond_5
    const-string v0, "binary"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 346
    const-string v0, "7bit"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 347
    const-string v0, "8bit"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 350
    new-instance v0, Ljavax/mail/MessagingException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Unknown encoding: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static encode(Ljava/io/OutputStream;Ljava/lang/String;Ljava/lang/String;)Ljava/io/OutputStream;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 372
    if-nez p1, :cond_1

    .line 385
    :cond_0
    :goto_0
    return-object p0

    .line 374
    :cond_1
    const-string v0, "base64"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 375
    new-instance v0, Lcom/sun/mail/util/BASE64EncoderStream;

    invoke-direct {v0, p0}, Lcom/sun/mail/util/BASE64EncoderStream;-><init>(Ljava/io/OutputStream;)V

    move-object p0, v0

    goto :goto_0

    .line 376
    :cond_2
    const-string v0, "quoted-printable"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 377
    new-instance v0, Lcom/sun/mail/util/QPEncoderStream;

    invoke-direct {v0, p0}, Lcom/sun/mail/util/QPEncoderStream;-><init>(Ljava/io/OutputStream;)V

    move-object p0, v0

    goto :goto_0

    .line 378
    :cond_3
    const-string v0, "uuencode"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_4

    .line 379
    const-string v0, "x-uuencode"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_4

    .line 380
    const-string v0, "x-uue"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 381
    :cond_4
    new-instance v0, Lcom/sun/mail/util/UUEncoderStream;

    invoke-direct {v0, p0, p2}, Lcom/sun/mail/util/UUEncoderStream;-><init>(Ljava/io/OutputStream;Ljava/lang/String;)V

    move-object p0, v0

    goto :goto_0

    .line 382
    :cond_5
    const-string v0, "binary"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 383
    const-string v0, "7bit"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 384
    const-string v0, "8bit"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 387
    new-instance v0, Ljavax/mail/MessagingException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Unknown encoding: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static encodeText(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/UnsupportedEncodingException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    .line 428
    invoke-static {p0, v0, v0}, Ljavax/mail/internet/MimeUtility;->encodeText(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static encodeText(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/UnsupportedEncodingException;
        }
    .end annotation

    .prologue
    .line 459
    const/4 v0, 0x0

    invoke-static {p0, p1, p2, v0}, Ljavax/mail/internet/MimeUtility;->encodeWord(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static encodeWord(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/UnsupportedEncodingException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    .line 607
    invoke-static {p0, v0, v0}, Ljavax/mail/internet/MimeUtility;->encodeWord(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static encodeWord(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/UnsupportedEncodingException;
        }
    .end annotation

    .prologue
    .line 635
    const/4 v0, 0x1

    invoke-static {p0, p1, p2, v0}, Ljavax/mail/internet/MimeUtility;->encodeWord(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private static encodeWord(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/String;
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/UnsupportedEncodingException;
        }
    .end annotation

    .prologue
    const/4 v5, 0x1

    .line 651
    invoke-static {p0}, Ljavax/mail/internet/MimeUtility;->checkAscii(Ljava/lang/String;)I

    move-result v0

    .line 652
    if-ne v0, v5, :cond_0

    .line 689
    :goto_0
    return-object p0

    .line 657
    :cond_0
    if-nez p1, :cond_2

    .line 658
    invoke-static {}, Ljavax/mail/internet/MimeUtility;->getDefaultJavaCharset()Ljava/lang/String;

    move-result-object v2

    .line 659
    invoke-static {}, Ljavax/mail/internet/MimeUtility;->getDefaultMIMECharset()Ljava/lang/String;

    move-result-object p1

    .line 664
    :goto_1
    if-nez p2, :cond_1

    .line 665
    const/4 v1, 0x3

    if-eq v0, v1, :cond_3

    .line 666
    const-string p2, "Q"

    .line 672
    :cond_1
    :goto_2
    const-string v0, "B"

    invoke-virtual {p2, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    move v1, v5

    .line 680
    :goto_3
    new-instance v7, Ljava/lang/StringBuffer;

    invoke-direct {v7}, Ljava/lang/StringBuffer;-><init>()V

    .line 685
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    rsub-int/lit8 v3, v0, 0x44

    .line 686
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v4, "=?"

    invoke-direct {v0, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v4, "?"

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v4, "?"

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    move-object v0, p0

    move v6, p3

    .line 681
    invoke-static/range {v0 .. v7}, Ljavax/mail/internet/MimeUtility;->doEncode(Ljava/lang/String;ZLjava/lang/String;ILjava/lang/String;ZZLjava/lang/StringBuffer;)V

    .line 689
    invoke-virtual {v7}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p0

    goto :goto_0

    .line 661
    :cond_2
    invoke-static {p1}, Ljavax/mail/internet/MimeUtility;->javaCharset(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_1

    .line 668
    :cond_3
    const-string p2, "B"

    goto :goto_2

    .line 674
    :cond_4
    const-string v0, "Q"

    invoke-virtual {p2, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 675
    const/4 v1, 0x0

    goto :goto_3

    .line 677
    :cond_5
    new-instance v0, Ljava/io/UnsupportedEncodingException;

    .line 678
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Unknown transfer encoding: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 677
    invoke-direct {v0, v1}, Ljava/io/UnsupportedEncodingException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static fold(ILjava/lang/String;)Ljava/lang/String;
    .locals 10

    .prologue
    const/16 v9, 0x4c

    const/16 v8, 0x20

    const/16 v7, 0x9

    const/4 v3, -0x1

    const/4 v1, 0x0

    .line 968
    sget-boolean v0, Ljavax/mail/internet/MimeUtility;->foldText:Z

    if-nez v0, :cond_1

    .line 1015
    :cond_0
    :goto_0
    return-object p1

    .line 974
    :cond_1
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    :goto_1
    if-gez v0, :cond_4

    .line 979
    :cond_2
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    add-int/lit8 v2, v2, -0x1

    if-eq v0, v2, :cond_3

    .line 980
    add-int/lit8 v0, v0, 0x1

    invoke-virtual {p1, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p1

    .line 983
    :cond_3
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    add-int/2addr v0, p0

    if-le v0, v9, :cond_0

    .line 987
    new-instance v6, Ljava/lang/StringBuffer;

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    add-int/lit8 v0, v0, 0x4

    invoke-direct {v6, v0}, Ljava/lang/StringBuffer;-><init>(I)V

    move v0, v1

    .line 989
    :goto_2
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    add-int/2addr v2, p0

    if-gt v2, v9, :cond_6

    .line 1014
    :goto_3
    invoke-virtual {v6, p1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 1015
    invoke-virtual {v6}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    .line 975
    :cond_4
    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    .line 976
    if-eq v2, v8, :cond_5

    if-eq v2, v7, :cond_5

    const/16 v4, 0xd

    if-eq v2, v4, :cond_5

    const/16 v4, 0xa

    if-ne v2, v4, :cond_2

    .line 974
    :cond_5
    add-int/lit8 v0, v0, -0x1

    goto :goto_1

    :cond_6
    move v2, v3

    move v4, v0

    move v0, v1

    .line 991
    :goto_4
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v5

    if-lt v0, v5, :cond_8

    .line 1000
    :cond_7
    if-ne v2, v3, :cond_c

    .line 1002
    invoke-virtual {v6, p1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 1003
    const-string p1, ""

    goto :goto_3

    .line 992
    :cond_8
    if-eq v2, v3, :cond_9

    add-int v5, p0, v0

    if-gt v5, v9, :cond_7

    .line 994
    :cond_9
    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v5

    .line 995
    if-eq v5, v8, :cond_a

    if-ne v5, v7, :cond_b

    .line 996
    :cond_a
    if-eq v4, v8, :cond_b

    if-eq v4, v7, :cond_b

    move v2, v0

    .line 991
    :cond_b
    add-int/lit8 v0, v0, 0x1

    move v4, v5

    goto :goto_4

    .line 1007
    :cond_c
    invoke-virtual {p1, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v6, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 1008
    const-string v0, "\r\n"

    invoke-virtual {v6, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 1009
    invoke-virtual {p1, v2}, Ljava/lang/String;->charAt(I)C

    move-result v0

    .line 1010
    invoke-virtual {v6, v0}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 1011
    add-int/lit8 v2, v2, 0x1

    invoke-virtual {p1, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p1

    .line 1012
    const/4 p0, 0x1

    goto :goto_2
.end method

.method public static getDefaultJavaCharset()Ljava/lang/String;
    .locals 2

    .prologue
    .line 1154
    sget-object v0, Ljavax/mail/internet/MimeUtility;->defaultJavaCharset:Ljava/lang/String;

    if-nez v0, :cond_1

    .line 1159
    const/4 v0, 0x0

    .line 1161
    :try_start_0
    const-string v1, "mail.mime.charset"

    invoke-static {v1}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v0

    .line 1163
    :goto_0
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_0

    .line 1164
    invoke-static {v0}, Ljavax/mail/internet/MimeUtility;->javaCharset(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Ljavax/mail/internet/MimeUtility;->defaultJavaCharset:Ljava/lang/String;

    .line 1165
    sget-object v0, Ljavax/mail/internet/MimeUtility;->defaultJavaCharset:Ljava/lang/String;

    .line 1186
    :goto_1
    return-object v0

    .line 1169
    :cond_0
    :try_start_1
    const-string v0, "file.encoding"

    .line 1170
    const-string v1, "8859_1"

    .line 1169
    invoke-static {v0, v1}, Ljava/lang/System;->getProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Ljavax/mail/internet/MimeUtility;->defaultJavaCharset:Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/SecurityException; {:try_start_1 .. :try_end_1} :catch_0

    .line 1186
    :cond_1
    :goto_2
    sget-object v0, Ljavax/mail/internet/MimeUtility;->defaultJavaCharset:Ljava/lang/String;

    goto :goto_1

    .line 1171
    :catch_0
    move-exception v0

    .line 1179
    new-instance v0, Ljava/io/InputStreamReader;

    new-instance v1, Ljavax/mail/internet/MimeUtility$1NullInputStream;

    invoke-direct {v1}, Ljavax/mail/internet/MimeUtility$1NullInputStream;-><init>()V

    invoke-direct {v0, v1}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V

    .line 1180
    invoke-virtual {v0}, Ljava/io/InputStreamReader;->getEncoding()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Ljavax/mail/internet/MimeUtility;->defaultJavaCharset:Ljava/lang/String;

    .line 1181
    sget-object v0, Ljavax/mail/internet/MimeUtility;->defaultJavaCharset:Ljava/lang/String;

    if-nez v0, :cond_1

    .line 1182
    const-string v0, "8859_1"

    sput-object v0, Ljavax/mail/internet/MimeUtility;->defaultJavaCharset:Ljava/lang/String;

    goto :goto_2

    .line 1162
    :catch_1
    move-exception v1

    goto :goto_0
.end method

.method static getDefaultMIMECharset()Ljava/lang/String;
    .locals 1

    .prologue
    .line 1193
    sget-object v0, Ljavax/mail/internet/MimeUtility;->defaultMIMECharset:Ljava/lang/String;

    if-nez v0, :cond_0

    .line 1195
    :try_start_0
    const-string v0, "mail.mime.charset"

    invoke-static {v0}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Ljavax/mail/internet/MimeUtility;->defaultMIMECharset:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1198
    :cond_0
    :goto_0
    sget-object v0, Ljavax/mail/internet/MimeUtility;->defaultMIMECharset:Ljava/lang/String;

    if-nez v0, :cond_1

    .line 1199
    invoke-static {}, Ljavax/mail/internet/MimeUtility;->getDefaultJavaCharset()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljavax/mail/internet/MimeUtility;->mimeCharset(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Ljavax/mail/internet/MimeUtility;->defaultMIMECharset:Ljava/lang/String;

    .line 1200
    :cond_1
    sget-object v0, Ljavax/mail/internet/MimeUtility;->defaultMIMECharset:Ljava/lang/String;

    return-object v0

    .line 1196
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public static getEncoding(Ljavax/activation/DataHandler;)Ljava/lang/String;
    .locals 4

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 232
    .line 248
    invoke-virtual {p0}, Ljavax/activation/DataHandler;->getName()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 249
    invoke-virtual {p0}, Ljavax/activation/DataHandler;->getDataSource()Ljavax/activation/DataSource;

    move-result-object v0

    invoke-static {v0}, Ljavax/mail/internet/MimeUtility;->getEncoding(Ljavax/activation/DataSource;)Ljava/lang/String;

    move-result-object v0

    .line 290
    :goto_0
    return-object v0

    .line 252
    :cond_0
    :try_start_0
    new-instance v0, Ljavax/mail/internet/ContentType;

    invoke-virtual {p0}, Ljavax/activation/DataHandler;->getContentType()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljavax/mail/internet/ContentType;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 257
    const-string v1, "text/*"

    invoke-virtual {v0, v1}, Ljavax/mail/internet/ContentType;->match(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 259
    new-instance v0, Ljavax/mail/internet/AsciiOutputStream;

    invoke-direct {v0, v2, v2}, Ljavax/mail/internet/AsciiOutputStream;-><init>(ZZ)V

    .line 261
    :try_start_1
    invoke-virtual {p0, v0}, Ljavax/activation/DataHandler;->writeTo(Ljava/io/OutputStream;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    .line 265
    :goto_1
    invoke-virtual {v0}, Ljavax/mail/internet/AsciiOutputStream;->getAscii()I

    move-result v0

    packed-switch v0, :pswitch_data_0

    .line 273
    const-string v0, "base64"

    goto :goto_0

    .line 253
    :catch_0
    move-exception v0

    .line 254
    const-string v0, "base64"

    goto :goto_0

    .line 267
    :pswitch_0
    const-string v0, "7bit"

    goto :goto_0

    .line 270
    :pswitch_1
    const-string v0, "quoted-printable"

    goto :goto_0

    .line 280
    :cond_1
    new-instance v0, Ljavax/mail/internet/AsciiOutputStream;

    sget-boolean v1, Ljavax/mail/internet/MimeUtility;->encodeEolStrict:Z

    invoke-direct {v0, v3, v1}, Ljavax/mail/internet/AsciiOutputStream;-><init>(ZZ)V

    .line 282
    :try_start_2
    invoke-virtual {p0, v0}, Ljavax/activation/DataHandler;->writeTo(Ljava/io/OutputStream;)V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2

    .line 284
    :goto_2
    invoke-virtual {v0}, Ljavax/mail/internet/AsciiOutputStream;->getAscii()I

    move-result v0

    if-ne v0, v3, :cond_2

    .line 285
    const-string v0, "7bit"

    goto :goto_0

    .line 287
    :cond_2
    const-string v0, "base64"

    goto :goto_0

    .line 262
    :catch_1
    move-exception v1

    goto :goto_1

    .line 283
    :catch_2
    move-exception v1

    goto :goto_2

    .line 265
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method public static getEncoding(Ljavax/activation/DataSource;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 184
    .line 189
    :try_start_0
    new-instance v0, Ljavax/mail/internet/ContentType;

    invoke-interface {p0}, Ljavax/activation/DataSource;->getContentType()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljavax/mail/internet/ContentType;-><init>(Ljava/lang/String;)V

    .line 190
    invoke-interface {p0}, Ljavax/activation/DataSource;->getInputStream()Ljava/io/InputStream;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 195
    const-string v2, "text/*"

    invoke-virtual {v0, v2}, Ljavax/mail/internet/ContentType;->match(Ljava/lang/String;)Z

    move-result v0

    .line 197
    const/4 v2, -0x1

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    invoke-static {v1, v2, v0}, Ljavax/mail/internet/MimeUtility;->checkAscii(Ljava/io/InputStream;IZ)I

    move-result v0

    .line 198
    packed-switch v0, :pswitch_data_0

    .line 206
    const-string v0, "base64"

    .line 212
    :goto_1
    :try_start_1
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    .line 215
    :goto_2
    return-object v0

    .line 191
    :catch_0
    move-exception v0

    .line 192
    const-string v0, "base64"

    goto :goto_2

    .line 197
    :cond_0
    const/4 v0, 0x1

    goto :goto_0

    .line 200
    :pswitch_0
    const-string v0, "7bit"

    goto :goto_1

    .line 203
    :pswitch_1
    const-string v0, "quoted-printable"

    goto :goto_1

    .line 213
    :catch_1
    move-exception v1

    goto :goto_2

    .line 198
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method private static indexOfAny(Ljava/lang/String;Ljava/lang/String;)I
    .locals 1

    .prologue
    .line 1084
    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Ljavax/mail/internet/MimeUtility;->indexOfAny(Ljava/lang/String;Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method private static indexOfAny(Ljava/lang/String;Ljava/lang/String;I)I
    .locals 4

    .prologue
    const/4 v1, -0x1

    .line 1089
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    move v0, p2

    .line 1090
    :goto_0
    if-lt v0, v2, :cond_1

    move v0, v1

    .line 1096
    :cond_0
    :goto_1
    return v0

    .line 1091
    :cond_1
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v3

    invoke-virtual {p1, v3}, Ljava/lang/String;->indexOf(I)I
    :try_end_0
    .catch Ljava/lang/StringIndexOutOfBoundsException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    if-gez v3, :cond_0

    .line 1090
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1095
    :catch_0
    move-exception v0

    move v0, v1

    .line 1096
    goto :goto_1
.end method

.method public static javaCharset(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 1108
    sget-object v0, Ljavax/mail/internet/MimeUtility;->mime2java:Ljava/util/Hashtable;

    if-eqz v0, :cond_0

    if-nez p0, :cond_1

    .line 1114
    :cond_0
    :goto_0
    return-object p0

    .line 1113
    :cond_1
    sget-object v0, Ljavax/mail/internet/MimeUtility;->mime2java:Ljava/util/Hashtable;

    sget-object v1, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {p0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 1114
    if-eqz v0, :cond_0

    move-object p0, v0

    goto :goto_0
.end method

.method private static loadMappings(Lcom/sun/mail/util/LineInputStream;Ljava/util/Hashtable;)V
    .locals 3

    .prologue
    .line 1306
    :cond_0
    :goto_0
    :try_start_0
    invoke-virtual {p0}, Lcom/sun/mail/util/LineInputStream;->readLine()Ljava/lang/String;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v0

    .line 1311
    if-nez v0, :cond_2

    .line 1330
    :cond_1
    :goto_1
    return-void

    .line 1313
    :cond_2
    const-string v1, "--"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    const-string v1, "--"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 1318
    :cond_3
    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-eqz v1, :cond_0

    const-string v1, "#"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 1323
    new-instance v1, Ljava/util/StringTokenizer;

    const-string v2, " \t"

    invoke-direct {v1, v0, v2}, Ljava/util/StringTokenizer;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 1325
    :try_start_1
    invoke-virtual {v1}, Ljava/util/StringTokenizer;->nextToken()Ljava/lang/String;

    move-result-object v0

    .line 1326
    invoke-virtual {v1}, Ljava/util/StringTokenizer;->nextToken()Ljava/lang/String;

    move-result-object v1

    .line 1327
    sget-object v2, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {v0, v2}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0, v1}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_1
    .catch Ljava/util/NoSuchElementException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .line 1328
    :catch_0
    move-exception v0

    goto :goto_0

    .line 1307
    :catch_1
    move-exception v0

    goto :goto_1
.end method

.method public static mimeCharset(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 1131
    sget-object v0, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    if-eqz v0, :cond_0

    if-nez p0, :cond_1

    .line 1137
    :cond_0
    :goto_0
    return-object p0

    .line 1136
    :cond_1
    sget-object v0, Ljavax/mail/internet/MimeUtility;->java2mime:Ljava/util/Hashtable;

    sget-object v1, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {p0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 1137
    if-eqz v0, :cond_0

    move-object p0, v0

    goto :goto_0
.end method

.method static final nonascii(I)Z
    .locals 1

    .prologue
    .line 1493
    const/16 v0, 0x7f

    if-ge p0, v0, :cond_1

    const/16 v0, 0x20

    if-ge p0, v0, :cond_0

    const/16 v0, 0xd

    if-eq p0, v0, :cond_0

    const/16 v0, 0xa

    if-eq p0, v0, :cond_0

    const/16 v0, 0x9

    if-ne p0, v0, :cond_1

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public static quote(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 10

    .prologue
    const/16 v9, 0x5c

    const/16 v8, 0xd

    const/16 v7, 0xa

    const/4 v2, 0x0

    const/16 v6, 0x22

    .line 910
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v3

    move v1, v2

    move v0, v2

    .line 917
    :goto_0
    if-lt v1, v3, :cond_1

    .line 943
    if-eqz v0, :cond_0

    .line 944
    new-instance v0, Ljava/lang/StringBuffer;

    add-int/lit8 v1, v3, 0x2

    invoke-direct {v0, v1}, Ljava/lang/StringBuffer;-><init>(I)V

    .line 945
    invoke-virtual {v0, v6}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v1

    invoke-virtual {v1, v6}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 946
    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p0

    .line 948
    :cond_0
    :goto_1
    return-object p0

    .line 918
    :cond_1
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v4

    .line 919
    if-eq v4, v6, :cond_2

    if-eq v4, v9, :cond_2

    if-eq v4, v8, :cond_2

    if-ne v4, v7, :cond_7

    .line 921
    :cond_2
    new-instance v4, Ljava/lang/StringBuffer;

    add-int/lit8 v0, v3, 0x3

    invoke-direct {v4, v0}, Ljava/lang/StringBuffer;-><init>(I)V

    .line 922
    invoke-virtual {v4, v6}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 923
    invoke-virtual {p0, v2, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move v0, v1

    move v1, v2

    .line 925
    :goto_2
    if-lt v0, v3, :cond_3

    .line 936
    invoke-virtual {v4, v6}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 937
    invoke-virtual {v4}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p0

    goto :goto_1

    .line 926
    :cond_3
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    .line 927
    if-eq v2, v6, :cond_4

    if-eq v2, v9, :cond_4

    .line 928
    if-eq v2, v8, :cond_4

    if-ne v2, v7, :cond_5

    .line 929
    :cond_4
    if-ne v2, v7, :cond_6

    if-ne v1, v8, :cond_6

    .line 933
    :cond_5
    :goto_3
    invoke-virtual {v4, v2}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 925
    add-int/lit8 v0, v0, 0x1

    move v1, v2

    goto :goto_2

    .line 932
    :cond_6
    invoke-virtual {v4, v9}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    goto :goto_3

    .line 938
    :cond_7
    const/16 v5, 0x20

    if-lt v4, v5, :cond_8

    const/16 v5, 0x7f

    if-ge v4, v5, :cond_8

    invoke-virtual {p1, v4}, Ljava/lang/String;->indexOf(I)I

    move-result v4

    if-ltz v4, :cond_9

    .line 940
    :cond_8
    const/4 v0, 0x1

    .line 917
    :cond_9
    add-int/lit8 v1, v1, 0x1

    goto :goto_0
.end method

.method public static unfold(Ljava/lang/String;)Ljava/lang/String;
    .locals 9

    .prologue
    const/16 v8, 0x9

    const/16 v7, 0x20

    const/4 v6, 0x0

    .line 1027
    sget-boolean v0, Ljavax/mail/internet/MimeUtility;->foldText:Z

    if-nez v0, :cond_1

    .line 1074
    :cond_0
    :goto_0
    return-object p0

    .line 1030
    :cond_1
    const/4 v0, 0x0

    .line 1032
    :goto_1
    const-string v1, "\r\n"

    invoke-static {p0, v1}, Ljavax/mail/internet/MimeUtility;->indexOfAny(Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    if-gez v2, :cond_2

    .line 1070
    if-eqz v0, :cond_0

    .line 1071
    invoke-virtual {v0, p0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 1072
    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p0

    goto :goto_0

    .line 1034
    :cond_2
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v3

    .line 1035
    add-int/lit8 v1, v2, 0x1

    .line 1036
    if-ge v1, v3, :cond_3

    add-int/lit8 v4, v1, -0x1

    invoke-virtual {p0, v4}, Ljava/lang/String;->charAt(I)C

    move-result v4

    const/16 v5, 0xd

    if-ne v4, v5, :cond_3

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v4

    const/16 v5, 0xa

    if-ne v4, v5, :cond_3

    .line 1037
    add-int/lit8 v1, v1, 0x1

    .line 1038
    :cond_3
    if-eqz v2, :cond_4

    add-int/lit8 v4, v2, -0x1

    invoke-virtual {p0, v4}, Ljava/lang/String;->charAt(I)C

    move-result v4

    const/16 v5, 0x5c

    if-eq v4, v5, :cond_c

    .line 1042
    :cond_4
    if-ge v1, v3, :cond_a

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v4

    if-eq v4, v7, :cond_5

    if-ne v4, v8, :cond_a

    .line 1043
    :cond_5
    add-int/lit8 v1, v1, 0x1

    .line 1044
    :goto_2
    if-ge v1, v3, :cond_6

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v4

    if-eq v4, v7, :cond_9

    if-eq v4, v8, :cond_9

    .line 1046
    :cond_6
    if-nez v0, :cond_7

    .line 1047
    new-instance v0, Ljava/lang/StringBuffer;

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v3

    invoke-direct {v0, v3}, Ljava/lang/StringBuffer;-><init>(I)V

    .line 1048
    :cond_7
    if-eqz v2, :cond_8

    .line 1049
    invoke-virtual {p0, v6, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 1050
    invoke-virtual {v0, v7}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 1052
    :cond_8
    invoke-virtual {p0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p0

    goto :goto_1

    .line 1045
    :cond_9
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 1056
    :cond_a
    if-nez v0, :cond_b

    .line 1057
    new-instance v0, Ljava/lang/StringBuffer;

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    invoke-direct {v0, v2}, Ljava/lang/StringBuffer;-><init>(I)V

    .line 1058
    :cond_b
    invoke-virtual {p0, v6, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 1059
    invoke-virtual {p0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p0

    goto/16 :goto_1

    .line 1063
    :cond_c
    if-nez v0, :cond_d

    .line 1064
    new-instance v0, Ljava/lang/StringBuffer;

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v3

    invoke-direct {v0, v3}, Ljava/lang/StringBuffer;-><init>(I)V

    .line 1065
    :cond_d
    add-int/lit8 v3, v2, -0x1

    invoke-virtual {p0, v6, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 1066
    invoke-virtual {p0, v2, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 1067
    invoke-virtual {p0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p0

    goto/16 :goto_1
.end method
