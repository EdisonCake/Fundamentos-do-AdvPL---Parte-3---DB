#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_09()
    // Declaração de variáveis.
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery    := ""
    local cDesc     := ""
    local cPesquisa := ""
    
    // Aqui é preparado o ambiente com base na empresa, filial, tabela e módulo referentes.
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC6' MODULO 'COM'

    // Aqui é solicitado ao usuário qual o código de produto a ser pesquisado.
    cPesquisa := FwInputBox("Digite o código a ser pesquisado:", cPesquisa)

    // Aqui é passada a informação ao código da pesquisa a ser realizada no banco de dados.
    cQuery := "SELECT PED.C5_NUM, PROD.C6_PRODUTO FROM " + RetSqlName('SC6') + " PROD INNER JOIN " + RetSqlName('SC5') + " PED ON PROD.C6_NUM = PED.C5_NUM WHERE PROD.C6_PRODUTO = '" + cPesquisa + "' AND PROD.D_E_L_E_T_ = ' '"

    // E aqui é feita a pesquisa, posicionando, em seguida, o ponteiro no topo da tabela.
    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    // Enquanto o ponteiro não atingir o final da tabela, será concatenado o número do pedido com um separador de vírgula.
    While &(cAlias)->(!EOF())

        cDesc += alltrim(&(cAlias)->(C5_NUM)) + ", "       
        &(cAlias)->(DbSkip())

    End

    // Ao final, será exibido ao usuário a informação solicitada, porém, utilizando uma função STUFF() que substituirá a última vírgula por um ponto final.
    FwAlertInfo("O produto pesquisado se encontra nos pedidos:" + CRLF +;
                stuff(cDesc, len(cDesc) - 1, 2, ".") , "Pesquisa de Produto")

    // Aqui a tabela é fechada e a área restaurada.
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
