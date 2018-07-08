﻿function Set-PSFTeppResult
{
<#
	.SYNOPSIS
		Refreshes the tab completion value cache.
	
	.DESCRIPTION
		Refreshes the tab completion value cache for the specified completion scriptblock.
	
		Tab Completion scriptblocks can be configured to retrieve values from a dedicated cache.
		This allows seamless background refreshes of completion data and eliminates all waits for the user.
	
	.PARAMETER TabCompletion
		The name of the completion script to set the last results for.
	
	.PARAMETER Value
		The values to set.
	
	.EXAMPLE
		PS C:\> Set-PSFTeppResult -TabCompletion 'MyModule.Computer' -Value (Get-ADComputer -Filter *).Name
	
		Stores the names of all computers in AD into the tab completion cache of the completion scriptblock 'MyModule.Computer'
#>
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[PSFramework.Validation.PsfValidateSetAttribute(ScriptBlock = { [PSFramework.TabExpansion.TabExpansionHost]::Scripts.Keys } )]
		[string]
		$TabCompletion,
		
		[Parameter(Mandatory = $true)]
		[AllowEmptyCollection()]
		[string[]]
		$Value
	)
	
	begin
	{
		
	}
	process
	{
		[PSFramework.TabExpansion.TabExpansionHost]::Scripts[$TabCompletion.ToLower()].LastResult = $Value
		[PSFramework.TabExpansion.TabExpansionHost]::Scripts[$TabCompletion.ToLower()].LastExecution = ([System.DateTime]::Now)
	}
	end
	{
	
	}
}