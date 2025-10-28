QBCore = {}
QBCore.Config = QBConfig
QBCore.Shared = QBShared
QBCore.ClientCallbacks = {}
QBCore.ServerCallbacks = {}

exports('GetCoreObject', function()
    return QBCore
end)

-- To use this export in a script instead of manifest method
-- Just put this line of code below at the very top of the script
-- local DWASCore = exports['dwas-core']:GetCoreObject()

AddEventHandler('__cfx_export_dwas-core_GetCoreObject', function(setCB)
    setCB(function()
        return QBCore
    end)
end)
