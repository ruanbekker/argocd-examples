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

Or if you need a kubernetes cluster, gitea and argocd on a kind cluster you can check out: `_scripts/bootstrap.sh`

## Examples

- [helm-files-inside-applications](#helm-values-inside-application)
- [helm-values-from-file](#helm-values-from-file)
- [git-and-list-generators](#git-and-list-generators)
  - [multiple-tags](#multiple-tags)
- [matrix-generators](#matrix-generators)
  - [multiple-environment-value-files](#multiple-environment-value-files)

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

### git-and-list-generators

#### multiple-tags

<code style="color : aqua">Jump</code> to directory: [./git-and-list-generators/](./git-and-list-generators/)

The application is defined in `git-and-list-generators/multiple-git-tags-application.yaml` and listens for applications in `apps/` and does the following:

For staging:
- If the commit tag is `staging` it will append a `staging-` prefix to the name and deploy to the `staging` namespace in the `kind-staging` cluster.

For production:
- If the commit tag is `production` it will append a `prod-` prefix to the name and deploy to the `prod` namespace in the `kind-prod` cluster.


### matrix-generators

#### multiple-environment-value-files

<code style="color : aqua">Jump</code> to directory: [./matrix-generators/](./matrix-generators/)

The ApplicationSet is defined in `git-and-list-generators/multiple-envs-applications.yaml` and listens for applications under the `apps/` directory in the git repository. It uses a `git generator` to discover application directories and a `matrix generator` to combine the application paths with environment-specific configurations (dev, staging, production). 

For each environment (dev, staging, production), it deploys the corresponding environment-specific values.yaml file using Helm. The deployments are targeted to the appropriate Kubernetes namespaces (dev, staging, production), and the ApplicationSet automatically handles synchronization, pruning, and namespace creation.


