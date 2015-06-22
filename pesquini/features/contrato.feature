#language: pt

Funcionalidade: Verificar se a empresa foi contratada após sofrer sanção.

Cenário: Acessar empresa  

Dado que a empresa samsung exista
Dado que eu clico no nome da empresa
Então eu vejo o texto "Contrato pós Sanção? : "
