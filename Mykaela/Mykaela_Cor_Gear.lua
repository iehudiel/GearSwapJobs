-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'None')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc','Proc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'DWMax'}

    gear.RAbullet = "Chrono Bullet"
    gear.WSbullet = "Chrono Bullet"
    gear.MAbullet = "Orichalc. Bullet" --For MAB WS, do not put single-use bullets here.
    gear.QDbullet = "Animikii Bullet"
    options.ammo_warning_limit = 15

	gear.tp_ranger_jse_back = {}
	gear.snapshot_jse_back = { name="Camulus's Mantle", augments={'"Snapshot"+10',}}
	gear.tp_jse_back = {name="Camulus's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}}
	gear.ranger_wsd_jse_back = { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+9','Weapon skill damage +10%',}}
	gear.magic_wsd_jse_back = {name="Camulus's Mantle",augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
	gear.str_wsd_jse_back = {name="Camulus's Mantle",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	
    -- Additional local binds
	send_command('bind !f11 gs c cycle ExtraMeleeMode')
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

	send_command('bind !r gs c weapons SingleWeapon;gs c update')
	send_command('bind @q gs c weapons MaccWeapons;gs c update')
	send_command('bind ^q gs c weapons DualRangedWeapons;gs c update')
	send_command('bind !q gs c weapons SavageWeapons;gs c update')
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
	
	sets.precast.JA['Triple Shot'] = {body="Chasseur's Frac +1"}
    sets.precast.JA['Snake Eye'] = {legs="Lanun Culottes +1"}
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +1"}
    sets.precast.JA['Random Deal'] = {body="Lanun Frac +1"}
    sets.precast.FoldDoubleBust = {hands="Lanun Gants +1"}
    
    sets.precast.CorsairRoll = {
        head="Lanun Tricorne +1",neck="Regal Necklace",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Lanun Frac +1",hands="Chasseur's Gants +1",ring1="Defending Ring",ring2="Dark Ring",
        back=gear.tp_jse_back,waist="Flume Belt",legs="Desultor Tassets",feet=gear.herculean_dt_feet}
		
    sets.precast.LuzafRing = {ring2="Luzaf's Ring"}
    
    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chas. Culottes +1"})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chass. Bottes +1"})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chass. Tricorne"})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +1"})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +1"})
    
    sets.precast.CorsairShot = {ammo=gear.QDbullet,
        head=gear.herculean_nuke_head,neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Crematio Earring",
        body="Samnuha Coat",hands="Leyline Gloves",ring1="Ilabrat Ring",ring2="Shiva Ring +1",
        back=gear.ranger_wsd_jse_back,waist="Eschan Stone",legs="Mummu Kecks +1",feet="Chass. Bottes +1"}
	
    sets.precast.CorsairShot.Proc = {ammo=gear.RAbullet,
        head="Wh. Rarab Cap +1",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Sanare Earring",
        body="Emet Harness +1",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Dark Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Carmine Cuisses +1",feet="Chass. Bottes +1"}

    sets.precast.CorsairShot['Light Shot'] = {ammo=gear.QDbullet,
        head="Carmine Mask +1",neck="Sanctity Necklace",ear1="Digni. Earring",ear2="Telos Earring",
        body="Mummu Jacket +1",hands="Leyline Gloves",ring1="Stikini Ring",ring2="Stikini Ring",
        back=gear.ranger_wsd_jse_back,waist="Eschan Stone",legs="Mummu Kecks +1",feet="Mummu Gamash. +1"}

    sets.precast.CorsairShot['Dark Shot'] = set_combine(sets.precast.CorsairShot['Light Shot'], {feet="Chass. Bottes +1"})

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Carmine Mask +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body=gear.herculean_waltz_body,hands=gear.herculean_waltz_hands,ring1="Defending Ring",ring2="Valseur's Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Dashing Subligar",feet=gear.herculean_waltz_feet}
		
	sets.Self_Waltz = {head="Mummu Bonnet +1",body="Passion Jacket",ring1="Asklepian Ring"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
        head="Carmine Mask +1",neck="Baetyl Pendant",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
        body="Dread Jupon",hands="Leyline Gloves",ring1="Kishar Ring",ring2="Lebeche Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Rawhide Trousers",feet="Carmine Greaves +1"}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})
	
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {ear2="Mendi. Earring"})

    sets.precast.RA = {ammo=gear.RAbullet,
        head="Chass. Tricorne +1",
        body="Laksa. Frac +3",hands="Carmine Fin. Ga. +1",
        back=gear.snapshot_jse_back,waist="Impulse Belt",legs="Laksa. Trews +3",feet="Meg. Jam. +2"}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Meghanada Visor +2",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Telos Earring",
        body="Laksa. Frac +3",hands="Meg. Gloves +2",ring1="Regal Ring",ring2="Karieyh Ring",
        back=gear.str_wsd_jse_back,waist="Fotia Belt",legs="Meg. Chausses +2",feet="Meg. Jam. +2"}
		
    sets.precast.WS.Acc = {
        head="Carmine Mask +1",neck="Combatant's Torque",ear1="Digni. Earring",ear2="Telos Earring",
        body="Meg. Cuirie +2",hands="Meg. Gloves +2",ring1="Regal Ring",ring2="Karieyh Ring",
        back=gear.str_wsd_jse_back,waist="Grunfeld Rope",legs="Carmine Cuisses +1",feet=gear.herculean_acc_feet}		
		
    sets.precast.WS.Proc = {
        head="Carmine Mask +1",neck="Combatant's Torque",ear1="Digni. Earring",ear2="Zennaroi Earring",
        body="Mummu Jacket +1",hands="Floral Gauntlets",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back=gear.tp_jse_back,waist="Olseni Belt",legs="Carmine Cuisses +1",feet=gear.herculean_acc_feet}
		
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {head="Carmine Mask +1",ring2="Rufescent Ring",legs="Carmine Cuisses +1",feet="Carmine Greaves +1"})
	
	sets.precast.WS['Savage Blade'] = {ammo=gear.WSbullet,
        head="Lilitu Headpiece",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Ishvara Earring",
        body="Laksa. Frac +3",hands="Meg. Gloves +2",ring1="Regal Ring",ring2="Ifrit Ring +1",
        back=gear.str_wsd_jse_back,waist="Grunfeld Rope",legs=gear.herculean_wsd_legs,feet=gear.herculean_wsd_feet}

    sets.precast.WS['Savage Blade'].Acc = {ammo=gear.WSbullet,
        head="Carmine Mask +1",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Telos Earring",
        body="Meg. Cuirie +2",hands="Meg. Gloves +2",ring1="Regal Ring",ring2="Rufescent Ring",
        back=gear.str_wsd_jse_back,waist="Grunfeld Rope",legs="Carmine Cuisses +1",feet=gear.herculean_wsd_feet}
	
    sets.precast.WS['Last Stand'] = {ammo=gear.WSbullet,
        head="Meghanada Visor +2",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Telos Earring",
        body="Laksa. Frac +3",hands="Meg. Gloves +2",ring1="Regal Ring",ring2="Dingir Ring",
        back=gear.ranger_wsd_jse_back,waist="Fotia Belt",legs="Meg. Chausses +2",feet="Meg. Jam +2"}

    sets.precast.WS['Last Stand'].Acc = {ammo=gear.WSbullet,
        head="Meghanada Visor +2",neck="Iskur Gorget",ear1="Moonshade Earring",ear2="Telos Earring",
        body="Laksa. Frac +3",hands="Meg. Gloves +2",ring1="Regal Ring",ring2="Dingir Ring",
        back=gear.ranger_wsd_jse_back,waist="Fotia Belt",legs="Meg. Chausses +2",feet="Meg. Jam +2"}
		
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
	
    sets.precast.WS['Leaden Salute'] = {ammo=gear.MAbullet,
        head="Pixie Hairpin +1",neck="Baetyl Pendant",ear1="Moonshade Earring",ear2="Friomisi Earring",
        body="Laksa. Frac +3",hands="Carmine Fin. Ga. +1",ring1="Dingir Ring",ring2="Archon Ring",
        back=gear.magic_wsd_jse_back,waist="Eschan Stone",legs="Laksa. Trews +3",feet=gear.herculean_nuke_feet}

    sets.precast.WS['Leaden Salute'].Acc = {ammo=gear.MAbullet,
        head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Moonshade Earring",ear2="Friomisi Earring",
        body="Laksa. Frac +3",hands="Leyline Gloves",ring1="Dingir Ring",ring2="Archon Ring",
        back=gear.magic_wsd_jse_back,waist="Eschan Stone",legs="Laksa. Trews +3",feet=gear.herculean_nuke_feet}

    sets.precast.WS['Wildfire'] = {ammo=gear.MAbullet,
        head=gear.herculean_nuke_head,neck="Baetyl Pendant",ear1="Crematio Earring",ear2="Friomisi Earring",
        body="Laksa. Frac +3",hands="Carmine Fin. Ga. +1",ring1="Regal Ring",ring2="Dingir Ring",
        back=gear.magic_wsd_jse_back,waist="Eschan Stone",legs="Laksa. Trews +3",feet=gear.herculean_nuke_feet}

    sets.precast.WS['Wildfire'].Acc = {ammo=gear.MAbullet,
        head=gear.herculean_nuke_head,neck="Sanctity Necklace",ear1="Crematio Earring",ear2="Friomisi Earring",
        body="Laksa. Frac +3",hands="Leyline Gloves",ring1="Regal Ring",ring2="Dingir Ring",
        back=gear.magic_wsd_jse_back,waist="Eschan Stone",legs="Laksa. Trews +3",feet=gear.herculean_nuke_feet}
		
    sets.precast.WS['Hot Shot'] = sets.precast.WS['Wildfire']
    sets.precast.WS['Hot Shot'].Acc = sets.precast.WS['Wildfire'].Acc
		
		--Because omen skillchains.
    sets.precast.WS['Burning Blade'] = {ammo=gear.RAbullet,
        head="Meghanada Visor +2",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Sanare Earring",
        body="Meg. Cuirie +2",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Dark Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Meg. Chausses +2",feet="Meg. Jam. +2"}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.precast.MaxTP = {}
	sets.precast.AccMaxTP = {}
        
    -- Midcast Sets
    sets.midcast.FastRecast = {
        head="Carmine Mask +1",neck="Baetyl Pendant",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
        body="Dread Jupon",hands="Leyline Gloves",ring1="Kishar Ring",ring2="Lebeche Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Rawhide Trousers",feet="Carmine Greaves +1"}
        
    -- Specific spells

	sets.midcast.Cure = {
        head="Carmine Mask +1",neck="Phalaina Locket",ear1="Enchntr. Earring +1",ear2="Mendi. Earring",
        body="Dread Jupon",hands="Leyline Gloves",ring1="Sirona's Ring",ring2="Lebeche Ring",
        back="Solemnity Cape",waist="Flume Belt",legs="Carmine Cuisses +1",feet="Carmine Greaves +1"}
	
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Recieved = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	
    sets.midcast.Utsusemi = sets.midcast.FastRecast

    -- Ranged gear
    sets.midcast.RA = {ammo=gear.RAbullet,
        head="Meghanada Visor +2",neck="Iskur Gorget",ear1="Enervating Earring",ear2="Telos Earring",
        body="Laksa. Frac +3",hands="Carmine Fin. Ga. +1",ring1="Regal Ring",ring2="Dingir Ring",
        back=gear.ranger_wsd_jse_back,waist="Yemaya Belt",legs="Adhemar Kecks",feet="Meg. Jam. +2"}

    sets.midcast.RA.Acc = {ammo=gear.RAbullet,
        head="Meghanada Visor +2",neck="Iskur Gorget",ear1="Enervating Earring",ear2="Telos Earring",
        body="Laksa. Frac +3",hands="Meg. Gloves +2",ring1="Regal Ring",ring2="Dingir Ring",
        back=gear.ranger_wsd_jse_back,waist="Yemaya Belt",legs="Meg. Chausses +2",feet="Meg. Jam. +2"}
		
	sets.buff['Triple Shot'] = {body="Chasseur's Frac +1"}
    
    -- Sets to return to when not performing an action.
	
	sets.DayIdle = {}
	sets.NightIdle = {}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets
    sets.idle = {ammo=gear.RAbullet,
        head="Meghanada Visor +2",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Sanare Earring",
        body="Meg. Cuirie +2",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Karieyh Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Carmine Cuisses +1",feet=gear.herculean_dt_feet}
		
    sets.idle.Refresh = {ammo=gear.RAbullet,
        head="Rawhide Mask",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Ethereal Earring",
        body="Mekosu. Harness",hands=gear.herculean_refresh_hands,ring1="Defending Ring",ring2="Karieyh Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Rawhide Trousers",feet=gear.herculean_dt_feet}
    
    -- Defense sets
    sets.defense.PDT = {ammo=gear.RAbullet,
        head="Meghanada Visor +2",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Sanare Earring",
        body="Meg. Cuirie +2",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Dark Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Meg. Chausses +2",feet=gear.herculean_dt_feet}

    sets.defense.MDT = {ammo=gear.RAbullet,
        head="Meghanada Visor +2",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Meg. Cuirie +2",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Dark Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Meg. Chausses +2",feet="Ahosi Leggings"}
		
    sets.defense.MEVA = {ammo=gear.RAbullet,
        head="Meghanada Visor +2",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Meg. Cuirie +2",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Dark Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Meg. Chausses +2",feet="Ahosi Leggings"}

    sets.Kiting = {legs="Carmine Cuisses +1"}
	
	sets.Weapons = {main="Fettering Blade",sub="Blurred Knife +1",range="Fomalhaut"}
	sets.SavageWeapons = {main="Hep. Sapara +1",sub="Blurred Knife +1",range="Ataktos"}
	sets.SingleWeapon = {main="Fettering Blade",sub="Nusku Shield"}
	sets.DualRangedWeapons = {main="Fettering Blade",sub="Kustawi +1"}
	sets.LeadenWeapons = {main="Fettering Blade",sub="Atoyac"}
	sets.RollWeapons = {range="Compensator"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {feet=gear.herculean_treasure_feet})
	
	sets.DWMax = {ear1="Dudgeon Earring",ear2="Heartseeker Earring",body="Adhemar Jacket",hands="Floral Gauntlets",waist="Reiki Yotai"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
		head="Dampening Tam",neck="Iskur Gorget",ear1="Cessance Earring",ear2="Brutal Earring",
		body="Meg. Cuirie +2",hands="Adhemar Wristbands",ring1="Epona's Ring",ring2="Petrov Ring",
		back=gear.tp_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_ta_feet}
    
    sets.engaged.Acc = {
		head="Dampening Tam",neck="Combatant's Torque",ear1="Cessance Earring",ear2="Telos Earring",
		body="Meg. Cuirie +2",hands="Adhemar Wristbands",ring1="Epona's Ring",ring2="Petrov Ring",
		back=gear.tp_jse_back,waist="Olseni Belt",legs="Samnuha Tights",feet=gear.herculean_acc_feet}

    sets.engaged.DW = {
		head="Dampening Tam",neck="Asperity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
		body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Epona's Ring",ring2="Petrov Ring",
		back=gear.tp_jse_back,waist="Reiki Yotai",legs="Samnuha Tights",feet=gear.herculean_ta_feet}
    
    sets.engaged.DW.Acc = {
		head="Dampening Tam",neck="Combatant's Torque",ear1="Digni. Earring",ear2="Telos Earring",
		body="Meg. Cuirie +2",hands="Floral Gauntlets",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
		back=gear.tp_jse_back,waist="Reiki Yotai",legs="Meg. Chausses +2",feet=gear.herculean_acc_feet}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    if player.sub_job == 'NIN' then
        set_macro_page(2, 11)
    elseif player.sub_job == 'DNC' then
		set_macro_page(1, 11)
    elseif player.sub_job == 'RNG' then
        set_macro_page(9, 11)
    else
        set_macro_page(10, 11)
    end   


end