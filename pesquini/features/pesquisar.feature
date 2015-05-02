#language: pt

Funcionalidade: Pesquisar Empresas Inidonias
  Ao usuário entrar na homepage do sistema, ele poderá inserir o nome ou cnpj de uma das empresas no campo pré-determinado para tal função

Cenário: Abrir página de pesquisar empresas   

Ao usuário tentar pesquisar uma empresa existente, ela deverá ter seus dados mostrados.

Dado que a empresa samsung exista
Dado que eu estou na index de enterprises
Dado que insiro uma empresa existente
Quando eu clico no link "Search"
Entao vejo o texto os dados desta empresa.
