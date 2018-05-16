Import-Module Boxstarter.Chocolatey

New-PackageFromScript -Source roles\Base_env.ps1 -PackageName CB911.Baseenv
Install-BoxstarterPackage -Package CB911.Baseenv