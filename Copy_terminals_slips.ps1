Set-location "C:\Scripts"

$PathList = @("\\192.168.145.30\Slips$", "\\192.168.145.31\Slips", "\\192.168.145.32\Slips", "\\192.168.145.34\Slips", "\\192.168.145.35\Slips")
foreach ($Path in $PathList)
{
$Days = "-100"
$CurrentDate = Get-Date
$OldDate = $CurrentDate.AddDays($Days)
Get-ChildItem $Path -Recurse | Where-Object { $_.LastWriteTime -lt $OldDate } | Remove-Item -recurse -verbose
}

Copy-item \\192.168.145.30\Slips$\*.txt -destination Z:\Public\!��������\��������1 -force -recurse -verbose
Copy-item \\192.168.145.31\Slips$\*.txt -destination Z:\Public\!��������\��������2 -force -recurse -verbose
Copy-item \\192.168.145.32\Slips\*.txt -destination Z:\Public\!��������\��������3 -force -recurse -verbose
Copy-item \\192.168.145.34\Slips\*.txt -destination Z:\Public\!��������\��������4 -force -recurse -verbose
Copy-item \\192.168.145.35\Slips\*.txt -destination Z:\Public\!��������\��������5 -force -recurse -verbose
