#INCLUDE 'TOTVS.CH'

User Function MediaTemp()
    // Declaração de variáveis.
    local aMes   := {"Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"}
    local aTemp  := {}
    local cExibe := ""
    local nUser  := 0
    local nMedia := 0
    local nSoma  := 0
    local nCount := 0

    // Iniciado um contador finito para o preenchimento da temperatura média referente ao mês.
    For nCount := 1 to 12
        nUser := Val(FwInputBox("Digite a temperatura média do mês de " + aMes[nCount]))
        aAdd(aTemp, nUser)

        // Aqui é realizada a soma de todas as temperaturas.
        nSoma += nUser
    Next

    // E aqui é realizada a média entre as temperaturas
    nMedia := (nSoma / 12)

    // Iniciado um contador finito para fazer a comparação de cada posição do array preenchido anteriormente.
    For nCount := 1 to 12

        // Se o valor for maior ou igual ao da média, a informação é armazenada para o usuário.
        if aTemp[nCount] >= nMedia
            cExibe += aMes[nCount] + ": " + cvaltochar(aTemp[nCount]) + "°C" + CRLF
        endif
    Next

    // E por fim, a mesma é exibida.
    FwAlertInfo(cExibe,"Média Anual: " + cvaltochar(nMedia) + "°C")

Return
