#INCLUDE 'TOTVS.CH'

User Function ContaLetra()
    // Declara��o de vari�veis.
    local cFrase    := ""
    local nCount    := 0
    local nA        := 0
    local nE        := 0
    local nI        := 0
    local nO        := 0
    local nU        := 0
    local nSpace    := 0

    // Aqui � solicitado ao usu�rio uma frase, e a vari�vel j� recebe a frase digitada em letras mai�sculas.
    cFrase := upper(FwInputBox("Digite uma frase: ", cFrase))

    // � realizado uma verifica��o de cada letra e cada informa��o � acrescida na vari�vel referente.
    For nCount := 1 to len(cFrase)
        do case
            case substr(cFrase, nCount, 1) == "A"
                nA++
            case substr(cFrase, nCount, 1) == "E"
                nE++
            case substr(cFrase, nCount, 1) == "I"
                nI++
            case substr(cFrase, nCount, 1) == "O"
                nO++
            case substr(cFrase, nCount, 1) == "U"
                nU++
            case substr(cFrase, nCount, 1) == " "
                nSpace++
        end case
    Next

    // Por fim, � exibido ao usu�rio as informa��es anteriormente acrescidas.
    FwAlertInfo("Na frase " + cFrase + " existem: " + CRLF + CRLF +;
                cvaltochar(nA) + " letras A;" + CRLF +;
                cvaltochar(nE) + " letras E;" + CRLF +;
                cvaltochar(nI) + " letras I;" + CRLF +;
                cvaltochar(nO) + " letras O;" + CRLF +;
                cvaltochar(nU) + " letras U;" + CRLF +;
                cvaltochar(nSpace) + " espa�os.","Contador")
Return 
