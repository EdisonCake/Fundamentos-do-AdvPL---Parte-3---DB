#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_08()
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery    := ""
    local cDesc     := ""
    
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC5' MODULO 'COM'

    cQuery := "SELECT TOP 1 C6_NUM, C6_DESCRI, C6_PRODUTO, C6_VALOR FROM " + RetSqlName('SC6') + " ORDER BY C6_VALOR DESC"

    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    While &(cAlias)->(!EOF())
        cDesc += "Pedido: " + &(cAlias)->(C6_NUM) + CRLF +;
                 "Código do Produto: " + &(cAlias)->(C6_DESCRI) + CRLF +;
                 "Descrição: " + &(cAlias)->(C6_PRODUTO) + CRLF +;
                 "Valor Total: R$ " + cvaltochar(&(cAlias)->(C6_VALOR))
        &(cAlias)->(DbSkip())
    End

    FwAlertInfo(cDesc, "Maior Valor")

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
