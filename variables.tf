variable "languagetool_docker_image" {
  type    = string
  default = "meyay/languagetool"
}

variable "languagetool_docker_image_tag" {
  type    = string
  default = "6.7-3"
}

variable "languages" {
  type    = list(string)
  default = []
}

