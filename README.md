# sre-bootcamp-capstone-project
SRE bootcamp repository

# Setup

You can run:

```bash
npm install
```

# Add env variables
 * Create in the config folder a file with .env name.
 * Ask for the credentials
 ```
    PORT=8000
    DB_USER=admin
    DB_PASSWORD=*******
    DB_NAME=user
    HOST=sre-bootcamp.*******.us-east-1.rds.amazonaws.com
    secret=my2w7wjd7yXF64FIADfJxNs1oupTGAuW
```

# Run app
```bash
npm run start
```

## Add in the headers a token value: 
```bash
curl --location --request GET 'http://localhost:8000/cidr-to-mask?value=16' \
--header 'token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW4ifQ.StuYX978pQGnCeeaj2E1yBYwQvZIodyDTCJWXdsxBGI'
```

# Run tests
```bash
npm run test
```
 
# Docker image

```bash
docker pull osestrad/academy-sre-bootcamp-osvaldo-estrada
```


# Terraform
1. Run 
 ```bash
aws configure --profile sre-bootcamp

```

* configure your credentials.

2. Run :
```bash
terraform init
```

3. Run:
```bash
terraform fmt
terraform validate
terraform plan
```

4. To deploy the IAC run:
```bash
terraform apply
```