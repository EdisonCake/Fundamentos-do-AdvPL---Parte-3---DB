#INCLUDE 'TOTVS.CH'

User Function Desceu()
    // Declaração de variáveis.
    local cNome     := ""
    local cConcat   := ""
    local nCount    := 0

    // Aqui é solicitado um nome ao usuário.
    cNome := upper(FwInputBox("Digite um nome: ", cNome))

    // Iniciado um contador do início ao fim do nome, e cada letra é armazenada em outra variável com quebra de linha após.
    For nCount := 1 to len(cNome)
        cConcat += substr(cNome, nCount, 1) + CRLF
    Next

    // Por fim, é exibido ao usuário o nome em formado de cascata.
    FwAlertInfo(cConcat, "Nome")

Return 
