
function docker-compose-containers-domains($projectName, $command) 
{
    Install-Module PsHosts

    (docker-compose -p $projectName ps -q ) | foreach-object { 

        $c = $PSItem.ToString(); 
        $ip = docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $c   

        docker inspect -f '{{range $index, $value := .Config.Env}} {{$value}}{{println}}{{end}}' $c | foreach-object `
        {
            if ($_.IndexOf("domains") -eq 1 )
            {
                $domains = $_.Substring(9)
                foreach ($domain in $domains.Split(';'))
                {             
                    switch ($command) 
                    {
                        "add" 
                            { 
                                Write-Host "set host domain for  $domain $ip"
                                Set-HostEntry  $domain $ip -force -Comment "Docker project $projectName"
                            }
                        "remove" 
                            { 
                                Write-Host "remove host domain for  $domain $ip"
                                Remove-HostEntry  $domain 
                            }
                    }                    
                }
            }       
        }
    }
}
