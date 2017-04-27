dovecot:
  pkg.installed: []

dkim-milter:
  pkg.installed: []

dkimproxy:
  pkg.installed: []

opensmtpd-extras:
  pkg.installed: []

p5-Mail-SpamAssassin:
  pkg.installed: []

spampd:
  pkg.installed: []

/etc/mail/smtpd.conf:
  file.managed:
    - source: salt://smtpd/smtpd.conf
    - user: root
    - group: wheel
    - mode: 644

/etc/mail/sqlite.conf:
  file.managed:
    - source: salt://smtpd/sqlite.conf
    - user: root
    - group: wheel
    - mode: 644

/etc/mail/smtpd.sqlite:
  file.managed:
    - source: salt://smtpd/smtpd.sqlite
    - user: root
    - group: wheel
    - mode: 644

/etc/dovecot/conf.d/auth-sql.conf.ext:
  file.managed:
    - source: salt://smtpd/auth-sql.conf.ext
    - user: root
    - group: wheel
    - mode: 644

/etc/dovecot/dovecot-sql.conf.ext:
  file.managed:
    - source: salt://smtpd/dovecot-sql.conf.ext
    - user: root
    - group: wheel
    - mode: 644

include_ext_auth:
  file.append:
    - name: /etc/dovecot/conf.d/10-auth.conf
    - text:
      - "!include auth-sql.conf.ext"

dovecot_cert:
  file.line:
    - name: /etc/dovecot/conf.d/10-ssl.conf
    - match: "ssl_cert = </etc/ssl/dovecotcert.pem"
    - content: "ssl_cert = </var/le/domains/mail.malled.de/latest/cert.pem"
    - mode: replace

dovecot_cert_key:
  file.line:
    - name: /etc/dovecot/conf.d/10-ssl.conf
    - match: "ssl_key = </etc/ssl/private/dovecot.pem"
    - content: "ssl_key = </var/le/domains/mail.malled.de/latest/serverkey.pem"
    - mode: replace

dovecot_rc:
  file.append:
    - name: /etc/rc.conf.local
    - text:
      - dovecot_flags=""

spamd_rc:
  file.append:
    - name: /etc/rc.conf.local
    - text:
      - spamd_flags="-v"

/etc/login.conf:
  file.append:
    - ignore_whitespace: false
    - text: |
       dovecot:\
                :openfiles-cur=512:\
                :openfiles-max=2048:\
                :tc=daemon:


vmail:
  user.present:
    - fullname: vmail
    - shell: /usr/bin/false
    - home: /var/vmail
    - uid: 5000
    - gid_from_name: true


spamassasin_header_rewrite:
  file.uncomment:
    - name: /etc/mail/spamassassin/local.cf
    - regex: rewrite_header

spamassasin_rc:
  file.append:
    - name: /etc/rc.conf.local
    - text:
      - spampd_flags="--tagall -aw"
