
1.1 Create a new cluster with Workload Identity enabled
```
gcloud container clusters create CLUSTER_NAME \
    --workload-pool=PROJECT_ID.svc.id.goog
```
1.2 Enable Workload Identity on an existing cluster
```
gcloud container clusters update CLUSTER_NAME --workload-pool=PROJECT_ID.svc.id.goog --region us-west1

```

2.1. Node pool creation with Workload Identity
```
gcloud container node-pools create NODEPOOL_NAME \
    --cluster=CLUSTER_NAME \
    --workload-metadata=GKE_METADATA
```
2.2. Modification existing Node pool 
```
gcloud container node-pools update NODEPOOL_NAME \
    --cluster=CLUSTER_NAME \
    --workload-metadata=GKE_METADATA --region us-west1
```

3. Create Google service account : GSA_NAME@PROJECT_ID.iam.gserviceaccount.com

4. Create K8s Service account
```
apiVersion: v1
kind: ServiceAccount
metadata:
  annotations:
    iam.gke.io/gcp-service-account: GSA_NAME@PROJECT_ID.iam.gserviceaccount.com
  name: rao-ksa
  namespace: rao-test
```

5. Bind KSA with GSA, k8s namespace
```
gcloud iam service-accounts add-iam-policy-binding \
    --role roles/iam.workloadIdentityUser \
    --member "serviceAccount:PROJECT_ID.svc.id.goog[K8S_NAMESPACE/KSA_NAME]" \
    GSA_NAME@PROJECT_ID.iam.gserviceaccount.com
```
NOTE: You can also do binding with YAML file.

```
apiVersion: iam.cnrm.cloud.google.com/v1beta1
kind: IAMPolicy
metadata:
  name: iampolicy-workload-identity-sample
spec:
  resourceRef:
    apiVersion: iam.cnrm.cloud.google.com/v1beta1
    kind: IAMServiceAccount
    name: GSA_NAME@PROJECT_ID.iam.gserviceaccount.com
  bindings:
    - role: roles/iam.workloadIdentityUser
      members:
        - serviceAccount:PROJECT_ID.svc.id.goog[K8S_NAMESPACE/KSA_NAME]
```
You need to be able to “Config Connector” on the k8s cluster with the below command.

```
gcloud container clusters update CLUSTER_NAME \
    --update-addons ConfigConnector=ENABLED
```

6. optional
```
kubectl annotate serviceaccount \
    --namespace K8S_NAMESPACE KSA_NAME \
    iam.gke.io/gcp-service-account=GSA_NAME@PROJECT_ID.iam.gserviceaccount.com
```
7. Create deployment and do changes as per your need

```
apiVersion: apps/v1
kind: Deployment
metadata:
 name: example-gke-workload-identity
 namespace: rao-test
spec:
 replicas: 2
 selector:
   matchLabels:
     app: hello
 template:
   metadata:
     labels:
       app: hello
   spec:
     serviceAccountName: rao-ksa     ##update with your k8s service account name
     containers:
     - name: work-load-identity
       image: gauravsonu1991/apache
         - name: BUCKET_NAME
           value: gke-workload-identity-your-bucket-name
```

