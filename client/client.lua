-- [[Alarm]] --
function startCarAlarm(entity)
    SetVehicleAlarm(entity, true)
    StartVehicleAlarm(entity)
    SetVehicleAlarmTimeLeft(entity, N.alarmTime)
end

-- [[Durability]] --
function durability()
    local lockpick = exports.ox_inventory:Search('slots', 'lockpick')
        
    for i = 1, #lockpick do
        if lockpick[i].metadata and (lockpick[i].metadata.durability or 100) > 0 then
            TriggerServerEvent('n-lockpick:durability', lockpick[i].slot, (lockpick[i].metadata.durability or 100) - N.durability)
            break
        end
    end
end

-- [[AlertPolice]] --
function AlertPolice()
    if N.policeAlert then
        if math.random(100) > N.chanceAlert then
            return
        end
        --TU WKLEJ SWÓJ KOD OD POWIADOMIENIA DLA POLICJI
        lib.notify({
            title = 'POLICE ALERT',
            description = 'Kradzież pojazdu',
            type = 'error'
        })
    end
end

-- [[OpenDoor]] --
function OpenCarDoor(data)
    local entity = data.entity
    RequestAnimDict('anim@amb@clubhouse@tutorial@bkr_tut_ig3@')
    while not HasAnimDictLoaded('anim@amb@clubhouse@tutorial@bkr_tut_ig3@') do 
        Citizen.Wait(100) 
    end
    TaskPlayAnim(PlayerPedId(), 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 1.0, -1.0, -1, 17, 0.0, false, false, false)
    local success = lib.skillCheck(N.skillChecklev, N.skillChecknum)
    ClearPedTasks(PlayerPedId())
    if success then
        if lib.progressCircle({
            duration = N.durationProgresbar,
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
            },
            anim = {
                dict = 'missheistfbisetup1',
                clip = 'hassle_intro_loop_f'
            },
        }) then
            SetVehicleDoorsLocked(entity, 1)
            SetVehicleDoorsLockedForAllPlayers(entity, false)
            PlayVehicleDoorOpenSound(entity, 0)
            SetVehicleAlarm(entity, false)
            --print('Otworzyłeś Auto')
            lib.notify(N.notifyGood)
        else
            startCarAlarm(entity)
        end
    else
        startCarAlarm(entity)
        AlertPolice()  -- [[ALERT POLICE]] --
        durability()
    end
end

-- [[Target]] --
local ox_target = exports.ox_target
ox_target:addGlobalVehicle({
    {
        name = 'lockpick',
        icon = 'fa-solid fa-lock',
        items = 'lockpick',
        onSelect = function(data)
            OpenCarDoor(data)
        end,
        label = 'Włam Się',
        canInteract = function(entity)
            local lock = GetVehicleDoorLockStatus(entity)
            local lockpick = exports.ox_inventory:Search('slots', 'lockpick')
        
            for i = 1, #lockpick do 
                durabi = lockpick[i].metadata and (lockpick[i].metadata.durability or 100)
            end
            return lock > 2 and durabi > 0
        end,
        distance = 2
    }
})
