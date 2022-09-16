### check pods with high cpu utilization and save to file

```bash
kubectl top nodes
```

### Drain a node

evict all pods from node,
```bash
kubectl drain node
```

### Prevent scheduling on new pod on a node

marks as unschedulable,
```bash
kubectl cordon node <nodename>
```

### Create static pods

```bash

```