CocoaHeads Brasil Web
======================

Projeto Web do CocoaHeads Brasil

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

