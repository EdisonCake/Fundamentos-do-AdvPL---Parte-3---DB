/* 2 � Fa�a uma consulta na tabela SC5 para retornar todos os pedidos de Venda em que o �n�mero da nota� (C5_NOTA) n�o foi preenchido. Apresente em uma mensagem quais s�o os n�meros dos pedidos e o nome dos clientes. */

#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_02()
    // Declara��o de vari�veis.
    local aArea   := GetArea()
    local cAlias  := GetNextAlias()
    local cDesc   := ""
    local cQuery  := ""

    // Aqui � preparado o ambiente com base na empresa, filial, tabela e m�dulo escolhidos.
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC5' MODULO 'COM'

    // Aqui � passada a consulta do banco de dados que queremos para uma vari�vel auxiliar.
    cQuery := "SELECT PD.C5_NUM, PD.C5_CLIENT, CL.A1_NOME FROM " + RetSqlName('SC5') + " PD INNER JOIN " + RetSqlName('SA1') + " CL ON PD.C5_CLIENT = CL.A1_COD WHERE C5_NOTA = ' ' AND PD.D_E_L_E_T_ = ' '"

    // E aqui, a mesma � realizada no banco de dados e � posicionado o ponteiro no topo da tabela.
    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    // Enquanto o ponteiro n�o chegar no final da tabela, � concatenada a informa��o que ser� exibida no final.
    While &(cAlias)->(!EOF())
        cDesc += "Pedido : " + &(cAlias)->(C5_NUM) + " Nome: " + &(cAlias)->(A1_NOME) + CRLF
        &(cAlias)->(DbSkip())
    End

    // Por fim, � exibido ao usu�rio o resultado da consulta.
    FwAlertInfo(cDesc, "Pedidos sem n�mero de nota.")

    // Nesse bloco a �rea da tabela � fechada, e a �rea restaurada.
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
