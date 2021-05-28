resource "random_password" "password" {
  count   = var.same_password ? 1 : var.user_count
  length  = var.password_length
  special = false
}

locals {
  users = var.same_password ? [for index in range(var.user_count) :
    ["${var.user_prefix}-${format("%03d", index + 1)}", random_password.password[0].result]
    ] : [for index, pw in random_password.password :
    ["${var.user_prefix}-${format("%03d", index + 1)}", pw.result]
  ]
  instances = [for i in range(1, var.instance_count + 1) :
    [i, "${var.hostname_prefix}-${format("%02d", i)}", cidrhost(var.subnet_cidr, -var.instance_count + i - 3)]
  ]
}
