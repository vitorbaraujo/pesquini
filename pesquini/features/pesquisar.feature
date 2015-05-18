#language: pt

Funcionalidade: Pesquisar Empresas Inidonias
  Ao usuário entrar no sistema, ele poderá inserir o nome ou cnpj de uma das empresas no campo pré-determinado para tal função

Cenário: Abrir página de pesquisar empresas   

Ao usuário tentar pesquisar uma empresa existente, ela deverá ter seus dados mostrados.

Dado que a empresa samsung exista
Dado que eu estou na index de enterprises
Dado que insiro uma empresa existente
Quando eu clico no botão "Search"
Entao vejo o texto os dados desta empresa.

Cenário: Abrir página inicial  

Ao usuário tentar pesquisar uma empresa existente, ela deverá ter seus dados mostrados.

Dado que a empresa samsung exista
Dado que eu estou na index da welcome
Dado que insiro uma empresa existente
Quando eu clico no id "search_index"
Entao vejo o texto os dados desta empresa.
