#resource "local_file" "arquivo" {
#  content  = "Conteúdo do arquivo 1"
#  filename = "./arquivo1.txt"
#  depends_on = [
#    local_file.outro_arquivo
#   ]
#}

resource "local_file" "arquivo" {
  content  = "Conteúdo do arquivo  - ${each.key}"
  filename = "./arquivo-${each.key}.txt"
  #count = var.contador
  for_each = var.contador
}

variable "contador" {
  default = ["Maquina01", "Maquina02", "Maquina03"]
  type = set(string)
}

#variable "conteudo" {
#  default = ["nyc", "media", "false"]
#  type        = tuple([string, string, bool])
#  description = "conteúdo que vai para o arquivo."
#}


#variable "conteudo_string" {
#  type        = string
#  #default     = "Teste"
#  description = "Conteúdo dentro do arquivo"
#}
#
#variable "lista_nomes" {
#  type        = list(string)
#  #default     = ["Maquina01", "Maquina02", "Maquina03", "Maquina03"]
#  description = "Lista de nomes."
#}
#
#resource "local_file" "arquivo_list" {
#  content  = "Os nomes definidos foram ${join(", ", var.lista_nomes)}"
#  filename = "arquivo-list.txt"
#}
#
#resource "local_file" "arquivo_string" {
#  content  = var.conteudo_string
#  filename = "arquivo-string.txt"
#}