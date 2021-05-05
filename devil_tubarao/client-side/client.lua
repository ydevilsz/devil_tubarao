-----------------------------------------------------------------------------------------------------------------------------------------
-- CRIADOR
-----------------------------------------------------------------------------------------------------------------------------------------
-- FEITO POR Devil#0069 / https://github.com/ydevilsz
-- Script GRATUITO!
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

emp = Tunnel.getInterface('devil')
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local EntidadeSkin
local EntidadeTipo
local entityBlip = {}
local ProximoSpawnDevil
local EntidadeViva = false
local entityHealth = {}
local entity = {}
local EntidadeSpawnada = true
local EntidadeRemovida = {}
local blipid = 0
local MissaoEmAndamentoDevil = false
local EntidadeTipo = {28}
local EntidadeSkin = {GetHashKey("a_c_deer")} -- PROP DO TUBARÃO
local devil = 1
local a = math.random(1, 10)
local CacadorVeiculo = false

local CoordenadasMissoesDevil = { -- LOCAIS ONDE NASCEM OS TUBARÕES
    {x = 3839.9501953125,y = 4756.4873046875,z = 0.63276600837708},
    {x = 4060.6010742188,y = 4607.3696289063,z = -0.35087049007416},
    {x = 4000.1447753906,y = 4463.5712890625,z = 0.32227477431297},
    {x = 3901.4868164063,y = 4823.9736328125,z = -0.83160400390625},
    {x = 4038.9479980469,y = 4898.7836914063,z = 0.28605374693871},
    {x = 3843.9479980469,y = 4917.2875976563,z = -2.0620303153992},
    {x = 3648.4797363281,y = 4816.5693359375,z = -0.060442000627518},
    {x = 4086.3500976563,y = 4321.9760742188,z = 1.0775016546249},
    {x = 4153.1918945313,y = 4062.2294921875,z = -1.9204443693161},
    {x = 4261.2651367188,y = 4430.3911132813,z = -0.25099191069603}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local Coordenadas = GetEntityCoords(GetPlayerPed(-1))
        local Distancia = GetDistanceBetweenCoords(Coordenadas.x, Coordenadas.y, Coordenadas.z,3802.4013671875,4441.2109375,4.1565537452698, true)
        if Distancia < 5.0 then
            OpacidadeDevil = math.floor(255 - (Distancia * 5))
            DrawMarker(27, 3802.4013671875,4441.2109375,4.1565537452698-0.95, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.5001, 255, 255, 255, OpacidadeDevil, 0, 0, 0, 0)
            Texto3D(3802.4013671875,4441.2109375,4.1565537452698+0.8, "PRESSIONE ~b~ [ E ] ~w~PARA  INICIAR A CAÇAR DE TUBARAO", OpacidadeDevil)
        end
    end
end)

local blipsdevil = {
    {nome = "Caçador de Tubarão", cor = 1, id = 68, x = 3802.40,y = 4441.21,z = 4.15 }, -- LOCAL ONDE FICA O BLIP
}

