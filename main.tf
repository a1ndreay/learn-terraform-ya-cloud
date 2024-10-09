terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.87.0"
    }
  }

  # backend "s3" {
  #   endpoints = {
  #     s3 = "https://storage.yandexcloud.net"
  #   }
  #   bucket = "tf-test-bucket-std-ext-011-46"
  #   region = "ru-central1-a"
  #   key    = "~/terraform.tfstate"
  #   skip_region_validation      = true
  #   skip_credentials_validation = true
  #   skip_requesting_account_id  = true # Необходимая опция Terraform для версии 1.6.1 и старше.
  #   skip_s3_checksum            = true # Необходимая опция при описании бэкенда для Terraform версии 1.6.3 и старше.
  # }
}

provider "yandex" {
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
  token     = var.IAM_TOKEN
}

# Get folder by ID
data "yandex_resourcemanager_folder" "students_ext_11" {
  folder_id = var.folder_id
}

data "yandex_resourcemanager_cloud" "cloud-praktikumdevopscourse" {
  cloud_id = var.cloud_id
}

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

data "yandex_vpc_network" "name" {
  network_id = var.network_id
}

// Create SA https://yandex.cloud/ru/docs/iam/operations/sa/create
resource "yandex_iam_service_account" "sa" {
  folder_id = var.folder_id
  name      = "tf-test-sa-std-ext-011-46"
}

// Grant permissions SA #error reading Storage Bucket (tf-test-bucket-std-ext-011-46): Forbidden: Forbidden
# resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
#   folder_id = var.folder_id
#   role      = "storage.editor"
#   member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
# }

// Create Static Access Keys
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}


// Use keys to create bucket
resource "yandex_storage_bucket" "test" {
  folder_id = data.yandex_resourcemanager_folder.students_ext_11.folder_id
  bucket    = var.bucket
  #access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  #secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  max_size = 1048576
}

resource "yandex_compute_instance" "vm-1" {
  name = "chapter5-lesson2-std-ext-011-46"
  # Конфигурация ресурсов:
  # количество процессоров и оперативной памяти
  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
    }
  }


  # Сетевой интерфейс:
  # нужно указать идентификатор подсети, к которой будет подключена ВМ
  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  # Метаданные машины:
  # здесь можно указать скрипт, который запустится при создании ВМ
  # или список SSH-ключей для доступа на ВМ
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_yavm.pub")}"
  }
}