# DevOps Pipeline Assignment

A complete DevOps pipeline built from scratch for a Node.js web application.
Covers CI/CD, Docker, Infrastructure as Code, and Monitoring.

---

## Live Repository
https://github.com/umashankar2203/devops-assignment

---

## Project Structure
```
devops-assignment/
├── src/
│   ├── index.js                  # Express web app
│   └── index.test.js             # Jest unit tests
├── .github/
│   └── workflows/
│       └── ci-cd.yml             # GitHub Actions CI/CD pipeline
├── terraform/
│   ├── main.tf                   # AWS resources (VPC, EC2, S3)
│   ├── variables.tf              # Input variables
│   └── outputs.tf                # Output values
├── monitoring/
│   └── prometheus.yml            # Prometheus scrape config
├── Dockerfile                    # Multi-stage Docker build
├── docker-compose.yml            # App + Prometheus + Grafana
├── package.json                  # Node.js dependencies
└── .eslintrc.json                # ESLint configuration
```

---

## Part 1 — CI/CD with GitHub Actions

### What it does
Every time code is pushed to the main branch, GitHub Actions automatically:
1. Checks code quality with ESLint
2. Runs unit tests with Jest
3. Builds a Docker image

### Pipeline Jobs

| Job | What it does | Status |
|-----|-------------|--------|
| Lint | Runs ESLint to check code quality | Passing |
| Test | Runs Jest unit tests with coverage | Passing |
| Build | Builds Docker image | Passing |

### How to trigger the pipeline
Simply push any code change to the main branch:
```
git add .
git commit -m "your message"
git push
```

Then go to the Actions tab on GitHub to watch it run.

### Pipeline Results
- Lint job — checks for code errors and style issues
- Test job — runs 2 unit tests, both passing
- Build job — successfully builds Docker image

---

## Part 2 — Docker

### Dockerfile
The app uses a multi-stage Docker build:
- Stage 1 (builder) — installs all dependencies
- Stage 2 (production) — copies only what is needed, runs as non-root user for security

### How to run with Docker

Build the image:
```
docker build -t devops-demo .
```

Run the container:
```
docker run -p 3000:3000 devops-demo
```

Open browser at http://localhost:3000

### How to run with Docker Compose

Starts the app, Prometheus, and Grafana together:
```
docker-compose up -d
```

Check all containers are running:
```
docker ps
```

Stop everything:
```
docker-compose down
```

### Running Containers

| Container | Port | Purpose |
|-----------|------|---------|
| demo-app | 3000 | Node.js web application |
| prometheus | 9090 | Metrics collection |
| grafana | 3001 | Metrics visualisation |
| node-exporter | 9100 | System metrics collector |

### App Endpoints

| Endpoint | Response |
|----------|----------|
| http://localhost:3000 | Hello message with status ok |
| http://localhost:3000/health | Health status and uptime |

---

## Part 3 — Infrastructure as Code (Terraform)

### What gets provisioned on AWS
```
VPC (10.0.0.0/16)
  └── Public Subnet (10.0.1.0/24)
       ├── Internet Gateway
       ├── Route Table
       ├── Security Group (ports 22, 80, 443, 3000)
       └── EC2 Instance (t3.micro, Ubuntu 22.04)
            └── Installs Docker and runs the app automatically

S3 Bucket
  ├── Versioning enabled
  ├── Encryption enabled (AES256)
  └── Public access blocked
```

### How to use Terraform

Install Terraform from https://terraform.io

Configure AWS credentials:
```
aws configure
```

Then run:
```
cd terraform
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
terraform destroy
```

### Terraform Files

| File | Purpose |
|------|---------|
| main.tf | All AWS resources |
| variables.tf | Input variables |
| outputs.tf | Outputs like server IP and app URL |

---

## Part 4 — Monitoring (Bonus)

### Stack

| Tool | Purpose | Port |
|------|---------|------|
| Prometheus | Collects and stores metrics | 9090 |
| Grafana | Visualises metrics as dashboards | 3001 |
| Node Exporter | Collects system metrics | 9100 |

### How to access

Start the stack:
```
docker-compose up -d
docker run -d --name node-exporter --network devops-assignment_app-network -p 9100:9100 prom/node-exporter:latest
```

Open Grafana at http://localhost:3001

Login credentials:
```
Username: admin
Password: admin123
```

### Setting up the dashboard

1. Go to Connections and add Prometheus as data source
2. URL: http://prometheus:9090
3. Click Save and test
4. Go to Dashboards and click Import
5. Enter dashboard ID 1860 and click Load
6. Select Prometheus as the data source
7. Click Import

### Metrics visible on dashboard
```
Sys Load      — 1.9%
RAM Used      — 14.5%
SWAP Used     — 0.0%
CPU Cores     — 16
RAM Total     — 8 GiB
SWAP Total    — 2 GiB
Uptime        — live
```

---

## How to run the full project locally

Step 1 — Clone the repository:
```
git clone https://github.com/umashankar2203/devops-assignment.git
cd devops-assignment
```

Step 2 — Install dependencies:
```
npm install
```

Step 3 — Run tests:
```
npm test
```

Step 4 — Start the app locally:
```
npm start
```

Step 5 — Run with Docker:
```
docker-compose up -d
```

Step 6 — Add node-exporter for metrics:
```
docker run -d --name node-exporter --network devops-assignment_app-network -p 9100:9100 prom/node-exporter:latest
```

Step 7 — Open in browser:
```
App:        http://localhost:3000
Prometheus: http://localhost:9090
Grafana:    http://localhost:3001
```

---

## Technologies Used

| Technology | Purpose |
|------------|---------|
| Node.js + Express | Web application |
| Jest + Supertest | Unit testing |
| ESLint | Code quality |
| Docker | Containerisation |
| Docker Compose | Multi-container orchestration |
| GitHub Actions | CI/CD pipeline |
| Terraform | Infrastructure as Code |
| Prometheus | Metrics collection |
| Grafana | Metrics visualisation |
| AWS (EC2, VPC, S3) | Cloud infrastructure |

---

## Author
Umashankar
GitHub: https://github.com/umashankar2203
