#language: pt

Funcionalidade: Visualizar Grafico por Tipo de Sanções e por estados com mais sanções
  Ao usuario visualizar as estatisticas, ele poderá ver um grafico de pizza com os numeros por tipo de sanção e outro grafico de barras com os estados que sofreram maior numero de sanções .

Cenario: Ver grafico de sanções por tipo

Dado que eu estou na index de statistics
Quando eu clico no no link "Clique aqui para ser redirecionado para a página..."
Entao vejo o grafico de pizza de sanção por tipo

Cenário: Ver grafico de estados com mais sanções

Dado que eu estou na index de statistics
Quando eu clico no no link "Clique aqui para ser redirecionado para a página."
Entao vejo o grafico de estados com mais sanções


Cenário: Entrar na pagina de estatisticas as opções de estatisticas

Dado que estou na index na welcome
Quando eu clico no link "Estatisticas"
Então eu sou redirecionado ao quadro de estatisticas
Quando eu clico no link "Estados com mais sanções"
Então eu vejo o texto "Este gráfico ilustra quais tipo de sanções as empresas brasileiras mais sofreram de forma geral. Como também demonstra através de um filtro por estado, qual o tipo de sanção mais ocorreu em cada uma das unidades federativas do Brasil. "
E " Este ranking possui informações sobre as empresas que mais receberam sanções desde 1988, separando-as por grupos de número de sanções"
E " Este gráfico ilustra quais tipos de sanções as empresas brasileiras mais sofreram de forma geral. São elas: suspensão temporária, declaração de inidoneidade, impedimento de licitar e contratar, proibição de participar de licitações e de contratar. Esta estatística também demonstra através de um filtro por estado, qual o tipo de sanção mais ocorreu em cada uma das unidades federativas do Brasil."
