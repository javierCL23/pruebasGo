#!/bin/bash

USER=$(whoami)
sudo hostnamectl set-hostname CP


echo "
--------------------
CONFIGURING KUBEADM
--------------------
"

sudo sysctl -w net.ipv4.ip_forward=1

# Kube init + save output
OUTPUT=$(sudo kubeadm init)

#Get kubeconfig in place
mkdir -p /home/$USER/.kube
sudo cp -i /etc/kubernetes/admin.conf /home/$USER/.kube/config
sudo chown $USER:$USER /home/$USER/.kube/config

kubectl config view

echo "
--------------------
  CONFIGURING CNI
--------------------
"

#CNI
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.27.0/manifests/calico.yaml

# Extraer el comando join desde la salida
JOIN_COMMAND=$(echo "$OUTPUT" | grep -A 2 "kubeadm join")

# Guardarlo en un archivo accesible
echo "$JOIN_COMMAND" > /tmp/scripts/join_command.sh
chmod +x /tmp/scripts/join_command.sh

echo "
--------------------
   CP CONFIGURED
--------------------
"
