-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"raw umber", 3}, {"red earth", 2}, {"lead white", 2}}, texture=0.35, um=90}, {apply="knife", pile={{"raw umber", 2.5}, {"yellow ochre", 2}, {"lead white", 3}, {"bone black", 0.5}}, texture=0.2, um=70}}, linen={16, 14}, seed=1881, size=900}

--@ chunk 2
sky_deep = pile{{"Prussian blue", 3}, {"raw umber", 2}, {"bone black", 1.5}, turps=0.5, name="sky_deep"}
sky_moon = pile{{"cobalt blue", 2}, {"raw umber", 1.5}, {"lead white", 2.5}, {"yellow ochre", 0.5}, turps=0.4, name="sky_moon"}
ground_shadow = pile{{"raw umber", 3}, {"bone black", 1.5}, {"Prussian blue", 0.8}, {"yellow ochre", 1}, turps=0.5, name="ground_shadow"}
ground_spill = pile{{"yellow ochre", 3}, {"Mars orange", 1.5}, {"red earth", 1}, {"lead white", 1.5}, turps=0.4, name="ground_spill"}
blast_outer = pile{{"Mars orange", 2.5}, {"vermilion", 2}, {"cadmium yellow", 2}, {"lead white", 0.5}, turps=0.35, name="blast_outer"}
blast_core = pile{{"lead white", 4}, {"pale cadmium", 2}, {"cadmium yellow", 0.5}, blot=0.2, name="blast_core"}
zombie_shadow = pile{{"green earth", 3}, {"raw umber", 2}, {"viridian", 1}, {"bone black", 0.8}, turps=0.45, name="zombie_shadow"}
zombie_lit = pile{{"lead white", 2.5}, {"yellow ochre", 1.5}, {"green earth", 2}, {"raw umber", 0.5}, name="zombie_lit"}

-- Lay swatches on scratch canvas in a 300x250 window (100..400, 100..350)
work(rect(110, 110, 80, 90), {hand="body", pile=sky_deep, coverage=1.3, load=0.8, clip=true})
work(rect(200, 110, 80, 90), {hand="body", pile=sky_moon, coverage=1.3, load=0.8, clip=true})
work(rect(290, 110, 80, 90), {hand="body", pile=ground_shadow, coverage=1.3, load=0.8, clip=true})
work(rect(110, 210, 80, 90), {hand="body", pile=ground_spill, coverage=1.3, load=0.8, clip=true})

-- Test blast_outer and wet-on-wet vs dry blast_core
work(rect(200, 210, 80, 90), {hand="body", pile=blast_outer, coverage=1.4, load=0.85, clip=true})
local b_imp = brush{kind="filbert", width=8, lay=6, stiffness=0.8}
b_imp:reload(blast_core, 0.9)
-- Left half of blast_outer swatch: wet-on-wet stroke
b_imp:stroke({{215, 230}, {215, 280}}, {pressure=0.7})

-- Zombie shadow + lit overlap
work(rect(290, 210, 80, 90), {hand="body", pile=zombie_shadow, coverage=1.3, load=0.8, clip=true})
work(rect(330, 225, 35, 60), {hand="body", pile=zombie_lit, coverage=1.3, load=0.8, clip=true})

print("drying at sky_deep:", drying(150, 150))
print("drying at blast_outer:", drying(240, 250))

--@ chunk 3
wait(36 * 60)
print("drying at blast_outer after 36h:", drying(255, 250))
wait(36 * 60)
print("drying at blast_outer after 72h:", drying(255, 250))
local b_imp = brush{kind="filbert", width=8, lay=6, stiffness=0.8}
b_imp:reload(blast_core, 0.9)
b_imp:stroke({{255, 230}, {255, 280}}, {pressure=0.7})

--@ chunk 4
wait(48 * 60)
print("drying at blast_outer after 120h (5 days):", drying(270, 250))
local b_imp = brush{kind="filbert", width=8, lay=6, stiffness=0.8}
b_imp:reload(blast_core, 0.9)
b_imp:stroke({{270, 230}, {270, 280}}, {pressure=0.7})

--@ chunk 5
wait(48 * 60)
print("drying at blast_outer after 168h (7 days):", drying(240, 250))

blast_outer_fast = pile{{"orange chrome", 2.5}, {"red lead", 1.5}, {"Mars red", 1}, {"lead-tin yellow", 1}, turps=0.5, name="blast_outer_fast"}
work(rect(110, 310, 80, 70), {hand="body", pile=blast_outer_fast, coverage=1.4, load=0.85, clip=true})
wait(36 * 60)
print("drying at blast_outer_fast after 36h:", drying(150, 345))
wait(12 * 60)
print("drying at blast_outer_fast after 48h:", drying(150, 345))
local b_imp = brush{kind="filbert", width=8, lay=6, stiffness=0.8}
b_imp:reload(blast_core, 0.9)
b_imp:stroke({{150, 320}, {150, 370}}, {pressure=0.7})

