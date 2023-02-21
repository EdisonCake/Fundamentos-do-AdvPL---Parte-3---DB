#INCLUDE 'TOTVS.CH'

User Function MediaTemp()
    local aMes   := {"Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"}
    local aTemp  := {}
    local cExibe := ""
    local nUser  := 0
    local nMedia := 0
    local nSoma  := 0
    local nCount := 0

    For nCount := 1 to 12
        nUser := Val(FwInputBox("Digite a temperatura média do mês de " + aMes[nCount]))
        aAdd(aTemp, nUser)

        nSoma += nUser
    Next

    nMedia := (nSoma / 12)

    For nCount := 1 to 12
        if aTemp[nCount] > nMedia
            cExibe += aMes[nCount] + ": " + cvaltochar(aTemp[nCount]) + "°C" + CRLF
        endif
    Next

    FwAlertInfo(cExibe,"Média Anual: " + cvaltochar(nMedia) + "°C")

Return
