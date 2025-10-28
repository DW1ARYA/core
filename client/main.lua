DWASCore = {}
DWASCore.PlayerData = {}
DWASCore.Config = DWASConfig
DWASCore.Shared = DWASShared
DWASCore.ClientCallbacks = {}
DWASCore.ServerCallbacks = {}
IsLoggedIn = false

exports('GetCoreObject', function()
    return DWASCore
end)

-- Untuk menggunakan export ini di script lain tanpa manifest method,
-- cukup tambahkan baris ini di bagian atas script:
-- local DWASCore = exports['dwas-core']:GetCoreObject()

AddEventHandler('__cfx_export_dwas-core_GetCoreObject', function(setCB)
    setCB(function()
        return DWASCore
    end)
end)
