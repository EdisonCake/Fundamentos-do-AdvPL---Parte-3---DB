/* 3 - Faça uma consulta na tabela SC5 que retorne todos os produtos do pedido “PV0008” e apresente os seguintes campos em uma mensagem: Código – Descrição – Qtd – Vl. Unit – Vl Total */

#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_03()
    // Declaração de Variáveis
    local aArea   := GetArea()
    local cAlias  := GetNextAlias()
    local cDesc   := ""
    local cQuery  := ""

    // Aqui é preparado o ambiente com base na empresa, filial, tabela e módulo escolhidos.
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC5' MODULO 'FAT'
    
    // Aqui é passada a consulta do banco de dados que queremos para uma variável auxiliar.
    cQuery := "SELECT PV.C5_NUM, PDV.C6_PRODUTO, PDV.C6_DESCRI, PDV.C6_QTDVEN, PDV.C6_PRCVEN, PDV.C6_VALOR FROM " + RetSqlName('SC5') + " PV INNER JOIN " + RetSqlName('SC6') + " PDV ON PV.C5_NUM = PDV.C6_NUM WHERE C5_NUM = 'PV0008' AND PV.D_E_L_E_T_ = ' '"

    // E aqui, a mesma é realizada no banco de dados e é posicionado o ponteiro no topo da tabela.
    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    // Enquanto o ponteiro não chegar no final da tabela, é concatenada a informação que será exibida no final.
    While &(cAlias)->(!EOF())

        cDesc += "Código: " + &(cAlias)->(C6_PRODUTO) +;
                 " // Descrição: " + cvaltochar(&(cAlias)->(C6_DESCRI)) +;
                 " // QTD.: " + cvaltochar(&(cAlias)->(C6_QTDVEN)) +;
                 " // Vl.Unit R$ " + cvaltochar(&(cAlias)->(C6_PRCVEN)) +;
                 " // Vl.Total R$ " + cvaltochar(&(cAlias)->(C6_VALOR)) + CRLF + CRLF
        &(cAlias)->(DbSkip())
    End

    // Por fim, é exibido ao usuário o resultado da consulta.
    FwAlertInfo(cDesc, "Produtos no PV0008")

    // Nesse bloco a área da tabela é fechada, e a área restaurada.
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
