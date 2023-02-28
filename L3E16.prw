#INCLUDE 'TOTVS.CH'

User Function DeTras()
    // Declaração de variáveis.
    local aNome     := {}
    local cInverte  := ""
    local cNome     := ""
    local nCount    := 0
    local lNome     := .t.

    // Enquanto o usuário não decidir sair, o programa funcionará.
    While lNome

        // É solicitada a entrada de um nome ao usuário.
        cNome := FwInputBox("Digite seu nome: ", cNome)

        // O nome é percorrido através de um contador, e cada letra é armazenada em um array com a função Upper() transformando-a em maiúscula.
        For nCount := 1 to len(cNome)
            aAdd(aNome, upper(substr(cNome, nCount, 1)))
        Next

        // Depois, o array é percorrido de trás para frente, e o conteúdo da posição é concatenado em uma variável de texto.
        For nCount := len(aNome) to 1 step -1
            cInverte += aNome[nCount]
        Next

        // Por fim, é exibido ao usuário o nome em ordem inversa, e é perguntado se deseja realizar com um novo nome.
        lNome := MsgYesNo(cInverte + CRLF + "Deseja fazer com outro nome?", "Nome invertido")
        
        // Se sim, as variáveis anteriores são redefinidas e o programa é executado novamente.
        cInverte := " "
        cNome := " "
        aNome := {}
        
    End while
Return 
