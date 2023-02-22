#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_08()
    // Declara��o de vari�veis.
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery    := ""
    local cDesc     := ""
    
    //Aqui � preparado o ambiente com base na empresa, filial, tabela e m�dulo.
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC5' MODULO 'COM'

    // Aqui � feita a pesquisa com base no primeiro resultado exibido da ordena��o decrescente de valor.
    cQuery := "SELECT TOP 1 C6_NUM, C6_DESCRI, C6_PRODUTO, C6_VALOR FROM " + RetSqlName('SC6') + " WHERE D_E_L_E_T_ = ' ' ORDER BY C6_VALOR DESC"

    // Aqui a consulta � feita e o ponteiro posicionado no in�cio da tabela.
    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    // Enquanto o ponteiro n�o chegar no final, � feito o registro na vari�vel correspondente.
    While &(cAlias)->(!EOF())
        cDesc += "Pedido: " + &(cAlias)->(C6_NUM) + CRLF +;
                 "C�digo do Produto: " + &(cAlias)->(C6_DESCRI) + CRLF +;
                 "Descri��o: " + &(cAlias)->(C6_PRODUTO) + CRLF +;
                 "Valor Total: R$ " + cvaltochar(&(cAlias)->(C6_VALOR))
        &(cAlias)->(DbSkip())
    End

    // Por fim, � exibido ao usu�rio a informa��o do maior valor solicitado pelo usu�rio.
    FwAlertInfo(cDesc, "Maior Valor")

    //Aqui a tabela � fechada e a �rea restaurada.
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
