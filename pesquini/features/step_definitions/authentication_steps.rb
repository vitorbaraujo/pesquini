# encoding: utf-8

Dado(/^que a empresa samsung exista$/) do
  @enterprise = Enterprise.new
  @enterprise.corporate_name = "samsung"
  @enterprise.save
end

Dado(/^que eu estou na index de enterprises$/) do
  visit '/enterprises'
end

Dado(/^que eu clico no text field$/) do
  pending # express the regexp above with the code you wish you had
end

Dado(/^que insiro uma empresa existente$/) do
  fill_in 'q_corporate_name_cont', :with=> "samsung"
end

Quando(/^eu clico no botão "(.*?)"$/) do |arg1|
  click_button arg1
end

Entao(/^vejo o texto os dados desta empresa\.$/) do
  page.should have_content('samsung')
end

Dado(/^que eu estou na index da welcome$/) do
  visit '/'
end

Quando(/^eu clico no link "(.*?)"$/) do |arg1|
  click_link arg1
end

Quando(/^eu clico no id "(.*?)"$/) do |arg1|
  find("#"+arg1).click
end

Dado(/^que a empresa COOPERSEMO exista$/) do
  @enterprise = Enterprise.new
  @enterprise.corporate_name = "COOPERSEMO"
  @enterprise.save
end

Dado(/^que uma sançao exista$/) do
  @sanction = Sanction.new
  @sanction.sanction_type_id = 1
  @sanction.save
end

Dado(/^que eu visitei a pagina de rankings$/) do
  visit '/rankings'
end

Entao(/^vejo o ranking das empresas com os dados, posiçao, nome e numero de sançoes$/) do
  page.should have_content('COOPERSEMO')
end

Dado(/^que eu clico no nome da empresa$/) do
  visit '/enterprises/1122'
end

Entao(/^vejo os dados das sançoes da mesma$/) do
  page.should have_content(1)
end

Dado(/^que eu estou em qualquer pagina da aplicaçao$/) do
  visit '/' 
end

Entao(/^vejo o texto "(.*?)"$/) do |arg1|
  page.should have_content(arg1)
end


