## Repo for the web-site <br>
https://www.a-sh.ae

Static page is responsive, built with Bootstrap. Hosted on S3, disributed via CloudFront. 

Two automated CI pipelines: 

I. Branch "Terraform" <br/>

    - All underlying AWS infrastructure is described declaratively with TF files.
    - TF state stored on Terraform Cloud.
    - CD effected via GitHub Actions on pushes.
    - TF outputs are uploaded to GitHub Artifacts for later usage (e.g. domain confirmation for ACM certifcate validation).

II. Branch "Static" <br>
    GitHub Actions provides the following workflow on pushes:
    
    - Parse TF outputs from GH Artifacts.
    - Assume AWS role with least privileges.
    - Checkout repo.
    - Upload static files to the S3 bucket.