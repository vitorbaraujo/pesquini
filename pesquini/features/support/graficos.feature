#language: pt

Funcionalidade: Visualizar Grafico por Tipo de Sanções e por estados com mais sanções
  Ao usuario visualizar as estatisticas, ele poderá ver um grafico de pizza com os numeros por tipo de sanção e outro grafico de barras com os estados que sofreram maior numero de sanções .

Cenario: Ver grafico de sanções por tipo

Dado que eu estou na index de statistics
Quando eu clico no no link "Clique aqui para ser redirecionado para a página..."
Entao vejo o grafico de pizza de sanção por tipo

Cenário: Ver grafico de estados com mais sanções

Dado que eu estou na index de statistics
Quando eu clico no no link "Clique aqui para ser redirecionado para a página .."
Entao vejo o grafico de estados com mais sanções


Cenário: Entrar na pagina de estatisticas para ver o grafico dos estados com mais sanções

Dado que estou na index na welcome
Quando eu clico no link "Estatisticas"
Então eu sou redirecionado ao quadro de estatisticas
Quando eu clico no link "Estados com mais sanções"
Então eu vejo o texto "Nesse gráfico estão disponiveis as informações sobre a quantidade de sanções que cada unidade federativa brasileira recebeu desde o começo da obtenção de dados. "
