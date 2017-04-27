{% set current_path = salt['environ.get']('PATH', '/bin:/usr/bin') %}

app-pkgs:
  pkg.installed:
    - names:
      - go

git:
  user.present:
    - fullname: git
    - shell: /usr/bin/false
    - home: /home/git

/home/git/go:
    file.directory:
        - user: git
        - group: git
        - mode: 755
        - makedirs: True

gogs_get:
  cmd.run:
    - name: /usr/local/bin/go get -u -tags "sqlite" github.com/gogits/gogs
    - cwd: /home/git/
    - runas: git
    - env:
      - GOROOT: '/usr/local/go'
      - GOPATH: '/home/git/go/'
      - PATH: {{ [current_path, '/home/git/go/bin/']|join(':') }}

gogs_build:
  cmd.run:
    - name: /usr/local/bin/go build -tags "sqlite"
    - cwd: /home/git/go/src/github.com/gogits/gogs
    - runas: git
    - env:
      - GOROOT: '/usr/local/go'
      - GOPATH: '/home/git/go/'
      - PATH: {{ [current_path, '/home/git/go/bin/']|join(':') }}

