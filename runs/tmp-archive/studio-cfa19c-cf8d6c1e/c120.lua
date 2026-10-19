wait(60*24*3)
local base = 441
local P = {}
-- great church: west tower, octagon, needle spire
P[#P+1] = poly({{599.3,base},{599.3,362},{610.2,362},{610.2,base}}, true)
P[#P+1] = poly({{600.8,362.5},{601.2,353},{608.4,353},{608.8,362.5}}, true)
P[#P+1] = poly({{601.0,353.5},{604.6,322},{605.0,322},{608.6,353.5}}, true)
P[#P+1] = ellipse(604.8, 321.2, 0.6, 1.0)
-- nave with steep roof and lower chancel
P[#P+1] = poly({{610,base},{610,417},{614,403.5},{688,403.5},{693,417},{693,base}}, true)
P[#P+1] = poly({{692,base},{692,421},{695,412},{708,412},{712,421},{712,base}}, true)
P[#P+1] = poly({{645,404},{646,398},{647,404}}, true)  -- ridge turret
-- left church: slim tower with spire
P[#P+1] = poly({{540.2,base},{540.2,406},{551,406},{551,base}}, true)
P[#P+1] = poly({{540,406.5},{545.5,370},{546,370},{551.3,406.5}}, true)
P[#P+1] = poly({{551,base},{551,420},{555,410},{580,410},{584,420},{584,base}}, true)
-- right tower with pyramid cap and little lantern
P[#P+1] = poly({{722,base},{722,386},{735,386},{735,base}}, true)
P[#P+1] = poly({{721.5,386.5},{728.5,374},{735.5,386.5}}, true)
P[#P+1] = poly({{727.6,375},{727.8,367},{729.2,367},{729.4,375}}, true)
-- houses: gables and roofs
local houses = {{520,528,424},{528,536,428},{584,592,426},{592,599,422},{712,719,425},{735,746,418},{746,753,423},{753,765,414},{765,772,424},{772,784,419},{784,791,426},{791,800,429},{800,808,432}}
for _,hs in ipairs(houses) do
  local x0,x1,t = hs[1],hs[2],hs[3]
  local mx = (x0+x1)/2
  P[#P+1] = poly({{x0,base},{x0,t+ (x1-x0)*0.45},{mx,t},{x1,t+(x1-x0)*0.45},{x1,base}}, true)
end
local T = P[1]
for i=2,#P do T = T + P[i] end
townM3 = T
local tw3 = pile{{"lead white",2.5},{"smalt",2},{"raw umber",0.5},{"red earth",0.35},{"Prussian blue",0.04}, medium=0.08}
work(townM3, {hand="detail", pile=tw3, tool={kind="round", width=1.6, point=0.3}, angle=math.pi/2, coverage=3, fill=true, clip=true, pressure={0.5,0.8}, seed=1201})
