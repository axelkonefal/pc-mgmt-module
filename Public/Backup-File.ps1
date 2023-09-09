<#

.SYNOPSIS

A function for backuping desired folder to the .zip format.

.DESCRIPTION

This function is used to back up designated folders. The function performs compression of a folder to zip format and then moves the given compressed file to the indicated location. The zip file has a default name but can be changed freely.

.PARAMETER path

Specifies a path to be backed up.

.PARAMETER backupDirectory

Specifies a path for a backup location.

.PARAMETER backupName

Specifies a backup name. by default the syntax is "Backup_$(Get-Date -Format "MMddyyyy")" but can be changed freely by user.

.EXAMPLE

Backup-File -path C:\Temp\SomeImportantFile -backupDirectory C:\Temp

Creates a backup of all files inside "C:\Temp\SomeImportantFile" in .zip format and gives it a name: "Backup_MMddYYYY.zip". Then moves it to the "C:\Temp" directory

.EXAMPLE

Backup-File -path C:\Temp\SomeImportantFile -backupDirectory C:\Temp -backupName "randomName"

Creates a backup of all files inside "C:\Temp\SomeImportantFile" in .zip format and gives it a name: "randomName.zip". Then moves it to the "C:\Temp" directory

.EXAMPLE

backup-file -path "" -backupDirectory "C:\Temp"

Backup-File : Cannot validate argument on parameter 'path'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again.

At line:1 char:23

+ backup-file -path "" -backupDirectory "C:\Temp"

+                       ~~

    + CategoryInfo          : InvalidData: (:) [Backup-File], ParameterBindingValidationException

    + FullyQualifiedErrorId : ParameterArgumentValidationError,Backup-File

 

.NOTES

    Name: Backup-File

    Author: Axel Konefał

    DateCreated: 09.09.2023

#>

function Backup-File {

    param (

        # Parameter help description

        [Parameter(Mandatory = $true,

            Position = 0)]

        [ValidateNotNull()]

        [ValidateNotNullOrEmpty()]

        [string]$path,

 

        # Parameter help description

        [Parameter(Mandatory = $true,

            Position = 1)]

        [ValidateNotNull()]

        [ValidateNotNullOrEmpty()]

        [string]$backupDirectory,

 

        # Parameter help description

        [Parameter(Mandatory = $false,

            Position = 2)]

        [string]$backupName = "Backup_$(Get-Date -Format "MMddyyyy")"

    )

 

    begin{

        if(($path -eq $null) -or ($path -eq "") -or (!(Test-path -path $path -filter any))){

            throw "Invalid directory to be backed up"

        }

        if(($backupDirectory -eq $null) -or ($backupDirectory -eq "") -or (!(Test-path -path $backupDirectory -filter any))){

            throw "Invalid backup destination folder"

        }

    }

 

    process{        

        try {

            $backupname += ".zip"

            $zipPath = Join-Path $path -ChildPath $backupName

            Compress-Archive -Path $path\* -DestinationPath $zipPath -Force

            Move-Item -Path $zipPath -Destination $backupDirectory -ErrorAction Stop            

           

        }

        catch [System.IO.IOException]{

            throw "The file with given backup name is already created in one of given directories"

        }

        catch {

            throw "An error ocurred while performing a function"

        }

    }

 

   

}