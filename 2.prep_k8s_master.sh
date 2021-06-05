hs=`hostname`
curr_ip=$(ifconfig ens32 | grep netmask | cut -d' ' -f10)
#if [ $hs = 'master' ]
# then
    echo "Current node is master ... Performing master node-specific actions"
    kubeadm init --apiserver-advertise-address=$cur_ip --pod-network-cidr=10.244.0.0/16 > ./kubeadm_init.log
    mkdir -p $HOME/.kube
    cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    chown $(id -u):$(id -g) $HOME/.kube/config
    kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
    echo " .......................... Applied Master node changes ...................................."
    echo " -------------------------- Getting Cluster status -----------------------------------------"
    sleep 10
    kubectl get pods --all-namespaces
    cat kubeadm_init.log | grep -A1 kubeadm | grep 'join\|discovery' > ./kubeadm_join_cmd.sh
    chmod +x ./kubeadm_join_cmd.sh
    
    #### ssh keygen and lighttpd install 
    
    ssh-keygen -f /root/.ssh/id_rsa -P ''
    apt-get install lighttpd -y
    service lighttpd start
    cat /root/.ssh/id_rsa.pub > /root/.ssh/authorized_keys
    cp /root/.ssh/authorized_keys /var/www/html/authorized_keys
    chmod -Rf 777 /var/www/html/
    ###################################
    curl -s http://master/authorized_keys > /root/.ssh/authorized_keys
# else
#    echo "Node not master ... skipping further actions"
#fi
