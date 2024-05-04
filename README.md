# argocd-examples
Argo CD Examples

## Argo CD

To follow along Argo CD needs to be installed.

> [!IMPORTANT]  
> The following can be used to install Argo CD to your cluster:
> ```bash
>kubectl create namespace argocd
>kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
>```

## Examples

- [helm-files-inside-applications](#helm-values-inside-application)
- [helm-values-from-file](#helm-values-from-file)

### helm-values-inside-application

<code style="color : aqua">Jump</code> to directory: [./helm-values-inside-application/](./helm-values-inside-application/)

The helm values are managed inside the `Application`:

```yaml
  source:
    chart: microservice
    repoURL: https://charts.ruan.dev
    targetRevision: 3.1.1
    helm:
      values: |
        replicaCount: 1
```

### helm-values-from-file

<code style="color : aqua">Jump</code> to directory: [./helm-values-from-file/](./helm-values-from-file/)

The application is defined in `helm-values-from-file/apps/app-dev.yaml` and the values are defined in `helm-values-from-file/values-dev.yaml` and argo will monitor this path on git:

```yaml
  source:
    path: helm-values-from-file
    repoUrl: https://github.com/ruanbekker/argocd-examples
    targetRevision: HEAD
    helm:
      valueFiles:
      - values-dev.yaml
```
