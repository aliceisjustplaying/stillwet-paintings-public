-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{
  size = 800,
  aspect = 1.33333333,
  linen = {18, 14},
  seed = 1885,
  ground = {
    {
      pile = {{"lead white", 10}, {"raw umber", 1.8}, {"yellow ochre", 0.8}},
      um = 45,
      apply = "brush",
      texture = 0.15
    }
  }
}
print("Canvas initialized: W=" .. W .. ", H=" .. H)

--@ chunk 2
-- Underdrawing with pencil and chalk
c = chalk()
h = pencil("HB")

-- 1. Horizon & Desert Canyon Topography
h:line({{0, 440}, {250, 430}, {500, 445}, {750, 435}, {1000, 440}}, {pressure=0.35})
-- Distant rugged mesas / buttes
h:sketch({{0, 360}, {120, 320}, {220, 330}, {340, 380}}, {pressure=0.3, wander=4})
h:sketch({{720, 380}, {840, 340}, {930, 350}, {1000, 370}}, {pressure=0.3, wander=4})

-- 2. Cowboy Anatomy & Gestures
-- Hat & Head (centered around x=265, y=320)
c:line({{190, 325}, {240, 310}, {300, 305}, {345, 325}, {290, 332}, {220, 330}, {190, 325}}, {pressure=0.6}) -- hat brim
c:sketch({{240, 310}, {248, 275}, {285, 272}, {295, 305}}, {pressure=0.5}) -- hat crown
c:sketch({{250, 325}, {260, 355}, {278, 355}, {282, 330}}, {pressure=0.5}) -- face / jaw / bandana
-- Torso & Duster coat
c:sketch({{245, 355}, {225, 410}, {215, 490}, {200, 560}}, {pressure=0.5}) -- back contour
c:sketch({{275, 360}, {290, 420}, {280, 510}}, {pressure=0.5}) -- chest / belt
-- Gun Arm extended forward
c:line({{285, 380}, {345, 385}, {410, 388}, {450, 390}}, {pressure=0.7}) -- top of arm
c:line({{280, 405}, {340, 405}, {405, 405}, {445, 400}}, {pressure=0.6}) -- bottom of arm
-- Revolver / Heavy Colt
c:line({{445, 385}, {490, 385}, {490, 405}, {445, 405}, {445, 385}}, {pressure=0.8}) -- barrel and cylinder
c:line({{445, 405}, {440, 430}, {455, 432}, {458, 410}}, {pressure=0.7}) -- grip
-- Left bracing arm
c:sketch({{245, 375}, {265, 420}, {310, 430}, {340, 410}}, {pressure=0.5})
-- Coat tails billowing back
c:sketch({{200, 560}, {145, 630}, {120, 680}}, {pressure=0.6})
c:sketch({{230, 550}, {180, 650}, {165, 710}}, {pressure=0.5})
-- Legs & Boots
c:line({{230, 540}, {210, 610}, {195, 685}, {180, 710}, {215, 715}, {225, 685}, {240, 610}}, {pressure=0.6}) -- back leg
c:line({{275, 530}, {305, 600}, {320, 675}, {310, 715}, {345, 715}, {345, 675}, {315, 590}}, {pressure=0.6}) -- front leg

-- 3. Zombie Anatomy & Gestures
-- Head snapped back in shock (x=730..800, y=260..340)
c:sketch({{735, 335}, {750, 270}, {795, 275}, {810, 330}, {775, 360}, {740, 345}}, {pressure=0.6}) -- skull contour
c:line({{745, 330}, {765, 340}, {785, 330}}, {pressure=0.6}) -- gaping mouth
c:line({{740, 305}, {755, 305}}, {pressure=0.5}) -- hollow eye socket
-- Wild ragged hair strands
h:sketch({{765, 270}, {790, 240}, {820, 255}}, {pressure=0.4})
h:sketch({{795, 280}, {835, 275}, {845, 310}}, {pressure=0.4})
-- Torso bucking under blast impact (x=660..760, y=360..510)
c:sketch({{750, 360}, {765, 430}, {755, 510}}, {pressure=0.6}) -- back contour
c:sketch({{710, 370}, {670, 420}, {680, 510}}, {pressure=0.6}) -- blasted chest / ribcage
-- Flailing left arm (flung back)
c:line({{765, 375}, {820, 340}, {865, 310}, {880, 315}}, {pressure=0.6})
-- Reaching right arm (clawing forward toward blast)
c:line({{690, 385}, {640, 410}, {595, 425}, {585, 415}}, {pressure=0.7})
-- Legs
c:line({{685, 510}, {675, 590}, {680, 670}, {665, 710}, {700, 715}, {710, 665}, {705, 585}}, {pressure=0.6}) -- forward shambling leg
c:line({{745, 510}, {760, 595}, {780, 670}, {780, 710}, {810, 705}, {800, 660}, {775, 580}}, {pressure=0.6}) -- trailing leg

