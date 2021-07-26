Set-location "C:\scripts"
Copy-item \\irkutsk-uni-1\Logs\ -destination ** -force -recurse
Copy-item \\irkutsk-unit2\Logs\ -destination ** -force -recurse
Copy-item \\irkutsk-unit3\Logs\ -destination ** -force -recurse
Copy-item \\irkutsk-unit4\Logs\ -destination ** -force -recurse
Copy-item \\irkutsk-unit6\Logs\ -destination ** -force -recurse

$PathList = @("")
foreach ($Path in $PathList)
{
$Days = "-5"
$CurrentDate = Get-Date
$OldDate = $CurrentDate.AddDays($Days)
Get-ChildItem $Path -Recurse | Where-Object { $_.LastWriteTime -lt $OldDate } | Remove-Item -recurse -Verbose
}

$PathList = @("")
foreach ($Path in $PathList)
{
$Days = "-60"
$CurrentDate = Get-Date
$OldDate = $CurrentDate.AddDays($Days)
Get-ChildItem $Path -Recurse | Where-Object { $_.LastWriteTime -lt $OldDate } | Remove-Item -recurse -verbose
}

$PathList = @("Z:\Public\!Выгрузки\Терминал1", "")
foreach ($Path in $PathList)
{
$Days = "-70"
$CurrentDate = Get-Date
$OldDate = $CurrentDate.AddDays($Days)
Get-ChildItem $Path -Recurse | Where-Object { $_.LastWriteTime -lt $OldDate } | Remove-Item -recurse -verbose
}