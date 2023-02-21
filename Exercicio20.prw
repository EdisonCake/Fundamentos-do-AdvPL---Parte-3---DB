#INCLUDE 'TOTVS.CH'

User Function ZZGRP()
    local cMsg := ""

    if M->B1_TIPO == "PA"

        cMsg := "PRODUTO PARA COMERCIALIZACAO"

    elseif M->B1_TIPO == "MP"

        cMsg := "MATERIA PRIMA PRODUCAO"
        
    else    

        cMsg := "OUTROS PRODUTOS"

    endif

Return cMsg
