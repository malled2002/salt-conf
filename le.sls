le:
  user.present:
    - fullname: le
    - shell: /usr/bin/false
    - home: /var/le

/var/le/generate:
  file.managed:
    - source: salt://le/generate
    - user: le
    - group: wheel
    - mode: 744

/var/le/regenerate-all:
  file.managed:
    - source: salt://le/regenerate-all
    - user: le
    - group: wheel
    - mode: 744

/var/le/intermediate.pem:
  file.managed:
    - source: salt://le/intermediate.pem
    - user: le
    - group: wheel
    - mode: 644

acme-tiny:
  git.latest:
    - name: https://github.com/diafygi/acme-tiny
    - rev: master
    - user: le
    - target: /var/le/acme-tiny
    - force_clone: true

/var/www/htdocs/acme/.well-known/acme-challenge:
  file.directory:
    - user: le
    - group: wheel
    - mode: 755
    - makedirs: True
