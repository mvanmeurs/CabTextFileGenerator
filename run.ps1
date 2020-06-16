
# Usage: .\run.ps1

$userdirectory = Read-Host -Prompt 'Enter the source path (ex->C:\MyFolder)'
$outputfile = Read-Host -Prompt 'Enter the output path and filename (ex->C:\files.txt)'

$Dir = get-childitem $userdirectory -recurse

if(Test-Path $outputfile){
    Remove-Item $outputfile
}
New-Item $outputfile -ItemType file

$writer = [System.IO.StreamWriter] $outputfile

#options for the cab generator
$writer.WriteLine(".Set CompressionType=LZX")
$writer.WriteLine(".Set CabinetFileCountThreshold=0")
$writer.WriteLine(".Set FolderFileCountThreshold=0")
$writer.WriteLine(".Set FolderSizeThreshold=0")
$writer.WriteLine(".Set MaxCabinetSize=0")
$writer.WriteLine(".Set MaxDiskFileCount=0")
$writer.WriteLine(".Set MaxDiskSize=0")

$lastdir = ""

foreach ($item in $Dir) {

    #check that we are a file and not a directory
    if(!($item -is [System.IO.DirectoryInfo])){

        $fullname = $item.FullName
        $beginningindex = "$fullname".IndexOf("src")
        $endingindex = "$fullname".LastIndexOf($item)
        $mydir = "$fullname".Substring($beginningindex, $endingindex - $beginningindex - 1)

        #if we changed directories, add a new line with the set destination dir command with the relative file path
        if(!($mydir -eq $lastdir)){
            $writer.Write(".Set DestinationDir=")
            $writer.Write($mydir)
            $writer.WriteLine()
            $lastdir = $mydir
        }
        
        #print the files absolute filepath including the filename
        $writer.WriteLine($item.FullName)
    }
}
$writer.Close()
Write-Host "================Done================"