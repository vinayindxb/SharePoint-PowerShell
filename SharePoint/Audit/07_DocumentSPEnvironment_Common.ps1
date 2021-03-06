
############################################################################################################################################
# Script para documentar las configuraciones comunes de un ambiente de SharePoint
# Parámetros necesarios: 
#    -> N/A
# Referencias:
#    -> http://technet.microsoft.com/en-us/library/ff645391(v=office.14).aspx
############################################################################################################################################

If ((Get-PSSnapIn -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null ) 
{ Add-PSSnapIn -Name Microsoft.SharePoint.PowerShell }

#Hacemos un buen uso de PowerShell para no penalizar el rendimiento
$host.Runspace.ThreadOptions = "ReuseThread"

#############################################################################################################################################
## Configuraciones comunes de SharePoint
#############################################################################################################################################

Start-SPAssignment –Global

#Información de las aplicaciones Web, con un nivel de profunfidad de 4 (Recomendado)
#Get-SPWebApplication -IncludeCentralAdministration | Export-Clixml .\WebAppDepth_Level_4.xml -depth 4
Get-SPWebApplication -IncludeCentralAdministration | Export-Clixml .\WebAppDepth_Level_3.xml -depth 3
Get-SPWebApplication -IncludeCentralAdministration | Export-Clixml .\WebAppDepth_Level_2.xml -depth 2

#Información relativa a layouts personalizados
Get-SPWebApplication | Get-SPCustomLayoutsPage | Export-Clixml .\Get-SPCustomLayoutsPage.xml

#Determina como está configurado SharePoint Designer
Get-SPWebApplication | Get-SPDesignerSettings  | Export-Clixml .\Get-SPDesignerSettings.xml

#Devuelve información sobre las rutas de acceso alternativo
Get-SPAlternateURL  | Export-Clixml .\Get-SPAlternateURL.xml

#Devuelve información sobre Rutas Administradas
Get-SPWebApplication -IncludeCentralAdministration | Get-SPManagedPath  | Export-Clixml .\Get-SPManagedPath.xml


#Información sobre las BDs de Contenidos
Get-SPContentDatabase  | Export-Clixml .\Get-SPContentDatabase.xml

#Propiedades de cada BD de SharePoint
Get-SPDatabase  | Export-Clixml .\Get-SPDatabase.xml

#Información específica sobre los productos instalados en la granja, incluyendo todas las actualizaciones de cada producto
Get-SPProduct  | Export-Clixml .\Get-SPProduct.xml

#Información de la granaja
Get-SPFarm  | Export-Clixml .\Get-SPFarm.xml
Get-SPFarmConfig  | Export-Clixml .\Get-SPFarmConfig.xml

#Información de los servidores en la granja
Get-SPServer  | Export-Clixml .\Get-SPServer.xml

#Información sobre las características instaladas
Get-SPFeature  | Export-Clixml .\Get-SPFeature.xml

#Retrieve information about globally-installed site templates
Get-SPWebTemplate  | Export-Clixml .\Get-SPWebTemplate.xml

#Retrieve information about deployed solutions
Get-SPSolution  | Export-Clixml .\Get-SPSolution.xml

#Información sobre soluciones de tipo Sandbox
Get-SPSite | Get-SPUserSolution  | Export-Clixml .\Get-SPUserSolution.xml

#Información sobre autenticación basada en Claims
Get-SPTrustedIdentityTokenIssuer  | Export-Clixml .\Get-SPTrustedIdentityTokenIssuer.xml
Get-SPTrustedServiceTokenIssuer  | Export-Clixml .\Get-SPTrustedServiceTokenIssuer.xml
Get-SPTrustedRootAuthority  | Export-Clixml .\Get-SPTrustedRootAuthority.xml


#Información sobre la ayuda instalada
#Get-SPHelpCollection  | Export-Clixml .\Get-SPHelpCollection.xml

#Información sobre el nivel de logging fijado en la granja -> Valor normal (Medium)
Get-SPLogLevel  | Export-Clixml .\Get-SPLogLevel.xml

#Información sobre las colecciones de sitios
Get-SPSite  | Export-Clixml .\Get-SPSite.xml
Get-SPSiteAdministration  | Export-Clixml .\Get-SPSiteAdministration.xml
Get-SPSiteSubscription  | Export-Clixml .\Get-SPSiteSubscription.xml


#Información sobre Logging
Get-SPDiagnosticConfig  | Export-Clixml .\Get-SPDiagnosticConfig.xml
Get-SPDiagnosticsPerformanceCounter  | Export-Clixml .\Get-SPDiagnosticsPerformanceCounter.xml
Get-SPDiagnosticsProvider  | Export-Clixml .\Get-SPDiagnosticsProvider.xml

#Devolver información sobre las cuentas administradas
<#Get-SPManagedAccount  | Export-Clixml .\Get-SPManagedAccount.xml
Get-SPProcessAccount  | Export-Clixml .\Get-SPProcessAccount.xml
Get-SPShellAdmin  | Export-Clixml .\Get-SPShellAdmin.xml#>

#Devolver información específica sobre la autoridad de certificado
Get-SPCertificateAuthority  | Export-Clixml .\Get-SPCertificateAuthority.xml
Get-SPClaimProvider  | Export-Clixml .\Get-SPClaimProvider.xml
Get-SPClaimProviderManager  | Export-Clixml .\Get-SPClaimProviderManager.xml

#Devolver información sobre Jobs de Content Deplyment
<#Get-SPContentDeploymentJob | Export-Clixml .\Get-SPContentDeploymentJob.xml
Get-SPContentDeploymentPath | Export-Clixml .\Get-SPContentDeploymentPath.xml#>

#Devolver información sobre la cuenta de mensajería móbil
#Get-SPWebApplication | Get-SPMobileMessagingAccount  | Export-Clixml .\Get-SPMobileMessagingAccount.xml


###Note: These cmdlets are commented out because you are unlikely to want to run them. ###
#Get-SPSite | %{$web=Get-SPWeb $_.Url;$webid=$web.Id;$web | Get-SPUser | Export-Clixml .\Get-SPUser-$webid.xml}

# Get-SPSite | %{$web=Get-SPWeb $_.Url;$webid=$web.Id;$web | Export-Clixml .\Get-SPWeb-$webid.xml}

#Quitamos el Snapin de Microsoft.SharePoint.PowerShell

Stop-SPAssignment –Global

Remove-PsSnapin Microsoft.SharePoint.PowerShell