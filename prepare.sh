rm -rf ubu-k8slab
git clone https://github.com/omerabm/ubu-k8slab.git
cd ubu-k8slab
chmod +x first_boot_k8s.sh
./first_boot_k8s.sh
echo "Done .. initial setup"
reboot