-- 4. Blast Core & Shockwave (x=490..620, y=360..440)
h:sketch({{490, 395}, {525, 375}, {575, 390}, {615, 395}, {570, 415}, {520, 415}, {490, 395}}, {pressure=0.4})

print("Underdrawing completed.")

--@ chunk 3
-- Fix underdrawing
fix()

-- Define palette piles for lean lay-in
p_night_sky = pile{{"bone black", 3.5}, {"raw umber", 2.5}, {"ultramarine blue", 4.0}, turps=0.55}
p_mesa = pile{{"raw umber", 4.5}, {"bone black", 3.5}, {"burnt sienna", 2.0}, turps=0.5}
p_ground_lean = pile{{"raw umber", 4.5}, {"yellow ochre", 2.2}, {"bone black", 2.5}, {"burnt sienna", 1.5}, turps=0.5}

-- Figure & blast reservation polygons
-- Cowboy bounding mask
m_cowboy_shape = poly({
  {180, 270}, {350, 270}, {360, 340}, {495, 380}, {495, 415},
  {445, 440}, {360, 440}, {350, 725}, {170, 725}, {110, 680},
  {180, 540}, {210, 360}
}, true)

-- Zombie bounding mask
m_zombie_shape = poly({
  {570, 410}, {635, 380}, {725, 240}, {860, 240}, {890, 325},
  {820, 370}, {815, 725}, {650, 725}, {650, 520}, {570, 450}
}, true)

-- Blast core reservation (includes expanding fiery cone)
m_blast_reserve = poly({
  {460, 385}, {540, 330}, {640, 350}, {670, 410}, {640, 460},
  {560, 480}, {480, 430}
}, true)

-- Mesa silhouetted shapes
m_mesas_left = poly({{0, 440}, {0, 360}, {120, 320}, {220, 330}, {340, 390}, {340, 440}}, true)
m_mesas_right = poly({{700, 440}, {720, 380}, {840, 340}, {930, 350}, {1000, 370}, {1000, 440}}, true)
m_mesas = m_mesas_left + m_mesas_right

-- Sky mask (above mesas and horizon, outside figures and blast)
m_sky = above({{0, 440}, {1000, 440}}) - m_mesas - m_cowboy_shape - m_zombie_shape - m_blast_reserve

-- Ground mask (below horizon, outside figures and blast)
m_ground = below({{0, 440}, {1000, 440}}) - m_cowboy_shape - m_zombie_shape - m_blast_reserve

-- Lay in the sky: broad strokes across, atmospheric cool dark
work(m_sky, {hand="broad", pile=p_night_sky, coverage=1.2, angle=-0.08, edge="soft"})

-- Lay in mesas: slightly darker, warmer earth silhouette against sky
work(m_mesas - m_cowboy_shape - m_zombie_shape, {hand="body", pile=p_mesa, coverage=1.2, angle=0.05, edge="firm"})

-- Lay in the desert floor: lean earthy umber/ochre wash
work(m_ground, {hand="broad", pile=p_ground_lean, coverage=1.15, angle=0.03, edge="soft"})

print("Background lean lay-in applied successfully.")

--@ chunk 4
-- Campaign 2: Laying in Cowboy, Zombie, and Blast Core

