.class public Lorg/apache/commons/mail/ImageHtmlEmail;
.super Lorg/apache/commons/mail/HtmlEmail;
.source "SourceFile"


# static fields
.field private static final IMG_PATTERN:Ljava/util/regex/Pattern;

.field public static final REGEX_IMG_SRC:Ljava/lang/String; = "(<[Ii][Mm][Gg]\\s*[^>]*?\\s+[Ss][Rr][Cc]\\s*=\\s*[\"\'])([^\"\']+?)([\"\'])"

.field public static final REGEX_SCRIPT_SRC:Ljava/lang/String; = "(<[Ss][Cc][Rr][Ii][Pp][Tt]\\s*.*?\\s+[Ss][Rr][Cc]\\s*=\\s*[\"\'])([^\"\']+?)([\"\'])"

.field private static final SCRIPT_PATTERN:Ljava/util/regex/Pattern;


# instance fields
.field private dataSourceResolver:Lorg/apache/commons/mail/DataSourceResolver;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 65
    const-string v0, "(<[Ii][Mm][Gg]\\s*[^>]*?\\s+[Ss][Rr][Cc]\\s*=\\s*[\"\'])([^\"\']+?)([\"\'])"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lorg/apache/commons/mail/ImageHtmlEmail;->IMG_PATTERN:Ljava/util/regex/Pattern;

    .line 68
    const-string v0, "(<[Ss][Cc][Rr][Ii][Pp][Tt]\\s*.*?\\s+[Ss][Rr][Cc]\\s*=\\s*[\"\'])([^\"\']+?)([\"\'])"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lorg/apache/commons/mail/ImageHtmlEmail;->SCRIPT_PATTERN:Ljava/util/regex/Pattern;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0}, Lorg/apache/commons/mail/HtmlEmail;-><init>()V

    return-void
.end method

.method private replacePattern(Ljava/lang/String;Ljava/util/regex/Pattern;)Ljava/lang/String;
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;,
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 129
    new-instance v3, Ljava/lang/StringBuffer;

    invoke-direct {v3}, Ljava/lang/StringBuffer;-><init>()V

    .line 132
    new-instance v4, Ljava/util/HashMap;

    invoke-direct {v4}, Ljava/util/HashMap;-><init>()V

    .line 135
    new-instance v5, Ljava/util/HashMap;

    invoke-direct {v5}, Ljava/util/HashMap;-><init>()V

    .line 139
    invoke-virtual {p2, p1}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v6

    .line 142
    :cond_0
    :goto_0
    invoke-virtual {v6}, Ljava/util/regex/Matcher;->find()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 145
    const/4 v0, 0x2

    invoke-virtual {v6, v0}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object v1

    .line 148
    invoke-interface {v5, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_2

    .line 151
    invoke-virtual {p0}, Lorg/apache/commons/mail/ImageHtmlEmail;->getDataSourceResolver()Lorg/apache/commons/mail/DataSourceResolver;

    move-result-object v0

    invoke-interface {v0, v1}, Lorg/apache/commons/mail/DataSourceResolver;->resolve(Ljava/lang/String;)Ljavax/activation/DataSource;

    move-result-object v0

    .line 153
    if-eqz v0, :cond_5

    .line 155
    invoke-interface {v5, v1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-object v2, v0

    .line 163
    :goto_1
    if-eqz v2, :cond_0

    .line 165
    invoke-interface {v2}, Ljavax/activation/DataSource;->getName()Ljava/lang/String;

    move-result-object v0

    .line 166
    invoke-static {v0}, Lorg/apache/commons/mail/EmailUtils;->isEmpty(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_4

    .line 171
    :goto_2
    invoke-interface {v4, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 173
    if-nez v0, :cond_1

    .line 175
    invoke-virtual {p0, v2, v1}, Lorg/apache/commons/mail/ImageHtmlEmail;->embed(Ljavax/activation/DataSource;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 176
    invoke-interface {v4, v1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 182
    :cond_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v2, 0x1

    invoke-virtual {v6, v2}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "cid:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/4 v1, 0x3

    invoke-virtual {v6, v1}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v6, v3, v0}, Ljava/util/regex/Matcher;->appendReplacement(Ljava/lang/StringBuffer;Ljava/lang/String;)Ljava/util/regex/Matcher;

    goto :goto_0

    .line 160
    :cond_2
    invoke-interface {v5, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljavax/activation/DataSource;

    move-object v2, v0

    goto :goto_1

    .line 188
    :cond_3
    invoke-virtual {v6, v3}, Ljava/util/regex/Matcher;->appendTail(Ljava/lang/StringBuffer;)Ljava/lang/StringBuffer;

    .line 190
    invoke-interface {v4}, Ljava/util/Map;->clear()V

    .line 191
    invoke-interface {v5}, Ljava/util/Map;->clear()V

    .line 193
    invoke-virtual {v3}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_4
    move-object v1, v0

    goto :goto_2

    :cond_5
    move-object v2, v0

    goto :goto_1
.end method


# virtual methods
.method public buildMimeMessage()V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 105
    :try_start_0
    iget-object v0, p0, Lorg/apache/commons/mail/HtmlEmail;->html:Ljava/lang/String;

    sget-object v1, Lorg/apache/commons/mail/ImageHtmlEmail;->IMG_PATTERN:Ljava/util/regex/Pattern;

    invoke-direct {p0, v0, v1}, Lorg/apache/commons/mail/ImageHtmlEmail;->replacePattern(Ljava/lang/String;Ljava/util/regex/Pattern;)Ljava/lang/String;

    move-result-object v0

    .line 106
    sget-object v1, Lorg/apache/commons/mail/ImageHtmlEmail;->SCRIPT_PATTERN:Ljava/util/regex/Pattern;

    invoke-direct {p0, v0, v1}, Lorg/apache/commons/mail/ImageHtmlEmail;->replacePattern(Ljava/lang/String;Ljava/util/regex/Pattern;)Ljava/lang/String;

    move-result-object v0

    .line 107
    invoke-virtual {p0, v0}, Lorg/apache/commons/mail/ImageHtmlEmail;->setHtmlMsg(Ljava/lang/String;)Lorg/apache/commons/mail/HtmlEmail;

    .line 108
    invoke-super {p0}, Lorg/apache/commons/mail/HtmlEmail;->buildMimeMessage()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 114
    return-void

    .line 110
    :catch_0
    move-exception v0

    .line 112
    new-instance v1, Lorg/apache/commons/mail/EmailException;

    const-string v2, "Building the MimeMessage failed"

    invoke-direct {v1, v2, v0}, Lorg/apache/commons/mail/EmailException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
.end method

.method public getDataSourceResolver()Lorg/apache/commons/mail/DataSourceResolver;
    .locals 1

    .prologue
    .line 80
    iget-object v0, p0, Lorg/apache/commons/mail/ImageHtmlEmail;->dataSourceResolver:Lorg/apache/commons/mail/DataSourceResolver;

    return-object v0
.end method

.method public setDataSourceResolver(Lorg/apache/commons/mail/DataSourceResolver;)V
    .locals 0

    .prologue
    .line 90
    iput-object p1, p0, Lorg/apache/commons/mail/ImageHtmlEmail;->dataSourceResolver:Lorg/apache/commons/mail/DataSourceResolver;

    .line 91
    return-void
.end method
