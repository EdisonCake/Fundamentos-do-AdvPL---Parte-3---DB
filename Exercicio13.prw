#INCLUDE 'TOTVS.CH'

User Function Ex_013()
    local aDias := {"Domingo", "Segunda-Feira", "Terça-Feira", "Quarta-Feira", "Quinta-Feira", "Sexta-Feira", "Sábado"}
    local nUser := 0
    local lLoop := .t.

    While lLoop
        nUser := val(FwInputBox("Digite um número entre 1 e 7."))

            if nUser <= 0 .or. nUser > 7
                MsgStop("Digite um número válido!!")
                loop
            else
                lLoop := MsgYesNo("O dia informado foi " + aDias[nUser] + "." + CRLF +;
                                  "Deseja visualizar outro dia?", "Dia da Semana")
            endif
    End While

    MsgInfo("Fim da Execução", "Fim")

Return 

