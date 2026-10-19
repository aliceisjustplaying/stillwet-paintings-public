-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box tonn

--@ chunk 1
canvas{size=300, aspect=1.25, linen=15, ground={{pile={{"lead white", 5}, {"lead-tin yellow", 1}}, um=80, apply="knife"}}}

--@ chunk 2
b = brush("filbert", 6); b:load(pile{{"burnt sienna", 2}, {"cerulean blue", 1}, {"lead white", 3}}, 0.9); for i = 1, 12 do b:stroke({{100 + i * 60, 700}, {140 + i * 60, 300}}) end; wait(90)

--@ chunk 3
work(rect(100, 100, 800, 150), {hand="glaze", pile=pile{{"permanent alizarin", 1}, {"transparent oxide yellow", 1}, medium=0.7}})
