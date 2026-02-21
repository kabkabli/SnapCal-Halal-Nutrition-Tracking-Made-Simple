# ====================================
# SnapCal Setup Script - PowerShell
# ====================================
# This script automatically sets up and runs the SnapCal project

param(
    [string]$ProjectPath = "$env:USERPROFILE\Documents\SnapCal"
)

# Colors for better readability
$colors = @{
    'Green'  = 'Green'
    'Yellow' = 'Yellow'
    'Red'    = 'Red'
    'Cyan'   = 'Cyan'
}

Write-Host "=====================================" -ForegroundColor $colors.Green
Write-Host "   SnapCal Setup Script" -ForegroundColor $colors.Green
Write-Host "   Halal Nutrition Tracking" -ForegroundColor $colors.Green
Write-Host "=====================================" -ForegroundColor $colors.Green

# Step 1: Check if Node.js is installed
Write-Host "`n[1/5] Checking Node.js installation..." -ForegroundColor $colors.Yellow

if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Node.js is not installed!" -ForegroundColor $colors.Red
    Write-Host "Please download from: https://nodejs.org/" -ForegroundColor $colors.Cyan
    exit 1
}

$nodeVersion = node --version
Write-Host "✅ Node.js version: $nodeVersion" -ForegroundColor $colors.Green

# Step 2: Check if npm is installed
Write-Host "`n[2/5] Checking npm installation..." -ForegroundColor $colors.Yellow

if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
    Write-Host "❌ npm is not installed!" -ForegroundColor $colors.Red
    exit 1
}

$npmVersion = npm --version
Write-Host "✅ npm version: $npmVersion" -ForegroundColor $colors.Green

# Step 3: Navigate to project directory
Write-Host "`n[3/5] Checking project directory..." -ForegroundColor $colors.Yellow

if (-not (Test-Path "$ProjectPath\package.json")) {
    Write-Host "❌ package.json not found at: $ProjectPath" -ForegroundColor $colors.Red
    Write-Host "Make sure you're in the SnapCal project directory!" -ForegroundColor $colors.Yellow
    exit 1
}

Set-Location $ProjectPath
Write-Host "✅ Project directory: $ProjectPath" -ForegroundColor $colors.Green

# Step 4: Install dependencies
Write-Host "`n[4/5] Installing dependencies (npm install)..." -ForegroundColor $colors.Yellow

npm install

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ npm install failed!" -ForegroundColor $colors.Red
    exit 1
}

Write-Host "✅ Dependencies installed successfully" -ForegroundColor $colors.Green

# Step 5: Start development server
Write-Host "`n[5/5] Starting development server..." -ForegroundColor $colors.Yellow
Write-Host "🌐 The app will be available at: http://localhost:5173" -ForegroundColor $colors.Cyan
Write-Host "📝 Press Ctrl+C to stop the server" -ForegroundColor $colors.Yellow

Write-Host "`n=====================================" -ForegroundColor $colors.Green
Write-Host "✅ Setup Complete! Starting SnapCal..." -ForegroundColor $colors.Green
Write-Host "=====================================" -ForegroundColor $colors.Green

npm run dev
