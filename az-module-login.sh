#!bin/bash
$ClientId = "c271cc62-8a9d-46ee-b2f2-222f2425bb9c"
$ClientSecret = ConvertTo-SecureString "A0JTg0AR88C99MCnFGaa9tRqcXCxrRHEfVV3q6ArXsk=" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential($ClientId, $ClientSecret)
Connect-AzAccount -Credential $Credential -Tenant "468baace-a6c5-46f4-832d-417248f38f5e" -Subscription "3b714193-8ac6-46be-87db-d6140bfbf648" -ServicePrincipal
