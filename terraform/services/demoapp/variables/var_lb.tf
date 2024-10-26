variable "lb_variables" {
  default = {

    target_group_slow_start = {
      tmcdapne2 = 0
    }

    target_group_deregistration_delay = {
      tmcdapne2 = 0
    }

    external_lb = {
      tags = {
        tmcdapne2 = {
          Name    = "demoapp-tmcdapne2-external-lb"
          app     = "demoapp"
          project = "demoapp"
          env     = "dev"
          stack   = "tmcdapne2"
        }
      }
    }

    external_lb_tg = {
      tags = {
        tmcdapne2 = {
          Name    = "demoapp-tmcdapne2-external-tg"
          app     = "demoapp"
          project = "demoapp"
          env     = "dev"
          stack   = "tmcdapne2"
        }
      }
    }
    internal_lb = {
      tags = {
      }
    }

    internal_lb_tg = {
      tags = {
      }
    }
  }
}
