variable "env" {
  type        = string
  description = "This is a variable for Environment"
  default     = "dev"
}

variable "instance_type" {
  type        = string
  description = "This is a variable for instance type"
  default     = "t2.micro"
}
variable "vpc_cidr" {
  type        = string
  description = "This is a variable for vpc cidr "
  default     = "10.0.0.0/16"
}

variable "pub_cidr_blocks" {
  type        = list(string)
  description = "This is a list of pub cidr blocks"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "priv_cidr_blocks" {
  type        = list(string)
  description = "this is a list of priv cidr blocks"
  default     = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
}


variable "project" {
  type        = string
  description = "The project name"
  default     = "bird"
}

variable "stage" {
  type        = string
  description = "the stage it is on"
  default     = "nonprod"
}

variable "region" {
  type        = string
  description = "The region"
  default     = "ue1"
}

variable "AZ" {
  type        = list(string)
  description = "the AZ's"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
