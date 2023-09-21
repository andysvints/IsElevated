# IsElevated

Module for checking if Powershell Console is running in elevated mode.

## Installation

 Module is published to PowerShell Gallery. Use the following command to install
it:

 ```powershell
 Install-Module -Name IsElevated 
 ```

## Cmdlets

Please refer to the comment-based help for more information about these commands.

### Get-ConsoleElevationStatus

This function is checking if Powershell Console is running in elevated mode(as administrator).

#### Syntax


#### Example

```powershell
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
``````

**[Icons created by Freepik - Flaticon](https://www.flaticon.com/free-icons/timer)**
