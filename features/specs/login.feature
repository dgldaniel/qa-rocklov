# language: pt

Funcionalidade: Login
  Sendo um usuário cadastrado
  Quero acessar o sistema da RockLov
  Para que eu possa anunicar meus equipamentos musicais

  @temp
  Cenario: Login do usuário
    Dado que acesso a página principal
    Quando submeto minhas credenciais com "danieldouglas26@gmail.com" e "pwd123"
    Então sou redirecionado para o Dashboard

  Esquema do Cenario: Tentar logar
    Dado que acesso a página principal
    Quando submeto minhas credenciais com "<email_input>" e "<senha_input>"
    Então vejo a mensagem de alerta: "<mensagem_output>"

    Exemplos:
      | email_input                  | senha_input | mensagem_output                  |
      | danieldouglas26@gmail.com    | pwd1234     | Usuário e/ou senha inválidos.    |
      | danieldouglas26@gmail.com.br | pwd123      | Usuário e/ou senha inválidos.    |
      | danieldouglas26&gmail.com    | pwd123      | Oops. Informe um email válido!   |
      | danieldouglas26@gmail.com    |             | Oops. Informe sua senha secreta! |