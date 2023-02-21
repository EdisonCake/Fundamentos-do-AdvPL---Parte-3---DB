/* 2 – Faça uma consulta na tabela SC5 para retornar todos os pedidos de Venda em que o “número da nota” (C5_NOTA) não foi preenchido. Apresente em uma mensagem quais são os números dos pedidos e o nome dos clientes. */

#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_02()
    local aArea   := GetArea()
    local cAlias  := GetNextAlias()
    local cDesc   := ""
    local cQuery  := ""

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC5' MODULO 'COM'

    cQuery := "SELECT PD.C5_NUM, PD.C5_CLIENT, CL.A1_NOME FROM " + RetSqlName('SC5') + " PD INNER JOIN " + RetSqlName('SA1') + " CL ON PD.C5_CLIENT = CL.A1_COD WHERE C5_NOTA = ' '"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())

    While &(cAlias)->(!EOF())
        cDesc += "Pedido : " + &(cAlias)->(C5_NUM) + " Nome: " + &(cAlias)->(A1_NOME) + CRLF
        &(cAlias)->(DbSkip())
    End

    FwAlertInfo(cDesc, "Pedidos sem número de nota.")

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
