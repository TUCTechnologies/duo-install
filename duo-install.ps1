$Source = "duo-win-login-4.2.0.exe"
$Destination = "C:\Windows\Temp\duo-win-login-4.2.0.exe"

If (-Not (Get-ChildItem -Path "C:\Windows\Temp" -Filter "duo-win-login-4.2.0.exe") ) {
  Copy-Item -Path $Source -Destination $Destination
}

$Software = "Duo Authentication for Windows Logon";
$Installed = ((gp HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*).DisplayName -Match "$Software").Length -gt 0

If(-Not $Installed) {
	Write-Host "'$Software' not installed."
	Start-Process -Wait -FilePath "$Destination" -ArgumentList '/S', '/V"', '/qn', 'IKEY=""', 'SKEY=""', 'HOST=""', 'AUTOPUSH="#1"', 'FAILOPEN="#1"', 'SMARTCARD="#0"', 'RDPONLY="#0""' -PassThru
} else {
	Write-Host "'$Software' is installed."
}
