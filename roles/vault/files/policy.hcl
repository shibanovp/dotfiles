path "secret/data/{{identity.entity.id}}/*" {
  capabilities = ["create", "update", "read", "delete"]
}

path "secret/metadata/{{identity.entity.id}}/*" {
  capabilities = ["list"]
}

# Create and manage entities and groups
path "identity/*" {
  capabilities = [ "create", "read", "update", "delete", "list" ]
}
