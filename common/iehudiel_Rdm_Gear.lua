function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','Acc','FullAcc')
    state.HybridMode:options('Normal','DT')
	state.WeaponskillMode:options('Match','Proc')
	state.AutoBuffMode:options('Off','Auto','AutoMelee')
	state.CastingMode:options('Normal','Resistant', 'Fodder', 'Proc')
    state.IdleMode:options('Normal','PDT','MDT','DTHippo')
    state.PhysicalDefenseMode:options('PDT','NukeLock')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None','Naegling','Sequence','DualWeapons','DualWeaponsAcc','DualEvisceration','DualClubs','DualAeolian','DualProcDaggers','EnspellOnly','SavageBlade')
	
	gear.obi_cure_back = "Tempered Cape +1"
	gear.obi_cure_waist = "Witful Belt"

	gear.obi_low_nuke_back = "Toro Cape"
	gear.obi_low_nuke_waist = "Sekhmet Corset"

	gear.obi_high_nuke_back = "Toro Cape"
	gear.obi_high_nuke_waist = "Refoccilation Stone"

	gear.stp_jse_back = {}
	gear.nuke_jse_back = { back={ name="Sucellos's Cape", augments={'INT+12','Mag. Acc+5 /Mag. Dmg.+5','Magic Damage +2','"Fast Cast"+10','Spell interruption rate down-6%',},}}
	gear.wsd_jse_back = {}

		-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^@!` input /ja "Accession" <me>')
	send_command('bind ^backspace input /ja "Saboteur" <me>')
	send_command('bind !backspace input /ja "Spontaneity" <t>')
	send_command('bind @backspace input /ja "Composure" <me>')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind != input /ja "Penury" <me>')
	send_command('bind @= input /ja "Parsimony" <me>')
	if player.sub_job == 'SCH' then
	  send_command('bind ^delete input /ja "Dark Arts" <me>')
	  send_command('bind !delete input /ja "Addendum: Black" <me>')
	  send_command('bind @delete input /ja "Manifestation" <me>')
	end
	send_command('bind ^\\\\ input /ma "Protect V" <t>')
	send_command('bind @\\\\ input /ma "Shell V" <t>')
	if player.sub_job == 'SCH' or player.sub_job == 'WHM' then
	  send_command('bind !\\\\ input /ma "Reraise" <me>')
	end
	send_command('bind @f10 gs c cycle RecoverMode')
	--send_command('bind ^r gs c set skipprocweapons true;gs c reset weaponskillmode;gs c weapons Default;gs c set unlockweapons false')
	send_command('bind ^q gs c set weapons enspellonly;gs c set unlockweapons true')
	send_command('bind !q gs c set skipprocweapons true;gs c reset weaponskillmode;gs c set weapons none')
	send_command('bind ^d gs c set idlemode pdt')
	send_command('bind ^n gs c set idlemode normal')
	
	select_default_macro_book()
end

function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Chainspell'] = {body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},}
	

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	
	sets.precast.FC = {
		main={ name="Crocea Mors", augments={'Path: C',}},
		sub="Culminus",
		ammo="Staunch Tathlum",
		head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
		body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
		feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+28','"Drain" and "Aspir" potency +1','INT+10','Mag. Acc.+15',}},
		neck="Erra Pendant",
		waist="Witful Belt",
		left_ear="Etiolation Earring",
		right_ear={ name="Leth. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','"Dbl.Atk."+3',}},
		left_ring="Lebeche Ring",
		right_ring="Kishar Ring",
		back={ name="Sucellos's Cape", augments={'INT+12','Mag. Acc+5 /Mag. Dmg.+5','Magic Damage +2','"Fast Cast"+10','Spell interruption rate down-6%',}},
	}
		
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {})
       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		ammo="Ginsen",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Leth. Houseaux +3",
		neck="Anu Torque",
		waist="Sarissapho. Belt",
		left_ear="Sherida Earring",
		right_ear="Ishvara Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Ilabrat Ring",
		back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%','Damage taken-5%',}},
	}
		
	sets.precast.WS.Proc = 	{}
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = {}
	
	sets.precast.WS['Chant Du Cygne'] = {}
		
	sets.precast.WS['Evisceration'] = sets.precast.WS['Chant Du Cygne']

	sets.precast.WS['Savage Blade'] = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Leth. Houseaux +3",
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist="Sarissapho. Belt",
		left_ear="Sherida Earring",
		right_ear="Ishvara Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Ilabrat Ring",
		back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%','Damage taken-5%',}},
	}
		
	sets.precast.WS['Sanguine Blade'] = {
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",
		body="Lethargy Sayon +2",
		hands="Jhakri Cuffs +2",
		legs="Bunzi's Pants",
		feet="Leth. Houseaux +3",
		neck="Sibyl Scarf",
		waist="Carrier's Sash",
		left_ear="Regal Earring",
		right_ear="Ishvara Earring",
		left_ring="Archon Ring",
		right_ring="Jhakri Ring",
		back={ name="Sucellos's Cape", augments={'INT+12','Mag. Acc+5 /Mag. Dmg.+5','Magic Damage +2','"Fast Cast"+10','Spell interruption rate down-6%',}},
	}
		
	sets.precast.WS['Seraph Blade'] = {
		ammo="Pemphredo Tathlum",
		head="Bunzi's Hat",
		body="Lethargy Sayon +2",
		hands="Jhakri Cuffs +2",
		legs="Bunzi's Pants",
		feet="Leth. Houseaux +3",
		neck="Sibyl Scarf",
		waist="Carrier's Sash",
		left_ear="Regal Earring",
		right_ear="Friomisi Earring",
		left_ring="Locus Ring",
		right_ring="Jhakri Ring",
		back={ name="Sucellos's Cape", augments={'INT+12','Mag. Acc+5 /Mag. Dmg.+5','Magic Damage +2','"Fast Cast"+10','Spell interruption rate down-6%',}},
	}
	--sets.precast.WS['Seraph Blade'] = {
	--	ammo="Pemphredo Tathlum",
	--	head="Bunzi's Hat",
	--	body="Lethargy Sayon +2",
	--	hands="Jhakri Cuffs +2",
	--	legs="Bunzi's Pants",
	--	feet="Leth. Houseaux +2",
	--	neck="Sibyl Scarf",
	--	waist="Refoccilation Stone",
	--	left_ear="Regal Earring",
	--	right_ear="Ishvara Earring",
	--	left_ring="Epaminondas's Ring",
	--	right_ring="Jhakri Ring",
	--	back={ name="Sucellos's Cape", augments={'INT+12','Mag. Acc+5 /Mag. Dmg.+5','Magic Damage +2','"Fast Cast"+10','Spell interruption rate down-6%',}},
	--}
		
	sets.precast.WS['Aeolian Edge'] = {}

	-- Midcast Sets

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {}
	
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {
		main={ name="Rubicundity", augments={'Mag. Acc.+9','"Mag.Atk.Bns."+8','Dark magic skill +9','"Conserve MP"+5',}},
		sub="Culminus",
		ammo="Pemphredo Tathlum",
		head="Bunzi's Hat",
		body="Bunzi's Robe",
		hands="Bunzi's Gloves",
		legs={ name="Amalric Slops", augments={'MP+60','"Mag.Atk.Bns."+20','Enmity-5',}},
		feet="Bunzi's Sabots",
		neck="Imbodla Necklace",
		waist="Refoccilation Stone",
		left_ear="Regal Earring",
		right_ear="Friomisi Earring",
		left_ring="Mujin Band",
		right_ring="Locus Ring",
		back={ name="Sucellos's Cape", augments={'INT+12','Mag. Acc+5 /Mag. Dmg.+5','Magic Damage +2','"Fast Cast"+10','Spell interruption rate down-6%',}},
	}
	
	sets.midcast.FastRecast = {}

    sets.midcast.Cure = {
		main={ name="Serenity", augments={'MP+50','Enha.mag. skill +10','"Cure" potency +5%','"Cure" spellcasting time -10%',}},
		sub="Elan Strap +1",
		ammo="Staunch Tathlum",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
		hands={ name="Kaykaus Cuffs", augments={'MP+60','Spell interruption rate down +10%','"Cure" spellcasting time -5%',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+20','Pet: Mag. Acc.+22','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Nodens Gorget",
		waist="Rumination Sash",
		left_ear="Mendi. Earring",
		right_ear="Etiolation Earring",
		left_ring="Lebeche Ring",
		right_ring="Sirona's Ring",
		back="Solemnity Cape",
	}
		
    sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {})
		
		--Cureset for if it's not light weather but is light day.
    sets.midcast.LightDayCure = set_combine(sets.midcast.Cure, {})
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {
		neck="Malison Medallion",
		left_ring="Ephedra Ring",
		right_ring="Ephedra Ring",
	})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})
		
	sets.midcast.Curaga = sets.midcast.Cure
	sets.Self_Healing = sets.midcast.Cure
	sets.Cure_Received = {}
	sets.Self_Refresh = {
		main="Oranyan",
		sub="Enki Strap",
		ammo="Staunch Tathlum",
		head="Befouled Crown",
		body="Atrophy Tabard +3",
		hands="Atrophy Gloves +2",
		legs="Leth. Fuseau +2",
		feet="Leth. Houseaux +3",
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist="Cascade Belt",
		left_ear="Etiolation Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','Latent effect: "Refresh"+1',}},
		left_ring="Kishar Ring",
		right_ring="Vocane Ring",
		back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +7','Enh. Mag. eff. dur. +16',}},
		}

	sets.midcast['Enhancing Magic'] = {
		main={ name="Pukulatmuj +1", augments={'Path: A',}},
		sub="Culminus",
		ammo="Pemphredo Tathlum",
		head="Befouled Crown",
		body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
		hands={ name="Chironic Gloves", augments={'"Subtle Blow"+3','Mag. Acc.+14','Accuracy+6 Attack+6','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet="Leth. Houseaux +3",
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist="Cascade Belt",
		left_ear="Halasz Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Vocane Ring",
		back={ name="Sucellos's Cape", augments={'INT+12','Mag. Acc+5 /Mag. Dmg.+5','Magic Damage +2','"Fast Cast"+10','Spell interruption rate down-6%',}},
	}

	--Atrophy Gloves are better than Lethargy for me despite the set bonus for duration on others.		
	sets.buff.ComposureOther = {
		main={ name="Pukulatmuj +1", augments={'Path: A',}},
		sub="Culminus",
		ammo="Staunch Tathlum",
		head="Befouled Crown",
		body="Lethargy Sayon +2",
		hands="Atrophy Gloves +2",
		legs="Leth. Fuseau +2",
		feet="Leth. Houseaux +3",
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist="Cascade Belt",
		left_ear="Etiolation Earring",
		right_ear="Halasz Earring",
		left_ring="Rahab Ring",
		right_ring="Kishar Ring",
		back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +7','Enh. Mag. eff. dur. +16',}},
	}
		
	--Red Mage enhancing sets are handled in a different way from most, layered on due to the way Composure works
	--Don't set combine a full set with these spells, they should layer on Enhancing Set > Composure (If Applicable) > Spell
	sets.EnhancingSkill = set_combine(sets.midcast['Enhancing Magic'], {
		    main={ name="Pukulatmuj +1", augments={'Path: A',}},
		ammo="Staunch Tathlum",
		head="Befouled Crown",
		body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
		hands="Leth. Gantherots +1",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet="Leth. Houseaux +3",
		neck="Enhancing Torque",
		waist="Cascade Belt",
		left_ear="Etiolation Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','Latent effect: "Refresh"+1',}},
		left_ring="Kishar Ring",
		right_ring="Vocane Ring",
		back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +7','Enh. Mag. eff. dur. +16',}},
		})
	
	sets.midcast.EnhancingDuration = set_combine(sets.EnhancingSkill, {
		main="Oranyan",
		sub="Enki Strap",
        ammo="Pemphredo Tathlum",
        head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +9',}},
        body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
        hands="Atrophy Gloves +2",
        legs={ name="Telchine Braconi", augments={'Mag. Acc.+22','"Cure" spellcasting time -3%','Enh. Mag. eff. dur. +9',}},
        feet="Leth. Houseaux +3",
        neck={ name="Dls. Torque +2", augments={'Path: A',}},
        waist="Cascade Belt",
        left_ear="Etiolation Earring",
		right_ear={ name="Leth. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','"Dbl.Atk."+3',}},
        left_ring="Kishar Ring",
        right_ring="Vocane Ring",
        back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +7','Enh. Mag. eff. dur. +16',}},
   } )
	
	sets.midcast.Refresh = set_combine(sets.Self_Refresh, {main="Oranyan"})
	sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
		head={ name="Chironic Hat", augments={'Mag. Acc.+27','Attack+5','"Store TP"+2','Accuracy+18 Attack+18','Mag. Acc.+18 "Mag.Atk.Bns."+18',}},
	})
	sets.midcast.BarElement = set_combine(sets.midcast.EnhancingDuration, {})
	sets.midcast.Temper = sets.EnhancingSkill
	sets.midcast.Temper.DW = set_combine(sets.midcast.Temper, {})
	sets.midcast.Enspell = sets.midcast.Temper
	sets.midcast.Enspell.DW = set_combine(sets.midcast.Enspell, {
		hands="Aya. Manopolas +2",
		back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +7','Enh. Mag. eff. dur. +16',}},
	})
	sets.midcast.BoostStat = {}
	sets.midcast.Stoneskin = set_combine(sets.EnhancingSkill, {})
	sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {})
	sets.midcast.Shell = set_combine(sets.midcast.EnhancingDuration, {})
	
	sets.midcast['Enfeebling Magic'] = {
		main={ name="Crocea Mors", augments={'Path: C',}},
		sub="Thuellaic Ecu +1",
		ammo="Regal Gem",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Atrophy Tabard +3",
		hands="Leth. Ganth. +3",
		legs={ name="Chironic Hose", augments={'Mag. Acc.+20','Pet: Mag. Acc.+22','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}},
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist="Rumination Sash",
		left_ear="Snotra Earring",
		right_ear={ name="Leth. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','"Dbl.Atk."+3',}},
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Sucellos's Cape", augments={'INT+12','Mag. Acc+5 /Mag. Dmg.+5','Magic Damage +2','"Fast Cast"+10','Spell interruption rate down-6%',}},
	}
		
	sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], {
	})
		
	sets.midcast.DurationOnlyEnfeebling = set_combine(sets.midcast['Enfeebling Magic'], {})
		
	sets.midcast.Silence = set_combine(sets.midcast.DurationOnlyEnfeebling,{right_ring="Kishar Ring",range="Kaja Bow",})
	sets.midcast.Silence.Resistant = sets.midcast['Enfeebling Magic'].Resistant
	sets.midcast.Sleep = set_combine(sets.midcast.DurationOnlyEnfeebling,{right_ring="Kishar Ring",range="Kaja Bow",})
	sets.midcast.Sleep.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant,{})
	sets.midcast.Bind = set_combine(sets.midcast.DurationOnlyEnfeebling,{right_ring="Kishar Ring",range="Kaja Bow",})
	sets.midcast.Bind.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant,{})
	sets.midcast.Break = set_combine(sets.midcast.DurationOnlyEnfeebling,{right_ring="Kishar Ring",range="Kaja Bow",})
	sets.midcast.Break.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant,{})
	
	sets.midcast.Dispel = sets.midcast['Enfeebling Magic'].Resistant
	
	sets.midcast.SkillBasedEnfeebling = set_combine(sets.midcast['Enfeebling Magic'], {})
	
	sets.midcast['Frazzle II'] = sets.midcast['Enfeebling Magic'].Resistant
	sets.midcast['Frazzle III'] = sets.midcast.SkillBasedEnfeebling
	sets.midcast['Frazzle III'].Resistant = sets.midcast['Enfeebling Magic'].Resistant
	
	sets.midcast['Distract III'] = sets.midcast.SkillBasedEnfeebling
	sets.midcast['Distract III'].Resistant = sets.midcast['Enfeebling Magic'].Resistant
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {})
	
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio III'] = set_combine(sets.midcast['Enfeebling Magic'], {})
	
	sets.midcast['Haste'] = set_combine(sets.midcast.EnhancingDuration, {})
	sets.midcast['Haste II'] = set_combine(sets.midcast.EnhancingDuration, {})
	sets.midcast['Flurry II'] = set_combine(sets.midcast.EnhancingDuration, {})
	sets.midcast['Regen'] = set_combine(sets.midcast.EnhancingDuration, {})
	sets.midcast['Regen II'] = set_combine(sets.midcast.EnhancingDuration, {})

    sets.midcast['Elemental Magic'] = set_combine(sets.MagicBurst, {
		head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+29','STR+2','Mag. Acc.+7 "Mag.Atk.Bns."+7',}},
		body={ name="Amalric Doublet", augments={'INT+10','Elem. magic skill +15','Dark magic skill +15',}},
		hands="Bunzi's Gloves",
		legs={ name="Merlinic Shalwar", augments={'"Mag.Atk.Bns."+30','"Fast Cast"+2','MND+8',}},
		feet="Navon Crackows",
	})
		
    sets.midcast['Elemental Magic'].Resistant = {}
		
    sets.midcast['Elemental Magic'].Fodder = {}

    sets.midcast['Elemental Magic'].Proc = {}
		
	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {})
	sets.midcast['Elemental Magic'].HighTierNuke.Fodder = set_combine(sets.midcast['Elemental Magic'].Fodder, {})
		
	sets.midcast.Impact = {}

	sets.midcast['Dark Magic'] = {
		main={ name="Rubicundity", augments={'Mag. Acc.+9','"Mag.Atk.Bns."+8','Dark magic skill +9','"Conserve MP"+5',}},
		sub="Thuellaic Ecu +1",
		ammo="Pemphredo Tathlum",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body={ name="Psycloth Vest", augments={'Mag. Acc.+10','Spell interruption rate down +15%','MND+7',}},
		hands={ name="Chironic Gloves", augments={'"Subtle Blow"+3','Mag. Acc.+14','Accuracy+6 Attack+6','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+20','Pet: Mag. Acc.+22','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+28','"Drain" and "Aspir" potency +1','INT+10','Mag. Acc.+15',}},
		neck="Erra Pendant",
		waist="Fucho-no-Obi",
		left_ear="Choleric Earring",
		right_ear="Halasz Earring",
		left_ring="Excelsis Ring",
		right_ring="Archon Ring",
		back={ name="Sucellos's Cape", augments={'INT+12','Mag. Acc+5 /Mag. Dmg.+5','Magic Damage +2','"Fast Cast"+10','Spell interruption rate down-6%',}},
	}

    sets.midcast.Drain = sets.midcast['Dark Magic']

	sets.midcast.Aspir = sets.midcast.Drain
		
	sets.midcast.Stun = set_combine(sets.midcast['Enfeebling Magic'],{})
		
	sets.midcast.Stun.Resistant = {}

	-- Sets for special buff conditions on spells.
		
	sets.buff.Saboteur = {
		main={ name="Crocea Mors", augments={'Path: C',}},
		sub="Thuellaic Ecu +1",
		ammo="Regal Gem",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Atrophy Tabard +3",
		hands="Leth. Ganth. +3",
		legs="Leth. Fuseau +2",
		feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}},
		neck="Erra Pendant",
		waist="Rumination Sash",
		left_ear="Digni. Earring",
		right_ear="Regal Earring",
		left_ring="Stikini Ring +1",
		right_ring="Kishar Ring",
		back={ name="Sucellos's Cape", augments={'INT+12','Mag. Acc+5 /Mag. Dmg.+5','Magic Damage +2','"Fast Cast"+10','Spell interruption rate down-6%',}},
	}
	
	sets.HPDown = {}
		
    sets.HPCure = {}
	
	sets.buff.Doom = set_combine(sets.midcast.Cursna, {})

	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {
		main={ name="Crocea Mors", augments={'Path: C',}},
		sub="Culminus",
		ammo="Pemphredo Tathlum",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Jhakri Robe +2",
		hands="Aya. Manopolas +2",
		legs={ name="Lengo Pants", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}},
		feet="Nyame Sollerets",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Fucho-no-Obi",
		left_ear="Etiolation Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','Latent effect: "Refresh"+1',}},
		left_ring="Defending Ring",
		right_ring="Vocane Ring",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Store TP"+10','Damage taken-5%',}},
	}
	

	-- Idle sets
	sets.idle = {
		main={ name="Crocea Mors", augments={'Path: C',}},
		sub="Culminus",
		ammo="Pemphredo Tathlum",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Lethargy Sayon +2",
		hands="Leth. Ganth. +3",
		legs={ name="Lengo Pants", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}},
		feet="Nyame Sollerets",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Fucho-no-Obi",
		left_ear="Etiolation Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','Latent effect: "Refresh"+1',}},
		left_ring="Defending Ring",
		right_ring="Vocane Ring",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Store TP"+10','Damage taken-5%',}},
	}
		
	sets.idle.PDT = {
		main={ name="Crocea Mors", augments={'Path: C',}},
		sub="Culminus",
		ammo="Staunch Tathlum",
		head="Nyame Helm",
		body="Lethargy Sayon +2",
		hands="Leth. Ganth. +3",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','Latent effect: "Refresh"+1',}},
		left_ring="Defending Ring",
		right_ring="Vocane Ring",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Store TP"+10','Damage taken-5%',}},
	}
		
	sets.idle.MDT = {
		main={ name="Crocea Mors", augments={'Path: C',}},
		sub="Culminus",
		ammo="Staunch Tathlum",
		head="Nyame Helm",
		body="Lethargy Sayon +2",
		hands="Leth. Ganth. +3",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','Latent effect: "Refresh"+1',}},
		left_ring="Defending Ring",
		right_ring="Vocane Ring",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Store TP"+10','Damage taken-5%',}},
	}
		
	sets.idle.Weak = {
		main={ name="Crocea Mors", augments={'Path: C',}},
		sub="Culminus",
		ammo="Pemphredo Tathlum",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Lethargy Sayon +2",
		hands="Leth. Ganth. +3",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','Latent effect: "Refresh"+1',}},
		left_ring="Defending Ring",
		right_ring="Vocane Ring",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Store TP"+10','Damage taken-5%',}},
	}
	
	sets.idle.DTHippo = set_combine(sets.idle.PDT, {})
	
	-- Defense sets
	sets.defense.PDT = set_combine(sets.idle.PDT, {})

	sets.defense.NukeLock = sets.midcast['Elemental Magic']
		
	sets.defense.MDT = set_combine(sets.idle.MDT, {})
		
    sets.defense.MEVA = {}
		
	sets.Kiting = set_combine( sets.idle.PDT, {legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},})
	sets.latent_refresh = {
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Lethargy Sayon +2",
		waist="Fucho-no-Obi",
	}
	sets.latent_refresh_grip = {}
	sets.TPEat = {}
	sets.DayIdle = {}
	sets.NightIdle = {}
	
	-- Weapons sets
	sets.weapons.Sequence = {}
	sets.weapons.Naegling = {main="Naegling",}
	sets.weapons.Almace = {}
	sets.weapons.DualWeapons = {}
	sets.weapons.DualWeaponsAcc = {}
	sets.weapons.DualEvisceration = {}
	sets.weapons.DualAeolian = {}
	sets.weapons.DualProcDaggers = {
		main="Wind Knife",
		sub="Wind Knife",
	}
	
	sets.weapons.SavageBlade = {
		main="Naegling",		
	}
	sets.weapons.EnspellOnly = {}
	sets.weapons.DualClubs = {}
	sets.weapons.DualBlackHalo = {}
	sets.weapons.DualAlmace = {}
	sets.weapons.DualBow = {}
	sets.weapons.BowMacc = {}
	
    sets.buff.Sublimation = {}
    sets.buff.DTSublimation = {}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.Dagger.Accuracy.Evasion
	
	-- Normal melee group
--	sets.engaged = {ammo="Aurgelmir Orb +1",
--		head="Aya. Zucchetto +2",neck="Asperity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
--		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Petrov Ring",ring2="Ilabrat Ring",
--		back=gear.stp_jse_back,waist="Windbuffet Belt +1",legs="Carmine Cuisses +1",feet="Carmine Greaves +1"}


	sets.engaged = {			
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Aya. Zucchetto +2",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Jhakri Slops +2",
		feet="Nyame Sollerets",
		neck="Anu Torque",
		waist="Kentarch Belt",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Petrov Ring",
		right_ring="Chirich Ring",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Store TP"+10','Damage taken-5%',}},
	}
	
	
	
	
	sets.engaged.EnspellOnly = set_combine(sets.engaged, {
		hands="Aya. Manopolas +2",
	})
	

	
	sets.engaged.Acc = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Aya. Zucchetto +2",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Jhakri Slops +2",
		feet="Nyame Sollerets",
		neck="Anu Torque",
		waist="Kentarch Belt",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Petrov Ring",
		right_ring="Chirich Ring",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Store TP"+10','Damage taken-5%',}},
	}
	



	sets.engaged.FullAcc = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Aya. Zucchetto +2",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Jhakri Slops +2",
		feet="Nyame Sollerets",
		neck="Anu Torque",
		waist="Kentarch Belt",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Petrov Ring",
		right_ring="Chirich Ring",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Store TP"+10','Damage taken-5%',}},
	}


	
	sets.engaged.DT = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Nyame Helm",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Jhakri Slops +2",
		feet="Nyame Sollerets",
		neck="Anu Torque",
		waist="Kentarch Belt",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Petrov Ring",
		right_ring="Chirich Ring",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Store TP"+10','Damage taken-5%',}},
	}
			

	sets.engaged.Acc.DT = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Nyame Helm",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Jhakri Slops +2",
		feet="Nyame Sollerets",
		neck="Anu Torque",
		waist="Kentarch Belt",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Petrov Ring",
		right_ring="Chirich Ring",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Store TP"+10','Damage taken-5%',}},
	}
		
	sets.engaged.FullAcc.DT = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Nyame Helm",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Jhakri Slops +2",
		feet="Nyame Sollerets",
		neck="Anu Torque",
		waist="Kentarch Belt",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Petrov Ring",
		right_ring="Chirich Ring",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Store TP"+10','Damage taken-5%',}},
	}
		
	sets.engaged.DW = sets.engaged
		
	sets.engaged.DW.Acc = sets.engaged
		
	sets.engaged.DW.FullAcc = sets.engaged
		
	sets.engaged.DW.DT = sets.engaged
		
	sets.engaged.DW.Acc.DT = sets.engaged
		
	sets.engaged.DW.FullAcc.DT = sets.engaged
end

-- Select default macro book on initial load or subjob change.
-- Default macro set/book
function select_default_macro_book()
	if player.sub_job == 'DNC' then
		set_macro_page(4, 9)
	elseif player.sub_job == 'NIN' then
		set_macro_page(4, 9)
	elseif player.sub_job == 'BLM' then
		set_macro_page(2, 9)
	elseif player.sub_job == 'SCH' then
	    set_macro_page(1, 9)
	else
		set_macro_page(1, 9)
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
					windower.chat.input('/ma "Yoran-Oran (UC)" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[984] < spell_latency and not have_trust("August") then
					windower.chat.input('/ma "August" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[967] < spell_latency and not have_trust("Qultada") then
					windower.chat.input('/ma "Qultada" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[914] < spell_latency and not have_trust("Ulmia") then
					windower.chat.input('/ma "Ulmia" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[979] < spell_latency and not have_trust("Selh'teus") then
					windower.chat.input('/ma "Selh\'teus" <me>')
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

function user_job_buff_change(buff, gain)
	if buff:startswith('Addendum: ') or buff:endswith(' Arts') then
		style_lock = true
	end
end

function user_job_lockstyle()
	if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
		if player.equipment.main == nil or player.equipment.main == 'empty' then
			windower.chat.input('/lockstyleset 074')
		elseif res.items[item_name_to_id(player.equipment.main)].skill == 3 then --Sword in main hand.
			if res.items[item_name_to_id(player.equipment.sub)].skill == 3 then --Sword/Sword.
				windower.chat.input('/lockstyleset 074')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Sword/Dagger.
				windower.chat.input('/lockstyleset 074')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 11 then --Sword/Club.
				windower.chat.input('/lockstyleset 074')
			else
				windower.chat.input('/lockstyleset 074') --Catchall
			end
		elseif res.items[item_name_to_id(player.equipment.main)].skill == 2 then --Dagger in main hand.
			if res.items[item_name_to_id(player.equipment.sub)].skill == 3 then --Dagger/Sword.
				windower.chat.input('/lockstyleset 074')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Dagger/Dagger.
				windower.chat.input('/lockstyleset 074')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 11 then --Dagger/Club.
				windower.chat.input('/lockstyleset 074')
			else
				windower.chat.input('/lockstyleset 074') --Catchall
			end
		elseif res.items[item_name_to_id(player.equipment.main)].skill == 11 then --Club in main hand.
			if res.items[item_name_to_id(player.equipment.sub)].skill == 3 then --Club/Sword.
				windower.chat.input('/lockstyleset 074')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Club/Dagger.
				windower.chat.input('/lockstyleset 074')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 11 then --Club/Club.
				windower.chat.input('/lockstyleset 074')
			else
				windower.chat.input('/lockstyleset 074') --Catchall
			end
		end
	elseif player.sub_job == 'WHM' or state.Buff['Light Arts'] or state.Buff['Addendum: White'] then
		windower.chat.input('/lockstyleset 074')
	elseif player.sub_job == 'BLM' or state.Buff['Dark Arts'] or state.Buff['Addendum: Black'] then
		windower.chat.input('/lockstyleset 074')
	else
		windower.chat.input('/lockstyleset 074')
	end
end