-- 1. Palette additions
p_hat_dark = pile{{"bone black", 5.0}, {"raw umber", 3.0}, {"burnt sienna", 1.0}, turps=0.3}
p_cowboy_coat = pile{{"raw umber", 4.0}, {"bone black", 3.0}, {"burnt sienna", 2.0}, turps=0.3}
p_cowboy_denim = pile{{"bone black", 4.0}, {"ultramarine blue", 3.0}, {"raw umber", 2.0}, turps=0.3}
p_bandana = pile{{"red earth", 3.5}, {"raw umber", 2.0}, {"burnt sienna", 1.5}, turps=0.3}
p_gun_steel = pile{{"bone black", 5.0}, {"lead white", 1.5}, {"cobalt blue", 0.8}, turps=0.2}

p_zombie_coat = pile{{"bone black", 4.0}, {"raw umber", 3.5}, {"green earth", 2.5}, turps=0.3}
p_zombie_flesh = pile{{"green earth", 3.0}, {"raw umber", 2.0}, {"yellow ochre", 2.0}, {"lead white", 1.5}, turps=0.3}
p_zombie_maw = pile{{"bone black", 6.0}, {"burnt sienna", 2.5}, {"cadmium red", 1.0}, turps=0.2}
p_zombie_pants = pile{{"raw umber", 5.0}, {"bone black", 3.0}, {"yellow ochre", 1.5}, turps=0.3}
p_blast_radiant = pile{{"cadmium yellow", 4.0}, {"deep cadmium", 3.0}, {"orange vermilion", 2.0}, {"lead white", 1.5}}
p_blast_outer = pile{{"deep cadmium", 3.0}, {"Mars orange", 3.0}, {"raw sienna", 2.0}, turps=0.3}
p_ground_glow = pile{{"raw umber", 3.0}, {"yellow ochre", 4.0}, {"Mars orange", 2.0}, turps=0.4}

-- 2. COWBOY BLOCK-IN
-- Hat Crown & Brim
m_hat_crown = poly({{235, 310}, {245, 265}, {295, 265}, {295, 310}}, true)
m_hat_brim = poly({{180, 325}, {230, 305}, {310, 305}, {355, 325}, {290, 335}, {220, 332}}, true)
work(m_hat_crown + m_hat_brim, {hand="body", pile=p_hat_dark, coverage=1.3, angle=0.1, edge="firm"})

-- Bandana & Face
m_bandana_shape = poly({{245, 325}, {285, 325}, {280, 360}, {255, 370}, {242, 350}}, true)
work(m_bandana_shape, {hand="detail", pile=p_bandana, coverage=1.2, angle=0.4})

-- Duster Torso, Arms & Billowing Tails
m_duster_torso = poly({
  {240, 350}, {285, 350}, {305, 410}, {285, 520}, {210, 520}, {220, 420}
}, true)
m_duster_tails = poly({
  {210, 520}, {240, 530}, {180, 660}, {120, 685}, {135, 620}, {185, 545}
}, true)
m_gun_arm = poly({
  {285, 375}, {350, 380}, {440, 385}, {440, 410}, {345, 415}, {285, 410}
}, true)
m_left_arm = poly({
  {235, 380}, {260, 425}, {300, 435}, {295, 415}, {255, 400}, {235, 385}
}, true)
work(m_duster_torso + m_duster_tails + m_gun_arm + m_left_arm, {hand="body", pile=p_cowboy_coat, coverage=1.25, angle=0.6, edge="firm"})

-- Trousers & Boots
m_cowboy_legs = poly({
  {215, 520}, {280, 520}, {320, 600}, {335, 715}, {300, 715}, {295, 610},
  {245, 610}, {225, 715}, {190, 715}, {205, 610}
}, true)
work(m_cowboy_legs, {hand="body", pile=p_cowboy_denim, coverage=1.2, angle=1.4, edge="firm"})

-- Gun (Colt Heavy Revolver)
m_revolver = poly({
  {435, 386}, {485, 386}, {485, 404}, {455, 404}, {452, 430}, {438, 428}, {440, 402}, {435, 395}
}, true)
work(m_revolver, {hand="detail", pile=p_gun_steel, coverage=1.4, angle=0.0, edge="firm"})

-- 3. ZOMBIE BLOCK-IN
-- Head & Jaw
m_zombie_skull = poly({
  {730, 335}, {745, 265}, {795, 265}, {815, 320}, {780, 365}, {740, 350}
}, true)
work(m_zombie_skull, {hand="body", pile=p_zombie_flesh, coverage=1.3, angle=-0.5, edge="firm"})

