{% from "emby/map.jinja" import emby with context %}

include:
  - .repo
{% if salt['grains.get']('os')|lower == 'centos' %}
  - epel
{% endif %}

emby-server:
  pkg.installed:
    - name: {{ emby.lookup }}
    - require:
      - pkgrepo: emby

  service.running:
    - name: emby-server
    - enable: True
    - require:
      - pkg: emby-server
