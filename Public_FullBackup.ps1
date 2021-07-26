$CurentDate = (Get-Date -Format "ddMMyy").ToString()  #Текущая дата
$dir = "C:\Public\" #Каталог для архивирования
$backup_local = "C:\Backup_local_copy\"  #Каталог для локальных бекапов
$backup = "\\irkutsk-backup\backup$\Share"  #Каталог на сервере бекапов
$arch = "C:\Program Files\7-Zip\7z.exe" #Архиватор

# Бекап на локальный диск (кроме каталога "Обмен" и "Distr")
  Get-ChildItem $dir -Force -Exclude 'Distr, '03_ИТ',  | ForEach-Object { 
      & $arch a -tzip ($backup_local+"Public_Full"+$CurentDate+".zip")$_.FullName
      }'

# Копия на сервер бекапов
Copy-item $backup_local"Public_Full"$CurentDate".zip" -destination $backup      