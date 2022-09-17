## Deployments

### Create nginx deployment 

```bash
kubectl create deploy nginx --image=nginx --dry-run=client -o yaml > ng.yaml
kubectl apply -f ng.yaml
```

### Upgrade nginx deployment 

```bash
kubectl set image deploy/ng nginx=nginx:1.161
kubectl set image deploy/ng nginx=nginx:1.162 
```

### Rollout nginx deployment

```bash
kubectl rollout history deploy/ng
kubectl rollout history deploy/ng --revision=2
```

## Scaling Deployment

### Scale

```bash
kubectl scale deploy/ng --replicas=10
kubectl get rs
```

### HPA 

enable hpa on your cluster 
```bash
kubectl rollout history deploy/ng --min=10 --max=15 --cpu-percent=80
```


