### Create logging sidecar to aggregate nginx logs to a mount point

create nginx deployment 

```bash
kubectl create deploy ng --image=nginx --dry-run=client -o yaml > ng.yaml
```

edit ng.yaml and add volumeMount, let volume be hostPath to some location, take ref for "volumes" 
from official doc
add another container busybox, with command,

```bash
command: ["sh", "-c", "tail -n+1 -f /var/log/nginx/access.log"]
```
full example, 

```bash

```

### Fluentd Example

copy the example from official doc, 

create a cm, 

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: fluentd-config
data:
  fluentd.conf: |
    <source>
      type tail
      format none
      path /var/log/1.log
      pos_file /var/log/1.log.pos
      tag count.format1
    </source>

    <match **>
      type google_cloud
    </match>   
```

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: counter
spec:
  containers:
  - name: count
    image: busybox:1.28
    args:
    - /bin/sh
    - -c
    - >
      while true;
      do
        echo "$(date)" >> /var/log/1.log;
        sleep 1;
      done      
    volumeMounts:
    - name: varlog
      mountPath: /var/log
  - name: count-agent
    image: registry.k8s.io/fluentd-gcp:1.30
    env:
    - name: FLUENTD_ARGS
      value: -c /etc/fluentd-config/fluentd.conf
    volumeMounts:
    - name: varlog
      mountPath: /var/log
    - name: config-volume
      mountPath: /etc/fluentd-config
  volumes:
  - name: varlog
    emptyDir: {}
  - name: config-volume
    configMap:
      name: fluentd-config
```

### Fluentd to write to aws s3

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: fluentd-config
data:
  fluentd.conf: |
    <match pattern>
      @type s3
    
      aws_key_id YOUR_AWS_KEY_ID
      aws_sec_key YOUR_AWS_SECRET_KEY
      s3_bucket YOUR_S3_BUCKET_NAME
      s3_region ap-northeast-1
      path logs/
      # if you want to use ${tag} or %Y/%m/%d/ like syntax in path / s3_object_key_format,
      # need to specify tag for ${tag} and time for %Y/%m/%d in <buffer> argument.
      <buffer tag,time>
        @type file
        path /var/log/fluent/s3
        timekey 3600 # 1 hour partition
        timekey_wait 10m
        timekey_use_utc true # use utc
        chunk_limit_size 256m
      </buffer>
    </match>  
```
Create fluentd logging sidecar, 

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: counter
spec:
  containers:
  - name: count
    image: busybox:1.28
    args:
    - /bin/sh
    - -c
    - >
      while true;
      do
        echo "$(date)" >> /var/log/1.log;
        sleep 1;
      done      
    volumeMounts:
    - name: varlog
      mountPath: /var/log
  - name: count-agent
    image: registry.k8s.io/fluentd-gcp:1.30
    env:
    - name: FLUENTD_ARGS
      value: -c /etc/fluentd-config/fluentd.conf
    volumeMounts:
    - name: varlog
      mountPath: /var/log
    - name: config-volume
      mountPath: /etc/fluentd-config
  volumes:
  - name: varlog
    emptyDir: {}
  - name: config-volume
    configMap:
      name: fluentd-config
```