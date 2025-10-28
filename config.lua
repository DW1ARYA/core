DWASConfig = {}

DWASConfig.MaxPlayers = GetConvarInt('sv_maxclients', 8)
DWASConfig.DefaultSpawn = vector4(-1035.71, -2731.87, 12.86, 0.0)
DWASConfig.UpdateInterval = 1
DWASConfig.StatusInterval = 1

DWASConfig.Money = {}

---@alias Money {cash: number, bank: number}
---@type Money
DWASConfig.Money.MoneyTypes = { cash = 25000, bank = 50000 }
DWASConfig.Money.DontAllowMinus = { 'cash' }
DWASConfig.Money.PaycheckTimeout = 7
DWASConfig.Money.PaycheckSociety = false

DWASConfig.Player = {}
DWASConfig.Player.HungerRate = 2
DWASConfig.Player.ThirstRate = 2

---@enum BloodType
DWASConfig.Player.Bloodtypes = {
    "A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-",
}

---@alias UniqueIdType 'citizenid' | 'AccountNumber' | 'PhoneNumber' | 'FingerId' | 'WalletId' | 'SerialNumber'
---@type table<UniqueIdType, {valueFunction: function}>
DWASConfig.Player.IdentifierTypes = {
    ['citizenid'] = {
        valueFunction = function()
            return tostring(DWASCore.Shared.RandomStr(3) .. DWASCore.Shared.RandomInt(5)):upper()
        end,
    },
    ['AccountNumber'] = {
        valueFunction = function()
            return 'US0' .. math.random(1, 9) .. 'DWASCore' .. math.random(1111, 9999) .. math.random(1111, 9999) .. math.random(11, 99)
        end,
    },
    ['PhoneNumber'] = {
        valueFunction = function()
            return math.random(100,999) .. math.random(1000,9999)
        end,
    },
    ['FingerId'] = {
        valueFunction = function()
            return tostring(DWASCore.Shared.RandomStr(2) .. DWASCore.Shared.RandomInt(3) .. DWASCore.Shared.RandomStr(1) .. DWASCore.Shared.RandomInt(2) .. DWASCore.Shared.RandomStr(3) .. DWASCore.Shared.RandomInt(4))
        end,
    },
    ['WalletId'] = {
        valueFunction = function()
            return 'DW-' .. math.random(11111111, 99999999)
        end,
    },
    ['SerialNumber'] = {
        valueFunction = function()
            return math.random(11111111, 99999999)
        end,
    },
}

DWASConfig.Server = {}
DWASConfig.Server.UseConnectQueue = true
DWASConfig.Server.Closed = false
DWASConfig.Server.ClosedReason = "Server Closed"
DWASConfig.Server.Uptime = 0
DWASConfig.Server.Whitelist = false
DWASConfig.Server.WhitelistPermission = 'admin'
DWASConfig.Server.PVP = true
DWASConfig.Server.Discord = ""
DWASConfig.Server.CheckDuplicateLicense = true
DWASConfig.Server.Permissions = {'god', 'admin', 'mod'}

DWASConfig.Notify = {}
DWASConfig.NotifyPosition = 'top-right'
