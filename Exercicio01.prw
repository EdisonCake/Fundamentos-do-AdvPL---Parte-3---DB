/* 1 – Faça uma consulta na tabela SC7 para retornar todos os pedidos realizados para o fornecedor
“Super Cabos”. Apresente o resultado em uma função de mensagem com a seguinte estrutura:
Pedido 1: PC0001
Pedido 2: PC0002
... */

#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_01()
    // Declaração de variáveis.
    local aArea   := GetArea()
    local cAlias  := GetNextAlias()
    local cDesc   := ""
    local cQuery  := ""
    local nCount  := 1

    // Aqui é preparado o ambiente com base na empresa, filial, tabela e módulo escolhido.
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC7' MODULO 'COM'

    // Aqui é passada a pesquisa a ser feita no banco de dados.
    cQuery := "SELECT DISTINCT C7_NUM FROM " + RetSqlName('SC7') + " WHERE C7_FORNECE = 'F00004' AND D_E_L_E_T_ = ' '"
    
    // E aqui a mesma é realizada, mandando o ponteiro para o primeiro registro da tabela.
    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    // Enquanto o meu ponteiro não chegar no final da tabela, é concatenado em uma variável de texto as informações adquiridas da tabela.
    While &(cAlias)->(!EOF())
        cDesc += "Pedido " + cvaltochar(strzero(nCount, 2)) + ": " + &(cAlias)->(C7_NUM) + CRLF
        &(cAlias)->(DbSkip())
    End

    // Após a concatenação, é exibido ao usuário a informação solicitada.
    FwAlertInfo(cDesc, "Tabela de Pedidos")

    // E a tabela é fechada.
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
