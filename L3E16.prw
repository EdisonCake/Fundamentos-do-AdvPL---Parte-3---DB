#INCLUDE 'TOTVS.CH'

User Function DeTras()
    // Declara��o de vari�veis.
    local aNome     := {}
    local cInverte  := ""
    local cNome     := ""
    local nCount    := 0
    local lNome     := .t.

    // Enquanto o usu�rio n�o decidir sair, o programa funcionar�.
    While lNome

        // � solicitada a entrada de um nome ao usu�rio.
        cNome := FwInputBox("Digite seu nome: ", cNome)

        // O nome � percorrido atrav�s de um contador, e cada letra � armazenada em um array com a fun��o Upper() transformando-a em mai�scula.
        For nCount := 1 to len(cNome)
            aAdd(aNome, upper(substr(cNome, nCount, 1)))
        Next

        // Depois, o array � percorrido de tr�s para frente, e o conte�do da posi��o � concatenado em uma vari�vel de texto.
        For nCount := len(aNome) to 1 step -1
            cInverte += aNome[nCount]
        Next

        // Por fim, � exibido ao usu�rio o nome em ordem inversa, e � perguntado se deseja realizar com um novo nome.
        lNome := MsgYesNo(cInverte + CRLF + "Deseja fazer com outro nome?", "Nome invertido")
        
        // Se sim, as vari�veis anteriores s�o redefinidas e o programa � executado novamente.
        cInverte := " "
        cNome := " "
        aNome := {}
        
    End while
Return 
