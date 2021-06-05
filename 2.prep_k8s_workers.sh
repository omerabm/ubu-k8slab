### Preparing Worker nodes ####
#hs=`hostname`
#if [ $hs = 'master' ]
# then
#    echo "Current node is master ...  Will not be performing worker node-specific actions"
#    echo " Exiting !!!!"
#    exit
# else
    echo "Current node is worker ... Performing worker node-specific actions"
    kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
    curl -s http://worker1/authorized_keys > /root/.ssh/authorized_keys
 #   curl -s http://master/authorized_keys > /root/.ssh/authorized_keys
 #   scp root@master:/root/kubeadm_join_cmd.sh .
    scp -o "StrictHostKeyChecking no" root@worker1:/root/kubeadm_join_cmd.sh .
    chmod +x kubeadm_join_cmd.sh
    ./kubeadm_join_cmd.sh
    sleep 10
#fi
