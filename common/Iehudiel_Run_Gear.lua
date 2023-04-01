function user_job_setup()

	state.OffenseMode:options('Normal','SomeAcc','Acc','HighAcc','FullAcc')
	state.HybridMode:options('Normal','DTLite','Tank')
	state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','HighAcc','FullAcc')
	state.CastingMode:options('Normal','SIRD')
	state.PhysicalDefenseMode:options('PDT_HP','PDT')
	state.MagicalDefenseMode:options('MDT_HP','BDT_HP','MDT','BDT')
	state.ResistDefenseMode:options('MEVA_HP','MEVA','Death','Charm','DTCharm')
	state.IdleMode:options('Normal','Tank','KiteTank','Sphere')
	state.Weapons:options('None','Aettir','Lionheart','DualWeapons')
	
	state.ExtraDefenseMode = M{['description']='Extra Defense Mode','None','MP'}

	gear.enmity_jse_back = {name="Ogma's cape",augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}}
	gear.stp_jse_back = {name="Ogma's cape",augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}}
	gear.da_jse_back = {name="Ogma's cape",augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}

	-- Additional local binds
	send_command('bind !` gs c SubJobEnmity')
	send_command('bind @` gs c cycle RuneElement')
	send_command('bind ^` gs c RuneElement')
	send_command('bind @pause gs c toggle AutoRuneMode')
	send_command('bind ^delete input /ja "Provoke" <stnpc>')
	send_command('bind !delete input /ma "Cure IV" <stal>')
	send_command('bind @delete input /ma "Flash" <stnpc>')
	send_command('bind ^\\\\ input /ma "Protect IV" <t>')
	send_command('bind @\\\\ input /ma "Shell V" <t>')
	send_command('bind !\\\\ input /ma "Crusade" <me>')
	send_command('bind ^backspace input /ja "Lunge" <t>')
	send_command('bind @backspace input /ja "Gambit" <t>')
	send_command('bind !backspace input /ja "Rayke" <t>')
	send_command('bind @f8 gs c toggle AutoTankMode')
	send_command('bind @f10 gs c toggle TankAutoDefense')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	send_command('bind !r gs c weapons Lionheart;gs c update')
	
	select_default_macro_book()
end

