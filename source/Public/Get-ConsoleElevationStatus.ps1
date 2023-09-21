function Get-ConsoleElevationStatus
{
    <#
      .SYNOPSIS
      Check if Powershell Console is running in elevated mode.

      .DESCRIPTION
      This function is checking if Powershell Console is running in elevated mode(as administrator).

      .EXAMPLE
      Get-ConsoleElevationStatus

Name             : ConsoleHost
Version          : 7.3.6
InstanceId       : ed83bbad-12c9-4f6f-8ea2-c91761f81e64
UI               : System.Management.Automation.Internal.Host.InternalHostUserInterface
CurrentCulture   : en-US
CurrentUICulture : en-US
PrivateData      : Microsoft.PowerShell.ConsoleHost+ConsoleColorProxy
DebuggerEnabled  : True
IsRunspacePushed : False
Runspace         : System.Management.Automation.Runspaces.LocalRunspace
IsElevated       : False

        .EXAMPLE
   iselevated -short

   True


      .PARAMETER Short
      The Short parameter is the switch that will force short (true/false) output version.

    #>
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'Low'
    )]
    [Alias('iselevated')]
    param
    (
        [switch]
        $Short
    )

    process
    {
        if ($pscmdlet.ShouldProcess("Powershell Console"))
        {
            $IsElevated=$null
            if ($IsLinux)
            {
                Write-Verbose "Running on Linux - checking if user is root"
                $IsElevated=if (sudo -n true 2>&1){$false}else{$true}
            }else{
                Write-Verbose "Running on Windows - checking if user is elevated"
                $IsElevated=$null -ne (whoami /all | select-string S-1-16-12288)
            }
            if ($Short)
            {
                Write-Verbose "Returning only boolean value - $true if elevated and $false otherwise"
                $IsElevated
            }else{
                Write-Verbose "Returning full info about Powershell Console including Elevation Status"
                $Props=[ordered]@{
                    IsElevated=$IsElevated
                    CurrentCulture="$($Host.CurrentCulture)"
                    CurrentUICulture="$($Host.CurrentUICulture)"
                    DebuggerEnabled="$($Host.DebuggerEnabled)"
                    InstanceId="$($Host.InstanceId)"
                    IsRunspacePushed="$($Host.IsRunspacePushed)"
                    Name="$($Host.Name)"
                    OS=$($PSVersionTable.OS)
                    Platform="$($PSVersionTable.Platform)"
                    PSEdition="$($PSVersionTable.PSEdition)"
                    PSVersion="$($Host.Version)"
                }
                $ConsoleHostObj=New-Object -TypeName psobject -Property $Props
                $ConsoleHostObj
            }
    }
    }
}
