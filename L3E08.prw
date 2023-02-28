#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_08()
    // Declaração de variáveis.
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery    := ""
    local cDesc     := ""
    
    //Aqui é preparado o ambiente com base na empresa, filial, tabela e módulo.
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC5' MODULO 'COM'

    // Aqui é feita a pesquisa com base no primeiro resultado exibido da ordenação decrescente de valor.
    cQuery := "SELECT TOP 1 C6_NUM, C6_DESCRI, C6_PRODUTO, C6_VALOR FROM " + RetSqlName('SC6') + " WHERE D_E_L_E_T_ = ' ' ORDER BY C6_VALOR DESC"

    // Aqui a consulta é feita e o ponteiro posicionado no início da tabela.
    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())
    
    // O ponteiro já foi posicionado no primeiro (e único registro) então a informação é registrada na variável.
    cDesc += "Pedido: " + &(cAlias)->(C6_NUM) + CRLF +;
             "Descrição: " + &(cAlias)->(C6_DESCRI) + CRLF +;
             "Código do Prodtuto: " + &(cAlias)->(C6_PRODUTO) + CRLF +;
             "Valor Total: R$ " + cvaltochar(&(cAlias)->(C6_VALOR))

    // Por fim, é exibido ao usuário a informação do maior valor solicitado pelo usuário.
    FwAlertInfo(cDesc, "Maior Valor")

    //Aqui a tabela é fechada e a área restaurada.
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
