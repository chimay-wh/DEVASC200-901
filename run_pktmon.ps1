# --- Check admin privilege ---
$admin = ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $admin) {
    Write-Host "This script must be run as Administrator."
    Write-Host "Right-click and choose 'Run as administrator'."
    exit
}

# --- Create output folder ---
$folder = Join-Path $env:USERPROFILE "Desktop\mon"

if (!(Test-Path $folder)) {
    New-Item -ItemType Directory -Path $folder | Out-Null
}

cd $folder

# --- Timestamped filename (single file, no %d) ---
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$filename = "pkt_$timestamp.etl"

Write-Host ""
Write-Host "pktmon is now running."
Write-Host "To stop capture, type:"
Write-Host "    pktmon stop"
Write-Host ""
Write-Host "Output file:"
Write-Host "    $filename"
Write-Host ""

# --- Start pktmon with max size 10GB ---
pktmon start -c -f $filename -s 10240 --pkt-size 0 -m circular