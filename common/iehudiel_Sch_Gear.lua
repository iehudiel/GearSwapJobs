-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal')
    state.CastingMode:options('Normal','Resistant','Proc','OccultAcumen','9k')
    state.IdleMode:options('Normal','PDT')
	state.HybridMode:options('Normal','PDT')
	state.Weapons:options('None','Akademos','Khatvanga')

	gear.nuke_jse_back = {name="Lugh's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10'}}
	
	gear.obi_cure_back = "Tempered Cape +1"
	gear.obi_cure_waist = "Witful Belt"

	gear.obi_low_nuke_waist = "Refoccilation Stone"
	gear.obi_high_nuke_waist = "Refoccilation Stone"
	
		-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` gs c scholar power')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^q gs c weapons Khatvanga;gs c set CastingMode OccultAcumen')
	send_command('bind !q gs c weapons default;gs c reset CastingMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation and Myrkr.
	send_command('bind @^` input /ja "Parsimony" <me>')
	send_command('bind ^backspace input /ma "Stun" <t>')
	send_command('bind !backspace gs c scholar speed')
	send_command('bind @backspace gs c scholar aoe')
	send_command('bind ^= input /ja "Dark Arts" <me>')
	send_command('bind != input /ja "Light Arts" <me>')
	send_command('bind ^\\\\ input /ma "Protect V" <t>')
	send_command('bind @\\\\ input /ma "Shell V" <t>')
	send_command('bind !\\\\ input /ma "Reraise III" <me>')
	
    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Precast sets to enhance JAs

    sets.precast.JA['Tabula Rasa'] = {legs="Peda. Pants +1"}
	sets.precast.JA['Enlightenment'] = {} --body="Peda. Gown +1"

    -- Fast cast sets for spells

    sets.precast.FC = {
		main="Mpaca's Staff",
		sub="Enki Strap",
		ammo="Staunch Tathlum",
		head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+29','STR+2','Mag. Acc.+7 "Mag.Atk.Bns."+7',}},
		body="Agwu's Robe",
		hands="Agwu's Gages",
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
		feet="Regal Pumps +1",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Witful Belt",
		left_ear="Etiolation Earring",
		right_ear="Malignance Earring",
		left_ring="Kishar Ring",
		right_ring="Rahab Ring",
		back="Lugh's Cape",
	}
		
	sets.precast.FC.Arts = {}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {main="Serenity"})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], {})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak"})

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS['Myrkr'] = {ammo="Staunch Tathlum +1",
		head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Evans Earring",ear2="Etiolation Earring",
		body="Amalric Doublet",hands="Regal Cuffs",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
		back="Aurist's Cape +1",waist="Yamabuki-no-Obi",legs="Psycloth Lappas",feet="Medium's Sabots"}

    -- Midcast Sets

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {feet=gear.chironic_treasure_feet})
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {}
	
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {
		main="Bunzi's Rod",
		sub="Culminus",
		ammo="Pemphredo Tathlum",
		head="Agwu's Cap",
		body="Agwu's Robe",
		hands="Agwu's Gages",
		legs="Agwu's Slops",
		feet="Agwu's Pigaches",
		neck="Deviant Necklace",
		waist="Carrier's Sash",
		left_ear="Regal Earring",
		right_ear={ name="Arbatel Earring", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+6',}},
		left_ring="Mujin Band",
		right_ring="Jhakri Ring",
		back="Lugh's Cape",
	}
	
	-- Gear for specific elemental nukes.
	sets.element.Dark = {head="Pixie Hairpin +1",ring2="Archon Ring"}

    sets.midcast.FastRecast = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Hasty Pinion +1",
		head="Amalric Coif +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Malignance Earring",
		body="Zendik Robe",hands="Gende. Gages +1",ring1="Kishar Ring",ring2="Prolix Ring",
		back="Swith Cape +1",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}
		
    sets.midcast.Cure = {
		main="Chatoyant Staff",
		sub="Enki Strap",
		ammo="Pemphredo Tathlum",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body="Chironic Doublet",
		hands={ name="Kaykaus Cuffs", augments={'MP+60','Spell interruption rate down +10%','"Cure" spellcasting time -5%',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+20','Pet: Mag. Acc.+22','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Nodens Gorget",
		waist="Witful Belt",
		left_ear="Etiolation Earring",
		right_ear="Mendi. Earring",
		left_ring="Naji's Loop",
		right_ring="Lebeche Ring",
		back="Solemnity Cape",
	}
		
    sets.midcast.LightWeatherCure = {
		main="Chatoyant Staff",
		sub="Enki Strap",
		ammo="Pemphredo Tathlum",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body="Chironic Doublet",
		hands={ name="Kaykaus Cuffs", augments={'MP+60','Spell interruption rate down +10%','"Cure" spellcasting time -5%',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+20','Pet: Mag. Acc.+22','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Nodens Gorget",
		waist="Witful Belt",
		left_ear="Etiolation Earring",
		right_ear="Mendi. Earring",
		left_ring="Naji's Loop",
		right_ring="Lebeche Ring",
		back="Solemnity Cape",
	}
		
    sets.midcast.LightDayCure = {
		main="Chatoyant Staff",
		sub="Enki Strap",
		ammo="Pemphredo Tathlum",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body="Chironic Doublet",
		hands={ name="Kaykaus Cuffs", augments={'MP+60','Spell interruption rate down +10%','"Cure" spellcasting time -5%',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+20','Pet: Mag. Acc.+22','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Nodens Gorget",
		waist="Witful Belt",
		left_ear="Etiolation Earring",
		right_ear="Mendi. Earring",
		left_ring="Naji's Loop",
		right_ring="Lebeche Ring",
		back="Solemnity Cape",
	}

    sets.midcast.Curaga = sets.midcast.Cure

	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}
	
	sets.midcast.Cursna = {
		main={ name="Gada", augments={'"Fast Cast"+4','Mag. Acc.+22','"Mag.Atk.Bns."+19','DMG:+5',}},
		sub="Sors Shield",
		ammo="Pemphredo Tathlum",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body={ name="Telchine Chas.", augments={'Mag. Acc.+11 "Mag.Atk.Bns."+11','"Cure" spellcasting time -5%','Enh. Mag. eff. dur. +9',}},
		hands={ name="Kaykaus Cuffs", augments={'MP+60','Spell interruption rate down +10%','"Cure" spellcasting time -5%',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+20','Pet: Mag. Acc.+22','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Malison Medallion",
		waist="Witful Belt",
		left_ear="Etiolation Earring",
		right_ear="Mendi. Earring",
		left_ring="Ephedra Ring",
		right_ring="Ephedra Ring",
		back="Solemnity Cape",
	}
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main=gear.grioavolr_fc_staff})

	sets.midcast['Enhancing Magic'] = {
		main="Bolelabunga",
		sub="Sors Shield",
		ammo="Pemphredo Tathlum",
		head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +9',}},
		body={ name="Telchine Chas.", augments={'Mag. Acc.+11 "Mag.Atk.Bns."+11','"Cure" spellcasting time -5%','Enh. Mag. eff. dur. +9',}},
		hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +9',}},
		legs={ name="Telchine Braconi", augments={'Mag. Acc.+22','"Cure" spellcasting time -3%','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}},
		neck="Enhancing Torque",
		waist="Cascade Belt",
		left_ear="Halasz Earring",
		right_ear="Mendi. Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Lugh's Cape",
	}

    sets.midcast.Regen = {
		main="Bolelabunga",
		sub="Sors Shield",
		ammo="Pemphredo Tathlum",
		head="Arbatel Bonnet +2",
		body={ name="Telchine Chas.", augments={'Mag. Acc.+11 "Mag.Atk.Bns."+11','"Cure" spellcasting time -5%','Enh. Mag. eff. dur. +9',}},
		hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +9',}},
		legs={ name="Telchine Braconi", augments={'Mag. Acc.+22','"Cure" spellcasting time -3%','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}},
		neck="Enhancing Torque",
		waist="Cascade Belt",
		left_ear="Halasz Earring",
		right_ear="Mendi. Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Lugh's Cape",
	}

    sets.midcast.Stoneskin = {
		main="Bolelabunga",
		sub="Sors Shield",
		ammo="Pemphredo Tathlum",
		head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +9',}},
		body={ name="Telchine Chas.", augments={'Mag. Acc.+11 "Mag.Atk.Bns."+11','"Cure" spellcasting time -5%','Enh. Mag. eff. dur. +9',}},
		hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +9',}},
		legs={ name="Telchine Braconi", augments={'Mag. Acc.+22','"Cure" spellcasting time -3%','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}},
		neck="Nodens Gorget",
		waist="Cascade Belt",
		left_ear="Halasz Earring",
		right_ear="Mendi. Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Lugh's Cape",
	}
	
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {})
	
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {})

    sets.midcast.Storm = set_combine(sets.midcast['Enhancing Magic'], {})

    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Protectra = sets.midcast.Protect

    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Shellra = sets.midcast.Shell


    -- Custom spell classes

	sets.midcast['Enfeebling Magic'] = {
		main="Daybreak",
		sub="Culminus",
		ammo="Pemphredo Tathlum",
		head="Befouled Crown",
		body="Jhakri Robe +2",
		hands={ name="Kaykaus Cuffs", augments={'MP+60','Spell interruption rate down +10%','"Cure" spellcasting time -5%',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+20','Pet: Mag. Acc.+22','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		feet="Jhakri Pigaches +2",
		neck="Imbodla Necklace",
		waist="Rumination Sash",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Lugh's Cape",
	}
	
	sets.midcast['Enfeebling Magic'].Resistant = {
		main="Daybreak",
		sub="Culminus",
		ammo="Pemphredo Tathlum",
		head="Befouled Crown",
		body="Jhakri Robe +2",
		hands={ name="Kaykaus Cuffs", augments={'MP+60','Spell interruption rate down +10%','"Cure" spellcasting time -5%',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+20','Pet: Mag. Acc.+22','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		feet="Jhakri Pigaches +2",
		neck="Imbodla Necklace",
		waist="Rumination Sash",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Lugh's Cape",
	}
		
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {head="Amalric Coif +1",ear2="Malignance Earring",back=gear.nuke_jse_back,waist="Acuity Belt +1"})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Amalric Coif +1",back=gear.nuke_jse_back,waist="Acuity Belt +1"})
	
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {head="Amalric Coif +1",ear1="Malignance Earring",back=gear.nuke_jse_back,waist="Acuity Belt +1"})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Amalric Coif +1",back=gear.nuke_jse_back,waist="Acuity Belt +1"})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {ring2="Stikini Ring +1",feet=gear.chironic_nuke_feet})

    sets.midcast['Dark Magic'] = {main="Rubicundity",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Amalric Coif +1",neck="Incanter's Torque",ear1="Regal Earring",ear2="Malignance Earring",
        body="Chironic Doublet",hands="Acad. Bracers +3",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Chironic Hose",feet=gear.merlinic_aspir_feet}

    sets.midcast.Kaustra = {main="Akademos",sub="Enki Strap",ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Saevus Pendant +1",ear1="Crematio Earring",ear2="Malignance Earring",
        body=gear.merlinic_nuke_body,hands="Amalric Gages +1",ring1="Freke Ring",ring2="Archon Ring",
        back=gear.nuke_jse_back,waist="Refoccilation Stone",legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}
		
    sets.midcast.Kaustra.Resistant = {main=gear.grioavolr_nuke_staff,sub="Enki Strap",ammo="Pemphredo Tathlum",
        head=gear.merlinic_nuke_head,neck="Erra Pendant",ear1="Crematio Earring",ear2="Malignance Earring",
        body=gear.merlinic_nuke_body,hands="Amalric Gages +1",ring1="Shiva Ring +1",ring2="Freke Ring",
        back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}

    sets.midcast.Drain = {main="Rubicundity",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Erra Pendant",ear1="Regal Earring",ear2="Malignance Earring",
        body="Chironic Doublet",hands="Acad. Bracers +3",ring1="Evanescence Ring",ring2="Archon Ring",
        back=gear.nuke_jse_back,waist="Fucho-no-obi",legs="Chironic Hose",feet=gear.merlinic_aspir_feet}
		
    sets.midcast.Drain.Resistant = {main="Rubicundity",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Amalric Coif +1",neck="Erra Pendant",ear1="Regal Earring",ear2="Malignance Earring",
        body="Chironic Doublet",hands="Acad. Bracers +3",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Chironic Hose",feet=gear.merlinic_aspir_feet}

    sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant

    sets.midcast.Stun = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Hasty Pinion +1",
        head="Amalric Coif +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Malignance Earring",
        body="Zendik Robe",hands="Acad. Bracers +3",ring1="Metamor. Ring +1",ring2="Stikini Ring +1",
        back=gear.nuke_jse_back,waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}

    sets.midcast.Stun.Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Acad. Mortar. +3",neck="Erra Pendant",ear1="Regal Earring",ear2="Malignance Earring",
        body="Zendik Robe",hands="Acad. Bracers +3",ring1="Metamor. Ring +1",ring2="Stikini Ring +1",
        back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Chironic Hose",feet=gear.merlinic_aspir_feet}

    -- Elemental Magic sets are default for handling low-tier nukes.
		sets.midcast['Elemental Magic'] = {
		main="Bunzi's Rod",
		sub="Culminus",
		ammo="Pemphredo Tathlum",
		head="Agwu's Cap",
		body="Agwu's Robe",
		hands="Agwu's Gages",
		legs="Agwu's Slops",
		feet="Arbatel Loafers +3",
		neck="Deviant Necklace",
		waist="Carrier's Sash",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Mujin Band",
		right_ring="Jhakri Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}},
	}

    sets.midcast['Elemental Magic'].Resistant = {
		main="Bunzi's Rod",
		sub="Culminus",
		ammo="Pemphredo Tathlum",
		head="Agwu's Cap",
		body="Agwu's Robe",
		hands="Agwu's Gages",
		legs="Agwu's Slops",
		feet="Arbatel Loafers +3",
		neck="Deviant Necklace",
		waist="Carrier's Sash",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Mujin Band",
		right_ring="Jhakri Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}},
	}
		
    sets.midcast['Elemental Magic'].Fodder = {
		main="Bunzi's Rod",
		sub="Culminus",
		ammo="Pemphredo Tathlum",
		head="Agwu's Cap",
		body="Agwu's Robe",
		hands="Agwu's Gages",
		legs="Agwu's Slops",
		feet="Arbatel Loafers +3",
		neck="Deviant Necklace",
		waist="Carrier's Sash",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Mujin Band",
		right_ring="Jhakri Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}},
	}
		
    sets.midcast['Elemental Magic']['9k'] = {
		main="Bunzi's Rod",
		sub="Culminus",
		ammo="Pemphredo Tathlum",
		head="Agwu's Cap",
		body="Agwu's Robe",
		hands="Agwu's Gages",
		legs="Agwu's Slops",
		feet="Arbatel Loafers +3",
		neck="Deviant Necklace",
		waist="Carrier's Sash",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Mujin Band",
		right_ring="Jhakri Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}},
	}
		
    sets.midcast['Elemental Magic'].Proc = {
		main="Bunzi's Rod",
		sub="Culminus",
		ammo="Pemphredo Tathlum",
		head="Agwu's Cap",
		body="Agwu's Robe",
		hands="Agwu's Gages",
		legs="Agwu's Slops",
		feet="Arbatel Loafers +3",
		neck="Deviant Necklace",
		waist="Carrier's Sash",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Mujin Band",
		right_ring="Jhakri Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}},
	}
		
    sets.midcast['Elemental Magic'].OccultAcumen = {
		main="Bunzi's Rod",
		sub="Culminus",
		ammo="Pemphredo Tathlum",
		head="Agwu's Cap",
		body="Agwu's Robe",
		hands="Agwu's Gages",
		legs="Agwu's Slops",
		feet="Arbatel Loafers +3",
		neck="Deviant Necklace",
		waist="Carrier's Sash",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Mujin Band",
		right_ring="Jhakri Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}},
	}
		
    -- Custom refinements for certain nuke tiers
	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {})
	sets.midcast['Elemental Magic'].HighTierNuke.Fodder = set_combine(sets.midcast['Elemental Magic'].Fodder, {})

	sets.midcast.Helix = {
		main="Bunzi's Rod",
		sub="Culminus",
		ammo="Pemphredo Tathlum",
		head="Agwu's Cap",
		body="Agwu's Robe",
		hands="Agwu's Gages",
		legs="Agwu's Slops",
		feet="Agwu's Pigaches",
		neck="Deviant Necklace",
		waist="Carrier's Sash",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Mujin Band",
		right_ring="Jhakri Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}},
	}
	
	sets.midcast.Helix.Resistant = {
		main="Bunzi's Rod",
		sub="Culminus",
		ammo="Pemphredo Tathlum",
		head="Agwu's Cap",
		body="Agwu's Robe",
		hands="Agwu's Gages",
		legs="Agwu's Slops",
		feet="Agwu's Pigaches",
		neck="Deviant Necklace",
		waist="Carrier's Sash",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Mujin Band",
		right_ring="Jhakri Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}},
	}
		
	sets.midcast.Helix.Proc = {
		main="Bunzi's Rod",
		sub="Culminus",
		ammo="Pemphredo Tathlum",
		head="Agwu's Cap",
		body="Agwu's Robe",
		hands="Agwu's Gages",
		legs="Agwu's Slops",
		feet="Agwu's Pigaches",
		neck="Deviant Necklace",
		waist="Carrier's Sash",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Mujin Band",
		right_ring="Jhakri Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}},
	}

	sets.midcast.Impact = {
		main="Bunzi's Rod",
		sub="Culminus",
		ammo="Pemphredo Tathlum",
		head="Agwu's Cap",
		body="Agwu's Robe",
		hands="Agwu's Gages",
		legs="Agwu's Slops",
		feet="Agwu's Pigaches",
		neck="Deviant Necklace",
		waist="Carrier's Sash",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Mujin Band",
		right_ring="Jhakri Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}},
	}
		
    sets.midcast.Impact.OccultAcumen = set_combine(sets.midcast['Elemental Magic'].OccultAcumen, {})
		
    -- Sets to return to when not performing an action.

     -- Resting sets
    sets.resting = {main="Chatoyant Staff",sub="Oneiros Grip",ammo="Homiliary",
		head="Befouled Crown",neck="Chrys. Torque",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Amalric Doublet",hands=gear.merlinic_refresh_hands,ring1="Defending Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Fucho-no-obi",legs="Assid. Pants +1",feet=gear.chironic_refresh_feet}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {
		main="Mpaca's Staff",
		sub="Enki Strap",
		ammo="Staunch Tathlum",
		head="Befouled Crown",
		body="Arbatel Gown +2",
		hands={ name="Chironic Gloves", augments={'STR+12','Accuracy+8','"Refresh"+1',}},
		legs="Assid. Pants +1",
		feet="Nyame Sollerets",
		neck="Sibyl Scarf",
		waist="Rumination Sash",
		left_ear="Etiolation Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','Latent effect: "Refresh"+1',}},
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Solemnity Cape",
	}

    sets.idle.PDT = {
		main="Malignance Pole",
		sub="Enki Strap",
		ammo="Staunch Tathlum",
		head="Nyame Helm",
		body="Arbatel Gown +2",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Carrier's Sash",
		left_ear="Etiolation Earring",
		right_ear="Lugalbanda Earring",
		left_ring="Defending Ring",
		right_ring="Vocane Ring",
		back="Solemnity Cape",
	}
		
	sets.idle.Hippo = set_combine(sets.idle.PDT, {})

    sets.idle.Weak = {main="Bolelabunga",sub="Genmei Shield",ammo="Homiliary",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
        body="Jhakri Robe +2",hands=gear.merlinic_refresh_hands,ring1="Defending Ring",ring2="Dark Ring",
        back="Umbra Cape",waist="Flax Sash",legs="Assid. Pants +1",feet=gear.chironic_refresh_feet}
		
    -- Defense sets

    sets.defense.PDT = {
		main="Malignance Pole",
		sub="Enki Strap",
		ammo="Staunch Tathlum",
		head="Nyame Helm",
		body="Arbatel Gown +2",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Carrier's Sash",
		left_ear="Etiolation Earring",
		right_ear="Lugalbanda Earring",
		left_ring="Defending Ring",
		right_ring="Vocane Ring",
		back="Solemnity Cape",
	}

    sets.defense.MDT = {
		main="Malignance Pole",
		sub="Enki Strap",
		ammo="Staunch Tathlum",
		head="Nyame Helm",
		body="Arbatel Gown +2",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Carrier's Sash",
		left_ear="Etiolation Earring",
		right_ear="Lugalbanda Earring",
		left_ring="Defending Ring",
		right_ring="Vocane Ring",
		back="Solemnity Cape",
	}
		
    sets.defense.MEVA = {
		main="Malignance Pole",
		sub="Enki Strap",
		ammo="Staunch Tathlum",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Carrier's Sash",
		left_ear="Etiolation Earring",
		right_ear="Lugalbanda Earring",
		left_ring="Defending Ring",
		right_ring="Vocane Ring",
		back="Solemnity Cape",
	}
		
    sets.Kiting = {feet="Crier's Gaiters",}
    sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.TPEat = {neck="Chrys. Torque"}
	sets.DayIdle = {}
	sets.NightIdle = {}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {main="Bolelabunga",sub="Genmei Shield",ammo="Homiliary",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
        body="Jhakri Robe +2",hands=gear.merlinic_refresh_hands,ring1="Defending Ring",ring2="Sheltered Ring",
        back="Umbra Cape",waist="Flax Sash",legs="Assid. Pants +1",feet=gear.chironic_refresh_feet}
		
	sets.engaged.PDT = {main="Malignance Pole", sub="Oneiros Grip",ammo="Staunch Tathlum +1",
        head="Gende. Caubeen +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
        body="Vrikodara Jupon",hands="Gende. Gages +1",ring1="Defending Ring",ring2="Dark Ring",
        back="Umbra Cape",waist="Flax Sash",legs="Hagondes Pants +1",feet=gear.chironic_refresh_feet}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Ebullience'] = {head="Arbatel Bonnet +2"}
    sets.buff['Rapture'] = {head="Arbatel Bonnet +2"}
    sets.buff['Perpetuance'] = {hands="Arbatel Bracers +2"}
    sets.buff['Immanence'] = {hands="Arbatel Bracers +2"}
    sets.buff['Penury'] = {}
    sets.buff['Parsimony'] = {legs="Arbatel Pants +1"}
    sets.buff['Celerity'] = {feet="Peda. Loafers +1"}
    sets.buff['Alacrity'] = {feet="Peda. Loafers +1"}
    sets.buff['Klimaform'] = {feet="Arbatel Loafers +3",}
	sets.buff['Addendum: Black'] = {body="Arbatel Gown +2"}
	sets.buff['Addendum: White'] = {body="Arbatel Gown +2"}
	
	sets.HPDown = {head="Pixie Hairpin +1",ear1="Mendicant's Earring",ear2="Evans Earring",
		body="Zendik Robe",hands="Hieros Mittens",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
		back="Swith Cape +1",waist="Flax Sash",legs="Shedir Seraweels",feet=""}
		
    sets.HPCure = {main="Daybreak",sub="Sors Shield",range=empty,ammo="Hasty Pinion +1",
        head="Gende. Caubeen +1",neck="Unmoving Collar +1",ear1="Gifted Earring",ear2="Mendi. Earring",
        body="Kaykaus Bliaut",hands="Kaykaus Cuffs",ring1="Gelatinous Ring +1",ring2="Meridian Ring",
        back="Moonlight Cape",waist="Luminary Sash",legs="Carmine Cuisses +1",feet="Kaykaus Boots"}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff['Light Arts'] = {} --legs="Academic's Pants +3"
	sets.buff['Dark Arts'] = {} --body="Academic's Gown +3"

    sets.buff.Sublimation = {head="Acad. Mortar. +3",waist="Embla Sash"}
    sets.buff.DTSublimation = {waist="Embla Sash"}
	
	-- Weapons sets
	sets.weapons.Akademos = {main="Akademos",sub="Enki Strap"}
	sets.weapons.Khatvanga = {main="Khatvanga",sub="Bloodrain Strap"}
end

-- Select default macro book on initial load or subjob change.
-- Default macro set/book
function select_default_macro_book()
	if player.sub_job == 'RDM' then
		set_macro_page(1, 14)
	elseif player.sub_job == 'BLM' then
		set_macro_page(1, 14)
	elseif player.sub_job == 'WHM' then
		set_macro_page(1, 14)
	else
		set_macro_page(1, 14)
	end
end