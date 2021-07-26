Set-location "C:\Program Files\Firebird\Firebird_2_5\bin"
$CurentDate = (Get-Date -Format "yyyyMMdd").ToString()  #������� ����
$Backup_Local = "C:\Backup_local_copy\"  #������� ��� ��������� �������
$backup = ""  #������� �� ������� �������

#~~~~~~~~~~~~~~~~~~~�����~~~~~~~~~~~~~~~~~~~
$ServerSmtp = ""
$Port = 587
$From = ""
$To = ""
$Subject = "������ ����"
$File = "C:\Base\temp\ClearDB.zip"
$User = ""
$Pass = ""
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ��������� ���������� ����� ��������
    Write-Output "������������� ������ ��������" | Out-File C:\Base\temp\ClearDB.log 
    Get-Service UCS_SMonitor,UCS_CashBox,UCS_Ma_Server,SRPTService,UCS_RuServer,UCS_CRPT_SERVER,UCS_Sync_Server,RE_Local_ServerService,KP_LicenseServer | where {$_.status -eq 'running'} | stop-service -Force �PassThru | Out-File C:\Base\temp\ClearDB.log -Append
# ��������� External
    Stop-Process -Name PremieraExternal,PremieraExternal_Monitor -Force
    Write-Output "���������� External"| Out-File C:\Base\temp\ClearDB.log -Append  
# ����� �� ��������� ���� (Out-Null -�������� �������� gbak)
	Write-Output "������� ���� �� ��������� ����"| Out-File C:\Base\temp\ClearDB.log -Append
    .\gbak.exe -v -b -user SYSDBA -pas masterkey C:\KINOPLAN\Base\PREMIERA.FDB $Backup_Local"Premiera_"$CurentDate.gbk | Out-File C:\Base\temp\ClearDB.log -Append | Out-Null
# ��������� ���������� ����� FireBird
    Write-Output "������������� ������ FireBird"| Out-File C:\Base\temp\ClearDB.log -Append
    Get-Service FirebirdGuardianDefaultInstance,FirebirdServerDefaultInstance | where {$_.status -eq 'running'} | stop-service -Force �Passthru | Out-File C:\Base\temp\ClearDB.log -Append
# ����������� �� ��������� ������� � �������������� ���� 
    Write-Output "�������� ���� �� ��������� �������"| Out-File C:\Base\temp\ClearDB.log -Append
    Copy-Item -Path 'C:\KINOPLAN\Base\PREMIERA.FDB' -Destination 'C:\Base\temp\PREMIERA_Old.FDB' 
    Write-Output "��������������� ����"| Out-File C:\Base\temp\ClearDB.log -Append
    Rename-Item -Path 'C:\Kinoplan\Base\PREMIERA.FDB' -NewName "PREMIERA_$CurentDate.FDB"
# ������ ����� FireBird � ������
    Write-Output "��������� ������ FireBird"| Out-File C:\Base\temp\ClearDB.log -Append
    Get-Service FirebirdGuardianDefaultInstance,FirebirdServerDefaultInstance | Foreach { start-service $_.name -passthru; start-service $_.DependentServices -passthru} | Out-File C:\Base\temp\ClearDB.log -Append
        Write-Output "�������� �������� ������� � ������, ������������ ������"| Out-File C:\Base\temp\ClearDB.log -Append
        .\gfix.exe -v -full -user SYSDBA -pas masterkey C:\Base\temp\PREMIERA_Old.FDB | Out-File C:\Base\temp\ClearDB.log -Append | Out-Null
        Write-Output "�������� ����������� ������ ��� ��������������"| Out-File C:\Base\temp\ClearDB.log -Append
        .\gfix.exe -mend -user SYSDBA -pas masterkey C:\Base\temp\PREMIERA_Old.FDB | Out-File C:\Base\temp\ClearDB.log -Append | Out-Null
        Write-Output "������ ����"| Out-File C:\Base\temp\ClearDB.log -Append
        .\gbak.exe -v -b -ig -g -user SYSDBA -pas masterkey C:\Base\temp\PREMIERA_Old.FDB C:\Base\temp\PREMIERA_Clear.FBK | Out-File C:\Base\temp\ClearDB.log -Append | Out-Null
        Write-Output "�������������� ���� ���� � ������� ��������"| Out-File C:\Base\temp\ClearDB.log -Append
        .\gbak.exe -c -v -user SYSDBA -pas masterkey C:\Base\temp\PREMIERA_Clear.FBK C:\Base\temp\PREMIERA_Clear.FDB | Out-File C:\Base\temp\ClearDB.log -Append | Out-Null
