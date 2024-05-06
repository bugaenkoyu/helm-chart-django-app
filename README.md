## Installation VPC 
## Creating k8s cluster
## Creating PostgreSQL

## Create Certificate
## Installation and configuration AWS Load Balancer Controller
### Setup IAM for ServiceAccount
1. Create IAM OIDC provider
```
eksctl utils associate-iam-oidc-provider \
    --region <aws-region> \
    --cluster <your-cluster-name> \
    --approve
```
2. Download IAM policy for the AWS Load Balancer Controller
```
curl -o iam-policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json
```
3. Create an IAM policy called AWSLoadBalancerControllerIAMPolicy
```
aws iam create-policy \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam-policy.json
```
Take note of the policy ARN that is returned
4. Create a IAM role and ServiceAccount for the Load Balancer controller, use the ARN from the step above
```
eksctl create iamserviceaccount \
--cluster=<cluster-name> \
--namespace=kube-system \
--name=aws-load-balancer-controller \
--attach-policy-arn=arn:aws:iam::<AWS_ACCOUNT_ID>:policy/AWSLoadBalancerControllerIAMPolicy \
--approve \
--region eu-central-1
```
### Installing the Chart
1. Add the EKS repository to Helm:
```
helm repo add eks https://aws.github.io/eks-charts
```
2. Install the AWS Load Balancer controller
```
helm install \
  aws-load-balancer-controller \
  eks/aws-load-balancer-controller \
  --set clusterName=<cluster-name> -n kube-system \
  --set serviceAccount.create=false --set 

```

### Deploying django-app Helm Chart
## Configuration domain name records
## Checking the success of the execution