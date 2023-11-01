[all:children]
web
lb
monitoring

[all:vars]
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
ansible_port=22
ansible_user='root'
ansible_ssh_private_key_file="~/.ssh/id_rsa"

[web]
%{ for ip in web-vms ~}
${ip.name} ansible_host=${ip.ipv4_address}
%{ endfor ~}

[lb]
%{ for ip in lb-vms ~}
${ip.name} ansible_host=${ip.ipv4_address}
%{ endfor ~}

[monitoring]
%{ for ip in monitoring-vms ~}
${ip.name} ansible_host=${ip.ipv4_address}
%{ endfor ~}