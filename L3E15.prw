#INCLUDE 'TOTVS.CH'

User Function MediaTemp()
    // Declara��o de vari�veis.
    local aMes   := {"Janeiro", "Fevereiro", "Mar�o", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"}
    local aTemp  := {}
    local cExibe := ""
    local nUser  := 0
    local nMedia := 0
    local nSoma  := 0
    local nCount := 0

    // Iniciado um contador finito para o preenchimento da temperatura m�dia referente ao m�s.
    For nCount := 1 to 12
        nUser := Val(FwInputBox("Digite a temperatura m�dia do m�s de " + aMes[nCount]))
        aAdd(aTemp, nUser)

        // Aqui � realizada a soma de todas as temperaturas.
        nSoma += nUser
    Next

    // E aqui � realizada a m�dia entre as temperaturas
    nMedia := (nSoma / 12)

    // Iniciado um contador finito para fazer a compara��o de cada posi��o do array preenchido anteriormente.
    For nCount := 1 to 12

        // Se o valor for maior ou igual ao da m�dia, a informa��o � armazenada para o usu�rio.
        if aTemp[nCount] >= nMedia
            cExibe += aMes[nCount] + ": " + cvaltochar(aTemp[nCount]) + "�C" + CRLF
        endif
    Next

    // E por fim, a mesma � exibida.
    FwAlertInfo(cExibe,"M�dia Anual: " + cvaltochar(nMedia) + "�C")

Return
