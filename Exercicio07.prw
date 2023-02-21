#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_07()
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery    := ""
    local dData1    := ""
    local dData2    := ""
    local cDesc     := ""
    
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC5' MODULO 'COM'

    dData1 := ctod(FwInputBox("Digite a data de início:" ))
    dData2 := ctod(FwInputBox("Digite a data final: "))

    cQuery := "SELECT * FROM " + RetSqlName('SC5') + " WHERE C5_EMISSAO >= '" + DTOS(dData1) + "' AND C5_EMISSAO <= '" + DTOS(dData2) + "' D_E_L_E_T_ = ' '"

    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    While &(cAlias)->(!EOF())
        cDesc += "Pedido: " + &(cAlias)->(C5_NUM) + " Data de Emissão: " + cvaltochar(StoD(&(cAlias)->(C5_EMISSAO))) + CRLF + CRLF

        &(cAlias)->(DbSkip())
    End

    FwAlertInfo(cDesc, "Pedidos")

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
