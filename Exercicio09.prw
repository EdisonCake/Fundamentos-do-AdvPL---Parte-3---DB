#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_09()
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery    := ""
    local cDesc     := ""
    local cPesquisa := ""
    
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC6' MODULO 'COM'

    cPesquisa := FwInputBox("Digite o código a ser pesquisado:", cPesquisa)

    cQuery := "SELECT PED.C5_NUM, PROD.C6_PRODUTO FROM " + RetSqlName('SC6') + " PROD INNER JOIN " + RetSqlName('SC5') + " PED ON PROD.C6_NUM = PED.C5_NUM WHERE PROD.C6_PRODUTO = '" + cPesquisa + "'"

    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    While &(cAlias)->(!EOF())

        cDesc += alltrim(&(cAlias)->(C5_NUM)) + ", "

        &(cAlias)->(DbSkip())
    End

    FwAlertInfo("O produto pesquisado se encontra nos pedidos:" + CRLF +;
                cDesc, "Pesquisa de Produto")

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
