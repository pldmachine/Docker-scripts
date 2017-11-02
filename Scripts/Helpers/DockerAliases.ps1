function docker-container-ip
{
	docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $Args[0]
}

. $profile