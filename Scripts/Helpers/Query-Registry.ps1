[CmdletBinding()]
Param(
    [Parameter(Mandatory=$True,Position=1)]
    $Filter=".*",
    
    #TODO: handle https & no basic auth as well..
    $RegistryEndpoint = "registry.local:5000",
    $UserName = "user",
    $Password = "password"
)


#encode credentials to Base64String
$AuthString = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($UserName):$($Password)"))

$Result = (Invoke-RestMethod -Uri "https://$RegistryEndpoint/v2/_catalog" -Method Get ).repositories -Match $Filter

Write-Host -ForegroundColor Green ("found {0} images:" -f $Result.count)
$Result | % { 
    $image=$_
    $image
    (irm -uri "https://$RegistryEndpoint/v2/$image/tags/list" -Method Get ).tags  | % {
        $tag=$_
        "  docker pull $RegistryEndpoint/${image}:${tag}"
    }
}