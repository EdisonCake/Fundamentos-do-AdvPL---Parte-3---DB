/* 6 � Fa�a um programa em que o usu�rio possa digitar um c�digo de produto e saber se esse c�digo existe no sistema ou n�o. Caso exista, apresente o C�digo, Descri��o e o  Pre�o de Venda, caso contr�rio, apresente uma mensagem informando que n�o existe. */

#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_06()
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery    := ""
    local cPesquisa := ""
    local cDesc     := ""
    
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

    cPesquisa := FwInputBox("Digite o c�digo a ser pesquisado:", cPesquisa)

    cQuery := "SELECT * FROM " + RetSqlName('SB1') + " WHERE B1_COD = '" + cPesquisa + "'"

    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    While &(cAlias)->(!EOF())

        if alltrim(&(cAlias)->(B1_COD)) == cPesquisa
            cDesc := "C�digo: " + &(cAlias)->(B1_COD) + CRLF +;
                     "Descri��o: " + &(cAlias)->(B1_DESC) + CRLF+;
                     "Pre�o de Venda: R$ " + cvaltochar(&(cAlias)->(B1_PRV1))
            &(cAlias)->(DbSkip())
        endif
        
    End

    if cDesc == ""
        FwAlertError("N�o foram encontrados produtos com o c�digo informado.", "Aten��o")
    else
        FwAlertInfo(cDesc)
    endif

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
