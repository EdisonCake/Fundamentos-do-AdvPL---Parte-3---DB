#INCLUDE 'TOTVS.CH'

User Function ArrayFiller()
    // Declara��o de vari�veis.
    local aNumeros := {}
    local nUser    := 0
    local nCount   := 0
    
    // Iniciado um contador finito para o registro dos n�meros solicitado ao usu�rio atrav�s de um array.
    For nCount := 1 to 5
        nUser := int(val(FwInputBox("Digite um n�mero: " + cvaltochar(nCount) + "/5")))

        aAdd(aNumeros, nUser)
    Next

    // Dentro do programa principal � chamada uma fun��o que faz a exibi��o do array preenchido anteriormente.
    MostraArray(aNumeros)

Return 

// Fun��o para exibir o array.
Static Function MostraArray(aArray)
    // Declara��o de vari�veis da fun��o.
    local nCount := 0
    local cExibe := ""

    // Iniciado um contador para fazer a concatena��o dos n�meros em uma vari�vel de texto, com separa��o por v�rgula e finaliza��o com ponto final.
    For nCount := 1 to 5
        if nCount < 5
            cExibe += cvaltochar(aArray[nCount]) + ", "
        else
            cExibe += cvaltochar(aArray[nCount]) + "."
        endif
    Next

    // Por fim, a fun��o exibe ao usu�rio o array digitado anteriormente.
    MsgInfo(cExibe, "Array")

Return 
