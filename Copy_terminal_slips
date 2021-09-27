Set-location "C:\Scripts"

$PathList = @("\\192.168.*.*\Slips$", "\\192.168.*.*\Slips", "\\192.168.*.*\Slips", "\\192.168.*.*\Slips", "\\192.168.*.*\Slips")
foreach ($Path in $PathList)
{
$Days = "-100" # удаляем файлы больше 100 дней, можно поставить значение меньше
$CurrentDate = Get-Date
$OldDate = $CurrentDate.AddDays($Days)
Get-ChildItem $Path -Recurse | Where-Object { $_.LastWriteTime -lt $OldDate } | Remove-Item -recurse -verbose
}

Copy-item \\192.168.*.*\Slips$\*.txt -destination "Папка назначения. У меня стоит на общей шаре" -force -recurse -verbose
Copy-item \\192.168.*.*\Slips$\*.txt -destination  -force -recurse -verbose
Copy-item \\192.168.*.*\Slips\*.txt -destination   -force -recurse -verbose
Copy-item \\192.168.*.*\Slips\*.txt -destination   -force -recurse -verbose
Copy-item \\192.168.*.*\Slips\*.txt -destination   -force -recurse -verbose
