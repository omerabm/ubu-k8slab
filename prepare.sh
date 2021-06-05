echo "Done .. initial setup"
echo "Moving to node setup for K8s services"
echo "Preparing system for node specific changes"
chmod +x 2.prep_k8s_master.sh
chmod +x 2.prep_k8s_workers.sh
hostname | grep -q "master" && 2.prep_k8s_master.sh || echo "No master... Will skip master specific changes"
hostname | grep -q "worker" && 2.prep_k8s_worker.sh || echo "Not worker .. Will skip worker specific changes"
echo "Applied changes"
echo "Consider rebooting all nodes"
sleep 30
