$sitename = Read-Host "Please enter a website in the format: 'http://site.com'"

Begin {
    $web = New-Object System.Net.WebClient
    $flag = $false
    }
Process {
    While ($flag -eq $false) {
            Try {
                $web.DownloadString($sitename)
                $flag = $true
                }
            Catch {
                Write-Host -ForegroundColor Red -NoNewline "Access Down..."
                 }
            }
        }
End {
    Write-Host -ForegroundColor Green "Access is Up!"
    }

