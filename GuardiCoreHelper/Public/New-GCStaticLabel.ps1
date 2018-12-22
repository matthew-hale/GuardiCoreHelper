<#
.SYNOPSIS
	Encapsulates the "POST /assets/labels/{key}/{value}" API call.

.DESCRIPTION
	Creates a static label with given VMs, specified by unique ID. if the given Key/Value pair already exists, the new VMs are appended to the existing label.

.PARAMETER Assets
	[System.Array] Array of GuardiCore asset IDs. Used for static label definitions.

.PARAMETER LabelKey
	[System.String] Key of the label to be updated. Required for both dynamic and static labels.

.PARAMETER LabelValue
	[System.String] Value of the label to be updated. Required for both dynamic and static labels.

.INPUTS
	[System.Array] $Assets parameter.

.OUTPUTS
	application/json

#>
function New-GCStaticLabel {

	[cmdletbinding()]
	param (
		[Parameter(Mandatory=$false,ValueFromPipeline=$true)][System.Array]$AssetIds,
		[Parameter(Mandatory=$true)][System.String]$LabelKey,
		[Parameter(Mandatory=$true)][System.String]$LabelValue
	)
	begin {
		$Key = $global:GCApiKey
		
		$Uri = $Key.Uri + "assets/labels/" + $LabelKey + "/" + $LabelValue
		$Body = [PSCustomObject]@{
			"vms" = @()
		}
	}
	process {
		$Body.vms += foreach ($Asset in $AssetIds) {
			$Asset
		}
	}
	end {
		$BodyJson = $Body | ConvertTo-Json -Depth 99
		Invoke-RestMethod -Uri $Uri -ContentType "application/json" -Authentication Bearer -Token $Key.Token -Body $BodyJson -Method "POST"
	}
}