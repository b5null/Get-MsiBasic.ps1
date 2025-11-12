function Get-MsiBasics {
<#
.SYNOPSIS
Retrieves basic information from MSI installer files.

.DESCRIPTION
This function scans a target directory (by default C:\Windows\Installer\)
and queries each .MSI file for the properties:
- ProductName
- ProductVersion
- Manufacturer

It uses the Windows Installer COM object to read the MSI database and
returns the results as PowerShell objects. You can pipe or export them
to CSV or table output.

.PARAMETER Pattern
Specifies the file search pattern. Defaults to 'C:\Windows\Installer\*.msi'.
You can point it to any directory or use other wildcards (e.g. 'D:\Apps\*.msi').

.EXAMPLE
Get-MsiBasics
Lists ProductName, ProductVersion, and Manufacturer for all MSI files
under C:\Windows\Installer.

.EXAMPLE
Get-MsiBasics 'D:\Software\*.msi' | Export-Csv msi_inventory.csv -NoTypeInformation
Exports MSI information from D:\Software to a CSV file.
#>

  param(
    [string]$Pattern = 'C:\Windows\Installer\*.msi'
  )

  $props = 'ProductName','ProductVersion','Manufacturer'
  $installer = New-Object -ComObject WindowsInstaller.Installer

  Get-ChildItem -Path $Pattern -File | ForEach-Object {
    $db = $null
    try {
      $db = $installer.OpenDatabase($_.FullName, 0)
      $row = [ordered]@{ Path = $_.FullName; Name = $_.Name; Size = $_.Length }
      foreach ($p in $props) {
        $view = $db.OpenView("SELECT Value FROM Property WHERE Property='$p'")
        $view.Execute(); $rec = $view.Fetch()
        $row[$p] = if ($rec) { $rec.StringData(1) } else { 'N/A' }
        $view.Close()
      }
      [pscustomobject]$row
    } catch {
      [pscustomobject]@{
        Path='ERROR: ' + $_.Exception.Message; Name=$_.Name; Size=$_.Length
        ProductName='(error)'; ProductVersion='(error)'; Manufacturer='(error)'
      }
    } finally {
      if ($db) { [void][Runtime.InteropServices.Marshal]::ReleaseComObject($db) }
    }
  }
}
