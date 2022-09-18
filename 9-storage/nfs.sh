sudo apt-get update && sudo apt-get install -y nfs-kernel-server
sudo mkdir /opt/sfw
sudo chmod 1777 /opt/sfw/
sudo bash -c "echo software > /opt/sfw/hello.txt"
sudo bash -c "echo '/opt/sfw/ *(rw,sync,no_root_squash,subtree_check)' >> /etc/exports"
sudo exportfs -ra
echo
echo "Should be ready. Test here and second node"
echo
sudo showmount -e localhost