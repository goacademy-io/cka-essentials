## Job

### Create a job to print hello 5 times

copy sample from official doc & edit like this, 
```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: bb
spec:
  template:
    spec:
      containers:
      - name: bb
        image: busybox
        command: ["sh",  "-c", 'for i in $(seq 1 5); do echo hello; done']
      restartPolicy: Never
  backoffLimit: 4
```

### Create a job with infinite loop but with activeDeadlineSeconds 10

```bash
apiVersion: batch/v1
kind: Job
metadata:
  name: bb
spec:
  activeDeadLineSeconds: 10
  template:
    spec:
      containers:
      - name: bb
        image: busybox
        command: ["sh",  "-c", 'while true; do echo hello; done']
      restartPolicy: Never
  backoffLimit: 4
```

### Create a job with parallel execution & completion

```bash
apiVersion: batch/v1
kind: Job
metadata:
  name: bb
spec:
  completion: 10
  parallelism: 3
  template:
    spec:
      containers:
      - name: bb
        image: busybox
        command: ["sh",  "-c", 'for i in $(seq 1 5); do echo hello; done']
      restartPolicy: Never
  backoffLimit: 4
```

## CronJob

### Create a cron job that runs every 10 seconds 

Take example from official doc, 
```bash 

```

no create a job from a corn job 

```bash
kubectl create job bb --from=cronjob/a-cronjob
```