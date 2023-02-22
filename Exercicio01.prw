/* 1 � Fa�a uma consulta na tabela SC7 para retornar todos os pedidos realizados para o fornecedor
�Super Cabos�. Apresente o resultado em uma fun��o de mensagem com a seguinte estrutura:
Pedido 1: PC0001
Pedido 2: PC0002
... */

#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_01()
    // Declara��o de vari�veis.
    local aArea   := GetArea()
    local cAlias  := GetNextAlias()
    local cDesc   := ""
    local cQuery  := ""
    local nCount  := 1

    // Aqui � preparado o ambiente com base na empresa, filial, tabela e m�dulo escolhido.
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC7' MODULO 'COM'

    // Aqui � passada a pesquisa a ser feita no banco de dados.
    cQuery := "SELECT DISTINCT C7_NUM FROM " + RetSqlName('SC7') + " WHERE C7_FORNECE = 'F00004' AND D_E_L_E_T_ = ' '"
    
    // E aqui a mesma � realizada, mandando o ponteiro para o primeiro registro da tabela.
    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    // Enquanto o meu ponteiro n�o chegar no final da tabela, � concatenado em uma vari�vel de texto as informa��es adquiridas da tabela.
    While &(cAlias)->(!EOF())
        cDesc += "Pedido " + cvaltochar(strzero(nCount, 2)) + ": " + &(cAlias)->(C7_NUM) + CRLF
        &(cAlias)->(DbSkip())
    End

    // Ap�s a concatena��o, � exibido ao usu�rio a informa��o solicitada.
    FwAlertInfo(cDesc, "Tabela de Pedidos")

    // E a tabela � fechada.
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
