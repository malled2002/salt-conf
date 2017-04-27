/etc/sysctl.conf:
  file.managed:
    - source: salt://system/sysctl.conf
    - user: root
    - group: wheel
    - mode: 644

/etc/pf.conf:
  file.managed:
    - source: salt://system/pf.conf
    - user: root
    - group: wheel
    - mode: 644

/etc/rc.conf.local:
  file.managed:
    - user: root
    - group: wheel
    - mode: 644

zsh:
  pkg.installed: []

