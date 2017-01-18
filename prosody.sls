prosody:
  pkg.installed: []

prodody_rc:
  file.append:
    - name: /etc/rc.conf.local
    - text:
      - prosody_flags=""
