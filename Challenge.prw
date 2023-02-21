#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function Chall03()
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery    := ""

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

    cQuery := "SELECT B1_FILIAL, B1_COD, B1_TIPO, B1_ZZGRP FROM " + RetSqlName('SB1') + " WHERE B1_ZZGRP = ' ' AND D_E_L_E_T_ = ' '"

    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    While &(cAlias)->(!EOF())

        if &(cAlias)->(B1_TIPO) == "PA"
            cMsg := "PRODUTO PARA COMERCIALIZACAO"
        elseif &(cAlias)->(B1_TIPO) == "MP"
            cMsg := "MATERIA PRIMA PRODUCAO"
        else
            cMsg := "OUTROS PRODUTOS"
        endif

        DbSelectArea("SB1")
        DbSetOrder(1)

        If DbSeek(&(cAlias)->(B1_FILIAL) + &(cAlias)->(B1_COD))

            RecLock("SB1", .F.)
            SB1->B1_ZZGRP := cMsg
            MsUnlock()
        endif

        &(cAlias)->(DBSKIP())
    End While

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)
Return 
