/* 5 � Fa�a um SELECT na tabela SB1 que retorne todos os produtos cadastrados e  presente os c�digos e descri��es de todos em uma mensagem. Mas aten��o, os itens devem ser apresentados em ordem de descri��o decrescente (Z-A) */

#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_05()
    // Declara��o de vari�veis
    local aArea   := GetArea()
    local cAlias  := GetNextAlias()
    local cDesc   := ""
    local cQuery  := ""
    
    // Aqui prepara o ambiente com base na empresa, filial, tabela e m�dulo correspondente.
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

    // Aqui � informada a pesquisa com os par�metros necess�rios.
    cQuery := "SELECT * FROM " + RetSqlName('SB1') + " WHERE D_E_L_E_T_ = ' ' ORDER BY B1_DESC DESC"
    
    // Aqui � realizada a pesquisa no banco de dados e � posicionado o ponteiro no topo da tabela.
    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    // Enquanto o cursor n�o atingir o final da tabela, � concatenada a informa��o solicitada.
    While &(cAlias)->(!EOF())
        cDesc += "Descri��o: " + &(cAlias)->(B1_DESC) + CRLF
        &(cAlias)->(DbSkip())
    End

    // Por fim, � exibido ao usu�rio a informa��o obtida.
    FwAlertInfo(cDesc, "Produtos Decrescente")

    // E a tabela � fechada e a �rea restaurada.
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
