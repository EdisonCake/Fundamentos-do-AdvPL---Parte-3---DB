#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_10()
    // Declara��o de vari�veis.
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery    := ""
    local cPesquisa := ""
    local nMedia    := 0
    local nCount    := 0
    local nVolta    := 0

    // Prepara��o de ambiente.
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

    // Aqui � solicitado ao usu�rio qual o produto a ser pesquisado.
    cPesquisa := FwInputBox("Digite o produto a ser pesquisado: ")

    // Aqui a informa��o do usu�rio � inclusa na pesquisa a ser realizada no banco de dados.
    cQuery := "SELECT * FROM " + RetSqlName('SB1') + " PROD INNER JOIN " + RetSqlName('SC6') + " PEDV ON PROD.B1_COD = PEDV.C6_PRODUTO WHERE PROD.B1_COD = '" + cPesquisa + "' AND PROD.D_E_L_E_T_ = ' '"  
    
    // Aqui, a pesquisa � feita, e o ponteiro posicionado no topo da tabela.
    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    // Enquanto o ponteiro n�o chegar o final da tabela, � realizado um bloco condicional em cada registro.
    While &(cAlias)->(!EOF())

        // Se o registro atual �  exatamente igual � pesquisa do usu�rio, � acrescido um contador e � somado o valor de um campo em outra vari�vel.
        if cPesquisa == alltrim(&(cAlias)->(B1_COD))
            nVolta++
            nCount += &(cAlias)->(C6_QTDVEN)
            &(cAlias)->(DbSkip())

        // Caso contr�rio, o registro � ignorado e � avan�ado para o pr�ximo.
        else
            &(cAlias)->(DbSkip())
        endif
    End

    // Por fim, se o contador retornar zerado, � informada a inconsist�ncia ao usu�rio.
    if nVolta = 0
        FwAlertError("O produto n�o existe ou nunca foi vendido.")
    else
        // Sen�o, � realizada a m�dia com base na somat�ria e as voltas dadas e � informado ao usu�rio.
        nMedia := (nCount / nVolta)
        FwAlertInfo("H� uma m�dia de " + cvaltochar(round(nMedia, 0)) + " unidade(s) desse produto dentre os pedidos de venda.", "M�dia de Venda")
    endif

    // Por fim, a tabela � fechada e a �rea restaurada.
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