function init_gear_sets()

    sets.Enmity = {
	    ammo="Staunch Tathlum",
		head="Agwu's Cap",
		body="Emet Harness +1",
		hands={ name="Rawhide Gloves", augments={'Mag. Acc.+15','INT+7','MND+7',}},
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Taeon Boots", augments={'Spell interruption rate down -9%','Phalanx +3',}},
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Sulla Belt",
		left_ear="Halasz Earring",
		right_ear="Cryptic Earring",
		left_ring="Begrudging Ring",
		right_ring="Petrov Ring",
		back="Ogma's Cape",
	}
		 
    sets.Enmity.SIRD = {
	    ammo="Staunch Tathlum",
		head="Agwu's Cap",
		body="Emet Harness +1",
		hands={ name="Rawhide Gloves", augments={'Mag. Acc.+15','INT+7','MND+7',}},
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Taeon Boots", augments={'Spell interruption rate down -9%','Phalanx +3',}},
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Sulla Belt",
		left_ear="Halasz Earring",
		right_ear="Cryptic Earring",
		left_ring="Begrudging Ring",
		right_ring="Petrov Ring",
		back="Ogma's Cape",
	}
		
    sets.Enmity.SIRDT = {
	    ammo="Staunch Tathlum",
		head="Agwu's Cap",
		body="Emet Harness +1",
		hands={ name="Rawhide Gloves", augments={'Mag. Acc.+15','INT+7','MND+7',}},
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Taeon Boots", augments={'Spell interruption rate down -9%','Phalanx +3',}},
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Sulla Belt",
		left_ear="Halasz Earring",
		right_ear="Cryptic Earring",
		left_ring="Begrudging Ring",
		right_ring="Petrov Ring",
		back="Ogma's Cape",
	}

    sets.Enmity.DT = {
	    ammo="Staunch Tathlum",
		head="Agwu's Cap",
		body="Emet Harness +1",
		hands={ name="Rawhide Gloves", augments={'Mag. Acc.+15','INT+7','MND+7',}},
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Taeon Boots", augments={'Spell interruption rate down -9%','Phalanx +3',}},
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Sulla Belt",
		left_ear="Halasz Earring",
		right_ear="Cryptic Earring",
		left_ring="Begrudging Ring",
		right_ring="Petrov Ring",
		back="Ogma's Cape",
	}
		
	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Item sets.

	-- Precast sets to enhance JAs
    sets.precast.JA['Vallation'] = set_combine(sets.Enmity,{body="Runeist's Coat +3",back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','VIT+10','Enmity+10','Phys. dmg. taken-10%',}},})
    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
    sets.precast.JA['Pflug'] = set_combine(sets.Enmity,{feet="Runeist's Boots +3"})
    sets.precast.JA['Battuta'] = set_combine(sets.Enmity,{head="Futhark Bandeau +3"})
    sets.precast.JA['Liement'] = set_combine(sets.Enmity,{body="Futhark Coat +3"})
    sets.precast.JA['Gambit'] = set_combine(sets.Enmity,{hands="Runeist's Mitons +3"})
    sets.precast.JA['Rayke'] = set_combine(sets.Enmity,{feet="Futhark Bottes"})
    sets.precast.JA['Elemental Sforzo'] = set_combine(sets.Enmity, {body="Futhark Coat +3"})
    sets.precast.JA['Swordplay'] = set_combine(sets.Enmity, {hands="Futhark Mitons"})
    sets.precast.JA['Embolden'] = set_combine(sets.Enmity,{})
    sets.precast.JA['One For All'] = {
		ammo="Staunch Tathlum",
		head="Agwu's Cap",
		body="Emet Harness +1",
		hands={ name="Rawhide Gloves", augments={'Mag. Acc.+15','INT+7','MND+7',}},
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Taeon Boots", augments={'Spell interruption rate down -9%','Phalanx +3',}},
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Sulla Belt",
		left_ear="Halasz Earring",
		right_ear="Cryptic Earring",
		left_ring="Begrudging Ring",
		right_ring="Petrov Ring",
		back="Ogma's Cape",
	}
    sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Last Resort'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Animated Flourish'] = set_combine(sets.Enmity, {})

    sets.precast.JA['Vallation'].DT = set_combine(sets.Enmity.DT,{body="Runeist's Coat +3",back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','VIT+10','Enmity+10','Phys. dmg. taken-10%',}},})
    sets.precast.JA['Valiance'].DT = sets.precast.JA['Vallation'].DT
    sets.precast.JA['Pflug'].DT = set_combine(sets.Enmity.DT,{feet="Runeist's Boots +3"})
    sets.precast.JA['Battuta'].DT = set_combine(sets.Enmity.DT,{head="Futhark Bandeau +1"})
    sets.precast.JA['Liement'].DT = set_combine(sets.Enmity.DT,{body="Futhark Coat +1"})
    sets.precast.JA['Gambit'].DT = set_combine(sets.Enmity.DT,{hands="Runeist's Mitons +3"})
    sets.precast.JA['Rayke'].DT = set_combine(sets.Enmity.DT,{feet="Futhark Bottes"})
    sets.precast.JA['Elemental Sforzo'].DT = set_combine(sets.Enmity.DT,{body="Futhark Coat +3"})
    sets.precast.JA['Swordplay'].DT = set_combine(sets.Enmity.DT,{hands="Futhark Mitons"})
    sets.precast.JA['Embolden'].DT = set_combine(sets.Enmity.DT,{})
    sets.precast.JA['One For All'].DT = {
		ammo="Staunch Tathlum",
		head="Agwu's Cap",
		body="Emet Harness +1",
		hands={ name="Rawhide Gloves", augments={'Mag. Acc.+15','INT+7','MND+7',}},
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Taeon Boots", augments={'Spell interruption rate down -9%','Phalanx +3',}},
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Sulla Belt",
		left_ear="Halasz Earring",
		right_ear="Cryptic Earring",
		left_ring="Begrudging Ring",
		right_ring="Petrov Ring",
		back="Ogma's Cape",
	}
    sets.precast.JA['Provoke'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Warcry'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Defender'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Berserk'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Last Resort'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Aggressor'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Animated Flourish'].DT = set_combine(sets.Enmity.DT, {})

    sets.precast.JA['Lunge'] = {
		ammo="Aqreqaq Bomblet",
		head="Rabid Visor",
		body="Emet Harness +1",
		hands="Meg. Gloves +2",
		legs="Eri. Leg Guards +1",
		feet="Erilaz Greaves +1",
		neck="Unmoving Collar",
		waist="Sulla Belt",
		left_ear="Friomisi Earring",
		right_ear="Cryptic Earring",
		left_ring="Begrudging Ring",
		right_ring="Petrov Ring",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','VIT+10','Enmity+10','Phys. dmg. taken-10%',}},
	}

	sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']

	-- Gear for specific elemental nukes.
	sets.element.Dark = {head="Pixie Hairpin +1",ring2="Archon Ring"}

	-- Pulse sets, different stats for different rune modes, stat aligned.
    sets.precast.JA['Vivacious Pulse'] = {
		ammo="Aqreqaq Bomblet",
		head="Erilaz Galea +1",
		body="Emet Harness +1",
		hands="Meg. Gloves +2",
		legs="Eri. Leg Guards +1",
		feet="Erilaz Greaves +1",
		neck="Unmoving Collar",
		waist="Sulla Belt",
		left_ear="Friomisi Earring",
		right_ear="Cryptic Earring",
		left_ring="Begrudging Ring",
		right_ring="Petrov Ring",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','VIT+10','Enmity+10','Phys. dmg. taken-10%',}},
	}
    sets.precast.JA['Vivacious Pulse']['Ignis'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Gelus'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Flabra'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Tellus'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Sulpor'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Unda'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Lux'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Tenebrae'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	
	
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Yamarang",
        head="Carmine Mask +1",neck="Unmoving Collar +1",ear1="Enchntr. Earring +1",ear2="Handler's Earring +1",
        body=gear.herculean_waltz_body,hands=gear.herculean_waltz_hands,ring1="Defending Ring",ring2="Valseur's Ring",
        back="Moonlight Cape",waist="Chaac Belt",legs="Dashing Subligar",feet=gear.herculean_waltz_feet}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
	
    sets.precast.Step = {}
		
	sets.precast.JA['Violent Flourish'] = {}
		
	-- Fast cast sets for spells
    sets.precast.FC = {
		ammo="Staunch Tathlum",
		head="Agwu's Cap",
		body="Agwu's Robe",
		hands="Agwu's Gages",
		legs={ name="Agwu's Slops", augments={'Path: A',}},
		feet="Agwu's Pigaches",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Genmei Earring",
		left_ring="Kishar Ring",
		right_ring="Defending Ring",
		back="Ogma's Cape",
	}
			
	sets.precast.FC.DT = {main="Malignance Sword",sub="Chanter's Shield",ammo="Impatiens",
        head="Rune. Bandeau +3",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Tuisto Earring",
        body="Runeist's Coat +3",hands="Leyline Gloves",ring1="Gelatinous Ring +1",ring2="Moonlight Ring",
        back="Moonlight Cape",waist="Audumbla Sash",legs="Eri. Leg Guards +1",feet="Carmine Greaves +1"}
		
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {legs="Futhark Trousers +1",head="Erilaz Galea +1",
    body="Emet Harness +1",})
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck='Magoraga beads', back="Mujin Mantle"})
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

	-- Weaponskill sets
	sets.precast.WS = {ammo="Knobkierrie",
            head="Lilitu Headpiece",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Sherida Earring",
            body="Adhemar Jacket +1",hands="Meg. Gloves +2",ring1="Niqmaddu Ring",ring2="Regal Ring",
            back=gear.da_jse_back,waist="Fotia Belt",legs="Meg. Chausses +2",feet=gear.herculean_ta_feet}
	sets.precast.WS.SomeAcc = {ammo="Voluspa Tathlum",
            head="Adhemar Bonnet +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Sherida Earring",
            body="Ayanmo Corazza +2",hands="Meg. Gloves +2",ring1="Niqmaddu Ring",ring2="Regal Ring",
            back=gear.da_jse_back,waist="Fotia Belt",legs="Meg. Chausses +2",feet=gear.herculean_ta_feet}
	sets.precast.WS.Acc = {ammo="C. Palug Stone",
            head="Dampening Tam",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Sherida Earring",
            body="Ayanmo Corazza +2",hands="Meg. Gloves +2",ring1="Niqmaddu Ring",ring2="Regal Ring",
            back=gear.da_jse_back,waist="Fotia Belt",legs="Meg. Chausses +2",feet=gear.herculean_ta_feet}
	sets.precast.WS.HighAcc = {ammo="C. Palug Stone",
            head="Meghanada Visor +2",neck="Fotia Gorget",ear1="Telos Earring",ear2="Sherida Earring",
            body="Ayanmo Corazza +2",hands="Meg. Gloves +2",ring1="Niqmaddu Ring",ring2="Regal Ring",
            back=gear.da_jse_back,waist="Fotia Belt",legs="Meg. Chausses +2",feet=gear.herculean_acc_feet}
	sets.precast.WS.FullAcc = {ammo="C. Palug Stone",
            head="Carmine Mask +1",neck="Combatant's Torque",ear1="Telos Earring",ear2="Mache Earring +1",
            body="Meg. Cuirie +2",hands="Meg. Gloves +2",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
            back=gear.stp_jse_back,waist="Fotia Belt",legs="Meg. Chausses +2",feet=gear.herculean_acc_feet}

	sets.precast.WS['Savage Blade'] = {
		ammo="Knobkierrie",
		head={ name="Herculean Helm", augments={'Accuracy+12 Attack+12','Weapon skill damage +5%','STR+6','Attack+5',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Meg. Gloves +2",
		legs={ name="Herculean Trousers", augments={'Accuracy+13','Weapon skill damage +5%','STR+2',}},
		feet={ name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}},
		neck="Futhark Torque +2",
		waist="Prosilio Belt +1",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Karieyh Ring +1",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
    sets.precast.WS['Resolution'] = {
		ammo="Yamarang",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Meg. Chausses +2",
		feet={ name="Herculean Boots", augments={'Accuracy+12 Attack+12','"Triple Atk."+3','Accuracy+5','Attack+8',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
	}
    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'],{ammo="Honed Tathlum", body="Dread Jupon", hands="Umuthi Gloves", back="Evasionist's Cape", legs="Manibozho Legs"})
    sets.precast.WS['Resolution'].HighAcc = set_combine(sets.precast.WS['Resolution'].Acc,{})
	sets.precast.WS['Resolution'].FullAcc = set_combine(sets.precast.WS.FullAcc,{})

    sets.precast.WS['Dimidiation'] = {
		ammo="Yamarang",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Meg. Chausses +2",
		feet={ name="Herculean Boots", augments={'Accuracy+12 Attack+12','"Triple Atk."+3','Accuracy+5','Attack+8',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
	}
    sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'],{ammo="Honed Tathlum", head="Whirlpool Mask", hands="Buremte Gloves", back="Evasionist's Cape", waist="Thunder Belt"})
	sets.precast.WS['Dimidiation'].HighAcc = set_combine(sets.precast.WS.HighAcc,{legs=gear.herculean_wsd_legs,feet=gear.herculean_wsd_feet})
	sets.precast.WS['Dimidiation'].FullAcc = set_combine(sets.precast.WS.FullAcc,{})
	
    sets.precast.WS['Ground Strike'] = {
		ammo="Yamarang",
		head="Aya. Zucchetto +2",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Meg. Chausses +2",
		feet="Runeist's Boots +3",
		neck="Combatant's Torque",
		waist="Kentarch Belt +1",
		left_ear="Telos Earring",
		right_ear="Digni. Earring",
		left_ring="Regal Ring",
		right_ring="Chirich Ring +1",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
    sets.precast.WS['Ground Strike'].Acc = set_combine(sets.precast.WS.Acc,{})
	sets.precast.WS['Ground Strike'].HighAcc = set_combine(sets.precast.WS.HighAcc,{})
	sets.precast.WS['Ground Strike'].FullAcc = set_combine(sets.precast.WS.FullAcc,{})
		
    sets.precast.WS['Herculean Slash'] = set_combine(sets.precast['Lunge'], {hands="Umuthi Gloves"})
	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast['Lunge'], {})
	
	sets.precast.WS['Shockwave'] = {
		ammo="Pemphredo Tathlum",
		head="Volte Cap",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Volte Hose",
		feet="Volte Boots",
		neck="Sanctity Necklace",
		waist="Chaac Belt",
		left_ear="Gwati Earring",
		right_ear="Digni. Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	sets.precast.WS['Decimation'] = {
		ammo="Yamarang",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Meg. Chausses +2",
		feet={ name="Herculean Boots", augments={'Accuracy+12 Attack+12','"Triple Atk."+3','Accuracy+5','Attack+8',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
	}
	
	sets.precast.WS['Armor Break'] = {
		ammo="Yamarang",
		head="Aya. Zucchetto +2",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Aya. Cosciales +2",
		feet="Volte Boots",
		neck="Sanctity Necklace",
		waist="Luminary Sash",
		left_ear="Gwati Earring",
		right_ear="Digni. Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}

	--------------------------------------
	-- Midcast sets
	--------------------------------------
	
    sets.midcast.FastRecast = {}
			
	sets.midcast.FastRecast.DT = {}
		
	sets.midcast.FastRecast.SIRD = {}

    sets.midcast['Enhancing Magic'] = {
		ammo="Staunch Tathlum",
		head="Erilaz Galea +1",
		body="Runeist's Coat +3",
		hands="Turms Mittens +1",
		legs={ name="Futhark Trousers +1", augments={'Enhances "Inspire" effect',}},
		feet="Turms Leggings +1",
		neck={ name="Futhark Torque +2", augments={'Path: A',}},
		waist="Audumbla Sash",
		left_ear="Odnowa Earring +1",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Moonbeam Ring",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','VIT+10','Enmity+10','Phys. dmg. taken-10%',}},
	}
	
	sets.midcast['Temper'] = {
		ammo="Staunch Tathlum",
		head="Erilaz Galea +1",
		body="Runeist's Coat +3",
		hands="Turms Mittens +1",
		legs={ name="Futhark Trousers +1", augments={'Enhances "Inspire" effect',}},
		feet="Turms Leggings +1",
		neck={ name="Futhark Torque +2", augments={'Path: A',}},
		waist="Audumbla Sash",
		left_ear="Odnowa Earring +1",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Moonbeam Ring",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','VIT+10','Enmity+10','Phys. dmg. taken-10%',}},
	}
    sets.midcast['Phalanx'] = {
		ammo="Staunch Tathlum",
		head={ name="Taeon Chapeau", augments={'Spell interruption rate down -9%','Phalanx +3',}},
		body={ name="Taeon Tabard", augments={'Spell interruption rate down -8%','Phalanx +3',}},
		hands={ name="Taeon Gloves", augments={'Spell interruption rate down -10%','Phalanx +3',}},
		legs={ name="Taeon Tights", augments={'Spell interruption rate down -10%','Phalanx +3',}},
		feet={ name="Taeon Boots", augments={'Spell interruption rate down -9%','Phalanx +3',}},
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear="Genmei Earring",
		left_ring="Vocane Ring",
		right_ring="Defending Ring",
		back="Ogma's Cape",
	}
    sets.midcast['Regen'] = {
		ammo="Staunch Tathlum",
		head="Erilaz Galea +1",
		body="Runeist's Coat +3",
		hands="Turms Mittens +1",
		legs={ name="Futhark Trousers +1", augments={'Enhances "Inspire" effect',}},
		feet="Turms Leggings +1",
		neck="Loricate Torque +1",
		waist="Audumbla Sash",
		left_ear="Odnowa Earring +1",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Moonbeam Ring",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','VIT+10','Enmity+10','Phys. dmg. taken-10%',}},
	}
	
	sets.midcast['Refresh'] = set_combine(sets.midcast['Enhancing Magic'],{head="Erilaz Galea +1"}) 
    sets.midcast.Stoneskin =  {
		ammo="Staunch Tathlum",
		head="Erilaz Galea +1",
		body="Runeist's Coat +3",
		hands="Turms Mittens +1",
		legs={ name="Futhark Trousers +1", augments={'Enhances "Inspire" effect',}},
		feet="Turms Leggings +1",
		neck="Loricate Torque +1",
		waist="Audumbla Sash",
		left_ear="Odnowa Earring +1",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Moonbeam Ring",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','VIT+10','Enmity+10','Phys. dmg. taken-10%',}},
	}
	sets.midcast.Flash = set_combine(sets.Enmity, {})
	sets.midcast.Flash.DT = set_combine(sets.Enmity.DT, {})
	sets.midcast.Foil = set_combine(sets.Enmity, {})
	sets.midcast.Foil.DT = set_combine(sets.Enmity.DT, {})
    sets.midcast.Stun = set_combine(sets.Enmity, {})
	sets.midcast.Stun.DT = set_combine(sets.Enmity.DT, {})
	sets.midcast.Jettatura = set_combine(sets.Enmity, {})
	sets.midcast.Jettatura.DT = set_combine(sets.Enmity.DT, {})
	sets.midcast['Blue Magic'] = {
		ammo="Staunch Tathlum",
		head="Agwu's Cap",
		body="Emet Harness +1",
		hands={ name="Rawhide Gloves", augments={'Mag. Acc.+15','INT+7','MND+7',}},
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Taeon Boots", augments={'Spell interruption rate down -9%','Phalanx +3',}},
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Sulla Belt",
		left_ear="Halasz Earring",
		right_ear="Cryptic Earring",
		left_ring="Begrudging Ring",
		right_ring="Evanescence Ring",
		back="Ogma's Cape",
	}
	sets.midcast['Blue Magic'].DT = {
		ammo="Staunch Tathlum",
		head="Agwu's Cap",
		body="Emet Harness +1",
		hands={ name="Rawhide Gloves", augments={'Mag. Acc.+15','INT+7','MND+7',}},
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Taeon Boots", augments={'Spell interruption rate down -9%','Phalanx +3',}},
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Sulla Belt",
		left_ear="Halasz Earring",
		right_ear="Cryptic Earring",
		left_ring="Begrudging Ring",
		right_ring="Evanescence Ring",
		back="Ogma's Cape",
	}
	sets.midcast['Blue Magic'].SIRD = {
		ammo="Staunch Tathlum",
		head="Agwu's Cap",
		body="Emet Harness +1",
		hands={ name="Rawhide Gloves", augments={'Mag. Acc.+15','INT+7','MND+7',}},
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Taeon Boots", augments={'Spell interruption rate down -9%','Phalanx +3',}},
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Sulla Belt",
		left_ear="Halasz Earring",
		right_ear="Cryptic Earring",
		left_ring="Begrudging Ring",
		right_ring="Evanescence Ring",
		back="Ogma's Cape",
	}

    sets.midcast.Cure = {neck="Colossus's Torque", hands="Buremte Gloves", ring1="Ephedra Ring", feet="Futhark Boots +1"}
		
	sets.midcast['Wild Carrot'] = set_combine(sets.midcast.Cure, {})
		
	sets.Self_Healing = {hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {head="Erilaz Galea +1"}
	sets.Phalanx_Received = {main="Deacon Sword",hands=gear.herculean_phalanx_hands,feet=gear.herculean_nuke_feet}
	
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	sets.resting = {}

    sets.idle = {
	   ammo="Staunch Tathlum",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Etiolation Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Vocane Ring",
		right_ring="Defending Ring",
		back="Ogma's Cape",
	}
		
    sets.idle.Sphere = set_combine(sets.idle,{body="Mekosu. Harness"})
			
	sets.idle.Tank = {main="Aettir",sub="Utu Grip",ammo="Staunch Tathlum +1",
        head="Fu. Bandeau +1",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Ethereal Earring",
        body="Runeist's Coat +3",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Moonlight Ring",
        back="Shadow Mantle",waist="Flume Belt +1",legs="Eri. Leg Guards +1",feet="Erilaz Greaves +1"}

	sets.idle.KiteTank = {main="Aettir",sub="Utu Grip",ammo="Staunch Tathlum +1",
        head="Fu. Bandeau +1",neck="Vim Torque +1",ear1="Genmei Earring",ear2="Ethereal Earring",
        body="Futhark Coat +1",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Moonlight Ring",
        back="Moonlight Cape",waist="Flume Belt +1",legs="Carmine Cuisses +1",feet="Hippo. Socks +1"}

	sets.idle.Weak = {main="Aettir",sub="Utu Grip",ammo="Homiliary",
		head="Rawhide Mask",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Ethereal Earring",
		body="Runeist's Coat +3",hands=gear.herculean_refresh_hands,ring1="Defending Ring",ring2="Dark Ring",
		back="Moonlight Cape",waist="Flume Belt +1",legs="Rawhide Trousers",feet=gear.herculean_refresh_feet}

	sets.Kiting = {legs="Carmine Cuisses +1"}
	
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.DayIdle = {}
	sets.NightIdle = {}

    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.Knockback = {}
    sets.MP = {ear2="Ethereal Earring",body="Erilaz Surcoat +1",waist="Flume Belt +1"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons.Aettir = {main="Aettir",sub="Utu Grip"}
	sets.weapons.Lionheart = {main="Lionheart",sub="Utu Grip"}
	sets.weapons.DualWeapons = {main="Firangi",sub="Reikiko"}
	
	-- Defense Sets
	
	sets.defense.PDT = {
		ammo="Staunch Tathlum",
		head={ name="Fu. Bandeau +2", augments={'Enhances "Battuta" effect',}},
		body="Runeist's Coat +3",
		hands="Turms Mittens +1",
		legs="Eri. Leg Guards +1",
		feet="Turms Leggings +1",
		neck={ name="Futhark Torque +2", augments={'Path: A',}},
		waist="Flume Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Moonbeam Ring",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
	}
	sets.defense.PDT_HP = {
		ammo="Staunch Tathlum",
		head={ name="Fu. Bandeau +2", augments={'Enhances "Battuta" effect',}},
		body="Runeist's Coat +3",
		hands="Turms Mittens +1",
		legs="Eri. Leg Guards +1",
		feet="Turms Leggings +1",
		neck={ name="Futhark Torque +2", augments={'Path: A',}},
		waist="Flume Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Moonbeam Ring",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
	}
	sets.defense.MDT = {main="Aettir",sub="Utu Grip",ammo="Yamarang",
        head="Erilaz Galea +1",neck="Warder's Charm +1",ear1="Odnowa Earring +1",ear2="Sanare Earring",
        body="Runeist's Coat +3",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Shadow Ring",
        back="Moonlight Cape",waist="Engraved Belt",legs=gear.herculean_dt_legs,feet="Erilaz Greaves +1"}
	sets.defense.MDT_HP = {main="Aettir",sub="Utu Grip",ammo="Staunch Tathlum +1",
        head="Erilaz Galea +1",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Tuisto Earring",
        body="Runeist's Coat +3",hands=gear.herculean_dt_hands,ring1="Gelatinous Ring +1",ring2="Moonlight Ring",
        back="Moonlight Cape",waist="Engraved Belt",legs="Eri. Leg Guards +1",feet="Erilaz Greaves +1"}
	
	sets.defense.BDT = {
		ammo="Staunch Tathlum",
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Turms Mittens +1",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
		neck={ name="Futhark Torque +2", augments={'Path: A',}},
		waist="Kentarch Belt +1",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Defending Ring",
		right_ring="Moonbeam Ring",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
	}
	sets.defense.BDT_HP = {main="Aettir",sub="Utu Grip",ammo="Staunch Tathlum +1",
        head="Erilaz Galea +1",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Tuisto Earring",
        body="Runeist's Coat +3",hands=gear.herculean_dt_hands,ring1="Gelatinous Ring +1",ring2="Moonlight Ring",
        back="Moonlight Cape",waist="Engraved Belt",legs="Eri. Leg Guards +1",feet="Erilaz Greaves +1"}
	
	sets.defense.MEVA = {
		ammo="Staunch Tathlum",
		head={ name="Fu. Bandeau +2", augments={'Enhances "Battuta" effect',}},
		body="Runeist's Coat +3",
		hands="Turms Mittens +1",
		legs="Eri. Leg Guards +1",
		feet="Turms Leggings +1",
		neck={ name="Futhark Torque +2", augments={'Path: A',}},
		waist="Flume Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Moonbeam Ring",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
	}
	sets.defense.MEVA_HP = {
		ammo="Staunch Tathlum",
		head={ name="Fu. Bandeau +2", augments={'Enhances "Battuta" effect',}},
		body="Runeist's Coat +3",
		hands="Turms Mittens +1",
		legs="Eri. Leg Guards +1",
		feet="Turms Leggings +1",
		neck={ name="Futhark Torque +2", augments={'Path: A',}},
		waist="Flume Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Moonbeam Ring",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
	}
		
	sets.defense.Death = {main="Aettir",sub="Utu Grip",ammo="Staunch Tathlum +1",
        head="Erilaz Galea +1",neck="Warder's Charm +1",ear1="Odnowa Earring +1",ear2="Sanare Earring",
        body="Runeist's Coat +3",hands="Erilaz Gauntlets +1",ring1="Purity Ring",ring2="Vengeful Ring",
        back=gear.enmity_jse_back,waist="Engraved Belt",legs="Rune. Trousers +3",feet="Erilaz Greaves +1"}

	sets.defense.DTCharm = {main="Aettir",sub="Utu Grip",ammo="Staunch Tathlum +1",
        head="Erilaz Galea +1",neck="Unmoving Collar +1",ear1="Odnowa Earring +1",ear2="Sanare Earring",
        body="Runeist's Coat +3",hands="Erilaz Gauntlets +1",ring1="Defending Ring",ring2="Dark Ring",
        back=gear.enmity_jse_back,waist="Engraved Belt",legs="Rune. Trousers +3",feet="Erilaz Greaves +1"}
		
	sets.defense.Charm = {main="Aettir",sub="Utu Grip",ammo="Staunch Tathlum +1",
        head="Erilaz Galea +1",neck="Unmoving Collar +1",ear1="Odnowa Earring +1",ear2="Sanare Earring",
        body="Runeist's Coat +3",hands="Erilaz Gauntlets +1",ring1="Purity Ring",ring2="Vengeful Ring",
        back=gear.enmity_jse_back,waist="Engraved Belt",legs="Rune. Trousers +3",feet="Erilaz Greaves +1"}
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Brutal Earring"}
	sets.AccMaxTP = {ear1="Telos Earring"}

	--------------------------------------
	-- Engaged sets
	--------------------------------------

    sets.engaged = {
		ammo="Staunch Tathlum",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Etiolation Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Vocane Ring",
		right_ring="Defending Ring",
		back="Ogma's Cape",
	}
    sets.engaged.SomeAcc = {main="Lionheart",sub="Utu Grip",ammo="Yamarang",
            head="Dampening Tam",neck="Combatant's Torque",ear1="Brutal Earring",ear2="Sherida Earring",
            body="Ayanmo Corazza +2",hands="Adhemar Wrist. +1",ring1="Niqmaddu Ring",ring2="Epona's Ring",
            back=gear.stp_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_ta_feet}
	sets.engaged.Acc = {main="Lionheart",sub="Utu Grip",ammo="Yamarang",
            head="Dampening Tam",neck="Combatant's Torque",ear1="Cessance Earring",ear2="Sherida Earring",
            body="Ayanmo Corazza +2",hands="Adhemar Wrist. +1",ring1="Niqmaddu Ring",ring2="Epona's Ring",
            back=gear.stp_jse_back,waist="Windbuffet Belt +1",legs="Meg. Chausses +2",feet=gear.herculean_ta_feet}
	sets.engaged.HighAcc = {main="Lionheart",sub="Utu Grip",ammo="C. Palug Stone",
            head="Aya. Zucchetto +2",neck="Combatant's Torque",ear1="Telos Earring",ear2="Sherida Earring",
            body="Ayanmo Corazza +2",hands="Meg. Gloves +2",ring1="Niqmaddu Ring",ring2="Ilabrat Ring",
            back=gear.stp_jse_back,waist="Grunfeld Rope",legs="Meg. Chausses +2",feet=gear.herculean_acc_feet}
	sets.engaged.FullAcc = {main="Lionheart",sub="Utu Grip",ammo="C. Palug Stone",
            head="Carmine Mask +1",neck="Combatant's Torque",ear1="Telos Earring",ear2="Mache Earring +1",
            body="Ayanmo Corazza +2",hands="Meg. Gloves +2",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
            back=gear.stp_jse_back,waist="Olseni Belt",legs="Carmine Cuisses +1",feet=gear.herculean_acc_feet}
    sets.engaged.DTLite = {main="Lionheart",sub="Utu Grip",ammo="Yamarang",
            head="Aya. Zucchetto +2",neck="Loricate Torque +1",ear1="Brutal Earring",ear2="Sherida Earring",
            body="Ayanmo Corazza +2",hands="Meg. Gloves +2",ring1="Defending Ring",ring2="Patricius Ring",
            back="Moonlight Cape",waist="Windbuffet Belt +1",legs="Meg. Chausses +2",feet="Ahosi Leggings"}
    sets.engaged.SomeAcc.DTLite = {main="Lionheart",sub="Utu Grip",ammo="C. Palug Stone",
            head="Aya. Zucchetto +2",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Sherida Earring",
            body="Ayanmo Corazza +2",hands="Meg. Gloves +2",ring1="Defending Ring",ring2="Patricius Ring",
            back="Moonlight Cape",waist="Windbuffet Belt +1",legs="Meg. Chausses +2",feet="Ahosi Leggings"}
	sets.engaged.Acc.DTLite = {main="Lionheart",sub="Utu Grip",ammo="C. Palug Stone",ammo="C. Palug Stone",
            head="Aya. Zucchetto +2",neck="Loricate Torque +1",ear1="Telos Earring",ear2="Sherida Earring",
            body="Ayanmo Corazza +2",hands="Meg. Gloves +2",ring1="Defending Ring",ring2="Patricius Ring",
            back="Moonlight Cape",waist="Grunfeld Rope",legs="Meg. Chausses +2",feet="Ahosi Leggings"}
	sets.engaged.HighAcc.DTLite = {main="Lionheart",sub="Utu Grip",ammo="C. Palug Stone",
            head="Aya. Zucchetto +2",neck="Loricate Torque +1",ear1="Telos Earring",ear2="Sherida Earring",
            body="Ayanmo Corazza +2",hands="Meg. Gloves +2",ring1="Defending Ring",ring2="Patricius Ring",
            back="Moonlight Cape",waist="Olseni Belt",legs="Meg. Chausses +2",feet="Ahosi Leggings"}
	sets.engaged.FullAcc.DTLite = {main="Lionheart",sub="Utu Grip",ammo="C. Palug Stone",
            head="Aya. Zucchetto +2",neck="Loricate Torque +1",ear1="Telos Earring",ear2="Mache Earring +1",
            body="Ayanmo Corazza +2",hands="Meg. Gloves +2",ring1="Defending Ring",ring2="Patricius Ring",
            back="Moonlight Cape",waist="Olseni Belt",legs="Meg. Chausses +2",feet="Ahosi Leggings"}
    sets.engaged.Tank = {main="Aettir",sub="Utu Grip",ammo="Staunch Tathlum +1",
            head="Meghanada Visor +2",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Ethereal Earring",
            body="Futhark Coat +1",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Shadow Ring",
            back="Shadow Mantle",waist="Engraved Belt",legs=gear.herculean_dt_legs,feet="Erilaz Greaves +1"}
	sets.engaged.Tank_HP = {main="Aettir",sub="Utu Grip",ammo="Staunch Tathlum +1",
        head="Fu. Bandeau +1",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Tuisto Earring",
        body="Runeist's Coat +3",hands=gear.herculean_dt_hands,ring1="Gelatinous Ring +1",ring2="Moonlight Ring",
        back="Moonlight Cape",waist="Flume Belt +1",legs="Eri. Leg Guards +1",feet="Erilaz Greaves +1"}
    sets.engaged.SomeAcc.Tank = sets.engaged.Tank
	sets.engaged.Acc.Tank = sets.engaged.Tank
	sets.engaged.HighAcc.Tank = sets.engaged.Tank
	sets.engaged.FullAcc.Tank = sets.engaged.Tank
	
	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	sets.buff.Battuta = {hands="Turms Mittens +1"}
	sets.buff.Embolden = {back="Evasionist's Cape"}
	
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(1, 19)
	elseif player.sub_job == 'RDM' then
		set_macro_page(5, 19)
	elseif player.sub_job == 'SCH' then
		set_macro_page(5, 19)
	elseif player.sub_job == 'BLU' then
		set_macro_page(1, 19)
	elseif player.sub_job == 'WAR' then
		set_macro_page(7, 19)
	elseif player.sub_job == 'SAM' then
		set_macro_page(8, 19)
	elseif player.sub_job == 'DRK' then
		set_macro_page(9, 19)
	elseif player.sub_job == 'NIN' then
		set_macro_page(10, 19)
	else
		set_macro_page(5, 19)
	end
end

--Job Specific Trust Overwrite
function check_trust()
	if not moving then
		if state.AutoTrustMode.value and not data.areas.cities:contains(world.area) and (buffactive['Elvorseal'] or buffactive['Reive Mark'] or not player.in_combat) then
			local party = windower.ffxi.get_party()
			if party.p5 == nil then
				local spell_recasts = windower.ffxi.get_spell_recasts()
			
				if spell_recasts[980] < spell_latency and not have_trust("Yoran-Oran") then
					windower.send_command('input /ma "Yoran-Oran (UC)" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[952] < spell_latency and not have_trust("Koru-Moru") then
					windower.send_command('input /ma "Koru-Moru" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[979] < spell_latency and not have_trust("Selh'teus") then
					windower.send_command('input /ma "Selh\'teus" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[967] < spell_latency and not have_trust("Qultada") then
					windower.send_command('input /ma "Qultada" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[914] < spell_latency and not have_trust("Ulmia") then
					windower.send_command('input /ma "Ulmia" <me>')
					tickdelay = os.clock() + 3
					return true
				else
					return false
				end
			end
		end
	end
	return false
end

function user_job_lockstyle()
	if state.Weapons.value == 'Lionheart' then
		windower.chat.input('/lockstyleset 034')
	else
		windower.chat.input('/lockstyleset 033')
	end
end