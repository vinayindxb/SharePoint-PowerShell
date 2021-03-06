############################################################################################################################################
# This script allows to work with SharePoint property bags at the Site Collection Level
# Required Parameters: 
#    ->$sOperationType: Operation type to be done with the property bag - Create - Update - Delete.
#    ->$sPropertyBagKey: Key for the property bag to be added.
#    ->$sPropertyBagValue: Value for the property bag addded.
############################################################################################################################################

If ((Get-PSSnapIn -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null ) 
{ Add-PSSnapIn -Name Microsoft.SharePoint.PowerShell }

$host.Runspace.ThreadOptions = "ReuseThread"

#
#Definition of the function that allows to create, update and remove a property bag
#
function WorkWithFarmPropertyBags
{
    param ($sOperationType,$sPropertyBagKey,$sPropertyBagValue)
    try
    {
        $spfFarm=Get-SPFarm        
        switch ($sOperationType) 
        { 
        "Create" {
            Write-Host "Adding Property Bag $sPropertyBagKey to the farm!!" -ForegroundColor Green                        
            $spfFarm.Properties.Add($sPropertyBagKey,$sPropertyBagValue)           
            $spfFarm.Update()            
            $sPropertyBag=$spfFarm.Properties[$sPropertyBagKey]
            Write-Host "Property bag $sPropertyBagKey has the value $sPropertyBag" -ForegroundColor Green
            } 
        "Read" {
            Write-Host "Reading Property Bag $sPropertyBagKey" -ForegroundColor Green                 
            $sPropertyBag=$spfFarm.Properties[$sPropertyBagKey]
            Write-Host "Property bag $sPropertyBagKey has the value $sPropertyBag" -ForegroundColor Green
            }
        "Update" {
            $sPropertyBag=$spfFarm.Properties[$sPropertyBagKey]
            Write-Host "Property bag $sPropertyBagKey has the value $sPropertyBag" -ForegroundColor Green
            Write-Host "Updating Property Bag $sPropertyBagKey in the farm" -ForegroundColor Green            
            $spfFarm.Properties[$sPropertyBagKey]="SPSiteColPBagUpdatedValue_2"    
            $spfFarm.Update()                    
            $sPropertyBag=$spfFarm.Properties[$sPropertyBagKey]
            Write-Host "Property bag $sPropertyBagKey has the value $sPropertyBag" -ForegroundColor Green
            } 
        "Delete" {
            Write-Host "Removing Property Bag $sPropertyBagKey" -ForegroundColor Green                                    
            $spfFarm.Properties.Remove($sPropertyBagKey)            
            $spfFarm.Update()            
            $sPropertyBag=$spfFarm.Properties[$sPropertyBagKey]
            Write-Host "Property bag $sPropertyBagKey has the value $sPropertyBag" -ForegroundColor Green
            }           
        default {
            Write-Host "Requested Operation not valid!!" -ForegroundColor DarkBlue                  
            }
        }        
    }
    catch [System.Exception]
    {
        write-host -f red $_.Exception.ToString()
    }
}

Start-SPAssignment –Global
#Calling the function
$sPropertyBagKey="<PropertyBagKey>"
$sPropertyBagValue="<PropertyBagValue>"
WorkWithFarmPropertyBags -sOperationType "Create" -sPropertyBagKey $sPropertyBagKey -sPropertyBagValue $sPropertyBagValue
WorkWithFarmPropertyBags -sOperationType "Read" -sPropertyBagKey $sPropertyBagKey -sPropertyBagValue $sPropertyBagValue
#WorkWithFarmPropertyBags -sOperationType "Update" -sPropertyBagKey $sPropertyBagKey -sPropertyBagValue $sPropertyBagValue
#WorkWithFArmPropertyBags -sOperationType "Delete" -sPropertyBagKey $sPropertyBagKey -sPropertyBagValue $sPropertyBagValue
Stop-SPAssignment –Global

Remove-PSSnapin Microsoft.SharePoint.PowerShell