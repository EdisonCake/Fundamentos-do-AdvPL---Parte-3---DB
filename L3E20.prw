#INCLUDE 'TOTVS.CH'

User Function ZZGRP()
    // Declaração de variáveis.
    local cMsg := ""

    // Se a variável de memória com ponteiro no campo indicado for igual à informação da condição, será adicionado na variável uma informação.
    if M->B1_TIPO == "PA"

        cMsg := "PRODUTO PARA COMERCIALIZACAO"

    elseif M->B1_TIPO == "MP"

        cMsg := "MATERIA PRIMA PRODUCAO"
        
    else    

        cMsg := "OUTROS PRODUTOS"

    endif

// Por fim, a função retorna a variável de texto no campo informado dentro do Protheus.
Return cMsg
