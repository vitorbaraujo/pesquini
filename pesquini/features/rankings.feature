#language: pt

Funcionalidade: Visualizar um ranking das empresas com mais sançoes
  Ao usuario entrar no sistema, ele podera selecionar o icone dos rankings para ser direcionado a parte do site que contem o link para a pagina dos rankings, ou descer ate chegar ate esta parte do site

Cenario: Visualizar os rankings

Ao usuário tentar clicar no icone ranking para ser direcionado a parte debaixo do site com o icone que direciona para a pagina dos rankings. Este ranking contara com as 10 empresas com mais sançoes e exibira os seguintes dados.

Dado que a empresa COOPERSEMO exista
Dado que uma sançao exista
Dado que eu visitei a pagina de rankings
Entao vejo o ranking das empresas com os dados, posiçao, nome e numero de sançoes
Dado que eu clico no nome da empresa
Entao vejo os dados das sançoes da mesma