
# 0) Setup ----------------------------------------------------------------

## create token
usethis::create_github_token(description = "telegram LAR")

## set token
gitcreds::gitcreds_set()

## use github
usethis::use_github()

## packages and functions
source("R/ler_html_telegram.R")
library(lubridate)
library(tidyverse) # data wrangling



# 1) Data ----------------------------------------------------------------

data <- fs::dir_ls("data/ChatExport_2022-10-07/", regexp = "messages")

chat <- purrr::map_dfr(data, ler_html_telegram, .id = "arquivo")

glimpse(chat)



# 2) Plots ----------------------------------------------------------------

# barplot with number of messages by person
chat %>%
	group_by(nome) %>%
	tally() %>%
	ggplot(aes(x = reorder(nome, n), y = n)) +
	geom_col(fill = "#246634") +
	geom_label(aes(label = n), size = 8,
			   label.padding = unit(.2, "lines")) +
	labs(x = "Integrantes",
		 y = "Número de mensagens enviadas",
		 title = "Participação dos membros do LAR 🐸🐍🦎🦗🧬 no Telegram") +
	coord_flip() +
	theme_bw() +
	theme(plot.margin = margin(25, 25, 25, 25),
		  plot.title = element_text(size = 30),
		  axis.title = element_text(size = 20),
		  axis.text = element_text(size = 15))


# barplot with the hour of communication
chat %>%
	mutate(hora = factor(hour(data_hora))) %>%
	ggplot(aes(x = hora)) +
	geom_bar(fill = "#246634") +
	labs(x = "Hora",
		 y = "Número de mensagens",
		 title = "Hora de envio das mensagens") +
	theme_bw() +
	theme(plot.margin = margin(25, 25, 25, 25),
		  plot.title = element_text(size = 30),
		  axis.title = element_text(size = 20),
		  axis.text = element_text(size = 15))


