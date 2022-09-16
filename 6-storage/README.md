### Storage Class 

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: local
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
```

```bash
kubectl apply -f sc.yaml
```

### Create a PV 

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: mypv
  labels:
    type: local
spec:
  storageClassName: local
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/data"
```

```bash
kubectl create pf pv.yaml
```

### Create a PVC

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mypvc
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 3Gi
```

### Create pod to use PVC

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: ng
spec:
  volumes:
    - name: mypv
      persistentVolumeClaim:
        claimName: mypvc
  containers:
    - name: ng
      image: nginx
      ports:
        - containerPort: 80
          name: "http-server"
      volumeMounts:
        - mountPath: "/usr/share/nginx/html"
          name: mypv
```

```bash
kubectl create -f pvc.yaml
```