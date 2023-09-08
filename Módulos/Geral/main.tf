module "pets" {
  source = "./modules/pets"
  prefixo_arquivo = "teste_arquvo-${each.key}"
  for_each = toset([ "prpe01", "pre02", "pre03", "pre04" ])
}

