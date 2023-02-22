/* 6 � Fa�a um programa em que o usu�rio possa digitar um c�digo de produto e saber se esse c�digo existe no sistema ou n�o. Caso exista, apresente o C�digo, Descri��o e o  Pre�o de Venda, caso contr�rio, apresente uma mensagem informando que n�o existe. */

#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_06()
    // Declara��o de vari�veis
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery    := ""
    local cPesquisa := ""
    local cDesc     := ""
    
    // Aqui � preparado o ambiente com base na empresa, filial, tabela e m�dulos selecionados.
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

    // Aqui � solicitado ao usu�rio o c�digo que o mesmo deseja consultar no banco de dados.
    cPesquisa := FwInputBox("Digite o c�digo a ser pesquisado:", cPesquisa)

    // Aqui � montada a pesquisa no bancode dados com base no produto informado pelo usu�rio.
    cQuery := "SELECT * FROM " + RetSqlName('SB1') + " WHERE B1_COD = '" + cPesquisa + "' AND D_E_L_E_T_ = ' '"

    // E aqui � feita a pesquisa no banco de dados.
    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    // Enquanto o ponteiro n�o chegar ao final, ser� feita uma compara��o com o registro selecionado.
    While &(cAlias)->(!EOF())

        // Caso o registro do campo seja exatamente igual � pesquisa do usu�rio, ser� atribu�da a informa��o � vari�vel correspondente.
        if alltrim(&(cAlias)->(B1_COD)) == cPesquisa
            cDesc := "C�digo: " + &(cAlias)->(B1_COD) + CRLF +;
                     "Descri��o: " + &(cAlias)->(B1_DESC) + CRLF+;
                     "Pre�o de Venda: R$ " + cvaltochar(&(cAlias)->(B1_PRV1))
            &(cAlias)->(DbSkip())
        endif
        
    End

    // Se a descri��o estiver nula/em branco, ser� informado ao usu�rio a inexist�ncaia do c�digo/produto, sen�o, � informado ao usu�rio as informa��es da pesquisa.
    if cDesc == ""
        FwAlertError("N�o foram encontrados produtos com o c�digo informado.", "Aten��o")
    else
        FwAlertInfo(cDesc)
    endif

    // Aqui � fechada a tabela e restaurada a �rea
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
