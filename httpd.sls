/etc/httpd.conf:
  file.managed:
    - source: salt://httpd/httpd.conf
    - user: root
    - group: wheel
    - mode: 644

httpd_rc:
  file.append:
    - name: /etc/rc.conf.local
    - text:
      - httpd_flags=""

