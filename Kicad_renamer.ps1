
Add-Type -AssemblyName System.Windows.Forms

# Create the main form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Copy Folder Contents--X to close when Done"
$form.Size = New-Object System.Drawing.Size(450, 250)
$form.StartPosition = "CenterScreen"

# Create a label for source folder
$label1 = New-Object System.Windows.Forms.Label
$label1.Text = "Select the source folder:"
$label1.AutoSize = $true
$label1.Location = New-Object System.Drawing.Point(20, 20)
$form.Controls.Add($label1)

# Create a text box for source folder path
$sourceTextBox = New-Object System.Windows.Forms.TextBox
$sourceTextBox.Size = New-Object System.Drawing.Size(300, 20)
$sourceTextBox.Location = New-Object System.Drawing.Point(20, 50)
$sourceTextBox.ReadOnly = $true
$form.Controls.Add($sourceTextBox)

# Create a button to browse for source folder
$browseSourceButton = New-Object System.Windows.Forms.Button
$browseSourceButton.Text = "Browse"
$browseSourceButton.Location = New-Object System.Drawing.Point(330, 47)
$browseSourceButton.Add_Click({
    $folderDialog = New-Object System.Windows.Forms.FolderBrowserDialog
    if ($folderDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        $sourceTextBox.Text = $folderDialog.SelectedPath
    }
})
$form.Controls.Add($browseSourceButton)

# Create a label for new folder name
$label2 = New-Object System.Windows.Forms.Label
$label2.Text = "Enter new folder name:"
$label2.AutoSize = $true
$label2.Location = New-Object System.Drawing.Point(20, 90)
$form.Controls.Add($label2)

# Create a text box for new folder name
$newFolderTextBox = New-Object System.Windows.Forms.TextBox
$newFolderTextBox.Size = New-Object System.Drawing.Size(300, 20)
$newFolderTextBox.Location = New-Object System.Drawing.Point(20, 120)
$form.Controls.Add($newFolderTextBox)

# Create a button to copy folder contents
$copyButton = New-Object System.Windows.Forms.Button
$copyButton.Text = "Copy Contents"
$copyButton.Location = New-Object System.Drawing.Point(20, 160)
$copyButton.Add_Click({
    $sourceFolder = $sourceTextBox.Text
    $newFolderName = $newFolderTextBox.Text

    if ([string]::IsNullOrWhiteSpace($sourceFolder) -or [string]::IsNullOrWhiteSpace($newFolderName)) {
        [System.Windows.Forms.MessageBox]::Show("Please select source folder and a new folder name. X out of this when done.", "Error", "OK", "Error")
        return
    }

    $destinationFolder = Join-Path (Split-Path -Parent $sourceFolder) $newFolderName

    if (Test-Path $destinationFolder) {
        [System.Windows.Forms.MessageBox]::Show("The folder '$newFolderName' already exists!", "Error", "OK", "Error")
    } else {
        New-Item -ItemType Directory -Path $destinationFolder | Out-Null
        Copy-Item -Path "$sourceFolder\*" -Destination $destinationFolder -Recurse -Force
        
        $global:newfolder = $destinationFolder
        [System.Windows.Forms.MessageBox]::Show("Contents copied successfully to '$destinationFolder'", "Success", "OK", "Information")
    }
})
$form.Controls.Add($copyButton)

# Show the form
$form.Topmost = $true
$form.Add_Shown({$form.Activate()})
[System.Windows.Forms.Application]::Run($form)

 WRITE-HOST "NEW DIRECTORY CREATED: $global:newfolder"

 # Define the target folder
$folderPath = $global:newfolder  # Change this to your actual folder path


 WRITE-HOST "deleting unneeded swill in $global:newfolder"
# Ensure the folder exists
if (Test-Path $folderPath) {
    # Get all files in the folder except the specified extensions
    Get-ChildItem -Path $folderPath -File | Where-Object { 
        $_.Extension -notin @(".kicad_sch", ".kicad_pro", ".kicad_pcb", ".wbk") 
    } | Remove-Item -Force

    Write-Host "Files deleted successfully, except for the specified extensions."
} else {
    Write-Host "The specified folder does not exist."
}


$path = $global:newfolder
$folderName = Split-Path -Path $path -Leaf

write-host "renaming files in $global:newfolder"

# Define the target folder (Change this to your folder path)
$folderPath = $global:newfolder

# Define the prefix string
$prefix = $foldername

# Ensure the folder exists
if (Test-Path $folderPath) {
    # Get all files in the folder
    Get-ChildItem -Path $folderPath -File | ForEach-Object {
        $newName = $prefix + $_.Extension
        #$newPath = Join-Path -Path $folderPath -ChildPath $newName

        # Rename the file
        Rename-Item -Path $_.FullName -NewName $newName
        Write-Host "Renamed: $($_.Name) -> $newName"
    }
    Write-Host "All files have been renamed successfully."
    Write-Host "Boy Howdy! You have created a new good to go Kicad Project Directory."
} else {
    Write-Host "The folder does not exist."
}


 