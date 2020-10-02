
###
# If we wanted to fetch the latest mime.types version from httpd repo
###
#
#provider "http" {}
#
#data "http" "mimetypes" {
#  url = "https://svn.apache.org/repos/asf/httpd/httpd/trunk/docs/conf/mime.types"
#
#  request_headers = {
#    Accept = "text/plain"
#  }
#}
#
# ... data.http.mimetypes.body
#

locals {
  mimetypes = { for line in
        compact([ for line in 
            split("\n", file("${path.module}/conf/mime.types")) :
            trimspace(replace(trimspace(line), "/#.*/", ""))
        ]) :
        element(split(" ", replace(line, "/\\s+/", " ")), 1) => element(split(" ", replace(line, "/\\s+/", " ")), 0)...
    }
}
