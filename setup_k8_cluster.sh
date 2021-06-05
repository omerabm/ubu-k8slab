rm -rf ubu-k8slab
echo "Getting config files from Github"
git clone https://github.com/omerabm/ubu-k8slab.git
cd ubu-k8slab
chmod +x first_boot_k8s.sh
echo "Preparing system for first use assiging IP address, hostnames"
./first_boot_k8s.sh
echo "Done .. initial setup"
echo "Moving to node setup for K8s services"
