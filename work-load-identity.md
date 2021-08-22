
https://cloud.google.com/iam/docs/access-resources-aws#iam-workload-pools-create-python

iam role ==> IAM work load identity pool admin

origination policy
```
API:-
Identity and Access Management (IAM) API
Cloud Resource Manager API
IAM Service Account Credentials API
Security Token Service API
```

https://cloud.google.com/iam/docs/manage-workload-identity-pools-providers#restrict
origination policies :-
constraints/iam.workloadIdentityPoolProviders     ==>  https://sts.amazonaws.com

(optional) constraints/iam.workloadIdentityPoolAwsAccounts  ==>  AWS account number 
```
Step A:
gcloud resource-manager org-policies allow constraints/iam.workloadIdentityPoolProviders \
     https://sts.amazonaws.com --organization=ORGANIZATION_NUMBER
```
```
Step B:
gcloud resource-manager org-policies allow constraints/iam.workloadIdentityPoolAwsAccounts \
    AWS_ACCOUNT_ID --organization=ORGANIZATION_NUMBER
```
```
step 1 : create work load pool ID

gcloud iam workload-identity-pools create POOL_ID \
    --location="global" \
    --description="DESCRIPTION" \
    --display-name="DISPLAY_NAME"
```
```
step 2	: Add AWS as identity provider ID

gcloud iam workload-identity-pools providers create-aws PROVIDER_ID \
    --workload-identity-pool="POOL_ID" \
    --account-id="AWS_ACCOUNT_ID" \
    --display-name="GCP aws work load identity"  \
    --description="GCP aws work load identity"  \
    --location="global"
```
```
step 3 : impersonate a service account with work load identity and AWS role						 				
	gcloud iam service-accounts add-iam-policy-binding SERVICE_ACCOUNT_EMAIL \
	    --role=roles/iam.workloadIdentityUser \
	    --member="principalSet://iam.googleapis.com/projects/PROJECT_NUMBER/locations/global/workloadIdentityPools/POOL_ID/attribute.aws_role/arn:aws:sts::AWS_ACCOUNT_ID:assumed-role/AWS_ROLE_NAME"
```
```
Step 4: Generate Google credentials

gcloud iam workload-identity-pools create-cred-config \
    projects/PROJECT_NUMBER/locations/global/workloadIdentityPools/POOL_ID/providers/PROVIDER_ID \
    --service-account=SERVICE_ACCOUNT_EMAIL \
    --output-file=FILEPATH \
    --aws
```
```
Step 5: set 2 variable in aws account
	export GOOGLE_APPLICATION_CREDENTIALS  = "FILEPATH"
	export GOOGLE_CLOUD_PROJECT = "GCP_PROJECT_ID"
![image](https://user-images.githubusercontent.com/46133868/130357508-cad057b5-ff15-47d9-b12d-25e99eb917e5.png)
```
