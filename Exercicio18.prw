#INCLUDE 'TOTVS.CH'

User Function Escada()  
    // Declara��o de vari�veis
    local cNome         := ""
    local cConcatena    := ""
    local nCount        := 0

    // Aqui � solicitado ao usu�rio um nome, e o mesmo j� � armazenado com todas as letras mai�sculas na vari�vel correspondente.
    cNome := Upper(FwInputBox("Digite seu nome:", cNome))

    // � iniciado um contador finito, para fazer a concatena��o de cada letra em formato de escada.
    For nCount := 1 to len(cNome)
        cConcatena += substr(cNome, 1, nCount) + CRLF
    Next

    // E por fim, � exibido ao usu�rio o nome no formato concatenado.
    FwAlertInfo(cConcatena, "Escadinha!")

Return 
