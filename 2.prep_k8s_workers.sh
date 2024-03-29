### Preparing Worker nodes ####
#hs=`hostname`
#if [ $hs = 'master' ]
# then
#    echo "Current node is master ...  Will not be performing worker node-specific actions"
#    echo " Exiting !!!!"
#    exit
# else
     echo "Current node is worker ... Performing worker node-specific actions"
 #   kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
     curl -s http://master/authorized_keys > /root/.ssh/authorized_keys
 #   scp -o "StrictHostKeyChecking no" root@worker1:/root/kubeadm_join_cmd.sh .
echo "Will now start to join worker nodes to the master"
echo "Waiting to receive the kubeadm join script from master node"
if [ -s kubeadm_join_cmd.sh ]
 then
    echo "Received the kubeadm join script from master node"
    echo "============================================"
    cat kubeadm_join_cmd.sh
    echo "============================================"
 else
    curl -s http://master/kubeadm_join_cmd.sh > /root/ubu-k8slab/kubeadm_join_cmd.sh
    while ! [ -s /root/ubu-k8slab/kubeadm_join_cmd.sh ]
      do
         curl -s http://master/kubeadm_join_cmd.sh > /root/ubu-k8slab/kubeadm_join_cmd.sh
         sleep 5
         echo "Waiting to receive the kubeadm join script from master"
      done
fi
chmod +x /root/ubu-k8slab/kubeadm_join_cmd.sh
./kubeadm_join_cmd.sh
sleep 10
