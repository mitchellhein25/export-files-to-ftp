$source = "c:\test"
$destination = "ftp://localhost:21/New Directory/"
$username = "test"
$password = "test"
# $cred = Get-Credential
$wc = New-Object System.Net.WebClient
$wc.Credentials = New-Object System.Net.NetworkCredential($username, $password)

$files = get-childitem $source -recurse -force
foreach ($file in $files)
{
    $localfile = $file.fullname
    # ??????????
}
$wc.UploadFile($destination, $source)
$wc.Dispose()