local R = rect(20,640,110,76) + rect(880,660,110,56)
blades(R, 120, gmd, {y0=650, y1=716, L0=10, L1=22, W0=0.8, W1=1.5, lean=0.1, spread=0.3})
blades(R, 50, glt, {y0=650, y1=716, L0=10, L1=22, W0=0.5, W1=1.1, lean=0.15, spread=0.25, load=0.35})
local st = brush{kind="round", width=0.8, point=1}
st:load(leaflt, 0.35)
for _,e in ipairs({{{930,716},{918,690},{913,675}}, {{934,716},{944,690},{948,680}}, {{73,700},{60,695},{42,688}}, {{73,700},{90,691},{104,686}}, {{926,716},{910,700},{902,694}}}) do
  st:stroke(e, {pressure={st:pressure_for(0.8), st:pressure_for(0.2)}})
end
