# Show message box popup and return the button clicked by the user.
function Read-MessageBoxDialog([string]$Message, [string]$WindowTitle, [System.Windows.Forms.MessageBoxButtons]$Buttons = [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]$Icon = [System.Windows.Forms.MessageBoxIcon]::None)
{
    Add-Type -AssemblyName System.Windows.Forms
    return [System.Windows.Forms.MessageBox]::Show($Message, $WindowTitle, $Buttons, $Icon)
}

# Show input box popup and return the value entered by the user.
function Read-InputBoxDialog([string]$Message, [string]$WindowTitle, [string]$DefaultText)
{
    Add-Type -AssemblyName Microsoft.VisualBasic
    return [Microsoft.VisualBasic.Interaction]::InputBox($Message, $WindowTitle, $DefaultText)
}

git add .
$changes = git status --short
$changes = $changes.Split([Environment]::NewLine)
foreach($change in $changes) {
    $index = $changes.IndexOf($change)
    $change = $change.Replace("A ", "Added: ")
    $change = $change.Replace("M ", "Modified: ")
    $changes[$index] = $change
}

$prompt = "The following files have been modified. Please enter a message to describe your changes. `n $changes"
$multiLineText = Read-MultiLineInputBoxDialog -Message $prompt -WindowTitle "Changes" -DefaultText "Enter update message here..."

$textEntered = Read-InputBoxDialog -Message "Please enter the word 'Banana'" -WindowTitle "Input Box Example" -DefaultText "Enter update message here..."
if ($textEntered -eq $null) { Write-Host "You clicked Cancel" }
elseif ($textEntered -eq "Banana") { Write-Host "Thanks for typing Banana" }
else { Write-Host "You entered $textEntered" }


if ($multiLineText -eq $null) { Write-Host "You clicked Cancel" }
else { 
    $result = git commit -m $multiLineText

    $buttonClicked = Read-MessageBoxDialog -Message $result -WindowTitle "Result" -Buttons OKCancel -Icon Exclamation
    if ($buttonClicked -eq "OK") { Write-Host "Thanks for pressing OK" }
    else { Write-Host "You clicked $buttonClicked" }
}


