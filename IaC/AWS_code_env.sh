
# Networking

# Create a VPC 

aws ec2 create-vpc \
    --cidr-block 10.0.0.0/16 \
    --tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value=WebApplication-VPC}]'

# Create a subnet to WebServer

aws ec2 create-subnet \
    --vpc-id <VPC_ID> \
    --cidr-block 10.0.1.0/24 \
    --availability-zone us-east-2a \
    --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=WebServer-Subnet}]'


# Attach a Internet Gateway

aws ec2 create-internet-gateway \
    --tag-specifications 'ResourceType=internet-gateway,Tags=[{Key=Name,Value=WebServer-IGW}]'

aws ec2 attach-internet-gateway \
    --vpc-id <VPC_ID> \
    --internet-gateway-id <INTERNET_GATEWAY_ID>

# Create a Route tables

aws ec2 create-route-table \
    --vpc-id <VPC_ID> \
    --tag-specifications 'ResourceType=route-table,Tags=[{Key=Name,Value=WebServer-RouteTable}]'

aws ec2 associate-route-table \
    --route-table-id <ROUTE_TABLE_ID> \
    --subnet-id <SUBNET_ID>

aws ec2 create-route \
    --route-table-id <ROUTE_TABLE_ID> \
    --destination-cidr-block 0.0.0.0/0 \
    --gateway-id igw-042a483c7c1a124af

# Create Security Groups

aws ec2 create-security-group \
    --group-name WebServer-SG \
    --description "Security Group for Web Server" \
    --vpc-id <VPC_ID> \

# Add Rules to Security Groups

aws ec2 authorize-security-group-ingress \
    --protocol tcp \
    --port 80 \
    --cidr 0.0.0.0/0 \
    --group-id <SECURITY_GROUP_ID>

aws ec2 authorize-security-group-ingress \
    --protocol tcp \
    --port 22 \
    --cidr 0.0.0.0/0 \
    --group-id <SECURITY_GROUP_ID>