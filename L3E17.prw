#INCLUDE 'TOTVS.CH'

User Function Desceu()
    // Declara��o de vari�veis.
    local cNome     := ""
    local cConcat   := ""
    local nCount    := 0

    // Aqui � solicitado um nome ao usu�rio.
    cNome := upper(FwInputBox("Digite um nome: ", cNome))

    // Iniciado um contador do in�cio ao fim do nome, e cada letra � armazenada em outra vari�vel com quebra de linha ap�s.
    For nCount := 1 to len(cNome)
        cConcat += substr(cNome, nCount, 1) + CRLF
    Next

    // Por fim, � exibido ao usu�rio o nome em formado de cascata.
    FwAlertInfo(cConcat, "Nome")

Return 
