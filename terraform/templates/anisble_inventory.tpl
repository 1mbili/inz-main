[all:children]
web
lb
monitoring

[all:vars]
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
ansible_port=22
ansible_user='szef'
ansible_ssh_private_key_file="~/.ssh/id_rsa"

[web]
%{ for ip in web-vms ~}
${ip.name} ansible_host=${ip.public_ip_address} private_adress=${ip.private_ip_address}
%{ endfor ~}

[lb]
%{ for ip in lb-vms ~}
${ip.name} ansible_host=${ip.public_ip_address} private_adress=${ip.private_ip_address}
%{ endfor ~}

[monitoring]
%{ for ip in monitoring-vms ~}
<<<<<<< HEAD
${ip.name} ansible_host=${ip.public_ip_address} private_adress=${ip.private_ip_address}
=======
${ip.name} ansible_host=${ip.ipv4_address} private_adress=${ip.ipv4_address_private}
>>>>>>> main
%{ endfor ~}

[cdn]
%{ for ip in cdn-vms ~}
<<<<<<< HEAD
${ip.name} ansible_host=${ip.public_ip_address} private_adress=${ip.private_ip_address}
=======
${ip.name} ansible_host=${ip.ipv4_address} private_adress=${ip.ipv4_address_private}
>>>>>>> main
%{ endfor ~}
