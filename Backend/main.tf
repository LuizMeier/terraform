terraform {
  backend "pg" {
    conn_str = "postgres://$DBUSER:$DB_PWD@localhost:5432/$DATABASE"
  }
}

resource "local_file" "arquivo_local" {
  filename = "arquivo.txt"
  content  = "Conteúdo"
}