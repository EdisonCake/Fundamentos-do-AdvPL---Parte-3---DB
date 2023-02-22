#INCLUDE 'TOTVS.CH'

User Function Ex_013()
    // Declaração de variáveis.
    local aDias := {"Domingo", "Segunda-Feira", "Terça-Feira", "Quarta-Feira", "Quinta-Feira", "Sexta-Feira", "Sábado"}
    local nUser := 0
    local lLoop := .t.

    // Iniciado um loop infinito definido com base na escolha final do usuário.
    While lLoop 

        // Será solicitado ao usuário um número entre 1 e 7.
        nUser := val(FwInputBox("Digite um número entre 1 e 7."))

            // Se o mesmo fizer uma entrada incálida, será informado, e o programa retornará solicitando a entrada novamente.
            if nUser <= 0 .or. nUser > 7
                MsgStop("Digite um número válido!!")
                loop

            // Se digitada corretamente, o programa retornará o dia da semana equivalente ao número digitado, e perguntará sobre uma nova consulta.
            else
                lLoop := MsgYesNo("O dia informado foi " + aDias[nUser] + "." + CRLF +;
                                  "Deseja visualizar outro dia?", "Dia da Semana")
            endif
    End While

    // Após o fm da execução, será informado o término ao usuário.
    MsgInfo("Fim da Execução", "Fim")

Return 

