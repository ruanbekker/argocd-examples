# Terraform Deployment

## Usage

Deploy the cluster and ArgoCD Helm Release:

```bash
terraform init
terraform apply -auto-approve
```

Get the password:

```bash
export  KUBECONFIG=/tmp/kube.config
kubectl get secrets -n argocd argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d ; echo
```

Port Forward (port 8080):

```bash
kubectl port-forward svc/argocd-server -n argocd  --address=0.0.0.0 8080:80
```

## Cleanup

Destroy

```bash
terraform destroy -auto-approve
```


