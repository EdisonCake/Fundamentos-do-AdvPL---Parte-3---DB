#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_12()  
    // Declaração de variáveis.
    local aArea     := GetArea()
    local aDesc     := {}
    local aPreco    := {}
    local cAlias    := GetNextAlias()
    local cQuery    := ""

    // Preparação de ambiente.
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

    // Aqui é informado a pesquisa que será realiazda no banco de dados, ordenada pelo preço .
    cQuery := "SELECT * FROM " + RetSqlName('SB1') + " WHERE D_E_L_E_T_ = ' ' ORDER BY B1_PRV1"

    // E aqui, a mesma é executada, posicionando em seguida o ponteiro no início da tabela.
    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    // Enquanto o ponteiro não atingir o final da tabela, é adicionado em um array a descrição do produto, e em outro, o valor do mesmo.
    While &(cAlias)->(!EOF())
        
        aAdd(aDesc, &(cAlias)->(B1_DESC))
        aAdd(aPreco, &(cAlias)->(B1_PRV1))

        &(cAlias)->(DbSkip())
    End

    // Por fim, é pego o primeiro valor (menor) e o último (maior) com base nos arrays preenchidos.
    FwAlertInfo("O menor valor de venda é o produto: " + aDesc[1] + " no valor de R$ " + cvaltochar(aPreco[1]) + CRLF + CRLF +;
                "E o maior valor de venda é o produto "  + aTail(aDesc) + " no valor de R$ " + cvaltochar(aTail(aPreco)), "Maior e Menor Valor")

    // Aqui a tabela é fechada e a área restaurada.
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
