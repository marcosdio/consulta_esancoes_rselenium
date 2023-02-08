#codigo para pesquisa no site @sançoes

library (tidyverse)
library (RSelenium)
library (netstat)
library (readxl)
library (writexl)
rs_driver_object <- rsDriver(browser = "firefox",
                             chromever = NULL,
                             verbose=FALSE,
                             port = free_port())
remDr <- rs_driver_object$client
portal_sancoes <- "https://www.bec.sp.gov.br/sancoes_ui/aspx/consultaadministrativafornecedor.aspx"
dataset_base <- read_excel("banco_cnpj.xlsx")
funcao_consulta_sancoes <- function(cnpj_empresas){
  remDr$navigate(portal_sancoes)
  remDr$findElement(using= "id", "txtCNPJCPF")$sendKeysToElement(c(cnpj_empresas, key = "enter"))
  Sys.sleep(2)
  css_obj <- 'table.styled:nth-child(3) > tbody:nth-child(1)'
  if(substr(remDr$findElement(using='css selector', css_obj)$getElementText(), 74, 102)=="Não foram encontradas sanções"){
            print("ok")
  }         else {print("pendencia")}
  }
write_xlsx(cbind(cnpj_list,sapply(dataset_base$cnpj, FUN = funcao_consulta_sancoes)), "resultado e-sancoes.xlsx")

