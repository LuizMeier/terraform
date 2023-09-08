resource "local_file" "exemplo" {
  content = join(", ", [for v in var.valor: trimspace(v)])
  filename = "arquivo.txt"
}

variable valor {
    default = ["Docker", "Terraform", "Jenkins"]
    validation {
      condition = contains(var.valor, "kubernetes")
      error_message = "Tem que ter kubernetes nessa lista"
    }
}