-- Sunken eye socket & Gaping Maw
m_zombie_features = poly({{740, 315}, {775, 328}, {775, 350}, {745, 345}}, true) + ellipse(748, 298, 8, 12)
work(m_zombie_features, {hand="detail", pile=p_zombie_maw, coverage=1.4, angle=0.2})

-- Wild ragged hair strands
m_zombie_hair = poly({{745, 265}, {775, 235}, {835, 245}, {845, 305}, {810, 275}}, true)
work(m_zombie_hair, {hand="detail", pile=p_hat_dark, coverage=1.3, angle=0.4})

-- Torso & Rotted Coat
m_zombie_torso = poly({
  {725, 360}, {765, 365}, {780, 435}, {765, 520}, {675, 520}, {665, 425}, {710, 375}
}, true)
work(m_zombie_torso, {hand="body", pile=p_zombie_coat, coverage=1.25, angle=-0.4, edge="firm"})

-- Blasted ruptured chest core
m_chest_impact = poly({{665, 405}, {725, 395}, {735, 445}, {680, 465}}, true)
work(m_chest_impact, {hand="body", pile=p_zombie_maw, coverage=1.3, angle=0.2})

-- Arms: Reaching Right Arm & Flung-back Left Arm
m_zombie_reach_arm = poly({
  {685, 385}, {635, 410}, {575, 422}, {575, 435}, {635, 425}, {680, 415}
}, true)
m_zombie_flung_arm = poly({
  {765, 375}, {825, 340}, {880, 305}, {885, 320}, {830, 360}, {775, 400}
}, true)
work(m_zombie_reach_arm, {hand="body", pile=p_zombie_flesh, coverage=1.3, angle=0.1, edge="firm"})
work(m_zombie_flung_arm, {hand="body", pile=p_zombie_coat, coverage=1.2, angle=-0.7, edge="firm"})

-- Legs & Tattered Trousers
m_zombie_legs = poly({
  {675, 520}, {760, 520}, {790, 610}, {805, 715}, {765, 715}, {745, 615},
  {715, 615}, {705, 715}, {665, 715}, {675, 600}
}, true)
work(m_zombie_legs, {hand="body", pile=p_zombie_pants, coverage=1.2, angle=1.3, edge="firm"})

-- 4. BLAST EXPANSION & GROUND GLOW
-- Ground reflection under blast
m_ground_blast = poly({
  {410, 460}, {540, 445}, {680, 460}, {710, 540}, {580, 580}, {430, 540}
}, true) - m_cowboy_legs - m_zombie_legs
work(m_ground_blast, {hand="broad", pile=p_ground_glow, coverage=0.9, angle=0.0, edge="soft"})

-- Outer blast plume
m_blast_plume = poly({
  {475, 395}, {515, 345}, {585, 340}, {650, 385}, {650, 425}, {575, 455}, {505, 435}
}, true) - m_revolver
work(m_blast_plume, {hand="body", pile=p_blast_outer, coverage=1.1, angle=0.1, edge="soft"})

-- Intense radiant blast core
m_blast_center = poly({
  {480, 395}, {510, 365}, {555, 375}, {585, 395}, {550, 420}, {505, 415}
}, true) - m_revolver
work(m_blast_center, {hand="body", pile=p_blast_radiant, coverage=1.3, angle=0.0, edge="soft"})

print("Cowboy, zombie, and blast core blocked in.")

--@ chunk 5
print("Drying states at 10:07:")
print("Sky (200, 200): " .. drying(200, 200))
print("Ground (500, 600): " .. drying(500, 600))
print("Cowboy coat (250, 450): " .. drying(250, 450))
print("Blast center (530, 400): " .. drying(530, 400))
print("Zombie chest (700, 420): " .. drying(700, 420))

--@ chunk 6
-- Campaign 3: Modeling Figures, Rim Lighting, Gunsmoke & Blast Flare

