# Cab File Text Generator

This simple powershell utility iterates through all files in a folder and appends the absolute filepath for each file to a text file. If the directory changes, the `.Set DestinationDir=` command is appended to the file with the relative directory of the file before the line with the absolute filepath. This allows for makecab to run without errors when making a cab file with many folders and files.

## Usage

1. Run powershell
2. Navigate to the directory with this script and run it with `.\run.ps1`
3. Input the path to the folder that you wish to compress as a cab file
4. Input the path to the text file you wish to use to store the files in your cab directory in
5. Once the script is done, open command prompt and run:
`makecab /d CabinetName1=<cab_name>.cab /D DiskDirectoryTemplate=C:\<path_to_store_the_cab_file> /f c:\<path_to_text_file_generated_by_powershell>`
6. Make a directory where you wish to extract your cab file contents
7. To extract the cab file run `expand MyCab.cab -F:* C:\<destination_folder>`

Note: to extract only a single file from the cab file instead of all files, replace the `*` in step 7 with the filename you want without the path to it. ex/`expand MyCab.cab -F:file.txt C:\<destination_folder>`. You only want the filename with no absolute or relative filepath, cab will find the file for you

## Example

- `.\run.ps1`
- C:\Users\User\Cab\MyFolder
- C:\Users\User\Cab\files.txt
- `makecab /d CabinetName1=MyCab.cab /D DiskDirectoryTemplate=C:\Users\User\Cab /f c:\users\user\cab\files.txt`
- `mkdir extracted`
- `expand MyCab.cab -F:* C:\Users\User\Cab\extracted`
