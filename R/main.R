
# 0) Setup ----------------------------------------------------------------

## create token
usethis::create_github_token(description = "telegram LAR")

## set token
gitcreds::gitcreds_set()

## use github
usethis::use_github()

## get token
gitcreds::gitcreds_get()

## packages and functions
source("R/ler_html_telegram.R")
library(tidyverse) # data wrangling


# 1) Data ----------------------------------------------------------------

data <- fs::dir_ls("data/ChatExport_2022-10-07/", regexp = "messages")

chat <- purrr::map_dfr(data, ler_html_telegram, .id = "arquivo")


# 2) Plots ----------------------------------------------------------------





