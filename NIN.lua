--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- __________.__                                ________                          __               .__.__  __      __  .__    .__           _____.__.__              
-- \______   |  |   ____ _____    ______ ____   \______ \   ____     ____   _____/  |_    ____   __| _|___/  |_  _/  |_|  |__ |__| ______ _/ ____|__|  |   ____      
--  |     ___|  | _/ __ \\__  \  /  ____/ __ \   |    |  \ /  _ \   /    \ /  _ \   __\ _/ __ \ / __ ||  \   __\ \   __|  |  \|  |/  ___/ \   __\|  |  | _/ __ \     
--  |    |   |  |_\  ___/ / __ \_\___ \\  ___/   |    `   (  <_> ) |   |  (  <_> |  |   \  ___// /_/ ||  ||  |    |  | |   Y  |  |\___ \   |  |  |  |  |_\  ___/     
--  |____|   |____/\___  (____  /____  >\___  > /_______  /\____/  |___|  /\____/|__|    \___  \____ ||__||__|    |__| |___|  |__/____  >  |__|  |__|____/\___  > /\ 
--                     \/     \/     \/     \/          \/              \/                   \/     \/                      \/        \/                      \/  \/ 
--
--	Please do not edit this file!							Please do not edit this file!							Please do not edit this file!
--
--	Editing this file will cause you to be unable to use Github Desktop to update!
--
--	Any changes you wish to make in this file you should be able to make by overloading. That is Re-Defining the same variables or functions in another file, by copying and
--	pasting them to a file that is loaded after the original file, all of my library files, and then job files are loaded first.
--	The last files to load are the ones unique to you. User-Globals, Charactername-Globals, Charactername_Job_Gear, in that order, so these changes will take precedence.
--
--	You may wish to "hook" into existing functions, to add functionality without losing access to updates or fixes I make, for example, instead of copying and editing
--	status_change(), you can instead use the function user_status_change() in the same manner, which is called by status_change() if it exists, most of the important 
--  gearswap functions work like this in my files, and if it's unique to a specific job, user_job_status_change() would be appropriate instead.
--
--  Variables and tables can be easily redefined just by defining them in one of the later loaded files: autofood = 'Miso Ramen' for example.
--  States can be redefined as well: state.HybridMode:options('Normal','PDT') though most of these are already redefined in the gear files for editing there.
--	Commands can be added easily with: user_self_command(commandArgs, eventArgs) or user_job_self_command(commandArgs, eventArgs)
--
--	If you're not sure where is appropriate to copy and paste variables, tables and functions to make changes or add them:
--		User-Globals.lua - 			This file loads with all characters, all jobs, so it's ideal for settings and rules you want to be the same no matter what.
--		Charactername-Globals.lua -	This file loads with one character, all jobs, so it's ideal for gear settings that are usable on all jobs, but unique to this character.
--		Charactername_Job_Gear.lua-	This file loads only on one character, one job, so it's ideal for things that are specific only to that job and character.
--
--
--	If you still need help, feel free to contact me on discord or ask in my chat for help: https://discord.gg/ug6xtvQ
--  !Please do NOT message me in game about anything third party related, though you're welcome to message me there and ask me to talk on another medium.
--
--  Please do not edit this file!							Please do not edit this file!							Please do not edit this file!
-- __________.__                                ________                          __               .__.__  __      __  .__    .__           _____.__.__              
-- \______   |  |   ____ _____    ______ ____   \______ \   ____     ____   _____/  |_    ____   __| _|___/  |_  _/  |_|  |__ |__| ______ _/ ____|__|  |   ____      
--  |     ___|  | _/ __ \\__  \  /  ____/ __ \   |    |  \ /  _ \   /    \ /  _ \   __\ _/ __ \ / __ ||  \   __\ \   __|  |  \|  |/  ___/ \   __\|  |  | _/ __ \     
--  |    |   |  |_\  ___/ / __ \_\___ \\  ___/   |    `   (  <_> ) |   |  (  <_> |  |   \  ___// /_/ ||  ||  |    |  | |   Y  |  |\___ \   |  |  |  |  |_\  ___/     
--  |____|   |____/\___  (____  /____  >\___  > /_______  /\____/  |___|  /\____/|__|    \___  \____ ||__||__|    |__| |___|  |__/____  >  |__|  |__|____/\___  > /\ 
--                     \/     \/     \/     \/          \/              \/                   \/     \/                      \/        \/                      \/  \/ 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    -- Load and initialize the include file.
    include('Sel-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

	state.Buff['Aftermath: Lv.3'] = buffactive['Aftermath: Lv.3'] or false
    state.Buff.Migawari = buffactive.Migawari or false
    state.Buff.Yonin = buffactive.Yonin or false
    state.Buff.Innin = buffactive.Innin or false
    state.Buff.Futae = buffactive.Futae or false
	
	state.Stance = M{['description']='Stance','Innin','Yonin','None'}

	autows = "Blade: Shun"
	autofood = 'Soy Ramen'
	
	utsusemi_ni_cancel_delay = .1
	
	state.ElementalMode = M{['description'] = 'Elemental Mode','Fire','Water','Lightning','Earth','Wind','Ice','Light','Dark',}
	
	update_melee_groups()
	init_job_states({"Capacity","AutoRuneMode","AutoTrustMode","AutoWSMode","AutoShadowMode","AutoFoodMode","AutoNukeMode","AutoStunMode","AutoDefenseMode","ElementalWheel",},{"AutoBuffMode","AutoSambaMode","Weapons","OffenseMode","WeaponskillMode","Stance","IdleMode","Passive","RuneElement","ElementalMode","CastingMode","TreasureMode",})
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.

function job_filtered_action(spell, eventArgs)

end

function job_pretarget(spell, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' and (player.equipment.ammo == 'Togakushi Shuriken' or player.equipment.ammo == 'Happo Shuriken') then
		cancel_spell()
		add_to_chat(123,'Abort: Don\'t throw your good ammo!')
    elseif spell.english == 'Sange' and (player.equipment.ammo == 'Togakushi Shuriken' or player.equipment.ammo == 'Happo Shuriken') then
		cancel_spell()
		add_to_chat(123,'Abort: Don\'t throw your good ammo!')
    end
end

function job_post_precast(spell, spellMap, eventArgs)
	if spell.type == 'WeaponSkill' then

		local WSset = standardize_set(get_precast_set(spell, spellMap))
		local wsacc = check_ws_acc()
		
		if (WSset.ear1 == "Moonshade Earring" or WSset.ear2 == "Moonshade Earring") then
			-- Replace Moonshade Earring if we're at cap TP
			if get_effective_player_tp(spell, WSset) > 3200 then
				if wsacc:contains('Acc') and not buffactive['Sneak Attack'] and sets.AccMaxTP then
					local AccMaxTPset = standardize_set(sets.AccMaxTP)

					if (AccMaxTPset.ear1:startswith("Lugra Earring") or AccMaxTPset.ear2:startswith("Lugra Earring")) and not classes.DuskToDawn and sets.AccDayMaxTPWSEars then
						equip(sets.AccDayMaxTPWSEars[spell.english] or sets.AccDayMaxTPWSEars)
					else
						equip(sets.AccMaxTP[spell.english] or sets.AccMaxTP)
					end
				elseif sets.MaxTP then
					local MaxTPset = standardize_set(sets.MaxTP)
					if (MaxTPset.ear1:startswith("Lugra Earring") or MaxTPset.ear2:startswith("Lugra Earring")) and not classes.DuskToDawn and sets.DayMaxTPWSEars then
						equip(sets.DayMaxTPWSEars[spell.english] or sets.DayMaxTPWSEars)
					else
						equip(sets.MaxTP[spell.english] or sets.MaxTP)
					end
				else
				end
			else
				if wsacc:contains('Acc') and not buffactive['Sneak Attack'] and (WSset.ear1:startswith("Lugra Earring") or WSset.ear2:startswith("Lugra Earring")) and not classes.DuskToDawn and sets.AccDayWSEars then
					equip(sets.AccDayWSEars[spell.english] or sets.AccDayWSEars)
				elseif (WSset.ear1:startswith("Lugra Earring") or WSset.ear2:startswith("Lugra Earring")) and not classes.DuskToDawn and sets.DayWSEars then
					equip(sets.DayWSEars[spell.english] or sets.DayWSEars)
				end
			end
		elseif (WSset.ear1:startswith("Lugra Earring") or WSset.ear2:startswith("Lugra Earring")) and not classes.DuskToDawn then
			if wsacc:contains('Acc') and not buffactive['Sneak Attack'] and sets.AccDayWSEars then
				equip(sets.AccDayWSEars[spell.english] or sets.AccDayWSEars)
			elseif sets.DayWSEars then
				equip(sets.DayWSEars[spell.english] or sets.DayWSEars)
			end
		end
	end	
end

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, spellMap, eventArgs)
    if spellMap == 'ElementalNinjutsu' then
        if state.MagicBurstMode.value ~= 'Off' then equip(sets.MagicBurst) end
		if spell.element == world.weather_element or spell.element == world.day_element then
			if state.CastingMode.value == 'Normal' or state.CastingMode.value == 'Fodder' then
				-- if item_available('Twilight Cape') and not state.Capacity.value then
					-- sets.TwilightCape = {back="Twilight Cape"}
					-- equip(sets.TwilightCape)
				-- end
				if spell.element == world.day_element then
					if item_available('Zodiac Ring') then
						sets.ZodiacRing = {ring2="Zodiac Ring"}
						equip(sets.ZodiacRing)
					end
				end
			end
		end
		if spell.element and sets.element[spell.element] then
			equip(sets.element[spell.element])
		end
		if state.Buff.Futae and sets.buff.Futae then
			equip(sets.buff.Futae)
		end
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, spellMap, eventArgs)
    
	if spell.interrupted then return
	elseif spell.english == "Migawari: Ichi" then
        state.Buff.Migawari = true
	elseif spellMap == 'ElementalNinjutsu' then
            if state.MagicBurstMode.value == 'Single' then
				state.MagicBurstMode:reset()
			end
			if state.DisplayMode.value then update_job_states()	end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	update_melee_groups()
end

function job_status_change(new_status, old_status)

end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Get custom spell maps
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == "Ninjutsu" then
        if not default_spell_map then
            if spell.target.type == 'SELF' then
                return 'NinjutsuBuff'
            else
                return 'NinjutsuDebuff'
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function job_customize_idle_set(idleSet)
    if state.Buff.Migawari then
        idleSet = set_combine(idleSet, sets.buff.Migawari)
    end

    return idleSet
end

function job_customize_kiting_set(kitingSet)
	if player.status == 'Idle' and moving and state.DefenseMode.value == 'None' and (state.IdleMode.value == 'Normal' or state.IdleMode.value == 'Sphere') then
		if classes.DuskToDawn and sets.DuskKiting then
		kitingSet = set_combine(idleSet, sets.DuskKiting)
		end
	end
	
	return kitingSet
end

-- Modify the default melee set after it was constructed.
function job_customize_melee_set(meleeSet)

	if state.Buff.Yonin then 
		if state.DefenseMode.value == 'None' or state.DefenseMode.value == 'Evasion' then
			meleeSet = set_combine(meleeSet, sets.buff.Yonin)
		end
	elseif state.Buff.Innin then
		if (state.OffenseMode.value == 'Normal' or state.OffenseMode.value == 'Fodder') and state.DefenseMode.value == 'None' then
			meleeSet = set_combine(meleeSet, sets.buff.Innin)
		end
    end
	
	if state.Buff.Migawari then
        meleeSet = set_combine(meleeSet, sets.buff.Migawari)
    end

    return meleeSet
end

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
	update_melee_groups()
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

--[[function determine_haste_group()
    -- We have three groups of DW in gear: Hachiya body/legs, Iga head + Patentia Sash, and DW earrings
    
    -- Standard gear set reaches near capped delay with just Haste (77%-78%, depending on HQs)

    -- For high haste, we want to be able to drop one of the 10% groups.
    -- Basic gear hits capped delay (roughly) with:
    -- 1 March + Haste
    -- 2 March
    -- Haste + Haste Samba
    -- 1 March + Haste Samba
    -- Embrava
    
    -- High haste buffs:
    -- 2x Marches + Haste Samba == 19% DW in gear
    -- 1x March + Haste + Haste Samba == 22% DW in gear
    -- Embrava + Haste or 1x March == 7% DW in gear
    
    -- For max haste (capped magic haste + 25% gear haste), we can drop all DW gear.
    -- Max haste buffs:
    -- Embrava + Haste+March or 2x March
    -- 2x Marches + Haste
    
    -- So we want four tiers:
    -- Normal DW
    -- 20% DW -- High Haste
    -- 7% DW (earrings) - Embrava Haste (specialized situation with embrava and haste, but no marches)
    -- 0 DW - Max Haste
    
    classes.CustomMeleeGroups:clear()
    
    if buffactive.embrava and (buffactive.march == 2 or (buffactive.march and buffactive.haste)) then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.march == 2 and buffactive.haste then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.embrava and (buffactive.haste or buffactive.march) then
        classes.CustomMeleeGroups:append('EmbravaHaste')
    elseif buffactive.march == 1 and buffactive.haste and buffactive['haste samba'] then
        classes.CustomMeleeGroups:append('HighHaste')
    elseif buffactive.march == 2 then
        classes.CustomMeleeGroups:append('HighHaste')
    end
end]]--Removed for now.

function job_self_command(commandArgs, eventArgs)
	if commandArgs[1]:lower() == 'elemental' then
		handle_elemental(commandArgs)
		eventArgs.handled = true

	elseif commandArgs[1] == 'SubJobEnmity' then

		if player.target.type ~= "MONSTER" then
			add_to_chat(123,'Abort: You are not targeting a monster.')
			return

		elseif player.sub_job == 'RUN' then
			local spell_recasts = windower.ffxi.get_spell_recasts()

			if spell_recasts[112] < spell_latency then
				send_command('input /ma "Flash" <t>')
				return
			end
		
			local abil_recasts = windower.ffxi.get_ability_recasts()
			
			if abil_recasts[24] < latency then
				send_command('input /ja "Swordplay" <me>')
			end
			
		elseif player.sub_job == 'BLU' and not moving then
			local spell_recasts = windower.ffxi.get_spell_recasts()
					
			if spell_recasts[584] < spell_latency then
				windower.chat.input('/ma "Sheep Song" <t>')
			elseif spell_recasts[598] < spell_latency then
				windower.chat.input('/ma "Soporific" <t>')
			elseif spell_recasts[605] < spell_latency then
				windower.chat.input('/ma "Geist Wall" <t>')
			elseif spell_recasts[575] < spell_latency then
				windower.chat.input('/ma "Jettatura" <t>')
			elseif spell_recasts[537] < spell_latency then
				windower.chat.input('/ma "Stinking Gas" <t>')
			elseif spell_recasts[592] < spell_latency then
				windower.chat.input('/ma "Blank Gaze" <t>')
			elseif not check_auto_tank_ws() then
				if not state.AutoTankMode.value then add_to_chat(123,'All Enmity Blue Magic on cooldown.') end
			end

		elseif player.sub_job == 'DRK' then
			local abil_recasts = windower.ffxi.get_ability_recasts()
			local spell_recasts = windower.ffxi.get_spell_recasts()
			
			if (state.HybridMode.value ~= 'Normal' or state.DefenseMode.value ~= 'None')  and buffactive['Souleater'] then
				send_command('cancel souleater')
			end
			
			if (state.HybridMode.value ~= 'Normal' or state.DefenseMode.value ~= 'None')  and buffactive['Last Resort'] then
				send_command('cancel last resort')
			end
			
			if spell_recasts[252] < spell_latency and not silent_check_silence() then
				windower.chat.input('/ma "Stun" <t>')
			elseif abil_recasts[85] < latency then
				windower.chat.input('/ja "Souleater" <me>')
			elseif abil_recasts[87] < latency then
				windower.chat.input('/ja "Last Resort" <me>')
			elseif abil_recasts[86] < latency then
				windower.chat.input('/ja "Arcane Circle" <me>')
			elseif not check_auto_tank_ws() then
				if not state.AutoTankMode.value then add_to_chat(123,'All Enmity Dark Knight abillities on cooldown.') end
			end

		elseif player.sub_job == 'WAR' then
			local abil_recasts = windower.ffxi.get_ability_recasts()
			
			if state.HybridMode.value:contains('DD') then
				if buffactive['Defender'] then send_command('cancel defender') end
			elseif state.HybridMode.value ~= 'Normal' and not state.HybridMode.value:contains('DD') then
				if buffactive['Berserk'] then send_command('cancel berserk') end
			end
			
			if abil_recasts[5] < latency then
				send_command('input /ja "Provoke" <t>')
			elseif abil_recasts[2] < latency then
				send_command('input /ja "Warcry" <me>')
			elseif abil_recasts[3] < latency then
				send_command('input /ja "Defender" <me>')
			elseif abil_recasts[4] < latency then
				send_command('input /ja "Aggressor" <me>')
			elseif abil_recasts[1] < latency then
				send_command('input /ja "Berserk" <me>')
			elseif not check_auto_tank_ws() then
				if not state.AutoTankMode.value then add_to_chat(123,'All Enmity Warrior Job Abilities on cooldown.') end
			end
			
		elseif player.sub_job == 'DNC' then
			local abil_recasts = windower.ffxi.get_ability_recasts()
			local under3FMs = not buffactive['Finishing Move 3'] and not buffactive['Finishing Move 4'] and not buffactive['Finishing Move 5']
        
			if under3FMs then
				if abil_recasts[220] < latency then
				send_command('@input /ja "'..state.CurrentStep.value..'" <t>')
				return
				end
			elseif abil_recasts[221] < latency then
				send_command('input /ja "Animated Flourish" <t>')
				return
			elseif abil_recasts[220] < latency and not buffactive['Finishing Move 5'] then
				send_command('@input /ja "'..state.CurrentStep.value..'" <t>')
				return
			elseif not check_auto_tank_ws() then
				if not state.AutoTankMode.value then add_to_chat(123,'Dancer job abilities not needed.') end
			end
		end

	end
end

function job_tick()
	if check_stance() then return true end
	if check_buff() then return true end
	if check_buffup() then return true end
	if state.AutoTankMode.value and player.in_combat and player.target.type == "MONSTER" and not moving then
		windower.send_command('gs c SubJobEnmity')
		tickdelay = os.clock() + 1
		return true
	end
	return false
end

function handle_elemental(cmdParams)
    -- cmdParams[1] == 'elemental'
    -- cmdParams[2] == ability to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No elemental command given.')
        return
    end
    local command = cmdParams[2]:lower()
	local target = '<t>'
	if cmdParams[3] then
		if tonumber(cmdParams[3]) then
			target = tonumber(cmdParams[3])
		else
			target = table.concat(cmdParams, ' ', 3)
			target = get_closest_mob_id_by_name(target) or '<t>'
		end
	end
	local spell_recasts = windower.ffxi.get_spell_recasts()
	
	if command == 'nuke' then
		local tiers = {'San','Ni','Ichi'}
		for k in ipairs(tiers) do
			if spell_recasts[get_spell_table_by_name(data.elements.ninjutsu_nuke_of[state.ElementalMode.value]..': '..tiers[k]..'').id] < spell_latency then
				windower.chat.input('/ma "'..data.elements.ninjutsu_nuke_of[state.ElementalMode.value]..': '..tiers[k]..'" '..target..'')
				return
			end
		end
		add_to_chat(123,'Abort: All '..data.elements.nuke_of[state.ElementalMode.value]..' nukes on cooldown or or not enough MP.')
	elseif S{'San','Ni','Ichi'}:contains(command) then
		windower.chat.input('/ma "'..data.elements.ninjutsu_nuke_of[state.ElementalMode.value]..': '..command..'" '..target..'')
	elseif command == 'proc' then
		windower.chat.input('/ma "'..data.elements.ninjutsu_nuke_of[state.ElementalMode.value]..': Ni" '..target..'')
	end
end

function update_melee_groups()
	if player.equipment.main then
		classes.CustomMeleeGroups:clear()
		
		if player.equipment.main == "Nagi" and state.Buff['Aftermath: Lv.3'] then
				classes.CustomMeleeGroups:append('AM')
		end
	end	
end

function check_stance()
	if state.Stance.value ~= 'None' and player.in_combat then
		
		local abil_recasts = windower.ffxi.get_ability_recasts()

		if state.Stance.value == 'Innin' and not state.Buff.Yonin and abil_recasts[147] < latency then
			windower.chat.input('/ja "Innin" <me>')
			tickdelay = os.clock() + 1.1
			return true
		elseif state.Stance.value == 'Yonin' and not state.Buff.Innin and abil_recasts[146] < latency then
			windower.chat.input('/ja "Yonin" <me>')
			tickdelay = os.clock() + 1.1
			return true
		else
			return false
		end
	end

	return false
end

function check_buff()
	if state.AutoBuffMode.value ~= 'Off' and not data.areas.cities:contains(world.area) then
		local spell_recasts = windower.ffxi.get_spell_recasts()
		for i in pairs(buff_spell_lists[state.AutoBuffMode.Value]) do
			if not buffactive[buff_spell_lists[state.AutoBuffMode.Value][i].Buff] and (buff_spell_lists[state.AutoBuffMode.Value][i].When == 'Always' or (buff_spell_lists[state.AutoBuffMode.Value][i].When == 'Combat' and (player.in_combat or being_attacked)) or (buff_spell_lists[state.AutoBuffMode.Value][i].When == 'Engaged' and player.status == 'Engaged') or (buff_spell_lists[state.AutoBuffMode.Value][i].When == 'Idle' and player.status == 'Idle') or (buff_spell_lists[state.AutoBuffMode.Value][i].When == 'OutOfCombat' and not (player.in_combat or being_attacked))) and spell_recasts[buff_spell_lists[state.AutoBuffMode.Value][i].SpellID] < spell_latency and silent_can_use(buff_spell_lists[state.AutoBuffMode.Value][i].SpellID) then
				windower.chat.input('/ma "'..buff_spell_lists[state.AutoBuffMode.Value][i].Name..'" <me>')
				tickdelay = os.clock() + 2
				return true
			end
		end
		
		if player.in_combat then
			local abil_recasts = windower.ffxi.get_ability_recasts()

			if player.sub_job == 'WAR' and not buffactive.Berserk and not is_defensive() and abil_recasts[1] < latency then
				windower.chat.input('/ja "Berserk" <me>')
				tickdelay = os.clock() + 1.1
				return true
			elseif player.sub_job == 'WAR' and not buffactive.Aggressor and not is_defensive() and abil_recasts[4] < latency then
				windower.chat.input('/ja "Aggressor" <me>')
				tickdelay = os.clock() + 1.1
				return true
			else
				return false
			end
		end
	end
		
	return false
end

function check_buffup()
	if buffup ~= '' then
		local needsbuff = false
		for i in pairs(buff_spell_lists[buffup]) do
			if not buffactive[buff_spell_lists[buffup][i].Buff] and silent_can_use(buff_spell_lists[buffup][i].SpellID) then
				needsbuff = true
				break
			end
		end
	
		if not needsbuff then
			add_to_chat(217, 'All '..buffup..' buffs are up!')
			buffup = ''
			return false
		end
		
		local spell_recasts = windower.ffxi.get_spell_recasts()
		
		for i in pairs(buff_spell_lists[buffup]) do
			if not buffactive[buff_spell_lists[buffup][i].Buff] and silent_can_use(buff_spell_lists[buffup][i].SpellID) and spell_recasts[buff_spell_lists[buffup][i].SpellID] < spell_latency then
				windower.chat.input('/ma "'..buff_spell_lists[buffup][i].Name..'" <me>')
				tickdelay = os.clock() + 2
				return true
			end
		end
		
		return false
	else
		return false
	end
end

buff_spell_lists = {
	Auto = {	
		{Name='Migawari: Ichi',Buff='Migawari',SpellID=510,When='Combat'},
	},
	
	Default = {
		{Name='Myoshu: Ichi',Buff='Subtle Blow Plus',SpellID=507,Reapply=false},
		{Name='Kakka: Ichi',Buff='Store TP',SpellID=509,Reapply=false},
	},
}