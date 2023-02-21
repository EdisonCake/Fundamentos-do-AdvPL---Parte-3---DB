/* 3 - Faça uma consulta na tabela SC5 que retorne todos os produtos do pedido “PV0008” e apresente os seguintes campos em uma mensagem: Código – Descrição – Qtd – Vl. Unit – Vl Total */

#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_03()
    local aArea   := GetArea()
    local cAlias  := GetNextAlias()
    local cDesc   := ""
    local cQuery  := ""

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC5' MODULO 'FAT'

    cQuery := "SELECT PV.C5_NUM, PDV.C6_PRODUTO, PDV.C6_DESCRI, PDV.C6_QTDVEN, PDV.C6_PRCVEN, PDV.C6_VALOR FROM " + RetSqlName('SC5') + " PV INNER JOIN " + RetSqlName('SC6') + " PDV ON PV.C5_NUM = PDV.C6_NUM WHERE C5_NUM = 'PV0008'"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())

    While &(cAlias)->(!EOF())

        cDesc += "Código: " + &(cAlias)->(C6_PRODUTO) +;
                 " / Descrição: " + cvaltochar(&(cAlias)->(C6_DESCRI)) +;
                 " / QTD.: " + cvaltochar(&(cAlias)->(C6_QTDVEN)) +;
                 " / Vl.Unit R$ " + cvaltochar(&(cAlias)->(C6_PRCVEN)) +;
                 " / Vl.Total R$ " + cvaltochar(&(cAlias)->(C6_VALOR)) + CRLF + CRLF
        &(cAlias)->(DbSkip())
    End

    FwAlertInfo(cDesc, "Produtos no PV0008")

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
