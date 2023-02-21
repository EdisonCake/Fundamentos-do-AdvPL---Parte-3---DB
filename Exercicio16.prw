#INCLUDE 'TOTVS.CH'

User Function DeTras()
    local aNome     := {}
    local cInverte  := ""
    local cNome     := ""
    local nCount    := 0
    local lNome     := .t.

    While lNome
        cNome := FwInputBox("Digite seu nome: ", cNome)

        For nCount := 1 to len(cNome)
            aAdd(aNome, upper(substr(cNome, nCount, 1)))
        Next

        For nCount := len(aNome) to 1 step -1
            cInverte += aNome[nCount]
        Next

        lNome := MsgYesNo(cInverte + CRLF + "Deseja fazer com outro nome?", "Nome invertido")
        
        cInverte := ""
        cNome := ""
    End while
Return 
