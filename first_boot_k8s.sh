cur_mac_addr=$(ifconfig ens32 | grep ether | cut -d' ' -f10)
cur_ip_addr=$(cat ip_mac.txt | grep $cur_mac_addr | cut -d',' -f2)
cur_host_name=$(cat ip_mac.txt | grep $cur_mac_addr | cut -d',' -f3)
cur_fqdn_name=$cur_host_name'.'$(cat ip_mac.txt | grep $cur_mac_addr | cut -d',' -f4)
sed -i "s/192.168.1.110/$cur_ip_addr/g" /etc/netplan/00-installer-config.yaml
hostnamectl set-hostname $cur_fqdn_name
sed -i "/$cur_ip_addr/d" /etc/hosts
sed -i "/$cur_host_name/d" /etc/hosts
sed -i "/$cur_fqdn_name/d" /etc/hosts
echo "$cur_ip_addr $cur_host_name $cur_fqdn_name" >> /etc/hosts
echo "Done with inital host config"
reboot
