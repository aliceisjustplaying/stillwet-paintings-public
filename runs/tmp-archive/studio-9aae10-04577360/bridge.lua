local c = {{372,566},{390,555},{408,545},{426,536}}
local w = {8,7.5,7,6.5}
work(ribbon(c, w):roughen(0.8, 6, 41), {hand="detail", pile=trailP, coverage=3, fill=true, angle=-0.5, load=1, pressure={0.5,0.8}, tool={kind="filbert", width=2.5}})
local e = {{371,563},{389,552},{407,542},{425,533}}
work(ribbon(e, {2.4,2.2,2,1.9}):roughen(0.5, 5, 43), {hand="detail", pile=trailK, coverage=3, fill=true, angle=-0.5, load=1, pressure={0.5,0.8}, tool={kind="round", width=1.5}})
