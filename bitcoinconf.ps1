$rpcPassword = (-Join ((65..90) + (97..122) | Get-Random -Count 33 | % {[char]$_}))
New-Item -Path $env:APPDATA -ItemType "directory" -Name "bitcoin" -ErrorAction Ignore
$dir = "$env:APPDATA\bitcoin\"
if (Test-Path "$dir\bitcoin.conf") 
{
  Remove-Item "$dir\bitcoin.conf"
}
New-Item -Path $dir -ItemType "file" -Name "bitcoin.conf"
Add-Content "$dir\bitcoin.conf" "datadir=$dir"
Add-Content "$dir\bitcoin.conf" "printtoconsole=1"
Add-Content "$dir\bitcoin.conf" "disablewallet=1"
Add-Content "$dir\bitcoin.conf" "rpcuser=bitcoinrpc"
Add-Content "$dir\bitcoin.conf" "rpcpassword=$rpcPassword"
Get-Content "$dir\bitcoin.conf"