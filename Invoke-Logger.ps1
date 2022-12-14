## Invoke Logger 
## By Chris Tejeda
## A custom loggin function 
## Example Command: Invoke-logger -Message "Obtaning Computer Details" -Logfile "c:\temp\test.log" -Showoutput -EmailALert

Function Invoke-Logger {


    [CmdletBinding()]
    param 
    (
        [Parameter(Mandatory=$true)]
        [string]$Message,
        [Parameter(Mandatory=$true)]
        [string]$LogFile,
        [Parameter(Mandatory=$false)]
        [Switch]$ShowOutput,
        [Parameter(Mandatory=$false)]
        [Switch]$SaveToCSV,
        [Parameter(Mandatory=$false)]
        [Switch]$ShowError,
        [Parameter(Mandatory=$false)]
        [Switch]$ShowWarning,
        [Parameter(Mandatory=$false)]
        [Switch]$EmailALert

    )
        
        $date = Get-Date -UFormat "%m/%d/%Y %H:%M:%S"
        $Global:logfile = "$env:USERPROFILE.log"
        Add-Content $LogFile -Value "$date - $Message"
        if ($ShowOutput)
        {$ShowOutput = Write-Host $Message -ForegroundColor Green }
        if ($ShowError)
        {$ShowError = Write-Host $Message -ForegroundColor Red }
        if ($ShowWarning)
        {$ShowWarning = Write-Host $Message -ForegroundColor Yellow }
        if ($SaveToCSV){$array = @(); $array += [pscustomobject] @{"computer" = $computer; "Message" = "$Message"; "Date" = "$date" }; $array | Export-Csv -Path "$env:USERPROFILE\Invoke-VMBuild.csv" -NoTypeInformation }
        $ErrorActionPreference='stop'
        if ($EmailALert) {
        


        $emailsettings = @{
        From = "User@domain.com"
        Subject = "Test-Test"
        To = @("user@domain.com")
        SMTPServer = "InternalMailRelay_That_Does_Not_Require_Authentication"
   
}
        $pass = ConvertTo-SecureString "EmptyPass" -asplaintext -force
        $creds = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "NT AUTHORITY\ANONYMOUS LOGON", $pass
        Send-MailMessage @emailsettings -Body ($Message) -Credential $creds 





}
        
}
