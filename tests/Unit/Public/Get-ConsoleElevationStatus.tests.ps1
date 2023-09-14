$ProjectPath = "$PSScriptRoot\..\..\.." | Convert-Path
$ProjectName = ((Get-ChildItem -Path $ProjectPath\*\*.psd1).Where{
        ($_.Directory.Name -match 'source|src' -or $_.Directory.Name -eq $_.BaseName) -and
        $(try { Test-ModuleManifest $_.FullName -ErrorAction Stop } catch { $false } )
    }).BaseName

Import-Module $ProjectName

InModuleScope $ProjectName {
    Describe Get-ConsoleElevationStatus {

        Context 'Return values' {
            BeforeEach {
                $return = Get-ConsoleElevationStatus
            }

            It 'Returns a single object' {
                ($return | Measure-Object).Count | Should -Be 1
            }

            It 'Returns an object with the expected properties' {
                $return.IsElevated | Should -Not -BeNullOrEmpty
            }

            It 'Returns short output when -Short is specified' {
                $(Get-ConsoleElevationStatus -Short) | Should -BeOfType boolean
            }

        }

        Context 'ShouldProcess' {
            It 'Supports WhatIf' {
                (Get-Command Get-ConsoleElevationStatus).Parameters.ContainsKey('WhatIf') | Should -Be $true
                { Get-ConsoleElevationStatus -WhatIf } | Should -Not -Throw
            }

        }
    }
}
