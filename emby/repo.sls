{% set baseurl = 'http://download.opensuse.org/repositories/home:/emby/' + salt['grains.get']('os') + '_$releasever/' %}
{% set gpgkey = baseurl + 'repodata/repomd.xml.key' %}

emby-repo:
  pkgrepo.managed:
    - name: emby
    - humanname: "emby's Home Project"
    - type: rpm-md
    - baseurl: {{ baseurl }}
    - gpgcheck: 1
    - gpgkey: {{ gpgkey }}

emby-repo-key:
  cmd.run:
    - name:  rpm --import {{ gpgkey }}
    - unless: rpm -qi gpg-pubkey-2a7d8a28
