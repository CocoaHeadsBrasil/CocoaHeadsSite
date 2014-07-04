[ ![Codeship Status for logics/CocoaHeadsBRWeb](https://www.codeship.io/projects/c1268530-e5ca-0131-e1ff-367b462184ed/status)](https://www.codeship.io/projects/25786)

CocoaHeads Brasil Web
======================

Projeto Web do CocoaHeads Brasil

DESCRIÇÃO DOS BRANCHES
- master -> Somente as versões de produção numeradas por tags (0.1, 1.0.0, 1.2, etc.). Apenas o gerente do projeto deve dar commit neste branch.
- dev -> Branch principal de desenvolvimento. Este é o branch mais ativo e todo push deve ser feito nele. Todos os participantes podem dar commit neste branch.
- feature-* -> Prefixo de branches para o desenvolvimento de novos recursos. Podem ser criados livremente e devem ser excluidos ao dar merge com o branch dev.
- release-* -> Prefixo de branches destinados a micro alterações antes da publicação no branch master.
- hotfix-* -> Prefixo de branches destinados a correções urgentes sem precisar passar pelo branch dev.

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

============================================================
FLUXO DE COMMITS DOS BRANCHES RELEASE-*
============================================================

1. Pegue a versão mais recente do projeto direto do branch DEV
```
$ git checkout -b release-1.2 dev
```

2. Realize todas as modificações necessárias para mudar gerar a release, como mudar o número da versão, mudar assinaturas, número da build e tudo que for necessário.

3. Faça o commit final da versão
```
git commit -a -m "Nova versão 1.2"
```

4. Faça o merge com o branch MASTER
```
$ git checkout master
$ git merge --no-ff release-1.2
```

5. Insira a TAG apontando para este commit para facilitar a busca por versoes
```
$ git tag -a 1.2
```

6. Atualize o branch DEV
```
$ git checkout develop
$ git merge --no-ff release-1.2
```

7. Exclua o branch RELEASE-*
```
$ git branch -d release-1.2
```
============================================================
FLUXO DE COMMITS DOS BRANCHES HOTFIX-*
============================================================

1. Efetua o checkout direto do MASTER
```
$ git checkout -b hotfix-1.2.1 master
```

2. Trabalhe, trabalhe, CORRIJA O BUG... Teste. Se corrigido, ok, senão, REPITA.

3. Realize todas as modificações necessárias para mudar gerar a release, como mudar o número da versão, mudar assinaturas, número da build e tudo que for necessário.
```
$ git commit -a -m "Nova versão 1.2.1"
```
4. Faça o commit final
```
$ git commit -m "Correção de bug emergencial na versão de produção"
```

5. Faça o merge com o MASTER e crie a tag da nova versão
```
$ git checkout master
$ git merge --no-ff hotfix-1.2.1
$ git tag -a 1.2.1
```

6. Faça o merge de volta para o DEV para que outros tenham acesso a versão corrigida
```
$ git checkout dev
$ git merge --no-ff hotfix-1.2.1
```

7. Exclua o branch HOTFIX-*
```
$ git branch -d hotfix-1.2.1
```
