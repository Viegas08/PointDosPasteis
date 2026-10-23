# Como funcionam pedidos, entrega e pagamento

- Entrega: taxa fixa de R$ 5,00; o cliente informa rua, número e bairro.
- Retirada: sem taxa.
- Pagamentos: dinheiro, Pix ou cartão. Para entrega com cartão, o entregador leva a maquininha.
- O QR Code e o código Pix são montados no navegador com o total do pedido. Para ativar, preencha `PIX_CONFIG` em `index.html` com a chave Pix, o nome do recebedor e a cidade. O site não confirma automaticamente que o Pix foi recebido; a equipe deve conferir o pagamento.

O gerador de QR Code usado pelo site é carregado do cdnjs, então o navegador precisa estar conectado à internet para exibir o QR.