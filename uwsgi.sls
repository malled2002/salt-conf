uwsgi2:
  pip.installed:
    - name: uwsgi

  file.directory:
    - name: /etc/uwsgi-emperor/vassals/ 
    - user: nsupdate
    - group: www
    - dir_mode: 755
    - file_mode: 644

test:
  file.managed:
    - name: /etc/uwsgi-emperor/emperor.ini
    - source: salt://uwsgi/emperor.ini
    - user: nsupdate
    - group: www
    - mode: 644
