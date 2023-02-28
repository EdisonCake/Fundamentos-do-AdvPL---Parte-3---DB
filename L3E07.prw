#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_07()
    // Declara��o de vari�veis.
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery    := ""
    local dData1    := ""
    local dData2    := ""
    local cDesc     := ""
    
    // Aqui � preparado o ambiente com base na empresa, filial, tabela e m�dulos escolhidos.
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC5' MODULO 'COM'

    // Aqui s�o solicitadas as datas (o per�odo) nas quais o usu�rio deseja filtrar a pesquisa no banco de dados.
    dData1 := ctod(FwInputBox("Digite a data de in�cio:" ))
    dData2 := ctod(FwInputBox("Digite a data final: "))

    // E aqui � passada a informa��o convertida para o padr�o do banco de dados para que a pesquisa possa ser realizada.
    cQuery := "SELECT * FROM " + RetSqlName('SC5') + " WHERE C5_EMISSAO >= '" + DTOS(dData1) + "' AND C5_EMISSAO <= '" + DTOS(dData2) + "' D_E_L_E_T_ = ' '"

    // Aqui � feita a pesquisa com base nas informa��es obtidas do usu�rio e � posicionado o ponteiro no in�cio da tabela.
    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    // Enquanto o ponteiro n�o chegar no final da tabela, ser� concatenadas as informa��es solicitadas pelo usu�rio.
    While &(cAlias)->(!EOF())
        cDesc += "Pedido: " + &(cAlias)->(C5_NUM) + " Data de Emiss�o: " + cvaltochar(StoD(&(cAlias)->(C5_EMISSAO))) + CRLF + CRLF

        &(cAlias)->(DbSkip())
    End

    //Por fim, ser� exibido ao usu�rio.
    FwAlertInfo(cDesc, "Pedidos")

    // E a tabela ser� fechada, e a �rea restaurada.
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
