Static web page with my CV hosted on S3.

Using Terraform for provisioning: 
S3 bucket, CloudFront distribution, ACM certificate, R53 hosted zone & records.

Using GitHub Actions on pull requests, workflow:
1. Assume AWS role with min privileges using creds stored in GH secrets.
2. Checkout repo.
3. Upload static files to the bucket.