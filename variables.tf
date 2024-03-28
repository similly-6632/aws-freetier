variable "naming_prefix" {
  description = "Prefix for the naming convention"
  default     = "srmlab-awsfreetier"
}
variable "region" {
  description = "Provide the region for deploying the VPC"
  default     = "us-east-1"
}
variable "availability_zone1" {
  description = "AZ1"
  default     = "us-east-1a"

}
variable "availability_zone2" {
  description = "AZ2"
  default     = "us-east-1c"

}
variable "vpc_cidr" {
  description = "Provide the network CIDR for the VPC"
  default     = "10.0.0.0/16"
}
variable "subnet1_cidr" {
  description = "Provide the CIDR for subnet 1"
  default     = "10.0.10.0/24"
}
variable "subnet2_cidr" {
  description = "Provide the CIDR for subnet 2"
  default     = "10.0.20.0/24"
}
