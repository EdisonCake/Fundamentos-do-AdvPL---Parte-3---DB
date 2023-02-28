/* 3 - Fa�a uma consulta na tabela SC5 que retorne todos os produtos do pedido �PV0008� e apresente os seguintes campos em uma mensagem: C�digo � Descri��o � Qtd � Vl. Unit � Vl Total */

#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_03()
    // Declara��o de Vari�veis
    local aArea   := GetArea()
    local cAlias  := GetNextAlias()
    local cDesc   := ""
    local cQuery  := ""

    // Aqui � preparado o ambiente com base na empresa, filial, tabela e m�dulo escolhidos.
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC5' MODULO 'FAT'
    
    // Aqui � passada a consulta do banco de dados que queremos para uma vari�vel auxiliar.
    cQuery := "SELECT PV.C5_NUM, PDV.C6_PRODUTO, PDV.C6_DESCRI, PDV.C6_QTDVEN, PDV.C6_PRCVEN, PDV.C6_VALOR FROM " + RetSqlName('SC5') + " PV INNER JOIN " + RetSqlName('SC6') + " PDV ON PV.C5_NUM = PDV.C6_NUM WHERE C5_NUM = 'PV0008' AND PV.D_E_L_E_T_ = ' '"

    // E aqui, a mesma � realizada no banco de dados e � posicionado o ponteiro no topo da tabela.
    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    // Enquanto o ponteiro n�o chegar no final da tabela, � concatenada a informa��o que ser� exibida no final.
    While &(cAlias)->(!EOF())

        cDesc += "C�digo: " + &(cAlias)->(C6_PRODUTO) +;
                 " // Descri��o: " + cvaltochar(&(cAlias)->(C6_DESCRI)) +;
                 " // QTD.: " + cvaltochar(&(cAlias)->(C6_QTDVEN)) +;
                 " // Vl.Unit R$ " + cvaltochar(&(cAlias)->(C6_PRCVEN)) +;
                 " // Vl.Total R$ " + cvaltochar(&(cAlias)->(C6_VALOR)) + CRLF + CRLF
        &(cAlias)->(DbSkip())
    End

    // Por fim, � exibido ao usu�rio o resultado da consulta.
    FwAlertInfo(cDesc, "Produtos no PV0008")

    // Nesse bloco a �rea da tabela � fechada, e a �rea restaurada.
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
