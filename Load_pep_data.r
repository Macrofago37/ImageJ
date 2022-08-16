Load_pep_data <- function(Data, nome){
  
  Data <- read_delim("~/Downloads/Emer_RUN1_1/Peptides.txt", 
                     delim = "\t", escape_double = FALSE, 
                     trim_ws = TRUE) %>% 
    slice(-1) %>% 
    select(Sequence, Charge, Proteins, `28/30`:`36/32`) %>% 
    mutate(across(c(`28/30`:`36/32`), ~ gsub(",", ".", .))) %>% 
    mutate(across(c(`28/30`:`36/32`), ~ as.numeric(.)))
    
    write_excel_csv2(Data, paste0(nome, ".csv"))
}
