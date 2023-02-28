/* 
11 – Crie uma função que retorne todos os fornecedores situados em São Paulo (SP).
*/

#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_11()
    // Declaração de variáveis.
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery    := ""
    local cDesc     := ""

    // Preparação de ambiente.
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SA2' MODULO 'COM'

    // Aqui é informada a pesquisa que será feita no banco de dados.
    cQuery := "SELECT * FROM " + RetSqlName('SA2') + " WHERE A2_EST = 'SP' AND D_E_L_E_T_ = ' '"

    // E aqui, a mesma é realizada, posicionando em seguida o ponteiro no início da tabela.
    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    // Enquanto não for atingido o final da tabela, é realizada a concatenação das informações solicitadas.
    While &(cAlias)->(!EOF())
        cDesc += "Código: " + &(cAlias)->(A2_COD) + CRLF +;
                 " Nome: " + &(cAlias)->(A2_NOME) + CRLF +;
                 Replicate("=", 35) + CRLF
        &(cAlias)->(DbSkip())
    End

    // Por fim, a mesma é exibida ao usuário.
    FwAlertInfo(cDesc, "Fornecedores do Estado de São Paulo")

    // E aqui, a tabela é fechada e a área restaurada.
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
