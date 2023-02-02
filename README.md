# terraform-vsphere

Examples of VM generations with Terraform ans vsphere provider.
I use Ansible to install software and configure VM. 

# dns-server
- 1 VM for DNS server

# proxy-server
- 1 VM for proxy server

# etcd-vm
Create VM for ETCD cluster with
- 5 VM for ETCD nodes
- 2 VM for load-balancer front of the cluster with HA

# k8s-vm
Create VM for Kubernetes cluster with
- 5 VM for controlplanes nodes
- 5 VM for workers nodes
- 2 VM for API load-balancer with HA

