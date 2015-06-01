#language: pt

Funcionalidade: Pesquisar Empresas Inidonias
  Ao usuário entrar no sistema, ele poderá inserir o nome ou cnpj de uma das empresas no campo pré-determinado para tal função

Cenário: Abrir página inicial 

Ao usuário tentar pesquisar uma empresa existente, ela deverá ter seus dados prévios mostrados.

Dado que a empresa samsung exista
Dado que eu estou na index da welcome
Dado que insiro uma empresa existente
Quando eu clico no id "search_index"
Entao vejo os dados prévios desta empresa.

Cenário: Abrir página de pesquisar empresas   

Ao usuário tentar pesquisar uma empresa existente, ela deverá ter seus dados mostrados.

Dado que a empresa samsung exista
Dado que eu estou na index de enterprises
Dado que insiro uma empresa existente
Quando eu clico no botão "Search"
Entao vejo todos os dados desta empresa.

Cenário: Entrar na pagina de estatisticas para ver o grafico dos estados com mais sanções

Dado que estou na index na welcome
Quando eu clico no link "Estatisticas"
Então eu sou redirecionado ao quadro de estatisticas
Quando eu clico no link "Estados com mais sanções"
Então eu vejo o texto "Nesse gráfico estão disponiveis as informações sobre a quantidade de sanções que cada unidade federativa brasileira recebeu desde o começo da obtenção de dados. "
