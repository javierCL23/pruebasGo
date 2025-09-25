#!/bin/bash

# Disable swap to avoid errors in kubeadm (although without configuring swap this problem shouldn't occur in vm)
sudo swapoff -a
sudo sed -i.bak '/ swap / s/^\(.*\)$/#\1/' /etc/fstab


echo "
--------------------
      SWAP OFF
--------------------
"

# Install basic dependencies (although in the default image only apt-transport-https would be installed)
sudo apt-get update && sudo apt-get install -y apt-transport-https ca-certificates curl gpg

# Install containerd
sudo apt install -y containerd

sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml
        # Change SystemdCgroup to true
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml

sudo systemctl restart containerd
sudo systemctl enable containerd

echo "
--------------------
Containerd Installed
--------------------
"

# Install kubeadm, kubelet, kubectl
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

sudo systemctl enable --now kubelet
sudo systemctl restart kubelet


echo "
--------------------
Kubethings installed
--------------------
"
