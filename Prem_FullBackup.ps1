Set-location "C:\Program Files\Firebird\Firebird_2_5\bin"
$CurentDate = (Get-Date -Format "yyyyMMdd").ToString()  #Текущая дата
$backup_local = "C:\Backup_local_copy\"  #Каталог для локальных бекапов
$backup = "\\irkutsk-backup\backup$\Premiere"  #Каталог на сервере бекапов


# Бекап на локальный диск
	.\gbak.exe -v -b -user SYSDBA -pas masterkey C:\KINOPLAN\Base\PREMIERA.fdb $backup_local"Premiera_"$CurentDate.gbk
#	.\gbak.exe -v -b -user SYSDBA -pas masterkey C:\UCS\Bases\CARDSSYSTEM.fdb $backup_local"Cardssystem_"$CurentDate.gbk
# Копия на сервер бекапов
Move-Item $backup_local"Premiera_"$CurentDate".gbk" -destination $backup
#Move-Item $backup_local"Cardssystem_"$CurentDate".gbk" -destination $backup    
