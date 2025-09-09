data "aws_caller_identity" "current" {}

resource "aws_opensearch_domain" "bugraid_noufa_logs" {
  domain_name    = "bugraid-noufa-logs"
  engine_version = "OpenSearch_2.13"

  cluster_config {
    instance_type  = "t3.small.search"
    instance_count = 1
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
    volume_type = "gp3"
  }

  node_to_node_encryption {
    enabled = true
  }

  encrypt_at_rest {
    enabled = true
  }

  domain_endpoint_options {
    enforce_https       = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

  # ✅ Fine-grained access control (admin/password)
  advanced_security_options {
    enabled                        = true
    internal_user_database_enabled = true

    master_user_options {
      master_user_name     = "admin"
      master_user_password = "BugraidNoufa@123"
    }
  }

  # ✅ Access policy: allow everyone, FGAC will enforce login
  access_policies = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "es:ESHttp*",
      "Resource": "arn:aws:es:ap-south-1:${data.aws_caller_identity.current.account_id}:domain/bugraid-noufa-logs/*"
    }
  ]
}
POLICY

  tags = {
    Name        = "bugraid-noufa-opensearch"
    Environment = "bugraid-noufa"
    Project     = "bugraid-assignment"
  }
}
