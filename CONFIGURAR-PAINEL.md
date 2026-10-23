# Configurar o painel de pedidos

O painel `admin.html` usa o Supabase para manter os pedidos online entre o site do cliente e o aparelho da pastelaria. O pedido continua abrindo uma conversa no WhatsApp.

1. Crie um projeto Supabase em supabase.com e escolha a região mais próxima.
2. No projeto, abra **SQL Editor**, crie uma consulta, cole o arquivo `supabase-setup.sql` e execute.
3. Em **Project Settings > API**, copie a **Project URL** e a chave **anon/public**. Não use `service_role`.
4. Cole esses dois valores no arquivo `supabase-config.js`.
5. Em **Authentication > Users**, crie o usuário (e-mail e senha) para a pastelaria. Em **Authentication > Providers/Sign-in**, desative a criação pública de novas contas.
6. Publique novamente os arquivos do site. A equipe acessa `admin.html` e entra com o usuário criado.

O cliente acompanha o andamento na própria página após enviar o pedido; o status é consultado com um token privado e atualizado periodicamente. Se você já havia executado o SQL antigo, execute novamente o arquivo atualizado para criar o token e a função de consulta. O painel atualiza pedidos a cada 20 segundos e permite confirmar/desfazer pagamento, mudar status (novo, preparando, pronto, saiu para entrega, concluído ou cancelado) e abrir WhatsApp do cliente. Confirmação Pix é manual: confira o recebimento no banco antes de confirmar. A chave anon/public pode ficar no site; a chave `service_role` nunca deve ser exposta.

Sem preencher o Supabase, o site continua aceitando pedidos pelo fluxo de WhatsApp, mas eles não aparecem automaticamente no painel.


