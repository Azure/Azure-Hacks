output "jumphost_pip" {
  value = module.compute.jumphost_pip
}

output "acr_name" {
  value = module.k8s.acr_name
}

output "kube_config" {
  value     = module.k8s.kube_config
  sensitive = true
}

output "pg_password" {
  value     = random_password.pg_password.result
  sensitive = true
}

output "aoai_endpoint"  {
  value = module.ai.aoai_endpoint
}

# Note: API key auth is disabled in this environment (disableLocalAuth=true).
# Use Entra ID bearer tokens instead.
