# export-files-to-ftp
This Powershell script detects changes in a directory, and anytime a file is added to the directory, it uploads those files to an FTP server 
(a dummy server is configured at the moment.

It was built for an external software that was exporting files to a folder (testFtp). The script loops over any files in the directory when a file is added, 
uploads them to the ftp that is specified, and copies the files to a new directory (copies) to be stored for archival purposes.

The files are also deleted from testFtp, so it is always empty until new files are exported to it from the software, to avoid copying the same file multiple times.

There is also a logs file that keeps track of which files are copied over, and reports if there are any errors uploading to FTP.
