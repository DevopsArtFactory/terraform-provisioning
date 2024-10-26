variable "sg_variables" {
  default = {
    external_lb = {
      tags = {
        tmcdapne2 = {
          Name    = "demoapp-tmcdapne2-external-lb-sg"
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
  }
}
