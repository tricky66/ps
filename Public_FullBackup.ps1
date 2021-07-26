$CurentDate = (Get-Date -Format "ddMMyy").ToString()  #������� ����
$dir = "C:\Public\" #������� ��� �������������
$backup_local = "C:\Backup_local_copy\"  #������� ��� ��������� �������
$backup = "\\irkutsk-backup\backup$\Share"  #������� �� ������� �������
$arch = "C:\Program Files\7-Zip\7z.exe" #���������

# ����� �� ��������� ���� (����� �������� "�����" � "Distr")
  Get-ChildItem $dir -Force -Exclude 'Distr, '03_��',  | ForEach-Object { 
      & $arch a -tzip ($backup_local+"Public_Full"+$CurentDate+".zip")$_.FullName
      }'

# ����� �� ������ �������
Copy-item $backup_local"Public_Full"$CurentDate".zip" -destination $backup      