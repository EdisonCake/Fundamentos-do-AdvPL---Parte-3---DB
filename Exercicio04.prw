/*/ 4 � Fa�a um SELECT na tabela SB1 que retorne todos os produtos que pertencem ao grupo
�Pel�culas�. Apresente a descri��o desses produtos atrav�s da fun��o FwAlertInfo() /*/

#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_04()
    local aArea   := GetArea()
    local cAlias  := GetNextAlias()
    local cDesc   := ""
    local cQuery  := ""
    
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

    cQuery := "SELECT * FROM " + RetSqlName('SB1') + " WHERE B1_GRUPO = 'G002'"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())

    While &(cAlias)->(!EOF())
        cDesc += "Descri��o: " + &(cAlias)->(B1_DESC) + CRLF
        &(cAlias)->(DbSkip())
    End

    FwAlertInfo(cDesc, "Pel�culas")

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
