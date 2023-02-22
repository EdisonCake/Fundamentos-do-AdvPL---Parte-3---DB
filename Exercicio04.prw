/*/ 4 – Faça um SELECT na tabela SB1 que retorne todos os produtos que pertencem ao grupo
“Películas”. Apresente a descrição desses produtos através da função FwAlertInfo() /*/

#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_04()
    // Declaração de variáveis
    local aArea   := GetArea()
    local cAlias  := GetNextAlias()
    local cDesc   := ""
    local cQuery  := ""
    
    // Aqui o código prepara o ambiente com base na empresa, filial, tabela e módulo.
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

    // Aqui é passada a pesquisa a ser feita no banco de dados.
    cQuery := "SELECT * FROM " + RetSqlName('SB1') + " WHERE B1_GRUPO = 'G002' AND D_E_L_E_T_ = ' '"

    // Aqui é feita a pesquisa e posicionado o ponteiro no topo da tabela
    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    // Enquanto o ponteiro não chegar no fim da tabela, ele vai concatenando as informações solicitadas.
    While &(cAlias)->(!EOF())
        cDesc += "Descrição: " + &(cAlias)->(B1_DESC) + CRLF
        &(cAlias)->(DbSkip())
    End

    // Por fim, é exibido ao usuário as informações que o mesmo solicitou.
    FwAlertInfo(cDesc, "Películas")

    // A tabela é fechada e a área restaurada.
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
