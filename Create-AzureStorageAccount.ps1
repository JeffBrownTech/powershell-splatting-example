[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [string]
    $StorageAccountName,

    [Parameter(Mandatory)]
    [string]
    $ResourceGroup,

    [Parameter(Mandatory)]
    [ValidateSet("Dev", "Test", "Prod")]
    [string]
    $Environment
)

# Define the hash table to store properties about the storage account
$stgAcctArgs = @{
    "AccountName" = $StorageAccountName
    "ResourceGroupName" = $ResourceGroup
    "Location" = $null
    "SkuName" = $null
}

# Update properties of the hash table based on the environment
switch ($Environment) {
    "Dev" { 
        $stgAcctArgs.AccountName += "dev"
        $stgAcctArgs.Location = "westus"
        $stgAcctArgs.SkuName = "Standard_LRS"
        break
    }
    
    "Test" { 
        $stgAcctArgs.AccountName += "test"
        $stgAcctArgs.Location = "eastus"
        $stgAcctArgs.SkuName = "Standard_LRS"
        break
    }

    "Prod" { 
        $stgAcctArgs.AccountName += "prod"
        $stgAcctArgs.Location = "southcentralus"
        $stgAcctArgs.SkuName = "Premium_LRS"
        break
    }
}

# Create the storage account, passing the splatted hash table
New-AzStorageAccount @stgAcctArgs