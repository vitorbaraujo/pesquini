#language: pt

Funcionalidade: Visualizar ranking das empresas que mais receberam pagamentos do governo.

Cenario: Visualizar o ranking com as 10 empresas que mais receberam pagamentos.

Ao usuario acessar a pagina de estatisticas e selecionar a opçao "Empresas com o maior numero de pagamentos", o sistema deve mostrar um ranking com as 10 empresas que mais receberam pagamentos do governo.

Dado que eu estou na pagina inicial da aplicaçao
Dado que eu visitei a pagina de estatisticas
Quando eu clico no icone "Clique aqui para ser redirecionado para a página ..." referente a Empresas que mais receberam pagamentos
Entao vejo o ranking das 10 empresas que mais receberam pagamentos

Cenario: Visualizar o ranking de todas as sançoes atraves de um botao.

Dado que eu estou na página do ranking das empresas que mais receberam pagamentos
Quando eu clico no link "Todas".
Então eu devo visualizar o ranking de todas as empresas que mais receberam pagamentos
