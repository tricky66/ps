# Делаем папку на общей шаре, куда будут сохраняться скрины. Добавить права на папку юзеру который авторизован на кассе. В основном только чтение и запись.
$Path = "\\irk-share\Public\03_ИТ\Screen_Unicash\uni4"
#~~~~~~~~~~~~~~~~~~~Почта~~~~~~~~~~~~~~~~~~~
$ServerSmtp = "uk-exchange-cas.ts.sys"
$Port = 587
$From = "irkutsk_robot@kinomax.ru"
$To = ""
$Subject = $env:computername
$User = "irkutsk_robot"
$Pass = ""
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Add-Type -AssemblyName System.Windows.Forms
$screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
$image = New-Object System.Drawing.Bitmap($screen.Width, $screen.Height)
$graphic = [System.Drawing.Graphics]::FromImage($image)
$point = New-Object System.Drawing.Point(0, 0)
$graphic.CopyFromScreen($point, $point, $image.Size);
$cursorBounds = New-Object System.Drawing.Rectangle([System.Windows.Forms.Cursor]::Position, [System.Windows.Forms.Cursor]::Current.Size)
[System.Windows.Forms.Cursors]::Default.Draw($graphic, $cursorBounds)
$screen_file = "$Path\" + $env:computername + "_" + $env:username + "_" + "$((get-date).tostring('yyyy.MM.dd-HH.mm.ss')).png"
$image.Save($screen_file, [System.Drawing.Imaging.ImageFormat]::Png)
$image.Dispose()

# Telegram
$bot_token = "" # Здесь ставим токен своего бота, куда будут приходить скрины
$File=$screen_file
# Прописываем свой chat_id и курлом передаем пикчу.
C:\curl\bin\curl.exe -F chat_id="" -F document="@$File" https://api.telegram.org/bot$bot_token/sendDocument

#Делаем ярлык и выносим его в быстрый доступ. 

# Отправляем результат на почту
    $Att = New-object Net.Mail.Attachment($screen_file)
    $Message = New-Object System.Net.Mail.MailMessage
        $Message.From = $from
        $Message.To.Add($to)
        $Message.Subject = $subject
        $Message.IsBodyHTML = $true
        $Message.Body = "<h1>screen</h1>"
        $Message.Attachments.Add($Att)
    $smtp = New-Object Net.Mail.SmtpClient($ServerSmtp, $Port)
        $smtp.EnableSSL = $false
        $smtp.Credentials = New-Object System.Net.NetworkCredential($User,$Pass)
    $smtp.Send($Message)
    $Att.Dispose()
