/* 5 – Faça um SELECT na tabela SB1 que retorne todos os produtos cadastrados e  presente os códigos e descrições de todos em uma mensagem. Mas atenção, os itens devem ser apresentados em ordem de descrição decrescente (Z-A) */

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
        cDesc += "Descrição: " + &(cAlias)->(B1_DESC) + CRLF
        &(cAlias)->(DbSkip())
    End

    FwAlertInfo(cDesc, "Produtos Decrescente")

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
