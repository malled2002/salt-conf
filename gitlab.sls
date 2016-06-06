app-pkgs:
  pkg.installed:
    - names:
      - git
      - ruby

nsupdate:
  user.present:
    - fullname: nsupdate
    - shell: /bin/zsh
    - home: /home/nsupdate
    - uid: 4000
    - gid: www
    - groups:
      - www

webapp:
  git.latest:
    - name: https://github.com/nsupdate-info/nsupdate.info
    - rev: master
    - target: /home/nsupdate/venv/nsupdate
    - force: true
    - require:
      - pkg: app-pkgs

mysite-env:
  virtualenv.managed:
    - name: /home/nsupdate/venv
    - cwd: /home/nsupdate/venv/nsupdate
    - user: nsupdate
    - no_site_packages: True
    - no_chown: True
    - requirements: /home/nsupdate/venv/nsupdate/requirements.d/prod.txt

  file.managed:
    - name: /etc/uwsgi-emperor/vassals/nsupdate.ini
    - source: salt://nsupdate/nsupdate.ini
    - user: nsupdate
    - group: www
      
