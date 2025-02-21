output "vm_public_ip" {
  description = "Public IP of the created instance"
  value       = module.compute.instance_ip
}