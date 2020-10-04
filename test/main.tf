provider "aws" {
  alias                       = "test"
  region                      = "eu-west-3"
  access_key                  = "AKIAIOSFODNN7EXAMPLE"
  secret_key                  = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_force_path_style         = true

  endpoints {
    s3  = "http://localhost:4572"
    iam = "http://localhost:4566"
  }
}

module "test" {
  source = "./module"

  domain = "test"
  public = "./public"
  providers = {
    aws = aws.test
  }
}

output "test_bucket" {
  value = module.test.bucket
}

output "test_bucket_domain_name" {
  value = module.test.bucket_domain_name
}
