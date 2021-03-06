# pwsh-GC
A collection of Powershell Core functions and scripts for GuardiCore Centra administration and management.

## Project status

This project has been abandoned for the time being. As I no longer work for a company that uses GuardiCore, I don't have any access to a GuardiCore instance with which to develop this API wrapper. Feel free to fork and continue work on it if you wish.

## Roadmap
+ Complete help files & pester tests
+ Implement Windows PowerShell compatibility (if possible without significant issue)
+ Rework pipeline and parameter functionality (heavily utilize ValueFromPipelineByPropertyName)

    Currently, lots of parameters aren't in an ideal state. Ideally, any time you want to refer to a known object, you should be able to do so by ID, Name, or by passing in the object itself. The best way to accomplish this is to utilize ValueFromPipelineByPropertyName, and named parameter sets.

+ Complete implementation of map functionality
+ Complete implementation of the following API endpoints:
    + /agent\_aggregators
    + /collectors
    + /system-events
    + /system/audit-log
    + /rbac/\*

## What is this?
The pwsh-GC module is essentially a wrapper for GuardiCore's management server API. It also contains functions that help in using the API, such as ConvertTo/ConvertFrom-GCUnixTime, Get-GCFlowTotal, etc. The other scripts in this repository are used when working with data from the API - for example, Copy-GCLabel.ps1 can copy an existing label to a new one. The module is written for PowerShell Core (PS 6.x); you will need to install PowerShell Core in order to use this module.

## Installation
Install PowerShell Core from the PowerShell github repository, here:\
https://github.com/powershell/powershell

### PowerShellGet
pwsh-GC is available on the PowerShell Gallery, and can thus be installed using PowerShellGet.

Install the pwsh-GC module with PowerShellGet:
```PowerShell
Install-Module pwsh-GC
```

### Manual
To manually use the module, you can simply import the module file directly.

Download/clone the pwsh-GC repository, and import the module:
```PowerShell
Import-Module ./pwsh-GC.psd1
```

## Use
Either use/write scripts that utilize the functions, or use them directly from the command line.

### Authentication
After you import the module, authenticate with the server **(Note: 2-factor authentication cannot be enabled for the account you use)**:
```PowerShell
Get-GCApiKey -Server "cus-XXXX" -Credentials $Creds
```
where $Creds is a PowerShell credential object (you can call Get-Credential). Alternatively, just supply a username, and it will prompt for your password, or leave it out, and PowerShell will prompt for both username and password.

This function saves the api token to a global variable called $GCApiKey that is used automatically by the rest of the functions in the module; there's no need to store it and manually enter it each time. It works like a typical GuardiCore user session, with the same timeout value. **Note: exiting the PowerShell session will require that you re-authenticate.**

You also have the option of using the -Export parameter, which will output the object on the pipeline for manual use. This option is good for running a number of API calls across multiple different environments, or if you just want to do a quick call without discarding your current session.

### Examples
Create a static label from an array of hostnames:

```PowerShell
$Hostnames = @(
  "Example-DC",
  "Example-WSUS",
  "Example-Web"
)
$Assets = foreach ($VM in $Hostnames) {
  Get-GCAsset -Search $VM
}
$Assets | New-GCStaticLabel -LabelKey "Example" -LabelValue "Demo"
```
returns:
```PowerShell
id                                   name          key     value
--                                   ----          ---     -----
XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX Example: Demo Example Demo
```
