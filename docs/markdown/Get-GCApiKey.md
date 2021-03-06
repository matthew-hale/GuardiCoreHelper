---
external help file: pwsh-GC-help.xml
Module Name: pwsh-GC
online version:
schema: 2.0.0
---

# Get-GCApiKey

## SYNOPSIS
Authenticates with the given management server, and stores a key in a global variable called "GCApiKey".
Alternatively, returns a portable key object on the pipeline for future use.

## SYNTAX

```
Get-GCApiKey [-Server] <String> [-Credential] <PSCredential> [-Export] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
To make GuardiCore API calls, an API token must be included in the headers.
Thus, this first API call must be made; it returns a token that can be used for further API calls.
The token represents a user session, and has the same timeout duration.
The GCApiKey variable includes this token, plus the Uri of the management server that it's authenticated with.
All functions in the module that use this token are able to get the Uri and the token from this variable without further user input.
If using the key as a portable object, functions can optionally take this key as input, instead of referencing the global variable.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-GCApiKey -Server cus-XXXX -Credential api
Password for user api: ******
```

Authenticate to the "cus-XXXX" server using the username "api". Prompts for password.

### Example 2
```powershell
PS C:\> $Cred = Get-Credential api
Password for user api: ******

PS C:\> $ApiKey = Get-GCApiKey -Server cus-XXXX -Credential $Cred -Export
```

Authenticate to the "cus-XXXX" server using a credential object, and store the result in the $ApiKey variable.

## PARAMETERS

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Credential for authentication.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases: Credentials, Cred

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Export
Exports the key on the pipeline instead of setting it to the global variable.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Server
GuardiCore management server, in the format: "cus-XXXX".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### [PSCredential] $Credentials parameter.
## OUTPUTS

### None. This function has no pipeline output.
## NOTES

## RELATED LINKS
