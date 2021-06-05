hs=`hostname`
curr_ip=$(ifconfig ens32 | grep netmask | cut -d' ' -f10)
if [ $hs = 'master' ]
 then
    echo "Current node is mater ...  Will not performing worker node-specific actions"
    echo " Exiting !!!!"
    exit
else
    echo "Current node is worker ... Performing worker node-specific actions"
    kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
    scp root@master:/root/kubeadm_join_cmd.sh .
    chmod +x kubeadm_join_cmd.sh
    ./kubeadm_join_cmd.sh
    sleep 10
 else
    echo "Node not master ... skipping further actions"
fi
