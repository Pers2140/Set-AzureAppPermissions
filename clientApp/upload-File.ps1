
# Returns rest response as object
function Get-UserToken {
    # Set Params
    # param(
    #     [string] $client_id 
    #     [string] $client_secret 
    #     [string] $tenant_id 
    # )
        
    $client_id = "xxxxxxxxxxxxxxxxxxxx"
    $client_secret = "xxxxxxxxxxxxxxxxxxxxxxxxxx"
    $tenant_id = "xxxxxxxxxxxxxxxxxxxxxxxxx"

    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Content-Type", "application/x-www-form-urlencoded")
    $headers.Add("Cookie", "buid=0.ATYAgOMOjNVS90mkojTPK-ewudfqWYwD1ydKnlXJagBUyNI2AAA.AQABAAEAAAD--DLA3VO7QrddgJg7WevrwzXRBf53TBob6qbZZNibQYJLRn1fWp_-0da2yf5resER9eV_jHbKJ8tJEk3Ek9mUZ7PuHWsVpMI8_7nrAuW7t0jbDkCVnEjdIegdNGEz8yYgAA; fpc=Al6oLhm8kABEh-fZyWWWvPOqTVxQAQAAAEZjd9sOAAAA; stsservicecookie=estsfd; x-ms-gateway-slice=estsfd")

    $body = "grant_type=client_credentials&client_id=$client_id&client_secret=$client_secret&resource=https%3A%2F%2Fgraph.microsoft.com"

    $response = Invoke-RestMethod "https://login.microsoftonline.com/$tenant_id/oauth2/token" -Method 'POST' -Headers $headers -Body $body
    $response | convertTo-JSON | ConvertFrom-Json
}

# Upload file to Sharepoint - returns obj
function Start-FileUpload {
    param(
        [string] $file_path,
        [string] $upload_dir
        )
        
        $token = (Get-userToken).access_token
        $file_name = $file_path.Split("\")[-1]
        $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
        $headers.Add("Authorization", "Bearer $token")
        $headers.Add("Content-Type", "text/plain")
        
    # If user specifies a upload directory that will be used. Else it will be uploaded to the root directory
    if ($upload_dir){
        # write-host $file_path
            write-host "Uploading to directory ---> "${upload_dir}
            Invoke-RestMethod "https://graph.microsoft.com/v1.0/sites/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/drives/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/root:/${upload_dir}/${file_name}:/content" -Method 'PUT' -InFile $file_path -Headers $headers 
        }else{
            write-host "Uploading file ---> "${file_name}
            Invoke-RestMethod "https://graph.microsoft.com/v1.0/sites/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/drives/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/root:/${file_name}:/content" -Method 'PUT' -InFile $file_path -Headers $headers 
        }
    
    $response | convertTo-JSON | ConvertFrom-Json | select-object createdBy, createdDateTime, lastModifiedBy, lastModifiedDateTime  

}

function Start-FolderUpload {

    param(
        [string] $folder_path,
        [string] $upload_dir
    )

    $token = $(Get-userToken).access_token
    write-host "Uploading files to SharePoint please wait ..."
    Get-ChildItem $folder_path | ForEach-Object {

        $file_name = $_.Name.Split("\")[-1]
        $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
        $headers.Add("Authorization", "Bearer $token")
        $headers.Add("Content-Type", "text/plain")

        if ($upload_dir){
            # write-host $file_path
                write-host "Uploading to directory ---> "${upload_dir}
                Invoke-RestMethod "https://graph.microsoft.com/v1.0/sites/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/drives/b!GoMzd6NImEKkS7h8psO1Mal-S2J3q-1Jvy3dfVof4t2c7wenMrV6SoA4cZEqE54K/root:/${upload_dir}/${file_name}:/content" -Method 'PUT' -InFile $file_path -Headers $headers 
            }else{
                write-host "Uploading file ---> "${file_name}
                Invoke-RestMethod "https://graph.microsoft.com/v1.0/sites/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/drives/b!GoMzd6NImEKkS7h8psO1Mal-S2J3q-1Jvy3dfVof4t2c7wenMrV6SoA4cZEqE54K/root:/${file_name}:/content" -Method 'PUT' -InFile $file_path -Headers $headers 
            }

    write-host "All done!"
    $response | convertTo-JSON | ConvertFrom-Json | select-object createdBy, createdDateTime, lastModifiedBy, lastModifiedDateTime  }

}