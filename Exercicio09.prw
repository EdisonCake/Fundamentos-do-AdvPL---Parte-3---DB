#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_09()
    // Declara��o de vari�veis.
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery    := ""
    local cDesc     := ""
    local cPesquisa := ""
    
    // Aqui � preparado o ambiente com base na empresa, filial, tabela e m�dulo referentes.
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC6' MODULO 'COM'

    // Aqui � solicitado ao usu�rio qual o c�digo de produto a ser pesquisado.
    cPesquisa := FwInputBox("Digite o c�digo a ser pesquisado:", cPesquisa)

    // Aqui � passada a informa��o ao c�digo da pesquisa a ser realizada no banco de dados.
    cQuery := "SELECT PED.C5_NUM, PROD.C6_PRODUTO FROM " + RetSqlName('SC6') + " PROD INNER JOIN " + RetSqlName('SC5') + " PED ON PROD.C6_NUM = PED.C5_NUM WHERE PROD.C6_PRODUTO = '" + cPesquisa + "' AND PROD.D_E_L_E_T_ = ' '"

    // E aqui � feita a pesquisa, posicionando, em seguida, o ponteiro no topo da tabela.
    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    // Enquanto o ponteiro n�o atingir o final da tabela, ser� concatenado o n�mero do pedido com um separador de v�rgula.
    While &(cAlias)->(!EOF())

        cDesc += alltrim(&(cAlias)->(C5_NUM)) + ", "       
        &(cAlias)->(DbSkip())

    End

    // Ao final, ser� exibido ao usu�rio a informa��o solicitada, por�m, utilizando uma fun��o STUFF() que substituir� a �ltima v�rgula por um ponto final.
    FwAlertInfo("O produto pesquisado se encontra nos pedidos:" + CRLF +;
                stuff(cDesc, len(cDesc) - 1, 2, ".") , "Pesquisa de Produto")

    // Aqui a tabela � fechada e a �rea restaurada.
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