-- 1. Palette additions
p_smoke = pile{{"lead white", 4.0}, {"raw umber", 2.0}, {"cobalt blue", 1.5}, {"Mars orange", 1.0}, turps=0.4}
p_blast_rim = pile{{"lead white", 3.2}, {"cadmium yellow", 4.0}, {"deep cadmium", 2.0}}
p_blast_core_hot = pile{{"lead white", 5.0}, {"cadmium yellow", 3.0}, {"deep cadmium", 1.0}}
p_cool_rim = pile{{"lead white", 3.5}, {"cobalt blue", 2.0}, {"ultramarine blue", 1.0}}
p_duster_shadow = pile{{"bone black", 6.0}, {"raw umber", 3.0}, {"burnt sienna", 1.0}}
p_duster_warm_half = pile{{"raw umber", 3.5}, {"burnt sienna", 2.5}, {"yellow ochre", 2.0}, {"Mars orange", 1.0}}
p_gore_dark = pile{{"bone black", 4.0}, {"burnt sienna", 3.0}, {"cadmium red", 2.0}}
p_bone_highlight = pile{{"lead white", 3.5}, {"yellow ochre", 2.0}, {"green earth", 0.8}, {"cadmium yellow", 1.5}}

-- 2. COWBOY MODELING
-- Deep shadow folds in duster coat and trousers
b_detail = brush("filbert", 5)
b_detail:load(p_duster_shadow, 0.8)
b_detail:gesture({{240, 360, 0.7}, {230, 420, 0.8}, {225, 480, 0.6}}) -- spine fold
b_detail:gesture({{260, 430, 0.6}, {245, 480, 0.8}, {235, 520, 0.5}}) -- waist fold
b_detail:gesture({{220, 530, 0.7}, {170, 620, 0.8}, {135, 670, 0.6}}) -- billowing tail fold
b_detail:gesture({{305, 540, 0.6}, {310, 610, 0.8}, {320, 680, 0.5}}) -- leg fold

-- Warm halftones on duster facing the blast
m_duster_warm = poly({
  {270, 365}, {295, 410}, {280, 460}, {260, 440}
}, true) + poly({
  {345, 390}, {435, 395}, {435, 412}, {350, 412}
}, true)
work(m_duster_warm, {hand="body", pile=p_duster_warm_half, coverage=1.1, angle=0.4, edge="soft"})

-- Sharp blast rim lights on cowboy (right-facing edges)
b_rim = brush{kind="round", width=3, point=1}
b_rim:load(p_blast_rim, 0.9)
-- Hat brim edge catching blast
b_rim:gesture({{230, 308, 0.4}, {295, 306, 0.9}, {350, 325, 0.7}})
-- Forehead/brow & nose under hat brim
b_rim:gesture({{265, 325, 0.8}, {270, 335, 0.9}, {273, 345, 0.5}})
-- Bandana fold
b_rim:gesture({{270, 350, 0.6}, {278, 358, 0.8}, {270, 368, 0.4}})
-- Outstretched arm top edge
b_rim:gesture({{290, 376, 0.6}, {350, 381, 0.8}, {415, 384, 0.9}, {440, 386, 0.95}})
-- Revolver highlights (cylinder, top strap, barrel)
b_rim:gesture({{440, 386, 0.9}, {485, 386, 1.0}}) -- top rib of barrel
b_rim:gesture({{445, 395, 0.8}, {465, 395, 0.85}}) -- cylinder glint
-- Front knee and shin catching blast
b_rim:gesture({{295, 595, 0.7}, {315, 640, 0.8}, {330, 685, 0.6}})

-- Cool moonlight rim on cowboy's back and rear hat
b_cool = brush{kind="round", width=3, point=1}
b_cool:load(p_cool_rim, 0.8)
b_cool:gesture({{185, 325, 0.6}, {225, 308, 0.7}}) -- rear hat brim
b_cool:gesture({{245, 266, 0.5}, {236, 285, 0.7}, {236, 310, 0.5}}) -- rear crown
b_cool:gesture({{238, 355, 0.6}, {220, 420, 0.7}, {212, 490, 0.8}, {198, 550, 0.6}}) -- back silhouette
b_cool:gesture({{190, 550, 0.6}, {135, 625, 0.7}, {115, 680, 0.5}}) -- billowing coat tail rim

