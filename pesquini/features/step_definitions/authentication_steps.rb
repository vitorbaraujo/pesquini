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
    fill_in 'Corporate name contains', :with=> "samsung"
end

Quando(/^eu clico no link "(.*?)"$/) do |arg1|
  click_button arg1
end

Entao(/^vejo o texto os dados desta empresa\.$/) do
  page.should have_content('samsung')
end
