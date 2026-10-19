-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"lead white", 10}, {"bone black", 0.2}}, texture=0.3, um=120}, {apply="brush", pile={{"lead white", 6}, {"red earth", 1.2}, {"raw umber", 1}, {"yellow ochre", 0.6}}, texture=0.5, um=40}}, linen={16, 14}, seed=4471, size=900}

--@ chunk 2
-- setting: glow sky, zombie silhouette dark, dry; then trial shirt darkening, rim light, flash light
sk_glow = pile{{"lead white", 6}, {"Naples yellow", 2}, {"cadmium yellow", 0.35}}
sk_gold = pile{{"lead white", 3}, {"Naples yellow", 1.5}, {"orange chrome", 0.5}, {"yellow ochre", 0.3}}
work(rect(650,250,250,250), {hand="broad", piles={{sk_glow, function(x,y) return 1 end},{sk_gold, function(x,y) return 0.6 end}}, coverage=2, fill=true, clip=true})
zb_head2 = poly({{800,294},{810,298},{816,308},{816,322},{810,336},{802,346},{792,345},{783,343},{780,336},{780,327},{779,321},{781,318},{776,314},{780,309},{782,304},{787,298}}, true)
zb_torso = poly({{788,348},{772,362},{765,382},{772,412},{781,446},{788,478},{794,494},{800,486},{806,498},{812,484},{818,494},{825,478},{823,450},{831,420},{835,385},{827,360},{808,343}}, true)
zb_hump = poly({{804,344},{820,345},{832,352},{839,366},{841,384},{837,398},{826,400},{818,380},{808,360}}, true)
zb_armF = ribbon({{768,372},{752,380},{736,374},{722,368},{710,364}}, {14,11,9,8,7})
zb_armB = ribbon({{804,362},{786,356},{770,352},{752,344},{734,336},{720,330}}, {15,13,11,9,8,7})
zb_shirt_m = poly({{786,356},{796,350},{804,356},{802,390},{798,420},{794,446},{788,452},{784,430},{780,400},{782,372}}, true):roughen(2, 10, 5) * zb_torso
zb_cloth = pile{{"raw umber", 1}, {"bone black", 0.4}, {"ultramarine blue", 0.3}, {"burnt sienna", 0.2}, {"lead white", 0.08}}
zb_shirt = pile{{"raw umber", 0.6}, {"lead white", 0.5}, {"yellow ochre", 0.3}, {"ultramarine blue", 0.15}, {"bone black", 0.1}}
zb_skin_dk = pile{{"green earth", 1}, {"raw umber", 0.8}, {"bone black", 0.15}, {"lead white", 0.15}, {"rose madder", 0.08}}
local Z = zb_head2 + zb_torso + zb_hump + zb_armF + zb_armB
wait(5*24*60)
work(Z - zb_shirt_m - zb_head2, {hand="detail", pile=zb_cloth, coverage=2.5, clip=true})
work(zb_shirt_m, {hand="detail", pile=zb_shirt, coverage=2.5, clip=true})
work(zb_head2, {hand="detail", pile=zb_skin_dk, coverage=2.5, clip=true})
wait(12*24*60)
Zall = Z
print(drying(795,400))

--@ chunk 3
zb_shirt2 = pile{{"raw umber", 1}, {"yellow ochre", 0.35}, {"green earth", 0.4}, {"lead white", 0.18}, {"bone black", 0.12}, name="zb_shirt2"}
zb_rim = pile{{"Naples yellow", 1}, {"orange chrome", 0.35}, {"lead white", 0.5}, {"raw umber", 0.12}, name="zb_rim"}
zb_flash = pile{{"orange chrome", 1}, {"Naples yellow", 0.6}, {"burnt sienna", 0.3}, {"lead white", 0.2}, name="zb_flash"}
work(zb_shirt_m, {hand="detail", tool={kind="round", width=2.5}, pile=zb_shirt2, coverage=2.5, clip=zb_shirt_m, angle=1.4, seed=1})
-- rim: a thin band inside the silhouette edge
local rim = Zall:rim(2.2, 0.8) * Zall
print(rim:area(), rim:at(840, 380), rim:at(800, 400))
work(rim, {hand="detail", tool={kind="round", width=1.6}, pile=zb_rim, coverage=1.8, clip=Zall, seed=2})
