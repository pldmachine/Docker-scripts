# Docker

## Informacje wstępne

http://blog.helion.pl/docker-obiecuje-czemu-warto-go-uzywac/


## Microsoft SQL Server

Utworzenie nowej instancji SQL Server Express Edition:


Uruchomienie obrazu ms sql express z prywatnego repozytorium

`docker run -d -p 1433:1433 -v c:/Workspace/Docker/Database/:c:/Database/ --name="database" -e sa_password=Warszawska26a -e ACCEPT_EULA=Y registry.local:5000/apps/database:22.08.2017`

gdzie folder: *c:/Workspace/Docker/Database/* należy utworzyć lokalnie.

## IIS + www content

> Zakładamy że mamy w repozytorium obraz o nazwie registry.local:5000/apps/coesi: 22.08.2017

## Jak zbudowac własny obraz jenkins

https://blog.alexellis.io/continuous-integration-docker-windows-containers/


## Własne respozytorium - Registry

Docker udostępnia własne oficialny hub. Znajduje się tam olbrzymia ilość repozytorium. Niestety wersja darmowa pozwala tylko na tworzenie repozytorium publicznego.

Niemniej jednak docker pozwala nam na utworzenie własnego "docker registry" i hostować go na dowolnym serwerze.

Poniższe linki pomocne podczas tworzenia własnego repozytorium

https://hub.docker.com/r/stefanscherer/registry-windows/
https://github.com/docker/labs/blob/master/windows/registry/part-1.md
https://github.com/docker/labs/blob/master/windows/registry/part-2.md
https://github.com/docker/labs/blob/master/windows/registry/part-3.md

### Wgrywanie zmian do repozytorium 

> Posiadamy w docker strony www poprzez którą klient zapisuje w ścieżce relatywnej pewne pliki, np PDFy, obrazki wgrywane z CMS'a itp.
> Checemy przenieść stronę na inny serwer

Postępujemy w sposób następujący:

1. Zapisujemy stan naszego kontenera poprzez "commit" https://docs.docker.com/engine/reference/commandline/commit/

  np.:

  `docker commit demo.coesi registry.local:5000/apps/coesi:22.08.2017`

  gdzie '22.08.2017' to *tag* który w tym przypadku jest bieżącą datą.
  W ten sposób tworzymy nowy lokalny "image"
  
2. Wysyłamy obraz na serwer:

`docker push registry.local:5000/apps/coesi:22.08.2017`

3. Pobranie obrazu z repozytorium na innym serwerze

** Najpierw należy skonfigurować zaufane połączenie po https. Dokument tej czynności jeszcze nie opisuje **

Po uruchomieniu skryptu `.\Query-Registry.ps1 coesi` powyższy commit powinien pojawić się na liście wynikowej.

Pobranie obrazu lokalnie:

`docker pull registry.local:5000/apps/coesi:22.08.2017`

## Selenium i Docker

https://github.com/SeleniumHQ/docker-selenium

np: `docker run -d -p 4444:4444 -p 5900:5900 selenium/standalone-chrome-debug:3.4.0-francium`

## Pomocne skrypty

#### Query-Registry.ps1 

Skrypt w Powershell pozwalajacy na przeszukiwanie zdalnego repozytorium które jest hostowane na prywantym serwerze.
Przed użyciem należy skrypt wyedytować i wprowadzić poprawna wartość w pozycji:

`$RegistryEndpoint = "registry.local:5000"`

**Użycie: **

`.\Query-Registry.ps1 szukana-fraza`

#### Powershell alias docker-container-ip

W celu usprawnienia sobie pracy utworzono alias powershell za pomocą którego w szybki sposób można sprawdzić IP danego kontenera.

Aby móc tworzyć trwałe aliasy, najpierw nalezy utworzyć profil użytkownika w systemie administratora:

`.\CreateProfile.ps1`

w pliku DockerAliases.ps1 znajdziemy definicję aliasu **docker-container-ip**. Należy ten plik wykonać:

`.\DockerAliases.ps1`

Dzięki temu w łatwy sposób pobieramy informacje o IP danego kontenera:

`docker-container-ip container-name`

Powyższy alias zawieria w sobie polecenie:

`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}`