-- 3. ZOMBIE MODELING & BLAST GORE
-- Deep shadows inside skull & maw
b_maw = brush("filbert", 4)
b_maw:load(p_duster_shadow, 0.9)
b_maw:gesture({{745, 332, 0.9}, {768, 342, 0.9}, {775, 332, 0.7}}) -- deep mouth cavity
b_maw:gesture({{745, 298, 0.8}, {752, 304, 0.7}}) -- left eye socket
b_maw:gesture({{768, 300, 0.8}, {775, 305, 0.7}}) -- right eye socket

-- Blast light striking zombie skull, teeth & facial bones
b_bone = brush{kind="round", width=3.5, point=1}
b_bone:load(p_bone_highlight, 0.9)
-- Brow ridge & temple
b_bone:gesture({{738, 315, 0.7}, {748, 290, 0.9}, {762, 280, 0.6}})
-- Cheekbone & jawbone edge
b_bone:gesture({{740, 325, 0.9}, {755, 326, 0.9}, {772, 330, 0.7}})
-- Rotted upper teeth rimmed in blast light
b_bone:gesture({{748, 330, 0.8}, {765, 334, 0.9}})
-- Lower jaw teeth & chin
b_bone:gesture({{752, 345, 0.8}, {768, 350, 0.8}, {775, 342, 0.6}})

-- Blasted chest cavity: torn flesh, exposed ribs, gore
b_gore = brush("filbert", 6)
b_gore:load(p_gore_dark, 0.9)
b_gore:gesture({{670, 410, 0.8}, {710, 425, 0.9}, {730, 450, 0.7}})
-- Exposed fractured rib bones catching firelight
b_bone:gesture({{680, 420, 0.85}, {700, 422, 0.8}})
b_bone:gesture({{685, 435, 0.85}, {710, 438, 0.8}})
b_bone:gesture({{690, 450, 0.8}, {715, 452, 0.75}})

-- Reaching claw arm lit by blast
b_bone:gesture({{680, 386, 0.7}, {635, 410, 0.85}, {585, 420, 0.95}}) -- forearm & wrist
-- Bony rotting claw fingers
b_bone:gesture({{585, 420, 0.8}, {570, 416, 0.9}}) -- finger 1
b_bone:gesture({{585, 423, 0.8}, {568, 425, 0.9}}) -- finger 2
b_bone:gesture({{585, 426, 0.8}, {572, 434, 0.85}}) -- finger 3

-- Flung-back left arm catching raking blast
b_rim:gesture({{770, 376, 0.7}, {820, 342, 0.85}, {875, 310, 0.9}})

-- Ragged coat shreds and pant highlights on zombie
b_rim:gesture({{670, 520, 0.6}, {680, 580, 0.8}, {675, 640, 0.7}}) -- forward leg crease
b_rim:gesture({{745, 525, 0.5}, {760, 585, 0.7}, {775, 640, 0.6}}) -- back leg highlight

-- 4. GUNSMOKE PLUMES & BILLOWS
m_smoke_plumes = poly({
  {485, 370}, {530, 310}, {620, 280}, {710, 300}, {720, 350},
  {660, 350}, {590, 330}, {520, 350}
}, true) + poly({
  {520, 430}, {580, 460}, {650, 480}, {720, 470}, {700, 510},
  {610, 520}, {530, 470}
}, true)
work(m_smoke_plumes, {hand="glaze", pile=p_smoke, coverage=0.85, angle=0.25, edge="soft"})

-- 5. INCANDESCENT BLAST CORE (HIGH IMPASTO ACCENT)
b_blast = brush{kind="round", width=6, point=1, lay=6}
b_blast:load(p_blast_core_hot, 1.0)
-- Point-blank detonation flash from the muzzle!
b_blast:gesture({{480, 395, 0.5}, {495, 395, 1.0}, {535, 395, 1.0}, {565, 395, 0.7}})
-- Expanding diamond rays of the blast
b_blast:gesture({{500, 395, 1.0}, {525, 370, 0.8}, {545, 355, 0.5}})
b_blast:gesture({{500, 395, 1.0}, {530, 420, 0.8}, {550, 435, 0.5}})

