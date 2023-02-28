#INCLUDE 'TOTVS.CH'

User Function Escada()  
    // Declaração de variáveis
    local cNome         := ""
    local cConcatena    := ""
    local nCount        := 0

    // Aqui é solicitado ao usuário um nome, e o mesmo já é armazenado com todas as letras maiúsculas na variável correspondente.
    cNome := Upper(FwInputBox("Digite seu nome:", cNome))

    // É iniciado um contador finito, para fazer a concatenação de cada letra em formato de escada.
    For nCount := 1 to len(cNome)
        cConcatena += substr(cNome, 1, nCount) + CRLF
    Next

    // E por fim, é exibido ao usuário o nome no formato concatenado.
    FwAlertInfo(cConcatena, "Escadinha!")

Return 
