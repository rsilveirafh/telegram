
# Função por Julio Trecenti
# https://blog.curso-r.com/posts/2019-09-10-rbrasil/


ler_html_telegram <- function(html_file) {

	require(magrittr, quietly = TRUE)

	# pega todas as mensagens
	divs <- xml2::read_html(html_file) %>%
		xml2::xml_find_all("//div[@class='message default clearfix']")

	# nome da pessoa
	nomes <- divs %>%
		xml2::xml_find_all("./div/div[@class='from_name']") %>%
		xml2::xml_text() %>%
		stringr::str_squish()

	# data e hora da mensagem
	data_horas <- divs %>%
		xml2::xml_find_all("./div/div[@class='pull_right date details']") %>%
		xml2::xml_attr("title") %>%
		lubridate::dmy_hms()

	# texto da mensagem
	textos <- divs %>%
		purrr::map(xml2::xml_find_first, "./div/div[@class='text']") %>%
		purrr::map_chr(xml2::xml_text) %>%
		stringr::str_squish()

	# retorna numa tabela
	tibble::tibble(
		data_hora = data_horas,
		nome = nomes,
		texto = textos
	)
}
