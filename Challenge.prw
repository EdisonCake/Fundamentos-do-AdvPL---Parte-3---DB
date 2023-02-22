#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function Chall03()
    // Declara��o de vari�veis
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery    := ""

    // Aqui � preparado o ambiente com base na empresa, filial, tabela escolhida e m�dulo.
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

    // Aqui � passado ao query a consulta a ser realizada no banco de dados.
    cQuery := "SELECT B1_FILIAL, B1_COD, B1_TIPO, B1_ZZGRP FROM " + RetSqlName('SB1') + " WHERE B1_ZZGRP = ' ' AND D_E_L_E_T_ = ' '"

    // Aqui � feita a pesquisa no banco de dados, e com o DbGoTop � posicionado o ponteiro no topo da tabela.
    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    // Enquanto n�o chegar no fim da tabela, � feita uma verifica��o.
    While &(cAlias)->(!EOF())

        // Caso o campo B1_TIPO seja o especificado, � atribuido um texto � vari�vel correspondente.
        if &(cAlias)->(B1_TIPO) == "PA"
            cMsg := "PRODUTO PARA COMERCIALIZACAO"
        elseif &(cAlias)->(B1_TIPO) == "MP"
            cMsg := "MATERIA PRIMA PRODUCAO"
        else
            cMsg := "OUTROS PRODUTOS"
        endif

        // Aqui � selecionada a tabela a ser alterada e o �ndice de ordena��o.
        DbSelectArea("SB1")
        DbSetOrder(1)

        // Com esse bloco condicional, caso as informa��es coincidam � realizada a altera��o.
        If DbSeek(&(cAlias)->(B1_FILIAL) + &(cAlias)->(B1_COD))

            // Aqui � feito um lock do registro da tabela e atribuido o texto da vari�vel ao campo correspondente.
            RecLock("SB1", .F.)
            SB1->B1_ZZGRP := cMsg

            // Com essa fun��o, � feito o desbloqueio do registro editado.
            MsUnlock()
        endif
        
        // E com a fun��o DbSkip � pulado para o pr�ximo registro da tabela.
        &(cAlias)->(DBSKIP())
    End While

    // Por fim, � fechada a �rea da tabela e encerrado o programa.
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)
Return 
