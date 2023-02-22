#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function Chall03()
    // Declaração de variáveis
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery    := ""

    // Aqui é preparado o ambiente com base na empresa, filial, tabela escolhida e módulo.
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

    // Aqui é passado ao query a consulta a ser realizada no banco de dados.
    cQuery := "SELECT B1_FILIAL, B1_COD, B1_TIPO, B1_ZZGRP FROM " + RetSqlName('SB1') + " WHERE B1_ZZGRP = ' ' AND D_E_L_E_T_ = ' '"

    // Aqui é feita a pesquisa no banco de dados, e com o DbGoTop é posicionado o ponteiro no topo da tabela.
    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    // Enquanto não chegar no fim da tabela, é feita uma verificação.
    While &(cAlias)->(!EOF())

        // Caso o campo B1_TIPO seja o especificado, é atribuido um texto à variável correspondente.
        if &(cAlias)->(B1_TIPO) == "PA"
            cMsg := "PRODUTO PARA COMERCIALIZACAO"
        elseif &(cAlias)->(B1_TIPO) == "MP"
            cMsg := "MATERIA PRIMA PRODUCAO"
        else
            cMsg := "OUTROS PRODUTOS"
        endif

        // Aqui é selecionada a tabela a ser alterada e o índice de ordenação.
        DbSelectArea("SB1")
        DbSetOrder(1)

        // Com esse bloco condicional, caso as informações coincidam é realizada a alteração.
        If DbSeek(&(cAlias)->(B1_FILIAL) + &(cAlias)->(B1_COD))

            // Aqui é feito um lock do registro da tabela e atribuido o texto da variável ao campo correspondente.
            RecLock("SB1", .F.)
            SB1->B1_ZZGRP := cMsg

            // Com essa função, é feito o desbloqueio do registro editado.
            MsUnlock()
        endif
        
        // E com a função DbSkip é pulado para o próximo registro da tabela.
        &(cAlias)->(DBSKIP())
    End While

    // Por fim, é fechada a área da tabela e encerrado o programa.
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)
Return 
