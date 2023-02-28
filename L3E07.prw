#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_07()
    // Declaração de variáveis.
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery    := ""
    local dData1    := ""
    local dData2    := ""
    local cDesc     := ""
    
    // Aqui é preparado o ambiente com base na empresa, filial, tabela e módulos escolhidos.
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC5' MODULO 'COM'

    // Aqui são solicitadas as datas (o período) nas quais o usuário deseja filtrar a pesquisa no banco de dados.
    dData1 := ctod(FwInputBox("Digite a data de início:" ))
    dData2 := ctod(FwInputBox("Digite a data final: "))

    // E aqui é passada a informação convertida para o padrão do banco de dados para que a pesquisa possa ser realizada.
    cQuery := "SELECT * FROM " + RetSqlName('SC5') + " WHERE C5_EMISSAO >= '" + DTOS(dData1) + "' AND C5_EMISSAO <= '" + DTOS(dData2) + "' D_E_L_E_T_ = ' '"

    // Aqui é feita a pesquisa com base nas informações obtidas do usuário e é posicionado o ponteiro no início da tabela.
    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    // Enquanto o ponteiro não chegar no final da tabela, será concatenadas as informações solicitadas pelo usuário.
    While &(cAlias)->(!EOF())
        cDesc += "Pedido: " + &(cAlias)->(C5_NUM) + " Data de Emissão: " + cvaltochar(StoD(&(cAlias)->(C5_EMISSAO))) + CRLF + CRLF

        &(cAlias)->(DbSkip())
    End

    //Por fim, será exibido ao usuário.
    FwAlertInfo(cDesc, "Pedidos")

    // E a tabela será fechada, e a área restaurada.
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
