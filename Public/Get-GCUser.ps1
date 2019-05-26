function Get-GCUser {
	[cmdletbinding()]

	param (
		[String]$Name,

		[Switch]$Raw,

		[PSTypeName("GCApiKey")]$ApiKey
	)

	if (GCApiKey-present $ApiKey) {
		if ($ApiKey) {
			$Key = $ApiKey
		} else {
			$Key = $global:GCApiKey
		} 
		$Uri = "/system/users"
	}

	$Body = @{
		username = $Name
	}

	pwsh-gc-get-request -Uri $Uri -Body $Body -ApiKey $Key -Raw:$Raw.IsPresent
}
