#!/bin/bash -x

echo "This script is written to work with Ubuntu 18.04"
sleep 3
echo
echo "Disable swap until next reboot"
echo
sudo swapoff -a

echo "Update the local node"
sudo apt-get update && sudo apt-get upgrade -y
echo
echo "Install Containerd"
sleep 3

sudo apt-get install -y containerd.io
echo
echo "Install kubeadm and kubectl"
sleep 3

sudo sh -c "echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' >> /etc/apt/sources.list.d/kubernetes.list"

sudo sh -c "curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -"

sudo modprobe br_netfilter

sudo sysctl net.ipv4.ip_forward=1

sudo apt-get update

sudo apt-get install -y kubeadm kubelet kubectl

echo "kubeadm installed! use kubeadm join to join the node"