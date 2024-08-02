Function GET-HASHES-MONITOR-FILES{
    
    $pwpath = "C:\Users\Ayad\Documents\NoteFiles\PASSWORD\PASSWORDS.txt"
    
    $filehash = @{}

    $pwfile = Get-Content -Path "C:\Users\Ayad\Documents\NoteFiles\PASSWORD\PASSWORDS.txt"

    $pwhash = Get-FileHash -Path $pwpath -Algorithm SHA512

    "$($pwhash.path)|$($pwhash.Hash)" | Out-File -FilePath .\baseline.txt 

    $filehash.add($pwhash.path, $pwhash.hash)


    while($true){

        start-sleep -Seconds 1

        $hash = Get-FileHash -Path $pwpath -Algorithm SHA512

        if($filehash[$hash.path] -eq $hash.Hash){

        }else {
            "ALERT!!! $($hash.path) HAS CHANGED!!!!: $(Get-Date)" | Out-File -FilePath .\ALERTS
            write-host "ALERT!!! $($hash.path) HAS CHANGED!!!!"
        }
    }
}

GET-HASHES-MONITOR-FILES
