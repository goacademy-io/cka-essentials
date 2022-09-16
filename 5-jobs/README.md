Create a job to print date

```bash
kubectl create job bb --image=busybox -- date
```

Create a job to print hello 5 times 

```bash

```

Create a cron job to print hello 5 times 

```bash 

```
Create a job from a corn job 

```bash
kubectl create job bb --from=cronjob/a-cronjob
```