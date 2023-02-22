/* 
11 � Crie uma fun��o que retorne todos os fornecedores situados em S�o Paulo (SP).
*/

#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_11()
    // Declara��o de vari�veis.
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery    := ""
    local cDesc     := ""

    // Prepara��o de ambiente.
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SA2' MODULO 'COM'

    // Aqui � informada a pesquisa que ser� feita no banco de dados.
    cQuery := "SELECT * FROM " + RetSqlName('SA2') + " WHERE A2_EST = 'SP' AND D_E_L_E_T_ = ' '"

    // E aqui, a mesma � realizada, posicionando em seguida o ponteiro no in�cio da tabela.
    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    // Enquanto n�o for atingido o final da tabela, � realizada a concatena��o das informa��es solicitadas.
    While &(cAlias)->(!EOF())
        cDesc += "C�digo: " + &(cAlias)->(A2_COD) + CRLF +;
                 " Nome: " + &(cAlias)->(A2_NOME) + CRLF +;
                 Replicate("=", 35) + CRLF
        &(cAlias)->(DbSkip())
    End

    // Por fim, a mesma � exibida ao usu�rio.
    FwAlertInfo(cDesc, "Fornecedores do Estado de S�o Paulo")

    // E aqui, a tabela � fechada e a �rea restaurada.
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
