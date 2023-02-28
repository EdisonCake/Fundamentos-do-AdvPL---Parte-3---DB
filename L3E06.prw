/* 6 – Faça um programa em que o usuário possa digitar um código de produto e saber se esse código existe no sistema ou não. Caso exista, apresente o Código, Descrição e o  Preço de Venda, caso contrário, apresente uma mensagem informando que não existe. */

#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function SQL_06()
    // Declaração de variáveis
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery    := ""
    local cPesquisa := ""
    local cDesc     := ""
    
    // Aqui é preparado o ambiente com base na empresa, filial, tabela e módulos selecionados.
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

    // Aqui é solicitado ao usuário o código que o mesmo deseja consultar no banco de dados.
    cPesquisa := FwInputBox("Digite o código a ser pesquisado:", cPesquisa)

    // Aqui é montada a pesquisa no bancode dados com base no produto informado pelo usuário.
    cQuery := "SELECT * FROM " + RetSqlName('SB1') + " WHERE B1_COD = '" + cPesquisa + "' AND D_E_L_E_T_ = ' '"

    // E aqui é feita a pesquisa no banco de dados.
    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    // Enquanto o ponteiro não chegar ao final, será feita uma comparação com o registro selecionado.
    While &(cAlias)->(!EOF())

        // Caso o registro do campo seja exatamente igual à pesquisa do usuário, será atribuída a informação à variável correspondente.
        if alltrim(&(cAlias)->(B1_COD)) == cPesquisa
            cDesc := "Código: " + &(cAlias)->(B1_COD) + CRLF +;
                     "Descrição: " + &(cAlias)->(B1_DESC) + CRLF+;
                     "Preço de Venda: R$ " + cvaltochar(&(cAlias)->(B1_PRV1))
            &(cAlias)->(DbSkip())
        endif
        
    End

    // Se a descrição estiver nula/em branco, será informado ao usuário a inexistêncaia do código/produto, senão, é informado ao usuário as informações da pesquisa.
    if cDesc == ""
        FwAlertError("Não foram encontrados produtos com o código informado.", "Atenção")
    else
        FwAlertInfo(cDesc)
    endif

    // Aqui é fechada a tabela e restaurada a área
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
