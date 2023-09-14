

# function Get-ExternalSPOUsers {

    #Connect to SharePoint Online Tenant Admin
    $AdminSiteURL="https://xxxxxxxxxxxxxxxxxx.sharepoint.xxx/sites/education_pxxxxxxxxxx"
    
    $Cred = Get-Credential
    	
    Connect-PnPOnline -URL $AdminSiteURL -Credential $Cred
    Connect-PnPOnline -Url "https://xxxxxxxxxxxx.sharepoint.xxx/sites/eduxxxxxxxxxxxctsxxxxxxxxnter" -UseWebLogin
    
    #sharepoint online list external users powershell
    Get-PnPExternalUser | Select DisplayName,Email,AcceptedAs,WhenCreated | Format-Table


    #Read more: https://www.sharepointdiary.com/2017/11/sharepoint-online-find-all-external-users-using-powershell.html#ixzz7w2E8ZzSB
# }