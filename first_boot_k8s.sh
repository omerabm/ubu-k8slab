cur_mac_addr=$(ifconfig ens32 | grep ether | cut -d' ' -f10)
cur_ip_addr=$(cat ip_mac.txt | grep $cur_mac_addr | cut -d',' -f2)
cur_host_name=$(cat ip_mac.txt | grep $cur_mac_addr | cut -d',' -f3)
cur_fqdn_name=$cur_host_name'.'$(cat ip_mac.txt | grep $cur_mac_addr | cut -d',' -f4)
sed -i "s/192.168.1.110/$cur_ip_addr/g" /etc/netplan/00-installer-config.yaml
ifconfig ens32 $cur_ip_addr
route add default gw 192.168.1.1
sleep 2
hostnamectl set-hostname $cur_fqdn_name
sed -i "/$cur_ip_addr/d" /etc/hosts
sed -i "/$cur_host_name/d" /etc/hosts
sed -i "/$cur_fqdn_name/d" /etc/hosts
### Create hosts file and update /etc/hosts
nodes_details=$(cat ip_mac.txt | grep -v "#")
for nodes_params in $nodes_details
do
  node_ip_addr=$(echo $nodes_params | cut -d',' -f2)
  node_host_name=$(echo $nodes_params | cut -d',' -f3)
  node_fqdn_name=$node_host_name'.'$(echo $nodes_params | cut -d',' -f4)
  echo "$node_ip_addr $node_host_name $node_fqdn_name" >> /etc/hosts
done
echo "Done with inital host config"
chmod +x prepare.sh
./prepare.sh
