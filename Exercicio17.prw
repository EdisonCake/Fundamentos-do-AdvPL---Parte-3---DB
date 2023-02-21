#INCLUDE 'TOTVS.CH'

User Function Desceu()
    local cNome     := ""
    local cConcat   := ""
    local nCount    := 0

    cNome := upper(FwInputBox("Digite um nome: ", cNome))

    For nCount := 1 to len(cNome)
        cConcat += substr(cNome, nCount, 1) + CRLF
    Next

    FwAlertInfo(cConcat, "Nome")

Return 
