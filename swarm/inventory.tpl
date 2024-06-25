all:
  hosts:
    manager:
      ansible_host: ${manager_ip}
      ansible_user: admin
      ansible_ssh_private_key_file: ./myKey.pem
      ansible_ssh_common_args: '-o StrictHostKeyChecking=no'
  children:
    workers:
      hosts:
%{ for ip in worker_ips }
        worker_${ip}:
          ansible_host: ${ip}
          ansible_user: admin
          ansible_ssh_private_key_file: ./myKey.pem
          ansible_ssh_common_args: '-o StrictHostKeyChecking=no'
%{ endfor }
