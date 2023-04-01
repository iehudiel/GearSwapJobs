function user_job_setup()

    -- Options: Override default values	
	state.OffenseMode:options('Normal','Acc')
    state.HybridMode:options('Tank','DDTank','BreathTank','Dawn','NoShellTank','Normal')
    state.WeaponskillMode:options('Match','Normal', 'Acc')
    state.CastingMode:options('Normal','SIRD')
	state.Passive:options('None','AbsorbMP')
    state.PhysicalDefenseMode:options('PDT','PDT_HP','Tank')
    state.MagicalDefenseMode:options('BDT','MDT_HP','AegisMDT','AegisNoShellMDT','OchainMDT','OchainNoShellMDT','MDT_Reraise')
	state.ResistDefenseMode:options('MEVA','MEVA_HP','Death','Charm')
	state.IdleMode:options('Normal','Tank','KiteTank','PDT','MDT','Refresh','Reraise')
	state.Weapons:options('None','DeaconAegis','SequenceAegis','SequenceBlurred')
	
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode','None','MP','Twilight'}
	
	gear.fastcast_jse_back = {name="Rudianos's Mantle",augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10',}}
	gear.enmity_jse_back = {name="Rudianos's Mantle",augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10',}}

	-- Additional local binds
	send_command('bind !` gs c SubJobEnmity')
	send_command('bind ^backspace input /ja "Shield Bash" <t>')
	send_command('bind @backspace input /ja "Cover" <stpt>')
	send_command('bind !backspace input /ja "Sentinel" <me>')
	send_command('bind @= input /ja "Chivalry" <me>')
	send_command('bind != input /ja "Palisade" <me>')
	send_command('bind ^delete input /ja "Provoke" <stnpc>')
	send_command('bind !delete input /ma "Cure IV" <stal>')
	send_command('bind @delete input /ma "Flash" <stnpc>')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
	send_command('bind @` gs c cycle RuneElement')
	send_command('bind ^pause gs c toggle AutoRuneMode')
	send_command('bind @f8 gs c toggle AutoTankMode')
	send_command('bind @f10 gs c toggle TankAutoDefense')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	
    select_default_macro_book()
    update_defense_mode()
end

function init_gear_sets()
	
	--------------------------------------
	-- Precast sets
	--------------------------------------
	
    sets.Enmity = {
		main={ name="Burtgang", augments={'Path: A',}},
		ammo="Staunch Tathlum",
		head={ name="Loess Barbuta +1", augments={'Path: A',}},
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Moonlight Necklace",
		waist="Creed Baudrier",
		left_ear="Cryptic Earring",
		right_ear="Friomisi Earring",
		left_ring="Apeile Ring +1",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','VIT+10','Enmity+10','Damage taken-5%',}},
	}
		
    sets.Enmity.SIRD = {
		main={ name="Burtgang", augments={'Path: A',}},
		ammo="Staunch Tathlum",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		body="Rev. Surcoat +3",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Founder's Hose", augments={'MND+6','Mag. Acc.+6',}},
		feet={ name="Odyssean Greaves", augments={'AGI+6','Rng.Acc.+12 Rng.Atk.+12','"Treasure Hunter"+1','Accuracy+14 Attack+14',}},
		neck="Moonlight Necklace",
		waist="Rumination Sash",
		left_ear="Cryptic Earring",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Apeile Ring +1",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','VIT+10','Enmity+10','Damage taken-5%',}},
		}
		
    sets.Enmity.DT = {
		main={ name="Burtgang", augments={'Path: A',}},
		ammo="Staunch Tathlum",
		head={ name="Loess Barbuta +1", augments={'Path: A',}},
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Moonlight Necklace",
		waist="Flume Belt +1",
		left_ear="Cryptic Earring",
		right_ear="Etiolation Earring",
		left_ring="Apeile Ring +1",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','VIT+10','Enmity+10','Damage taken-5%',}},
	}
		
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = set_combine(sets.Enmity,{legs={ name="Cab. Breeches +1", augments={'Enhances "Invincible" effect',}},})
    sets.precast.JA['Holy Circle'] = set_combine(sets.Enmity,{feet="Rev. Leggings +2",})
    sets.precast.JA['Sentinel'] = set_combine(sets.Enmity,{})
    sets.precast.JA['Rampart'] = set_combine(sets.Enmity,{}) --head="Valor Coronet" (Also Vit?)
    sets.precast.JA['Fealty'] = set_combine(sets.Enmity,{body={ name="Cab. Surcoat +3", augments={'Enhances "Fealty" effect',}}})
    sets.precast.JA['Divine Emblem'] = set_combine(sets.Enmity,{ feet="Chev. Sabatons +2", })
    sets.precast.JA['Cover'] = set_combine(sets.Enmity, {
		head="Rev. Coronet +1",
		body={ name="Cab. Surcoat +3", augments={'Enhances "Fealty" effect',}}}) --head="Rev. Coronet +1",
	
    sets.precast.JA['Invincible'].DT = set_combine(sets.Enmity.DT,{legs={ name="Cab. Breeches +1", augments={'Enhances "Invincible" effect',}},})
    sets.precast.JA['Holy Circle'].DT = set_combine(sets.Enmity.DT,{feet="Rev. Leggings +2",})
    sets.precast.JA['Sentinel'].DT = set_combine(sets.Enmity.DT,{})
    sets.precast.JA['Rampart'].DT = set_combine(sets.Enmity.DT,{}) --head="Valor Coronet" (Also Vit?)
    sets.precast.JA['Fealty'].DT = set_combine(sets.Enmity.DT,{body={ name="Cab. Surcoat +3", augments={'Enhances "Fealty" effect',}}})
    sets.precast.JA['Divine Emblem'].DT = set_combine(sets.Enmity.DT,{})
    sets.precast.JA['Cover'].DT = set_combine(sets.Enmity.DT, {
		head="Rev. Coronet +1",
		body={ name="Cab. Surcoat +3", augments={'Enhances "Fealty" effect',}}}) --head="Rev. Coronet +1",
	
    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {}

	sets.precast.JA['Shield Bash'] = set_combine(sets.Enmity, {})		
    sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Palisade'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Intervene'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})
	
	sets.precast.JA['Shield Bash'].DT = set_combine(sets.Enmity.DT, {})		
    sets.precast.JA['Provoke'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Warcry'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Palisade'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Intervene'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Defender'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Berserk'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Aggressor'].DT = set_combine(sets.Enmity.DT, {})

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Step = {}
		
	sets.precast.JA['Violent Flourish'] = {}
		
	sets.precast.JA['Animated Flourish'] = set_combine(sets.Enmity, {})

    -- Fast cast sets for spells
    
    sets.precast.FC = {
		--main="Malignance Sword",
		ammo="Staunch Tathlum",
		head="Sakpata's Helm",
		body="Rev. Surcoat +3",
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs={ name="Founder's Hose", augments={'MND+6','Mag. Acc.+6',}},
		feet="Chev. Sabatons +2",
		neck="Moonlight Necklace",
		waist="Rumination Sash",
		left_ear="Etiolation Earring",
		right_ear="Halasz Earring",
		left_ring="Kishar Ring",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'VIT+12','Accuracy+9 Attack+9','STR+5','"Fast Cast"+10','Damage taken-2%',}},
	}
		
    sets.precast.FC.DT = set_combine(sets.precast.FC, {})
		
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})
	
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})
  
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Ginsen",
		head="Hjarrandi Helm",
		body="Hjarrandi Breast.",
		hands={ name="Odyssean Gauntlets", augments={'Weapon skill damage +2%','Accuracy+2','Mag. Acc.+3 "Mag.Atk.Bns."+3',}},
		legs={ name="Valor. Hose", augments={'Weapon skill damage +3%','STR+9','Attack+7',}},
		feet="Sulev. Leggings +2",
		neck="Asperity Necklace",
		waist="Kentarch Belt",
		left_ear="Digni. Earring",
		right_ear="Ishvara Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','VIT+10','Enmity+10','Damage taken-5%',}},
	}
		
    sets.precast.WS.DT = {}

    sets.precast.WS.Acc = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {})

	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {})

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		body={ name="Nyame Mail", augments={'Path: B',}},
	})
    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {
		body={ name="Nyame Mail", augments={'Path: B',}},
	})
	
	sets.precast.WS['Flat Blade'] = {}

	sets.precast.WS['Flat Blade'].Acc = {}

    sets.precast.WS['Sanguine Blade'] = {}

	sets.precast.WS['Sanguine Blade'].Acc = sets.precast.WS['Sanguine Blade']

    sets.precast.WS['Atonement'] = {	
		main={ name="Burtgang", augments={'Path: A',}},
		ammo="Staunch Tathlum",
		head={ name="Loess Barbuta +1", augments={'Path: A',}},
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Unmoving Collar +1",
		waist="Creed Baudrier",
		left_ear="Ishvara Earring",
		right_ear="Thrud Earring",
		left_ring="Vocane Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','VIT+10','Enmity+10','Damage taken-5%',}},
	}

    sets.precast.WS['Atonement'].Acc = sets.precast.WS['Atonement']
    sets.precast.WS['Spirits Within'] = sets.precast.WS['Atonement']
    sets.precast.WS['Spirits Within'].Acc = sets.precast.WS['Atonement']

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}


	--------------------------------------
	-- Midcast sets
	--------------------------------------

    sets.midcast.FastRecast = {}
		
	sets.midcast.FastRecast.DT = {}

    sets.midcast.Flash = set_combine(sets.Enmity, {})
	sets.midcast.Flash.SIRD = set_combine(sets.Enmity.SIRD, {})
    sets.midcast.Stun = set_combine(sets.Enmity, {})
	sets.midcast.Stun.SIRD = set_combine(sets.Enmity.SIRD, {})
	sets.midcast['Blue Magic'] = set_combine(sets.Enmity, {})
	sets.midcast['Blue Magic'].SIRD = set_combine(sets.Enmity.SIRD, {})
	sets.midcast.Cocoon = set_combine(sets.Enmity.SIRD, {})

    sets.midcast.Cure = {
		main={ name="Burtgang", augments={'Path: A',}},
		ammo="Staunch Tathlum",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		body="Rev. Surcoat +3",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Founder's Hose", augments={'MND+6','Mag. Acc.+6',}},
		feet={ name="Odyssean Greaves", augments={'AGI+6','Rng.Acc.+12 Rng.Atk.+12','"Treasure Hunter"+1','Accuracy+14 Attack+14',}},
		neck="Moonlight Necklace",
		waist="Rumination Sash",
		left_ear="Etiolation Earring",
		right_ear="Nourish. Earring +1",
		left_ring="Vocane Ring",
		right_ring="Sirona's Ring",
		back={ name="Rudianos's Mantle", augments={'VIT+12','Accuracy+9 Attack+9','STR+5','"Fast Cast"+10','Damage taken-2%',}},
	}
		
    sets.midcast.Cure.SIRD = set_combine(sets.Enmity.SIRD, sets.midcast.Cure)
		
    sets.midcast.Cure.DT = {}
		
    sets.midcast.Reprisal = {sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}},}

	sets.Self_Healing = {}
		
	sets.Self_Healing.SIRD = {}
		
	sets.Self_Healing.DT = {}

	sets.Cure_Received = {
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},}
	sets.Self_Refresh = {}

    sets.midcast['Enhancing Magic'] = --{main="Pukulatmuj +1",}
	   {}
		
    sets.midcast['Enhancing Magic'].SIRD = {
		ammo="Staunch Tathlum",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs={ name="Founder's Hose", augments={'MND+6','Mag. Acc.+6',}},
		feet={ name="Odyssean Greaves", augments={'AGI+6','Rng.Acc.+12 Rng.Atk.+12','"Treasure Hunter"+1','Accuracy+14 Attack+14',}},
		neck="Moonlight Necklace",
		waist="Rumination Sash",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear="Halasz Earring",
		left_ring="Kishar Ring",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'VIT+12','Accuracy+9 Attack+9','STR+5','"Fast Cast"+10','Damage taken-2%',}},}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})

    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {})
	
	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		body={ name="Cab. Surcoat +3", augments={'Enhances "Fealty" effect',}},
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs="Sakpata's Cuisses",
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Enhancing Torque",
		waist="Flume Belt +1",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear="Thureous Earring",
		left_ring="Stikini Ring +1",
		right_ring="Defending Ring",
		back={ name="Weard Mantle", augments={'VIT+4','DEX+2','Enmity+3','Phalanx +5',}},})
	sets.midcast.Phalanx.SIRD = set_combine(sets.midcast['Enhancing Magic'].SIRD, {})
	sets.midcast.Phalanx.DT = set_combine(sets.midcast.Phalanx.SIRD, {})	

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

    sets.resting = {
		main="Malignance Sword",
		}

    -- Idle sets
    sets.idle = {	
		main={ name="Burtgang", augments={'Path: A',}},
		sub="Aegis",
		ammo="Staunch Tathlum",
		head="Chev. Armet +2",
		body={ name="Cab. Surcoat +3", augments={'Enhances "Fealty" effect',}},
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet="Rev. Leggings +2",
		neck="Diemer Gorget",
		waist="Flume Belt +1",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear={ name="Chev. Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+10','Mag. Acc.+10',}},
		left_ring="Vocane Ring",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','VIT+10','Enmity+10','Damage taken-5%',}},
	}
		
    sets.idle.PDT = {
	    main={ name="Burtgang", augments={'Path: A',}},
		sub="Aegis",
		ammo="Staunch Tathlum",
		head="Chev. Armet +2",
		body={ name="Cab. Surcoat +3", augments={'Enhances "Fealty" effect',}},
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Diemer Gorget",
		waist="Flume Belt +1",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear={ name="Chev. Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+10','Mag. Acc.+10',}},
		left_ring="Vocane Ring",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','VIT+10','Enmity+10','Damage taken-5%',}},
	}
		
    sets.idle.MDT = set_combine(sets.idle, 
		{sub="Aegis",
		left_ear="Etiolation Earring",
		ammo="Staunch Tathlum",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		feet="Sakpata's Leggings",
		neck="Diemer Gorget",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear={ name="Chev. Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+10','Mag. Acc.+10',}},
		left_ring="Vocane Ring",
		right_ring="Defending Ring",
		waist="Carrier's Sash",
		})
		
	sets.idle.Refresh = {}

	sets.idle.Tank = {
		main={ name="Burtgang", augments={'Path: A',}},
		sub="Aegis",
		ammo="Staunch Tathlum",
		head={ name="Loess Barbuta +1", augments={'Path: A',}},
		body={ name="Cab. Surcoat +3", augments={'Enhances "Fealty" effect',}},
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Diemer Gorget",
		waist="Flume Belt +1",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear={ name="Chev. Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+10','Mag. Acc.+10',}},
		left_ring="Vocane Ring",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','VIT+10','Enmity+10','Damage taken-5%',}},}
		
	sets.idle.KiteTank = {
		main={ name="Burtgang", augments={'Path: A',}},
		sub="Aegis",
		ammo="Staunch Tathlum",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		--legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet="Sakpata's Leggings",
		neck="Diemer Gorget",
		waist="Flume Belt +1",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear={ name="Chev. Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+10','Mag. Acc.+10',}},
		left_ring="Vocane Ring",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','VIT+10','Enmity+10','Damage taken-5%',}},
	}
		
    sets.idle.Reraise = {}
		
    sets.idle.Weak = {}
		
	sets.Kiting = {
		main={ name="Burtgang", augments={'Path: A',}},
		sub="Aegis",
		ammo="Staunch Tathlum",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet="Sakpata's Leggings",
		neck="Diemer Gorget",
		waist="Flume Belt +1",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear={ name="Chev. Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+10','Mag. Acc.+10',}},
		left_ring="Vocane Ring",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','VIT+10','Enmity+10','Damage taken-5%',}},
	}

	sets.latent_refresh = {}
	sets.latent_refresh_grip = {}
	sets.latent_regen = {}
	sets.DayIdle = {}
	sets.NightIdle = {}

	--------------------------------------
    -- Defense sets
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
	sets.Knockback = {}
    sets.MP = {
		head="Chev. Armet +2",
		feet="Rev. Leggings +2",
	}
	sets.passive.AbsorbMP = {
		head="Chev. Armet +2",
		feet="Rev. Leggings +2",
	}
    sets.MP_Knockback = {}
    sets.Twilight = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons.DeaconAegis = {sub="Aegis",}
	sets.weapons.SequenceBlurred = {}
	sets.weapons.SequenceAegis = {sub="Aegis",}
	sets.weapons.DualWeapons = {}
    
    sets.defense.PDT = {}
		
    sets.defense.PDT_HP = {}
		
    sets.defense.MDT_HP = {}
		
    sets.defense.MEVA_HP = {}
		
    sets.defense.PDT_Reraise = {}
		
    sets.defense.MDT_Reraise = {}

	sets.defense.BDT = {}
		
	sets.defense.Tank = {}
		
	sets.defense.MEVA = {}
		
	sets.defense.Death = {ammo="Staunch Tathlum",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet="Sakpata's Leggings",
		neck="Moonlight Necklace",
		waist="Carrier's Sash",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear={ name="Chev. Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+10','Mag. Acc.+10',}},
		left_ring="Warden's Ring",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','VIT+10','Enmity+10','Damage taken-5%',}},}
		
	sets.defense.Charm = {ammo="Staunch Tathlum",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet="Sakpata's Leggings",
		neck="Unmoving Collar +1",
		waist="Carrier's Sash",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear={ name="Chev. Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+10','Mag. Acc.+10',}},
		left_ring="Vocane Ring",
		right_ring="Defending Ring",
		back="Solemnity Cape",}
		
		-- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
    sets.defense.OchainMDT = {}
		
    sets.defense.OchainNoShellMDT = {}
		
    sets.defense.AegisMDT = {sub="Aegis",}
		
    sets.defense.AegisNoShellMDT = {}		

	--------------------------------------
	-- Engaged sets
	--------------------------------------
    
	sets.engaged = set_combine(sets.idle.Tank, {
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		})

    sets.engaged.Acc = set_combine(sets.idle.Tank, {
		ammo="Ginsen",
		head="Hjarrandi Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Diemer Gorget",
		waist="Kentarch Belt",
		left_ear="Telos Earring",
		right_ear="Digni. Earring",
		left_ring="Petrov Ring",
		right_ring="Chirich Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','VIT+10','Enmity+10','Damage taken-5%',}},
		})

    sets.engaged.DW = {}

    sets.engaged.DW.Acc = {}

	sets.engaged.Tank = set_combine(sets.idle.Tank,{
		head="Hjarrandi Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		waist="Carrier's Sash",
	   })
		
	sets.engaged.Dawn = {}
		
	sets.engaged.BreathTank = {}
		
	sets.engaged.DDTank = {}
		
	sets.engaged.Acc.DDTank = {}
		
	sets.engaged.NoShellTank = {}
		
    sets.engaged.Reraise = set_combine(sets.engaged.Tank, sets.Reraise)
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc.Tank, sets.Reraise)
		
	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {}
    sets.buff.Cover = {}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'NIN' then
        set_macro_page(2, 4)
    elseif player.sub_job == 'RUN' then
        set_macro_page(2, 2)
    elseif player.sub_job == 'RDM' then
        set_macro_page(2, 1)
    elseif player.sub_job == 'BLU' then
        set_macro_page(2, 2)
    elseif player.sub_job == 'DNC' then
        set_macro_page(2, 3)
    else
        set_macro_page(2, 1) --War/Etc
    end
end