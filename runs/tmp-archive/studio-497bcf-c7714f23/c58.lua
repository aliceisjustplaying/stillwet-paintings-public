skyH = pile{{"lead white", 10}, {"yellow ochre", 0.42}, {"chrome yellow", 0.1}, {"vermilion", 0.05}, {"pale smalt", 0.12}, medium=0.08}
-- sky gaps: a deep notch between crown A and B, a smaller one between B and C, ragged edge bites
local gaps = poly({{86,376},{92,386},{95,398},{93,410},{97,420},{90,428},{84,418},{80,404},{78,390}}, true)
           + poly({{150,398},{155,408},{152,418},{147,425},{143,414},{142,404}}, true)
           + ellipse(30,398,6,4) + ellipse(20,414,4,4) + ellipse(142,378,5,6) + ellipse(160,404,4,5) + ellipse(62,386,5,3)
           + ellipse(100,372,4,5) + ellipse(186,428,4,4)
gaps = gaps:roughen(2, 6, 71) * above({{0,440},{1000,440}})
work(gaps, {hand="detail", pile=skyH, angle=0.3, coverage=2.5, length={3,8}, fill=true, clip=true, edge="firm"})
-- small sky holes inside the crowns, irregular
local holes = poly({{40,418},{45,414},{48,419},{44,423}}) + poly({{118,398},{123,395},{125,401},{120,404}}) + poly({{64,440},{69,437},{72,442},{66,444}})
work(holes:roughen(0.8, 3, 72), {hand="detail", pile=skyH, coverage=2.5, length={2,5}, fill=true, clip=true, edge="firm"})
print(wait(0))
