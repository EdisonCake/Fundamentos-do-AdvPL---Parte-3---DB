#INCLUDE 'TOTVS.CH'

User Function ZZGRP()
    // Declara��o de vari�veis.
    local cMsg := ""

    // Se a vari�vel de mem�ria com ponteiro no campo indicado for igual � informa��o da condi��o, ser� adicionado na vari�vel uma informa��o.
    if M->B1_TIPO == "PA"

        cMsg := "PRODUTO PARA COMERCIALIZACAO"

    elseif M->B1_TIPO == "MP"

        cMsg := "MATERIA PRIMA PRODUCAO"
        
    else    

        cMsg := "OUTROS PRODUTOS"

    endif

// Por fim, a fun��o retorna a vari�vel de texto no campo informado dentro do Protheus.
Return cMsg
