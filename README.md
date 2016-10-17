# CocoaHeads Brasil 🇧🇷

## Quem Somos

CocoaHeads é um grupo formado por desenvolvedores (profissionais e iniciantes), que se organizam para reunir pessoas com a mesma paixão: Programação para os iDevices da Apple (macOS, iOS, tvOS e WatchOS). Nossos encontros são informais e servem para juntar pessoas que gostam do mesmo assunto que você [programação! :) ]. Promovemos Talks e Palestras dadas por membros do grupo local ou de convidados especiais. Estamos também presentes no Slack, [http://iosdevbr.herokuapp.com](http://iosdevbr.herokuapp.com), onde temos diversas iniciativas como a criação do aplicativo da comunidade, área de #code-help, uma sessão para divulgação de empregos no canal #jobs, falamos também sobre #design e #ux de aplicações além de ter o podcast da comunidade!

## DESCRIÇÃO DOS BRANCHES

- master -> Somente as versões de produção numeradas por tags (0.1, 1.0.0, 1.2, etc.). 
- dev -> Branch principal de desenvolvimento. Este é o branch mais ativo e todo push deve ser feito nele. Todos os participantes podem dar commit neste branch.

## FLUXO DE COMMITS DO BRANCH DEV

1. Ao trabalhar em uma novo recurso, faça o checkout a partir do branch DEV
```
$ git checkout -b recurso-nomeDoRecurso dev
```

2. Trabalhe, trabalhe, trabalhe, commit... Trabalhe, trabalhe, trabalhe, commit...
Terminou o recurso, testou, hora de devolver o código de volta para o branch DEV
```
$ git checkout dev
```

3. Dê o merge do DEV com seu branch
```
$ git merge --no-ff recurso-nomeDoRecurso
```

4. Exclua seu branch
```
$ git branch -d recurso-nomeDoRecurso
```

5. Suba as modificações para o repositório na nuvem para que outros desenvolvedores do projeto tenham acesso à suas modificações
```
$ git push origin dev
```


## CONFIGURAÇÃO E EXECUÇÃO

Para ajudar na configuração e execução dos ambientes, foram criados 2 scripts de execução:

#### Development Fresh Run

```
$ ./development_fresh_run.sh
```

Esse script irá: 

* Instalar todas as dependências necessárias
* Começar um servidor postgres
* Criar os usuários necessários para o ambiente de desenvolvimento
* Criar os bancos de dados de desenvolvimento
* Configurar os bancos de desenvolvimento
* Incluir os dados de desenvolvimento
* Rodar um servidor local

Esse script só precisa ser executado 1 vez quando o projeto é clonado, ou quando você quiser uma nova instância dos banco de dados de desenvolvimento.

#### Run server

```
$ ./run_server.sh
```

Esse script irá:

* Começar um servidor postgres
* Rodar um servidor local

Esse script só existe para garantir que o servidor postgres está executando antes de criar um servidor na máquina local
