#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_10()
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery    := ""
    local cPesquisa := ""
    local nMedia    := 0
    local nCount    := 0
    local nVolta    := 0

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

    cPesquisa := FwInputBox("Digite o produto a ser pesquisado: ")

    cQuery := "SELECT * FROM " + RetSqlName('SB1') + " PROD INNER JOIN " + RetSqlName('SC6') + " PEDV ON PROD.B1_COD = PEDV.C6_PRODUTO WHERE PROD.B1_COD = '" + cPesquisa + "'"

    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    While &(cAlias)->(!EOF())
        if cPesquisa == alltrim(&(cAlias)->(B1_COD))
            nVolta++
            nCount += &(cAlias)->(C6_QTDVEN)
            &(cAlias)->(DbSkip())
        else
            &(cAlias)->(DbSkip())
        endif
    End

    if nVolta = 0
        FwAlertError("O produto não existe ou nunca foi vendido.")
    else
        nMedia := (nCount / nVolta)
        FwAlertInfo("Há uma média de " + cvaltochar(round(nMedia, 0)) + " unidade(s) desse produto dentre os pedidos de venda.", "Média de Venda")
    endif

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
