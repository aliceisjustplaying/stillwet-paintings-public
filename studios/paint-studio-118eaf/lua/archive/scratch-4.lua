-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"lead white", 10}, {"bone black", 0.2}}, texture=0.3, um=120}, {apply="brush", pile={{"lead white", 6}, {"red earth", 1.2}, {"raw umber", 1}, {"yellow ochre", 0.6}}, texture=0.5, um=40}}, linen={16, 14}, seed=4471, size=900}

--@ chunk 2
function zombie_v5()
  local head = poly({{812,336},{817,320},{812,305},{802,298},{790,298},{782,302},{781,307},{773,307},{778,313},{776,317},{786,321},{774,330},{776,337},{788,339},{792,350},{806,348}}, true)
  local torso = poly({{788,348},{772,362},{765,382},{772,412},{781,446},{788,478},{794,494},{800,486},{806,498},{812,484},{818,494},{825,478},{823,450},{831,420},{835,385},{827,360},{808,343}}, true)
  local sleeveF = poly({{786,358},{770,366},{758,374},{750,386},{756,384},{760,392},{766,384},{772,386},{790,376}}, true)
  local armF = ribbon({{768,372},{752,380},{736,374},{722,368},{710,364}}, {14,11,9,8,7}) + ellipse(752,379,6,6)
  local armB = ribbon({{804,362},{786,356},{770,352},{752,344},{734,336},{720,330}}, {15,13,11,9,8,7}) + ellipse(770,352,6,6)
  local handF = poly({{714,358},{702,357},{690,352},{696,360},{684,364},{696,367},{690,375},{704,371},{714,370}}, false)
  local handB = poly({{724,323},{712,320},{700,313},{705,323},{693,327},{706,331},{700,339},{714,336},{724,336}}, false)
  local legF = ribbon({{796,478},{786,505},{776,532},{773,572},{770,612}}, {24,19,15,12,11}) + ellipse(777,532,9,8)
  local legB = ribbon({{816,478},{824,505},{832,530},{841,566},{850,600}}, {24,19,15,12,11}) + ellipse(832,531,9,8)
  local cuffs = poly({{762,570},{784,566},{786,584},{780,578},{776,588},{770,580},{764,590},{760,580}}, true) + poly({{832,562},{852,558},{856,576},{850,570},{846,582},{840,572},{834,580}}, true)
  local feet = poly({{764,606},{778,606},{780,624},{748,628},{750,618}}, true) + poly({{844,594},{858,594},{870,610},{866,620},{844,618}}, true)
  return head + torso + sleeveF + armF + armB + handF + handB + legF + legB + cuffs + feet
end
local lt = pile{{"lead white", 3}, {"raw umber", 0.3}}
local dk = pile{{"bone black", 1}, {"raw umber", 1}, turps=0.3}
work(rect(660,270,240,380), {hand="broad", pile=lt, coverage=1.5, clip=true})
work(zombie_v5(), {hand="body", pile=dk, coverage=2.5, clip=true})
