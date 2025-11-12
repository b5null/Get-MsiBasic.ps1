# 🧩 Get-MsiBasics.ps1

Retrieves Microsoft Installer **Path**, **Name**, **Size**, **ProductName**, **ProductVersion**, and **Manufacturer** information.

---

## 💻 Usage

```powershell
# Import or run directly
PS C:\Users\b5null\Documents> . .\Get-MsiBasics.ps1

# Example: scan default Windows installer folder
PS C:\Users\b5null\Documents> Get-MsiBasics

# Example: specify another directory
PS C:\Users\b5null\Documents> Get-MsiBasics 'D:\Software\*.msi'
```


---

## 📘 Get-Help Output

```powershell
PS C:\Users\b5null\Documents> Get-Help Get-MsiBasics

NAME
    Get-MsiBasics
    
SYNOPSIS
    Retrieves basic information from MSI installer files.
    
SYNTAX
    Get-MsiBasics [[-Pattern] <String>] [<CommonParameters>]
    
DESCRIPTION
    This function scans a target directory (by default C:\Windows\Installer\)
    and queries each .MSI file for:
      - ProductName
      - ProductVersion
      - Manufacturer
    
    It uses the Windows Installer COM object to read the MSI database and
    returns the results as PowerShell objects. You can pipe or export them
    to CSV or table output.
    
RELATED LINKS

REMARKS
    To see the examples, type: "get-help Get-MsiBasics -examples".
    For more information, type: "get-help Get-MsiBasics -detailed".
    For technical information, type: "get-help Get-MsiBasics -full".
```

## Example

```powershell
PS C:\Users\b5null\Documents> Get-MsiBasics


Path           : C:\Windows\Installer\387c2.msi
Name           : 387c2.msi
Size           : 184320
ProductName    : Microsoft Visual C++ 2022 X86 Minimum Runtime - 14.36.32532
ProductVersion : 14.36.32532
Manufacturer   : Microsoft Corporation

Path           : C:\Windows\Installer\387c6.msi
Name           : 387c6.msi
Size           : 184320
ProductName    : Microsoft Visual C++ 2022 X86 Additional Runtime - 14.36.32532
ProductVersion : 14.36.32532
Manufacturer   : Microsoft Corporation

Path           : C:\Windows\Installer\387ca.msi
Name           : 387ca.msi
Size           : 192512
ProductName    : Microsoft Visual C++ 2022 X64 Minimum Runtime - 14.36.32532
ProductVersion : 14.36.32532
```
