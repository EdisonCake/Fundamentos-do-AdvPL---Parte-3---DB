#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'parmtype.ch'
#INCLUDE 'TOPCONN.CH'

User Function ZZGRP()
    local aArea   := GetArea()

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

    DbSelectArea('SB1')
    DbSetOrder(1)
    // DbSeek(xFilial('SB1') + '1')

    if SB1->(B1_TIPO) == "PA"

        SB1->(B1_ZZGRP) := "PRODUTO PARA COMERCIALIZACAO"

    elseif SB1->(B1_TIPO) == "MP"

        SB1->(B1_ZZGRP) := "MATERIA PRIMA PRODUCAO"
        
    else    

        SB1->(B1_ZZGRP) := "OUTROS PRODUTOS"
    endif

    DbCloseArea()
    RestArea(aArea)

Return 
