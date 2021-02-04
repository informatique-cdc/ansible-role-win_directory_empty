#!powershell

#AnsibleRequires -CSharpUtil Ansible.Basic

$spec = @{
    options             = @{
        path    = @{ type = "list"; elements = "str"; required = $true }
        exclude = @{ type = "list"; elements = "str"; required = $false }
    }
    supports_check_mode = $true
}

$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)

$path = $module.Params.path
$exclude = $module.Params.exclude

$allpaths = @()

$module.Result.changed = $false

foreach ($fullpath in $path ) {
    if (Test-Path -LiteralPath $fullpath) {
        $allpaths += Join-Path -Path $fullpath -ChildPath '*'
    }
}

$GetChildItemParams = @{
    Path = $allpaths
}

$RemoveItemParams = @{
}

if ($exclude) {
    $GetChildItemParams.Exclude = $exclude
    $RemoveItemParams.Exclude = $exclude
}

if ($module.CheckMode) {
    $GetChildItemParams.WhatIf = $true
    $RemoteItemParams.WhatIf = $true
}

$Files = (Get-ChildItem @GetChildItemParams -Recurse -ErrorAction SilentlyContinue)

if (($Files | Measure-Object).Count -gt 0) {
    $Files | Remove-Item @RemoveItemParams -ErrorAction SilentlyContinue -Force -Recurse
    $module.Result.changed = $true
}

# Return result
$module.ExitJson()
