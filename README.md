# FlutTask
## Introdução 
Um aplicativo de lista de tarefas feito em Flutter.

Este aplicativo permite registrar usuários e salvar tarefas. Um usuário já registrado pode logar e carregar suas taredas, podendo criar novas e edita-as.

## Cronograma
Este aplicativo foi desenvolvido em quatro noites. A primeira serviu para a criação do projeto como um todo, com os modelos, páginas e controladores, mas nada funcional.

A segunda noite serviu para deixar as tarefas e parte do registro funcional, já com criação, edição, conclusão e deleção de tarefas funcionais. Além disso, também foi possível começar o formulário de registro de usuário.
 
A terceira foi para terminar o registro do usuário, validar CPF, buscar uma API para cep e trabalhar com a persistência de dados no SQFLite.
  
A útlima foi para refatoração, atualização da interface para algo mais agradável e documentação.

## Páginas
### Login
O login é a página inicial do aplicativo. O usuário pode navegar para a página de registro ou tentar fazer o login. Caso o usuário entre com credenciais válidas, o mesmo será redirecionado para a página onde são listadas as tarefas.

### Formulário de registro de usuário
O usuário precisa passar seu nome, data de nascimento, e-mail e senha, esses são os campos obrigatório. **É preciso ter pelo menos 12 anos para poder criar uma conta**. É possível registrar mais informações, como CPF, CEP, endereço e número. O CPF e o CEP possuem uma forma de validação. Após o registro, o login é efetuado e o usuário é redirecionado para a página das tarefas.

### Listagem de tarefas
Nela é possível criar novas ou editar, concluir ou excluir as existentes. As ações de deleção e conclusão exigem confimação do usuário. A edição e a criação de tarefas são feitas na página de formulário de tarefas.

### Formulário de tarefas
Essa página é responsável pela edição e a criação de tarefas. Possui os campos nome e data de entrega, que são obrigatórios. Também é possível passar data de conclusão e descrição.

## Arquitetura
### Pacotes principais
A arquitetura MVC com repositório foi utilizada neste projeto. O pacote `GetX` foi o responsável pela injeção de dependêncidas, roteamento e gerência de estados, o `Dio` foi utilizado para fazer a consulta a rota de CEP, e o `SQFLite` serviu para utilização de banco de dados do Android. 

### *Models*
Os modelos são representações dos dados que serão armazenados em disco. São imutáveis e, quando preciso, possuem o padrão `copyWith`, para facilitar a alteração em conjunto com a biblioteca reativa do `GetX`.

### *Views*
As views são compostas principalmente de formulários, seja para login, registro de usuário ou tarefa. Apenas a listagem de tarefas não é um formulário. São separadas entre páginas e widgets, e cada uma foi dividida para focar apenas do dado ou controlador que está trabalhando.


### *Controllers*
Os controladores possuem os estados mais importantes do aplicativo, que são a autenticação e a lista de tarefas. Cada controlador implementa a classe `GetXController`, que precisa ser utilizada em par com o widget `Obx` para que a interface seja notificada de cada alteração. Vale lembrar que cada valor que varia é, na verdade, uma `Stream` de dados, facilitada pelos `observers` da biblioteca `GetX`.

## Instalação
Você precisará do Flutter configurado em seu computador para poder executar este aplicativo, tal configuração está fora do escopo dessa documentação. Caso isso ainda seja necessário, procure no guia de instalação oficial, neste [link](https://flutter.dev/docs/get-started/install).

Com tudo do Flutter correto, execute cada um dos comandos abaixo em sequência:
```sh
    git clone https://github.com/sthefanoss/fluttask.git
```
```sh
    cd fluttask
```
```sh
    flutter pub get
```
```sh
    flutter build apk --debug
```
```sh
    flutter run --debug
```

