/* 1 – Faça uma consulta na tabela SC7 para retornar todos os pedidos realizados para o fornecedor
“Super Cabos”. Apresente o resultado em uma função de mensagem com a seguinte estrutura:
Pedido 1: PC0001
Pedido 2: PC0002
... */

#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_01()
    local aArea   := GetArea()
    local cAlias  := GetNextAlias()
    local cDesc   := ""
    local cQuery  := ""
    local nCount  := 1

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC7' MODULO 'COM'

    cQuery := "SELECT DISTINCT C7_NUM FROM " + RetSqlName('SC7') + " WHERE C7_FORNECE = 'F00004' AND D_E_L_E_T_ = ' '"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())

    While &(cAlias)->(!EOF())
        cDesc += "Pedido " + cvaltochar(strzero(nCount, 2)) + ": " + &(cAlias)->(C7_NUM) + CRLF
        &(cAlias)->(DbSkip())
    End

    FwAlertInfo(cDesc, "Tabela de Pedidos")

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
