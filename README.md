# CocoaHeads Brasil 🇧🇷

## Quem Somos
CocoaHeads é um grupo formado por desenvolvedores (profissionais e iniciantes), que se organizam para reunir pessoas com a mesma paixão: Programação para os iDevices da Apple (OSX e iOS). Nossos encontros são informais e servem para juntar pessoas que gostam do mesmo assunto que você [programação! :) ]. Promovemos Talks e Palestras dadas por membros do grupo local ou de convidados especiais. Estamos também presentes no Slack, [http://iosdevbr.herokuapp.com](http://iosdevbr.herokuapp.com), onde temos diversas iniciativas como a criação do aplicativo da comunidade, área de #code-help, uma sessão para divulgação de empregos no canal #jobs, falamos também sobre #design e #ux de aplicações além de ter o podcast da comunidade!\


======================

DESCRIÇÃO DOS BRANCHES
- master -> Somente as versões de produção numeradas por tags (0.1, 1.0.0, 1.2, etc.). 
- dev -> Branch principal de desenvolvimento. Este é o branch mais ativo e todo push deve ser feito nele. Todos os participantes podem dar commit neste branch.

============================================================
FLUXO DE COMMITS DO BRANCH DEV
============================================================

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

