 FlutTask

Um aplicativo de lista de tarefas feito em Flutter.


Este aplicativo permite registrar usuários e salvar tarefas. Um usuário já registrado pode logar e carregar suas taredas, podendo criar novas e edita-as.



## 1 - Login
O login é a página inicial do aplicativo. O usuário pode navegar para a página de registro ou tentar fazer o login. Caso o usuário entre com credenciais válidas, o mesmo será redirecionado para a página onde são listadas as tarefas.

## 2 - Formulário de Registro de Usuário
O usuário precisa passar seu nome, data de nascimento, e-mail e senha, esses são os campos obrigatório. **É preciso ter pelo menos 12 anos para poder criar uma conta**. É possível registrar mais informações, como CPF, CEP, endereço e número. O CPF e o CEP possuem uma forma de validação. Após o registro, o login é efetuado e o usuário é redirecionado para a página das tarefas.

## 3 Listagem de Tarefas
Nela é possível criar novas ou editar, concluir ou excluir as existentes. As ações de deleção e conclusão exigem confimação do usuário. A edição e a criação de tarefas são feitas na página de formulário de tarefas.

## 4 Formulário de Tarefas
Essa página é responsável pela edição e a criação de tarefas. Possui os campos nome e data de entrega, que são obrigatórios. Também é possível passar data de conclusão e descrição.