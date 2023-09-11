<#

.SYNOPSIS

A function for grouping files (leafs) in directories.

.DESCRIPTION

The function is to group files in a given location by moving them to folders corresponding to the year of their creation. At the beginning, you specify the time frame for which the files are to be grouped. Then, when the year of creation of a given file falls within the time frame specified earlier, it is moved to the given folder.

.PARAMETER path

Specifies a path to files to be grouped by createdYear.

.PARAMETER startyear

The beginning of the range for which the files will be sorted.

.PARAMETER endYear

The end of the range for which the files will be sorted.

.EXAMPLE

Group-File -path 'C:\temp' -startyear 2020 -endYear 2023

 

    Directory: C:\temp

 

Mode                 LastWriteTime         Length Name

----                 -------------         ------ ----

d-----        11.09.2023     12:53                2020

d-----        11.09.2023     12:53                2021

d-----        11.09.2023     12:53                2022

d-----        11.09.2023     12:53                2023

 

Creates folders from year 2020 to 2023 and moves all files to proper folders.

.EXAMPLE

Group-File -path 'C:\temp' -startyear 2023 -endYear 2023

 

    Directory: C:\temp

 

Mode                 LastWriteTime         Length Name

----                 -------------         ------ ----

d-----        11.09.2023     13:19                2023

 

Creates one folder 2023 and moves all files to proper folder, the rest of files stays untouched.

.EXAMPLE

Group-File -path 'C:\temp' -startyear 2024 -endYear 2023

Start year can not be greater than end year.

At line:48 char:13

+             throw "Start year can not be greater than end year."

+             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    + CategoryInfo          : OperationStopped: (Start year can ... than end year.:String) [], RuntimeException

    + FullyQualifiedErrorId : Start year can not be greater than end year.

.NOTES

    Name: Group-File

    Author: Axel Konefał

    DateCreated: 11.09.2023

#>

 

function Group-File {

    [CmdletBinding()]

    param (

        #parameter help description

        [Parameter(Mandatory = $true,

                   Position = 0)]

        [ValidateNotNullOrEmpty()]

        [string]$path,

 

        #parameter help description

        [Parameter(Mandatory = $true,

                   Position = 1)]

        [ValidateNotNullOrEmpty()]

        [int]$startyear,

 

        #parameter help description

        [Parameter(Mandatory = $true,

                   Position = 2)]

        [ValidateNotNullOrEmpty()]

        [int]$endYear        

    )

   

    begin {

        if(($path -eq $null) -or ($path -eq "") -or (!(Test-path -path $path -filter any))){

            throw "Invalid path."

        }

 

        if($startyear -gt $endYear){

            throw "Start year can not be greater than end year."

        }

    }

   

    process {

        try {

            #creates list of folders to be created and creates if folders don't exist

            $listOfFolders = @($startyear..$endYear)

            $listOfFolders  | ForEach-Object {

                if(!(Test-Path -Path $path\$_ -PathType Container)){

                    New-Item -Path $path -Name $_ -ItemType Directory

                }

            }

           

            # goes through every item in the given path, checks if its a directory or newly created folder.

            # if not, moves file to folder with proper name (name the same as the year file was created)

            get-childitem -Path $path | ForEach-Object {                

                if(!(($_.Mode -eq 'd-----') -or ($listOfFolders.Contains($_.BaseName.ToString)))){

                    $tempItem = $_.CreationTime.ToString('yyyy')

                    if(Test-Path -Path $path\$tempItem -PathType Container){

                        Move-Item -Path $path\$_ -Destination $path\$tempItem -Force

                    }

                }

            }

               

        }

        catch {

            throw

        }

    }

}