### SET FOLDER TO WATCH + FILES TO WATCH + SUBFOLDERS YES/NO
    $watcher = New-Object System.IO.FileSystemWatcher
    $watcher.Path = "c:/testFtp" #<---------------ENTER ORIGINAL FOLDER EXESS EXPORTS TO HERE
    $watcher.Filter = "*.*"
    $watcher.IncludeSubdirectories = $true
    $watcher.EnableRaisingEvents = $true  

### DEFINE ACTIONS AFTER AN EVENT IS DETECTED
    $action = { 
       
        $path = $Event.SourceEventArgs.FullPath
        $changeType = $Event.SourceEventArgs.ChangeType
        $logs = "C:/test/log.txt" #ENTER THE LOCATION FOR CHANGE LOG OF THE EXESS EXPORT FOLDER

        ### Set the folder locations
        $source = "c:/testFtp"      # <---------------ENTER ORIGINAL FOLDER EXESS EXPORTS TO HERE
        $ftpdestination = "ftp://dlpuser:rNrKYTX9g7z3RgJRmxWuGHbeu@ftp.dlptest.com/" #<---------------ENTER FTP DESTINATION HERE (ftp://{user}{password}@{ftp.com}/)
        $copydestination = "C:/copies" #<---------------ENTER LOCATION FOR COPIES OF FILES TO END UP

        ###Copy the files to ftp and to copy destination
        $webclient = New-Object -TypeName System.Net.WebClient
        $files = Get-ChildItem $source
        foreach ($file in $files)
        {
            Write-Host "Uploading $file"
            try {
                $webclient.UploadFile("$ftpdestination/$file", $file.FullName)
            } catch {
                Add-content "$logs" -value "There was an error uploading to ftp" 
            }
            
            Write-Host "$source/$file"
            Copy-Item "$source/$file" -Destination "$copydestination"
            Remove-Item "$source/$file"
            $logline = "$(Get-Date), Added File: $file to $copydestination"
            Add-content "$logs" -value $logline 
        } 

        $webclient.Dispose()
              }    
### DECIDE WHICH EVENTS SHOULD BE WATCHED (Created is what we want)
    Register-ObjectEvent $watcher "Created" -Action $action
    # Register-ObjectEvent $watcher "Changed" -Action $action
    # Register-ObjectEvent $watcher "Deleted" -Action $action
    # Register-ObjectEvent $watcher "Renamed" -Action $action
    while ($true) {sleep 5}

