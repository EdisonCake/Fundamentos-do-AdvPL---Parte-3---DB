/*/ 4 � Fa�a um SELECT na tabela SB1 que retorne todos os produtos que pertencem ao grupo
�Pel�culas�. Apresente a descri��o desses produtos atrav�s da fun��o FwAlertInfo() /*/

#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_04()
    // Declara��o de vari�veis
    local aArea   := GetArea()
    local cAlias  := GetNextAlias()
    local cDesc   := ""
    local cQuery  := ""
    
    // Aqui o c�digo prepara o ambiente com base na empresa, filial, tabela e m�dulo.
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

    // Aqui � passada a pesquisa a ser feita no banco de dados.
    cQuery := "SELECT * FROM " + RetSqlName('SB1') + " WHERE B1_GRUPO = 'G002' AND D_E_L_E_T_ = ' '"

    // Aqui � feita a pesquisa e posicionado o ponteiro no topo da tabela
    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    // Enquanto o ponteiro n�o chegar no fim da tabela, ele vai concatenando as informa��es solicitadas.
    While &(cAlias)->(!EOF())
        cDesc += "Descri��o: " + &(cAlias)->(B1_DESC) + CRLF
        &(cAlias)->(DbSkip())
    End

    // Por fim, � exibido ao usu�rio as informa��es que o mesmo solicitou.
    FwAlertInfo(cDesc, "Pel�culas")

    // A tabela � fechada e a �rea restaurada.
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
