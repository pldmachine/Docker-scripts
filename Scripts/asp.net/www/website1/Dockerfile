FROM registry.local:5000/apps/iis-extended:1.0.0
SHELL ["powershell"]

RUN New-WebAppPool –Name 'Default'

COPY ./wwwroot c:/wwwroot

RUN Remove-WebSite -Name 'Default Web Site'  
RUN New-Website -Name 'Website' -Port 80 \  
    -PhysicalPath 'c:\wwwroot' -ApplicationPool 'Default'
	
RUN Import-Module WebAdministration; Set-ItemProperty ('IIS:\AppPools\Default') -Name managedPipelineMode -Value 1
	
EXPOSE 80
