# Fixes Applied to Resolve Console Errors

## Issues Identified from Console Logs

### 1. **404 Error - OData Service Not Found**
**Error**: `GET https://44061ef2trial-dev-hcm-recruitment.cfapps.us10-001.hana.ondemand.com/candidate/odata/v4/candidate/` - **404 (Not Found)**

**Root Cause**: The application was trying to access OData service at `/candidate/odata/v4/candidate/` but the service is actually available at `/odata/v4/candidate/`.

**Fix Applied**: Updated router configuration in `app/router/xs-app.json` to handle the path mismatch:

```json
{
  "source": "^/candidate/odata/(.*)$",
  "target": "/odata/$1",
  "destination": "srv-api",
  "authenticationType": "xsuaa",
  "csrfProtection": true
}
```

### 2. **i18n Locale Errors**
**Error**: `The fallback locale 'en' is not contained in the list of supported locales [''] of the bundle 'i18n/i18n.properties'`

**Root Cause**: Complex locale configuration in manifest.json was causing conflicts.

**Fix Applied**: Simplified i18n configuration in both `app/candidate/webapp/manifest.json` and `app/jobrequisition/webapp/manifest.json`:

```json
"i18n": {
  "type": "sap.ui.model.resource.ResourceModel",
  "settings": {
    "bundleName": "candidate.i18n.i18n"
  }
}
```

Removed problematic settings:
- `supportedLocales`
- `fallbackLocale`
- `@i18n` model

### 3. **Service Routing Issues**
**Error**: OData service calls were being made to wrong paths.

**Fix Applied**: Added proper routing rules in router configuration to handle:
- Direct OData calls: `/odata/v4/candidate/`
- App-specific OData calls: `/candidate/odata/v4/candidate/` → `/odata/v4/candidate/`

## Files Modified

### 1. **app/router/xs-app.json**
- Added route to handle `/candidate/odata/` → `/odata/` redirection
- Ensured proper authentication for OData service calls

### 2. **app/candidate/webapp/manifest.json**
- Simplified i18n configuration
- Removed problematic locale settings
- Kept OData service URI as `/odata/v4/candidate/`

### 3. **app/jobrequisition/webapp/manifest.json**
- Simplified i18n configuration
- Removed problematic locale settings
- Kept OData service URI as `/odata/v4/requisition/`

## Deployment Instructions

### Option 1: Use the Redeployment Script
```powershell
.\redeploy.ps1
```

### Option 2: Manual Redeployment
```powershell
# Clean previous builds
Remove-Item -Recurse -Force "gen" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "mta_archives" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "resources" -ErrorAction SilentlyContinue

# Install dependencies
npm ci

# Build UI5 applications
cd app/candidate && npm install && npm run build:cf && cd ../..
cd app/jobrequisition && npm install && npm run build:cf && cd ../..

# Build CAP application
npx cds build --production

# Build MTA
mbt build --mtar archive

# Deploy
cf deploy mta_archives/archive.mtar --retries 1
```

## Expected Results After Fixes

1. **No more 404 errors** for OData service calls
2. **No more i18n locale errors** in console
3. **Proper authentication flow** for OData services
4. **Working application** at: `https://44061ef2trial-dev-hcm-recruitment.cfapps.us10-001.hana.ondemand.com/candidate`

## Testing the Fixes

After redeployment, test the application by:

1. **Access the application URL**: `https://44061ef2trial-dev-hcm-recruitment.cfapps.us10-001.hana.ondemand.com/candidate`
2. **Check browser console** for any remaining errors
3. **Verify OData service access** by checking if the application loads data
4. **Test authentication flow** by ensuring proper login/logout

## Troubleshooting

If issues persist:

1. **Check Cloud Foundry logs**: `cf logs HCM-Recruitment --recent`
2. **Verify service bindings**: `cf services`
3. **Check application status**: `cf apps`
4. **Test OData service directly**: Try accessing the service URL directly

## Summary

The main issues were:
- **Path routing mismatch** between UI5 app and OData service
- **Complex i18n configuration** causing locale conflicts
- **Missing router rules** for app-specific OData calls

All fixes have been applied and should resolve the console errors you were experiencing.
