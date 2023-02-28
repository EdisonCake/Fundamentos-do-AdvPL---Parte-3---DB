/* 2 – Faça uma consulta na tabela SC5 para retornar todos os pedidos de Venda em que o “número da nota” (C5_NOTA) não foi preenchido. Apresente em uma mensagem quais são os números dos pedidos e o nome dos clientes. */

#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_02()
    // Declaração de variáveis.
    local aArea   := GetArea()
    local cAlias  := GetNextAlias()
    local cDesc   := ""
    local cQuery  := ""

    // Aqui é preparado o ambiente com base na empresa, filial, tabela e módulo escolhidos.
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC5' MODULO 'COM'

    // Aqui é passada a consulta do banco de dados que queremos para uma variável auxiliar.
    cQuery := "SELECT PD.C5_NUM, PD.C5_CLIENT, CL.A1_NOME FROM " + RetSqlName('SC5') + " PD INNER JOIN " + RetSqlName('SA1') + " CL ON PD.C5_CLIENT = CL.A1_COD WHERE C5_NOTA = ' ' AND PD.D_E_L_E_T_ = ' '"

    // E aqui, a mesma é realizada no banco de dados e é posicionado o ponteiro no topo da tabela.
    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    // Enquanto o ponteiro não chegar no final da tabela, é concatenada a informação que será exibida no final.
    While &(cAlias)->(!EOF())
        cDesc += "Pedido : " + &(cAlias)->(C5_NUM) + " Nome: " + &(cAlias)->(A1_NOME) + CRLF
        &(cAlias)->(DbSkip())
    End

    // Por fim, é exibido ao usuário o resultado da consulta.
    FwAlertInfo(cDesc, "Pedidos sem número de nota.")

    // Nesse bloco a área da tabela é fechada, e a área restaurada.
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
