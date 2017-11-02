[CmdletBinding()]
Param(
    [Parameter(Mandatory=$True,Position=1,HelpMessage="Please type name of project")]
    $projectName=".*",
    
    [Parameter(Mandatory=$True,Position=2,HelpMessage="Please type a command (up or down)")]
    [ValidatePattern("(^up$)|(^down$)|(^ps$)")]
    [ValidateSet("up","down","ps")]
    $command = ".*"
) 

. .\import.ps1

if (!$projectName -Or !$command )  
{ 
    Write-Host "Wrong command ! Run: "
    Write-Host "up.ps1 [-projectName] <Object> [-command] <up|down|ps> [<CommonParameters>]"
}
else
{
    switch ($command) 
    {
        "up" 
            { 
                docker-compose -p $projectName up -d
                docker-compose-containers-domains $projectName add
            }
        "down" 
            { 
                docker-compose-containers-domains $projectName remove
                docker-compose -p $projectName down 
            }
        "ps" 
            { 
                docker-compose -p $projectName ps 
            }
    }
}
