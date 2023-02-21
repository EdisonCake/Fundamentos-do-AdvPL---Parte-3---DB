/* 5 � Fa�a um SELECT na tabela SB1 que retorne todos os produtos cadastrados e  presente os c�digos e descri��es de todos em uma mensagem. Mas aten��o, os itens devem ser apresentados em ordem de descri��o decrescente (Z-A) */

#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_05()
    local aArea   := GetArea()
    local cAlias  := GetNextAlias()
    local cDesc   := ""
    local cQuery  := ""
    
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

    cQuery := "SELECT * FROM " + RetSqlName('SB1') + " ORDER BY B1_DESC DESC"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())

    While &(cAlias)->(!EOF())
        cDesc += "Descri��o: " + &(cAlias)->(B1_DESC) + CRLF
        &(cAlias)->(DbSkip())
    End

    FwAlertInfo(cDesc, "Produtos Decrescente")

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
