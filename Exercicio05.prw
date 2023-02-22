/* 5 – Faça um SELECT na tabela SB1 que retorne todos os produtos cadastrados e  presente os códigos e descrições de todos em uma mensagem. Mas atenção, os itens devem ser apresentados em ordem de descrição decrescente (Z-A) */

#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_05()
    // Declaração de variáveis
    local aArea   := GetArea()
    local cAlias  := GetNextAlias()
    local cDesc   := ""
    local cQuery  := ""
    
    // Aqui prepara o ambiente com base na empresa, filial, tabela e módulo correspondente.
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

    // Aqui é informada a pesquisa com os parâmetros necessários.
    cQuery := "SELECT * FROM " + RetSqlName('SB1') + " WHERE D_E_L_E_T_ = ' ' ORDER BY B1_DESC DESC"
    
    // Aqui é realizada a pesquisa no banco de dados e é posicionado o ponteiro no topo da tabela.
    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    // Enquanto o cursor não atingir o final da tabela, é concatenada a informação solicitada.
    While &(cAlias)->(!EOF())
        cDesc += "Descrição: " + &(cAlias)->(B1_DESC) + CRLF
        &(cAlias)->(DbSkip())
    End

    // Por fim, é exibido ao usuário a informação obtida.
    FwAlertInfo(cDesc, "Produtos Decrescente")

    // E a tabela é fechada e a área restaurada.
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
