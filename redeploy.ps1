Write-Host "Redeploying HCM-Recruitment with fixes..." -ForegroundColor Green

# Clean up previous builds
Write-Host "Cleaning up previous builds..." -ForegroundColor Yellow
if (Test-Path "gen") { Remove-Item -Recurse -Force "gen" }
if (Test-Path "mta_archives") { Remove-Item -Recurse -Force "mta_archives" }
if (Test-Path "resources") { Remove-Item -Recurse -Force "resources" }

# Install dependencies
Write-Host "Installing root dependencies..." -ForegroundColor Yellow
npm ci

# Build UI5 applications
Write-Host "Building UI5 applications..." -ForegroundColor Yellow
Set-Location "app/candidate"
npm install
npm run build:cf
Set-Location "../jobrequisition"
npm install
npm run build:cf
Set-Location "../.."

# Build CAP application
Write-Host "Building CAP application..." -ForegroundColor Yellow
npx cds build --production

# Build MTA
Write-Host "Building MTA archive..." -ForegroundColor Yellow
mbt build --mtar archive

# Deploy to Cloud Foundry
Write-Host "Deploying to Cloud Foundry..." -ForegroundColor Yellow
cf deploy mta_archives/archive.mtar --retries 1

Write-Host "Redeployment completed!" -ForegroundColor Green
Write-Host "Please test your application at: https://44061ef2trial-dev-hcm-recruitment.cfapps.us10-001.hana.ondemand.com/candidate" -ForegroundColor Cyan
