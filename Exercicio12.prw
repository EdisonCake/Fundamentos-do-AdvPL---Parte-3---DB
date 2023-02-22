#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_12()  
    // Declara��o de vari�veis.
    local aArea     := GetArea()
    local aDesc     := {}
    local aPreco    := {}
    local cAlias    := GetNextAlias()
    local cQuery    := ""

    // Prepara��o de ambiente.
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

    // Aqui � informado a pesquisa que ser� realiazda no banco de dados, ordenada pelo pre�o .
    cQuery := "SELECT * FROM " + RetSqlName('SB1') + " WHERE D_E_L_E_T_ = ' ' ORDER BY B1_PRV1"

    // E aqui, a mesma � executada, posicionando em seguida o ponteiro no in�cio da tabela.
    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    // Enquanto o ponteiro n�o atingir o final da tabela, � adicionado em um array a descri��o do produto, e em outro, o valor do mesmo.
    While &(cAlias)->(!EOF())
        
        aAdd(aDesc, &(cAlias)->(B1_DESC))
        aAdd(aPreco, &(cAlias)->(B1_PRV1))

        &(cAlias)->(DbSkip())
    End

    // Por fim, � pego o primeiro valor (menor) e o �ltimo (maior) com base nos arrays preenchidos.
    FwAlertInfo("O menor valor de venda � o produto: " + aDesc[1] + " no valor de R$ " + cvaltochar(aPreco[1]) + CRLF + CRLF +;
                "E o maior valor de venda � o produto "  + aTail(aDesc) + " no valor de R$ " + cvaltochar(aTail(aPreco)), "Maior e Menor Valor")

    // Aqui a tabela � fechada e a �rea restaurada.
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
