#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_12()
    local aArea     := GetArea()
    local aDesc     := {}
    local aPreco    := {}
    local cAlias    := GetNextAlias()
    local cQuery    := ""

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

    cQuery := "SELECT * FROM " + RetSqlName('SB1') + " WHERE D_E_L_E_T_ = ' ' ORDER BY B1_PRV1"

    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    While &(cAlias)->(!EOF())
        
        aAdd(aDesc, &(cAlias)->(B1_DESC))
        aAdd(aPreco, &(cAlias)->(B1_PRV1))

        &(cAlias)->(DbSkip())
    End

    FwAlertInfo("O menor valor de venda é o produto: " + aDesc[1] + " no valor de R$ " + cvaltochar(aPreco[1]) + CRLF + CRLF +;
                "E o maior valor de venda é o produto "  + aTail(aDesc) + " no valor de R$ " + cvaltochar(aTail(aPreco)), "Maior e Menor Valor")

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
