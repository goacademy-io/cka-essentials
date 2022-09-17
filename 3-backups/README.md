
certs are located at /etc/kubernetes/pki

### Etcd backup

```bash
ETCDCTL_API=3 etcdctl --endpoints=https://[127.0.0.1]:2379 --cacert=/opt/ca.crt --cert=/opt/etcd-client.crt --key=/opt/etcd-client.key snapshot save /srv/data/etcd-snapshot.db
```

### Etcd restore
```bash
ETCDCTL_API=3 etcdctl --endpoints=https://[127.0.0.1]:2379 --cacert=/opt/ca.crt --cert=/opt/KUIN00601/etcd-client.crt --key=/opt/etcd-client.key snapshot restore /srv/data/etcd-snapshot-previous.db
```




