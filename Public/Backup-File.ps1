<#

.SYNOPSIS

A function for backuping desired folder to the .zip format

.DESCRIPTION

This function is used to back up designated folders. The function performs compression of a folder to zip format and then moves the given compressed file to the indicated location. The zip file has a default name but can be changed freely.

.PARAMETER Param1

Parameter description

.PARAMETER Param2

Parameter description

.EXAMPLE

A sample command that uses the function or script, optionally followed by sample output and a description. Repeat this keyword for each example.

.NOTES

    Name: New-FunctionName2

    Author: First Last

    DateCreated: DATE

.FUNCTIONALITY

FunctionName Functionality

#>

function Backup-File {

    param (

        # Parameter help description

        [Parameter(Mandatory = $true,

            Position = 0)]

        [ValidateNotNull()]

        [ValidateNotNullOrEmpty()]

        [string]$filePath,

 

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

 

    process{

 

    }

 

    end{

 

    }

   

}