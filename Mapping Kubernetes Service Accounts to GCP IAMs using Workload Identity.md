
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

6. optional
```
kubectl annotate serviceaccount \
    --namespace K8S_NAMESPACE KSA_NAME \
    iam.gke.io/gcp-service-account=GSA_NAME@PROJECT_ID.iam.gserviceaccount.com
```