Citizen.CreateThread(function()
    local EntidadeCoordenadas = {
        {x=0, y=0, z=0},
        {x=0, y=0, z=0},
        {x=0, y=0, z=0},
        {x=0, y=0, z=0},
        {x=0, y=0, z=0},
        {x=0, y=0, z=0},
        {x=0, y=0, z=0},
        {x=0, y=0, z=0},
        {x=0, y=0, z=0},
        {x=0, y=0, z=0},
        {x=0, y=0, z=0},
        {x=0, y=0, z=0}
    }

    while true do
        Citizen.Wait(0)
        if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 3802.4013671875,4441.2109375,4.1565537452698, true) <= 1) then -- LOCAL PARA APERTAR E
            --if IsControlJustPressed(1, 38) and emp.devilcheckPermissao() then -- COM PERMISSÃO (APENAS QUEM TEM A PERMISSÃO DO SERVER-SIDE PODE FAZER)
            if IsControlJustPressed(1, 38) then -- SEM PERMISSÃO (TODOS PODEM FAZER)
                if emp.checkDevilScript then
                    Wait(500)
                    MissaoEmAndamentoDevil = true
                    EntidadeTipo = {28,28,28,28,28}
                    EntidadeSkin = {
                        GetHashKey("a_c_sharktiger"),GetHashKey("a_c_sharktiger"),GetHashKey("a_c_sharktiger"),
                        GetHashKey("a_c_sharktiger"),GetHashKey("a_c_sharktiger"),GetHashKey("a_c_sharktiger"),
                        GetHashKey("a_c_sharktiger"),GetHashKey("a_c_sharktiger"),GetHashKey("a_c_sharktiger"),
                        GetHashKey("a_c_sharktiger"),GetHashKey("a_c_sharktiger"),GetHashKey("a_c_sharktiger"),
                        GetHashKey("a_c_sharktiger")
                    }
                    EntidadeSpawnada = false
                    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLASHLIGHT"),1, true, true) -- FICA QUESTÃO DE VOCÊ COLOCAR UMA ARMA JÁ PARA PESSOA OU NÃO
                    ProximoSpawnDevil = AddBlipForCoord(CoordenadasMissoesDevil[a].x,CoordenadasMissoesDevil[a].y,CoordenadasMissoesDevil[a].z)
                    SetNewWaypoint(CoordenadasMissoesDevil[a].x,CoordenadasMissoesDevil[a].y)
                    SetBlipColour(ProximoSpawnDevil,1)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString("Presa")
                    EndTextCommandSetBlipName(ProximoSpawnDevil)
                else
                    TriggerEvent("Notify",source,"negado","Você não e um caçador.")
                end
            end
        end

        if (EntidadeSpawnada == false) then
            local SpawnPresa = math.random(1, 12)
            RequestModel(EntidadeSkin[devil])
            while not HasModelLoaded(EntidadeSkin[devil]) do
                Wait(1)
            end
            if (ProximoSpawnDevil ~= nil) then
                RemoveBlip(ProximoSpawnDevil)
            end
            entity[devil] = CreatePed(EntidadeTipo[SpawnPresa], EntidadeSkin[devil], CoordenadasMissoesDevil[a].x, CoordenadasMissoesDevil[a].y, CoordenadasMissoesDevil[a].z, 0, true, true)
            SetEntityAsMissionEntity(entity[devil], true, true)
            TaskWanderStandard(entity[devil], 0, 0)
            entityBlip[devil] = AddBlipForEntity(entity[devil])
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Presa")
            EndTextCommandSetBlipName(entityBlip[devil])
            SetBlipSprite(entityBlip[devil],141)
            SetBlipColour(entityBlip[devil],2)
            EntidadeViva = true
            EntidadeSpawnada = true
        end

        if (MissaoEmAndamentoDevil == true and EntidadeSpawnada == true) then
            entityHealth[devil] = GetEntityHealth(entity[devil])
            blipid = entityBlip[devil]
            local vX , vY , vZ = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, blipid, Citizen.ResultAsVector()))
            EntidadeCoordenadas[devil].x = vX
            EntidadeCoordenadas[devil].y = vY
            EntidadeCoordenadas[devil].z = vZ
            local Coordenadas = GetEntityCoords(GetPlayerPed(-1))
            local Distancia = GetDistanceBetweenCoords(Coordenadas.x, Coordenadas.y, Coordenadas.z, EntidadeCoordenadas[devil].x , EntidadeCoordenadas[devil].y , EntidadeCoordenadas[devil].z, true)
            OpacidadeDevil = math.floor(255 - (Distancia * 60))
            if (GetDistanceBetweenCoords( GetEntityCoords(GetPlayerPed(-1)),EntidadeCoordenadas[devil].x , EntidadeCoordenadas[devil].y , EntidadeCoordenadas[devil].z, true ) < 10) then
                if EntidadeViva == true then
                    Texto3D(EntidadeCoordenadas[devil].x , EntidadeCoordenadas[devil].y , EntidadeCoordenadas[devil].z, "Um tubarão bem ali, ~r~cuidado", OpacidadeDevil)
                else
                    Texto3D(EntidadeCoordenadas[devil].x , EntidadeCoordenadas[devil].y , EntidadeCoordenadas[devil].z, "Pressione ~y~[E] ~w~para pegar a carne", OpacidadeDevil)
                end
            end
            if (entityHealth[devil] == 0 and EntidadeViva == true) then
                SetBlipColour(entityBlip[devil],3)
                SetBlipSprite(entityBlip[devil],141)
                EntidadeViva = false
                EntidadeRemovida[devil] = false
            end

            if (GetDistanceBetweenCoords( GetEntityCoords(GetPlayerPed(-1)),EntidadeCoordenadas[devil].x , EntidadeCoordenadas[devil].y , EntidadeCoordenadas[devil].z, true ) < 1 and EntidadeViva == false) then
                --if (IsControlPressed(1, 38)) and emp.devilcheckPagamento() then
                if (IsControlPressed(1, 38)) then
                    TaskStartScenarioInPlace(GetPlayerPed(-1), "CODE_HUMAN_MEDIC_KNEEL", 0, 1)
                    Citizen.Wait(8000)
                    ClearPedTasksImmediately(GetPlayerPed(-1))
                    --TriggerServerEvent("pagamento:ColhendoCarne")
                    RemoveBlip(entityBlip[devil])
                    Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(entity[devil]))
                    EntidadeRemovida[devil] = true
                    emp.devilcheckPagamento()
                    EntidadeSpawnada = false
                    devil = math.random(1,12)
                    a = math.random(1, 10)
                    ProximoSpawnDevil = AddBlipForCoord(CoordenadasMissoesDevil[a].x,CoordenadasMissoesDevil[a].y,CoordenadasMissoesDevil[a].z)
                    SetNewWaypoint(CoordenadasMissoesDevil[a].x,CoordenadasMissoesDevil[a].y)
                    SetBlipColour(ProximoSpawnDevil,1)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString("Caça")
                    EndTextCommandSetBlipName(ProximoSpawnDevil)
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIP
-----------------------------------------------------------------------------------------------------------------------------------------
function Texto3D(x,y,z, text, OpacidadeDevil)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    if onScreen then
        SetTextScale(0.54, 0.54)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, OpacidadeDevil)
        SetTextDropshadow(0, 0, 0, 0, OpacidadeDevil)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

Citizen.CreateThread(function()
    for _, info in pairs(blipsdevil) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, 0.9)
        SetBlipColour(info.blip, info.cor)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.nome)
        EndTextCommandSetBlipName(info.blip)
    end
end)