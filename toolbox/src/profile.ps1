Function DirAll { Get-ChildItem -Force $args }
Set-Alias -Name dir -Value DirAll -Option AllScope

function global:prompt
{
    Write-Host -NoNewline -ForegroundColor DarkGreen 'pwsh'
    Write-Host -NoNewline " [$(whoami)@$(hostname)] $($executionContext.SessionState.Path.CurrentLocation)"
    if((git status | Select-Object -First 1) -match 'On branch (.*)') {
        Write-Host -NoNewline -ForegroundColor Cyan " [$($matches[1])] "
    }
    return "`n$('>' * ($nestedPromptLevel + 1)) "
}
