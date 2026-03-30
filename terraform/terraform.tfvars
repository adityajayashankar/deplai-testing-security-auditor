project_name = "deplai-testing-security-auditor"
aws_region = "eu-north-1"
environment = "dev"
instance_type = "t3.micro"
enable_ec2 = true
existing_ec2_key_pair_name = ""
ingress_cidr_blocks = ["0.0.0.0/0"]
ssh_ingress_cidr_blocks = []
preferred_availability_zones = ["eu-north-1a", "eu-north-1b", "eu-north-1c"]
use_default_vpc = true
vpc_cidr_block = "10.42.0.0/16"
public_subnet_cidr = "10.42.1.0/24"
force_destroy_site_bucket = true
ec2_root_volume_size = 8
bootstrap_index_html_base64 = "PGh0bWw+CiAgPGhlYWQ+PHRpdGxlPkRlcGxBSSBEZXBsb3ltZW50PC90aXRsZT48L2hlYWQ+CiAgPGJvZHkgc3R5bGU9ImZvbnQtZmFtaWx5OiBBcmlhbCwgc2Fucy1zZXJpZjsgcGFkZGluZzogMnJlbTsiPgogICAgPGgxPkRlcGxBSSBkZXBsb3ltZW50IGlzIGxpdmU8L2gxPgogICAgPHA+UHJvamVjdDogZGVwbGFpLXRlc3Rpbmctc2VjdXJpdHktYXVkaXRvcjwvcD4KICAgIAogIDwvYm9keT4KPC9odG1sPg=="
context_summary = <<-EOT
Q/A Summary: Q: What AWS region should this deploy to, and do you need multi-AZ resilience?
A: eu-north-1 - single AZ, Free Tier mode.

Q: What runtime stack powers this service? (e.g. Python + uvicorn, Node + pm2)
A: Python 3.11 + uvicorn, 2 workers per instance.

Q: Expected baseline traffic - RPS, concurrent users, peak load pattern?
A: ~500 RPS peak, ~50 concurrent users, mostly read traffic.

Q: Which EC2 instance family is appropriate? (general-purpose, compute-optimised, memory-optimised)
A: t3.micro (Free Tier safe) - general-purpose.

Q: Should internet traffic route through CloudFront, or direct to ALB?
A: CloudFront -> ALB - no custom domain required yet.
Architecture Context: Q: What AWS region should this deploy to, and do you need multi-AZ resilience?
A: eu-north-1 - single AZ, Free Tier mode.

Q: What runtime stack powers this service? (e.g. Python + uvicorn, Node + pm2)
A: Python 3.11 + uvicorn, 2 workers per instance.

Q: Expected baseline traffic - RPS, concurrent users, peak load pattern?
A: ~500 RPS peak, ~50 concurrent users, mostly read traffic.

Q: Which EC2 instance family is appropriate? (general-purpose, compute-optimised, memory-optimised)
A: t3.micro (Free Tier safe) - general-purpose.

Q: Should internet traffic route through CloudFront, or direct to ALB?
A: CloudFront -> ALB - no custom domain required yet.
Code Findings: 0
Supply Findings: 0
Critical/High Supply: 0
High-impact CWE IDs: none
EOT
