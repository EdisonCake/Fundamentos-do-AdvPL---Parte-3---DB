#INCLUDE 'TOTVS.CH'

User Function ContaLetra()
    local cFrase    := ""
    local nCount    := 0
    local nA        := 0
    local nE        := 0
    local nI        := 0
    local nO        := 0
    local nU        := 0
    local nSpace    := 0

    cFrase := upper(FwInputBox("Digite uma frase: ", cFrase))

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

    FwAlertInfo("Na frase " + cFrase + " existem: " + CRLF + CRLF +;
                cvaltochar(nA) + " letras A;" + CRLF +;
                cvaltochar(nE) + " letras E;" + CRLF +;
                cvaltochar(nI) + " letras I;" + CRLF +;
                cvaltochar(nO) + " letras O;" + CRLF +;
                cvaltochar(nU) + " letras U;" + CRLF +;
                cvaltochar(nSpace) + " espaços.","Contador")
Return 