-- 6. BURNING SPATTERS & SPARKS FLYING
-- Sparks spraying forward into zombie's chest and past him
b_sparks = brush("round", 3)
b_sparks:load(p_blast_core_hot, 0.9)
b_sparks:spatter{at={510, 395}, toward={180, -20}, spread=0.5, force=0.8}
b_sparks:spatter{at={530, 395}, toward={220, 30}, spread=0.6, force=0.85}

-- Blackened gore & cloth debris spraying behind zombie
b_debris = brush("round", 3)
b_debris:load(p_gore_dark, 0.85)
b_debris:spatter{at={720, 420}, toward={160, -10}, spread=0.4, force=0.75}
b_debris:spatter{at={730, 440}, toward={140, 40}, spread=0.5, force=0.7}

print("Campaign 3 completed: modeling, rims, smoke, core blast, and spatter.")

--@ chunk 7
-- Campaign 4: Ground Shadows, Desert Texture, Distant Moonlit Mesa, and Figure Refinements

-- 1. Palette additions
p_cast_shadow = pile{{"bone black", 6.0}, {"raw umber", 4.0}, {"burnt sienna", 1.0}}
p_pebble_light = pile{{"lead white", 2.5}, {"yellow ochre", 3.0}, {"Mars orange", 2.0}, {"cadmium yellow", 1.5}}
p_brass = pile{{"yellow ochre", 4.0}, {"cadmium yellow", 3.0}, {"lead white", 1.5}}
p_eye_glint = pile{{"lead white", 5.0}, {"cobalt blue", 1.0}}
p_smoke_thin = pile{{"lead white", 3.5}, {"raw umber", 1.5}, {"ultramarine blue", 1.5}, turps=0.55}

-- 2. CAST SHADOWS (Radiating away from the blast)
-- Cowboy cast shadow to the left
m_shadow_cowboy = poly({
  {180, 710}, {100, 725}, {130, 745}, {230, 735}, {310, 720}, {225, 715}
}, true)
work(m_shadow_cowboy, {hand="body", pile=p_cast_shadow, coverage=1.2, angle=-0.2, edge="soft"})

-- Zombie cast shadow to the right
m_shadow_zombie = poly({
  {665, 715}, {750, 730}, {860, 740}, {900, 725}, {810, 705}, {705, 715}
}, true)
work(m_shadow_zombie, {hand="body", pile=p_cast_shadow, coverage=1.2, angle=0.2, edge="soft"})

