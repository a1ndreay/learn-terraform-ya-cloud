#terraform output [<output_label>]
output "instance_external_hostname" {
  description = "yandex compute instance chapter5-lesson2-std-ext-011-46 hostname"
  value       = yandex_compute_instance.vm-1.hostname
}

output "instance_external_network_interface" {
  description = "yandex compute instance chapter5-lesson2-std-ext-011-46 hostname"
  value       = yandex_compute_instance.vm-1.network_interface
}

output "instance_external_nat_adress" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}

output "yandex_resourcemanager_folder_id" {
  value = data.yandex_resourcemanager_folder.students_ext_11.folder_id
}

output "yandex_compute_image_id" {
  value = data.yandex_compute_image.ubuntu.id
}

output "yandex_resourcemanager_folder_count" {
  value = data.yandex_resourcemanager_folder.students_ext_11.status
}

# output "yandex_iam_service_account_static_access_key" {
#   value = yandex_iam_service_account_static_access_key.sa-static-key.access_key
# }

# output "yandex_iam_service_account_static_secret_key" {
#   value = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
#   sensitive = true
# }