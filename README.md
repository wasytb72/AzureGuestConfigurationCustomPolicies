# Introduction
The `New-GuestConfigPolicy.ps1` script will walk you through the process of creating and publishing a custom Guest Configuration policy. I hope this guide helps you to better understand how all the Guest Configuration cmdlets can be used to create Custom Guest Configuration policies. Please follow the instructions in the script.

# Working with the end result
After executing the script line by line, you will have a Policy Initiative that contains the Deploy and Audit policy.

![](/Images/GuestConfigurationPolicyCreated.png)

If you create a Virtual Machine and assign the policy (including the remediation task) to a Virtual Machine, it will look like this first:

![](/Images/GuestConfigurationstatus-Compliant.png)

You think it's compliant, but it's not. The system needs some time to install the Guest Configuration Policy on the machine. After a coupl of minutes, the deploy policy should be compliant while the Audit policy is still evaluating. 

![](/Images/GuestConfigurationstatus-Pending.png)

If you drill down on the policy, you can click on the compliance reason details (important: don't click the row but the button!)

![](/Images/GuestConfigurationstatus-ComplianceReason.png)

Now it all makes sense. Because the policy is still evaluating, the compliance status is also still 'Pending' and not 'Compliant'.

![](/Images/GuestConfigurationstatus-PendingStatus.png)

If you logon on the Virtual Machine, you will see that a new log directory was created. If you open this log and search for "AuditBitLocker", you'll see why a resource is compliant or not. This status will also be reported back to Azure Guest Configuration so you can see it in the Azure Portal.

![](/Images/GuestConfigurationStatus-LogFiles.png)

You can also open the `gc_worker.log` file to see the DSC status results. Success:

![](/Images/GuestConfigurationStatus-SuccessLog.png)

If you want to see a policy failure, you can disable the service (in this case, the `winrm` service) by running the following PowerShell commands as administrator:

```` powershell
Get-Service winrm | Stop-Service
Get-Service winrm | Set-Service -StartupType Disabled
````

To quickly trigger the Azure Policy engine, you can create a tag on the VM and remove it so that the Azure Policy engine registers a change on the resource. Give it a couple of minutes and keep an eye on the `gc_worker.log` file again.

![](/Images/GuestConfigurationStatus-FailLog.png)