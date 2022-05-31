$Source = "duo-win-login-4.2.0.exe"
$Destination = "C:\Windows\Temp\duo-win-login-4.2.0.exe"

# Fill these in from Duo dashboard
$IKEY = "";
$SKEY = "";
$HOST = "";

# If the file isn't in the temp folder, copy it there
If (-Not (Get-ChildItem -Path "C:\Windows\Temp" -Filter "duo-win-login-4.2.0.exe") ) {
  Copy-Item -Path $Source -Destination $Destination
}

# Check to see if application is already installed
$Software = "Duo Authentication for Windows Logon";
$Installed = ((gp HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*).DisplayName -Match "$Software").Length -gt 0

# If app is not installed, install it
If(-Not $Installed) {
	Write-Host "'$Software' not installed."
	Start-Process -Wait -FilePath "$Destination" -ArgumentList '/S', '/V"', '/qn', 'IKEY="$IKEY"', 'SKEY="$SKEY"', 'HOST="$HOST"', 'AUTOPUSH="#1"', 'FAILOPEN="#1"', 'SMARTCARD="#0"', 'RDPONLY="#0""' -PassThru
} else {
	Write-Host "'$Software' is installed."
}
