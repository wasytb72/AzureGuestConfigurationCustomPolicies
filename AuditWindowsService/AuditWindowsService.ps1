# Add PSDscResources module to environment
Install-Module 'PSDscResources' -Force

# Define the DSC configuration and import GuestConfiguration
Configuration AuditWindowsService
{
    Import-DscResource -ModuleName 'PSDscResources'

    Node AuditWindowsService {
      Service 'Ensure Windows service is in a desired state'
      {
          Name = 'BDESVC'
          Ensure = 'Present'
          State = 'Running'
          StartupType = 'Manual'
      }
    }
}

# Compile the configuration to create the MOF files
AuditWindowsService -OutputPath ./AuditWindowsService/CompiledPolicy