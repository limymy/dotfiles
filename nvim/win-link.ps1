[CmdletBinding()]
param(
    [switch]$Uninstall
)

$ErrorActionPreference = 'Stop'

# ------------------ Path setup ------------------
$TargetDir = Join-Path $env:LOCALAPPDATA 'nvim'
$RepoRoot  = Split-Path -Parent $MyInvocation.MyCommand.Definition
$SourceDir = Join-Path $RepoRoot '.config/nvim'

function Remove-Symlink {
    if (Test-Path $TargetDir) {
        $item = Get-Item $TargetDir -Force
        if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) {
            Remove-Item $TargetDir -Force
            Write-Host "Removed symlink at '$TargetDir'."
        } else {
            Write-Warning "'$TargetDir' exists and is not a symlink; aborting uninstall."
        }
    } else {
        Write-Host "Nothing to uninstall – '$TargetDir' not found."
    }
}

if ($Uninstall) {
    Remove-Symlink
    return
}

# ------------------ Install / Update ------------------
if (-not (Test-Path $SourceDir)) {
    throw "Source directory '$SourceDir' not found. Ensure you run the script from inside the git repository that contains the 'nvim' folder."
}

# Backup or remove existing target
if (Test-Path $TargetDir) {
    $item = Get-Item $TargetDir -Force
    if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) {
        Write-Host "Existing symlink detected – refreshing it..."
        Remove-Item $TargetDir -Force
    } else {
        $Backup = "$TargetDir.backup_$(Get-Date -Format 'yyyyMMddHHmmss')"
        Move-Item $TargetDir $Backup
        Write-Host "Existing config moved to '$Backup'."
    }
}

# Create new symbolic link
New-Item -ItemType SymbolicLink -Path $TargetDir -Target $SourceDir | Out-Null

Write-Host "Created symlink:"
Write-Host "    $TargetDir -> $SourceDir"
Write-Host "Done! Launch Neovim to verify that the configuration loads correctly."
