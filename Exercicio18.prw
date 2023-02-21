#INCLUDE 'TOTVS.CH'

User Function Escada()
    local cNome         := ""
    local cConcatena    := ""
    local nCount        := 0

    cNome := Upper(FwInputBox("Digite seu nome:", cNome))

    For nCount := 1 to len(cNome)
        cConcatena += substr(cNome, 1, nCount) + CRLF
    Next

    FwAlertInfo(cConcatena, "Escadinha!")

Return 
