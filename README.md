# Express Backend Infrastructure with Terraform

This project contains a complete infrastructure setup for deploying an Express.js backend application on AWS using Terraform, with automated CI/CD using GitHub Actions.

## 📁 Project Structure

```
.
├── express-backend/          # Node.js Express application
│   ├── app.js               # Main application file
│   └── package.json         # Node.js dependencies and scripts
├── infrastructure/          # Terraform configuration files
│   ├── main.tf             # Main infrastructure resources
│   ├── variables.tf        # Input variables
│   ├── outputs.tf          # Output values
│   ├── terraform.tf        # Provider and version requirements
│   ├── ec2instance-key     # SSH private key (keep secure!)
│   └── ec2instance-key.pem # SSH private key in PEM format
├── scripts/                # Deployment and CI scripts
│   └── dev/
│       ├── ci.sh           # CI script for automated deployment
│       └── deploy.sh       # Deployment script for the server
└── README.md              # This file
```

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- [Terraform](https://www.terraform.io/downloads.html) (>= 1.2)
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
- [Node.js](https://nodejs.org/) (for local development)
- Git
- SSH client

### AWS Credentials Setup

1. Install and configure AWS CLI:
```bash
aws configure
```

2. Or set environment variables:
```bash
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="ap-south-1"
```

## 🏗️ Infrastructure Setup with Terraform

### Step 1: Initialize Terraform

Navigate to the infrastructure directory and initialize Terraform:

```bash
cd infrastructure
terraform init
```

This command will:
- Download the required provider plugins (AWS)
- Initialize the backend configuration
- Download and install modules (VPC module)

### Step 2: Plan the Infrastructure

Review what Terraform will create:

```bash
terraform plan
```

### Step 3: Apply the Infrastructure

Create the infrastructure:

```bash
terraform apply
```

Type `yes` when prompted to confirm the creation.

### Step 4: Get Outputs

After successful deployment, get the important outputs:

```bash
terraform output
```

### Infrastructure Components

The Terraform configuration creates:

- **VPC**: A Virtual Private Cloud with public and private subnets
- **EC2 Instance**: Ubuntu 24.04 server running in the public subnet
- **Security Groups**: Default security group from the VPC module
- **SSH Key Pair**: For secure access to the EC2 instance

### Terraform Commands Reference

```bash
# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Plan changes
terraform plan

# Apply changes
terraform apply

# Show current state
terraform show

# List resources
terraform state list

# Destroy infrastructure (use with caution!)
terraform destroy
```

## 🔧 Express Backend Application

### Local Development

1. Navigate to the express-backend directory:
```bash
cd express-backend
```

2. Install dependencies:
```bash
npm install
```

3. Start the development server:
```bash
npm run dev
```

The application will be available at `http://localhost:3000`

### Application Features

- **Express.js server** running on port 3000 (configurable via PORT env variable)
- **JSON middleware** for parsing request bodies
- **Basic route** at `/` returning "Hello, World!"
- **Development setup** with nodemon for auto-restart

## 🚀 Deployment Scripts

### CI Script (`scripts/dev/ci.sh`)

This script is used for continuous integration and deployment:

1. **Secures the SSH key** with proper permissions (400)
2. **Connects to the EC2 instance** using SSH
3. **Executes the deployment script** remotely

Usage:
```bash
chmod +x scripts/dev/ci.sh
./scripts/dev/ci.sh
```

### Deploy Script (`scripts/dev/deploy.sh`)

This script runs on the server to deploy the latest code:

1. **Pulls latest code** from GitHub
2. **Installs dependencies** with npm
3. **Restarts the application** using PM2

## 🔄 GitHub Actions Workflow Setup

### Step 1: Create GitHub Repository

1. Initialize git repository:
```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/yourusername/your-repo.git
git push -u origin main
```

### Step 2: Add GitHub Secrets

In your GitHub repository, go to Settings > Secrets and Variables > Actions, and add:

- `AWS_ACCESS_KEY_ID`: Your AWS access key
- `AWS_SECRET_ACCESS_KEY`: Your AWS secret access key
- `EC2_SSH_PRIVATE_KEY`: Content of your `ec2instance-key` file
- `SERVER_IP`: Your EC2 instance public IP

## 🔐 Security Considerations

### SSH Keys
- Keep your `ec2instance-key` and `ec2instance-key.pem` files secure
- Never commit private keys to version control
- Use appropriate file permissions (400 for private keys)

### AWS Security
- Use IAM roles with minimal required permissions
- Configure security groups to allow only necessary ports
- Regularly rotate access keys

### Application Security
- Use environment variables for sensitive configuration
- Implement proper error handling
- Add rate limiting and security headers

## 🔧 Troubleshooting

### Common Terraform Issues

1. **Provider authentication errors**:
   - Verify AWS credentials are configured correctly
   - Check IAM permissions

2. **Resource creation failures**:
   - Ensure region settings are correct
   - Verify available resources in your AWS account

3. **State file issues**:
   - Use `terraform refresh` to sync state
   - Consider remote state storage for team projects

### Common Deployment Issues

1. **SSH connection failures**:
   - Verify SSH key permissions (should be 400)
   - Check security group allows SSH (port 22)
   - Ensure correct server IP address

2. **Application startup issues**:
   - Check server logs: `pm2 logs`
   - Verify Node.js and dependencies are installed
   - Ensure port 3000 is available


## 🚀 Scaling and Production Considerations

### Load Balancing
Consider adding an Application Load Balancer (ALB) to your Terraform configuration for high availability.

### Database
Add RDS or other database services to your infrastructure as your application grows.

### Monitoring
Implement CloudWatch monitoring and logging for better observability.

### SSL/TLS
Configure SSL certificates using AWS Certificate Manager for HTTPS.

## 📚 Additional Resources

- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Express.js Documentation](https://expressjs.com/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [PM2 Documentation](https://pm2.keymetrics.io/)
- [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature-name`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin feature-name`
5. Submit a pull request

## 📄 License

This project is licensed under the ISC License - see the package.json file for details.

---

**Note**: Remember to update the SERVER_IP in `scripts/dev/ci.sh` and any GitHub secrets with your actual values after deploying your infrastructure.
