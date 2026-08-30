# MBN PDV compartilhado

PDV web estático para uso em celular, computador e outros dispositivos, com **uma única conta de acesso** e dados compartilhados pelo Supabase.

## 1. Configurar o Supabase

1. Abra o projeto correto no Supabase: https://supabase.com/dashboard/project/bcyyjdglhmxhskwwcrdb/sql/new
2. Abra o arquivo `supabase-pdv.sql` no SQL Editor.
3. Execute todo o conteúdo.
4. Em Authentication > Users, crie uma única conta para a equipe. Use o mesmo e-mail e senha em todos os dispositivos.

O navegador usa apenas a chave pública do projeto. Não substitua essa chave por uma chave `service_role`.

## 2. Publicar no GitHub

1. Crie um repositório vazio no GitHub.
2. Envie todos os arquivos desta pasta para o repositório.
3. Mantenha `index.html`, `supabase-pdv.sql`, `vercel.json`, `logo-mbn.png` e este README na raiz.

## 3. Publicar na Vercel

1. Em https://vercel.com, escolha **Add New Project**.
2. Importe o repositório do GitHub.
3. Use as configurações padrão para um site estático e publique.
4. Compartilhe o endereço da Vercel com a equipe.

## Uso compartilhado

- Entre com a mesma conta em todos os dispositivos.
- As alterações são salvas no Supabase e sincronizadas entre dispositivos conectados.
- O painel de notificações mostra estoque baixo, pagamentos pendentes e vendas recentes.
- Se um dispositivo ficar offline, ele mantém os dados localmente e tenta sincronizar quando voltar à internet.

## Estrutura

- `index.html`: aplicação completa do PDV.
- `config.js`: endereço e chave pública do Supabase.
- `logo-mbn.png`: logo oficial MBN.
- `supabase-pdv.sql`: tabela, políticas RLS, permissões e Realtime.
- `vercel.json`: configuração de publicação.

## Alterar os dados do Supabase

Abra `config.js` e altere somente estes dois valores:

```js
window.PDV_CONFIG = {
  supabaseUrl: 'https://SEU-PROJETO.supabase.co',
  supabaseAnonKey: 'SUA_CHAVE_PUBLICA'
};
```

Use a chave **publishable** ou **anon public**. Nunca coloque a chave `service_role` nesse arquivo. Depois, envie o `config.js` atualizado junto com o `index.html` para o GitHub e faça um novo deploy na Vercel.