# �������� ������ ���� � �������� �������
        Write-Output "�������� ���� � �������� �������"| Out-File C:\Base\temp\ClearDB.log -Append
        Copy-Item -Path 'C:\Base\temp\PREMIERA_Clear.FDB' -Destination 'C:\KINOPLAN\Base\PREMIERA_Clear.FDB' 
        Write-Output "��������������� ����"| Out-File C:\Base\temp\ClearDB.log -Append
        Rename-Item -Path 'C:\KINOPLAN\Base\PREMIERA_Clear.FDB' -NewName "C:\KINOPLAN\Base\PREMIERA.FDB"

# ������ ����� ��������
    Write-Output "��������� ������ ��������"| Out-File C:\Base\temp\ClearDB.log -Append
        Start-Service -Name UCS_SMonitor -PassThru
        Start-Service -Name UCS_CashBox -PassThru
        Start-Service -Name UCS_Ma_Server -PassThru
        Start-Service -Name SRPTService -PassThru
        Start-Service -Name UCS_RuServer -PassThru
        Start-Service -Name UCS_CRPT_SERVER -PassThru
        Start-Service -Name UCS_Sync_Server -PassThru
        Start-Service -Name RE_Local_ServerService -PassThru
        Start-Service -Name KP_LicenseServer -PassThru
    Get-Service -DisplayName UCS* | Out-File C:\Base\temp\ClearDB.log -Append
    Get-Service -DisplayName ��������* | Out-File C:\Base\temp\ClearDB.log -Append

    #Get-Service UCS_SMonitor,UCS_CashBox,UCS_Ma_Server,SRPTService,UCS_RuServer,UCS_CRPT_SERVER,UCS_Sync_Server,RE_Local_ServerService,KP_LicenseServer | Foreach { start-service $_.name -passthru; start-service $_.DependentServices -passthru} | Out-File C:\Base\temp\ClearDB.log -Append
# ������ External
    Write-Output "��������� External"| Out-File C:\Base\temp\ClearDB.log -Append
    Set-location "C:\KINOPLAN\External"   
        C:\KINOPLAN\External\Application_Start.js | Out-File C:\Base\temp\ClearDB.log -Append
		C:\KINOPLAN\External\Application_Monitor.js | Out-File C:\Base\temp\ClearDB.log -Append
        
       


# ���������� ��� ����
    Compress-Archive -Path C:\Base\temp\ClearDB.log -DestinationPath C:\Base\temp\ClearDB.zip -CompressionLevel Optimal

# ���������� ��������� �� �����
    $Att = New-object Net.Mail.Attachment($file)
    $Message = New-Object System.Net.Mail.MailMessage
        $Message.From = $from
        $Message.To.Add($to)
        $Message.Subject = $subject
        $Message.IsBodyHTML = $true
        $Message.Body = "<h1>��������� ������ ����, ���������� ��������� ��� ���� � ������ ��������</h1>"
        $Message.Attachments.Add($Att)
    $smtp = New-Object Net.Mail.SmtpClient($ServerSmtp, $Port)
        $smtp.EnableSSL = $true
        $smtp.Credentials = New-Object System.Net.NetworkCredential($User,$Pass)
    $smtp.Send($Message)
    $Att.Dispose()

# ������� ���������� ��������
    Remove-Item -Path 'C:\Base\temp\*.*' -Force -Recurse



    