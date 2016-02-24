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
        Catch

Try {
    $web.DownloadString($sitename)
    }
Catch {
    Write-Warning "$($Error[0])"
    }