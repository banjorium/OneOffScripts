﻿function Get-WebPage {
<#  
.SYNOPSIS  
   Downloads web page from site.
.DESCRIPTION
   Downloads web page from site and displays source code or displays total bytes of webpage downloaded
.PARAMETER Url
    URL of the website to test access to.
.PARAMETER UseDefaultCredentials
    Use the currently authenticated user's credentials  
.PARAMETER Proxy
    Used to connect via a proxy
.PARAMETER Credential
    Provide alternate credentials 
.PARAMETER ShowSize
    Displays the size of the downloaded page in bytes                 
.NOTES  
    Name: Get-WebPage
    Author: Boe Prox
    DateCreated: 08Feb2011        
.EXAMPLE  
    Get-WebPage -url "http://www.bing.com"
     
Description
------------
Returns information about Bing.Com to include StatusCode and type of web server being used to host the site.
 
#>
[cmdletbinding(
    DefaultParameterSetName = 'url',
    ConfirmImpact = 'low'
)]
    Param(
        [Parameter(
            Mandatory = $True,
            Position = 0,
            ParameterSetName = '',
            ValueFromPipeline = $True)]
            [string][ValidatePattern("^(http|https)\://*")]$Url,
        [Parameter(
            Position = 1,
            Mandatory = $False,
            ParameterSetName = 'defaultcred')]
            [switch]$UseDefaultCredentials,
        [Parameter(
            Mandatory = $False,
            ParameterSetName = '')]
            [string]$Proxy,
        [Parameter(
            Mandatory = $False,
            ParameterSetName = 'altcred')]
            [switch]$Credential,
        [Parameter(
            Mandatory = $False,
            ParameterSetName = '')]
            [switch]$ShowSize                        
                         
        )
Begin {     
    $psBoundParameters.GetEnumerator() | % { 
        Write-Verbose "Parameter: $_" 
        }
    
    #Create the initial WebClient object
    Write-Verbose "Creating web client object"
    $wc = New-Object Net.WebClient 
     
    #Use Proxy address if specified
    If ($PSBoundParameters.ContainsKey('Proxy')) {
        #Create Proxy Address for Web Request
        Write-Verbose "Creating proxy address and adding into Web Request"
        $wc.Proxy = New-Object -TypeName Net.WebProxy($proxy,$True)
        }       
     
    #Determine if using Default Credentials
    If ($PSBoundParameters.ContainsKey('UseDefaultCredentials')) {
        #Set to True, otherwise remains False
        Write-Verbose "Using Default Credentials"
        $wc.UseDefaultCredentials = $True
        }
    #Determine if using Alternate Credentials
    If ($PSBoundParameters.ContainsKey('Credentials')) {
        #Prompt for alternate credentals
        Write-Verbose "Prompt for alternate credentials"
        $wc.Credential = (Get-Credential).GetNetworkCredential()
        }         
         
    }
Process {    
    Try {
        If ($ShowSize) {
            #Get the size of the webpage
            Write-Verbose "Downloading web page and determining size"
            "{0:N0}" -f ($wr.DownloadString($url) | Out-String).length -as [INT]
            }
        Else {
            #Get the contents of the webpage
            Write-Verbose "Downloading web page and displaying source code"
            $wc.DownloadString($url)       
            }
         
        }
    Catch {
        Write-Warning "$($Error[0])"
        }
    }   
}  