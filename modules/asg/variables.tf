variable "env" {
  type        = string
  description = "This variable represents the environment"
  default     = "dev"
}
variable "instance_type" {
  type        = string
  description = "The size of Ec2 instances"
  default     = "t2.micro"
}

variable "max_size" {
  type        = number
  description = "The maximum number of ec2 instances"
  default     = 5
}

variable "min_size" {
  type        = number
  description = "the min number of ec2 instances"
  default     = 2
}

variable "desired_capacity" {
  type        = number
  description = "the desired capacity"
  default     = 2
}

variable "force_delete" {
  type        = bool
  description = "value for the argument"
  default     = true
}

variable "web_ports" {
  type        = list(string)
  description = "List of ports for sg"
  default     = ["22", "80"]
}


variable "region" {
  type        = string
  description = "the region"
  default     = "us-east-1"

}

variable "project" {
  type        = string
  description = "the project"
  default     = "dog"
}

variable "stage" {
  type        = string
  description = "the stage"
  default     = "nonprod"
}

variable "vpc_zone_identifier" {
  type        = list(string)
  description = "List of subnets"
  default     = ["answer"]
}

variable "lb_target_group_arn" {
  type        = string
  description = "arn of the lb"
  default     = "answer"
}

variable "vpc_id" {
  type        = string
  description = "vpc id of  custom vpc"
  default     = "answer"
}