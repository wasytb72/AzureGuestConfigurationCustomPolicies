# Add PSDscResources module to environment
Install-Module 'PSDscResources' -Force

# Define the DSC configuration and import GuestConfiguration
Configuration AuditWindowsRegistry
{
    Import-DscResource -ModuleName 'PSDscResources'

    Node AuditWindowsRegistry {
      Registry 'Ensure Windows Registry key and data is in a desired state'
      {
          Key =  'HKEY_LOCAL_MACHINE\SOFTWARE\ExampleKey1'
          Ensure = 'Present'
          ValueName = 'TestValue'
          ValueData = 'TestData'
          ValueType = 'String'  
      }
    }
}

# Compile the configuration to create the MOF files
AuditWindowsRegistry -OutputPath ./AuditWindowsRegistry/CompiledPolicy