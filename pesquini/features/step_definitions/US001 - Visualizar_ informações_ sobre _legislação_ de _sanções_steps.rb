Dado(/^que eu estou em qualquer pagina da aplicaçao$/) do
  visit '/more' # express the regexp above with the code you wish you had
end

Dado(/^que eu clico no link "(.*?)"$/) do |arg1|
  visit '/more'# express the regexp above with the code you wish you had
end

Entao(/^vejo o texto mostrando os dados\(nome, descricao, lei relacionada\)$/) do
   page.should have_content# express the regexp above with the code you wish you had
end
