variable "env" {
  type        = string
  description = "The environment"
  default     = "dev"
}
variable "app_port" {
  type        = number
  description = "The port number of the application"
  default     = "80"
}

variable "stage" {
  type        = string
  description = "the stage"
  default     = "nonprod"
}

variable "project" {
  type        = string
  description = "the project"
  default     = "cat"
}


variable "region" {
  type        = string
  description = "the region"
  default     = "us-east-1"

}

variable "vpc_id" {
  type        = string
  description = "vpc id of custom vpc"
  default     = "answer"
}

variable "subnets" {
  type        = list(string)
  description = "List of subnets"
  default     = ["answer"]
}