function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc', 'Fodder')
    state.WeaponskillMode:options('Match','Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder')
    state.HybridMode:options('Normal', 'PDT')
    state.PhysicalDefenseMode:options('PDT', 'HP')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'PDT')
	state.Weapons:options('Godhands','Staff','ProcStaff','ProcClub','Barehanded','ProcSword','ProcGreatSword','ProcScythe','ProcPolearm','ProcGreatKatana')

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None'}

    update_melee_groups()
	
	-- Additional local binds
	send_command('bind ^` input /ja "Boost" <me>')
	send_command('bind !` input /ja "Perfect Counter" <me>')
	send_command('bind ^backspace input /ja "Mantra" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind ^p gs c set OffenseMode Fodder')
	send_command('bind ^n gs c set OffenseMode Normal')
	
	select_default_macro_book()
end

function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs on use
	sets.precast.JA['Hundred Fists'] = {legs={ name="Hes. Hose +3", augments={'Enhances "Hundred Fists" effect',}},}
	sets.precast.JA['Boost'] = {hands="Anchor. Gloves +2",waist="Ask Sash",} --hands="Anchorite's Gloves +1"
	sets.precast.JA['Boost'].OutOfCombat = {hands="Anchor. Gloves +2",waist="Ask Sash",} --hands="Anchorite's Gloves +1", Remove Haste and Add Slow Gear.
	sets.precast.JA['Dodge'] = {feet="Anch. Gaiters +3",}
	sets.precast.JA['Focus'] = {}
	sets.precast.JA['Counterstance'] = {
		main={ name="Godhands", augments={'Path: A',}},
		ammo="Staunch Tathlum",
		head="Mpaca's Cap",
		body="Mpaca's Doublet",
		hands="Malignance Gloves",
		legs="Anch. Hose +2",
		feet={ name="Hes. Gaiters +3", augments={'Enhances "Mantra" effect',}},
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Cryptic Earring",
		right_ear={ name="Bhikku Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','"Store TP"+3',}},
		left_ring="Niqmaddu Ring",
		right_ring="Defending Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+10 Attack+10','STR+6','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},} --feet="Hesychast's Gaiters +1"
	sets.precast.JA['Footwork'] = {feet="Shukuyu Sune-Ate",}
	sets.precast.JA['Formless Strikes'] = {}
	sets.precast.JA['Mantra'] = {} --feet="Hesychast's Gaiters +1"

	sets.precast.JA['Chi Blast'] = {
		head={ name="Hes. Crown +3", augments={'Enhances "Penance" effect',}},
	}
	
	sets.precast.JA['Chakra'] = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Genmei Kabuto" },
		body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},
		hands="Tuisto Earring",
		legs="Hiza. Hizayoroi +2",
		feet="Shukuyu Sune-Ate",
		neck="Unmoving Collar +1",
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Cryptic Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Petrov Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+10 Attack+10','STR+6','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.precast.Step = {}
		
	sets.precast.Flourish1 = {}


	-- Fast cast sets for spells
	
	sets.precast.FC = {
		ammo="Staunch Tathlum",
		head={ name="Rao Kabuto +1", augments={'VIT+12','Attack+25','"Counter"+4',}},
		body="Ken. Samue +1",
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs={ name="Ryuo Hakama", augments={'HP+50','"Store TP"+4','"Subtle Blow"+7',}},
		feet={ name="Herculean Boots", augments={'Accuracy+29','Weapon skill damage +4%','CHR+9','Attack+5',}},
		neck="Unmoving Collar +1",
		waist="Rumination Sash",
		left_ear="Sherida Earring",
		right_ear="Etiolation Earring",
		left_ring="Rahab Ring",
		right_ring="Lebeche Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+10 Attack+10','STR+6','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {}
	sets.precast.WSSomeAcc = {}
	sets.precast.WSAcc = {}
	sets.precast.WSFullAcc = {}
	sets.precast.WSFodder = {}
	sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, sets.precast.WSSomeAcc)	
	sets.precast.WS.Acc = set_combine(sets.precast.WS, sets.precast.WSAcc)
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, sets.precast.WSFullAcc)
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, sets.precast.WSFodder)

	-- Specific weaponskill sets.

	sets.precast.WS['Raging Fists']    = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
		body="Ken. Samue +1",
		hands={ name="Adhemar Wrist. +1", augments={'Accuracy+20','Attack+20','"Subtle Blow"+8',}},
		legs="Ken. Hakama +1",
		feet={ name="Herculean Boots", augments={'Accuracy+29','Weapon skill damage +4%','CHR+9','Attack+5',}},
		neck={ name="Mnk. Nodowa +1", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Ishvara Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Petrov Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+10 Attack+10','STR+6','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	})
	sets.precast.WS['Howling Fist']    = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head={ name="Hes. Crown +3", augments={'Enhances "Penance" effect',}},
		body="Ken. Samue +1",
		hands={ name="Adhemar Wrist. +1", augments={'Accuracy+20','Attack+20','"Subtle Blow"+8',}},
		legs="Ken. Hakama +1",
		feet={ name="Herculean Boots", augments={'Accuracy+29','Weapon skill damage +4%','CHR+9','Attack+5',}},
		neck={ name="Mnk. Nodowa +1", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Ishvara Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Petrov Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+10 Attack+10','STR+6','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	})
	sets.precast.WS['Asuran Fists']    = set_combine(sets.precast.WS, {})
	sets.precast.WS["Ascetic's Fury"]  = set_combine(sets.precast.WS, {})
	sets.precast.WS["Victory Smite"]   = set_combine(sets.precast.WS, {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
		body="Ken. Samue +1",
		hands={ name="Ryuo Tekko +1", augments={'DEX+12','Accuracy+25','"Dbl.Atk."+4',}},
		legs="Ken. Hakama +1",
		feet={ name="Herculean Boots", augments={'Accuracy+29','Weapon skill damage +4%','CHR+9','Attack+5',}},
		neck={ name="Mnk. Nodowa +1", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Ishvara Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Mummu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+10 Attack+10','STR+6','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	})
	sets.precast.WS['Shijin Spiral']   = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head="Ken. Jinpachi +1",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs={ name="Tatena. Haidate +1", augments={'Path: A',}},
		feet={ name="Herculean Boots", augments={'Accuracy+29','Weapon skill damage +4%','CHR+9','Attack+5',}},
		neck={ name="Mnk. Nodowa +1", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Mache Earring +1",
		left_ring="Niqmaddu Ring",
		right_ring="Chirich Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+10 Attack+10','STR+6','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	})
	sets.precast.WS['Dragon Kick']     = set_combine(sets.precast.WS, {
	    ammo="Knobkierrie",
		head={ name="Hes. Crown +3", augments={'Enhances "Penance" effect',}},
		body="Ken. Samue +1",
		hands={ name="Adhemar Wrist. +1", augments={'Accuracy+20','Attack+20','"Subtle Blow"+8',}},
		legs="Ken. Hakama +1",
		feet="Anch. Gaiters +3",
		neck={ name="Mnk. Nodowa +1", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Ishvara Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Petrov Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+10 Attack+10','STR+6','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	})
	sets.precast.WS['Tornado Kick']    = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head={ name="Hes. Crown +3", augments={'Enhances "Penance" effect',}},
		body="Ken. Samue +1",
		hands={ name="Adhemar Wrist. +1", augments={'Accuracy+20','Attack+20','"Subtle Blow"+8',}},
		legs="Ken. Hakama +1",
		feet="Anch. Gaiters +3",
		neck={ name="Mnk. Nodowa +1", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Ishvara Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Petrov Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+10 Attack+10','STR+6','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	})
	sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head={ name="Herculean Helm", augments={'Accuracy+4','Weapon skill damage +2%','AGI+1','Attack+3',}},
		body="Ken. Samue +1",
		hands={ name="Adhemar Wrist. +1", augments={'Accuracy+20','Attack+20','"Subtle Blow"+8',}},
		legs="Hiza. Hizayoroi +2",
		feet={ name="Herculean Boots", augments={'Accuracy+29','Weapon skill damage +4%','CHR+9','Attack+5',}},
		neck={ name="Mnk. Nodowa +1", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Ishvara Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+10 Attack+10','STR+6','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	})
	
	sets.precast.WS['Shell Crusher'] = set_combine(sets.precast.WS, {
		main="Malignance Pole",
		sub="Dilet.'s Grip +1",
		ammo="Pemphredo Tathlum",
		head={ name="Herculean Helm", augments={'"Fast Cast"+2','Attack+12','Weapon skill damage +6%',}},
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Mummu Kecks +2",
		feet={ name="Herculean Boots", augments={'Accuracy+29','Weapon skill damage +4%','CHR+9','Attack+5',}},
		neck="Moonlight Necklace",
		waist="Eschan Stone",
		left_ear="Digni. Earring",
		right_ear="Hermetic Earring",
		left_ring="Mummu Ring",
		right_ring="Rahab Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+10 Attack+10','STR+6','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	})

	sets.precast.WS["Raging Fists"].SomeAcc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSSomeAcc)
	sets.precast.WS["Howling Fist"].SomeAcc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSSomeAcc)
	sets.precast.WS["Asuran Fists"].SomeAcc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSSomeAcc)
	sets.precast.WS["Ascetic's Fury"].SomeAcc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSSomeAcc, {})
	sets.precast.WS["Victory Smite"].SomeAcc = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSSomeAcc, {})
	sets.precast.WS["Shijin Spiral"].SomeAcc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSSomeAcc, {})
	sets.precast.WS["Dragon Kick"].SomeAcc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSSomeAcc)
	sets.precast.WS["Tornado Kick"].SomeAcc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSSomeAcc)
	
	sets.precast.WS["Raging Fists"].Acc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSAcc)
	sets.precast.WS["Howling Fist"].Acc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSAcc)
	sets.precast.WS["Asuran Fists"].Acc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSAcc)
	sets.precast.WS["Ascetic's Fury"].Acc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSAcc, {})
	sets.precast.WS["Victory Smite"].Acc = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSAcc, {})
	sets.precast.WS["Shijin Spiral"].Acc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSAcc)
	sets.precast.WS["Dragon Kick"].Acc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSAcc)
	sets.precast.WS["Tornado Kick"].Acc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSAcc)

	sets.precast.WS["Raging Fists"].FullAcc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSFullAcc)
	sets.precast.WS["Howling Fist"].FullAcc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSFullAcc)
	sets.precast.WS["Asuran Fists"].FullAcc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSFullAcc)
	sets.precast.WS["Ascetic's Fury"].FullAcc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSFullAcc, {})
	sets.precast.WS["Victory Smite"].FullAcc = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSFullAcc, {})
	sets.precast.WS["Shijin Spiral"].FullAcc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSFullAcc)
	sets.precast.WS["Dragon Kick"].FullAcc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSFullAcc)
	sets.precast.WS["Tornado Kick"].FullAcc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSFullAcc)
	
	sets.precast.WS["Raging Fists"].Fodder = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSFodder)
	sets.precast.WS["Howling Fist"].Fodder = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSFodder)
	sets.precast.WS["Asuran Fists"].Fodder = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSFodder)
	sets.precast.WS["Ascetic's Fury"].Fodder = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSFodder, {})
	sets.precast.WS["Victory Smite"].Fodder = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSFodder, {})
	sets.precast.WS["Shijin Spiral"].Fodder = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSFodder)
	sets.precast.WS["Dragon Kick"].Fodder = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSFodder)
	sets.precast.WS["Tornado Kick"].Fodder = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSFodder)


	sets.precast.WS['Cataclysm'] = {}
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}
	
	-- Midcast Sets
	sets.midcast.FastRecast = {}
		
	-- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})
		
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {}
	

	-- Idle sets
	sets.idle = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
		body="Ken. Samue +1",
		hands={ name="Adhemar Wrist. +1", augments={'Accuracy+20','Attack+20','"Subtle Blow"+8',}},
		legs="Bhikku Hose +2",
		feet="Anch. Gaiters +3",
		neck={ name="Mnk. Nodowa +1", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Chirich Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+10 Attack+10','STR+6','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	}

	sets.idle.Weak = {}

	sets.idle.PDT = {}

	-- Defense sets
	sets.defense.PDT = {
		ammo="Staunch Tathlum",
		head="Mpaca's Cap",
		body="Mpaca's Doublet",
		hands="Malignance Gloves",
		legs="Bhikku Hose +2",
		feet="Mpaca's Boots",
		neck={ name="Mnk. Nodowa +1", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Defending Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+10 Attack+10','STR+6','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	}
		
	-- Defense sets
	sets.defense.HP = {}

	sets.defense.MDT = {}
		
	sets.defense.MEVA = {}

	sets.Kiting = {
		feet="Hermes' Sandals",
	}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee sets
	sets.engaged = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Ken. Jinpachi +1",
		body="Ken. Samue +1",
		hands={ name="Adhemar Wrist. +1", augments={'Accuracy+20','Attack+20','"Subtle Blow"+8',}},
		legs="Bhikku Hose +2",
		-- legs={ name="Hes. Hose +3", augments={'Enhances "Hundred Fists" effect',}},
		feet="Anch. Gaiters +3",
		neck={ name="Mnk. Nodowa +1", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Chirich Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+10 Attack+10','STR+6','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	}
	sets.engaged.SomeAcc = {}
	sets.engaged.Acc = {}
	sets.engaged.FullAcc = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Ken. Jinpachi +1",
		body="Ken. Samue +1",
		hands={ name="Adhemar Wrist. +1", augments={'Accuracy+20','Attack+20','"Subtle Blow"+8',}},
		legs="Bhikku Hose +2",
		-- legs={ name="Hes. Hose +3", augments={'Enhances "Hundred Fists" effect',}},
		feet="Anch. Gaiters +3",
		neck={ name="Mnk. Nodowa +1", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Chirich Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+10 Attack+10','STR+6','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	}
	sets.engaged.Fodder = {
		ammo="Amar Cluster",
		head={ name="Rao Kabuto +1", augments={'VIT+12','Attack+25','"Counter"+4',}},
		body="Mpaca's Doublet",
		hands="Malignance Gloves",
		legs="Anch. Hose +2",
		feet={ name="Hes. Gaiters +3", augments={'Enhances "Mantra" effect',}},
		neck={ name="Mnk. Nodowa +1", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Cryptic Earring",
		right_ear={ name="Bhikku Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','"Store TP"+3',}},
		left_ring="Niqmaddu Ring",
		right_ring="Defending Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+10 Attack+10','STR+6','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	}

	-- Defensive melee hybrid sets
	sets.engaged.PDT = {
		ammo="Staunch Tathlum",
		head="Mpaca's Cap",
		body="Mpaca's Doublet",
		hands="Malignance Gloves",
		legs="Bhikku Hose +2",
		feet={ name="Hes. Gaiters +3", augments={'Enhances "Mantra" effect',}},
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Cryptic Earring",
		left_ring="Vocane Ring",
		right_ring="Defending Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+10 Attack+10','STR+6','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	}
	sets.engaged.SomeAcc.PDT = {}
	sets.engaged.Acc.PDT = {}
	sets.engaged.FullAcc.PDT = {}
	sets.engaged.Fodder.PDT = {}

	-- Hundred Fists/Impetus melee set mods
	
	sets.engaged.HF = set_combine(sets.engaged, {body="Bhikku Cyclas +2",})
	sets.engaged.SomeAcc.HF = set_combine(sets.engaged.SomeAcc, {body="Bhikku Cyclas +2",})
	sets.engaged.Acc.HF = set_combine(sets.engaged.Acc, {body="Bhikku Cyclas +2",})
	sets.engaged.FullAcc.HF = set_combine(sets.engaged.FullAcc, {body="Bhikku Cyclas +2",})
	sets.engaged.Fodder.HF = set_combine(sets.engaged.Fodder, {body="Bhikku Cyclas +2",})




	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {}
	sets.buff.Impetus = {body="Bhikku Cyclas +2",}
	sets.buff.Footwork = {
		legs={ name="Hes. Hose +3", augments={'Enhances "Hundred Fists" effect',}},
		feet="Anch. Gaiters +3",
	}
	sets.buff.Boost = {waist="Ask Sash",} --waist="Ask Sash"
	
	sets.FootworkWS = {}
	sets.DayIdle = {}
	sets.NightIdle = {}
    sets.Knockback = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.Skillchain = {}
	
	-- Weapons sets
	sets.weapons.Godhands = {main={ name="Godhands", augments={'Path: A',}},}
	sets.weapons.Barehanded = {main=empty}
	sets.weapons.Staff = {main="Malignance pole",}
	sets.weapons.ProcStaff = {main="Malignance pole",}
	sets.weapons.ProcClub = {}
	sets.weapons.ProcSword = {}
	sets.weapons.ProcGreatSword = {}
	sets.weapons.ProcScythe = {}
	sets.weapons.ProcPolearm = {}
	sets.weapons.ProcGreatKatana = {}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(1,7)
	elseif player.sub_job == 'NIN' then
		set_macro_page(1,7)
	elseif player.sub_job == 'THF' then
		set_macro_page(1,7)
	elseif player.sub_job == 'RUN' then
		set_macro_page(1,7)
	else
		set_macro_page(1,7)
	end
end