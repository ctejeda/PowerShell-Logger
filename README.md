# Custom PowerShell Logger

This repository hosts a custom PowerShell Logger I created to address the need for efficient logging in PowerShell scripts. The logger is flexible and enables easy logging of script outputs to a file. Check out the project here: https://github.com/ctejeda/PowerShell-Logger

## Installation

1. Clone the repository: 
    ```
    git clone https://github.com/ctejeda/PowerShell-Logger.git
    ```
2. Import the module: 
    ```
    Import-Module ./PowerShell-Logger/Invoke-Logger.ps1
    ```

## Basic Usage

You can simply call the Logger by using the following command:

```
Invoke-Logger -Message "This is a test" -Logfile "\path\to\logfile.log"
```

If you check the `Logfile.log`, you should see your logged message. This is the most basic usage of the script. The `-Message` and `-Logfile` flags are mandatory for the script to log the output.

## Additional Flags

### `-Message`

This flag is required to log the output. You can combine static strings and variables like this: 

```
-Message "The user: $uservariable was updated successfully"
```

### `-Logfile`

This flag is required to store the output from the message to a log file specified. You can declare the file in a variable like this: 

```
$Logfile = “c:\users\ctejeda\documents\logfile.log”
```

Then, you can use it like this: 

```
Invoke-Logger -Message "The user: $uservariable was updated successfully" -Logfile $logfile
```

### `-ShowOuput`

This is an optional flag that outputs the log in green. It's ideal for success messages.

### `-ShowWarning`

This is an optional flag that outputs the log in yellow. It's ideal for warning messages.

### `-ShowError`

This is an optional flag that outputs the log in red. It's ideal for error messages. It can be used within `Try` and `Catch` statements like this:

```
Try { 
    Get-Aduser -Identity $uservariable 
} 
Catch {
    Invoke-logger -Message "Error trying to get user $uservariable. Error showed: $_" -ShowError
}
```

## Advanced Usage

For more complex tasks, like logging events in a loop, you can wrap the logger module around a `foreach` loop. Here's an example where we log file sizes in a directory:

```powershell
Get-ChildItem -Path /Users/christophertejeda/testfolder | % {

    Import-Module "/Users/christophertejeda/PowerShell-Logger/Invoke-Logger.ps1"

    $logfile = "/Users/christophertejeda/logfile.log"
    $name = $_.name
    $size = $_.size
    if ($size -gt '2441472') {
        Invoke-Logger -Message "File $name is over 2441472 KBs. The size is $size" -LogFile $logfile -ShowOutput 
    }
    else {
        Invoke-Logger -Message "File $name is under 2441472 KBs. The size is $size" -LogFile $logfile -ShowWarning
    }
}
```

In this script, the logger logs a success message if a file is over 2441472 KBs and a warning message if it's not. The same principle can be applied to error handling using `Try` and `Catch` statements.

```powershell
Get-ChildItem -Path /Users/christophertejeda/testfolder | % {

    Import-Module "/Users/christophertejeda/PowerShell-Logger/Invoke-Logger.ps1"

    $logfile = "/Users/christophertejeda/testfolder/logfile.log"
    $name = $_.name
    $size = $_.size
    try {
        if ($size -gt '2441472') {
            Invoke-Logger -Message "File $name is over 2441472 KBs. The size is $size" -LogFile $logfile -ShowOutput 
        }

        else {
            Invoke-Logger -Message "File $name is under 2441472 KBs. The size is $size" -LogFile $logfile -ShowWarning
        }
    }

    catch {
        Invoke-Logger -Message "Error occured while processing file $name. Error was $_" -LogFile $logfile -ShowError
    }
}
```

I hope this custom PowerShell logger helps the next time you want to log your PowerShell scripts.

Note: Always replace variables like `$uservariable`, `$logfile`, `$name`, `$size` etc. with actual values or variables from your script.