-- 3. FOREGROUND DESERT PEBBLES & RAKE LIGHT
-- Small desert rocks in the illuminated ground zone
b_rock = brush("filbert", 3.5)
-- Rock 1 (near cowboy's front boot)
b_rock:load(p_cast_shadow, 0.8)
b_rock:touch(380, 705, {drag={8, 4}, pressure=0.7})
b_rock:reload(p_pebble_light, 0.8)
b_rock:touch(376, 703, {drag={4, -2}, pressure=0.8})

-- Rock 2 (mid-ground between figures)
b_rock:reload(p_cast_shadow, 0.8)
b_rock:touch(520, 680, {drag={12, 5}, pressure=0.8})
b_rock:reload(p_pebble_light, 0.8)
b_rock:touch(515, 677, {drag={6, -3}, pressure=0.9})

-- Rock 3 (closer to foreground center)
b_rock:reload(p_cast_shadow, 0.8)
b_rock:touch(460, 725, {drag={15, 6}, pressure=0.8})
b_rock:reload(p_pebble_light, 0.8)
b_rock:touch(453, 722, {drag={8, -4}, pressure=0.9})

-- Rock 4 & 5 (near zombie's front foot)
b_rock:reload(p_cast_shadow, 0.8)
b_rock:touch(630, 705, {drag={10, 4}, pressure=0.7})
b_rock:reload(p_pebble_light, 0.8)
b_rock:touch(625, 703, {drag={5, -2}, pressure=0.85})

b_rock:reload(p_cast_shadow, 0.8)
b_rock:touch(590, 730, {drag={14, 5}, pressure=0.8})
b_rock:reload(p_pebble_light, 0.8)
b_rock:touch(583, 727, {drag={7, -3}, pressure=0.9})

-- Scattered gravel specks catching light
b_gravel = brush{kind="round", width=2, point=1}
b_gravel:load(p_pebble_light, 0.9)
b_gravel:touch(410, 660, {pressure=0.6})
b_gravel:touch(435, 690, {pressure=0.7})
b_gravel:touch(485, 650, {pressure=0.8})
b_gravel:touch(545, 660, {pressure=0.7})
b_gravel:touch(570, 695, {pressure=0.8})
b_gravel:touch(615, 675, {pressure=0.7})

-- Desert scrub / sagebrush at bottom right catching rim light
m_scrub = poly({{880, 720}, {910, 650}, {950, 640}, {980, 670}, {990, 725}}, true)
work(m_scrub, {hand="hatch", pile=p_cast_shadow, coverage=1.1, angle=1.2, edge="loose"})
b_gravel:load(p_blast_rim, 0.7)
b_gravel:gesture({{910, 660, 0.6}, {925, 650, 0.8}, {940, 655, 0.5}})

-- 4. DISTANT MESA MOONLIT RIM
b_mesa = brush{kind="round", width=2.5, point=1}
b_mesa:load(p_cool_rim, 0.75)
b_mesa:gesture({{0, 360, 0.4}, {60, 335, 0.7}, {120, 320, 0.8}, {170, 322, 0.6}, {220, 330, 0.7}})

-- 5. COWBOY ACCENTS & REFINEMENTS
-- Eye glint in deep hat shadow
b_fine = brush{kind="round", width=1.5, point=1}
b_fine:load(p_eye_glint, 0.9)
b_fine:touch(265, 323, {pressure=0.7}) -- eye catchlight reflecting muzzle flash/moon

-- Cartridge belt / brass shells at waist
b_fine:reload(p_brass, 0.9)
b_fine:touch(250, 508, {pressure=0.7, drag={2, 4}})
b_fine:touch(256, 510, {pressure=0.7, drag={2, 4}})
b_fine:touch(262, 512, {pressure=0.7, drag={2, 4}})
b_fine:touch(268, 513, {pressure=0.7, drag={2, 4}})

-- Boot spur glint on front boot heel
b_fine:reload(p_eye_glint, 0.9)
b_fine:touch(342, 706, {pressure=0.8})

-- 6. ZOMBIE RAGGED EDGES & HAIR STRANDS
-- Matted hair catching flash
b_fine:reload(p_blast_rim, 0.85)
b_fine:gesture({{755, 260, 0.5}, {775, 235, 0.8}, {790, 240, 0.4}})
b_fine:gesture({{785, 255, 0.6}, {815, 245, 0.8}, {835, 260, 0.5}})
-- Shredded coat fringe on reaching arm
b_fine:gesture({{635, 425, 0.6}, {630, 442, 0.8}, {625, 455, 0.4}})
b_fine:gesture({{650, 422, 0.6}, {648, 438, 0.7}, {645, 448, 0.3}})
-- Dark clotted gore dripping down ribs
b_fine:reload(p_gore_dark, 0.9)
b_fine:gesture({{690, 455, 0.8}, {692, 480, 0.9}, {690, 505, 0.6}})
b_fine:gesture({{710, 452, 0.7}, {714, 475, 0.8}, {712, 495, 0.5}})

-- 7. DELICATE GUNSMOKE CIRCLING UPWARD
b_smoke = brush("filbert", 12)
b_smoke:load(p_smoke_thin, 0.6)
b_smoke:gesture({{450, 380, 0.4}, {410, 350, 0.5}, {360, 310, 0.6}, {300, 260, 0.4}, {250, 220, 0.2}})

print("Campaign 4 completed: ground shadows, desert texture, mesa rim, figure refinements.")

--@ chunk 8
-- Signature in lower left corner
b_sig = brush{kind="round", width=1.2, point=1}
p_sig = pile{{"raw umber", 4.0}, {"burnt sienna", 2.0}, {"yellow ochre", 1.5}, turps=0.4}
b_sig:load(p_sig, 0.7)

-- Delicate signature mark
b_sig:gesture({{45, 726, 0.6}, {55, 724, 0.7}, {52, 732, 0.6}, {62, 725, 0.7}, {70, 725, 0.5}})

print("Signature added.")

--@ chunk 9
print(wait(0))
