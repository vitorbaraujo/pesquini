#language: pt

Funcionalidade: Efetuar o login

Cenário: Abrir pagina de login

Dado que um login exista
Dado que eu estou na pagina "/signin"
Quando eu clico no botão "Sign in"
Então eu sou redirecionado para a Homepage
