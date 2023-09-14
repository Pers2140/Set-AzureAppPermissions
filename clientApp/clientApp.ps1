
$clientAppId = "xxxxxxxxxxxxxxxxxxxxxxxxxxxx"; #client-app

$tenantPrefix = "xxxxxxxxxxxxxxx"; # replace with your tenant id TODO to replace
$tenantName = $tenantPrefix +".onmicrosoft.com";
$password = (ConvertTo-SecureString -AsPlainText 'pass@word1' -Force)

$site2apply = "https://xxxxxxxxxxxxxxxxxx.sharepoint.com/sites/AD_profileinfo/"

$clientConn = Connect-PnPOnline -Url $site2apply -ClientId $clientAppId -CertificatePath './clientpnpSites-Selected.pfx' -CertificatePassword $password  -Tenant $tenantName

# Get-PnPList

#### GET
$perms = Get-PnPAzureADAppSitePermission -Site $site2apply

#### SET
Set-PnPAzureADAppSitePermission -Site $site2apply -Permissions Write -PermissionId $perms.Id