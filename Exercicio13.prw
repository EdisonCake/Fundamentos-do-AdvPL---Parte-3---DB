#INCLUDE 'TOTVS.CH'

User Function Ex_013()
    // Declara��o de vari�veis.
    local aDias := {"Domingo", "Segunda-Feira", "Ter�a-Feira", "Quarta-Feira", "Quinta-Feira", "Sexta-Feira", "S�bado"}
    local nUser := 0
    local lLoop := .t.

    // Iniciado um loop infinito definido com base na escolha final do usu�rio.
    While lLoop 

        // Ser� solicitado ao usu�rio um n�mero entre 1 e 7.
        nUser := val(FwInputBox("Digite um n�mero entre 1 e 7."))

            // Se o mesmo fizer uma entrada inc�lida, ser� informado, e o programa retornar� solicitando a entrada novamente.
            if nUser <= 0 .or. nUser > 7
                MsgStop("Digite um n�mero v�lido!!")
                loop

            // Se digitada corretamente, o programa retornar� o dia da semana equivalente ao n�mero digitado, e perguntar� sobre uma nova consulta.
            else
                lLoop := MsgYesNo("O dia informado foi " + aDias[nUser] + "." + CRLF +;
                                  "Deseja visualizar outro dia?", "Dia da Semana")
            endif
    End While

    // Ap�s o fm da execu��o, ser� informado o t�rmino ao usu�rio.
    MsgInfo("Fim da Execu��o", "Fim")

Return 

