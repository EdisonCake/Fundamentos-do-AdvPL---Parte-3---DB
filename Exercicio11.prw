/* 
11 – Crie uma função que retorne todos os fornecedores situados em São Paulo (SP).
*/

#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_11()
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery    := ""
    local cDesc     := ""

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SA2' MODULO 'COM'

    cQuery := "SELECT * FROM " + RetSqlName('SA2') + " WHERE A2_EST = 'SP'"

    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    While &(cAlias)->(!EOF())
        cDesc += "Código: " + &(cAlias)->(A2_COD) + CRLF +;
                 " Nome: " + &(cAlias)->(A2_NOME) + CRLF +;
                 Replicate("=", 35) + CRLF
        &(cAlias)->(DbSkip())
    End

    FwAlertInfo(cDesc, "Fornecedores do Estado de São Paulo")

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
