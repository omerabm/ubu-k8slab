echo "Preparing system for node specific changes"
chmod +x 2.prep_k8s_master.sh
chmod +x 2.prep_k8s_workers.sh
./2.prep_k8s_master.sh
./2.prep_k8s_workers.sh
echo "Applied changes"
echo "Consider rebooting all nodes"
sleep 30
