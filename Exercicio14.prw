#INCLUDE 'TOTVS.CH'

User Function ArrayFiller()
    local aNumeros := {}
    local nUser    := 0
    local nCount   := 0
    
    For nCount := 1 to 5
        nUser := int(val(FwInputBox("Digite um número: " + cvaltochar(nCount) + "/5")))

        aAdd(aNumeros, nUser)
    Next

    MostraArray(aNumeros)

Return 

Static Function MostraArray(aArray)
    local nCount := 0
    local cExibe := ""

    For nCount := 1 to 5
        if nCount < 5
            cExibe += cvaltochar(aArray[nCount]) + ", "
        else
            cExibe += cvaltochar(aArray[nCount]) + "."
        endif
    Next

    MsgInfo(cExibe, "Array")

Return 
