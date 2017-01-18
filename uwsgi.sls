uwsgi2:
  pip.installed:
    - name: uwsgi
    - require:
      - sls: system

/etc/uwsgi-emperor/vassals/:
  file.directory:
#    - name: /etc/uwsgi-emperor/vassals/ 
    - user: nsupdate
    - group: www
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - recurse:
      - user
      - group
      - mode

/etc/uwsgi-emperor/emperor.ini:
  file.managed:
#    - name: /etc/uwsgi-emperor/emperor.ini
    - source: salt://uwsgi/emperor.ini
    - user: nsupdate
    - group: www
    - mode: 644

/var/log/uwsgi/nsupdate.log:
  file.managed:
    - makedirs: True
    - user: nsupdate
    - group: www
    - mode: 644

