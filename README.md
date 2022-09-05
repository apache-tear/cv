## Repo for the web-site <br>
https://www.a-sh.ae

Static page uses Bootstrap. Hosted on S3, disributed via CloudFront. 

Two automated CI pipelines: 

I. Branch "Terraform" <br/>

    - All underlying AWS infrastructure is described declaratively with TF files.
    - CD effected via GitHub Actions on pushes.
    - TF apply outputs uploaded to GitHub Artifacts for later usage (e.g. domain confirmation for ACM certifcate validation).

II. Branch "Static" <br>
    GitHub Actions provides the following workflow on pushes:
    
    - Assume AWS role with min privileges using creds stored in GH secrets.
    - Checkout repo.
    - Upload static files to the S3 bucket.