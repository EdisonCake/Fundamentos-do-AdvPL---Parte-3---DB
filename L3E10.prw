#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_10()
    // Declaração de variáveis.
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery    := ""
    local cPesquisa := ""
    local nMedia    := 0
    local nCount    := 0
    local nVolta    := 0

    // Preparação de ambiente.
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

    // Aqui é solicitado ao usuário qual o produto a ser pesquisado.
    cPesquisa := FwInputBox("Digite o produto a ser pesquisado: ")

    // Aqui a informação do usuário é inclusa na pesquisa a ser realizada no banco de dados.
    cQuery := "SELECT * FROM " + RetSqlName('SB1') + " PROD INNER JOIN " + RetSqlName('SC6') + " PEDV ON PROD.B1_COD = PEDV.C6_PRODUTO WHERE PROD.B1_COD = '" + cPesquisa + "' AND PROD.D_E_L_E_T_ = ' '"  
    
    // Aqui, a pesquisa é feita, e o ponteiro posicionado no topo da tabela.
    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    // Enquanto o ponteiro não chegar o final da tabela, é realizado um bloco condicional em cada registro.
    While &(cAlias)->(!EOF())

        // Se o registro atual é  exatamente igual à pesquisa do usuário, é acrescido um contador e é somado o valor de um campo em outra variável.
        if cPesquisa == alltrim(&(cAlias)->(B1_COD))
            nVolta++
            nCount += &(cAlias)->(C6_QTDVEN)
            &(cAlias)->(DbSkip())

        // Caso contrário, o registro é ignorado e é avançado para o próximo.
        else
            &(cAlias)->(DbSkip())
        endif
    End

    // Por fim, se o contador retornar zerado, é informada a inconsistência ao usuário.
    if nVolta = 0
        FwAlertError("O produto não existe ou nunca foi vendido.")
    else
        // Senão, é realizada a média com base na somatória e as voltas dadas e é informado ao usuário.
        nMedia := (nCount / nVolta)
        FwAlertInfo("Há uma média de " + cvaltochar(round(nMedia, 0)) + " unidade(s) desse produto dentre os pedidos de venda.", "Média de Venda")
    endif

    // Por fim, a tabela é fechada e a área restaurada.
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
