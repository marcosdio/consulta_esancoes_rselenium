#codigo para pesquisa no site @sançoes


library("tidyverse")
library("RSelenium")
library("netstat")


rs_driver_object <- rsDriver(browser = "firefox",
                             chromever = NULL,
                            port = free_port())

remDr <-  rs_driver_object$client

site_sancoes <- "https://www.bec.sp.gov.br/sancoes_ui/aspx/consultaadministrativafornecedor.aspx"


cnpj_list <- c(45039237000114,27865757000102,12546935000157,07065868000119,60701190000104,60746948000112,03788306000142)


funcao_sancoes <- function(cnpj_empresas){
  remDr$navigate(site_sancoes)
  remDr$findElement(using= "id", "txtCNPJCPF")$sendKeysToElement(c(cnpj_empresas, key = "enter"))
  Sys.sleep(2)
  if(substr(remDr$findElement(using='css selector', 'table.styled:nth-child(3) > tbody:nth-child(1)')$getElementText(), 67, 95)=="Não foram encontradas sanções"){
    print("ok")
  }else {print("pendencia")}
  }

results <- sapply (cnpj_list, FUN = funcao_sancoes)
