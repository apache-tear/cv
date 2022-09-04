Repo for the web-site: https://www.a-sh.ae

Static page built with Bootstrap, hosted on S3, disributed via CloudFront. 

Two automated CI/CD pipelines: 

I. Branch "Terraform"
    1. All underlying AWS infrastructure is described declaratively with TF files.
    2. CD effected via GitHub Actions on pushes.
    3. TF apply outputs uploaded to GitHub Artifacts for later usage (e.g. domain confirmation for ACM certifcate validation).

II. Branch "Static"
    GitHub Actions provides the following workflow on pushes:
    1. Assume AWS role with min privileges using creds stored in GH secrets.
    2. Checkout repo.
    3. Upload static files to the S3 bucket.
