/* 6 – Faça um programa em que o usuário possa digitar um código de produto e saber se esse código existe no sistema ou não. Caso exista, apresente o Código, Descrição e o  Preço de Venda, caso contrário, apresente uma mensagem informando que não existe. */

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

    cPesquisa := FwInputBox("Digite o código a ser pesquisado:", cPesquisa)

    cQuery := "SELECT * FROM " + RetSqlName('SB1') + " WHERE B1_COD = '" + cPesquisa + "'"

    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    While &(cAlias)->(!EOF())

        if alltrim(&(cAlias)->(B1_COD)) == cPesquisa
            cDesc := "Código: " + &(cAlias)->(B1_COD) + CRLF +;
                     "Descrição: " + &(cAlias)->(B1_DESC) + CRLF+;
                     "Preço de Venda: R$ " + cvaltochar(&(cAlias)->(B1_PRV1))
            &(cAlias)->(DbSkip())
        endif
        
    End

    if cDesc == ""
        FwAlertError("Não foram encontrados produtos com o código informado.", "Atenção")
    else
        FwAlertInfo(cDesc)
    endif

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
