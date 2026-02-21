# PowerShell script to set up the SnapCal Halal Nutrition Tracking application.

# Set execution policy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process

# Create required directories
$directories = @('Data', 'Logs', 'Config')
foreach ($directory in $directories) {
    if (-Not (Test-Path -Path $directory)) {
        New-Item -ItemType Directory -Path $directory
    }
}

# Download the latest requirements
Invoke-WebRequest -Uri 'https://example.com/requirements.zip' -OutFile 'requirements.zip'

# Unzip the requirements
Expand-Archive -Path 'requirements.zip' -DestinationPath 'Data'

# Clean up
Remove-Item -Path 'requirements.zip' -Force

Write-Host 'Setup completed successfully!'