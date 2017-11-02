FROM registry.local:5000/apps/iis-net35-allfeatures:latest
SHELL ["powershell"]

RUN New-WebAppPool –Name 'Default'

COPY ./wwwroot c:/wwwroot

RUN Remove-WebSite -Name 'Default Web Site'  
RUN New-Website -Name 'Website' -Port 80 \  
    -PhysicalPath 'c:\wwwroot' -ApplicationPool 'Default'

RUN New-WebApplication -Site "Website" -Name "cms" -PhysicalPath "c:\wwwroot\cms" -ApplicationPool "Default"

RUN Import-Module WebAdministration; Set-ItemProperty ('IIS:\AppPools\Default') -Name managedRuntimeVersion -Value 'v2.0'
	
EXPOSE 80
