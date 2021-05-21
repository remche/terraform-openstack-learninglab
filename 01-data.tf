resource "random_password" "password" {
  count = var.user_count
  length = 16
  special = false
}

locals {
  users = [ for index, pw in random_password.password:
            ["${var.user_prefix}-${format("%03d", index + 1)}", pw.result]
          ]
  instances = [ for i in range(1, var.instance_count+1):
                [i, "${var.hostname_prefix}-${format("%02d", i)}", cidrhost(var.subnet_cidr, i+10)]
              ]
}
