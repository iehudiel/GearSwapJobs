-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal','Acc')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Match','Normal', 'Acc','Proc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')
	state.HybridMode:options('Normal','DT')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'DWMax'}
	state.Weapons:options('Default','DualWeapons','DualSavageWeapons','DualLeadenRanged','DualLeadenMelee','DualAeolian','DualLeadenMeleeAcc','DualRanged','None')
	state.CompensatorMode:options('Always','300','1000','Never')

    gear.RAbullet = "Chrono Bullet"
    gear.WSbullet = "Chrono Bullet"
    --gear.MAbullet = "Orichalc. Bullet" --For MAB WS, do not put single-use bullets here.
    --gear.QDbullet = "Animikii Bullet"
    options.ammo_warning_limit = 15

	gear.tp_ranger_jse_back = {name="Camulus's Mantle",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}}
	gear.snapshot_jse_back = {name="Camulus's Mantle",augments={'"Snapshot"+10',}}
	gear.tp_jse_back = {name="Camulus's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}}
	gear.ranger_wsd_jse_back = {name="Camulus's Mantle",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
	gear.magic_wsd_jse_back = {name="Camulus's Mantle",augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
	gear.str_wsd_jse_back = {name="Camulus's Mantle",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}

    -- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` gs c elemental quickdraw')
	
	send_command('bind ^backspace input /ja "Double-up" <me>')
	send_command('bind @backspace input /ja "Snake Eye" <me>')
	send_command('bind !backspace input /ja "Fold" <me>')
	send_command('bind ^@!backspace input /ja "Crooked Cards" <me>')
	
	send_command('bind ^\\\\ input /ja "Random Deal" <me>')
    send_command('bind !\\\\ input /ja "Bolter\'s Roll" <me>')
	send_command('bind ^@!\\\\ gs c toggle LuzafRing')
	send_command('bind @f7 gs c toggle RngHelper')

	send_command('bind !r gs c weapons DualSavageWeapons;gs c update')
	send_command('bind ^q gs c weapons DualAeolian;gs c update')
	send_command('bind @q gs c weapons DualKustawi;gs c update')
	send_command('bind !q gs c weapons DualLeadenRanged;gs c update')
	send_command('bind @pause roller roll')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Precast sets to enhance JAs

	sets.precast.JA['Triple Shot'] = {
	 --body="Chasseur's Frac +1"
	}
    sets.precast.JA['Snake Eye'] = {
		legs="Lanun Trews +1"
	}
    sets.precast.JA['Wild Card'] = {
		feet="Lanun Bottes +3"
	}
    sets.precast.JA['Random Deal'] = {
		body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
	}
    sets.precast.FoldDoubleBust = {
		--hands="Lanun Gants +1"
	}

    sets.precast.CorsairRoll = {
		main="Rostam",
		range={ name="Compensator", augments={'DMG:+15','Rng.Atk.+15','"Mag.Atk.Bns."+15',}},
		head={ name="Lanun Tricorne +1", augments={'Enhances "Winning Streak" effect',}},
		body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		hands="Chasseur's Gants +1",
		legs="Nyame Flanchard",
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Regal Necklace",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Barataria Ring",
		right_ring="Luzaf's Ring",
		back={ name="Camulus's Mantle", augments={'AGI+16','Rng.Acc.+20 Rng.Atk.+20','Rng.Atk.+10','Weapon skill damage +10%','Damage taken-5%',}},
	}

    sets.precast.LuzafRing = {		
		right_ring="Luzaf's Ring",
	}
    
    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chas. Culottes +1"})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chass. Bottes +2"})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {
		--head="Chass. Tricorne +1"
		})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {
		--body="Chasseur's Frac +1"
	})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +1"})
    
    sets.precast.CorsairShot = {
		head="Nyame Helm",
		body={ name="Samnuha Coat", augments={'Mag. Acc.+8','"Mag.Atk.Bns."+11','"Dual Wield"+2',}},
		hands="Malignance Gloves",
		legs="Nyame Flanchard",
		feet="Chass. Bottes +2",
		neck="Deviant Necklace",
		waist="Eschan Stone",
		left_ear="Hecate's Earring",
		right_ear="Friomisi Earring",
		left_ring="Crepuscular Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+16','Rng.Acc.+20 Rng.Atk.+20','Rng.Atk.+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
		
	sets.precast.CorsairShot.Damage = {
		head="Nyame Helm",
		body={ name="Samnuha Coat", augments={'Mag. Acc.+8','"Mag.Atk.Bns."+11','"Dual Wield"+2',}},
		hands="Malignance Gloves",
		legs="Nyame Flanchard",
		feet="Chass. Bottes +2",
		neck="Deviant Necklace",
		waist="Eschan Stone",
		left_ear="Hecate's Earring",
		right_ear="Friomisi Earring",
		left_ring="Crepuscular Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+16','Rng.Acc.+20 Rng.Atk.+20','Rng.Atk.+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
    sets.precast.CorsairShot.Proc = {
		head="Nyame Helm",
		body={ name="Samnuha Coat", augments={'Mag. Acc.+8','"Mag.Atk.Bns."+11','"Dual Wield"+2',}},
		hands="Malignance Gloves",
		legs="Nyame Flanchard",
		feet="Chass. Bottes +2",
		neck="Deviant Necklace",
		waist="Eschan Stone",
		left_ear="Hecate's Earring",
		right_ear="Friomisi Earring",
		left_ring="Crepuscular Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+16','Rng.Acc.+20 Rng.Atk.+20','Rng.Atk.+10','Weapon skill damage +10%','Damage taken-5%',}},
	}

    sets.precast.CorsairShot['Light Shot'] = {
		head="Nyame Helm",
		body={ name="Samnuha Coat", augments={'Mag. Acc.+8','"Mag.Atk.Bns."+11','"Dual Wield"+2',}},
		hands="Malignance Gloves",
		legs="Nyame Flanchard",
		feet="Chass. Bottes +2",
		neck="Deviant Necklace",
		waist="Eschan Stone",
		left_ear="Hecate's Earring",
		right_ear="Friomisi Earring",
		left_ring="Crepuscular Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+16','Rng.Acc.+20 Rng.Atk.+20','Rng.Atk.+10','Weapon skill damage +10%','Damage taken-5%',}},
	}

    sets.precast.CorsairShot['Dark Shot'] = set_combine(sets.precast.CorsairShot['Light Shot'], {
		head="Pixie Hairpin +1",
		left_ring="Archon Ring",
		feet="Chass. Bottes +2"})

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Nyame Helm",
		body="Nyame Mail",
		hands="Malignance Gloves",
		legs="Dashing Subligar",
		feet="Nyame Sollerets",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Handler's Earring +1",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Vocane Ring",
		right_ring="Defending Ring",
		back={ name="Camulus's Mantle", augments={'AGI+16','Rng.Acc.+20 Rng.Atk.+20','Rng.Atk.+10','Weapon skill damage +10%','Damage taken-5%',}},
		}
		
	sets.Self_Waltz = {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Malignance Gloves",
		legs="Dashing Subligar",
		feet="Nyame Sollerets",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Handler's Earring +1",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Vocane Ring",
		right_ring="Defending Ring",
		back={ name="Camulus's Mantle", augments={'AGI+16','Rng.Acc.+20 Rng.Atk.+20','Rng.Atk.+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
		head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
		body="Nyame Mail",
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet="Nyame Sollerets",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Halasz Earring",
		left_ring="Kishar Ring",
		right_ring="Lebeche Ring",
	}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
			neck="Magoraga Beads",
		}
	)
	
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {right_ear="Mendi. Earring"})

    sets.precast.RA = {
		head="Ikenga's Hat",
		body="Laksa. Frac +2",
		hands="Ikenga's Gloves",
		legs="Ikenga's Trousers",
		feet="Meg. Jam. +2",
		neck="Iskur Gorget",
		waist="Kentarch Belt",
		left_ear="Telos Earring",
		right_ear="Crep. Earring",
		left_ring="Dingir Ring",
		right_ring="Crepuscular Ring",
		back={ name="Camulus's Mantle", augments={'AGI+16','Rng.Acc.+20 Rng.Atk.+20','Rng.Atk.+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
		
	sets.precast.RA.Flurry = set_combine(sets.precast.RA, {})
	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA, {})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head={ name="Herculean Helm", augments={'"Fast Cast"+2','Attack+12','Weapon skill damage +6%',}},
		body="Laksa. Frac +2",
		hands="Meg. Gloves +2",
		legs="Ikenga's Trousers",
		feet={ name="Herculean Boots", augments={'Accuracy+29','Weapon skill damage +4%','CHR+9','Attack+5',}},
		neck="Rep. Plat. Medal",
		waist="Eschan Stone",
		left_ear="Telos Earring",
		right_ear="Ishvara Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Camulus's Mantle", augments={'AGI+16','Rng.Acc.+20 Rng.Atk.+20','Rng.Atk.+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
		
    sets.precast.WS.Acc = {
        head={ name="Herculean Helm", augments={'"Fast Cast"+2','Attack+12','Weapon skill damage +6%',}},
		body="Laksa. Frac +2",
		hands="Meg. Gloves +2",
		legs="Ikenga's Trousers",
		feet={ name="Herculean Boots", augments={'Accuracy+29','Weapon skill damage +4%','CHR+9','Attack+5',}},
		neck="Rep. Plat. Medal",
		waist="Eschan Stone",
		left_ear="Telos Earring",
		right_ear="Ishvara Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Camulus's Mantle", augments={'AGI+16','Rng.Acc.+20 Rng.Atk.+20','Rng.Atk.+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
		
    sets.precast.WS.Proc = {
        head={ name="Herculean Helm", augments={'"Fast Cast"+2','Attack+12','Weapon skill damage +6%',}},
		body="Laksa. Frac +2",
		hands="Meg. Gloves +2",
		legs="Ikenga's Trousers",
		feet={ name="Herculean Boots", augments={'Accuracy+29','Weapon skill damage +4%','CHR+9','Attack+5',}},
		neck="Rep. Plat. Medal",
		waist="Eschan Stone",
		left_ear="Telos Earring",
		right_ear="Ishvara Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Camulus's Mantle", augments={'AGI+16','Rng.Acc.+20 Rng.Atk.+20','Rng.Atk.+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
		
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Savage Blade'] = {
		head={ name="Herculean Helm", augments={'"Fast Cast"+2','Attack+12','Weapon skill damage +6%',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Meg. Gloves +2",
		legs="Nyame Flanchard",
		feet={ name="Herculean Boots", augments={'Accuracy+29','Weapon skill damage +4%','CHR+9','Attack+5',}},
		neck="Clotharius Torque",
		waist="Eschan Stone",
		left_ear="Telos Earring",
		right_ear="Ishvara Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'AGI+16','Rng.Acc.+20 Rng.Atk.+20','Rng.Atk.+10','Weapon skill damage +10%','Damage taken-5%',}},
	}

    sets.precast.WS['Savage Blade'].Acc = {
		head={ name="Herculean Helm", augments={'"Fast Cast"+2','Attack+12','Weapon skill damage +6%',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Meg. Gloves +2",
		legs="Nyame Flanchard",
		feet={ name="Herculean Boots", augments={'Accuracy+29','Weapon skill damage +4%','CHR+9','Attack+5',}},
		neck="Clotharius Torque",
		waist="Eschan Stone",
		left_ear="Telos Earring",
		right_ear="Ishvara Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'AGI+16','Rng.Acc.+20 Rng.Atk.+20','Rng.Atk.+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
    sets.precast.WS['Last Stand'] = {
		head={ name="Herculean Helm", augments={'"Fast Cast"+2','Attack+12','Weapon skill damage +6%',}},
		body="Laksa. Frac +2",
		hands="Meg. Gloves +2",
		legs="Ikenga's Trousers",
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Iskur Gorget",
		waist="Eschan Stone",
		left_ear="Telos Earring",
		right_ear="Enervating Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+16','Rng.Acc.+20 Rng.Atk.+20','Rng.Atk.+10','Weapon skill damage +10%','Damage taken-5%',}},
	}

    sets.precast.WS['Last Stand'].Acc = {
		head={ name="Herculean Helm", augments={'"Fast Cast"+2','Attack+12','Weapon skill damage +6%',}},
		body="Laksa. Frac +2",
		hands="Meg. Gloves +2",
		legs="Ikenga's Trousers",
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Iskur Gorget",
		waist="Eschan Stone",
		left_ear="Telos Earring",
		right_ear="Enervating Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+16','Rng.Acc.+20 Rng.Atk.+20','Rng.Atk.+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
		
    sets.precast.WS['Detonator'] = sets.precast.WS['Last Stand']
    sets.precast.WS['Detonator'].Acc = sets.precast.WS['Last Stand'].Acc
    sets.precast.WS['Slug Shot'] = sets.precast.WS['Last Stand']
    sets.precast.WS['Slug Shot'].Acc = sets.precast.WS['Last Stand'].Acc
    sets.precast.WS['Numbing Shot'] = sets.precast.WS['Last Stand']
    sets.precast.WS['Numbing Shot'].Acc = sets.precast.WS['Last Stand'].Acc
    sets.precast.WS['Sniper Shot'] = sets.precast.WS['Last Stand']
    sets.precast.WS['Sniper Shot'].Acc = sets.precast.WS['Last Stand'].Acc
    sets.precast.WS['Split Shot'] = sets.precast.WS['Last Stand']
    sets.precast.WS['Split Shot'].Acc = sets.precast.WS['Last Stand'].Acc
	
    sets.precast.WS['Leaden Salute'] = {
		head="Pixie Hairpin +1",
		body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Deviant Necklace",
		waist="Eschan Stone",
		left_ear="Hecate's Earring",
		right_ear="Friomisi Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Archon Ring",
		back={ name="Camulus's Mantle", augments={'AGI+16','Rng.Acc.+20 Rng.Atk.+20','Rng.Atk.+10','Weapon skill damage +10%','Damage taken-5%',}},
	}

    sets.precast.WS['Aeolian Edge'] = {ammo="Animikii Bullet",
        head=gear.herculean_nuke_head,neck="Sanctity Necklace",ear1="Crematio Earring",ear2="Friomisi Earring",
        body="Laksa. Frac +3",hands="Leyline Gloves",ring1="Metamor. Ring +1",ring2="Dingir Ring",
        back=gear.magic_wsd_jse_back,waist="Eschan Stone",legs="Laksa. Trews +3",feet="Lanun Bottes +3"}

    sets.precast.WS['Wildfire'] = {ammo=gear.RAbullet,
        head=gear.herculean_nuke_head,neck="Baetyl Pendant",ear1="Crematio Earring",ear2="Friomisi Earring",
        body="Laksa. Frac +3",hands="Carmine Fin. Ga. +1",ring1="Regal Ring",ring2="Dingir Ring",
        back=gear.magic_wsd_jse_back,waist="Eschan Stone",legs="Nyame Flanchard",feet="Lanun Bottes +3"}

    sets.precast.WS['Wildfire'].Acc = {ammo=gear.RAbullet,
        head=gear.herculean_nuke_head,neck="Sanctity Necklace",ear1="Crematio Earring",ear2="Friomisi Earring",
        body="Laksa. Frac +3",hands="Leyline Gloves",ring1="Regal Ring",ring2="Dingir Ring",
        back=gear.magic_wsd_jse_back,waist="Eschan Stone",legs="Laksa. Trews +3",feet="Lanun Bottes +3"}
		
    sets.precast.WS['Hot Shot'] = sets.precast.WS['Wildfire']
    sets.precast.WS['Hot Shot'].Acc = sets.precast.WS['Wildfire'].Acc
		
		--Because omen skillchains.
    sets.precast.WS['Burning Blade'] = {ammo=gear.RAbullet,
        head="Meghanada Visor +2",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Sanare Earring",
        body="Meg. Cuirie +2",hands="Malignance Gloves",ring1="Defending Ring",ring2="Dark Ring",
        back="Moonlight Cape",waist="Flume Belt +1",legs="Meg. Chausses +2",feet="Meg. Jam. +2"}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}
        
    -- Midcast Sets
    sets.midcast.FastRecast = {
        head="Carmine Mask",neck="Baetyl Pendant",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
        body="Dread Jupon",hands="Leyline Gloves",ring1="Kishar Ring",ring2="Lebeche Ring",
        back="Moonlight Cape",waist="Flume Belt +1",legs="Rawhide Trousers",feet="Carmine Greaves +1"}
        
    -- Specific spells

	sets.midcast.Cure = {
        head="Carmine Mask +1",neck="Phalaina Locket",ear1="Enchntr. Earring +1",ear2="Mendi. Earring",
        body="Dread Jupon",hands="Leyline Gloves",ring1="Janniston Ring",ring2="Lebeche Ring",
        back="Solemnity Cape",waist="Flume Belt +1",legs="Carmine Cuisses +1",feet="Carmine Greaves +1"}
	
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	
    sets.midcast.Utsusemi = sets.midcast.FastRecast

    -- Ranged gear
    sets.midcast.RA = {ammo=gear.RAbullet,
        head="Meghanada Visor +2",neck="Iskur Gorget",ear1="Enervating Earring",ear2="Telos Earring",
        body="Nisroch Jerkin",hands="Carmine Fin. Ga. +1",ring1="Rajas Ring",ring2="Ilabrat Ring",
        back=gear.tp_ranger_jse_back,waist="Yemaya Belt",legs="Adhemar Kecks",feet="Meg. Jam. +2"}

    sets.midcast.RA.Acc = {ammo=gear.RAbullet,
        head="Meghanada Visor +2",neck="Iskur Gorget",ear1="Enervating Earring",ear2="Telos Earring",
        body="Laksa. Frac +3",hands="Meg. Gloves +2",ring1="Regal Ring",ring2="Dingir Ring",
        back=gear.tp_ranger_jse_back,waist="Yemaya Belt",legs="Laksa. Trews +3",feet="Meg. Jam. +2"}
		
	sets.buff['Triple Shot'] = {body="Chasseur's Frac +1"}
    
    -- Sets to return to when not performing an action.
	
	sets.DayIdle = {}
	sets.NightIdle = {}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets
    sets.idle = {
		ammo=gear.RAbullet,
        head="Nyame Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Dark Ring",
        back="Moonlight Cape",waist="Carrier's Sash",legs="Carmine Cuisses +1",feet="Malignance Boots"}
		
    sets.idle.PDT = {ammo=gear.RAbullet,
        head="Nyame Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Dark Ring",
        back="Moonlight Cape",waist="Carrier's Sash",legs="Malignance Tights",feet="Malignance Boots"}
		
    sets.idle.Refresh = {ammo=gear.RAbullet,
        head="Rawhide Mask",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Ethereal Earring",
        body="Mekosu. Harness",hands=gear.herculean_refresh_hands,ring1="Defending Ring",ring2="Dark Ring",
        back="Moonlight Cape",waist="Flume Belt +1",legs="Rawhide Trousers",feet="Malignance Boots"}
    
    -- Defense sets
    sets.defense.PDT = {ammo=gear.RAbullet,
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Sanare Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Dark Ring",
        back="Shadow Mantle",waist="Flume Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

    sets.defense.MDT = {ammo=gear.RAbullet,
        head="Nyame Helm",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Moonlight Cape",waist="Carrier's Sash",legs="Malignance Tights",feet="Malignance Boots"}
		
    sets.defense.MEVA = {ammo=gear.RAbullet,
        head="Nyame Helm",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Moonlight Cape",waist="Carrier's Sash",legs="Malignance Tights",feet="Malignance Boots"}

    sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.DWMax = {ear1="Dudgeon Earring",ear2="Heartseeker Earring",body="Adhemar Jacket +1",hands="Floral Gauntlets",waist="Reiki Yotai"}

	-- Weapons sets
	sets.weapons.Default = {main="Naegling",sub="Nusku Shield",range="Fomalhaut"}
	sets.weapons.DualWeapons = {main="Naegling",sub="Blurred Knife +1",range="Fomalhaut"}
	sets.weapons.DualSavageWeapons = {main="Naegling",sub="Blurred Knife +1",range="Ataktos"}
	sets.weapons.DualLeadenRanged = {main="Rostam",sub="Tauret",range="Fomalhaut"}
	sets.weapons.DualLeadenMelee = {main="Naegling",sub="Atoyac",range="Fomalhaut"}
	sets.weapons.DualAeolian = {main="Rostam",sub="Tauret",range="Ataktos"}
	sets.weapons.DualLeadenMeleeAcc = {main="Naegling",sub="Blurred Knife +1",range="Fomalhaut"}
	sets.weapons.DualRanged = {main="Rostam",sub="Kustawi +1",range="Fomalhaut"}
	
    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
		head="Dampening Tam",neck="Iskur Gorget",ear1="Cessance Earring",ear2="Brutal Earring",
		body="Meg. Cuirie +2",hands="Adhemar Wrist. +1",ring1="Epona's Ring",ring2="Petrov Ring",
		back=gear.tp_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_ta_feet}
    
    sets.engaged.Acc = {
		head="Carmine Mask +1",neck="Combatant's Torque",ear1="Cessance Earring",ear2="Telos Earring",
		body="Meg. Cuirie +2",hands="Adhemar Wrist. +1",ring1="Epona's Ring",ring2="Ramuh Ring +1",
		back=gear.tp_jse_back,waist="Olseni Belt",legs="Carmine Cuisses +1",feet="Malignance Boots"}
		
    sets.engaged.DT = {
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Petrov Ring",
        back=gear.tp_jse_back,waist="Windbuffet Belt +1",legs="Malignance Tights",feet="Malignance Boots"}
    
    sets.engaged.Acc.DT = {
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Telos Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Ramuh Ring +1",
        back=gear.tp_jse_back,waist="Olseni Belt",legs="Malignance Tights",feet="Malignance Boots"}

    sets.engaged.DW = {
		head="Dampening Tam",neck="Iskur Gorget",ear1="Suppanomimi",ear2="Brutal Earring",
		body="Adhemar Jacket +1",hands="Adhemar Wrist. +1",ring1="Epona's Ring",ring2="Petrov Ring",
		back=gear.tp_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_ta_feet}
    
    sets.engaged.DW.Acc = {
		head="Carmine Mask +1",neck="Combatant's Torque",ear1="Digni. Earring",ear2="Telos Earring",
		body="Malignance Tabard",hands="Floral Gauntlets",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
		back=gear.tp_jse_back,waist="Olseni Belt",legs="Carmine Cuisses +1",feet="Malignance Boots"}
		
    sets.engaged.DW.DT = {
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Brutal Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Petrov Ring",
        back=gear.tp_jse_back,waist="Reiki Yotai",legs="Malignance Tights",feet="Malignance Boots"}
    
    sets.engaged.DW.Acc.DT = {
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Telos Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Ramuh Ring +1",
        back=gear.tp_jse_back,waist="Reiki Yotai",legs="Malignance Tights",feet="Malignance Boots"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    if player.sub_job == 'NIN' then
        set_macro_page(2, 10)
    elseif player.sub_job == 'DNC' then
		set_macro_page(1, 10)
    elseif player.sub_job == 'RNG' then
        set_macro_page(9, 10)
    elseif player.sub_job == 'DRG' then
        set_macro_page(5, 10)
    else
        set_macro_page(10, 10)
    end
end

function user_job_lockstyle()
	if player.equipment.main == nil or player.equipment.main == 'empty' then
		windower.chat.input('/lockstyleset 001')
	elseif res.items[item_name_to_id(player.equipment.main)].skill == 3 then --Sword in main hand.
		if player.equipment.sub == nil or player.equipment.sub == 'empty' then --Sword/Nothing.
				windower.chat.input('/lockstyleset 001')
		elseif res.items[item_name_to_id(player.equipment.sub)].shield_size then --Sword/Shield
				windower.chat.input('/lockstyleset 001')
		elseif res.items[item_name_to_id(player.equipment.sub)].skill == 3 then --Sword/Sword.
			windower.chat.input('/lockstyleset 001')
		elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Sword/Dagger.
			windower.chat.input('/lockstyleset 001')
		else
			windower.chat.input('/lockstyleset 001') --Catchall just in case something's weird.
		end
	elseif res.items[item_name_to_id(player.equipment.main)].skill == 2 then --Dagger in main hand.
		if player.equipment.sub == nil or player.equipment.sub == 'empty' then --Dagger/Nothing.
			windower.chat.input('/lockstyleset 001')
		elseif res.items[item_name_to_id(player.equipment.sub)].shield_size then --Dagger/Shield
			windower.chat.input('/lockstyleset 001')
		elseif res.items[item_name_to_id(player.equipment.sub)].skill == 3 then --Dagger/Sword.
			windower.chat.input('/lockstyleset 001')
		elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Dagger/Dagger.
			windower.chat.input('/lockstyleset 001')
		else
			windower.chat.input('/lockstyleset 001') --Catchall just in case something's weird.
		end
	end
end