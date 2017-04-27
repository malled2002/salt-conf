app-pkgs-nsupdate:
  pkg.installed:
    - names:
      - git

nsupdate:
  user.present:
    - fullname: nsupdate
    - shell: /usr/bin/false
    - home: /home/nsupdate
    - uid: 4000
    - gid: www
    - groups:
      - www

webapp:
  git.latest:
    - name: https://github.com/nsupdate-info/nsupdate.info
    - rev: master
    - user: nsupdate
    - target: /home/nsupdate/nsupdate.info
    - force_clone: true
    - require:
      - pkg: app-pkgs-nsupdate

mysite-env:
  pip.installed:
    - name: 
      - django >= 1.6, <= 1.7
      - social-auth-app-django
    - requirements: /home/nsupdate/nsupdate.info/requirements.d/prod.txt

  file.managed:
    - name: /etc/uwsgi-emperor/vassals/nsupdate.ini
    - source: salt://nsupdate/nsupdate.ini
    - user: nsupdate
    - group: www
      
/home/nsupdate/nsupdate.info/nsupdate.sqlite:
  file.managed:
    - source: salt://nsupdate/nsupdate.sqlite
    - user: nsupdate
    - group: www

/home/nsupdate/nsupdate.info/local_settings.py:
  file.managed:
    - source: salt://nsupdate/local_settings.py
    - user: nsupdate
    - group: www

nsupdate_migrate:
  cmd.run:
    - name: python manage.py migrate
    - runas: nsupdate
    - cwd: /home/nsupdate/nsupdate.info/
    - env:
      - DJANGO_SETTINGS_MODULE: local_settings

