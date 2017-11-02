Install-Module PsHosts

$container = $Args[0]
$domainName = $Args[1]
$ip = docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $container

Write-Host "Container IP: '$ip' "

Write-Host "Set System32\drivers\etc\host entry for domain : '$domainName' and ip '$ip' "
Set-HostEntry $domainName $ip -Force
