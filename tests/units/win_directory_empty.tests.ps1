# Set $ErrorActionPreference to what's set during Ansible execution
$ErrorActionPreference = "Stop"

#Get Current Directory
$Here = Split-Path -Parent $MyInvocation.MyCommand.Path

.$(Join-Path -Path $Here -ChildPath 'test_utils.ps1')

# Update Pester if needed
#Update-Pester

#Get Function Name
$moduleName = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -Replace ".Tests.ps1"

#Resolve Path to Module path
$ansibleModulePath = "$Here\..\..\library\$moduleName.ps1"

Invoke-TestSetup

Function Invoke-AnsibleModule {
    [CmdletBinding()]
    Param(
        [hashtable]$params
    )

    begin {
        $global:complex_args = @{
            "_ansible_check_mode" = $false
            "_ansible_diff"       = $true
        } + $params
    }
    Process {
        . $ansibleModulePath
        return $module.result
    }
}

try {
    Describe 'win_directory_empty' -Tag 'Get' {

        Context 'basic tests' {

            # BeforeAll {
            # }

            It 'Should empty the c:\temp\temp folder' {

                if (-not (Test-Path 'c:\temp\temp') ) {
                    New-Item -Path 'c:\temp\temp' -ItemType Directory |Out-Null
                }
                New-Item -Path 'c:\temp\temp\vmware-a.log' -ItemType File -ErrorAction SilentlyContinue |Out-Null
                New-Item -Path 'c:\temp\temp\newfile' -ItemType File -ErrorAction SilentlyContinue |Out-Null

                $params = @{
                    path = 'c:\temp\temp'
                    exclude = 'vmware-*.log'
                }

                $result = Invoke-AnsibleModule -params $params
                $result.changed | Should -Be $true
            }
        }
    }
}
finally {
    Invoke-TestCleanup
}
