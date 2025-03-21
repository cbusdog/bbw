# Define paths
$serviceName = "SymmetricDS"
$configDir = "C:\jumpmind\conf"
$originalFile = Join-Path $configDir "logback-fixed.xml"
$backupFile = Join-Path $configDir "logback-fixed.xml.bak"
$newFile = "C:\Users\YourUsername\Downloads\logback-fixed-datadog-tagged.xml"  # Update this path if needed

# Stop SymmetricDS
Write-Host "Stopping $serviceName service..."
Stop-Service -Name $serviceName -Force

# Backup current config
if (Test-Path $originalFile) {
    Write-Host "Backing up original logback-fixed.xml..."
    Copy-Item -Path $originalFile -Destination $backupFile -Force
}

# Replace config
Write-Host "Replacing logback-fixed.xml with updated Datadog version..."
Copy-Item -Path $newFile -Destination $originalFile -Force

# Start SymmetricDS
Write-Host "Starting $serviceName service..."
Start-Service -Name $serviceName

# Confirm status
Write-Host "Service status:"
Get-Service -Name $serviceName
