## Installation VPC 
To install VPC, I used the CloudFormation file (CloudFormation-VPC.yaml - which is attached in the infra folder). There I create all the necessary resources for my future cluster, such as VPC, public, private and db subnets, Internet Gateway, NAT Gateways, ElasticIP for NAT Gateways and all Route Tables. 
You can start the execution both from AWS Cloudformation and from the CLI by running the command:
```
aws cloudformation create-stack \
  --stack-name <stack-name> \
  --template-body file://<path/to/file> \
  --region <you_region>
```
## Creating k8s cluster
To create a cluster subnet, I used the ClusterConfig file, in which I specified private and public subnets for resources that will be created in the future in the cluster. He also specified the number of nodes and the region and type of instances.
To create a Cluster, use the command:
```
eksctl create cluster -f eks-cluster.yml 
```
## Creating PostgreSQL
The Django app requires a postgresql database for correct operation. I used terraform to create it. In the template, you only need to specify your subnets, vpc and k8s security group. 
To create a PostgreSQL, use the command:
```
terraform init
terraform apply
```

## Create Certificate
To create a certificate in AWS, I used AWS Certificate Manager (ACM). I created a request and then used CNAME to confirm the ownership of the domain.
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
To launch the Helm chart, go to the helmfile folder and run the following command:
```
helmfile apply
```
## Configuration domain name records
After the load balancer is automatically created for our application, you should add its dns to the domain name settings.
To do this, I go to route 53 and create a new A record where in the Alias section I add the dns of the load balancer.
## Checking the success of the execution
After the record was successfully applied, I went to the browser and saw that my domain was successfully working with an ssl certificate.
![SSL django](./img/ssl-django-app.png)
The connection is secure and certificate is valid.
![Secure](./img/secure.png)