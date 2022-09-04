Repo for the web-site: https://www.a-sh.ae

Static page built with Bootstrap, hosted on S3, disributed via CloudFront. 

Two automated CI/CD pipelines: 

I. Branch "Terraform" <br/>
    1. All underlying AWS infrastructure is described declaratively with TF files. <br/>
    2. CD effected via GitHub Actions on pushes. <br/>
    3. TF apply outputs uploaded to GitHub Artifacts for later usage (e.g. domain confirmation for ACM certifcate validation). <br/>

II. Branch "Static" <br/>
    GitHub Actions provides the following workflow on pushes: <br/>
    1. Assume AWS role with min privileges using creds stored in GH secrets. <br/>
    2. Checkout repo. <br/>
    3. Upload static files to the S3 bucket. <br/>
