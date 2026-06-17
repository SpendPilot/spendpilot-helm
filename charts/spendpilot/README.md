# Spend Control Helm Chart

This chart deploys:

- `spend-control-frontend`
- `spend-control-identity`
- `spend-control-finance`
- `spend-control-documents`
- migration job
- service account with optional workload identity annotation
- Gateway API `Gateway`
- HTTPRoutes for frontend, identity, finance, and documents paths

## Render

```bash
helm template spend-control repos/spendpilot-helm/charts/spendpilot
```

## Install

```bash
helm upgrade --install spend-control repos/spendpilot-helm/charts/spendpilot \
  --namespace spend-control \
  --create-namespace \
  -f repos/spendpilot-helm/charts/spendpilot/values-prod.yaml
```

Important values:

- image repositories and tag
- `config.create` and `config.existingConfigMapName`
- `serviceAccount.create`
- `secrets.create` and `secrets.existingSecretName`
- `keyVault.enabled`, `keyVault.name`, and `azure.managedIdentityClientId` for Azure Key Vault-backed runtime secrets

Platform bootstrap note:

- for prod, Terraform can pre-create the namespace, workload identity service account, and runtime `ConfigMap`
- if Azure Key Vault integration is enabled, set `config.create=false`, `serviceAccount.create=false`, `secrets.create=false`, and `keyVault.enabled=true`
- the chart will render a `SecretProviderClass`, mount the Secrets Store CSI volume into the backend pods, and sync the named Key Vault secrets into the stable in-cluster secret name consumed by the apps

Auth note:

- `auth.apiScope` should be `<backend Application ID URI>/access_as_user`
- do not derive it from the backend client ID unless your Application ID URI actually uses `api://<clientId>`