--@ chunk 6
-- Prepare a dark sky + orange blast test patch on scratch canvas (x=420..680, y=110..320)
work(rect(420, 110, 260, 210), {hand="body", pile=sky_deep, coverage=1.4, load=0.85, clip=true})
work(ellipse(550, 250, 75, 45), {hand="body", pile=blast_outer_fast, coverage=1.4, load=0.85, clip=true})
wait(72 * 60)
print("Scratch patch drying — sky:", drying(480, 160), "blast:", drying(550, 250))

-- Test S1 (left side x=440..535): high lead white + hand="scumble"
smoke_s1 = pile{{"lead white", 3}, {"cobalt blue", 1}, {"raw umber", 0.5}, thinner=0.65, name="smoke_s1"}
work(ellipse(485, 195, 42, 55), {hand="scumble", pile=smoke_s1, coverage=1.0, load=0.55})

-- Test S2 (right side x=555..660): ultramarine ash / raw umber / ochre / modest white + thinner=0.68 with soft filbert (hand="glaze")
smoke_warm = pile{{"yellow ochre", 2}, {"Mars orange", 1}, {"raw umber", 1.5}, {"lead white", 1.2}, thinner=0.68, name="smoke_warm"}
smoke_cool = pile{{"ultramarine ash", 2.5}, {"raw umber", 1.5}, {"yellow ochre", 0.8}, {"lead white", 1.2}, thinner=0.70, name="smoke_cool"}
work(ellipse(605, 220, 42, 38), {hand="glaze", tool="filbert 16", pile=smoke_warm, coverage=0.9, load=0.55, pressure={0.2, 0.35}})
work(ellipse(610, 170, 45, 45), {hand="glaze", tool="filbert 18", pile=smoke_cool, coverage=0.9, load=0.5, pressure={0.18, 0.32}})

-- Test Spatter on a second patch (x=420..680, y=340..490)
work(rect(420, 340, 260, 150), {hand="body", pile=sky_deep, coverage=1.4, load=0.85, clip=true})
wait(48 * 60)
p_ember_spatter = pile{{"lead-tin yellow", 2.5}, {"orange chrome", 2}, {"lead white", 1.5}, turps=0.55, name="ember_spatter"}
p_ichor_spatter = pile{{"Mars red", 2.5}, {"carmine lake", 2}, {"raw umber", 1.2}, medium=0.55, name="ichor_spatter"}

local b_sp = brush{kind="round", width=4, stiffness=0.7}
b_sp:reload(p_ember_spatter, 0.9)
local n_embers = b_sp:spatter{at={450, 415}, toward={95, -15}, spread=0.38, force=0.65, clip=rect(420, 340, 260, 150)}
b_sp:reload(p_ichor_spatter, 0.9)
local n_ichor = b_sp:spatter{at={560, 415}, toward={95, 10}, spread=0.42, force=0.55, clip=rect(420, 340, 260, 150)}
print("Spatter counts — embers:", n_embers, "ichor:", n_ichor)
wait(15) -- let thinner evaporate from smoke veils

--@ chunk 7
p_ichor_lit_spatter = pile{{"cadmium red", 2.5}, {"Mars red", 2}, {"orange chrome", 1}, {"lead white", 0.4}, turps=0.5, name="ichor_lit_spatter"}
local b_sp = brush{kind="round", width=4, stiffness=0.7}
b_sp:reload(p_ichor_lit_spatter, 0.9)
local n_ichor2 = b_sp:spatter{at={560, 450}, toward={95, -5}, spread=0.4, force=0.55, clip=rect(420, 340, 260, 150)}
print("Lit ichor spatter count:", n_ichor2)

--@ chunk 8
-- Trial 3 on scratch canvas: test whether hand="scumble" with thinner=0.80 and ultra-low pressure={0.08, 0.15}
-- avoids the opaque scrub marks seen in Trial 2A's smoke_s1
work(rect(110, 410, 220, 130), {hand="body", pile=sky_deep, coverage=1.4, load=0.85, clip=true})
work(ellipse(220, 490, 60, 35), {hand="body", pile=blast_outer_fast, coverage=1.4, load=0.85, clip=true})
wait(48 * 60)
print("Trial 3 substrate drying — sky:", drying(160, 440), "blast:", drying(220, 490))

smoke_s3_thin = pile{{"ultramarine ash", 2.5}, {"raw umber", 1.5}, {"yellow ochre", 0.8}, {"lead white", 1.2}, thinner=0.80, name="smoke_s3_thin"}
-- Left patch (x=135..205): hand="scumble" with thinner=0.80, pressure={0.08, 0.15}, load=0.35, 2 light passes
work(ellipse(175, 465, 38, 42), {hand="scumble", pile=smoke_s3_thin, coverage=0.7, load=0.35, pressure={0.08, 0.15}})
work(ellipse(175, 465, 38, 42), {hand="scumble", pile=smoke_s3_thin, coverage=0.7, load=0.35, pressure={0.08, 0.15}})

-- Right patch (x=225..295): hand="glaze" with tool="filbert 18", pressure={0.18, 0.30}, load=0.45
work(ellipse(260, 465, 38, 42), {hand="glaze", tool="filbert 18", pile=smoke_s3_thin, coverage=0.9, load=0.45, pressure={0.18, 0.30}})
wait(15)
