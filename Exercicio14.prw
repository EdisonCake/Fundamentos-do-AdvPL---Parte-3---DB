#INCLUDE 'TOTVS.CH'

User Function ArrayFiller()
    // Declaração de variáveis.
    local aNumeros := {}
    local nUser    := 0
    local nCount   := 0
    
    // Iniciado um contador finito para o registro dos números solicitado ao usuário através de um array.
    For nCount := 1 to 5
        nUser := int(val(FwInputBox("Digite um número: " + cvaltochar(nCount) + "/5")))

        aAdd(aNumeros, nUser)
    Next

    // Dentro do programa principal é chamada uma função que faz a exibição do array preenchido anteriormente.
    MostraArray(aNumeros)

Return 

// Função para exibir o array.
Static Function MostraArray(aArray)
    // Declaração de variáveis da função.
    local nCount := 0
    local cExibe := ""

    // Iniciado um contador para fazer a concatenação dos números em uma variável de texto, com separação por vírgula e finalização com ponto final.
    For nCount := 1 to 5
        if nCount < 5
            cExibe += cvaltochar(aArray[nCount]) + ", "
        else
            cExibe += cvaltochar(aArray[nCount]) + "."
        endif
    Next

    // Por fim, a função exibe ao usuário o array digitado anteriormente.
    MsgInfo(cExibe, "Array")

Return 
