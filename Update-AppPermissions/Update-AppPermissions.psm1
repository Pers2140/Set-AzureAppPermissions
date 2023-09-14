$adminAppId = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"; #admin-app TODO to replace
$clientAppId = "xxxxxxxxxxxxxxxxxxxxxxxxxxxx"; #client-app

$tenantPrefix = "xxxxxxxxxxxxxxx"; # replace with your tenant id TODO to replace
$tenantName = $tenantPrefix +".onmicrosoft.com";
$spoTenantName = "https://" + $tenantPrefix + ".sharepoint.com";

# site to apply granular permission, 
# it can be repeated for more than one sites
$site2apply = "https://xxxxxxxxxxxxxxx.sharepoint.com/sites/AD_profileinfo"

$password = (ConvertTo-SecureString -AsPlainText 'pass@word1' -Force)

$adminConn = Connect-PnPOnline -Url $spoTenantName -ClientId $adminAppId -CertificatePath './pnpSites-Selected.pfx' -CertificatePassword $password  -Tenant $tenantName

### GET
$perms = Get-PnPAzureADAppSitePermission -Site $site2apply

# #### GRANT
# # Grant-PnPAzureADAppSitePermission -AppId $clientAppId -DisplayName "clientApp" -Permissions Read -Site $site2apply -Verbose

# #### SET
Set-PnPAzureADAppSitePermission -Site $site2apply -Permissions Write -PermissionId $perms.Id

# #### REVOKE
# Revoke-PnPAzureADAppSitePermission -Site $site2apply -PermissionId $perms.Id