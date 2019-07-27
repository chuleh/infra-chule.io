# infra-chule.io
Repo for the new infra of my blog.
- creates 2 EC2 instances (not publicly accessible)
- creates ELB and routes traffic from ELB to instances
- associates EIPs to the 2 EC2 instances
- creates SGs for: ELB, EC2 instances, RDS
- creates RDS (password must be set when running terraform apply)
