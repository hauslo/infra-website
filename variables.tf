
variable "domain" {
  type        = string
  description = "The bucket domain name"
}

variable "public" {
  type        = string
  description = "The path to the website root"
}

variable "mime_types" {
  default = {
    html  = "text/html"
    css   = "text/css"
    js    = "application/javascript"
    map   = "application/javascript"
    json  = "application/json"
    ico   = "image/x-icon"
  }
}
