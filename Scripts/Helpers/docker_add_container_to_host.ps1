Install-Module PsHosts

$container = $Args[0]
$ip = docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $container

Write-Host "Container IP: '$ip' "

Write-Host "Set System32\drivers\etc\host entry for domain : '$container' and ip '$ip' "
Set-HostEntry $container $ip -Force
