Static web page with my CV hosted on S3
https://www.a-sh.ae

Using 2 separate CI pipelines:

Branch "static" uses GitHub Actions on PRs to:
1. Assume AWS role with min privileges using creds stored in GH secrets.
2. Checkout repo.
3. Upload static files to the S3 bucket.

Branch "terraform" provisions TF infrastructure on changes.