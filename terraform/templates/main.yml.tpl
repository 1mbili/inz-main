---
- name: "Set up Content delivery network"
  hosts: cdn
  become: true
  roles:
    - my_cdn
    - prometheus.prometheus.node_exporter

- name: "Install and configure my_web app"
  hosts: web
  become: true
  roles:
   - my_web
   - prometheus.prometheus.node_exporter

- name: "Set up load balancer"
  hosts: lb
  become: true
  roles:
   - my-lb
   - prometheus.prometheus.node_exporter

- name: Setup prometheus
  hosts: monitoring
  become: true
  roles:
    - my_monitoring
    - prometheus.prometheus.node_exporter
    - prometheus.prometheus.prometheus
  vars:
    prometheus_targets:
      node:
        - targets:
            %{ for ip in web-vms ~}
- "{{ hostvars['${ip.name}']['ansible_host'] }}:9100"
%{ endfor ~}
          labels:
            env: web
        - targets:
            %{ for ip in monitoring-vms ~}
- "{{ hostvars['${ip.name}']['ansible_host'] }}:9100"
%{ endfor ~}
          labels:
            env: monitoring
        - targets:
            %{ for ip in lb-vms ~}
- "{{ hostvars['${ip.name}']['ansible_host'] }}:9100"
            - "{{ hostvars['${ip.name}']['ansible_host'] }}:9113"
%{ endfor ~}          
          labels:
            env: loadbalancer
