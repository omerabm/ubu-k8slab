rm -rf ubu-k8slab
echo "Preparing system for first use assiging IP address, hostname "
git clone https://github.com/omerabm/ubu-k8slab.git
cd ubu-k8slab
chmod +x first_boot_k8s.sh
./first_boot_k8s.sh
echo "Done .. initial setup"
#reboot
#New changes to prepare the master node
#
echo "Preparing system for node specific changes"
./2.prep_k8s_master.sh
